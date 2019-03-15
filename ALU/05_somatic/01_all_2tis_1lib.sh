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

$masterpath/utls/13_postive_support.pl $case\15 $workfolder/$case\15 $Retro
$masterpath/utls/13_postive_support.pl $control\15 $workfolder/$control\15 $Retro
echo "calling combined TE"
$masterpath/ALU/07_Model/RetroSom.ALU.Model.1lib.edit.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/ALU/07_Model/RetroSom.ALU.NoModel.1lib.sh $5 $workfolder $Retro hg38 1 $2 $6

### checking overlap ###
echo "checking overlapping reads"
#$masterpath/utls/17_parse_overlap.pl $1\_$2 ALU $workfolder $4
#$masterpath/utls/17_parse_overlap.pl $1\_$2 ALU $workfolder $5
$masterpath/ALU/05_somatic/05_submit_somatic_1lib.sh $4 $5 $1 $2 $3 $6
