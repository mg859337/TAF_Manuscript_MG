#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=12:00:00 
#SBATCH --cpus-per-task=8 
#SBATCH --mem=108G

# Specify a job name: 
#SBATCH -J align_ctk

# Specify output and error files: 
#SBATCH -o outputfilealign.out
#SBATCH -e errorfilealign.err

module load bwa

# Iteratively run bwa to align samples to mm10 genome

for f in *.trim.c.fastq.gz; do
OUTPUT=$(basename ${f} |cut -f 1 -d ".")
echo "${OUTPUT}"
bwa aln -t 4 ./Mus_musculus/UCSC/mm10/Sequence/Chromosomes/mm10.fa ${f} > ${OUTPUT}.sai
bwa samse ./Mus_musculus/UCSC/mm10/Sequence/Chromosomes/mm10.fa ${OUTPUT}.sai ${f} | gzip -c > ${OUTPUT}.sam.gz
done

