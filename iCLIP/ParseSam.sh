#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=12:00:00 
#SBATCH --cpus-per-task=10 
#SBATCH --mem=108G

# Specify a job name: 
#SBATCH -J parse_ctk

# Specify output and error files: 
#SBATCH -o outputfileparse.out
#SBATCH -e errorfileparse.err

module load perl

# Iteratively run the parseAlignment code

for f in *.sam.gz; do
echo "${f}"
OUTPUT=$(basename ${f} |cut -f 1 -d ".")
perl parseAlignment.pl -v --map-qual 1 --min-len 18 --mutation-file ${OUTPUT}.mutation.txt ${f} ${OUTPUT}.tag.bed
done

