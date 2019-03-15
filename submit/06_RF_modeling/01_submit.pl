#! /usr/bin/perl -w

use strict;

### batch submission of jobs to call putative MEIs ###
### ARGV[0]: output folder to all the subjects ###
my $outpath = $ARGV[0];
### ARGV[1]: RetroSom version control ###
my $retro = $ARGV[1];
### ARGV[2]: masterpath ###
my $masterpath = ($ARGV[2] =~ /\w/) ? $ARGV[2] : '~/masterpath';

system("mkdir $outpath/RF$retro");
system("mkdir $outpath/RF$retro/ALU");
system("mkdir $outpath/RF$retro/LINE");

system("sbatch $masterpath/LINE/02_PE_RF/01.pipe.sh -o $outpath -m $masterpath -r $retro");
system("sbatch $masterpath/LINE/04_SR_RF/01.pipe.sh -o $outpath -m $masterpath -r $retro");
system("sbatch $masterpath/ALU/02_PE_RF/01.pipe.sh -o $outpath -m $masterpath -r $retro");
system("sbatch $masterpath/ALU/04_SR_RF/01.pipe.sh -o $outpath -m $masterpath -r $retro");
