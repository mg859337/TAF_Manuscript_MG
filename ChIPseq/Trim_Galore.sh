#!/bin/bash

# The following specifies computing cluster parameters

# Request Resources
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

# Specify Job name
#SBATCH -J Trim_Chipseq

# Specify Output and Input Files
#SBATCH -o outputtrim.out
#SBATCH -e errortrim.err

module load cutadapt
module load fastqc
module load trimgalore

for read in *.fastq.gz; do
echo "I see $read"
trim_galore -q 5 --fastqc ${read}
done
