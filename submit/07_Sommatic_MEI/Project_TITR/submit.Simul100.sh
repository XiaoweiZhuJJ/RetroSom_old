#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J Simul100
#SBATCH -t 20:0:0
#SBATCH --account=dflev
#SBATCH --mem=20G
#SBATCH -p batch
masterpath=/home/xwzhu/levinson/RetroSom
workfolder=/home/xwzhu/transfer/titration/Simul100
Retro=40
#$masterpath/LINE/05_somatic/01_all_2tis_2lib.sh $Retro 1 $workfolder TITR CONT _
#$masterpath/LINE/05_somatic/01_all_2tis_2lib.sh $Retro 0 $workfolder TITR CONT _
$masterpath/ALU/05_somatic/01_all_2tis_2lib.sh $Retro 1 $workfolder TITR CONT _
$masterpath/ALU/05_somatic/01_all_2tis_2lib.sh $Retro 0 $workfolder TITR CONT _
