#!/usr/bin/perl -w
use File::Basename;
use PFileOperation;

my $cfgfile =  "./call_toolkit.ini";


call_toolkit($cfgfile,"refresh");

sub call_toolkit{

	my($isarg,$filepath,$inputfile,$fileext,$fileText,$filewfreq,$fileVocab,$fileIdNgram,$fileLModel,$fileCcs,$filePerplexity,$fileTestText);
	my($ngram);
	#init all local vaiales
	$fileTestText = "..//data//test//pp_et_05.nvp";
	$fileCcs="..//data//other//lm.ccs";
	$fileext="";
	$ngram = 1;
	$isarg = @_;
	$discounting = "absolute";
	#$discounting = "good_turing";

	if($isarg >= 1){

		$cfgfile = $_[0];
		$fileCcs=getparameter($cfgfile,"fileCcs");
		$fileTestText =getparameter($cfgfile,"fileTestText");
		$ngram = getparameter($cfgfile,"ngram");
		$discounting = getparameter($cfgfile,"discounting");
		($filepath,$inputfile,$fileext)=getFileInfo(getparameter($cfgfile,"filename"));	
		$programsource = getparameter($cfgfile,"programsource");

		print "filinfo",$programsource,"\n";
		if($isarg >=2){
			@filelist = read_dir($filepath);
			print "refresh dir \n";
			foreach $file(@filelist){
				if(!($file =~ m/.text/)){
					
					$dfile = "$filepath/$file";
					#print "$file file invalid \n";
					system("rm $dfile");

				}
								
				
			}
		  		
		}	
	}else{
		print "please give config file name!\n";
		return;
	}

	
#text2wfreq [ -hash 1000000 ]
#           [ -verbosity 2 ]
#           < .text > .wfreq
	if(length($fileext)>0){
		$fileText = "$inputfile.$fileext";	
	}else{
		$fileText = $inputfile;		
	}
	$filewfreq = "$inputfile.wfreq";
	$fileText = "$filepath/$fileText";
	$filewfreq = "$filepath/$filewfreq";
	$input = $fileText;
	$output = $filewfreq;
	print "$programsource/text2wfreq <$input> $output ";
	print " \n end \n ";
	system("$programsource/text2wfreq <$input> $output");


#wfreq2vocab [ -top 20000 | -gt 10]
#            [ -records 1000000 ]
#            [ -verbosity 2]
#            < .wfreq > .vocab

	$fileVocab = "$inputfile.vocab";
	$fileVocab = "$filepath/$fileVocab";
	$input = $filewfreq;
	$output = $fileVocab;	
	system("$programsource/wfreq2vocab <$input> $output");
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
	$fileIdNgram = "$inputfile.idngram";
	$fileIdNgram = "$filepath/$fileIdNgram";
	$input = $fileVocab;
	$output = $fileIdNgram;	
	#system("$programsource/text2idngram -vocab $fileVocab -buffer 100 -temp $filepath -files 20 -n $ngram -write_ascii <$fileText> $output");
	system("$programsource/text2idngram -vocab $fileVocab -buffer 100 -temp $filepath -files 20 -n $ngram  <$fileText> $output");

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
	
	$fileLModel = "$inputfile.binlm"; 
	$fileLModel = "$inputfile.arpa";
	$fileLModel = "$filepath/$fileLModel";
	#$input = $fileIdNgram;
	$output = $fileLModel;	
	system("$programsource/idngram2lm  -idngram $fileIdNgram -vocab $fileVocab -arpa $output -context $fileCcs -$discounting -n $ngram ");
	#system("$programsource/idngram2lm  -idngram $fileIdNgram -vocab $fileVocab -binary $output  -n $ngram ");
	#system("$programsource/idngram2lm  -idngram $fileIdNgram -vocab $fileVocab -arpa $output  -n $ngram ");


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

#system("echo "perplexity -text oupt.text"");


#interpolate +[-] model1.fprobs +[-] model2.fprobs ... 
#        [ -test_all | -test_first n | -test_last n | -cv ]
#        [ -tag .tags ]
#        [ -captions .captions ]
#        [ -in_lambdas .lambdas ]
#        [ -out_lambdas .lambdas ]
#        [ -stop_ratio 0.999 ]
#        [ -probs .fprobs ]
#        [ -max_probs 6000000 ]


# system("cat $fileText | text2wfreq | wfreq2vocab -top 20000 > $fileVocab");
# system("cat $fileText | text2idngram -vocab $fileVocab|idngram2lm -vocab $fileVocab -idngram -arpa  fileLModel -context $fileCcs");

#system("echo perplexity -text $fileText | $programsource/evallm -arpa $fileLModel -context $fileCcs");
system("echo perplexity -text $fileTestText | $programsource/evallm -arpa $fileLModel -context $fileCcs");	
#system("echo perplexity -text $fileTestText | $programsource/evallm -binary $fileLModel ");


}

sub getFileInfo{
	my($isarg,$filename, $directories);
	@fileinfo = ();
	$isarg = @_;
	if($isarg>0){
		$fpath = $_[0];
		($filename, $directories) = fileparse($fpath);	
		$exteninfo = ($filename =~ m/([^.]+)$/)[0];
		$filename = substr($filename,0,length($filename)-length($exteninfo)-1);
		push(@fileinfo,$directories);
		push(@fileinfo,$filename);
		push(@fileinfo,$exteninfo);
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
