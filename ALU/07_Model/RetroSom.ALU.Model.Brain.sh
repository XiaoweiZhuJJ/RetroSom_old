module load samtools
module load exonerate
module load bcftools
module load bedtools
module load perl-scg/5.14.4

sub=$1\_Brain
sub2=$1$8
sub3=$2$8
Retro=$4
echo "$1 $2" ### subject ID ###
echo $3  ### path ###
echo $Retro ### output folder ###
echo $5  ### reference genome hg19 G37 hg38... ###
echo $6  ### filter level:0=no filter, 1=prefilter, 2=allfilters ### 
strand=$7
TE=ALU

masterpath=/home/xwzhu/levinson/RetroSom
mkdir $3/$sub
#rm -r $3/$sub/$Retro
mkdir $3/$sub/$Retro
mkdir $3/$sub/$Retro/$TE

echo before comment
: <<'END'
### combine 6 invidual libraries ###
### combine SR support reads ###
awk '$5="lib1_"$5'  OFS='\t' $3/$sub2\1/retro_v42_$strand/$TE/$sub2\1.sr.pred.posreads > $3/$sub/$Retro/sr1.txt
awk '$5="lib2_"$5'  OFS='\t' $3/$sub2\2/retro_v42_$strand/$TE/$sub2\2.sr.pred.posreads > $3/$sub/$Retro/sr2.txt
awk '$5="lib3_"$5'  OFS='\t' $3/$sub2\3/retro_v42_$strand/$TE/$sub2\3.sr.pred.posreads > $3/$sub/$Retro/sr3.txt
awk '$5="lib4_"$5'  OFS='\t' $3/$sub2\4/retro_v42_$strand/$TE/$sub2\4.sr.pred.posreads > $3/$sub/$Retro/sr4.txt
awk '$5="lib5_"$5'  OFS='\t' $3/$sub2\5/retro_v42_$strand/$TE/$sub2\5.sr.pred.posreads > $3/$sub/$Retro/sr5.txt
awk '$5="lib6_"$5'  OFS='\t' $3/$sub2\6/retro_v42_$strand/$TE/$sub2\6.sr.pred.posreads > $3/$sub/$Retro/sr6.txt
awk '$5="lib7_"$5'  OFS='\t' $3/$sub3\1/retro_v42_$strand/$TE/$sub3\1.sr.pred.posreads > $3/$sub/$Retro/sr7.txt
awk '$5="lib8_"$5'  OFS='\t' $3/$sub3\2/retro_v42_$strand/$TE/$sub3\2.sr.pred.posreads > $3/$sub/$Retro/sr8.txt
awk '$5="lib9_"$5'  OFS='\t' $3/$sub3\3/retro_v42_$strand/$TE/$sub3\3.sr.pred.posreads > $3/$sub/$Retro/sr9.txt
awk '$5="lib10_"$5' OFS='\t' $3/$sub3\4/retro_v42_$strand/$TE/$sub3\4.sr.pred.posreads > $3/$sub/$Retro/sr10.txt
awk '$5="lib11_"$5' OFS='\t' $3/$sub3\5/retro_v42_$strand/$TE/$sub3\5.sr.pred.posreads > $3/$sub/$Retro/sr11.txt
awk '$5="lib12_"$5' OFS='\t' $3/$sub3\6/retro_v42_$strand/$TE/$sub3\6.sr.pred.posreads > $3/$sub/$Retro/sr12.txt

cat $3/$sub/$Retro/sr*.txt \
    > $3/$sub/$Retro/$sub.$TE.sr.tabe.discover
rm $3/$sub/$Retro/sr*.txt

### combine the PE reads ###
awk '$5="lib1_"$5'  OFS='\t' $3/$sub2\1/retro_v42_$strand/$TE/$sub2\1.pe.pred.posreads > $3/$sub/$Retro/pe1.txt
awk '$5="lib2_"$5'  OFS='\t' $3/$sub2\2/retro_v42_$strand/$TE/$sub2\2.pe.pred.posreads > $3/$sub/$Retro/pe2.txt
awk '$5="lib3_"$5'  OFS='\t' $3/$sub2\3/retro_v42_$strand/$TE/$sub2\3.pe.pred.posreads > $3/$sub/$Retro/pe3.txt
awk '$5="lib4_"$5'  OFS='\t' $3/$sub2\4/retro_v42_$strand/$TE/$sub2\4.pe.pred.posreads > $3/$sub/$Retro/pe4.txt
awk '$5="lib5_"$5'  OFS='\t' $3/$sub2\5/retro_v42_$strand/$TE/$sub2\5.pe.pred.posreads > $3/$sub/$Retro/pe5.txt
awk '$5="lib6_"$5'  OFS='\t' $3/$sub2\6/retro_v42_$strand/$TE/$sub2\6.pe.pred.posreads > $3/$sub/$Retro/pe6.txt
awk '$5="lib7_"$5'  OFS='\t' $3/$sub3\1/retro_v42_$strand/$TE/$sub3\1.pe.pred.posreads > $3/$sub/$Retro/pe7.txt
awk '$5="lib8_"$5'  OFS='\t' $3/$sub3\2/retro_v42_$strand/$TE/$sub3\2.pe.pred.posreads > $3/$sub/$Retro/pe8.txt
awk '$5="lib9_"$5'  OFS='\t' $3/$sub3\3/retro_v42_$strand/$TE/$sub3\3.pe.pred.posreads > $3/$sub/$Retro/pe9.txt
awk '$5="lib10_"$5' OFS='\t' $3/$sub3\4/retro_v42_$strand/$TE/$sub3\4.pe.pred.posreads > $3/$sub/$Retro/pe10.txt
awk '$5="lib11_"$5' OFS='\t' $3/$sub3\5/retro_v42_$strand/$TE/$sub3\5.pe.pred.posreads > $3/$sub/$Retro/pe11.txt
awk '$5="lib12_"$5' OFS='\t' $3/$sub3\6/retro_v42_$strand/$TE/$sub3\6.pe.pred.posreads > $3/$sub/$Retro/pe12.txt

