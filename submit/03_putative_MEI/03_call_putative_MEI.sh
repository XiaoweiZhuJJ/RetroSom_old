#!/bin/bash -l
# NOTE the -l flag!
#SBATCH -J RetroCall
#SBATCH -o %x.%A.output
#SBATCH -e %x.%A.output
#SBATCH --account=dflev
#SBATCH -p batch
#SBATCH --mem=20gb
#SBATCH --time=20:00:00

usage="$(basename "$0") [-h] [-o i m r s g f] -- Calling putative MEI insertions. Requires one core, and 20gb memory

where:
    -h  show this help text
    -o  output folder path
    -i  subject ID
    -m  masterpath (default ~/masterpath)
    -r  RetroSom version control (default 1)
    -s  strand (0, -strand; 1, +strand)
    -g  reference genome version (hg38, hg19 etc., default: hg38)
    -f  filter (0, no filter; 1, SEG filter; 2, SEG and size filter"

ver=1
masterpath=~/masterpath
hg=hg38
while getopts ":ho:i:m:r:s:g:i:f:" opt; do
  case $opt in
    h) echo "$usage"
       exit
       ;;
    o) outpath="$OPTARG"
       ;;
    i) sub="$OPTARG"
       ;;
    r) ver="$OPTARG"
       ;;
    m) masterpath="$OPTARG"
       ;;
    s) strand="$OPTARG"
       ;;
    g) hg="$OPTARG"
       ;;
    f) filter="$OPTARG"
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
    \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   esac
done
echo "$sub ran on $(hostname -s)"

retro=retro_v$ver\_$strand
rm -r $outpath/$sub/$retro
mkdir $outpath/$sub/$retro
mkdir $outpath/$sub/$retro/ALU
mkdir $outpath/$sub/$retro/LINE
ln -s $outpath/$sub/retro_v$ver/$sub.discover $outpath/$sub/$retro/$sub.discover
ln -s $outpath/$sub/retro_v$ver/$sub.sr.discover $outpath/$sub/$retro/$sub.sr.discover
ln -s $outpath/$sub/retro_v$ver/$sub.depth $outpath/$sub/$retro/$sub.depth
ln -s $outpath/$sub/retro_v$ver/$sub.bed $outpath/$sub/$retro/$sub.bed

module load samtools
module load bcftools
module load bedtools
module load perl-scg/5.14.4

date '+%m/%d/%y %H:%M:%S'
echo "TE calling phase ... begins"
### get the SEG scores ###
### add cigar to read names ###
awk -v str=$strand '{if (xor(str,($14>$15))) print ">"$5">"$4">"$7">"$12">"$13">"$14">"$15"\n"$16}' $outpath/$sub/$retro/$sub.sr.discover \
   > $outpath/$sub/$retro/seg.sr.fasta

$masterpath/SEG/seg $outpath/$sub/$retro/seg.sr.fasta 350 -h | \
   awk '{if (/>/) print $1"\t"$2}' | \
   sed s/complexity=// > $outpath/$sub/$retro/seg.sr.scores

date '+%m/%d/%y %H:%M:%S'
echo "Modifying SR mode calls"
### filter SR mode ###
$masterpath/utls/05_retroseq_SR_filter_srlength.pl $sub $outpath/$sub $retro $filter
$masterpath/utls/15_filter_SR_dup.pl $sub $outpath/$sub $retro

grep Alu $outpath/$sub/$retro/$sub.sr.dedup.discover | grep 'OK' | \
   awk '{print $1"\t"$2"\t"$3"\t"$5}' | sort -u | \
   sort -k1,1 -k2,3n | \
   mergeBed -d 40 -c 4 -o distinct -delim ";" \
   -i stdin | \
   awk '{split ($4, num, ";"); print $1"\t"$2"\t"$3"\tsr,"length(num)","$4}' \
   > $outpath/$sub/$retro/ALU/$sub.ALU.SR.calls

