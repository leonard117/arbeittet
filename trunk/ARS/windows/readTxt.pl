

use IO::FIle;
$fout = new IO::File;
if($fout->open(">new.txt")) {
	while($str=<>){
			#print $str;	print "\n"; 
			#chomp($str);
			if($str=~ m/(\<p)|(p\>)/){
				print $str;	#print "\n";
							
				#print $fout "\n";
				$str="";
			}
			print $fout $str;	
	}

}
$fout->close;