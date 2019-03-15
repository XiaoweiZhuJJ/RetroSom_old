#! /usr/bin/env perl
#
use strict;
use warnings;
my ($line, @data, %length);

my $mask_file = './hg38.mask.bed';
my $TE = $ARGV[0];
my $strand = $ARGV[1];
my $in_file = './hg38.fa_'.$TE.'_'.$strand.'.bed';
my $ou_file = './hg38.fa_'.$TE.'_'.$strand.'.mask.temp';
my $size_file = '/home/xwzhu/masterpath/refTE/size/hg38.size';

(open (IN, "<$in_file")) || die "cannot open the in file\n";
(open (OU, ">$ou_file")) || die "cannot open the ou file\n";
(open (SIZE, "<$size_file")) || die "cannot open the size file\n";
(open (MASK, "<$mask_file")) || die "cannot open the size file\n";

while ($line = <SIZE>)
   {
    chomp($line);
    @data = split("\t", $line);
    next if ( ($data[0] !~ /chr/) || ($data[0] =~ /\_/) );
    $length{$data[0]} = $data[1];
   }

while ($line = <MASK>)
   {
    chomp($line);
    @data = split("\t", $line);
    next if (!exists($length{$data[0]}));
    $data[1] = ($data[1] > 10) ? ($data[1] - 10) : 0;
    $data[2] = ($data[2] < $length{$data[0]} -10) ? ($data[2] + 10) : $length{$data[0]};
    print OU "$data[0]\t$data[1]\t$data[2]\n";
   }

while ($line = <IN>)
   {
    chomp($line);
    @data = split("\t", $line);
    next if (!exists($length{$data[0]}));
    $data[1] = ($data[1] > 100) ? ($data[1] - 100) : 0;
    $data[2] = ($data[2] < $length{$data[0]} -100) ? ($data[2] + 100) : $length{$data[0]};
    print OU "$data[0]\t$data[1]\t$data[2]\n";
   }

