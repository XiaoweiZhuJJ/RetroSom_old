#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J SPLIT
# Request 5 hours run time
#SBATCH -t 10:0:0
#SBATCH --mem=6000
#SBATCH --account=dflev
#SBATCH -p batch

usage="$(basename "$0") [-h] [-o i g m] -- Seperating supporting reads from + strand or - strand, requires one core, and 4-10G memory per core.

where:
    -h  show this help text
    -o  output folder path
    -i  subject ID
    -m  masterpath (default ~/masterpath)
    -r  RetroSom version control (default 1)"

masterpath=~/masterpath
retro=1
while getopts ":ho:i:m:r:" opt; do
  case $opt in
    h) echo "$usage"
       exit
       ;;
    o) outpath="$OPTARG"
       ;;
    i) sub="$OPTARG"
       ;;
    m) masterpath="$OPTARG"
       ;;
    r) ver="$OPTARG"
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

### split the supporting reads from + strand and - strand ###
retro=retro_v$ver
$masterpath/utls/21_par_direction.pl $sub $outpath $retro

