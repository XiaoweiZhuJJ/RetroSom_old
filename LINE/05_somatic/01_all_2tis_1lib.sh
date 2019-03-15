TE=LINE
sub=SOM$1\_$2
Retro=retro_v$1\_$2
workfolder=$3
case="$4$6"
control="$5$6"
echo "$case $control"
masterpath=/home/xwzhu/levinson/RetroSom
mkdir $workfolder/$sub
mkdir $workfolder/$sub/$TE

$masterpath/utls/12_postive_support.pl $case\15 $workfolder/$case\15 $Retro
$masterpath/utls/12_postive_support.pl $control\15 $workfolder/$control\15 $Retro
echo "calling combined TE"
$masterpath/LINE/07_Model/RetroSom.L1.Model.1lib.1lib.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/LINE/07_Model/RetroSom.L1.NoModel.1lib.sh $5 $workfolder $Retro hg38 1 $2 $6
$masterpath/LINE/05_somatic/05_submit_somatic_1lib.sh $4 $5 $1 $2 $3 $6
