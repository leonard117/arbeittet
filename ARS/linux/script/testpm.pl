#!/usr/bin/perl -w
use PFileOperation;
use PFileOperation qw($weight);
camel();

print "weight = $weight";
print "\n";
print "height = $height \n";
$weight = 0;
$height = 0;
#outputvariable();
getparameter('./call_toolkit.ini','filename');
