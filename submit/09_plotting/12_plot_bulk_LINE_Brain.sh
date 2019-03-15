sub=$1
tissue=$2
control=$3
retro=retro_v$4
path=Brain$4
folder=$5
module load bedtools
### filter old discover ###
awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' \
   $folder/$sub/$path/LINE/$tissue.LINE.no$control.1plus.learn.2.old.discover \
   | sort -u | sort -k1,1 -k2,3n | \
   intersectBed -v \
   -a $folder/$sub/$path/LINE/$tissue.LINE.no$control.1plus.learn.2.calls \
   -b stdin \
   > $folder/$sub/$path/LINE/$tissue.LINE.no$control.1plus.learn.2.filter.calls 

### Plotting LINE ###
while read line; do
    chr=$(echo $line|awk '{print $1}')
    beg=$(echo $line|awk '{print $2}')
    end=$(echo $line|awk '{print $3}')
    ./01_plot_LINE.sh $chr $beg $end $sub $tissue $retro $folder/$sub $control
done < $folder/$sub/$path/LINE/$tissue.LINE.no$control.1plus.learn.2.filter.calls

