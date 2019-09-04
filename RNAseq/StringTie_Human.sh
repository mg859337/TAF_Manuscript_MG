#!/bin/bash

# Parameters for computing nodes

# Request Resources
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=55G

# Specify Job name
#SBATCH -J STRINGTIE_TPM

# Specify Job Output and Input Files
#SBATCH -o outputfilestringtie.out
#SBATCH -e errorfilestringtie.err

# stringtie <aligned_reads.bam> [options]*

module load stringtie

# folder name changes based on dataset
folder=foldernamegoeshere
echo "folder = $folder"

for aligned in *.bam; do
OUTPUT=$(basename ${aligned} |cut -f 1 -d ".");
echo "Output = $OUTPUT";

stringtie ${aligned} -o ~/data/mgura/${folder}/gtfs/${OUTPUT}.gtf -G /users/mgura/data/mgura/genomes/Human/official_human.gtf -l ${OUTPUT} -A ~/data/mgura/${folder}/tabs/${OUTPUT}.tab -e
done
