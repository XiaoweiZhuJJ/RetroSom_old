#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J L1NoModel
#SBATCH --account=dflev
#SBATCH -p batch
#SBATCH --mem=10gb
#SBATCH --time=6:00:00

module load samtools
module load exonerate
module load bcftools
module load bedtools

Retro=$3
sub=$1$8$7\_NoModel
sub2=$1$8
echo $1  ### subject ID ###
echo $2  ### path ###
echo $Retro ### output folder ###
echo $4  ### reference genome hg19 G37 hg38... ###
echo $5  ### filter level:0=no filter, 1=prefilter, 2=allfilters ### 
TE=LINE
lib=$7
workpath="/srv/gsfs0/projects/levinson/xwzhu/retro_camal2/common"
refpath="/srv/gsfs0/projects/levinson/xwzhu/retro_camal2"

mkdir $2/$sub
#rm -r $2/$sub/$Retro
mkdir $2/$sub/$Retro
mkdir $2/$sub/$Retro/$TE

### combine 6 invidual libraries ###
### combine SR support reads ###
awk '$5="lib1_"$5' OFS='\t' $2/$sub2$lib/$Retro/$sub2$lib.sr.tabe.discover > $2/$sub/$Retro/sr1.txt
cat $2/$sub/$Retro/sr1.txt \
    > $2/$sub/$Retro/$sub.$TE.sr.tabe.discover
rm $2/$sub/$Retro/sr1.txt

### combine the PE reads ###
awk '$5="lib1_"$5' OFS='\t' $2/$sub2$lib/$Retro/$TE/$sub2$lib.$TE.nodup.sites > $2/$sub/$Retro/pe1.txt
cat $2/$sub/$Retro/pe1.txt \
    > $2/$sub/$Retro/$TE/$sub.$TE.novel.sites
rm $2/$sub/$Retro/pe1.txt

### make calls ###
grep L1 $2/$sub/$Retro/$sub.$TE.sr.tabe.discover | grep 'OK' | \
   awk '{print $1"\t"$2"\t"$3"\t"$5}' | sort -u | \
   sort -k1,1 -k2,3n | \
   mergeBed -d 40 -c 4 -o distinct -delim ";" \
   -i stdin | \
   awk '{split ($4, num, ";"); print $1"\t"$2"\t"$3"\tsr,"length(num)","$4}' \
   > $2/$sub/$Retro/$TE/$sub.$TE.SR.calls

### PE calling ###
### L1 PE calls ###
$workpath/06_ana_depth.pl $sub $2/$sub $Retro $TE 1000
mv $2/$sub/$Retro/$TE/$sub.$TE.PE.calls $2/$sub/$Retro/$TE/$sub.$TE.PE.nodup.calls
$workpath/08_refine_depth.pl $sub $2/$sub $Retro $TE

### combine SR and PE ###
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... Combine SR and PE"
$workpath/09_merge.SR.PE.support.sh $sub $2/$sub $Retro $TE

windowBed \
   -w 100 -v \
   -a $2/$sub/$Retro/$TE/$sub.$TE.SR.PE.calls \
   -b $refpath/refTE/position/$4.fa_LINE1_$6.bed \
   > $2/$sub/$Retro/$TE/$sub.$TE.novel.calls

