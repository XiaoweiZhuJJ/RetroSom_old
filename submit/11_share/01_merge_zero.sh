#! /bin/sh
#
#$ -N MERGE
#
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=8G
#$ -j y
#
#$ -S /bin/bash
#

module load bedtools
Retro=retro_v$1
workfolder=/home/xwzhu/transfer/BulkSeq/$2
mkdir $workfolder/SOM$1
mkdir $workfolder/SOM$1/Merge_$TE
tis1=$3
tis2=$4
tis3=$5
TE=$6

cat \
$workfolder/$tis1\_Model/$Retro/$TE/$tis1\_Model.$TE.novel.calls \
$workfolder/$tis1\_NoModel/$Retro/$TE/$tis1\_NoModel.$TE.SR.PE.calls \
$workfolder/$tis2\_Model/$Retro/$TE/$tis2\_Model.$TE.novel.calls \
$workfolder/$tis2\_NoModel/$Retro/$TE/$tis2\_NoModel.$TE.SR.PE.calls \
$workfolder/$tis3\_Model/$Retro/$TE/$tis3\_Model.$TE.novel.calls \
$workfolder/$tis3\_NoModel/$Retro/$TE/$tis3\_NoModel.$TE.SR.PE.calls \
    | sort -k1,1 -k2,3n | \
    mergeBed -d 300 -i stdin \
    > $workfolder/SOM$1/Merge_$TE/merge.$2.$TE.calls

