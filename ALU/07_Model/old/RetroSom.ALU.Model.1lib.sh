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
TE=ALU

masterpath=/home/xwzhu/levinson/RetroSom
mkdir $2/$sub
#rm -r $2/$sub/$Retro
mkdir $2/$sub/$Retro
mkdir $2/$sub/$Retro/$TE

awk '$5="lib1_"$5' OFS='\t' $2/$sub2\15/$Retro/$TE/$sub2\15.sr.pred.posreads \
    > $2/$sub/$Retro/$sub.$TE.sr.tabe.discover

awk '$5="lib1_"$5' OFS='\t' $2/$sub2\15/$Retro/$TE/$sub2\15.pe.pred.posreads \
    > $2/$sub/$Retro/$TE/$sub.$TE.novel.sites

### make calls ###
grep Alu $2/$sub/$Retro/$sub.$TE.sr.tabe.discover | grep 'OK' | \
   awk '{print $1"\t"$2"\t"$3"\t"$5}' | sort -u | \
   sort -k1,1 -k2,3n | \
   mergeBed -d 40 -c 4 -o distinct -delim ";" \
   -i stdin | \
   awk '{split ($4, num, ";"); print $1"\t"$2"\t"$3"\tsr,"length(num)","$4}' \
   > $2/$sub/$Retro/$TE/$sub.$TE.SR.calls

### PE calling ###
### Alu PE calls ###
$masterpath/utls/06_ana_depth.pl $sub $2/$sub $Retro $TE
mv $2/$sub/$Retro/$TE/$sub.$TE.PE.calls $2/$sub/$Retro/$TE/$sub.$TE.PE.nodup.calls
$masterpath/utls/08_refine_depth.pl $sub $2/$sub $Retro $TE

### combine SR and PE ###
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... Combine SR and PE"
$masterpath/utls/09_merge.SR.PE.support.sh $sub $2/$sub $Retro $TE

windowBed \
   -w 100 -v \
   -a $2/$sub/$Retro/$TE/$sub.$TE.SR.PE.calls \
   -b $masterpath/refTE/position/$4.fa_ALU_$6.bed \
   > $2/$sub/$Retro/$TE/$sub.$TE.novel.calls

