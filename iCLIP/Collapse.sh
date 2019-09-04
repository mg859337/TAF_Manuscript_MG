#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=06:00:00 
#SBATCH --cpus-per-task=8 
#SBATCH --mem=64G

# Specify a job name: 
#SBATCH -J collapse

# Specify output and error files: 
#SBATCH -o outputfilecoll.out
#SBATCH -e errorfilecoll.err

# Will be executing perl script from CTK

module load perl

# An iterative way to run the fastq2collapse perl script

for f in *.trim.fastq.gz; do
echo "${f}"
OUTPUT=$(basename ${f} |cut -f 1 -d ".")
perl fastq2collapse.pl ${f} - | gzip -c > ${OUTPUT}.trim.c.fastq.gz
done
