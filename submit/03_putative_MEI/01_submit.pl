#! /usr/bin/perl -w

use strict;
### batch submission of jobs to call putative MEIs ###
### ARGV[0]: output folder to all the subjects ###
my $outpath = $ARGV[0];
### ARGV[1]: RetroSom version control ###
my $retro = $ARGV[1];
### ARGV[2]: masterpath ###
my $masterpath = ($ARGV[2] =~ /\w/) ? $ARGV[2] : '~/masterpath';
### human reference genome version ###
my $hg = 'hg38';
my $list_file = $outpath.'/list.txt';  ### list file in the outpath ### 
(open (LIST, "<$list_file")) || die "cannot open the list file\n";
my ($line, $sub, @data);

while ($line = <LIST>)
   {
    ### submit one data file at a time ###
    chomp($line);
    @data = split("\t", $line);
    $sub = $data[0];
    #system("sbatch ./02_preprocess.sh -o $outpath -i $sub -m $masterpath -r $retro -g $hg"); ### filtering likely fase positive supporting reads ###
    system("sbatch ./03_call_putative_MEI.sh -o $outpath -i $sub -m $masterpath -r $retro -g $hg -s 0 -f 1"); ### call putative meis in - strand ###
    #system("sbatch ./03_call_putative_MEI.sh -o $outpath -i $sub -m $masterpath -r $retro -g $hg -s 1 -f 1"); ### call putative MEIs in + strand ###
    last;
   }

