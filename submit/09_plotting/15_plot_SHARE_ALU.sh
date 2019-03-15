TE=ALU
retro=42
folder=/home/xwzhu/transfer/BulkSeq

control=control
while read line; do
    sub=$(echo $line|awk '{print $1}')
    strand=$(echo $line|awk '{print $2}')
    chr=$(echo $line|awk '{print $3}')
    beg=$(echo $line|awk '{print $4}')
    end=$(echo $line|awk '{print $5}')
    tissue=$(echo $line|awk '{print $7}')
    ./04_plot_ALU.sh $chr $beg $end $sub $tissue retro_v$retro\_$strand $folder/$sub $control
done < /home/xwzhu/transfer/BulkSeq/SHARE/$TE.txt
