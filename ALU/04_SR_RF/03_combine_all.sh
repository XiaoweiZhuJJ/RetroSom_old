masterpath=$1
while read line; do
    $masterpath/ALU/04_SR_RF/04_combine_SR_filter.pl $line $3 $2
done < $2/list.txt

