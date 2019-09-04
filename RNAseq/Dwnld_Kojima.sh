#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=48:00:00 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G

# Specify a job name: 
#SBATCH -J Dwnld_K

# Specify output and error files: 
#SBATCH -o outputfiledwnld.out
#SBATCH -e errorfiledwnld.err

module load sratoolkit

# The following list is all the WT embryonic samples from Kojima et al. NCBI SRA: SRP150721 

array=("SRR7352925" "SRR7352926" "SRR7352927" "SRR7352928" "SRR7352929" "SRR7352930" "SRR7352923" "SRR7352924" "SRR7352931" "SRR7352932" "SRR7352933" "SRR7352934" "SRR7352935" "SRR7352936")

for element in "${array[@]}"; do
	echo I see "${element}"
    fastq-dump --gzip ${element}
done

# Merging technical replicates and renaming

mv SRR7352925.fastq.gz Stra8_KO_rep2_trep1_SRR7352925.fastq.gz
mv SRR7352926.fastq.gz Stra8_KO_rep2_trep2_SRR7352926.fastq.gz

cat Stra8_KO_rep2*.fastq.gz > Stra8_KO_2.fastq.gz

mv SRR7352927.fastq.gz Stra8_KO_rep3_trep1_SRR7352927.fastq.gz
mv SRR7352928.fastq.gz Stra8_KO_rep3_trep2_SRR7352928.fastq.gz

cat Stra8_KO_rep3*.fastq.gz > Stra8_KO_3.fastq.gz

mv SRR7352929.fastq.gz Stra8_low_rep1_trep1_SRR7352929.fastq.gz
mv SRR7352930.fastq.gz Stra8_low_rep1_trep2_SRR7352930.fastq.gz

cat Stra8_low_rep1*.fastq.gz > Stra8_Lo_1.fastq.gz

mv SRR7352923.fastq.gz Stra8_KO_rep1_trep1_SRR7352923.fastq.gz
mv SRR7352924.fastq.gz Stra8_KO_rep1_trep2_SRR7352924.fastq.gz

cat Stra8_KO_rep1*.fastq.gz > Stra8_KO_1.fastq.gz

mv SRR7352931.fastq.gz Stra8_low_rep2_trep1_SRR7352931.fastq.gz
mv SRR7352932.fastq.gz Stra8_low_rep2_trep2_SRR7352932.fastq.gz

cat Stra8_low_rep2*.fastq.gz > Stra8_Lo_2.fastq.gz

mv SRR7352933.fastq.gz Stra8_high_rep1_trep1_SRR7352933.fastq.gz
mv SRR7352934.fastq.gz Stra8_high_rep1_trep2_SRR7352934.fastq.gz

cat Stra8_high_rep1*.fastq.gz > Stra8_Hi_1.fastq.gz

mv SRR7352935.fastq.gz Stra8_high_rep2_trep1_SRR7352935.fastq.gz
mv SRR7352936.fastq.gz Stra8_high_rep2_trep2_SRR7352936.fastq.gz

cat Stra8_high_rep2*.fastq.gz > Stra8_Hi_2.fastq.gz
