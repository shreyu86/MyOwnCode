#!usr/bin/perl;
open(FH,'rev.xml');
#open(WRITE,'>>1a2_raw_abs');
@arr=<FH>;
foreach $line (@arr)
{

	$kex=$line;
	if($line=~/<PMID>(.*)<\/PMID>/)
	{
		$pid=$1;
	}
	if($line=~/<ArticleTitle>(.*)<\/ArticleTitle>/)
	{
		$tit=$1;
	}
	
		if($line=~/<AbstractText>(.*)<\/AbstractText>/)
		{
			$abs= lc $1;
			#$tit=$1;
			
			#undef($1);
			$line=~//;
			#$tit=$&;
		#@stab=undef;
		#@tstab=undef;
		#print $1;
		$tit=lc $tit;
		$tit=~tr/.,\"!?;:#@_&()-[]//d;
		$abs=~tr/.,\"!?;:#@_&()-[]//d;
		chomp($abs);
		#@words=split(/\s/,$abs);
		#foreach $wrd(@words)
		#{
		#	$st=porter($wrd);
		#	push(@stab,$st);
		#}
		$fle="/media/Black Box/NDDI/ddi/"."$pid".".txt";
                open (WRITE,">>$fle");
             
                  

		#@twords=split(/\s/,$tit);
		#		foreach $twrd(@twords)
		#		{
		#			$tst=porter($twrd);
		#			push(@tstab,$tst);
		#}
		   	 print WRITE "$tit\n$abs\n";
    		}
    	
}
