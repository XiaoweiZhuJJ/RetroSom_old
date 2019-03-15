#!/bin/bash -l
# NOTE the -l flag!
#SBATCH -J PCRfree
#SBATCH -t 10:0:0
#SBATCH --account=dflev
#SBATCH --mem=20G
#SBATCH -p batch
masterpath=/home/xwzhu/levinson/RetroSom
workfolder=/home/xwzhu/transfer/BulkSeq/PCRfree

$masterpath/LINE/05_somatic/01_all_PCRfree.sh 41 1 $workfolder Neuron Heart
$masterpath/LINE/05_somatic/01_all_PCRfree.sh 41 0 $workfolder Neuron Heart 
$masterpath/ALU/05_somatic/01_all_PCRfree.sh 41 1 $workfolder Neuron Heart
$masterpath/ALU/05_somatic/01_all_PCRfree.sh 41 0 $workfolder Neuron Heart


