#!/bin/bash

usage="$(basename "$0") [-h] [-o i g] -- BWA alignment and post-processing from trimmed sequencing reads, requires six cores, and 4-10G memory per core. Requires BWA (tested for v0.7.12), java, samtools and picard.

where:
    -h  show this help text
    -o  output folder path
    -i  subject ID
    -g  path to reference genome hg38 version GRCh38DH

Please note that post-processing is slow, and it may take ~100hours to align sequencing reads from 30X WGS data"

while getopts ":ho:i:g:" opt; do
  case $opt in
    h) echo "$usage"
       exit
       ;;
    o) outpath="$OPTARG"
       ;;
    i) sub="$OPTARG"
       ;;
    g) refG="$OPTARG"
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

Itag="@RG\tID:$sub\tSM:sample1\tLB:library1\tPL:Illumina"
mkdir $outpath/$sub/alignment
module load bwa/0.7.12
module load samtools
module load java
module load picard-tools/1.92

### Alignment and post processing ###
### using BWA version 0.7.12 ###
### using human reference genome GRCh38DH ###
bwa mem -t 6 -B 4 -O 6 -E 1 -M \
   -R $Itag \
   $refG/GRCh38_full_analysis_set_plus_decoy_hla.fa \
   $outpath/$sub/reads/$sub.trimmed.R1.fastq \
   $outpath/$sub/reads/$sub.trimmed.R2.fastq \
   | /home/xwzhu/levinson/common/k8-linux /srv/gs1/software/bwa/bwa-0.7.12/bin/bwakit/bwa-postalt.js -p \
   $refG/GRCh38_full_analysis_set_plus_decoy_hla-extra.fa \
   $refG/GRCh38_full_analysis_set_plus_decoy_hla.fa.alt \
   | samtools view -bSh \
   > $outpath/$sub/align/$sub.bam

### sort the aligned file by coordinates ###
samtools sort -@ 6 -T $sub \
   $outpath/$sub/align/$sub.bam \
   -o $outpath/$sub/align/$sub.sort.bam

