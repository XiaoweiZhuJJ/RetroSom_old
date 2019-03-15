TE=ALU
sub=SOM$3
tissue=$1
control=$2
workfolder=$4

module load bedtools

awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' \
   $workfolder/$sub/$TE/$tissue\.$TE.no$control\.1plus.learn.$5.old.discover \
   | sort -u | sort -k1,1 -k2,3n | \
   intersectBed -v \
   -a $workfolder/$sub/$TE/$tissue\.$TE.no$control\.1plus.learn.$5.calls \
   -b stdin \
   > $workfolder/$sub/$TE/$tissue\.$TE.no$control\.1plus.learn.$5.filter.calls
