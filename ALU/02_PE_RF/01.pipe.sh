#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J AluPE
#SBATCH --account=dflev
#SBATCH -p batch
#SBATCH --mem=8gb
#SBATCH --time=20:00:00

usage="$(basename "$0") [-h] [-o m r] -- Applying the random forest models for the Alu PE supporting reads. Requires one core, and 8gb memory Requires R

where:
    -h  show this help text
    -o  output folder path
    -m  masterpath (default ~/masterpath)
    -r  RetroSom version control (default 1)"

ver=1
masterpath=~/masterpath
while getopts ":ho:m:r:" opt; do
  case $opt in
    h) echo "$usage"
       exit
       ;;
    o) outpath="$OPTARG"
       ;;
    r) ver="$OPTARG"
       ;;
    m) masterpath="$OPTARG"
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
    \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   esac
done

module load r
Rscript $masterpath/ALU/02_PE_RF/02.AluPE.predict.r $masterpath $outpath $ver
$masterpath/ALU/02_PE_RF/03_combine_all.sh $masterpath $outpath $ver
