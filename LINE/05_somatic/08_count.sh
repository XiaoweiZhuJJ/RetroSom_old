TE=LINE
sub=SOM$3
tissue=$1
control=$2
Retro=retro_v$3
workfolder=$4

a1=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.1plus.learn.2.calls |awk '{print $1}'`
a2=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.2plus.learn.2.calls |awk '{print $1}'`
a3=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.3plus.learn.2.calls |awk '{print $1}'`
a4=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.4plus.learn.2.calls |awk '{print $1}'`
a5=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.5plus.learn.2.calls |awk '{print $1}'`
a6=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.6plus.learn.2.calls |awk '{print $1}'`
a7=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.7plus.learn.2.calls |awk '{print $1}'`
a8=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.8plus.learn.2.calls |awk '{print $1}'`
a9=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.9plus.learn.2.calls |awk '{print $1}'`
a10=`wc -l $workfolder/$sub/LINE/$tissue.LINE.no$control.10plus.learn.2.calls |awk '{print $1}'`

b1=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.1plus.learn.2.old.discover | sort -u | wc -l`
b2=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.2plus.learn.2.old.discover | sort -u | wc -l`
b3=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.3plus.learn.2.old.discover | sort -u | wc -l`
b4=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.4plus.learn.2.old.discover | sort -u | wc -l`
b5=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.5plus.learn.2.old.discover | sort -u | wc -l`
b6=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.6plus.learn.2.old.discover | sort -u | wc -l`
b7=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.7plus.learn.2.old.discover | sort -u | wc -l`
b8=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.8plus.learn.2.old.discover | sort -u | wc -l`
b9=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.9plus.learn.2.old.discover | sort -u | wc -l`
b10=`awk '{print $(NF-7)"\t"$(NF-6)"\t"$(NF-5)}' $workfolder/$sub/LINE/$tissue\.LINE.no$control\.10plus.learn.2.old.discover | sort -u | wc -l`

echo "$a1 $a2 $a3 $a4 $a5 $a6 $a7 $a8 $a9 $a10"
echo "$b1 $b2 $b3 $b4 $b5 $b6 $b7 $b8 $b9 $b10"

