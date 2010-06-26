# This script allows you to download PubMed search result to local machine.
# Please refer to http://eutils.ncbi.nlm.nih.gov/entrez/query/static/eutils_help.html 
# for better details.


#!/usr/bin/perl

use strict;
use LWP::Simple;

my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";

my $db     = "Pubmed";
    if(!$ARGV[0]){
    print "Please input search term\n";
    exit(1);
}
my $query  = $ARGV[0];
my $report = "MEDLINE";

# ---------------------------------------------------------------------------
# $esearch cont¡ins the PATH & parameters for the ESearch call
# $esearch_result containts the result of the ESearch call
# the results are displayed ¡nd parsed into variables 
# $Count, $QueryKey, and $WebEnv for later use and then displayed.

my $esearch = "$utils/esearch.fcgi?" .
              "db=$db&retmax=1&usehistory=y&term=";

my $esearch_result = get($esearch . $query);


#print "\nESEARCH RESULT: $esearch_result\n";

$esearch_result =~ 
  m|<Count>(\d+)</Count>.*<QueryKey>(\d+)</QueryKey>.*<WebEnv>(\S+)</WebEnv>|s;

my $Count    = $1;
my $QueryKey = $2;
my $WebEnv   = $3;

  my $efetch = "$utils/efetch.fcgi?" .
               "rettype=$report&retmode=xml&" .
               "db=$db&query_key=$QueryKey&WebEnv=$WebEnv";

#print "\nEF_QUERY=$efetch\n";  

my $efetch_result = get($efetch);
  
print $efetch_result,"\n";

