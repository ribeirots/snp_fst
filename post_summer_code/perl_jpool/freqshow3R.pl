#!/usr/bin/perl -w
#use strict;

#Create a file that gives allele counts at every site for a single population (A, C, G, T), for one chromosome arm

my $PopLabel = 'EA';

my @InLines = ('EA119', 'EA126N', 'EA3', 'EA49', 'EA50N', 'EA59N', 'EA71', 'EA84N', 'EA87', 'EA90N', 'EA91N', 'EA93N');

#my @InLines = ('EF101N', 'EF103N', 'EF108N', 'EF10N', 'EF112N', 'EF114N', 'EF115N', 'EF117N', 'EF119N', 'EF120', 'EF122N', 'EF126N', 'EF130N', 'EF131N', 'EF135N', 'EF136N', 'EF1N', 'EF2', 'EF24N', 'EF25N', 'EF26N', 'EF27N', 'EF35N', 'EF39', 'EF43N', 'EF46N', 'EF48N', 'EF53N', 'EF59N', 'EF65', 'EF67N', 'EF70N', 'EF73N', 'EF78', 'EF7N', 'EF80N', 'EF81N', 'EF82N', 'EF83N', 'EF88N', 'EF8N', 'EF93N', 'EF95N', 'EF96N', 'EF98N');

#my @InLines = ('EG15N', 'EG28N', 'EG40N', 'EG46N', 'EG55N', 'EG73N');

#my @InLines = ('FR126N', 'FR12N', 'FR14', 'FR151', 'FR152N', 'FR157N', 'FR158N', 'FR161N', 'FR162N', 'FR164N', 'FR169N', 'FR173N', 'FR186N', 'FR188N', 'FR19N', 'FR200N', 'FR207', 'FR208N', 'FR216N', 'FR217', 'FR222N', 'FR225N', 'FR236N', 'FR238N', 'FR257N', 'FR260N', 'FR263N', 'FR264N', 'FR269N', 'FR276N', 'FR293N', 'FR302N', 'FR305N', 'FR313N', 'FR320N', 'FR323N', 'FR326N', 'FR32N', 'FR345N', 'FR360N', 'FR364N', 'FR37N', 'FR48N', 'FR54N', 'FR70', 'FR73N', 'FR91N');

#my @InLines = ('SD1N', 'SD109N', 'SD124N', 'SD142N', 'SD145', 'SD18N', 'SD28N', 'SD39N', 'SD43N', 'SD45', 'SD49N', 'SD54N', 'SD55N', 'SD56N', 'SD59N', 'SD67', 'SD78N', 'SD8N', 'SD82', 'SD88N', 'SD92N', 'SD98');

#my @InLines = ('ZI10', 'ZI104', 'ZI114N', 'ZI117', 'ZI118N', 'ZI126', 'ZI129', 'ZI134N', 'ZI136', 'ZI138', 'ZI152', 'ZI157', 'ZI161', 'ZI164', 'ZI165', 'ZI167', 'ZI170', 'ZI172', 'ZI173', 'ZI176', 'ZI178', 'ZI179', 'ZI181', 'ZI182', 'ZI184', 'ZI185', 'ZI191', 'ZI193', 'ZI194', 'ZI196', 'ZI198', 'ZI200', 'ZI206', 'ZI207', 'ZI210', 'ZI211', 'ZI212', 'ZI213', 'ZI216N', 'ZI219', 'ZI225', 'ZI226', 'ZI231', 'ZI232', 'ZI235', 'ZI239', 'ZI240', 'ZI250', 'ZI251N', 'ZI252', 'ZI253', 'ZI254N', 'ZI255', 'ZI26', 'ZI261', 'ZI263', 'ZI265', 'ZI268', 'ZI269', 'ZI27', 'ZI271', 'ZI276', 'ZI279', 'ZI28', 'ZI281', 'ZI286', 'ZI295', 'ZI303', 'ZI311N', 'ZI313', 'ZI314', 'ZI316', 'ZI31N', 'ZI320', 'ZI321', 'ZI324', 'ZI329', 'ZI33', 'ZI332', 'ZI335', 'ZI336', 'ZI339', 'ZI342', 'ZI344', 'ZI348', 'ZI357N', 'ZI358', 'ZI359', 'ZI364', 'ZI365', 'ZI370', 'ZI373', 'ZI374', 'ZI377', 'ZI378', 'ZI386', 'ZI388', 'ZI392', 'ZI394N', 'ZI395', 'ZI398', 'ZI402', 'ZI413', 'ZI418N', 'ZI420', 'ZI421', 'ZI431', 'ZI433', 'ZI444', 'ZI445', 'ZI447', 'ZI453', 'ZI455N', 'ZI456', 'ZI457', 'ZI458', 'ZI460', 'ZI466', 'ZI467', 'ZI468', 'ZI471', 'ZI472', 'ZI477', 'ZI488', 'ZI490', 'ZI491', 'ZI504', 'ZI50N', 'ZI514N', 'ZI517', 'ZI524', 'ZI527', 'ZI530', 'ZI56', 'ZI61', 'ZI68', 'ZI76', 'ZI85', 'ZI86', 'ZI91', 'ZI99');

