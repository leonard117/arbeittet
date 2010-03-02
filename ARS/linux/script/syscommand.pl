#!/usr/bin/perl -w

#system("cd ..");
#system("mkdir new");
#system("cd new");
#system("tar -xzvf CMU.tar.gz");
$filesource = "../source/*.z";
system("gzip -d $filesource");
