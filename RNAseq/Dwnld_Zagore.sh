#!/bin/bash

# The following specifies computing cluster parameters

# Request Resources
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

# Specify Job Name
#SBATCH -J-FastqcandDwnld

#Specify Output and Input Files
#SBATCH -o outputfqsamples.out
#SBATCH -e errorfiledwnld.err

module load sratoolkit

# The following list is all the WT embryonic samples from Zagore et al. NCBI SRA: SRP128645 

array=("SRR6456431" "SRR6456432" "SRR6456433" "SRR6456434" "SRR6456435")

for element in "${array[@]}"; do
    fastq-dump --split-files --gzip ${element}
    echo "${element}"
done

