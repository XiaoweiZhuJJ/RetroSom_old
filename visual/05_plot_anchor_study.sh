chr=$4
cord1=$5
cord2=$6

#fold=/share/diskarray4/MEI/$8
fold=${10}
retro=$9
ref=${11}
png=${12}
hg=${13}
cont=${14}
masterpath=/home/xwzhu/masterpath
rm -r $masterpath/visual/temp
mkdir $masterpath/visual/temp
echo -e $chr"\t"$cord1"\t"$cord2 > $masterpath/visual/temp/00_cord.bed

module load perl-scg/1.0
module load perl-scg/5.14.4
module load samtools
module load bedtools

$masterpath/visual/01_pick_sites.sh $fold/$1/$retro/$2/$1.$2.noref.calls
$masterpath/visual/02_support_sites_alignment.pl $fold/$1/$retro/$2/$1.$2.novel.sites $fold/$1/$retro/$1.$2.sr.tabe.discover $2 
$masterpath/visual/03_align_reads.sh $ref
$masterpath/visual/04_TE_visual_addSR.pl $1__no$cont\__$2__$4__$5.$7.png $chr $7 $png $hg 
