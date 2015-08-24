use strict;
my $dirName="./time_bwa/";
#my $dirName="./time_bwa0.5.7/";
opendir(DIR,$dirName);
my @fileName=readdir(DIR);
closedir(DIR);

for(my $nn=0;$nn<=$#fileName;$nn++){
	if($fileName[$nn] eq "."||$fileName[$nn] eq "..") {next;}
	#printf "$fileName[$nn] $#fileName\n";
	my $filePerfix="V10_1";
	if($fileName[$nn]=~/^$filePerfix/){
		my $file_1=$fileName[$nn];
		my $file_2=$fileName[$nn];
		$file_2=~s/_1/_2/;
		my $threadNum=0;
		if($file_1=~/.*\_(\d+)$/){ $threadNum=$1; };
		print "$file_1\n";
		open(FILE,"< $dirName$file_1")||die "can't open file!\n";
		my @linelist=<FILE>;
		close FILE;
		my $userTime;
		my $sysTime;
		my $realTime;
		my $PercentOfCpu;
		foreach my $eachline(@linelist){
			if($eachline=~/User time.*: (\d+\.\d+)$/){ 
				print "user time mech! $1\n";
				$userTime+=$1;
			}	
			elsif($eachline=~/System time.*: (\d+\.\d+)$/){
				print "sys time mech! $1\n";
				 $sysTime+=$1;
			}
			elsif($eachline=~/Elapsed .*: (\d*:)?(\d+):(\d\d)/){
				print "real time mech! $1$2:$3\n";
				$realTime+=($2*60+$3);
				if($1=~/(\d+):/) {$realTime+=($1*3600);}
			}
			elsif($eachline=~/Percent of CPU .*: (\d+)%/){
				print("Percent of  Cpu mech! $1\n");
				$PercentOfCpu+=$1;
			}
		}
		#################### file_2 ############################
		open(FILE,"< $dirName$file_2")||die "can't open file!\n";
		my @linelist2=<FILE>;
		close FILE;
		
		foreach my $eachline(@linelist2){
			if($eachline=~/User time.*: (\d+\.\d+)$/){ 
				print "user time mech! $1\n";
				$userTime+=$1;
			}	
			elsif($eachline=~/System time.*: (\d+\.\d+)$/){
				print "sys time mech! $1\n";
				$sysTime+=$1;
			}
			elsif($eachline=~/Elapsed .*: (\d*:)?(\d+):(\d\d)/){
				print "real time mech! $1$2:$3\n";
				$realTime+=($2*60+$3);
				if($1=~/(\d+):/){$realTime+=($1*3600)}
			}
			elsif($eachline=~/Percent of CPU .*: (\d+)%/){
				print "Percent of  C mech! $1\n";
				$PercentOfCpu+=$1;
			}
		}
		$PercentOfCpu/=2;
		print "$filePerfix thread: $threadNum\n
				real time: $realTime\n
				percent of cpu:$PercentOfCpu\n
				user time: $userTime\n
				sys time: $sysTime\n";		
	}
}
