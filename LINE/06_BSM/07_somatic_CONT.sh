#! /bin/sh
#
#$ -N SOM
#
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=10G
#$ -hold_jid SPLIT
#$ -j y
#
#$ -S /bin/bash
#
module load bedtools
TE=LINE
sub=SOM$5\_$6
cut=$1
cont=$2
tissue=$3
control=$4
WIN=600
Retro=retro_v$5\_$6
tisfolder=$7
confolder=$8

awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
   $confolder/$control\1/retro_v40/$control\1.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $tisfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print cont1"\t"$0}' \
   > $tisfolder/$sub/LINE/$tissue.LINE.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
   $confolder/$control\2/retro_v40/$control\2.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $tisfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print cont2"\t"$0}' \
   >> $tisfolder/$sub/LINE/$tissue.LINE.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
   $confolder/$control\3/retro_v40/$control\3.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $tisfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print cont3"\t"$0}' \
   >> $tisfolder/$sub/LINE/$tissue.LINE.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
   $confolder/$control\4/retro_v40/$control\4.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $tisfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print cont4"\t"$0}' \
   >> $tisfolder/$sub/LINE/$tissue.LINE.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
   $confolder/$control\5/retro_v40/$control\5.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $tisfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print cont5"\t"$0}' \
   >> $tisfolder/$sub/LINE/$tissue.LINE.no$4.$cont\plus.learn.$cut.old.discover

awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
   $confolder/$control\6/retro_v40/$control\6.$6.discover | \
   windowBed -w $WIN \
   -a stdin \
   -b $tisfolder/$sub/$TE/$tissue.$TE.no$4.$cont\plus.learn.$cut.calls \
   | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print cont6"\t"$0}' \
   >> $tisfolder/$sub/LINE/$tissue.LINE.no$4.$cont\plus.learn.$cut.old.discover
