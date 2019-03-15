#!/bin/bash

usage="$(basename "$0") [-h] [-o i] -- Remove PCR duplicates, secondary and supplementary alignment; Sort and indec the BAM file
Require BWA (v0.7.12), samtools and picard; Require 1 core

where:
    -h  show this help text
    -o  output folder path
    -i  subject ID"

while getopts ":ho:i:g:" opt; do
  case $opt in
    h) echo "$usage"
       exit
       ;;
    o) outpath="$OPTARG"
       ;;
    i) sub="$OPTARG"
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
module load samtools
module load java
module load picard-tools/1.92

### remove PCR duplicates, secondary alignment and supplementary alignment ###
java -Xmx4g -jar \
   /srv/gsfs0/software/picard-tools/1.129/picard.jar MarkDuplicates \
   I=$outpath/$sub/align/$sub.sort.bam \
   O=/dev/stdout \
   ASSUME_SORTED=true \
   TMP_DIR=$outpath/$sub/align/ \
   MAX_RECORDS_IN_RAM=2000000 \
   REMOVE_DUPLICATES=true \
   VALIDATION_STRINGENCY=SILENT \
   METRICS_FILE=$outpath/$sub/QC/$sub.dedupp.metrics | \
   samtools view -bh -F 0x0100 -F 0x400 -F 0x800 \
   > $outpath/$sub/align/$sub.recal.sorted.bam

### index the BAM file ###
samtools index \
   $outpath/$sub/align/$sub.final.bam

### check the alignment statistics ###
samtools flagstat \
    $outpath/$sub/align/$sub.final.bam \
    > $outpath/$sub/align/$sub.flagstat

