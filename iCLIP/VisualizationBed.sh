#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=12:00:00 
#SBATCH --cpus-per-task=10 
#SBATCH --mem=108G

# Specify a job name: 
#SBATCH -J visualization

# Specify output and error files: 
#SBATCH -o outputfileviz.out
#SBATCH -e errorfileviz.err

module load perl

perl bed2annotation.pl -dbkey mm10 -ss -region -v -summary Pool.tag.uniq.annot.summary.txt Pool.tag.uniq.rgb.bed Pool.tag.uniq.annot.txt

perl tag2profile.pl -v -ss -of bedgraph -n ″Unique Tag Profile″ Pool.tag.uniq.rgb.bed Pool.tag.uniq.bedgraph
