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

$masterpath/utls/12_postive_support.pl $case\7 $workfolder/$case\7 $Retro
$masterpath/utls/12_postive_support.pl $case\8 $workfolder/$case\8 $Retro
$masterpath/utls/12_postive_support.pl $control\7 $workfolder/$control\7 $Retro
$masterpath/utls/12_postive_support.pl $control\8 $workfolder/$control\8 $Retro
echo "calling combined TE"
$masterpath/LINE/07_Model/RetroSom.L1.Model.2lib.edit.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/LINE/07_Model/RetroSom.L1.NoModel.2lib.sh $5 $workfolder $Retro hg38 1 $2 $6

$masterpath/LINE/05_somatic/05_submit_somatic_2lib.sh $4 $5 $1 $2 $3 $6
