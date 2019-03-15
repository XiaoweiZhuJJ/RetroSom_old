masterpath=/home/xwzhu/masterpath
#$masterpath/visual/05_plot_anchor_study.sh \
#   $5\_Model ALU ALU $1 $2 $3 AluYb8 TITR $6 $7 $masterpath/refTE/sequence/AluYc1.fa ALUCAND/$4\_$5/AluYb8 hg38 $8

#$masterpath/visual/05_plot_anchor_study.sh \
#   $5\_Model ALU ALU $1 $2 $3 AluYa5 TITR $6 $7 $masterpath/refTE/sequence/AluYa5.fa ALUCAND/$4\_$5/AluYa5 hg38 $8

#$masterpath/visual/05_plot_anchor_study.sh \
#   $5\_Brain ALU ALU $1 $2 $3 AluYa5 TITR $6 $7 $masterpath/refTE/sequence/AluYa5.fa ALUBrain/$4\_$5/AluYa5 hg38 $8

mkdir $masterpath/visual/ALUShare/$4\_$5
$masterpath/visual/05_plot_anchor_study.sh \
   $5\_Model ALU ALU $1 $2 $3 AluYa5 TITR $6 $7 $masterpath/refTE/sequence/AluYa5.fa ALUShare/$4\_$5 hg38 $8
