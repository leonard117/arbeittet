#!/usr/bin/perl -w

$filepath = "..//data/SLM/CMU/bin";
#$pattern = ".text";
#read_dir($filepath,$pattern);
read_dir($filepath);
sub call_toolkit{

	my($isarg,$filepath,$inputfile,$fileText,$filewfreq,$fileVocab,$fileIdNgram,$fileLMode,$filePerplexity,$fileTestText)
	#init all local vaiales
	$isarg = @_;
	if($isarg >= 2){
		$filepath = $_[0];
		$inputfile = $_[1];
		
	}
#text2wfreq [ -hash 1000000 ]
#           [ -verbosity 2 ]
#           < .text > .wfreq
	$input = "$filepath/$input";
	$output = "$filepath/$output";
	system("text2wfreq <$input> $output");
#wfreq2vocab [ -top 20000 | -gt 10]
#            [ -records 1000000 ]
#            [ -verbosity 2]
#            < .wfreq > .vocab


#text2wngram [ -n 3 ]
#            [ -temp /usr/tmp/ ]
#            [ -chars n ]
#            [ -words m ]
#            [ -gzip | -compress ]
#            [ -verbosity 2 ]
#            < .text > .wngram


#text2idngram -vocab .vocab
#           [ -buffer 100 ]
#           [ -temp /usr/tmp/ ]
#           [ -files 20 ]
#           [ -gzip | -compress ]
#           [ -n 3 ]
#           [ -write_ascii ]
#           [ -fof_size 10 ]
#           [ -verbosity 2 ]
#           < .text > .idngram 

#ngram2mgram -n N -m M
#          [ -binary | -ascii | -words ]
#          < .ngram > .mgram

#wngram2idngram -vocab .vocab
#              [ -buffer 100 ]
#              [ -hash 200000 ]
#              [ -temp /usr/tmp/ ]
#              [ -files 20 ]
#              [ -gzip | -compress ]
#              [ -verbosity 2 ]
#              [ -n 3 ]
#              [ -write_ascii ]
#              < .wngram > .idngram

#idngram2stats [ -n 3 ]
#              [ -fof_size 50 ]
#              [ -verbosity 2 ]
#              [ -ascii_input ]
#              < .idngram > .stats


#mergeidngram [ -n 3 ]
#             [ -ascii_input ]   
#             [ -ascii_output ]   
#             .idngram_1 .idngram_2 ... .idngram_N > .idngram

#idngram2lm -idngram .idngram
#           -vocab .vocab
#           -arpa .arpa | -binary .binlm
#         [ -context .ccs ]
#         [ -calc_mem | -buffer 100 | -spec_num y ... z ]
#         [ -vocab_type 1 ]
#         [ -oov_fraction 0.5 ]
#         [ -linear | -absolute | -good_turing | -witten_bell ]
#         [ -disc_ranges 1 7 7 ] 
#         [ -cutoffs 0 ... 0 ]
#         [ -min_unicount 0 ]
#         [ -zeroton_fraction 1.0 ]
#         [ -ascii_input | -bin_input ]
#         [ -n 3 ]  
#         [ -verbosity 2 ]
#         [ -four_byte_counts ]
#         [ -two_byte_bo_weights
#            [ -min_bo_weight -3.2 ] [ -max_bo_weight 2.5 ] 
#            [ -out_of_range_bo_weights 10000 ] ]

#binlm2arpa -binary .binlm
#           -arpa .arpa 
#         [ -verbosity 2 ]

#evallm [ -binary .binlm | 
#         -arpa .arpa [ -context .ccs ] ]

#perplexity -text .text
#         [ -probs .fprobs ]
#         [ -oovs .oov_file ]
#         [ -annotate .annotation_file ]         
#         [ -backoff_from_unk_inc | -backoff_from_unk_exc ]
#         [ -backoff_from_ccs_inc | -backoff_from_ccs_exc ] 
#         [ -backoff_from_list .fblist ]
#         [ -include_unks ] 

#validate [ -backoff_from_unk_inc | -backoff_from_unk_exc ]
#         [ -backoff_from_ccs_inc | -backoff_from_ccs_exc ] 
#         [ -backoff_from_list .fblist ]
#           word1 word2 ... word_(n-1)

#interpolate +[-] model1.fprobs +[-] model2.fprobs ... 
#        [ -test_all | -test_first n | -test_last n | -cv ]
#        [ -tag .tags ]
#        [ -captions .captions ]
#        [ -in_lambdas .lambdas ]
#        [ -out_lambdas .lambdas ]
#        [ -stop_ratio 0.999 ]
#        [ -probs .fprobs ]
#        [ -max_probs 6000000 ]



}

sub getFileInfo{
	my($isarg,$filename, $directories);
	@fileinfo = ();
	$isarg = @_;
	if($isarg>0){
		($filename, $directories) = fileparse($fpath);	
		push(@fileinfo,$directories);
		push(@fileinfo,$filename);
		#push(@fileinfo,$exteninfo);		
	}

	return @fileinfo;
}

sub read_dir{
	my($dirname,$isarg,$file);# define local variables;
	@filelist=();
	$dirname = "none";
	$isarg = @_;
	if ($isarg > 0){
		
		$dirname = $_[0];#dir name;
		print ("dirname = ");
		print ("$dirname\n");
		if($isarg > 1){
			$filepattern = $_[1];
		}else{
			$filepattern = ".*";
		}
		opendir(DIR,$dirname)||die "can not open dir $dirname!";
		while (defined($file = readdir(DIR))){
			next if $file =~ /^\.\.?$/; # skip . and ..
			if ($file =~ /$filepattern/){
				print $file;
				print "\n";
				push(@filelist,$file);
			}
			
		}
		closedir(DIR)||die "can not close dir";
			
	}
	return @filelist;
}
