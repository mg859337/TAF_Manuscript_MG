#Libraries
library(ImpulseDE2)

#Loading count tables and respective metadata
# Set working directory
setwd("")
list.files()
counts=read.csv("Merged_Counts.csv",head=T,row.names=1)
groups=read.csv("Metadata.csv")
head(groups)

##setting up the data
lsSimulatedData <- simulateDataSetImpulseDE2(
  vecTimePointsA   = rep(seq(1,8),2),
  vecTimePointsB   = NULL,
  vecBatchesA      = NULL,
  vecBatchesB      = NULL,
  scaNConst        = 30,
  scaNImp          = 10,
  scaNLin          = 10,
  scaNSig          = 10,
  scaMuBatchEffect = NULL,
  scaSDBatchEffect = NULL,
  dirOutSimulation = NULL)

lsSimulatedData$matObservedCounts=as.matrix(counts)
lsSimulatedData$dfAnnotation=lsSimulatedData$dfAnnotation[c(1:ncol(counts)),]
groups$Sex=as.character(groups$Sex)
groups$Sex[groups$Sex=="Male"]="case"
lsSimulatedData$dfAnnotation$Condition=as.character(groups$Sex)
groups$Time=as.character(groups$Time)

# Set up as many time points as needed, defined by "Time" variable in metadata

groups$Time[groups$Time=="54d"]=1
groups$Time[groups$Time=="72d"]=2
groups$Time[groups$Time=="74d"]=3
groups$Time[groups$Time=="98d"]=4
groups$Time[groups$Time=="122d"]=5
groups$Time[groups$Time=="137d"]=6

lsSimulatedData$dfAnnotation$Time=as.numeric(groups$Time)

lsSimulatedData$dfAnnotation=lsSimulatedData$dfAnnotation[,c(1:4)]
colnames(lsSimulatedData$matObservedCounts)=row.names(lsSimulatedData$dfAnnotation)

objectImpulseDE2 <- runImpulseDE2(
  matCountData    = lsSimulatedData$matObservedCounts, 
  dfAnnotation    = lsSimulatedData$dfAnnotation,
  boolCaseCtrl    = FALSE,
  vecConfounders  = NULL,
  scaNProc        = 1 )

write.csv(row.names(na.omit(objectImpulseDE2$dfImpulseDE2Results[objectImpulseDE2$dfImpulseDE2Results$padj<.05,])),"casemaleonly_sigs.csv")
write.csv(objectImpulseDE2$dfImpulseDE2Results,"casemaleonly.csv")

# It's a pain to redo all this, so save the Rdata

Males=objectImpulseDE2
save(Females,file="malecaseonly.RData")
