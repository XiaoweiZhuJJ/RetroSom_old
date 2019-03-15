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

awk '{if (($4 ~/Alu/) && ($1~/chr/)) print}' \
   $workfolder/$control\7/retro_v40/$control\7.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 ~ /Alu/) && ($8 > 95) ) print cont1"\t"$0}' \
   > $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/Alu/) && ($1~/chr/)) print}' \
   $workfolder/$control\8/retro_v40/$control\8.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $workfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 ~ /Alu/) && ($8 > 95) ) print cont2"\t"$0}' \
   >> $workfolder/$sub/ALU/$tissue.ALU.no$4.$cont\plus.learn.$cut.old.discover

