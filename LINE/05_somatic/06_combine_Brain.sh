module load bedtools
TE=LINE
sub=Brain$5\_$6
cut=$1
cont=$2
tissue=$3
control=$4
WIN=100
Retro=retro_v$5\_$6
workfolder=$7
#mkdir $workfolder/$sub
#mkdir $workfolder/$sub/$TE

awk -v cutoff=$cut '{if ($5>=cutoff) print}' \
   $workfolder/$tissue\_Brain/$Retro/$TE/$tissue\_Brain.$TE.novel.calls \
   > $workfolder/$tissue\_Brain/$Retro/$TE/$tissue\_Brain.$TE.$cut.calls

awk -v cutoff=$cont '{if ($5>=cutoff) print}' \
   $workfolder/$control\_NoModel/$Retro/$TE/$control\_NoModel.$TE.SR.PE.calls | \
   windowBed -v \
   -w $WIN \
   -a $workfolder/$tissue\_Brain/$Retro/$TE/$tissue\_Brain.$TE.$cut.calls \
   -b stdin \
   | sort -k1,1 -k2,3n \
   > $workfolder/$sub/$TE/$tissue.$TE.no$control.$cont\plus.learn.$cut.calls

#wc -l /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/$sub/LINE/$tissue.LINE.no$control.$cont\plus.learn.$cut.calls

