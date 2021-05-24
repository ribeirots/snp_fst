#!/usr/bin/perl -w
#use strict;

#Create a file that gives allele counts at every site for a single population (A, C, G, T), for one chromosome arm

my $PopLabel = 'RG';

#my @InLines = ('EA117N', 'EA119', 'EA124N', 'EA126N', 'EA22N', 'EA2N', 'EA3', 'EA30N', 'EA31N', 'EA37N', 'EA49', 'EA50N', 'EA58N', 'EA59N', 'EA84N', 'EA87', 'EA87N', 'EA91N', 'EA93N');

#my @InLines = ('EF101N', 'EF102N', 'EF103N', 'EF108N', 'EF10N', 'EF110N', 'EF112N', 'EF114N', 'EF115N', 'EF116N', 'EF117N', 'EF119N', 'EF11N', 'EF120', 'EF120N', 'EF122N', 'EF126N', 'EF12N', 'EF130N', 'EF131N', 'EF132N', 'EF134N', 'EF135N', 'EF136N', 'EF15N', 'EF16N', 'EF19N', 'EF1N', 'EF2', 'EF24N', 'EF25N', 'EF26N', 'EF27N', 'EF31N', 'EF32N', 'EF35N', 'EF39', 'EF3N', 'EF43N', 'EF46N', 'EF48N', 'EF52N', 'EF53N', 'EF54N', 'EF59N',  'EF64N', 'EF65', 'EF66N', 'EF67N', 'EF69N', 'EF6N', 'EF70N', 'EF73N', 'EF74N', 'EF75N', 'EF78', 'EF7N', 'EF80N', 'EF81N', 'EF82N', 'EF83N', 'EF86N', 'EF88N', 'EF8N', 'EF93N', 'EF95N', 'EF96N', 'EF98N');

#my @InLines = ('EG15N', 'EG25N', 'EG28N', 'EG29N', 'EG36N', 'EG46N', 'EG49N', 'EG55N', 'EG70N', 'EG76N');

#my @InLines = ('FR106N', 'FR112N', 'FR115N', 'FR11N', 'FR126N', 'FR12N', 'FR135N', 'FR14', 'FR147N', 'FR151', 'FR152N', 'FR153N', 'FR157N', 'FR161N', 'FR162N', 'FR169N', 'FR16N', 'FR173N', 'FR186N', 'FR198N', 'FR19N', 'FR200N', 'FR207', 'FR208N', 'FR213N', 'FR216N', 'FR217', 'FR219N', 'FR222N', 'FR225N', 'FR229', 'FR230N', 'FR231N', 'FR235N', 'FR236N', 'FR238N', 'FR240N', 'FR248N', 'FR252N', 'FR257N', 'FR260N', 'FR261N', 'FR263N', 'FR264N', 'FR269N', 'FR26N', 'FR276N', 'FR279N', 'FR284N', 'FR288N', 'FR28N', 'FR293N', 'FR296N', 'FR299N', 'FR302N', 'FR304N', 'FR305N', 'FR310', 'FR312N', 'FR313N', 'FR319N', 'FR320N', 'FR326N', 'FR32N', 'FR340N', 'FR345N', 'FR348N', 'FR34N', 'FR357N', 'FR360N', 'FR361', 'FR364N', 'FR370N', 'FR37N', 'FR48N', 'FR54N', 'FR59N', 'FR5N', 'FR60N', 'FR70', 'FR73N', 'FR89N', 'FR90N', 'FR91N', 'FR94N');

#my @InLines = ('SD104N', 'SD108N', 'SD110N', 'SD114N', 'SD116N', 'SD117N', 'SD121N', 'SD131N', 'SD132N', 'SD133N', 'SD138N', 'SD145', 'SD14N', 'SD151N', 'SD17N', 'SD32N', 'SD35N', 'SD37N', 'SD43N', 'SD44N', 'SD47N', 'SD48N', 'SD5N', 'SD51N', 'SD54N', 'SD55N', 'SD64N', 'SD67', 'SD68N', 'SD72N', 'SD77N', 'SD78N', 'SD79N', 'SD90N', 'SD92N', 'SD98');

#my @InLines = ('ZI10', 'ZI103', 'ZI104', 'ZI126', 'ZI129', 'ZI134N', 'ZI138', 'ZI152', 'ZI157', 'ZI164', 'ZI165', 'ZI167', 'ZI170', 'ZI172', 'ZI173', 'ZI176', 'ZI177', 'ZI178', 'ZI179', 'ZI181', 'ZI182', 'ZI184', 'ZI185', 'ZI188', 'ZI190', 'ZI191', 'ZI193', 'ZI194', 'ZI196', 'ZI197N', 'ZI199', 'ZI200', 'ZI202', 'ZI207', 'ZI210', 'ZI211', 'ZI212', 'ZI213', 'ZI214', 'ZI216N', 'ZI218', 'ZI219', 'ZI220', 'ZI221', 'ZI225', 'ZI226', 'ZI228', 'ZI230', 'ZI231', 'ZI233', 'ZI237', 'ZI239', 'ZI241', 'ZI250', 'ZI251N', 'ZI252', 'ZI254N', 'ZI255', 'ZI26', 'ZI261', 'ZI264', 'ZI265', 'ZI267', 'ZI268', 'ZI271', 'ZI273N', 'ZI279', 'ZI28', 'ZI281', 'ZI286', 'ZI291', 'ZI292', 'ZI293', 'ZI295', 'ZI296', 'ZI303', 'ZI311N', 'ZI314', 'ZI317', 'ZI319', 'ZI31N', 'ZI320', 'ZI324', 'ZI329', 'ZI33', 'ZI332', 'ZI333', 'ZI335', 'ZI336', 'ZI341', 'ZI344', 'ZI348', 'ZI351', 'ZI353', 'ZI358', 'ZI359', 'ZI362', 'ZI364', 'ZI365', 'ZI368', 'ZI370', 'ZI373', 'ZI377', 'ZI378', 'ZI379', 'ZI380', 'ZI381', 'ZI382', 'ZI384', 'ZI386', 'ZI388', 'ZI392', 'ZI398', 'ZI400', 'ZI402', 'ZI413', 'ZI418N', 'ZI420', 'ZI421', 'ZI429', 'ZI431', 'ZI433', 'ZI437', 'ZI443', 'ZI447', 'ZI448', 'ZI453', 'ZI455N', 'ZI457', 'ZI458', 'ZI460', 'ZI466', 'ZI468', 'ZI471', 'ZI472', 'ZI476', 'ZI477', 'ZI490', 'ZI491', 'ZI504', 'ZI508', 'ZI50N', 'ZI514N', 'ZI517', 'ZI523', 'ZI56', 'ZI59', 'ZI68', 'ZI85', 'ZI86', 'ZI90', 'ZI91', 'ZI99');

#my @InLines = ('CO1',	'CO10N','CO13N','CO15N','CO16',	'CO2',	'CO4N',	'CO8N','CO9N');

my @InLines = ('RG10','RG11N','RG13N','RG15','RG18N','RG19','RG2','RG21N','RG22','RG24','RG25','RG28','RG32N','RG33','RG34','RG35','RG38N','RG39','RG4N','RG5','RG6N','RG7','RG8','RG9');


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
my @chrs = ('Chr2L');
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


