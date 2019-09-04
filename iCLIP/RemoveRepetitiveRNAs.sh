#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=12:00:00 
#SBATCH --cpus-per-task=10 
#SBATCH --mem=108G

# Specify a job name: 
#SBATCH -J repetitive_ctk

# Specify output and error files: 
#SBATCH -o outputfilerep.out
#SBATCH -e errorfilerep.err

module load perl

for f in *.tag.bed; do
echo "${f}"
OUTPUT=$(basename ${f} |cut -f 1 -d ".")
perl tagoverlap.pl -big -region ./annotation/genomes/mm10/annotation/rmsk.RNA.bed -ss --complete-overlap -r --keep-tag-name --keep-score -v ${f} ${OUTPUT}.tag.norRNA.bed
done
