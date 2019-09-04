#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=48:00:00 
#SBATCH --cpus-per-task=8 
#SBATCH --mem=32G

# Specify a job name: 
#SBATCH -J Dwnld_dazl

# Specify output and error files: 
#SBATCH -o outputfiledwnld.out
#SBATCH -e errorfiledwnld.err

module load sratoolkit

# The following list is all the P6 iCLIP samples from Zagore et al. NCBI GEO: GSE108183

array=("SRR6456436" "SRR6456437" "SRR6456438")

for element in "${array[@]}"; do
	echo I see "${element}"
    fastq-dump --gzip ${element}
done



