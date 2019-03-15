#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J TS
#SBATCH -t 20:0:0

#SBATCH --account=dflev
#SBATCH --mem=20G
#SBATCH -p batch

masterpath=/home/xwzhu/levinson/RetroSom
workfolder=/home/xwzhu/transfer/TSbrain
Retro=40
$masterpath/LINE/05_somatic/01_all_TS.sh $Retro 1 $workfolder $1 $2
$masterpath/LINE/05_somatic/01_all_TS.sh $Retro 0 $workfolder $1 $2
$masterpath/ALU/05_somatic/01_all_TS.sh $Retro 1 $workfolder $1 $2
$masterpath/ALU/05_somatic/01_all_TS.sh $Retro 0 $workfolder $1 $2