#my @InLines = ('CO1','CO10N','CO13N','CO14','CO15N','CO16','CO2','CO4N','CO8N','CO9N');

#my @InLines = ('RG10','RG11N','RG13N','RG15','RG19','RG2','RG21N','RG22','RG24','RG28','RG3','RG32N','RG33','RG34','RG35','RG36','RG37N','RG38N','RG39','RG4N','RG6N','RG7','RG8');

#my @InLines = (add KF);

my @InHandles = @InLines;
for ($i = 0; $i < @InHandles; $i++){
  $InHandles[$i] =~ s/1/A/;
  $InHandles[$i] =~ s/2/B/;
  $InHandles[$i] =~ s/3/C/;
  $InHandles[$i] =~ s/4/D/;
  $InHandles[$i] =~ s/5/E/;
  $InHandles[$i] =~ s/6/F/;
  $InHandles[$i] =~ s/7/G/;
  $InHandles[$i] =~ s/8/H/;
  $InHandles[$i] =~ s/9/I/;
  $InHandles[$i] =~ s/0/J/;
}

#declarations
my $c = 0;
my $f = 0;
my $i = 0;
my $j = 0;
my $s = 0;
my $chr = '';
my $kb = -1;
my $file = '';
my $file1 = '';
my $path = '';
my $CountFile = '';
my @ChrLines = ();
my @ChrHandles = ();
my @line = ();
my @InputAoA = ();
my @SiteCounts = ();

#Chr loop (not indented)
#my @chrs = ('ChrX','Chr2L','Chr2R','Chr3L','Chr3R');
my @chrs = ('Chr3R');
for ($c = 0; $c < @chrs; $c++){
$chr = $chrs[$c];
$kb = -1;
$CountFile = 'AllCounts_' . $PopLabel . '_' . $chr . '.txt';
open O, ">$CountFile" or die;

#ind loop - open files
@ChrLines = ();
@ChrHandles = ();
for ($f = 0; $f < @InLines; $f++){
  $file = $InLines[$f] . "_" . $chr . "\.fas1k";
  $path = "../$chr/$file";
  if (-e $path){
    open $InHandles[$f], "<../$chr/$file";
    push @ChrLines, $InLines[$f];
    push @ChrHandles, $InHandles[$f];
  } 
}
$file1 = $ChrHandles[0];
while (<$file1>){
  @InputAoA = ();
  chomp;
  $kb++;
  last if m/^$/;
  @line = split(//, $_);
  push @InputAoA, [ @line ];
  for ($f = 1; $f < @ChrLines; $f++){
    $file = $ChrHandles[$f];
    $_ = (<$file>);
    chomp;
    @line = split(//, $_);
    push @InputAoA, [ @line ];
  }
  if (($kb % 1000) == 0){
    print "kb $kb\n";
  }

#Obtain and record allele counts for each site  
  for ($s = 0; $s < @{$InputAoA[0]}; $s++){
    @SiteCounts = (0,0,0,0);
    for ($i = 0; $i < @InputAoA; $i++){
      if ($InputAoA[$i][$s] eq 'A'){
	$SiteCounts[0]++;
      }
      elsif ($InputAoA[$i][$s] eq 'C'){
	$SiteCounts[1]++;
      }
      elsif ($InputAoA[$i][$s] eq 'G'){
	$SiteCounts[2]++;
      }
      elsif ($InputAoA[$i][$s] eq 'T'){
	$SiteCounts[3]++;
      }
    }
    print O "$SiteCounts[0]\t$SiteCounts[1]\t$SiteCounts[2]\t$SiteCounts[3]\n";
  }
}

close O;

for ($i = 0; $i < @ChrLines; $i++){
  close $ChrHandles[$i];
}

}


