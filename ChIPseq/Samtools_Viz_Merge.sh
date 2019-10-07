#!/bin/bash

# The following specifies computing cluster parameters

# Request Resources
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=108G

# Specify Job Name
#SBATCH -J Merge_Kojima

#Specify Output and Input Files
#SBATCH -o outputmerge.out
#SBATCH -e errormerge.err

module load samtools

#Merging FLAG bam files

samtools merge FF_FLAG.bam FF_FLAG_1_filtered.bam FF_FLAG_2_filtered.bam FF_FLAG_3_filtered.bam

#Merging FLAG bam files
samtools merge FF_Input.bam FF_Input_1_filtered.bam FF_Input_2_filtered.bam FF_Input_3_filtered
