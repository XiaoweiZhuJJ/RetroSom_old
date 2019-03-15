#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J Simul200
#SBATCH -t 20:0:0
#SBATCH --account=dflev
#SBATCH --mem=20G
#SBATCH -p batch
masterpath=/home/xwzhu/masterpath
workfolder=/home/xwzhu/transfer/titration/Bulk/1702UNHX-0011
#$masterpath/LINE/05_somatic/01_all_2tis_6lib.sh 41 1 $workfolder TITR CONT _
#$masterpath/LINE/05_somatic/01_all_2tis_6lib.sh 41 0 $workfolder TITR CONT _
$masterpath/ALU/05_somatic/01_all_2tis_6lib.sh 42 1 $workfolder TITR CONT _
$masterpath/ALU/05_somatic/01_all_2tis_6lib.sh 42 0 $workfolder TITR CONT _
