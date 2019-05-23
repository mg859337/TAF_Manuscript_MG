
library(DESeq2)

# Set the working directory

list.files()
countData <- read.csv("Count_Table.csv", row.names = 1, header = TRUE, sep = ",")
head(countData)
groups <-read.csv("Metadata.csv", row.names = NULL, header = T, sep = ",")
head(groups)

# I typically put numbers in my groups metadata column, so I need to tell R to look at them as a factor instead of an interger,
# so you probably don't need this line if you don't use numbers:


str(groups)
groups$Group <- as.factor(groups$Group)


#Might need to move around columns in countData

dds <- DESeqDataSetFromMatrix(countData, colData = groups , design = ~ Group)
dds <- DESeq(dds)

resultsNames(dds)
res <- results(dds, contrast=c("Group","4","3"))
summary(res)
write.csv(res, file = "results_MWT_MDEF.csv")

