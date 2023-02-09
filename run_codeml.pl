#!/usr/bin/perl -w
use strict;
use warnings;

my $ctl_template;
$ctl_template.="seqfile \= \n"."treefile \= \n"."outfile \= \n\n";
$ctl_template.="noisy \= 0 \n"."verbose \= 0 \n"."runmode \= 0 \n\n";
$ctl_template.="seqtype \= 1 \n"."CodonFreq \= 2 \n"."clock \= 0 \n"."model \=  \n\n";
$ctl_template.="NSsites \=  \n"."icode \= 0 \n"."Mgene \= 0 \n\n";
$ctl_template.="fix_kappa \= 0 \n"."kappa \= 2 \n"."fix_omega \= \n"." omega \= \n\n";
$ctl_template.="fix_alpha \= 1 \n"."alpha \= \.0 \n"."Malpha \= 0 \n"."ncatG \= 8 \n\n";
$ctl_template.="getSE \= 0 \n"."RateAncestor \= 1 \n\n";
$ctl_template.="Small_Diff \= \.5e-6 \n"."cleandata \= 1 \n"."\*  fix_blength \= -1 \n"."method \= 0 \n\n";

my $dir_name = $ARGV[0];

opendir(DIR, $dir_name) || die "Can't open directory $dir_name"; 
my @dots = readdir(DIR);
foreach my $file (@dots){ 
  if ($file=~/^(\S.*)\.cds_aln\.paml/){
    my $Prefix=$1;
    my $ctl_brach_free_ratio=$ctl_template;
    $ctl_brach_free_ratio=~ s/seqfile\s+=/seqfile = $dir_name\/$file/g;
    $ctl_brach_free_ratio=~ s/treefile\s+=/treefile = tree.newick.Unlabeled/g;
    $ctl_brach_free_ratio=~ s/outfile\s+=/outfile = $Prefix.branch.freeratio.txt/g;
    $ctl_brach_free_ratio=~ s/model\s+=/model = 1/g;
    $ctl_brach_free_ratio=~ s/NSsites\s+=/NSsites = 0 /g;
    $ctl_brach_free_ratio=~ s/fix_omega\s+=/fix_omega = 0 /g;
    $ctl_brach_free_ratio=~ s/\somega\s+=/omega = .4 /g;
    my $fileout1=$Prefix."\.branch\.freeratio\.ctl";
    open(OUT1,">$fileout1");
    print OUT1 $ctl_brach_free_ratio;
    close OUT1;
    
    my $ctl_brach_one_ratio=$ctl_template;
    $ctl_brach_one_ratio=~ s/seqfile\s+=/seqfile = $dir_name\/$file/g;
    $ctl_brach_one_ratio=~ s/treefile\s+=/treefile = tree.newick.Unlabeled/g;
    $ctl_brach_one_ratio=~ s/outfile\s+=/outfile = $Prefix.branch.oneratio.txt/g;
    $ctl_brach_one_ratio=~ s/model\s+=/model = 0/g;
    $ctl_brach_one_ratio=~ s/NSsites\s+=/NSsites = 0 /g;
    $ctl_brach_one_ratio=~ s/fix_omega\s+=/fix_omega = 0 /g;
    $ctl_brach_one_ratio=~ s/\somega\s+=/omega = .4 /g;
    my $fileout2=$Prefix."\.branch\.oneratio\.ctl";
    open(OUT2,">$fileout2");
    print OUT2 $ctl_brach_one_ratio;
    close OUT2;
    
    
    my $ctl_brach_two_ratio=$ctl_template;
    $ctl_brach_two_ratio=~ s/seqfile\s+=/seqfile = $dir_name\/$file/g;
    $ctl_brach_two_ratio=~ s/treefile\s+=/treefile = tree.newick.Labeled/g;
    $ctl_brach_two_ratio=~ s/outfile\s+=/outfile = $Prefix.branch.tworatio.txt/g;
    $ctl_brach_two_ratio=~ s/model\s+=/model = 2/g;
    $ctl_brach_two_ratio=~ s/NSsites\s+=/NSsites = 0 /g;
    $ctl_brach_two_ratio=~ s/fix_omega\s+=/fix_omega = 0 /g;
    $ctl_brach_two_ratio=~ s/\somega\s+=/omega = .4 /g;
    my $fileout3=$Prefix."\.branch\.tworatio\.ctl";
    open(OUT3,">$fileout3");
    print OUT3 $ctl_brach_two_ratio;
    close OUT3;
    
    my $ctl_brach_site_fix=$ctl_template;
    $ctl_brach_site_fix=~ s/seqfile\s+=/seqfile = $dir_name\/$file/g;
    $ctl_brach_site_fix=~ s/treefile\s+=/treefile = tree.newick.Labeled/g;
    $ctl_brach_site_fix=~ s/outfile\s+=/outfile = $Prefix.branchsite.fix.txt/g;
    $ctl_brach_site_fix=~ s/model\s+=/model = 2/g;
    $ctl_brach_site_fix=~ s/NSsites\s+=/NSsites = 2 /g;
    $ctl_brach_site_fix=~ s/fix_omega\s+=/fix_omega = 1 /g;
    $ctl_brach_site_fix=~ s/\somega\s+=/omega = 1 /g;
    my $fileout4=$Prefix."\.branchsite\.fix\.ctl";
    open(OUT4,">$fileout4");
    print OUT4 $ctl_brach_site_fix;
    close OUT4;
    
    my $ctl_brach_site_nofix=$ctl_template;
    $ctl_brach_site_nofix=~ s/seqfile\s+=/seqfile = $dir_name\/$file/g;
    $ctl_brach_site_nofix=~ s/treefile\s+=/treefile = tree.newick.Labeled/g;
    $ctl_brach_site_nofix=~ s/outfile\s+=/outfile = $Prefix.branchsite.nofix.txt/g;
    $ctl_brach_site_nofix=~ s/model\s+=/model = 2/g;
    $ctl_brach_site_nofix=~ s/NSsites\s+=/NSsites = 2 /g;
    $ctl_brach_site_nofix=~ s/fix_omega\s+=/fix_omega = 0 /g;
    $ctl_brach_site_nofix=~ s/\somega\s+=/omega = 1.5 /g;
    my $fileout5=$Prefix."\.branchsite\.nofix\.ctl";
    open(OUT5,">$fileout5");
    print OUT5 $ctl_brach_site_nofix;
    close OUT5;
    
    `codeml  $Prefix.branch.freeratio.ctl`;
    `codeml  $Prefix.branch.oneratio.ctl`;
    `codeml  $Prefix.branch.tworatio.ctl`;
    `codeml  $Prefix.branchsite.fix.ctl`;
    `codeml  $Prefix.branchsite.nofix.ctl`;
    
  }else{
    next;
  }
}
closedir DIR;