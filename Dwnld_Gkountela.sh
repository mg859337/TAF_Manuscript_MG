#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G

# Specify a job name: 
#SBATCH -J Dwnld_Gkountela

# Specify output and error files: 
#SBATCH -o outputfiledwnld.out
#SBATCH -e errorfiledwnld.err

module load sratoolkit

# The following list is all the WT embryonic samples from Gkountela et al. NCBI SRA: SRP049981

array=("SRR1654903" "SRR1654904" "SRR1654905" "SRR1654906" "SRR1654907" "SRR1654908" "SRR1654909" "SRR1654910" "SRR1654911" "SRR1654912" "SRR1654913" "SRR1654914" "SRR1654915" "SRR1654916" "SRR1654917")

for element in "${array[@]}"; do
	echo I see "${element}"
    fastq-dump --gzip ${element}
done

# Renaming samples 

mv SRR1654903.fastq.gz f53d_1_SRR1654903.fastq.gz
mv SRR1654904.fastq.gz f53d_2_SRR1654904.fastq.gz
mv SRR1654905.fastq.gz f57d_SRR1654905.fastq.gz
mv SRR1654906.fastq.gz f67d_SRR1654906.fastq.gz
mv SRR1654907.fastq.gz f93d_SRR1654907.fastq.gz
mv SRR1654908.fastq.gz f94d_SRR1654908.fastq.gz
mv SRR1654909.fastq.gz f108d_SRR1654909.fastq.gz
mv SRR1654910.fastq.gz f110d_SRR1654910.fastq.gz
mv SRR1654911.fastq.gz f113d_SRR1654911.fastq.gz

mv SRR1654912.fastq.gz m54d_SRR1654912.fastq.gz
mv SRR1654913.fastq.gz m72d_SRR1654913.fastq.gz
mv SRR1654914.fastq.gz m74d_SRR1654914.fastq.gz
mv SRR1654915.fastq.gz m98d_SRR1654915.fastq.gz
mv SRR1654916.fastq.gz m122d_SRR1654916.fastq.gz
mv SRR1654917.fastq.gz m137d_SRR1654917.fastq.gz