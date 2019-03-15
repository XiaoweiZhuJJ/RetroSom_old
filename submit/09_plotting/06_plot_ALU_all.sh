sub=$1
astro=$2
neuron=$3
heart=$4
folder=$5
masterpath=/home/xwzhu/masterpath
mkdir $masterpath/visual/ALUCAND
mkdir $masterpath/visual/ALUCAND/$sub\_$astro
mkdir $masterpath/visual/ALUCAND/$sub\_$neuron
mkdir $masterpath/visual/ALUCAND/$sub\_$heart

mkdir $masterpath/visual/ALUCAND/$sub\_$astro/AluYa5
mkdir $masterpath/visual/ALUCAND/$sub\_$neuron/AluYa5
mkdir $masterpath/visual/ALUCAND/$sub\_$heart/AluYa5

mkdir $masterpath/visual/ALUCAND/$sub\_$astro/AluYb8
mkdir $masterpath/visual/ALUCAND/$sub\_$neuron/AluYb8
mkdir $masterpath/visual/ALUCAND/$sub\_$heart/AluYb8
### ALU plus ###
./05_plot_bulk_ALU.sh $sub $astro $heart 42_1 $folder
./05_plot_bulk_ALU.sh $sub $neuron $heart 42_1 $folder
./05_plot_bulk_ALU.sh $sub $heart $astro 42_1 $folder
./05_plot_bulk_ALU.sh $sub $heart $neuron 42_1 $folder

### ALU Minus ###
./05_plot_bulk_ALU.sh $sub $astro $heart 42_0 $folder
./05_plot_bulk_ALU.sh $sub $neuron $heart 42_0 $folder
./05_plot_bulk_ALU.sh $sub $heart $astro 42_0 $folder
./05_plot_bulk_ALU.sh $sub $heart $neuron 42_0 $folder

