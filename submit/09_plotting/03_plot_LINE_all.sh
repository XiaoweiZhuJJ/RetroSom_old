sub=$1
astro=$2
neuron=$3
heart=$4
folder=$5
masterpath=/home/xwzhu/masterpath
mkdir $masterpath/visual/LINECAND
mkdir $masterpath/visual/LINECAND/$sub\_$astro
mkdir $masterpath/visual/LINECAND/$sub\_$neuron
mkdir $masterpath/visual/LINECAND/$sub\_$heart
### LINE plus ###
./02_plot_bulk_LINE.sh $sub $astro $heart 41_1 $folder
./02_plot_bulk_LINE.sh $sub $neuron $heart 41_1 $folder
./02_plot_bulk_LINE.sh $sub $heart $astro 41_1 $folder
./02_plot_bulk_LINE.sh $sub $heart $neuron 41_1 $folder

### LINE Minus ###
./02_plot_bulk_LINE.sh $sub $astro $heart 41_0 $folder
./02_plot_bulk_LINE.sh $sub $neuron $heart 41_0 $folder
./02_plot_bulk_LINE.sh $sub $heart $astro 41_0 $folder
./02_plot_bulk_LINE.sh $sub $heart $neuron 41_0 $folder

