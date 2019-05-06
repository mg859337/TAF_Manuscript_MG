#!/bin/bash

# The following specifies computing cluster parameters

# Request Resources
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

# Specify a Job Name
#SBATCH -J FQformatanddwnld

# Specify Output and Input Files
#SBATCH -o outputfqSoh.out
#SBATCH -e errorfileSoh.err

module load sratoolkit

# The following list is all the WT embryonic samples from Soh et al. NCBI GEO: GSE70361

array=("SRR2067543" "SRR2067544" "SRR2067545" "SRR2067546" "SRR2067564" "SRR2067623" "" "SRR2067535" "SRR2067537" "SRR2067538" "SRR2067539" "SRR2067540" "SRR2067541")

for element in "${array[@]}"
do 	
	fastq-dump --gzip $element
	echo "$element"
done

