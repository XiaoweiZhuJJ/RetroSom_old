#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J SOM
#SBATCH --account=dflev
#SBATCH -p batch
#SBATCH --mem=12gb
#SBATCH --time=6:00:00

module load bedtools
TE=ALU
sub=SOM$5\_$6
cut=$1
cont=$2
tissue=$3
control=$4$8
WIN=600
Retro=retro_v$5\_$6
workfolder=$7

awk '{if (($4 ~/Alu/) && ($1~/chr/) && ($8>95)) print $1"\t"$2"\t"$3}' \
   $workfolder/$control/retro_v40/$control.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{print cont1"\t"$0}' \
   > $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

### Add NA12878 ###
awk '{if (($4 ~/Alu/) && ($1~/chr/)) print}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_1/retro_v40/CONT_1.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 ~ /Alu/) && ($8 > 95) ) print cont6"\t"$0}' \
   >> $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/Alu/) && ($1~/chr/)) print}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_2/retro_v40/CONT_2.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 ~ /Alu/) && ($8 > 95) ) print cont6"\t"$0}' \
   >> $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/Alu/) && ($1~/chr/)) print}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_3/retro_v40/CONT_3.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 ~ /Alu/) && ($8 > 95) ) print cont6"\t"$0}' \
   >> $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/Alu/) && ($1~/chr/)) print}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_4/retro_v40/CONT_4.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 ~ /Alu/) && ($8 > 95) ) print cont6"\t"$0}' \
   >> $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/Alu/) && ($1~/chr/)) print}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_5/retro_v40/CONT_5.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 ~ /Alu/) && ($8 > 95) ) print cont6"\t"$0}' \
   >> $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/Alu/) && ($1~/chr/)) print}' \
   /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_6/retro_v40/CONT_6.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 ~ /Alu/) && ($8 > 95) ) print cont6"\t"$0}' \
   >> $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

