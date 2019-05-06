#!/bin/bash

# The following specifies computing cluster parameters

# Request Resources
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=8G

# Specify Job Name
#SBATCH -J FastQC

#Specify Output and Input Files
#SBATCH -o outputfqc.out
#SBATCH -e errorfqc.err

module load fastqc

for item in *.fastq.gz; do
	echo I see ${item}
	fastqc ${item}
done

