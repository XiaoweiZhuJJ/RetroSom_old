#! /usr/bin/perl -w

use strict;

### perl script to submit a batch of subjects ###
### To discover putative MEI supporting reads (based on Retroseq), or ###
### to seperate supporting reads from different strands ###
my $outpath = $ARGV[0]; ### path to the list of subjects and output folders ###
my $ver = $ARGV[1];  ### version control of RetroSom ###
my $masterpath = $ARGV[2]; ### masterpath to the RetroSom folder ###
my $list_file = $outpath.'/list.txt'; ### list of all data files ###
my ($line, @data);

(open (LIST, "<$list_file")) || die "cannot open the list file\n";
while ($line = <LIST>)
    {
     ### submit one data file at a time ###
     chomp($line);
     next if ($line =~ /^\#/);
     system("./02_discover.sh -i $line -o $outpath -r $ver -m $masterpath"); ### discover candidate MEI supporting reads ###
     #system("sbatch ./03_splitDIS.sh -i $line -o $outpath -r $ver -m $masterpath"); ### seperate supporting reads for + strand and - strand insertions ### 
    }
