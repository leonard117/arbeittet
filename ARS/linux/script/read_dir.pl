#!/usr/bin/perl -w
#read dir
$dirname = "./";
opendir(DIR,$dirname)||die "can not open dir $dirname!";
while (defined($file = readdir(DIR))){
	print $file;
	print "\n";
}
closedir(DIR)||die "can not close dir";
