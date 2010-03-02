#!/usr/bin/perl
use IO::File;
$input = new IO::File;
print ("hello perl! \n");
if($input->open("<test.txt")){
	while(<>){
		print $_;
	}
	


}
$input->close;
