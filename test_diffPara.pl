use strict;
my $dirName="./a_fastq_change";
my $fastqFile="V9_1.fastq";
my $refFile="../library/gen_bwa0.5.7/genome.fa";
for(my $maxDiff=5;$maxDiff<6;$maxDiff++){
	for(my $maxGap=0;$maxGap<3;$maxGap++){
		my $command="/usr/bin/time -v -o ./time_bwa_DiffPara/$fastqFile$maxDiff$maxGap ../software/bwa-0.5.7/bwa aln -t 32 -n $maxDiff -e $maxGap $refFile $dirName/$fastqFile 1>/dev/null";
		print "$command\n";
		system($command);
	}

}
