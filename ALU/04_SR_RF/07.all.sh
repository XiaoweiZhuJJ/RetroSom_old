find /home/xwzhu/transfer/Project_VAC_11092_B01_GRM_WGS.2015-09-20/hg38/*/retro_v41_1/ALU \
    -name "*sr2.pred.stats" -print0 | \
    xargs -0 cat | grep 'recall\|precision\|Sample' | \
    sed ':a;N;$!ba;s/\nrecall/\trecall/g'  | \
    sed ':a;N;$!ba;s/\nprecision/\tprecision/g' \
    | grep -v MDA > /home/xwzhu/transfer/Project_VAC_11092_B01_GRM_WGS.2015-09-20/hg38/NOMDA.ALU.v41.sr.stats.txt

find /home/xwzhu/transfer/Project_VAC_11092_B01_GRM_WGS.2015-09-20/hg38/*/retro_v41_1/ALU \
    -name "*sr2.pred.stats" -print0 | \
    xargs -0 cat | grep 'recall\|precision\|Sample' | \
    sed ':a;N;$!ba;s/\nrecall/\trecall/g'  | \
    sed ':a;N;$!ba;s/\nprecision/\tprecision/g' \
    | grep MDA > /home/xwzhu/transfer/Project_VAC_11092_B01_GRM_WGS.2015-09-20/hg38/MDA.ALU.v41.sr.stats.txt
