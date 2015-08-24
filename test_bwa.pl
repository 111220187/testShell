#!/user/bin/perl
use strict;

###################################### find ###################################################
my $refName="../library/genomeForBwaSoftware/genome.fa";
my $dirName="./a_fastq_change/";#reads direction
my $nFile=0;
opendir(DIR,$dirName)||die "Can't open directory $dirName";
my @fileName=readdir(DIR);
foreach(@fileName){
	$nFile++;
}
closedir(DIR);
my $numberOfCPU=1;#the number of threads

for($numberOfCPU=32;$numberOfCPU<33;$numberOfCPU*=2){
	for(my $nn=0;$nn<$nFile;$nn++){
		if($fileName[$nn] eq "."||$fileName[$nn] eq "..") {next;}
		my $command="/usr/bin/time -v -o ./time_bwa/$fileName[$nn]_$numberOfCPU ../software/bwa-0.7.12/bwa aln -t $numberOfCPU -f ./s_bwa_sai/$fileName[$nn].sai  $refName $dirName$fileName[$nn]";
		print "$command\n\n";
		system($command);
	}
}


=pod
##################################  transform  ################################################
my $saiDir="./s_bwa_sai/";
opendir(DIR2,$saiDir);
my @saiFile=readdir(DIR2);
closedir(DIR2);

for my $file(@saiFile){
	if($file eq "."||$file eq "..") {next;}
	if($file=~/_2/){next;}
	
	my $file2=$file;
	$file2=~s/_1/_2/;
	
	my $fastqFile=$file;
	$fastqFile=~s/.sai//;
	
	my $fastqFile2=$file2;
	$fastqFile2=~s/.sai//;
	
	my $command="/usr/bin/time -v -o ./time_bwa/transform_$fastqFile ../software/bwa-0.7.12/bwa sampe -f  ./s_bwa_sam/$file.sam $refName $saiDir$file $saiDir$file2 $dirName$fastqFile $dirName$fastqFile2";
	print "$command\n\n";
	system($command);
}
=cut

