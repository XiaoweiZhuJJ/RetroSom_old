#!/bin/bash -l
# NOTE the -l flag!
#
#SBATCH -J Brain
#SBATCH -o %x.%A.output
#SBATCH -t 40:0:0
#SBATCH --account=dflev
#SBATCH --mem=10G
#SBATCH -p batch

usage="$(basename "$0") [-h] [-o i m r g] -- Calling the putative somatic MEIs.
Requires 1 core, and 10gb memory

where:
    -h  show this help text
    -o  output folder path
    -i  subject ID
    -m  masterpath (default ~/masterpath)
    -r  RetroSom version control (default 1)
    -g  reference genome version (hg38, hg19 etc., default: hg38)"

ver=1
masterpath=~/masterpath
hg=hg38
while getopts ":ho:i:m:r:g:" opt; do
  case $opt in
    h) echo "$usage"
       exit
       ;;
    o) outpath="$OPTARG"
       ;;
    i) sub="$OPTARG"
       ;;
    r) ver="$OPTARG"
       ;;
    m) masterpath="$OPTARG"
       ;;
    g) hg="$OPTARG"
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

workfolder=$outpath/$sub
$masterpath/LINE/05_somatic/01_all_3tis_6lib.sh $ver 1 $workfolder Astro Neuron Heart $hg $masterpath _
$masterpath/LINE/05_somatic/01_all_3tis_6lib.sh $ver 0 $workfolder Astro Neuron Heart $hg $masterpath _
$masterpath/ALU/05_somatic/01_all_3tis_6lib.sh $ver 1 $workfolder Astro Neuron Heart $hg $masterpath _
$masterpath/ALU/05_somatic/01_all_3tis_6lib.sh $ver 0 $workfolder Astro Neuron Heart $hg $masterpath _