cat $3/$sub/$Retro/pe*.txt \
    > $3/$sub/$Retro/$TE/$sub.$TE.novel.sites
rm $3/$sub/$Retro/pe*.txt

awk '$5="lib1_"$5'  OFS='\t' $3/$sub2\1/retro_v42_$strand/$sub2\1.alignfilter.discover | grep Alu >  $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib2_"$5'  OFS='\t' $3/$sub2\2/retro_v42_$strand/$sub2\2.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib3_"$5'  OFS='\t' $3/$sub2\3/retro_v42_$strand/$sub2\3.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib4_"$5'  OFS='\t' $3/$sub2\4/retro_v42_$strand/$sub2\4.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib5_"$5'  OFS='\t' $3/$sub2\5/retro_v42_$strand/$sub2\5.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib6_"$5'  OFS='\t' $3/$sub2\6/retro_v42_$strand/$sub2\6.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib7_"$5'  OFS='\t' $3/$sub3\1/retro_v42_$strand/$sub3\1.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib8_"$5'  OFS='\t' $3/$sub3\2/retro_v42_$strand/$sub3\2.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib9_"$5'  OFS='\t' $3/$sub3\3/retro_v42_$strand/$sub3\3.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib10_"$5' OFS='\t' $3/$sub3\4/retro_v42_$strand/$sub3\4.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib11_"$5' OFS='\t' $3/$sub3\5/retro_v42_$strand/$sub3\5.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover
awk '$5="lib12_"$5' OFS='\t' $3/$sub3\6/retro_v42_$strand/$sub3\6.alignfilter.discover | grep Alu >> $3/$sub/$Retro/$sub.ALU.alignfilter.discover

### make calls ###
$masterpath/utls/35_filter_SR_dup.pl $1 $3/$sub $Retro $TE
grep Alu $3/$sub/$Retro/$sub.$TE.sr.dedup.discover | grep 'OK' | \
   awk '{print $1"\t"$2"\t"$3"\t"$5}' | sort -u | \
   sort -k1,1 -k2,3n | \
   mergeBed -d 40 -c 4 -o distinct -delim ";" \
   -i stdin | \
   awk '{split ($4, num, ";"); print $1"\t"$2"\t"$3"\tsr,"length(num)","$4}' \
   > $3/$sub/$Retro/$TE/$sub.$TE.SR.calls

### PE calling ###
### Alu PE calls ###
$masterpath/utls/06_ana_depth.pl $sub $3/$sub $Retro $TE
$masterpath/utls/37_filter_dup.pl $1 $Retro $TE $3/$sub $6
#mv $3/$sub/$Retro/$TE/$sub.$TE.PE.calls $3/$sub/$Retro/$TE/$sub.$TE.PE.nodup.calls
$masterpath/utls/08_refine_depth.pl $sub $3/$sub $Retro $TE

### combine SR and PE ###
date '+%m/%d/%y %H:%M:%S'
echo "Calling PE phase ... Combine SR and PE"
$masterpath/utls/09_merge.SR.PE.support.sh $sub $3/$sub $Retro $TE

windowBed \
   -w 100 -v \
   -a $3/$sub/$Retro/$TE/$sub.$TE.SR.PE.calls \
   -b $masterpath/refTE/position/$5.fa_ALU_$strand.bed \
   | windowBed -w 10 -v \
   -a stdin \
   -b $masterpath/refTE/position/$5.mask.bed \
   > $3/$sub/$Retro/$TE/$sub.$TE.noref.calls

END
### checking overlap ###
echo "checking overlapping reads"
$masterpath/utls/47_parse_overlap.pl $4 ALU $3 $1

$masterpath/utls/16_filter_r1r2.pl $sub $3/$sub $Retro $TE

