#!/bin/bash

# The following specifies computing cluster parameters

# Request Resources
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=108G

# Specify Job Name
#SBATCH -J MACS2

#Specify Output and Input Files
#SBATCH -o outputmacs2.out
#SBATCH -e errormacs2.err

module load macs

for file in *FLAG_1_filtered.bam; do
	OUTPUT=$(basename ${file} | cut -f 1-3 -d "_")
	CONTROL=$(basename ${file} | cut -f 1 -d "_")
	echo "output=$OUTPUT"
	echo "control=$CONTROL"
	macs2 callpeak -t ${file} \
	-c ${CONTROL}_Input_1_filtered.bam \
	-f BAM -g mm \
	-n ${OUTPUT} \
	--outdir macs2 2> ${OUTPUT}.log
done

for file2 in *FLAG_2_filtered.bam; do
	OUTPUT2=$(basename ${file2} | cut -f 1-3 -d "_")
	CONTROL2=$(basename ${file2} | cut -f 1 -d "_")
	echo "output2=$OUTPUT2"
	echo "control2=$CONTROL2"
	macs2 callpeak -t ${file2} \
	-c ${CONTROL2}_Input_2_filtered.bam \
	-f BAM -g mm \
	-n ${OUTPUT2} \
	--outdir macs2 2> ${OUTPUT2}.log
done

for file3 in *FLAG_3_filtered.bam; do
	OUTPUT3=$(basename ${file3} | cut -f 1-3 -d "_")
	CONTROL3=$(basename ${file3} | cut -f 1 -d "_")
	echo "output3=$OUTPUT3"
	echo "control3=$CONTROL3"
	macs2 callpeak -t ${file3} \
	-c ${CONTROL3}_Input_3_filtered.bam \
	-f BAM -g mm \
	-n ${OUTPUT3} \
	--outdir macs2 2> ${OUTPUT3}.log
done
