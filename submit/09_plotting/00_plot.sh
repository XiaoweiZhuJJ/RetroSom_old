masterpath=/home/xwzhu/masterpath
sub=$1
case=$2
cont=$3
workfolder=$4
retro=40
mkdir $masterpath/visual/LINECAND/$sub\_$case
mkdir $masterpath/visual/ALUCAND/$sub\_$case
mkdir $masterpath/visual/ALUCAND/$sub\_$case/AluYc1
mkdir $masterpath/visual/ALUCAND/$sub\_$case/AluYa5
mkdir $masterpath/visual/LINECAND/$sub\_$cont
mkdir $masterpath/visual/ALUCAND/$sub\_$cont
mkdir $masterpath/visual/ALUCAND/$sub\_$cont/AluYc1
mkdir $masterpath/visual/ALUCAND/$sub\_$cont/AluYa5

echo "plotting L1"
./02_plot_bulk_LINE.sh $sub $case $cont $retro\_1 $workfolder
./02_plot_bulk_LINE.sh $sub $case $cont $retro\_0 $workfolder
./02_plot_bulk_LINE.sh $sub $cont $case $retro\_1 $workfolder
./02_plot_bulk_LINE.sh $sub $cont $case $retro\_0 $workfolder
echo "plotting Alu"
./05_plot_bulk_ALU.sh $sub $case $cont $retro\_1 $workfolder
./05_plot_bulk_ALU.sh $sub $case $cont $retro\_0 $workfolder
./05_plot_bulk_ALU.sh $sub $cont $case $retro\_1 $workfolder
./05_plot_bulk_ALU.sh $sub $cont $case $retro\_0 $workfolder

