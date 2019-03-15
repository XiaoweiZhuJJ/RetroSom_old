module load bedtools
TE=ALU
sub=SOM$1\_$2
cut=$4
cont=1
WIN=600
workfolder=$3
#mkdir $workfolder/$sub
#mkdir $workfolder/$sub/$TE

target=Heart
windowBed -w 600 -u \
    -a $workfolder/$sub/$TE/TITR.$TE.noCONT.$cont\plus.learn.$cut.filter.calls \
    -b /home/xwzhu/transfer/titration/TPTN42_$2/ALU/unique/$target\.bed \
    > $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls
wc -l $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls

target=NA19240
windowBed -w 600 -u \
    -a $workfolder/$sub/$TE/TITR.$TE.noCONT.$cont\plus.learn.$cut.filter.calls \
    -b /home/xwzhu/transfer/titration/TPTN42_$2/ALU/unique/$target\.bed \
    > $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls
wc -l $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls

target=HG00514
windowBed -w 600 -u \
    -a $workfolder/$sub/$TE/TITR.$TE.noCONT.$cont\plus.learn.$cut.filter.calls \
    -b /home/xwzhu/transfer/titration/TPTN42_$2/ALU/unique/$target\.bed \
    > $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls
wc -l $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls

target=HG00733
windowBed -w 600 -u \
    -a $workfolder/$sub/$TE/TITR.$TE.noCONT.$cont\plus.learn.$cut.filter.calls \
    -b /home/xwzhu/transfer/titration/TPTN42_$2/ALU/unique/$target\.bed \
    > $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls
wc -l $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls

target=bulk
windowBed -w 600 -u \
    -a $workfolder/$sub/$TE/TITR.$TE.noCONT.$cont\plus.learn.$cut.filter.calls \
    -b /home/xwzhu/transfer/titration/TPTN42_$2/ALU/unique/$target\.bed \
    > $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls
wc -l $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls

target=NA12877
windowBed -w 600 -u \
    -a $workfolder/$sub/$TE/TITR.$TE.noCONT.$cont\plus.learn.$cut.filter.calls \
    -b /home/xwzhu/transfer/titration/TPTN42_$2/ALU/unique/$target\.bed \
    > $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls
wc -l $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls

target=NA12878
windowBed -w 600 -u \
    -a $workfolder/$sub/$TE/TITR.$TE.noCONT.$cont\plus.learn.$cut.filter.calls \
    -b /home/xwzhu/transfer/titration/TPTN42_$2/ALU/unique/$target\.bed \
    > $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls
wc -l $workfolder/$sub/$TE/$target.noCONT.$cont\plus.learn.$cut.calls                                                                                
./06_somatic_zero_Alu.pl $cut $cont $1 $2 $workfolder

wc -l $workfolder/$sub/ALU/TITR.ALU.noCONT.$cont\plus.learn.$cut.matrix 
 awk '{if ( ($1 ~ /chr/) &&  (!($2~/cord/)) && ( ($6>=10) || ($9>=10) || ($12>=10) || ($15>=10) || ($31>5) || ($32>5) || ($33>5)) || ($34>5) || ($35>5) || ($36>5) ) print}' $workfolder/$sub/ALU/TITR.ALU.noCONT.$cont\plus.learn.$cut.matrix | wc -l
