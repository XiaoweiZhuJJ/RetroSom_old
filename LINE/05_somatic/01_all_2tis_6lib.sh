TE=LINE
sub=SOM$1\_$2
Retro=retro_v$1\_$2
workfolder=$3
case="$4$6"
control="$5$6"
echo "$case $control"
masterpath=/home/xwzhu/masterpath
mkdir $workfolder/$sub
mkdir $workfolder/$sub/$TE

$masterpath/utls/12_postive_support.pl $case\1 $workfolder/$case\1 $Retro
$masterpath/utls/12_postive_support.pl $case\2 $workfolder/$case\2 $Retro
$masterpath/utls/12_postive_support.pl $case\3 $workfolder/$case\3 $Retro
$masterpath/utls/12_postive_support.pl $case\4 $workfolder/$case\4 $Retro
$masterpath/utls/12_postive_support.pl $case\5 $workfolder/$case\5 $Retro
$masterpath/utls/12_postive_support.pl $case\6 $workfolder/$case\6 $Retro
$masterpath/utls/12_postive_support.pl $control\1 $workfolder/$control\1 $Retro
$masterpath/utls/12_postive_support.pl $control\2 $workfolder/$control\2 $Retro
$masterpath/utls/12_postive_support.pl $control\3 $workfolder/$control\3 $Retro
$masterpath/utls/12_postive_support.pl $control\4 $workfolder/$control\4 $Retro
$masterpath/utls/12_postive_support.pl $control\5 $workfolder/$control\5 $Retro
$masterpath/utls/12_postive_support.pl $control\6 $workfolder/$control\6 $Retro
echo "calling combined TE"
$masterpath/LINE/07_Model/RetroSom.L1.Model.6lib.edit.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/LINE/07_Model/RetroSom.L1.NoModel.6lib.sh $5 $workfolder $Retro hg38 1 $2 $6
$masterpath/LINE/05_somatic/05_submit_somatic_6lib.sh $4 $5 $1 $2 $3 $6
