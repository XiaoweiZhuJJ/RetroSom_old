TE=LINE
Retro=retro_v$1\_$2
workfolder=$3
case="$4$7"
control="$5$7"
lib=$6
echo "$case $control"
masterpath=/home/xwzhu/levinson/RetroSom

$masterpath/utls/12_postive_support.pl $case$lib $workfolder/$case$lib $Retro
$masterpath/utls/12_postive_support.pl $control$lib $workfolder/$control$lib $Retro
echo "calling combined TE"
$masterpath/LINE/07_Model/RetroSom.L1.Model.PCR.sh $4 $workfolder $Retro hg38 1 $2 $lib $7
$masterpath/LINE/07_Model/RetroSom.L1.Model.PCR.sh $5 $workfolder $Retro hg38 1 $2 $lib $7
$masterpath/LINE/07_Model/RetroSom.L1.NoModel.PCR.sh $4 $workfolder $Retro hg38 1 $2 $lib $7
$masterpath/LINE/07_Model/RetroSom.L1.NoModel.PCR.sh $5 $workfolder $Retro hg38 1 $2 $lib $7
