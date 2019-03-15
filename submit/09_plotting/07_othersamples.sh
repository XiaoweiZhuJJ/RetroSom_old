module load bedtools
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/BulkSeq/10011/neg1/retro_v40/neg1.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "neg1\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/BulkSeq/10011/neg2/retro_v40/neg2.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "neg2\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/BulkSeq/10011/neg3/retro_v40/neg3.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "neg3\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/BulkSeq/10011/neg4/retro_v40/neg4.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "neg4\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/BulkSeq/10011/neg5/retro_v40/neg5.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "neg5\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/BulkSeq/10011/neg6/retro_v40/neg6.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "neg6\t"$0}' 

awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_1/retro_v40/CONT_1.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "cont1\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_2/retro_v40/CONT_2.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "cont2\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_3/retro_v40/CONT_3.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "cont3\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_4/retro_v40/CONT_4.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "cont4\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_5/retro_v40/CONT_5.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "cont4\t"$0}' 
awk '{if (($4 ~/L1HS/) && ($1~/chr/)) print}' \
    /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/CONT_6/retro_v40/CONT_6.$1.discover | \
    windowBed -w 500 \
    -a stdin \
    -b ./test.bed \
    | awk '{if (($4 == "L1HS") && ($8 > 95) && (($11<6000) || ($12<6000)) ) print "cont4\t"$0}' 

