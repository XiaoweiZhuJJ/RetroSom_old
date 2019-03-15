#!/usr/bin/perl -w

use strict;

my $list_file = $ARGV[0].'/list.txt';
my $line;

(open (LIST, "<$list_file")) || die "cannot open the list file\n";

while ($line = <LIST>)
    {
     chomp($line);
     next if ($line =~ /^\#/);
     system("qsub /home/xwzhu/levinson/retro_camal2/retro_SOM/LINE/05_somatic/03_splitDIS.sh $line $ARGV[0]");
    }
