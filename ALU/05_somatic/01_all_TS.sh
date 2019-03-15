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

$masterpath/utls/13_postive_support.pl $case $workfolder/$case $Retro
$masterpath/utls/13_postive_support.pl $control $workfolder/$control $Retro
echo "calling combined TE"
$masterpath/ALU/07_Model/RetroSom.ALU.Model.edit.TS.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/ALU/07_Model/RetroSom.ALU.Model.edit.TS.sh $5 $workfolder $Retro hg38 1 $2 $6
$masterpath/ALU/07_Model/RetroSom.ALU.NoModel.TS.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/ALU/07_Model/RetroSom.ALU.NoModel.TS.sh $5 $workfolder $Retro hg38 1 $2 $6

### checking overlap ###
#echo "checking overlapping reads"
#$masterpath/utls/17_parse_overlap.pl $1\_$2 ALU $workfolder $4
#$masterpath/utls/17_parse_overlap.pl $1\_$2 ALU $workfolder $5

$masterpath/ALU/05_somatic/05_submit_somatic_TS.sh $4 $5 $1 $2 $3 $6
$masterpath/ALU/05_somatic/05_submit_somatic_TS.sh $5 $4 $1 $2 $3 $6

