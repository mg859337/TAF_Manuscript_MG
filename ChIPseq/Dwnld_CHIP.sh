#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=48:00:00 
#SBATCH --cpus-per-task=8 
#SBATCH --mem=32G

# Specify a job name: 
#SBATCH -J Dwnld_stra8

# Specify output and error files: 
#SBATCH -o outputfiledwnld.out
#SBATCH -e errorfiledwnld.err

module load sratoolkit

array=("SRR7352911" "SRR7352912" "SRR7352913" "SRR7352914" "SRR7352915" "SRR7352916" "SRR7352917" "SRR7352918" "SRR7352919" "SRR7352920" "SRR7352921" "SRR7352922")

for element in "${array[@]}"; do
	echo I see "${element}"
    fastq-dump --gzip ${element}
done
