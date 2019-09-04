library(DESeq2)
library(ggplot2)

# set the working directory

list.files()
countData <- read.csv("Count_Table.csv", row.names = 1, header = TRUE, sep = ",")
head(countData)
groups <-read.csv("Metadata.csv",  header = T, sep = ",")
head(groups)

# I typically put numbers in my groups metadata column, so I need to tell R to look at them as a factor instead of an interger,
# so you probably don't need this line if you don't use numbers:

groups$Group <- as.factor(groups$Group)

# Formatting the data into a dds

dds <- DESeqDataSetFromMatrix(countData, colData = groups , design = ~ Name)

# This is the transformation that the PCA plot will be using
vsd <- vst(dds, blind=TRUE)

# Making the PCA plot. "Name" and "Sex" are column titles in my metadata that went into my dds

pcaData <- plotPCA(vsd, intgroup=c("Name","Sex"), returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, color=Name, shape=Sex)) +
  geom_point(size=4) +
  theme(legend.text=element_text(size=14)) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  coord_fixed()
