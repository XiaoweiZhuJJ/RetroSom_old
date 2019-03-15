#! /usr/bin/perl -w

use strict;

my $FILTER = 1;
my $CUT_map = 95;
my $sample = $ARGV[0];
my $workfolder = $ARGV[2];
my $retro = 'retro_v'.$ARGV[1];
my $m1_file = $workfolder.'/'.$sample.'/'.$retro.'_0/'.$sample.'.sr.ALU.matrix.pAT';
my $m2_file = $workfolder.'/'.$sample.'/'.$retro.'_1/'.$sample.'.sr.ALU.matrix.pAT';
my $g1_file  = $workfolder.'/'.$sample.'/'.$retro.'_1/ALU/'.$sample.'.sr.pred.T1.txt';
my $ou1_file = $workfolder.'/'.$sample.'/'.$retro.'_0/ALU/'.$sample.'.sr2.pred.all.filter'.$FILTER.'.txt';
my $ou2_file = $workfolder.'/'.$sample.'/'.$retro.'_0/ALU/'.$sample.'.sr2.pred.filter'.$FILTER.'.summary';
my $ou3_file = $workfolder.'/'.$sample.'/'.$retro.'_1/ALU/'.$sample.'.sr2.pred.all.filter'.$FILTER.'.txt';
my $ou4_file = $workfolder.'/'.$sample.'/'.$retro.'_1/ALU/'.$sample.'.sr2.pred.filter'.$FILTER.'.summary';
my @order = (1); 
my ($line, @data, %pred1, $direction);
my ($i, $pred, $id, $pos, $neg, $g1);
print "$sample\n";
(open (M1, "<$m1_file")) || die "cannot open the mat file\n";
(open (M2, "<$m2_file")) || die "cannot open the mat file\n";
(open (G1, "<$g1_file")) || die "cannot open the g1 file $g1_file\n";
while ($line = <G1>)
   {
    chomp($line);
    @data = split("\t",$line);
    $pred1{$data[0]."\t".$data[1]."\t".$data[2]."\t".$data[3]} = $data[4];
   }

(open (OU1, ">$ou1_file")) || die "cannot open the out file\n";
(open (OU2, ">$ou2_file")) || die "cannot open the out file\n";
(open (OU3, ">$ou3_file")) || die "cannot open the out file\n";
(open (OU4, ">$ou4_file")) || die "cannot open the out file\n";

print OU1 "chr\tcord1\tcord2\tread\tpos\tneg\tG1\n";
<M1>;
while ($line = <M1>)
   {
    chomp($line);
    @data = split("\t", $line);
    $direction = $data[27];
    if ( (($data[6] == 1) || ($data[7] == 1)) && ($data[13] == 0) )
       {
        if ($FILTER)
           {
            next if ( ($data[12] < $CUT_map) || ($data[26] == 1) );
           }
        $id = $data[0]."\t".$data[1]."\t".$data[2]."\t".$data[3];
        $pos = $data[6];
        $neg = $data[7];
        $g1 = (exists($pred1{$id})) ? $pred1{$id} : 'NA';
        print OU1 "$id\t$direction\t$pos\t$neg\t$g1\n";
       }
   }

print OU3 "chr\tcord1\tcord2\tread\tpos\tneg\tG1\n";
<M2>;
while ($line = <M2>)
   {
    chomp($line);
    @data = split("\t", $line);
    $direction = $data[27];
    if ( (($data[6] == 1) || ($data[7] == 1)) && ($data[13] == 0) )
       {
        if ($FILTER)
           {
            next if ( ($data[12] < $CUT_map) || ($data[26] == 1) );
           }
        $id = $data[0]."\t".$data[1]."\t".$data[2]."\t".$data[3];
        $pos = $data[6];
        $neg = $data[7];
        $g1 = (exists($pred1{$id})) ? $pred1{$id} : 'NA';
        print OU3 "$id\t$direction\t$pos\t$neg\t$g1\n";
       }
   }
