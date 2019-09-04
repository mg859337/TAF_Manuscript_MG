#!/bin/bash

# Request Resources
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=9
#SBATCH --mem=32G

# Specify Job Name
#SBATCH -J FastQC_chip

#Specify Output and Input Files

#SBATCH -o outputfqc.out
#SBATCH -e errorfqc.err

module load fastqc

for item in *.fastq.gz; do
	echo I see ${item}
	fastqc ${item}
done

