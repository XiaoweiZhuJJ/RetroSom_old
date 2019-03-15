TE=ALU
sub=SOM$1\_$2
Retro=retro_v$1\_$2
workfolder=$3
case="$4$6"
control="$5$6"
echo "$case $control"
masterpath=/home/xwzhu/levinson/RetroSom
folder=/home/xwzhu/levinson/retro_camal2/retro_SOM/ALU/05_somatic
mkdir $workfolder/$sub
mkdir $workfolder/$sub/$TE

$masterpath/utls/13_postive_support.pl $case\9 $workfolder/$case\9 $Retro
$masterpath/utls/13_postive_support.pl $case\10 $workfolder/$case\10 $Retro
$masterpath/utls/13_postive_support.pl $case\11 $workfolder/$case\11 $Retro
$masterpath/utls/13_postive_support.pl $case\12 $workfolder/$case\12 $Retro
$masterpath/utls/13_postive_support.pl $case\13 $workfolder/$case\13 $Retro
$masterpath/utls/13_postive_support.pl $case\14 $workfolder/$case\14 $Retro

$masterpath/utls/13_postive_support.pl $control\9 $workfolder/$control\9 $Retro
$masterpath/utls/13_postive_support.pl $control\10 $workfolder/$control\10 $Retro
$masterpath/utls/13_postive_support.pl $control\11 $workfolder/$control\11 $Retro
$masterpath/utls/13_postive_support.pl $control\12 $workfolder/$control\12 $Retro
$masterpath/utls/13_postive_support.pl $control\13 $workfolder/$control\13 $Retro
$masterpath/utls/13_postive_support.pl $control\14 $workfolder/$control\14 $Retro
echo "calling combined TE"
$masterpath/ALU/07_Model/RetroSom.ALU.Model.12lib.edit.sh $4 $workfolder $Retro hg38 1 $2 $6 /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011
$masterpath/ALU/07_Model/RetroSom.ALU.NoModel.12lib.sh $5 $workfolder $Retro hg38 1 $2 $6 /home/xwzhu/transfer/titration/Bulk/1702UNHX-0011

### checking overlap ###
echo "checking overlapping reads"
#$masterpath/utls/17_parse_overlap.pl $1\_$2 ALU $workfolder $4
$masterpath/ALU/05_somatic/05_submit_somatic_12lib.sh $4 $5 $1 $2 $3 $6

