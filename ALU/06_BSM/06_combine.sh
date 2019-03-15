#! /bin/sh
#
#$ -N SOM
#
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=10G
#$ -j y
#
#$ -S /bin/bash
#
module load bedtools
TE=ALU
sub=SOM$5\_$6
cut=$1
cont=$2
tissue=$3
control=$4
WIN=100
Retro=retro_v$5\_$6
tisfolder=$7
confolder=$8
#mkdir $workfolder/$sub
#mkdir $workfolder/$sub/$TE

awk -v cutoff=$cut '{if ($5>=cutoff) print}' \
   $tisfolder/$tissue\_Model/$Retro/$TE/$tissue\_Model.$TE.over.calls \
   > $tisfolder/$tissue\_Model/$Retro/$TE/$tissue\_Model.$TE.$cut.calls

awk -v cutoff=$cont '{if ($5>=cutoff) print}' \
   $confolder/$control\_NoModel/$Retro/$TE/$control\_NoModel.$TE.SR.PE.calls | \
   windowBed -v \
   -w $WIN \
   -a $tisfolder/$tissue\_Model/$Retro/$TE/$tissue\_Model.$TE.$cut.calls \
   -b stdin \
   | sort -k1,1 -k2,3n \
   > $tisfolder/$sub/$TE/$tissue.$TE.no$control.$cont\plus.learn.$cut.calls

