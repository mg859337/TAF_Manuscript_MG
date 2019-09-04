#!/bin/bash

# The following specifies computing cluster parameters

# Request resources: 
#SBATCH --time=02:00:00 
#SBATCH --cpus-per-task=2 
#SBATCH --mem=64G

# Specify a job name: 
#SBATCH -J Build_index

# Specify output and error files: 
#SBATCH -o outputfileindex.out
#SBATCH -e errorfileindex.err

# Download mm10 genome and unpack

wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Mus_musculus/UCSC/mm10/Mus_musculus_UCSC_mm10.tar.gz
tar -xvf Mus_musculus_UCSC_mm10.tar.gz

cd /Mus_musculus_UCSC_mm10/Mus_musculus/UCSC/mm10/Sequence/Chromosomes

# Custom fasta that lacks M chromosome

cat chr1.fa chr2.fa chr3.fa chr4.fa chr5.fa chr6.fa chr7.fa chr8.fa chr9.fa chr10.fa chr11.fa chr12.fa chr13.fa chr14.fa chr15.fa chr16.fa chr17.fa chr18.fa chr19.fa chr20.fa chr21.fa chr22.fa chrX.fa chrY.fa > mm10.fa 

# Make genome index

module load bwa

bwa index -a bwtsw mm10.fa