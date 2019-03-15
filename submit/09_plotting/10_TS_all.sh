masterpath=/home/xwzhu/masterpath
rm -r $masterpath/visual/LINECAND
rm -r $masterpath/visual/ALUCAND

mkdir $masterpath/visual/LINECAND
mkdir $masterpath/visual/ALUCAND

./00_plot.sh TSbrain 4184BA6FA 4184CAP6 /home/xwzhu/transfer
./00_plot.sh TSbrain 4587BA6FA       4587cd_pt /home/xwzhu/transfer
./00_plot.sh TSbrain 4790BA6FA       4790CAP6 /home/xwzhu/transfer
./00_plot.sh TSbrain 5627BA6FA       5627cd_pt /home/xwzhu/transfer
./00_plot.sh TSbrain 5720BA6 5720CD_PT /home/xwzhu/transfer
./00_plot.sh TSbrain 5813BA6FA       5813CD_PT /home/xwzhu/transfer
./00_plot.sh TSbrain 6135BA6FA       6135CD_PT /home/xwzhu/transfer
./00_plot.sh TSbrain 6300BA6FA       6300CD_PT /home/xwzhu/transfer
./00_plot.sh TSbrain 7087BA6FA       7087CD_PT /home/xwzhu/transfer
./00_plot.sh TSbrain 7381BA6FA       7381CD_PT /home/xwzhu/transfer
./00_plot.sh TSbrain 7647BA6FA       7647cd_pt /home/xwzhu/transfer

