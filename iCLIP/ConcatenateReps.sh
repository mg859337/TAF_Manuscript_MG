#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=12:00:00 
#SBATCH --cpus-per-task=10 
#SBATCH --mem=108G

# Specify a job name: 
#SBATCH -J colorconcat

# Specify output and error files: 
#SBATCH -o outputfilecat.out
#SBATCH -e errorfilecat.err

module load perl

for f in *.mutation.txt; do
echo "${f}"
OUTPUT=$(basename ${f} |cut -f 1 -d ".")
python joinWrapper.py $f $OUTPUT.tag.uniq.bed 4 4 N $OUTPUT.tag.uniq.mutation.txt
done

perl bed2rgb.pl -v -col "188,0,0" SRR6456436.tag.uniq.bed SRR6456436.tag.uniq.rgb.bed
perl bed2rgb.pl -v -col "128,0,128" SRR6456437.tag.uniq.bed SRR6456437.tag.uniq.rgb.bed
perl bed2rgb.pl -v -col "0,128,0" SRR6456438.tag.uniq.bed SRR6456438.tag.uniq.rgb.bed

cat SRR6456436.tag.uniq.rgb.bed SRR6456437.tag.uniq.rgb.bed SRR6456438.tag.uniq.rgb.bed > Pool.tag.uniq.rgb.bed
cat SRR6456436.tag.uniq.mutation.txt SRR6456437.tag.uniq.mutation.txt SRR6456438.tag.uniq.mutation.txt > Pool.tag.uniq.mutation.txt