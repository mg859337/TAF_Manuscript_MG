#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=48:00:00 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G

# Specify a job name: 
#SBATCH -J Dwnld_T

# Specify output and error files: 
#SBATCH -o outputfiledwnld.out
#SBATCH -e errorfiledwnld.err

module load sratoolkit

# The following list is all the WT embryonic samples from Tang et al. NCBI SRA: SRP057098 

array=("SRR1777312" "SRR1777313" "SRR1777314" "SRR1777315" "SRR1777316" "SRR1777317")

for element in "${array[@]}"; do
	echo I see "${element}"
    fastq-dump --gzip ${element}
done

# Samples were renamed for convienience

mv SRR1777312.fastq.gz Soma_Wk7F_1_SRR1777312.fastq.gz
mv SRR1777313.fastq.gz Soma_Wk7F_2_SRR1777313.fastq.gz
mv SRR1777314.fastq.gz Soma_Wk7F_3_SRR1777314.fastq.gz

mv SRR1777315.fastq.gz hPGC_Wk7F_1_SRR1777315.fastq.gz
mv SRR1777316.fastq.gz hPGC_Wk7F_2_SRR1777316.fastq.gz
mv SRR1777317.fastq.gz hPGC_Wk7F_3_SRR1777317.fastq.gz

