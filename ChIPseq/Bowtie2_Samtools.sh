#!/bin/bash

# The following specifies computing cluster parameters

# Request Resources
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=108G

# Specify Job Name
#SBATCH -J Bowtie2_Kojima

#Specify Output and Input Files
#SBATCH -o outputbowtie2.out
#SBATCH -e errorbowtie2.err

module load bowtie2
module load samtools
module load bedtools

#Aligning every file in folder:
for item in *_trimmed.fastq.gz; do
	INPUT=$(basename ${item} | cut -f 1 -d ".")
	OUTPUT=$(basename ${item} | cut -f 1-3 -d "_")
	echo "input=$INPUT"
	echo "output=$OUTPUT"
	gunzip ${INPUT}.fastq.gz
	new=${INPUT}.fastq
	echo "new=$new"
	bowtie2 -x ~/data/genomes/Mouse/UCSC_mm10/genome -U ${new} -S ${OUTPUT}_unsorted.sam
	# Remove copy of fastq
	unsorted=${OUTPUT}_unsorted.sam
	echo "unsorted=$unsorted"
	gzip ${new}
	# Convert to bam
	samtools view -S -b ${unsorted} > ${OUTPUT}_unsorted.bam
	bam=${OUTPUT}_unsorted.bam
	echo "bam=$bam"
	# Remove sam file
	rm ${unsorted}
	# Sort for name
	samtools sort -n ${bam} -o ${OUTPUT}_sorted.bam
	sorted=${OUTPUT}_sorted.bam
	echo "sorted=$sorted"
	# Mark duplicates and remove unmapped:
	samtools fixmate -r -m ${sorted} ${OUTPUT}_fixmate.bam
	fixed=${OUTPUT}_fixmate.bam
	echo "fixed=$fixed"
	# Sort for position:
	samtools sort ${fixed} -o ${OUTPUT}_fixsort.bam
	fixsort=${OUTPUT}_fixsort.bam
	echo "fixsort=$fixsort"
	# Remove marked duplicates:
	samtools markdup -l 40 -r -s ${fixsort} ${OUTPUT}_dedup.bam
	dedup=${OUTPUT}_dedup.bam
	echo "dedup=$dedup"
	bedtools intersect -v -a ${dedup} -b ~/data/genomes/Mouse/UCSC_mm10/mm10.blacklist.bed > ${OUTPUT}_filtered.bam
	# Indexing an position sorted BAM file to extract alignments overlapping particular genomic regions:
	samtools index ${OUTPUT}_filtered.bam
done
