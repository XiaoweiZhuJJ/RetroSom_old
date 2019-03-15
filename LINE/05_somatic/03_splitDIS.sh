#! /bin/sh
#
#$ -N SPLIT
#
#$ -cwd
#$ -l h_rt=6:00:00
#$ -l s_rt=6:00:00
#$ -l h_vmem=4G
#$ -j y
#
#$ -S /bin/bash
#

/home/xwzhu/levinson/retro_camal2/retro_SOM/LINE/05_somatic/04_par_direction.pl $1 $2

