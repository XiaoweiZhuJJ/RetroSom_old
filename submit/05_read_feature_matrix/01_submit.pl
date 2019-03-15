#! /usr/bin/perl -w

use strict;

### batch submission of jobs to call putative MEIs ###
### ARGV[0]: output folder to all the subjects ###
my $outpath = $ARGV[0];
### ARGV[1]: RetroSom version control ###
my $retro = $ARGV[1];
### ARGV[2]: masterpath ###
my $masterpath = ($ARGV[2] =~ /\w/) ? $ARGV[2] : '~/masterpath';
my $list_file = $outpath.'/list.txt';
(open (LIST, "<$list_file")) || die "cannot open the list file\n";

my ($sub, $line, @data);

while ($line = <LIST>)
   {
    chomp($line);
    next if ($line =~ /^\#/);
    @data = split("\t", $line);
    print "$data[0]\n";
    $sub = $data[0];
    system("sbatch $masterpath/LINE/01_PE_matrix/02_matrix_gen.sh -o $outpath -i $sub -m $masterpath -r $retro -g hg38 -s 0");
    system("sbatch $masterpath/LINE/01_PE_matrix/02_matrix_gen.sh -o $outpath -i $sub -m $masterpath -r $retro -g hg38 -s 1");
    system("sbatch $masterpath/LINE/03_SR_matrix/02_matrix_gen.sh -o $outpath -i $sub -m $masterpath -r $retro -g hg38 -s 0");
    system("sbatch $masterpath/LINE/03_SR_matrix/02_matrix_gen.sh -o $outpath -i $sub -m $masterpath -r $retro -g hg38 -s 1");
    system("sbatch $masterpath/ALU/01_PE_matrix/02_matrix_gen.sh -o $outpath -i $sub -m $masterpath -r $retro -g hg38 -s 0");
    system("sbatch $masterpath/ALU/01_PE_matrix/02_matrix_gen.sh -o $outpath -i $sub -m $masterpath -r $retro -g hg38 -s 1");
    system("sbatch $masterpath/ALU/03_SR_matrix/02_matrix_gen.sh -o $outpath -i $sub -m $masterpath -r $retro -g hg38 -s 0");
    system("sbatch $masterpath/ALU/03_SR_matrix/02_matrix_gen.sh -o $outpath -i $sub -m $masterpath -r $retro -g hg38 -s 1");
   }
