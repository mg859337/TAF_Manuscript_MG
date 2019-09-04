#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=12:00:00 
#SBATCH --cpus-per-task=10 
#SBATCH --mem=108G

# Specify a job name: 
#SBATCH -J callpeaks

# Specify output and error files: 
#SBATCH -o outputfilepeaks.out
#SBATCH -e errorfilepeaks.err

module load perl

perl tag2peak.pl -ss -v --valley-seeking --valley-depth 0.9 Pool.tag.uniq.rgb.bed Pool.tag.uniq.peak.bed --out-boundary Pool.tag.uniq.peak.boundary.bed --out-half-PH Pool.tag.uniq.peak.halfPH.bed

