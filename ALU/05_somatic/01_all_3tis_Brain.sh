TE=ALU
sub=Brain$1\_$2
Retro=retro_v$1\_$2
workfolder=$3
astro="$4$7"
neuron="$5$7"
heart="$6$7"
echo "$astro $neuron $heart"
masterpath=/home/xwzhu/masterpath
mkdir $workfolder/$sub
mkdir $workfolder/$sub/$TE

#$masterpath/utls/13_postive_support.pl $astro\1 $workfolder/$astro\1 $Retro
#$masterpath/utls/13_postive_support.pl $astro\2 $workfolder/$astro\2 $Retro
#$masterpath/utls/13_postive_support.pl $astro\3 $workfolder/$astro\3 $Retro
#$masterpath/utls/13_postive_support.pl $astro\4 $workfolder/$astro\4 $Retro
#$masterpath/utls/13_postive_support.pl $astro\5 $workfolder/$astro\5 $Retro
#$masterpath/utls/13_postive_support.pl $astro\6 $workfolder/$astro\6 $Retro

#$masterpath/utls/13_postive_support.pl $neuron\1 $workfolder/$neuron\1 $Retro
#$masterpath/utls/13_postive_support.pl $neuron\2 $workfolder/$neuron\2 $Retro
#$masterpath/utls/13_postive_support.pl $neuron\3 $workfolder/$neuron\3 $Retro
#$masterpath/utls/13_postive_support.pl $neuron\4 $workfolder/$neuron\4 $Retro
#$masterpath/utls/13_postive_support.pl $neuron\5 $workfolder/$neuron\5 $Retro
#$masterpath/utls/13_postive_support.pl $neuron\6 $workfolder/$neuron\6 $Retro

#$masterpath/utls/13_postive_support.pl $heart\1 $workfolder/$heart\1 $Retro
#$masterpath/utls/13_postive_support.pl $heart\2 $workfolder/$heart\2 $Retro
#$masterpath/utls/13_postive_support.pl $heart\3 $workfolder/$heart\3 $Retro
#$masterpath/utls/13_postive_support.pl $heart\4 $workfolder/$heart\4 $Retro
#$masterpath/utls/13_postive_support.pl $heart\5 $workfolder/$heart\5 $Retro
#$masterpath/utls/13_postive_support.pl $heart\6 $workfolder/$heart\6 $Retro
echo "calling combined TE"
$masterpath/ALU/07_Model/RetroSom.ALU.Model.Brain.sh $4 $5 $workfolder $Retro hg38 1 $2 $7

$masterpath/ALU/05_somatic/05_submit_somatic_Brain.sh $4 $6 $1 $2 $3 $7