grep L1 $outpath/$sub/$retro/$sub.sr.dedup.discover | grep 'OK' | \
   awk '{print $1"\t"$2"\t"$3"\t"$5}' | sort -u | \
   sort -k1,1 -k2,3n | \
   mergeBed -d 40 -c 4 -o distinct -delim ";" \
   -i stdin | \
   awk '{split ($4, num, ";"); print $1"\t"$2"\t"$3"\tsr,"length(num)","$4}' \
   > $outpath/$sub/$retro/LINE/$sub.LINE.SR.calls

### PE calling ###
### 1. the candidate reads ###
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... filter the candidate support"
$masterpath/utls/03_filter_PE_alignment.pl $sub $outpath/$sub $retro 1 $strand

$masterpath/SEG/seg $outpath/$sub/$retro/seg.pe.fasta 350 -h | \
    awk '{if (/>/) print $1"\t"$2}' | \
    sed s/complexity=// > $outpath/$sub/$retro/seg.pe.scores

$masterpath/utls/04_filter_PE_complexity.pl $sub $outpath/$sub $retro 1

date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... getting the candidate reads"
grep Alu $outpath/$sub/$retro/$sub.filter.discover | sort -k1 -n -k2 \
    > $outpath/$sub/$retro/ALU/$sub.ALU.novel.sites

grep L1 $outpath/$sub/$retro/$sub.filter.discover | sort -k1 -n -k2 \
    > $outpath/$sub/$retro/LINE/$sub.LINE.novel.sites

### ALU PE calls ###
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... Alu calls"
$masterpath/utls/06_ana_depth.pl $sub $outpath/$sub $retro ALU
$masterpath/utls/07_filter_dup.pl $sub $retro ALU $outpath/$sub 1
$masterpath/utls/08_refine_depth.pl $sub $outpath/$sub $retro ALU

### L1 PE calls ###
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... L1 calls"
$masterpath/utls/06_ana_depth.pl $sub $outpath/$sub $retro LINE
$masterpath/utls/07_filter_dup.pl $sub $retro LINE $outpath/$sub 1
$masterpath/utls/08_refine_depth.pl $sub $outpath/$sub $retro LINE

### combine SR and PE ###
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... Combine SR and PE"
$masterpath/utls/09_merge.SR.PE.support.sh $sub $outpath/$sub $retro ALU $masterpath
$masterpath/utls/09_merge.SR.PE.support.sh $sub $outpath/$sub $retro LINE $masterpath

### filter out the ref calls and the calls near reference masks ###
### filter out the insertions that are close to segdup, gaps(including telomere) and centromeres ##
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... ref TE filter"

windowBed \
  -w 100 -v \
  -a $outpath/$sub/$retro/ALU/$sub.ALU.SR.PE.calls \
  -b $masterpath/refTE/position/$hg.fa_ALU\_$strand.bed \
  | windowBed -w 10 -v \
      -a stdin \
      -b $masterpath/refTE/position/$hg.mask.bed \
      > $outpath/$sub/$retro/ALU/$sub.ALU.noref.calls

windowBed \
  -w 100 -v \
  -a $outpath/$sub/$retro/LINE/$sub.LINE.SR.PE.calls \
  -b $masterpath/refTE/position/$hg.fa_LINE1\_$strand.bed \
  | windowBed -w 10 -v \
      -a stdin \
      -b $masterpath/refTE/position/$hg.mask.bed \
      > $outpath/$sub/$retro/LINE/$sub.LINE.noref.calls

### filter r1r2 ###
### remove redundancy, keep only one support read when  both read1 and read2 are putative supporting reads ###
### choose SR read over PE read ###
$masterpath/utls/16_prefilter_r1r2.pl $sub $outpath/$sub $retro ALU
$masterpath/utls/16_prefilter_r1r2.pl $sub $outpath/$sub $retro LINE

