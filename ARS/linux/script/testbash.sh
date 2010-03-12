#!/bin/bash
#*****************************************
#
#
#*****************************************
echo hello world
#sourcepath="../data/source"
#targetpath="../data/target"
#./testperl.pl
#ls $sourcepath
#./unpack.pl $sourcepath $targetpath
#./convertfile.pl $targetpath $targetpath

software_path = "../CMU/bin"
source_path =  "../data/target/output/output"
file_lm = "../data/target/output/output/output.binlm"

echo perplexity -text $source_path/oupt.text | $software_path/evallm -binary $file_lm

