#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=06:00:00 
#SBATCH --cpus-per-task=8 
#SBATCH --mem=64G

# Specify a job name: 
#SBATCH -J trim linker

# Specify output and error files: 
#SBATCH -o outputfilelinker.out
#SBATCH -e errorfilelinker.err

module load cutadapt

# Lightly trim and remove 3' linker sequence

for f in *.fastq.gz; do
OUTPUT=$(basename ${f} |cut -f 1 -d ".");
cutadapt -f fastq --times 1 -e 0 -O 1 --quality-cutoff 5 -m 24 -a GUGUCAGUCACUUCCAGCGG -o ${OUTPUT}.trim.fastq.gz ${f} > ${OUTPUT}.cutadapt.log
done
