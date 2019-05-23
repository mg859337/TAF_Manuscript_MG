# Set working directory

list.files()

FileNames <- list.files(path="")

name <- gsub(".gtf","",FileNames)


# The gtf organizing loop for mice
j <- 1

# the number after "<" changes depending on how many count tables are being merged
# made a folder called "TPM_Calc" for files to go to

while(j<17){
  temp <- read.delim(list.files()[j], header = F, row.names = NULL, comment.char="#", stringsAsFactors=FALSE)
  temp2 <- subset(temp, V3 != "exon")
  temp3 <- read.table(text = as.character(temp2[,9]), sep = ";")
  
  geneid <- as.data.frame(gsub(".* ","",temp3[,1]))
  transid <- as.data.frame(gsub(".* ","",temp3[,2]))
  refgen <- as.data.frame(gsub(".* ","",temp3[,3]))
  cov <- as.data.frame(gsub(".* ","",temp3[,4]))
  fpkm <- as.data.frame(gsub(".* ","",temp3[,5]))
  tpm <- as.data.frame(gsub(".* ","",temp3[,5]))
  
  temp4 <- cbind(geneid, transid, refgen, cov, fpkm, tpm)
  
  colnames(temp4) <- c("Gene_ID", "Transcript_ID", "Ref_Gene_ID", "Coverage", "FPKM","TPM")
  
  
  write.csv(temp4, file = paste("/TPM_Calc/", name[j], "_organized.csv", sep = ""), row.names = F)
  
  j <- j + 1
  
}

# Merging the transcripts into just gene names

Files <- list.files(path="/TPM_Calc/")
First <- read.csv(file=paste("/TPM_Calc/", Files[1], sep=""),
                      header=T)


FirstFix <- aggregate(cbind(Coverage, FPKM, TPM) ~ Gene_ID, data = First, FUN = sum)

Second <- read.csv(file=paste("/TPM_Calc/", Files[2], sep=""),
                       header=T)

SecondFix <- aggregate(cbind(Coverage, FPKM, TPM) ~ Gene_ID, data = Second, FUN = sum)

dataMerge <- merge(FirstFix, SecondFix, by="Gene_ID", all=T)

x <- colnames(dataMerge)
fixednames <- gsub(".x", paste("_", name[1]),x)
fixednames <- gsub(".y", paste("_", name[2]),fixednames)
fixednames <- gsub(" ", "", fixednames)

colnames(dataMerge) <- fixednames

for(i in 3:length(Files)){ 
  ReadInMerge <- read.csv(file=paste("/TPM_Calc/", Files[i], sep=""),
                          header=T)
  FixInMerge <- aggregate(cbind(Coverage, FPKM, TPM) ~ Gene_ID, data = ReadInMerge, FUN = sum)
  dataMerge <- merge(dataMerge, FixInMerge, by="Gene_ID", all = T)
  
  fixednames <- colnames(dataMerge)
  fixednames <- gsub(".x", paste("_", name[i-1]),fixednames)
  fixednames <- gsub(".y", paste("_", name[i]),fixednames)
  fixednames <- gsub(" ", "", fixednames)
  colnames(dataMerge) <- fixednames
  
}

setwd("/RNA_seq/")

write.csv(dataMerge, "All_TPM_Maths.csv", row.names = F)

solo <- dataMerge[,names(dataMerge) %in% colnames(dataMerge)[grepl("TPM",colnames(dataMerge))]]
final <- cbind(dataMerge[,1], solo)

write.csv(final, "All_TPMs.csv", row.names = F)




# The gtf organizing loop for humans
j <- 1
while(j<5){
  temp <- read.delim(list.files()[j], header = F, row.names = NULL, comment.char="#", stringsAsFactors=FALSE)
  temp2 <- subset(temp, V3 != "exon")
  temp3 <- read.table(text = as.character(temp2[,9]), sep = ";")
  
  geneid <- as.data.frame(gsub(".* ","",temp3[,1]))
  transid <- as.data.frame(gsub(".* ","",temp3[,2]))
  cov <- as.data.frame(gsub(".* ","",temp3[,3]))
  fpkm <- as.data.frame(gsub(".* ","",temp3[,4]))
  tpm <- as.data.frame(gsub(".* ","",temp3[,5]))
  
  temp4 <- cbind(geneid, transid, cov, fpkm, tpm)
  
  colnames(temp4) <- c("Gene_ID", "Transcript_ID", "Coverage", "FPKM","TPM")
  
  write.csv(temp4, file = paste("/Users/Megan Gura/Documents/Freiman_Lab/Computational/RNA_seq/TPM_Calc/", name[j], "_organized.csv", sep = ""), row.names = F)
  
  j <- j + 1
  
}

# Merging the transcripts into just gene names

Files <- list.files(path="/Users/Megan Gura/Documents/Freiman_Lab/Computational/RNA_seq/TPM_Calc/")
First <- read.csv(file=paste("/Users/Megan Gura/Documents/Freiman_Lab/Computational/RNA_seq/TPM_Calc/", Files[1], sep=""),
                  header=T)


FirstFix <- aggregate(cbind(Coverage, FPKM, TPM) ~ Gene_ID, data = First, FUN = sum)

Second <- read.csv(file=paste("/Users/Megan Gura/Documents/Freiman_Lab/Computational/RNA_seq/TPM_Calc/", Files[2], sep=""),
                   header=T)

SecondFix <- aggregate(cbind(Coverage, FPKM, TPM) ~ Gene_ID, data = Second, FUN = sum)

dataMerge <- merge(FirstFix, SecondFix, by="Gene_ID", all=T)

x <- colnames(dataMerge)
fixednames <- gsub(".x", paste("_", name[1]),x)
fixednames <- gsub(".y", paste("_", name[2]),fixednames)
fixednames <- gsub(" ", "", fixednames)

colnames(dataMerge) <- fixednames

for(i in 3:length(Files)){ 
  ReadInMerge <- read.csv(file=paste("/Users/Megan Gura/Documents/Freiman_Lab/Computational/RNA_seq/TPM_Calc/", Files[i], sep=""),
                          header=T)
  FixInMerge <- aggregate(cbind(Coverage, FPKM, TPM) ~ Gene_ID, data = ReadInMerge, FUN = sum)
  dataMerge <- merge(dataMerge, FixInMerge, by="Gene_ID", all = T)
  
  fixednames <- colnames(dataMerge)
  fixednames <- gsub(".x", paste("_", name[i-1]),fixednames)
  fixednames <- gsub(".y", paste("_", name[i]),fixednames)
  fixednames <- gsub(" ", "", fixednames)
  colnames(dataMerge) <- fixednames
  
}

setwd("/RNA_seq/")

write.csv(dataMerge, "All_TPM_Maths.csv", row.names = F)

solo <- dataMerge[,names(dataMerge) %in% colnames(dataMerge)[grepl("TPM",colnames(dataMerge))]]
final <- cbind(dataMerge[,1], solo)

write.csv(final, "All_TPMs.csv", row.names = F)