close(OU1);
close(OU3);
(open (OU1, "<$ou1_file")) || die "cannot open the out file\n";
(open (OU3, "<$ou3_file")) || die "cannot open the out file\n";

my ($pos_0, $pos_1, $pos_na, $pos_total, $neg_0, $neg_1, $neg_na, $neg_total, $recall, $precision);
my ($basep_0, $basep_1, $basep_na, $basen_0, $basen_1, $basen_na, $base_recall, $base_precision);
my ($rnd_recall, $rnd_precision);
my %usage = (
   '1' => 0,
  ); 
$pos_0=$pos_1=$pos_na=$neg_0=$neg_1=$neg_na=$pos_total=$neg_total=0;
$basep_0=$basep_1=$basep_na=$basen_0=$basen_1=$basen_na=0;

<OU1>;
while ($line = <OU1>)
   {
    chomp($line);
    @data = split("\t", $line);
    $pred = 'NA';
    for ($i=0; $i<=$#order; $i++)
       {
        if ($data[6+$order[$i]] ne 'NA')
           {
            $usage{$order[$i]} ++;
            $pred = ($data[6+$order[$i]] > 0.5) ? 1 : 0;
            last; 
           }
       }
    if ($data[5] == 1)
       {
        $pos_0 ++ if ($pred eq '0');
        $pos_1 ++ if ($pred eq '1');
        $pos_na++ if ($pred eq 'NA');
        if ($data[7] eq 'NA')
           {
            $basep_na++;
           }
        else
           {
            $basep_0 ++ if ($data[7] <= 0.5);
            $basep_1 ++ if ($data[7] >  0.5);
           }
        $pos_total++;
       }
    elsif ($data[5] == 0)
       {
        $neg_0 ++ if ($pred eq '0');
        $neg_1 ++ if ($pred eq '1');
        $neg_na++ if ($pred eq 'NA');
        if ($data[7] eq 'NA')
           {
            $basen_na++;
           }
        else
           {
            $basen_0 ++ if ($data[7] <= 0.5);
            $basen_1 ++ if ($data[7] >  0.5);
           }
        $neg_total++;
       }
    print OU2 "$line\t$pred\n";
   }

%usage = (
   '1' => 0,
  );
$pos_0=$pos_1=$pos_na=$neg_0=$neg_1=$neg_na=$pos_total=$neg_total=0;
$basep_0=$basep_1=$basep_na=$basen_0=$basen_1=$basen_na=0;

<OU3>;
while ($line = <OU3>)
   {
    chomp($line);
    @data = split("\t", $line);
    $pred = 'NA';
    for ($i=0; $i<=$#order; $i++)
       {
        if ($data[6+$order[$i]] ne 'NA')
           {
            $usage{$order[$i]} ++;
            $pred = ($data[6+$order[$i]] > 0.5) ? 1 : 0;
            last;
           }
       }
    if ($data[5] == 1)
       {
        $pos_0 ++ if ($pred eq '0');
        $pos_1 ++ if ($pred eq '1');
        $pos_na++ if ($pred eq 'NA');
        if ($data[7] eq 'NA')
           {
            $basep_na++;
           }
        else
           {
            $basep_0 ++ if ($data[7] <= 0.5);
            $basep_1 ++ if ($data[7] >  0.5);
           }
        $pos_total++;
       }
    elsif ($data[5] == 0)
       {
        $neg_0 ++ if ($pred eq '0');
        $neg_1 ++ if ($pred eq '1');
        $neg_na++ if ($pred eq 'NA');
        if ($data[7] eq 'NA')
           {
            $basen_na++;
           }
        else
           {
            $basen_0 ++ if ($data[7] <= 0.5);
            $basen_1 ++ if ($data[7] >  0.5);
           }
        $neg_total++;
       }
    print OU4 "$line\t$pred\n";
   }
