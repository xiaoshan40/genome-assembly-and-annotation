#!/usr/bin/perl -w
use strict;
use warnings;

my $dir_name = "~/paml/paml_result/raw_result/";

print "Ortho_family\tnp0\tLnL0\tnp2\tLnL2\tback_omega\tfor_omega\tpvalue\n";

opendir(DIR, $dir_name) || die "Can't open directory $dir_name"; 
my @dots = readdir(DIR); 

foreach my $file (@dots){ 
       if ($file=~/^(\S.*)\.branch\.oneratio\.txt/){
      my $Prefix=$1;
      my %value;
      my $one_ratio=$dir_name.$Prefix."\.branch\.oneratio\.txt";
      open (Result1, $one_ratio)or die "Can't open file!";
      while (<Result1>) {
        chomp();
          if (/^lnL.*np:\s+(\d+)\S+\s+(\S+)\s/){
            $value{$Prefix}{one_ratio}{np}= $1;
            $value{$Prefix}{one_ratio}{LnL}= $2;
        }
      }
      close Result1;
      
      my $two_ratio=$dir_name.$Prefix."\.branch\.tworatio\.txt";
      open (Result2, $two_ratio)or die "Can't open file!";
      while (<Result2>) {
        chomp();
          if (/^lnL.*np:\s+(\d+)\S+\s+(\S+)\s/){
            $value{$Prefix}{two_ratio}{np}= $1;
            $value{$Prefix}{two_ratio}{LnL}= $2;
        }elsif (/^\(\(Acep\s+\#(\S+).*Tele\s+\#(\S+)\s/){
            $value{$Prefix}{omega}="$1\t$2\t";
      }
      }
      close Result2;
      
      print "$Prefix\t$value{$Prefix}{one_ratio}{np}\t$value{$Prefix}{one_ratio}{LnL}\t$value{$Prefix}{two_ratio}{np}\t$value{$Prefix}{two_ratio}{LnL}\t$value{$Prefix}{omega}";
      
      my $delta_np=$value{$Prefix}{two_ratio}{np}-$value{$Prefix}{one_ratio}{np};
      my $delta_LnL=2*abs($value{$Prefix}{two_ratio}{LnL}-$value{$Prefix}{one_ratio}{LnL});
      
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