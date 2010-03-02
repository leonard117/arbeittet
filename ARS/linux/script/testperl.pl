#!/usr/bin/perl -w

#$a = "hello";
#$b = "world";
#$c = "$a$b";
#print "$c\n";
$sourcepath = "..//data//source";
$targetpath = "..//data//target";

system("./unpack.pl $sourcepath $targetpath");
system("./convertfile.pl $targetpath $targetpath");
