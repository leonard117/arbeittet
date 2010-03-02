#!/usr/bin/perl -w

sub funtest {
	my($i,$isarg);# define local variables;
	$isarg = @_;
	#builtin private array @_ is input arguments.
	#$_[1] or $_[2] means first and second argument.
	#$isarg = @_ to get length of array @_;
	if ($isarg > 0){
		print ("functions with parameters!\n");	
		$i = 0;
		foreach $_(@_){
			$i += 1;
			print ("parameter ");
 			print ($i); 
			print (" = ");
			print ( $_);
			print ( "\n");
		
		}
	}else{
		print ("no input parameters for functions!\n");	
	}
	
}
funtest("hallo","world");
