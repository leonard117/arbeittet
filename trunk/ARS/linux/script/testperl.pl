#!/usr/bin/perl -w

#$a = "hello";
#$b = "world";
#$c = "$a$b";
#print "$c\n";
#$sourcepath = "..//data//source";
#$targetpath = "..//data//target";
#system("./unpack.pl $sourcepath $targetpath");
#system("./convertfile.pl $targetpath $targetpath");

@A=("e1","e2");
$ra=[@A];
print $ra->[0],"\n";
$ra=\@A;
print $ra->[1],"\n";
