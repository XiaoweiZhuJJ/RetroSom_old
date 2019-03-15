export PATH=$PATH:/srv/gsfs0/projects/levinson/xwzhu/exonerate/
masterpath=/home/xwzhu/masterpath
pefile=$masterpath/visual/temp/02_PEsupport.fa
if [ -s "$pefile" ]
then
exonerate --model affine:local \
   --bestn 1 --ryo "INFO: %qi %qal %pi %tS %ti %qab %qae %tab %tae %tas\n" \
   $masterpath/visual/temp/02_PEsupport.fa \
   $1 | grep "^INFO" \
   > $masterpath/visual/temp/04_PE.alignment
fi

srfile=$masterpath/visual/temp/03_SRsupport.fa
if [ -s "$srfile" ]
then
exonerate --model affine:local \
   --bestn 1 --ryo "INFO: %qi %qal %pi %tS %ti %qab %qae %tab %tae %tas\n" \
   $masterpath/visual/temp/03_SRsupport.fa \
   $1 | grep "^INFO" \
   > $masterpath/visual/temp/05_SR.alignment
fi
