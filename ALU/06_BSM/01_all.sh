TE=ALU
sub=SOM$1\_$2
Retro=retro_v$1\_$2
workfolder=/home/xwzhu/transfer/BSM
pipefolder=/home/xwzhu/levinson/retro_camal2/bin
comfolder=/home/xwzhu/levinson/retro_camal2/strand_specific
folder=/home/xwzhu/levinson/retro_camal2/retro_SOM/ALU/06_BSM
mkdir $workfolder/BSM_bulk/$sub
mkdir $workfolder/BSM_bulk/$sub/$TE
mkdir $workfolder/fibroblasts/$sub
mkdir $workfolder/fibroblasts/$sub/$TE

$comfolder/13_postive_support.pl bulk1 $workfolder/BSM_bulk/bulk1 $Retro
$comfolder/13_postive_support.pl bulk2 $workfolder/BSM_bulk/bulk2 $Retro
$comfolder/13_postive_support.pl bulk3 $workfolder/BSM_bulk/bulk3 $Retro
$comfolder/13_postive_support.pl bulk4 $workfolder/BSM_bulk/bulk4 $Retro
$comfolder/13_postive_support.pl bulk5 $workfolder/BSM_bulk/bulk5 $Retro
$comfolder/13_postive_support.pl bulk6 $workfolder/BSM_bulk/bulk6 $Retro

$comfolder/13_postive_support.pl fibroblasts1 $workfolder/fibroblasts/fibroblasts1 $Retro
$comfolder/13_postive_support.pl fibroblasts2 $workfolder/fibroblasts/fibroblasts2 $Retro
$comfolder/13_postive_support.pl fibroblasts3 $workfolder/fibroblasts/fibroblasts3 $Retro
$comfolder/13_postive_support.pl fibroblasts4 $workfolder/fibroblasts/fibroblasts4 $Retro
$comfolder/13_postive_support.pl fibroblasts5 $workfolder/fibroblasts/fibroblasts5 $Retro
$comfolder/13_postive_support.pl fibroblasts6 $workfolder/fibroblasts/fibroblasts6 $Retro

echo "calling combined TE"
$pipefolder/retroseq.camal.ALU.model.sh bulk $workfolder/BSM_bulk $Retro hg38 1 $2
$pipefolder/retroseq.camal.ALU.model.sh fibroblasts $workfolder/fibroblasts $Retro hg38 1 $2

$pipefolder/retroseq.camal.ALU.nomodel.sh bulk $workfolder/BSM_bulk $Retro hg38 1 $2
$pipefolder/retroseq.camal.ALU.nomodel.sh fibroblasts $workfolder/fibroblasts $Retro hg38 1 $2

echo "split old discover"
#$folder/02_submit_split.pl $workfolder/BSM_bulk
#$folder/02_submit_split.pl $workfolder/fibroblasts

### checking overlap ###
echo "checking overlapping reads"
/home/xwzhu/levinson/retro_camal2/retro_SOM/03_train/overlap/01_parse_overlap.pl $1\_$2 ALU $workfolder/BSM_bulk bulk
/home/xwzhu/levinson/retro_camal2/retro_SOM/03_train/overlap/01_parse_overlap.pl $1\_$2 ALU $workfolder/fibroblasts fibroblasts

$folder/05_submit_somatic.sh fibroblasts bulk $1 $2 $workfolder/fibroblasts $workfolder/BSM_bulk
$folder/05_submit_somatic.sh bulk fibroblasts $1 $2 $workfolder/BSM_bulk $workfolder/fibroblasts
