sub=$1
tissue=$2
control=$3
strand=$4
retro=32
path=STRAND32
module load bedtools
### filter old discover ###
awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' \
   /home/xwzhu/transfer/BulkSeq/$sub/$path/ALU/$tissue.strand$strand.ALU.no$control.1plus.learn.2.old.discover \
   | sort -u | sort -k1,1 -k2,3n | \
   intersectBed -v \
   -a /home/xwzhu/transfer/BulkSeq/$sub/$path/ALU/$tissue.strand$strand.ALU.no$control.1plus.learn.2.calls \
   -b stdin \
   > /home/xwzhu/transfer/BulkSeq/$sub/$path/ALU/$tissue.strand$strand.ALU.no$control.1plus.learn.2.filter.calls 

### make new directory ###
mkdir /home/xwzhu/levinson/retro_camal2/visual/AluCand
mkdir /home/xwzhu/levinson/retro_camal2/visual/AluCand/$sub
mkdir /home/xwzhu/levinson/retro_camal2/visual/AluCand/$sub/AluYc1
mkdir /home/xwzhu/levinson/retro_camal2/visual/AluCand/$sub/AluYa5

### Plotting Alu ###
while read line; do
    chr=$(echo $line|awk '{print $1}')
    beg=$(echo $line|awk '{print $2}')
    end=$(echo $line|awk '{print $3}')
    ./06_plot_all.sh $chr $beg $end $strand $sub $tissue $retro
done < /home/xwzhu/transfer/BulkSeq/$sub/$path/ALU/$tissue.strand$strand.ALU.no$control.1plus.learn.2.filter.calls

