masterpath=$1
while read line; do
    $masterpath/LINE/04_SR_RF/04_combine_SR.pl $line $3 $2
done < $2/list.txt

