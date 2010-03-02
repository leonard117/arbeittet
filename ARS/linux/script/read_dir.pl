#!/usr/bin/perl -w
#read dir
$dir_name = "..//data//source";
@ar = read_dir($dir_name);
$a = @ar;
print ("$a \n");
print ("@ar \n");
sub read_dir{
	my($dirname,$isarg,$file);# define local variables;
	@filelist=();
	$dirname = "none";
	$isarg = @_;
	if ($isarg > 0){
		
		$dirname = $_[0];
		print ("dirname = ");
		print ("$dirname\n");
		opendir(DIR,$dirname)||die "can not open dir $dirname!";
		while (defined($file = readdir(DIR))){
			next if $file =~ /^\.\.?$/; # skip . and ..
			print $file;
			print "\n";
			push(@filelist,$file);
			
		}
		closedir(DIR)||die "can not close dir";
			
	}
	return @filelist;
}

