#!/usr/bin/env perl

#This script takes a single parameter being the number of copies to make
#of all .pdf files located in the current working directory
#
#It then proceeds to copy all the files adding in sequence from 001 to
#the total number of copies to be made for each pdf file

use strict ;

use FindBin ;
use local::lib "$FindBin::Bin/extlib" ;
use File::Glob ':bsd_glob' ;
use File::Basename ;
use File::Copy ;

#Get list of all pdf files in the current directory
my @pdfFiles = bsd_glob('*.pdf') ;

foreach my $seq (1 .. $ARGV[0])
{
	#Copy each pdf file to include sequence number
	foreach my $pdfFile (@pdfFiles)
	{
		my ($name,$path,$suffix) = fileparse($pdfFile,qr/\.[^.]*/) ;
		# firstname lastname - pdffilename
		my $destPath = "$name-" . sprintf("%03d",$seq) . $suffix ;
		print "copy($pdfFile, $destPath) ;\n" ;
		copy($pdfFile,$destPath) or die "Error copying $pdfFile to $destPath: $!" ;
	}
}

