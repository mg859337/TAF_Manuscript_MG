#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=12:00:00 
#SBATCH --cpus-per-task=10 
#SBATCH --mem=108G

# Specify a job name: 
#SBATCH -J pcrcollapse

# Specify output and error files: 
#SBATCH -o outputfilepcr.out
#SBATCH -e errorfilepcr.err

module load perl

for f in *.tag.norRNA.bed; do
echo "${f}"
OUTPUT=$(basename ${f} |cut -f 1 -d ".")
perl tag2collapse.pl -v -EM -1 --seq-error-model alignment -weight --weight-in-name --keep-max-score --keep-tag-name $f $OUTPUT.tag.uniq.bed
done
