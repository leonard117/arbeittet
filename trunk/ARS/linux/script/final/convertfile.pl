#!/usr/bin/perl -w
use IO::File;

use File::Basename;
use PFileOperation;
#$sourcepath = $ARGV[0];
#$targetpath = $ARGV[1];
my $cfgfile =  "./call_toolkit.ini";

my $sourcepath = getparameter($cfgfile,"unpack_path");
my $targetpath = getparameter($cfgfile,"convertfile_path");
print ("source = $sourcepath \n");
print ("target = $targetpath \n");
convertfile($sourcepath,$targetpath);

sub convertfile{
	my($sourcepath,$targetpath,$filesource,$isarg,@sourcelist,$convertfilename);# define local variables;
	@sourcelist=();	
	$isarg = @_;
	if ($isarg > 0){
		$sourcepath = $_[0];#source path
		$targetpath = $_[1];#target path
		@sourcelist = read_dir($sourcepath);
		$sourcesize = @sourcelist;
		if ($sourcesize>=1){
			system("mkdir $targetpath/tmp");
			system("mkdir $targetpath/output");
			foreach $file(@sourcelist){
				$sfile = "$sourcepath/$file";				
				$tfile = "$targetpath/tmp/$file";
				changefile($sfile,$tfile);
			}
			#system("cat $targetpath/tmp/* >$targetpath/output/output.text");
			$convertfilename=getparameter($cfgfile,"convertfile_name");
			system("cat $targetpath/tmp/* >$targetpath/output/$convertfilename");
			system("rm $targetpath/tmp/*");

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
					if($str =~ m/<s/){
						print OUT "<s>\n";	
					#print ("good line!\n");
					}else {
						$str !~ tr/A-Z/a-z/;
						print OUT $str;
					}
				}
	
			}#while
			#print "\n";
			close(OUT)|| die "cannot close file \n";
			close(IN)|| die "cannot close file \n";	
		}
	}#if isarg

}#sub

