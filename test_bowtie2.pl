#!/user/bin/perl
use strict;
my $refName="../library/hg19/genome";
my $dirName="./a_fastq_change/";
my $nFile=0;
opendir(DIR,$dirName)||die "Can't open directory $dirName";
my @fileName=readdir(DIR);
foreach(@fileName){
	$nFile++;
}
closedir(DIR);
#my $readsFile1="jiayan_1.fastq";
#my $readsFile2="jiayan_2.fastq";
my $numberOfCPU=1;

for($numberOfCPU=2;$numberOfCPU<33;$numberOfCPU*=2){
	for(my $nn=0;$nn<$nFile;$nn++){
		if($fileName[$nn] eq "."||$fileName[$nn] eq "..") {next;}
		if($fileName[$nn]=~/_2/){next;}
		my $snd=$fileName[$nn];
		$snd=~s/_1/_2/;	
		my $command="/usr/bin/time -v -o ./time12/$fileName[$nn]_$numberOfCPU ../software/bowtie2-2.2.5/bowtie2 -p $numberOfCPU -x $refName -1 $dirName$fileName[$nn] -2 $dirName$snd -S ./OutPut/$fileName[$nn]_$numberOfCPU.sam";
		print "$command\n";
		system($command);
	}
}


