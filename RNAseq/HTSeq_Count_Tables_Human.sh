#! /bin/bash

# The following specifies computing cluster parameters

# Request resources:
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=55G

# Specify a job name:
#SBATCH -J HTSeq_Tables_K

# Specify output and error files:
#SBATCH -o outputfilehtseq.out
#SBATCH -e errorfilehtseq.err

module load htseq

# Change folder name for each dataset

folder=foldernamehere

for bam in *.bam; do
OUTPUT=$(basename ${bam} |cut -f 1 -d ".");

HTinfile="(\"""/users/mgura/data/mgura/${folder}/${bam}""\")";
HToutfile="(\"""/users/mgura/data/mgura/${folder}/${OUTPUT}_Count_Table.txt""\")";

annotation_file="/users/mgura/data/mgura/genomes/Human/official_human.gtf";

echo "infile="$HTinfile> HTSeq_Code.py;
echo "outfile="$HToutfile >> HTSeq_Code.py;
echo "annotation_file=""(\"""$annotation_file""\")">>HTSeq_Code.py;

cat HTSeq_Template.py>>HTSeq_Code.py;

python HTSeq_Code.py;

done
