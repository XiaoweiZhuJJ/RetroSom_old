#! /usr/bin/perl -w

use strict;

my $folder  = $ARGV[1];;
my $retro   = 'retro_v40';
my $in_file = $folder.'/'.$ARGV[0].'/'.$retro.'/'.$ARGV[0].'.old.discover';
my $o1_file = $folder.'/'.$ARGV[0].'/'.$retro.'/'.$ARGV[0].'.1.discover';
my $o2_file = $folder.'/'.$ARGV[0].'/'.$retro.'/'.$ARGV[0].'.0.discover';

(open (IN, "<$in_file")) || die "cannot open the in file\n";
(open (O1, ">$o1_file")) || die "cannot open the o1 file\n";
(open (O2, ">$o2_file")) || die "cannot open the o2 file\n";

my ($line, @data, $c1, $c2, $c3, $direction);

while ($line = <IN>)
   {
    chomp($line);
    @data = split("\t", $line);
    $c1 = ($data[5] eq '+') ? 1 : -1;
    $c2 = ($data[6] eq '+') ? 1 : -1;
    $c3 = ($data[15] eq '+') ? 1 : -1;
    $direction = -1 * $c1 * $c2 * $c3;
    if ($direction > 0)
       {
        print O1 "$line\n";
       }
    else
       {
        print O2 "$line\n";
       }
   }


