TE=ALU
sub=SOM$1\_$2
Retro=retro_v$1\_$2
workfolder=$3
case="$4$6"
control="$5$6"
echo "$case $control"
masterpath=/home/xwzhu/levinson/RetroSom
mkdir $workfolder/$sub
mkdir $workfolder/$sub/$TE

$masterpath/utls/13_postive_support.pl $case\7 $workfolder/$case\7 $Retro
$masterpath/utls/13_postive_support.pl $case\8 $workfolder/$case\8 $Retro
$masterpath/utls/13_postive_support.pl $control\7 $workfolder/$control\7 $Retro
$masterpath/utls/13_postive_support.pl $control\8 $workfolder/$control\8 $Retro
echo "calling combined TE"
$masterpath/ALU/07_Model/RetroSom.ALU.Model.2lib.edit.sh $4 $workfolder $Retro hg38 1 $2 $6
$masterpath/ALU/07_Model/RetroSom.ALU.NoModel.2lib.sh $5 $workfolder $Retro hg38 1 $2 $6

### checking overlap ###
echo "checking overlapping reads"
#$masterpath/utls/17_parse_overlap.pl $1\_$2 ALU $workfolder $4
#$masterpath/utls/17_parse_overlap.pl $1\_$2 ALU $workfolder $5
$masterpath/ALU/05_somatic/05_submit_somatic_2lib.sh $4 $5 $1 $2 $3 $6

