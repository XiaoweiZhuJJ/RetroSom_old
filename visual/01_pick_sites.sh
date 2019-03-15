module load bedtools
masterpath=/home/xwzhu/masterpath
awk '{printf $1"\t"$2"\t"$3"\t"; for (i=6; i<=NF; ++i) {printf "%s,", $i; if ($i == $NF) printf "\n"}}' \
  $1 | \
  intersectBed -wo \
   -a stdin \
   -b $masterpath/visual/temp/00_cord.bed \
   > $masterpath/visual/temp/01_overlapping_insertions.txt


