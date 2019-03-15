#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J Share
#SBATCH -t 2:0:0
#SBATCH --account=dflev
#SBATCH --mem=12G
#SBATCH -p batch

masterpath=/home/xwzhu/masterpath
module load bedtools
retro=$1
subject=$2
TE=$3
strand=$4
$masterpath/submit/11_share/01_merge_zero.sh $retro $subject fib neg pos $TE
$masterpath/submit/11_share/02_somatic_zero.pl $retro $subject $TE
$masterpath/submit/11_share/03_cand.sh $retro $subject $TE $strand

