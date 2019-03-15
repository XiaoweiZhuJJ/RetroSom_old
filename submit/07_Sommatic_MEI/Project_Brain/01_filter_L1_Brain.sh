TE=LINE
sub=Brain$1
tissue=$4
control=$5
Retro=retro_v$1
workfolder=$3

module load bedtools

awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' \
   $workfolder/$sub/LINE/$tissue\.LINE.no$control\.1plus.learn.$2.old.discover \
   | sort -u | sort -k1,1 -k2,3n | \
   intersectBed -v \
   -a $workfolder/$sub/LINE/$tissue\.LINE.no$control\.1plus.learn.$2.calls \
   -b stdin \
   > $workfolder/$sub/LINE/$tissue\.LINE.no$control\.1plus.learn.$2.filter.calls
wc -l $workfolder/$sub/LINE/$tissue\.LINE.no$control\.1plus.learn.$2.filter.calls
