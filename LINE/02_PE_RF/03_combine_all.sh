masterpath=$1
while read line; do
   $masterpath/LINE/02_PE_RF/04_combine_PE.pl $line $3 $2
done < $2/list.txt

