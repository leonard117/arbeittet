#!/usr/bin/perl -w
use IO::File;

$sourcepath = $ARGV[0];
$targetpath = $ARGV[1];
print ("source = $sourcepath \n");
print ("target = $targetpath \n");
convertfile($sourcepath,$targetpath);
sub convertfile{
	my($sourcepath,$targetpath,$filesource,$isarg,@sourcelist);# define local variables;
	@sourcelist=();	
	$isarg = @_;
	if ($isarg > 0){
		$sourcepath = $_[0];#source path
		$targetpath = $_[1];#target path
		@sourcelist = read_dir($sourcepath);
		$sourcesize = @sourcelist;
		if ($sourcesize>=1){
			foreach $file(@sourcelist){
				$sfile = "$sourcepath/$file";
				system("mkdir $targetpath/new");
				$tfile = "$targetpath/new/$file";
				changefile($sfile,$tfile);
			}
		}
		
	}else{
		print ("please input source files!");
	}

}
sub changefile{
	my($sourcefile,$targetfile,$isarg,);
	$isarg = @_;
	if ($isarg > 0){
		$sourcefile = $_[0];
		$targetfile = $_[1];
		print("sourcefile = $sourcefile \n");
		print("targetfile = $targetfile \n");
		$s=($sourcefile =~ /^$targetfile$/);
		print ("s = $s \n");
		if ($sourcefile =~ /^$targetfile$/){
			print ("source and target are same!\n");	
			
		}else{
			open(IN,$sourcefile)|| die "cannot open source file \n";
			open(OUT,">$targetfile")|| die "cannot open target file \n";
			while(<IN>){
	
				#print $_;# $_ each line of file.
				#find out context cue <p>
				$str = $_;
				if($str =~ m/<p/){
					#print ("inlude <p..\n");	
				}elsif($str =~ m/\/p>/){
					#print ("inlude /p>\n");	
				}else{
					print OUT $str;	
					#print ("good line!\n");
				}
	
			}#while
			#print "\n";
			close(OUT)|| die "cannot close file \n";
			close(IN)|| die "cannot close file \n";	
		}
	}#if isarg

}#sub
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


