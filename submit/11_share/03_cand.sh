retro=$1
subject=$2
TE=$3
strand=$4
folder=/home/xwzhu/transfer/BulkSeq/$subject/SOM$retro/Merge_$TE
module load bedtools 

awk '{if ( ($5 > 0) && (($7>0) || ($9>0)) && (($4 >1) || ($6>1) || ($8 >1)) && ($5<10) && ($7<10) && ($9<10) ) print $1"\t"$2"\t"$3"\t"$4"_"$5"_"$6"_"$7"_"$8"_"$9}' \
    $folder/Shared.$2\.$TE\.calls | \
    windowBed -w 500 -v \
    -a stdin \
    -b /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_1/retro_v40/CONT_1.$TE.$strand.discover | \
    windowBed -w 500 -v \
    -a stdin \
    -b /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_2/retro_v40/CONT_2.$TE.$strand.discover | \
    windowBed -w 500 -v \
    -a stdin \
    -b /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_3/retro_v40/CONT_3.$TE.$strand.discover | \
    windowBed -w 500 -v \
    -a stdin \
    -b /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_4/retro_v40/CONT_4.$TE.$strand.discover | \
    windowBed -w 500 -v \
    -a stdin \
    -b /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_5/retro_v40/CONT_5.$TE.$strand.discover | \
    windowBed -w 500 -v \
    -a stdin \
    -b /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_6/retro_v40/CONT_6.$TE.$strand.discover \
    > $folder/candidates.$2\.$TE\.calls

