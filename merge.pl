#!/usr/bin/perl -w
use warnings;
use strict;

print "hello\n";


my $fin_okato;
my $fin_newcode;
open $fin_okato, "<./okato.txt";
open $fin_newcode, "<./newcode.txt";

my %okato;
my %newcode;
grep { chomp; 
	my ($region,$okato) = split ";", $_;
	my ($name,$area) = split " ",$region;
	$area = "" unless defined($area);
	$okato{$name} = "$name;$okato;$area"
} <$fin_okato>;

my $count = 0;
grep{ chomp;
	my ($name,$code,$abr) = split ";", $_;
	$newcode{$name} = "$name;$code;$abr";
	$count++;
} <$fin_newcode>;

my $assoc_count = 0;
while(my ($name,$rest) = each %newcode) {
	if (defined($okato{$name})) {
		print $okato{$name} . " ~ " . $newcode{$name} . "\n";
		$assoc_count++;
	} else {
		print "$newcode{$name}" . "\t"x3 . "unassociated\n";
	}
}

print "count newcode: $count\n";
print "assoc count: $assoc_count\n";
close $fin_okato;
close $fin_newcode;
