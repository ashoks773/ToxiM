#!/usr/bin/perl
# use strict;
# use warnings;

use Data::Dumper;

my $line1;my $name;my $line2;my $values;my @arr1;my @arr2;
my $hash_l1 = {};
my $file1 = 'Test_data_10per';
my $file2 = 'Total_Desc';

open (IN1, "$file1") || die "Cannot!";
open (IN2, "$file2") || die "Cannot!";
open (OUT, ">Desc_test") || die "Cannot!";

while (chomp(my $line1 = <IN1>))
      {     
           @arr1 = split (",", $line1);
            $name = shift(@arr1);
            $values = join(",", @arr1); #print $values; <stdin>;
            $hash_l1->{$name}=$values;
      } #print Dumper $hash_l1;
while (chomp(my $line2 = <IN2>))    
      { 
             @arr2 = split (",", $line2);
             if (exists($hash_l1->{$arr2[0]}))
                {
                   # print OUT "$line2".","."$hash_l1->{$arr2[0]}\n"; #<stdin>;
                     print OUT "$line2 \n";
                }
      }



                     
              
            
            
             
            
           
