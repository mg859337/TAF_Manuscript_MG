#!/bin/bash

# The following specifies computing cluster parameters
# This file was used for Soh and Kojima

# Request Resources
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=48G

# Specify Job name
#SBATCH -J HISAT2_Mouse

# Specify Job Output and Input Files
#SBATCH -o outputfilealign.out
#SBATCH -e errorfilealign.err

module load hisat2
module load samtools

DBDIR="/users/mgura/data/mgura/genomes/Mouse/HiSat2_mm10"
GENOME="genome"

for fastq in *.fastq.gz; do
	OUTPUT=$(basename ${fastq} |cut -f 1 -d "."); 
	echo "Output = $OUTPUT";

	hisat2 \
		--dta \
		-x ${DBDIR}/${GENOME} \
		-U ${fastq} \
		-S ${OUTPUT}.sam &> ${OUTPUT}.log

	samtools sort -o ${OUTPUT}.bam ${OUTPUT}.sam

done 
