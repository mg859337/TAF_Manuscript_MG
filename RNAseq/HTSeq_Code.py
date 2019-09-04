infile=("/users/mgura/data/mgura/Kojima_Redo/Stra8_Lo_2.bam")
outfile=("/users/mgura/data/mgura/Kojima_Redo/Stra8_Lo_2_Count_Table.txt")
annotation_file=("/users/mgura/data/mgura/genomes/Mouse/UCSC_mm10_Mus_musculus/UCSC_mm10_genes.gtf")

import HTSeq
import itertools
import numpy

gtf_file=HTSeq.GFF_Reader(annotation_file)

exons=HTSeq.GenomicArrayOfSets("auto",stranded=False)

for feature in gtf_file:
	if feature.type=="exon":
		exons[feature.iv]+= feature.name

counts={}
for feature in gtf_file:
	if feature.type=="exon":
		counts[feature.name]=0

bam_file=HTSeq.BAM_Reader(infile)
for alnmt in bam_file:
	if alnmt.aligned:
		iset=None
		for iv2, step_set in exons[alnmt.iv].steps():
			if iset is None:
				iset=step_set.copy()
			else:
				iset.intersection_update(step_set)
		if len(iset)==1:
			counts[list(iset)[0]] +=1

file=open(outfile,'w')
for name in sorted(counts.keys()):
	print>>file, name, counts[name]

file.close()
