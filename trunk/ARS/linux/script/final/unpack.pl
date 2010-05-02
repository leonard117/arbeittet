#!/usr/bin/perl -w
use strict;
use File::Basename;
use PFileOperation;
#$sourcepath = $ARGV[0];
#$targetpath = $ARGV[1];
my $cfgfile =  "./call_toolkit.ini";
my $sourcepath = getparameter($cfgfile,"zsource_path");
my $targetpath = getparameter($cfgfile,"unpack_path");

$sourcepath || die "sp empty!";
$targetpath || die "tp empty!";
print ("source = $sourcepath \n");
print ("target = $targetpath \n");

#$sourcepath = "..//data//source//*.z";
#$targetpath = "..//data//target";
system("cp $sourcepath//*.z $targetpath");
unpack_file("$targetpath//*.z");

sub unpack_file {
	my($filesource,$isarg); # define local variables
	#$filesource = ();
	#$isarg = ();
	$isarg = @_;
	if ($isarg > 0){
		
		$filesource = $_[0];
		#print $filesource;
		system("gzip -d $filesource");	
	}else{
		print ("please input source files!");
	}
	return -1;
}
#unpack_file($targetpath);
