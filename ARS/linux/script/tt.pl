#perl

use IO::FIle;
$fh = new IO::File;
$fout = new IO::File;

if ($fh->open("<test.txt")){
	
	if($fout->open(">new.txt")) {
		
		$str = <$fh>;
		#if($str=! m/^(<p)/){
			chomp($str);
			print $fout $str;	
		#}
		
		$fout->close;
	}
	
	print <$fh>;
	$fh->close;
}
print "\n";
print "hallo \n";

print "~m";
print "\n";
$scalarName="all";
$scalarName =~ s/a/b/;
print $scalarName; 
print "\n";
$a = "<p......>hello";
$a =~ /^he/; 
if($a =~ /^(<p)/){
	$a =~ s/<p.+>//;
	print $a;
}