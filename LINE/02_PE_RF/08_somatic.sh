module load bedtools
TE=LINE
sub=TITR
cut=$1
WIN=600
Retro=retro_v14
workfolder=/home/xwzhu/transfer/titration/Bulk/1702UNHX-0011
mkdir $workfolder/$sub

awk '{if ($17==1) print $1"\t"$2"\t"$3"\t"$4}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_1/retro_v14/LINE/TITR_1.pe.pred.summary \
   > /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_1/retro_v14/LINE/TITR_1.pe.pos.calls

awk '{if ($17==1) print $1"\t"$2"\t"$3"\t"$4}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_2/retro_v14/LINE/TITR_2.pe.pred.summary \
   > /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_2/retro_v14/LINE/TITR_2.pe.pos.calls

awk '{if ($17==1) print $1"\t"$2"\t"$3"\t"$4}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_3/retro_v14/LINE/TITR_3.pe.pred.summary \
   > /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_3/retro_v14/LINE/TITR_3.pe.pos.calls

awk '{if ($17==1) print $1"\t"$2"\t"$3"\t"$4}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_4/retro_v14/LINE/TITR_4.pe.pred.summary \
   > /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_4/retro_v14/LINE/TITR_4.pe.pos.calls

awk '{if ($17==1) print $1"\t"$2"\t"$3"\t"$4}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_5/retro_v14/LINE/TITR_5.pe.pred.summary \
   > /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_5/retro_v14/LINE/TITR_5.pe.pos.calls

awk '{if ($17==1) print $1"\t"$2"\t"$3"\t"$4}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_6/retro_v14/LINE/TITR_6.pe.pred.summary \
   > /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_6/retro_v14/LINE/TITR_6.pe.pos.calls

cat /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_1/retro_v14/LINE/TITR_1.pe.pos.calls \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_2/retro_v14/LINE/TITR_2.pe.pos.calls \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_3/retro_v14/LINE/TITR_3.pe.pos.calls \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_4/retro_v14/LINE/TITR_4.pe.pos.calls \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_5/retro_v14/LINE/TITR_5.pe.pos.calls \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR_6/retro_v14/LINE/TITR_6.pe.pos.calls \
    | sort -k1,1 -k2,3n | \
    mergeBed -d 300 -c 4 -o count -i stdin \
    | awk -v cutoff=$cut '{if ($4 >= cutoff) print $1"\t"$2"\t"$3}' \
    > $workfolder/$sub/$TE/$sub.$TE.learning.$cut.calls

windowBed -v \
   -w $WIN \
   -a $workfolder/TITR/$TE/TITR.$TE.learning.$cut.calls \
   -b $workfolder/CONT/$TE/CONT.$TE.SR.PE.calls \
   | sort -k1,1 -k2,3n \
   > $workfolder/TITR/$TE/TITR.$TE.noCONT.learn.$cut.calls

target=Astro_1
windowBed -w 600 -u \
    -a $workfolder/TITR/$TE/TITR.$TE.noCONT.learn.$cut.calls \
    -b /home/xwzhu/transfer/titration/TPTN16/LINE/unique/$target\.newbed \
    > $workfolder/TITR/$TE/$target.learn.$cut.calls

target=HG00514
windowBed -w 600 -u \
    -a $workfolder/TITR/$TE/TITR.$TE.noCONT.learn.$cut.calls \
    -b /home/xwzhu/transfer/titration/TPTN16/LINE/unique/$target\.newbed \
    > $workfolder/TITR/$TE/$target.learn.$cut.calls

target=HG00733
windowBed -w 600 -u \
    -a $workfolder/TITR/$TE/TITR.$TE.noCONT.learn.$cut.calls \
    -b /home/xwzhu/transfer/titration/TPTN16/LINE/unique/$target\.newbed \
    > $workfolder/TITR/$TE/$target.learn.$cut.calls

target=NA19240
windowBed -w 600 -u \
    -a $workfolder/TITR/$TE/TITR.$TE.noCONT.learn.$cut.calls \
    -b /home/xwzhu/transfer/titration/TPTN16/LINE/unique/$target\.newbed \
    > $workfolder/TITR/$TE/$target.learn.$cut.calls

target=NA12877
windowBed -w 600 -u \
    -a $workfolder/TITR/$TE/TITR.$TE.noCONT.learn.$cut.calls \
    -b /home/xwzhu/transfer/titration/TPTN16/LINE/unique/$target\.newbed \
    > $workfolder/TITR/$TE/$target.learn.$cut.calls

target=NA12878
windowBed -w 600 -u \
    -a $workfolder/TITR/$TE/TITR.$TE.noCONT.learn.$cut.calls \
    -b /home/xwzhu/transfer/titration/TPTN16/LINE/unique/$target\.newbed \
    > $workfolder/TITR/$TE/$target.learn.$cut.calls
                                                                                          
./09_somatic_zero.pl $cut 

wc -l /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR/LINE/TITR.LINE.noCONT.learn.$cut.matrix 
 awk '{if ( ($1 ~ /chr/) && ( ($6>10) || ($9>10) || ($12>10) || ($15>10) || ($31>5) || ($32>5) || ($33>5))) print}' /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR/LINE/TITR.LINE.noCONT.learn.$cut.matrix | wc -l
