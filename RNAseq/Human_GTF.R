# In the hg38_RefSeq_refgene.gtf downloaded from UCSC, some genes had a transcript ID but no gene ID. 
# Transcript IDs were converted using DAVID and this script is to add in the gene IDs
# This made a new gtf file for StringTie and HTSeq

setwd("/Users/Megan Gura/Documents/Freiman_Lab/Computational/R_Studio/Human_GTF")
list.files()

refseq_conversion <- read.csv("full_conversion.csv", row.names=NULL, header = F)

# Make all gene names uppercase

key <- refseq_conversion
key[,2] <- toupper(refseq_conversion[,2])

# Load gtf that needs gene names added

hg38_RefSeq_refGene <- read.delim("hg38_RefSeq_refGene.gtf", header=FALSE)
head(hg38_RefSeq_refGene)

ids <- as.data.frame(hg38_RefSeq_refGene[,9])
head(ids)

# Segregate gene ids from transcript ids, an empty third column results

split <- read.table(text = as.character(ids[,1]), sep = ";")
head(split)

# Isolating just the "gene_ids" of the first column

geneid <- as.data.frame(gsub(".* ","",split[,1]))
head(geneid)

# Put only these ids into the last column of the starting .gtf

hg38_RefSeq_refGene[,9] <- geneid
head(hg38_RefSeq_refGene)

# replace these with their gene names in "key"

newref <- merge(hg38_RefSeq_refGene,key, by.x = "V9", by.y= "V1", all = F)
head(newref)

# Start rebuilding original format of gtf ids

new_ids <- cbind(as.data.frame(newref[,1]), as.data.frame(newref[,10]))
head(new_ids)


new_trans <- as.data.frame(paste0(new_ids[,1], ";"))
new_genes <- as.data.frame(paste0(new_ids[,2], ";"))

new_trans <- as.data.frame(sapply(new_trans[,1], function(x) paste("transcript_id", x)))
new_genes <- as.data.frame(sapply(new_genes[,1], function(x) paste("gene_id", x)))

# Orient edited ids together

final <- data.frame()
final <- paste(new_genes[,1], new_trans[,1], sep=" ")
final <- as.data.frame(final)
head(final)

# Save just in case

write.csv(final, "record.csv", row.names = F, col.names = F, quote = F)


# merge to reference gtf that was organized so that we're adding the right ids for each row

official <- cbind(as.data.frame(newref[,2:9]), as.data.frame(final[,1]))
head(official)

# organize data frame to order it closer to what it was intitally

new <- official[order(official[,1], official[,4]), ]
head(new)

# Save new human gtf, add quotes around gene_id and transcript_id names in Notepad++

write.table(new, "official_human.gtf", row.names = F, col.names = F, quote = F, sep = "\t")
