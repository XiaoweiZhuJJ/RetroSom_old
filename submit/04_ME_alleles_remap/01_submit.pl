#! /usr/bin/perl -w

use strict;

### batch submission of jobs to call putative MEIs ###
#### ARGV[0]: output folder to all the subjects ###
my $outpath = $ARGV[0];
#### ARGV[1]: RetroSom version control ###
my $retro = $ARGV[1];
#### ARGV[2]: masterpath ###
my $masterpath = ($ARGV[2] =~ /\w/) ? $ARGV[2] : '~/masterpath';
my $list_file  = $outpath.'/list.txt';
my ($line, @data);
my $count = 0;
my ($name, $tag);

(open (LIST, "<$list_file")) || die "cannot open the list file\n";

while ($line = <LIST>)
    {
     $count ++;
     chomp($line);
     next if ($line =~ /^\#/);
     @data = split("\t", $line);
     system ("sbatch ./02_remap_L1.sh -o $outpath -i $line -m $masterpath -r $retro -g hg38");
     system ("sbatch ./03_remap_Alu.sh -o $outpath -i $line -m $masterpath -r $retro -g hg38");
    }
