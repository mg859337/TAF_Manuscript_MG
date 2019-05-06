#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=48:00:00 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G

# Specify a job name: 
#SBATCH -J Dwnld_I

# Specify output and error files: 
#SBATCH -o outputfiledwnld.out
#SBATCH -e errorfiledwnld.err

module load sratoolkit

# The following list is all the WT embryonic samples from Irie et al. NCBI SRA: SRP045294 

array=("SRR1537296" "SRR1537297" "SRR1537298" "SRR1537299")

for element in "${array[@]}"; do
	echo I see "${element}"
    fastq-dump --gzip ${element}
done

# Renamed samples

mv SRR1537296.fastq.gz hPCG_Wk7M_1_SRR1537296.fastq.gz
mv SRR1537297.fastq.gz hPGC_Wk7M_2_SRR1537297.fastq.gz

mv SRR1537298.fastq.gz Soma_Wk7M_1_SRR1537298.fastq.gz
mv SRR1537299.fastq.gz Soma_Wk7M_2_SRR1537299.fastq.gz

