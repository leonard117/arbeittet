#pm

package PFileOperation;
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(camel $height outputvariable getparameter);
our @EXPORT_OK = qw($weight);
our $VERSION = 1.0;

#################################
sub camel{
	print("call sub of PFileOperation!\n");
}
sub outputvariable{
	print "weight = $weight\n";
	print "height = $height\n";
}
$height = 800;
$weight = 1024;
sub  getparameter{
# getparameter('call_toolkit.ini','filename');
	my($isarg,$cfgfile,$parameter_name,$parameter_val);
	$isarg = @_;
	if ($isarg<2){ return -1;}
	$cfgfile = $_[0];
	$parameter_name = $_[1];
	open(CFGIN,$cfgfile)|| die "cannot open cfg file \n";
	while(<CFGIN>){
		$str = $_;
		if($str =~ m/#/){
			print "not valid line\n";
		}else{
			if(($str =~ m/=/)&&($str =~ m/$parameter_name/) ){	
			@word=split(/[= \n]/,$str);
			
			$len = @word;
				#$str include '\n', so this char should also be extracted.
				($sname,$sval,$tmp) =  @word;
				#print "sname=",$sname,"\n";
				#print "sval=",$sval,"\n";
				close(CFGIN)|| die "cannot close file \n";	
				return $sval
			}			
			
		}
	}#while
	close(CFGIN)|| die "cannot close file \n";	
	
	
}
