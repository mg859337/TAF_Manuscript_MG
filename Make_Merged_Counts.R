#Set working directory

setwd()
list.files()

FileNames <- list.files(path="/Count_Tables")
name <- gsub("_Count_Table.txt","",FileNames)


data <- read.csv("1_Count_Table.txt", row.names = 1, header = F, sep = " ")
head(data)
data2 <- read.csv("2_Count_Table.txt", row.names = 1, header = F, sep = " ")
head(data2)


j <- 2

# what comes after "<" is different based on number of files

while(j<8){
  temp<-read.csv(list.files()[j],row.names = 1, header = F, sep = " ")


i <- 1
while(i<nrow(data)) { 
  if(row.names(data)[i]!=row.names(temp)[i]){
    print(paste("row number",i,"is not the same", sep = ""))
  }
  i = i + 1
}
print(list.files()[j])
j <- j + 1
}

colnames(data) <-name[1]
head(data)

colnames(data2) <- name[2]
head(data2)



alldata <- cbind(data,data2)
head(alldata)

j <- 3
while(j<8){
  temp<-read.csv(list.files()[j],row.names = 1, header = F, sep = " ")
  colnames(temp) <- name[j]
  alldata <- cbind(alldata,temp)
  j <- j + 1
}

head(alldata)

write.csv(alldata, "Merged_Counts.csv")
