#!/usr/bin/perl -w

#$a = "hello";
#$b = "world";
#$c = "$a$b";
#print "$c\n";
#$sourcepath = "..//data//source";
#$targetpath = "..//data//target";


use File::Basename;
use PFileOperation;
my $cfgfile =  "./testperl.ini";
$sourcepath =getparameter($cfgfile,"sourcepath");
$targetpath =getparameter($cfgfile,"targetpath");

system("./unpack.pl $sourcepath $targetpath");
system("./convertfile.pl $targetpath $targetpath");
