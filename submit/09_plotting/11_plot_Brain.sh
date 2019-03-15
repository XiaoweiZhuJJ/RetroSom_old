masterpath=/home/xwzhu/masterpath
sub=$1
case=$2
cont=$3
workfolder=$4
retro=40
mkdir $masterpath/visual/LINEBrain/$sub\_$case
mkdir $masterpath/visual/ALUBrain/$sub\_$case
mkdir $masterpath/visual/ALUBrain/$sub\_$case/AluYc1
mkdir $masterpath/visual/ALUBrain/$sub\_$case/AluYa5

echo "plotting L1"
retro=41
./12_plot_bulk_LINE_Brain.sh $sub $case $cont $retro\_1 $workfolder
./12_plot_bulk_LINE_Brain.sh $sub $case $cont $retro\_0 $workfolder
echo "plotting Alu"
retro=42
./13_plot_bulk_ALU_Brain.sh $sub $case $cont $retro\_1 $workfolder
./13_plot_bulk_ALU_Brain.sh $sub $case $cont $retro\_0 $workfolder

