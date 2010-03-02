#!/usr/bin/perl -w
#unpack .z file in sourcepath and copy into targetpath 

$sourcepath = $ARGV[0];
$targetpath = $ARGV[1];
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
