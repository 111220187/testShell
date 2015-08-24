use strict;
my  $alnDir="./human_aln-5-1/";
my $fastqDir="~/Pipeline1/main/a_fastq_change/";
my  $casmapDir="~/Pipeline1/casmap";
my $samDir="./fpga_sam-5-1/";
my $refFile="~/Pipeline1/library/hg19/genome.fa";
opendir(DIR,$alnDir);
my @filename=readdir(DIR);
closedir(DIR);

for(my $nn=0;$nn<=$#filename;$nn++){
	if($filename[$nn]=~/\.aln$/) {
		my $command="$casmapDir/cm_aln2pos $refFile $alnDir$filename[$nn]";
		print "$command\n";
		system($command);
		my $fastq=$filename[$nn];
		$fastq=~s/.aln//;
		$command="$casmapDir/cm_pos2sam -f $samDir$filename[$nn].sam -t 32 $refFile $alnDir$filename[$nn].pos $fastqDir/$fastq";
		print("$command\n");
		system($command);
	}
}
