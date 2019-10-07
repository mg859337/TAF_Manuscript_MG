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

# The following list is all the ChIPs-seq samples from Kojima et al. NCBI GEO: GSE115928

array=("SRR7352917" "SRR7352918" "SRR7352919" "SRR7352920" "SRR7352921" "SRR7352922")

for element in "${array[@]}"; do
	echo I see "${element}"
	fastq-dump --gzip ${element}
done
