#!/usr/bin/perl -w
use strict;
use warnings;

my $dir_name = "~/paml/paml_result/raw_result/";

print "Ortho_family\tnp_fix\tLnL_fix\tnp_nofix\tLnL_nofix\tBEB\tpvalue\n";

opendir(DIR, $dir_name) || die "Can't open directory $dir_name"; 
my @dots = readdir(DIR); 

foreach my $file (@dots){ 
	if ($file=~/^(\S.*)\.branchsite\.fix\.txt/){
	my $Prefix=$1;
	my %value;
	
	my $fix=$dir_name.$Prefix."\.branchsite\.fix\.txt";
	open (Result1,$fix)or die "Can't open file!";
	while (<Result1>) {
		chomp();
		if (/^lnL.*np:\s+(\d+)\S+\s+(\S+)\s/){
		$value{$Prefix}{fix}{np}=$1;
		$value{$Prefix}{fix}{LnL}=$2;
		}
	}
	close Result1;

	my $no_fix=$dir_name.$Prefix."\.branchsite\.nofix\.txt";
	open (Result2, $no_fix)or die "Can't open file!";
	while (<Result2>) {
		chomp();
		if (/^lnL.*np:\s+(\d+)\S+\s+(\S+)\s/){
		$value{$Prefix}{no_fix}{np}= $1;
		$value{$Prefix}{no_fix}{LnL}= $2;
		}
		if (/^Bayes\s+Empirical\s+Bayes\s+\(BEB\)/){
			while (<Result2>){
			chomp;
			if (/^\s+(\d+)\s+(\w+)\s+(\S+)/){
				$value{$Prefix}{BEB}.="$1:$2:$3;";
			}
			last if /^\s*$/;
			}
		}
		}
	close Result2;

	print "$Prefix\t$value{$Prefix}{fix}{np}\t$value{$Prefix}{fix}{LnL}\t$value{$Prefix}{no_fix}{np}\t$value{$Prefix}{no_fix}{LnL}\t$value{$Prefix}{BEB}\t";

	my $delta_np=$value{$Prefix}{no_fix}{np}-$value{$Prefix}{fix}{np};
	my $delta_LnL=2*abs($value{$Prefix}{no_fix}{LnL}-$value{$Prefix}{fix}{LnL});

	`chi2 $delta_np $delta_LnL > file.txt` ; 

	open (Result3, 'file.txt')or die "Can't open file!";
	while (<Result3>) {
	chomp();
	if (/df.*prob\s=\s(\S+)\s/){
		$value{$Prefix}{pvalue}= $1;
		print "$value{$Prefix}{pvalue}\n";
	}else {
		next;
		}
	}
	close Result3; 

}else{
	next;
	}
}
closedir DIR;