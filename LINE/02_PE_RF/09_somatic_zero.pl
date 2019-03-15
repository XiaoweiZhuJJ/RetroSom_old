#!/usr/bin/perl -w

use strict;

### module load bedtools ###

my %TE = (
#  'ALU'   => 1,
  'LINE'  => 1,
  );
my $list_file = '/home/xwzhu/transfer/titration/all.txt';
my $temp_file = './zero.txt';
my (@data, @sample, @calls, @match, %out);
my ($i, $j, $k, $TE, $line);
my ($out_file, $call_file);
my $cutoff = $ARGV[0];

(open (LIST, "<$list_file")) || die "cannot open the list file\n";

$i = 0;
while ($line = <LIST>)
   {
    chomp($line);
    next if ($line =~ /\#/);
    $sample[$i++] = $line;
   }

    for $TE(keys %TE)
       {
        $call_file = '/home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR/LINE/TITR.LINE.noCONT.learn.'.$cutoff.'.calls';
        
        (open (CALL, "<$call_file")) || die "cannot open the CALL file\n";
        $j = 0;
        while ($line = <CALL>)
            {
             chomp($line);
             @data = split("\t", $line);
             $calls[$i]{$TE}[$j++] = $line; # $data[0]."\t".$data[1]."\t".$data[2];
            }
        @match = ();
        for ($k=0; $k<=$#sample; $k++)
            {
             if ( ($sample[$k] =~ /CONT\_/) || ($sample[$k] =~ /TITR\_/) )
                {
                 $temp_file = '/home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/'.$sample[$k].'/retro_v14/'.$TE.'/'.$sample[$k].'.'.$TE.'.nodup.calls';
                }
             elsif ( ($sample[$k] eq 'Astro_1') || ($sample[$k] eq 'Heart_1') || ($sample[$k] eq 'Neuron_1') )
                {
                 $temp_file = '/home/xwzhu/transfer/BulkSeq/adult/'.$sample[$k].'/retro_v14/'.$TE.'/'.$sample[$k].'.'.$TE.'.nodup.calls';
                }
             else
                {
                 $temp_file = '/home/xwzhu/transfer/titration/'.$sample[$k].'/retro_v14/'.$TE.'/'.$sample[$k].'.'.$TE.'.nodup.calls';
                }
     
             $out_file = './zero.out';             
             system("rm $out_file");
             %out = ();
             system("windowBed -w 300 -a $call_file -b $temp_file > $out_file");
            
             (open (OUT, "<$out_file")) || die "cannot open the out file\n";
             while ($line = <OUT>)
                {
                 chomp($line);
                 @data = split("\t", $line);
                 $line = $data[0]."\t".$data[1]."\t".$data[2]; #."\t".$data[3]."\t".$data[4]."\t".$data[5]."\t".$data[6]."\t".$data[7];
                 if (!exists($out{$line}))
                    {                 
                     $out{$line} = $data[7];
                    }
                 else
                    {
                     $out{$line} = ($out{$line} > $data[7]) ? $out{$line} : $data[7];
                    }
                }
             for ($j=0; $j<=$#{$calls[$i]{$TE}}; $j++)
                { 
                 $match[$j][$k] = (exists $out{$calls[$i]{$TE}[$j]}) ? $out{$calls[$i]{$TE}[$j]} : 0;
                }
            }
        $out_file = '/home/xwzhu/transfer/titration/Bulk/1702UNHX-0011/TITR/LINE/TITR.LINE.noCONT.learn.'.$cutoff.'.matrix';
        (open (OUT, ">$out_file")) || die "cannot open the out file\n";
        print OUT "chr\tcord1\tcord2";
        for ($k=0; $k<=$#sample; $k++)
           {
            print OUT "\t$sample[$k]";
           }
        print OUT "\n";
        for($j=0; $j<=$#{$calls[$i]{$TE}}; $j++)
           {
            @data = split("\t", $calls[$i]{$TE}[$j]);
            print OUT "$data[0]\t$data[1]\t$data[2]";
            for ($k=0; $k<=$#sample; $k++)
               {
                print OUT "\t$match[$j][$k]";
               }
            print OUT "\n";
            }
         }

