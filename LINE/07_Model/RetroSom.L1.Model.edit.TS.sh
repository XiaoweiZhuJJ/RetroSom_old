#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J L1Model
#SBATCH --account=dflev
#SBATCH -p batch
#SBATCH --mem=10gb
#SBATCH --time=6:00:00

module load samtools
module load exonerate
module load bcftools
module load bedtools

Retro=$3
sub=$1\_Model
sub2=$1$7
echo $1  ### subject ID ###
echo $2  ### path ###
echo $Retro ### output folder ###
echo $4  ### reference genome hg19 G37 hg38... ###
echo $5  ### filter level:0=no filter, 1=prefilter, 2=allfilters ### 
TE=LINE

masterpath=/home/xwzhu/levinson/RetroSom
mkdir $2/$sub
#rm -r $2/$sub/$Retro
mkdir $2/$sub/$Retro
mkdir $2/$sub/$Retro/$TE

### combine 6 invidual libraries ###
### combine SR support reads ###
awk '$5="lib1_"$5' OFS='\t' $2/$sub2/$Retro/$TE/$sub2.sr.pred.posreads > $2/$sub/$Retro/sr1.txt

cp $2/$sub/$Retro/sr1.txt $2/$sub/$Retro/$sub.$TE.sr.tabe.discover

rm $2/$sub/$Retro/sr1.txt

### combine the PE reads ###
awk '$5="lib1_"$5' OFS='\t' $2/$sub2/$Retro/$TE/$sub2.pe.pred.posreads > $2/$sub/$Retro/pe1.txt
awk '$5="lib1_"$5' OFS='\t' $2/$sub2/$Retro/$sub2.alignfilter.discover | grep L1 >  $2/$sub/$Retro/$sub.LINE.alignfilter.discover

cat $2/$sub/$Retro/pe1.txt \
    > $2/$sub/$Retro/$TE/$sub.$TE.novel.sites

ln -fs $2/$1/$Retro/$1.alignfilter.discover $2/$sub/$Retro/$sub.alignfilter.discover
rm $2/$sub/$Retro/pe1.txt

### make calls ###
$masterpath/utls/25_filter_SR_dup.pl $1 $2/$sub $Retro $TE
#cp $2/$sub/$Retro/$sub.$TE.sr.tabe.discover $2/$sub/$Retro/$sub.$TE.sr.dedup.discover
grep L1 $2/$sub/$Retro/$sub.$TE.sr.dedup.discover | grep 'OK' | \
   awk '{print $1"\t"$2"\t"$3"\t"$5}' | sort -u | \
   sort -k1,1 -k2,3n | \
   mergeBed -d 40 -c 4 -o distinct -delim ";" \
   -i stdin | \
   awk '{split ($4, num, ";"); print $1"\t"$2"\t"$3"\tsr,"length(num)","$4}' \
   > $2/$sub/$Retro/$TE/$sub.$TE.SR.calls

### PE calling ###
### L1 PE calls ###
$masterpath/utls/06_ana_depth.pl $sub $2/$sub $Retro $TE
$masterpath/utls/27_filter_dup.pl $1 $Retro $TE $2/$sub $5
#cp $2/$sub/$Retro/$TE/$sub.$TE.PE.calls $2/$sub/$Retro/$TE/$sub.$TE.PE.nodup.calls
$masterpath/utls/08_refine_depth.pl $sub $2/$sub $Retro $TE

### combine SR and PE ###
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... Combine SR and PE"
$masterpath/utls/09_merge.SR.PE.support.sh $sub $2/$sub $Retro $TE

windowBed \
   -w 100 -v \
   -a $2/$sub/$Retro/$TE/$sub.$TE.SR.PE.calls \
   -b $masterpath/refTE/position/$4.fa_LINE1_$6.bed \
   | windowBed -w 10 -v \
   -a stdin \
   -b $masterpath/refTE/position/$4.mask.bed \
   > $2/$sub/$Retro/$TE/$sub.$TE.noref.calls

$masterpath/utls/16_filter_r1r2.pl $sub $2/$sub $Retro $TE

