#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J Brain
#SBATCH -o %x.%A.output
#SBATCH -t 40:0:0

#SBATCH --account=dflev
#SBATCH --mem=20G
#SBATCH -p batch

masterpath=/home/xwzhu/masterpath
workfolder=/home/xwzhu/transfer/BulkSeq/$1

$masterpath/LINE/05_somatic/01_all_3tis_6lib.sh 41 1 $workfolder Astro Neuron Heart _
$masterpath/LINE/05_somatic/01_all_3tis_6lib.sh 41 0 $workfolder Astro Neuron Heart _
$masterpath/ALU/05_somatic/01_all_3tis_6lib.sh 42 1 $workfolder Astro Neuron Heart _
$masterpath/ALU/05_somatic/01_all_3tis_6lib.sh 42 0 $workfolder Astro Neuron Heart _

#$masterpath/LINE/05_somatic/01_all_3tis_Brain.sh 41 1 $workfolder Astro Neuron Heart _
#$masterpath/LINE/05_somatic/01_all_3tis_Brain.sh 41 0 $workfolder Astro Neuron Heart _
#$masterpath/ALU/05_somatic/01_all_3tis_Brain.sh 42 1 $workfolder Astro Neuron Heart _
#$masterpath/ALU/05_somatic/01_all_3tis_Brain.sh 42 0 $workfolder Astro Neuron Heart _
