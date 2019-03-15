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

$masterpath/utls/12_postive_support.pl $case $workfolder/$case $Retro
$masterpath/utls/12_postive_support.pl $control $workfolder/$control $Retro
echo "calling combined TE"
$masterpath/LINE/07_Model/RetroSom.L1.Model.edit.TS.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/LINE/07_Model/RetroSom.L1.Model.edit.TS.sh $5 $workfolder $Retro hg38 1 $2 $6
$masterpath/LINE/07_Model/RetroSom.L1.NoModel.TS.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/LINE/07_Model/RetroSom.L1.NoModel.TS.sh $5 $workfolder $Retro hg38 1 $2 $6

$masterpath/LINE/05_somatic/05_submit_somatic_TS.sh $4 $5 $1 $2 $3 $6
$masterpath/LINE/05_somatic/05_submit_somatic_TS.sh $5 $4 $1 $2 $3 $6
