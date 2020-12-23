#!/usr/bin/perl 
##################### usages  perl mean.pl columnefile     [column file may be aac or dpc comma seperated file]
if($ARGV[0] eq ""){print"\n\n@@@@@@@@@@@@@@@@ usages  perl mean.pl columnefile  row/col   [column file may be aac or dpc comma seperated file]  \n@@@@@@@@@@@@@@@@  use at your own risk :)\n\n";exit;}

$path=`pwd`;chomp $path;
open (FX,">>mean.R");
print FX "a<-read.csv(\"$path\/$ARGV[0]\", header=FALSE)\n";
print FX "amed<-apply(a,2,mean)\n";
if($ARGV[1] =~ "row"){print FX "amed<-round(apply(a,1,mean), digits=3)\n";}
if($ARGV[1] =~ "col"){print FX "amed<-round(apply(a,2,mean), digits=3)\n";}

print FX "write.csv(amed,\"$path\/$ARGV[0]\_outt\")\n";
close FX;

system "R CMD BATCH mean.R";
system "grep -v \"x\" $ARGV[0]\_outt > $ARGV[0]\_outt1";
system "cut -d \",\" -f2 $ARGV[0]\_outt1 \> $ARGV[0]\_mean";

system "rm *Rout $ARGV[0]\_outt* mean.R";

if($ARGV[1] =~ "col"){system "perl -pi -e \"s\/\\n\/,\/g\" $ARGV[0]\_mean;";}
if($ARGV[1] =~ "col"){system "perl -pi -e \"s\/,\$\/\\n\/g\" $ARGV[0]\_mean;";}

