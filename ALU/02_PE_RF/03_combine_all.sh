masterpath=$1
while read line; do
   $masterpath/ALU/02_PE_RF/04_combine_PE_filter.pl $line $3 $2
done < $2/list.txt


