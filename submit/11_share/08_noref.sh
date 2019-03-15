#! /bin/sh
#
#$ -N NORef
#
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l s_rt=6:00:00
#$ -l h_vmem=6G
#$ -j y
#
#$ -S /bin/bash
#

module load bedtools
tail -n +2 ~/Platium/hg38/TPTN15/LINE/somatic.zero.LINE.calls | \
   windowBed \
   -w 100 -v \
   -a stdin \
   -b ~/levinson/retro_camal2/refTE/position/hg38.fa_LINE1.bed \
   > ~/Platium/hg38/TPTN15/LINE/somatic.noref.LINE.calls

