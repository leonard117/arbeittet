#!/usr/bin/perl -w
use IO::File;
open(IN,"test.txt")|| die "cannot open file \n";
open(OUT,">new.txt")|| die "cannot open file \n";
$record = 0;
while(<IN>){
	#$record = $record+1;
	#print $record;
	print $_;# $_ each line of file.
	#find out context cue <p>
	$str = $_;
	if($str =~ m/<p/){
		print ("inlude <p..\n");	
	}elsif($str =~ m/\/p>/){
			print ("inlude /p>\n");	
	}else{
		print OUT $str;	
		print ("good line!\n");
			
	}
	
}
print "\n";
close(OUT)|| die "cannot close file \n";
close(IN)|| die "cannot close file \n";
