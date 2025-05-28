library(BiocManager)
library("limma")
library("statmod")

#read in file
Data <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/NoNAresults.txt", sep="\t", row.names = 1, header=TRUE)
#Data <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Limma/LimmaTvC.txt", sep="\t", row.names = 1, header=TRUE)
#Data <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Limma/LimmaTvA.txt", sep="\t", row.names = 1, header=TRUE)
#Data <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Limma/LimmaAvC.txt", sep="\t", row.names = 1, header=TRUE)

samples <- Data[c("Norm.Tam15","Norm.Tam20","Norm.Tam23","Norm.Tam4","Norm.Tam13","Norm.Tam5","Norm.Agg52","Norm.Agg55","Norm.Agg44","Norm.Agg64","Norm.Agg50","Norm.Con71","Norm.Con73","Norm.Con74","Norm.Con77","Norm.Con83")]

#make design marix to say which sample is in which group
groups <- c(rep("Tame",6), rep("Aggressive", 5), rep("Conventional", 5))
design <-model.matrix(~0+groups)
colnames(design) <-c("Aggressive","Conventional","Tame")
rownames(design) <-c("Norm.Tam15","Norm.Tam20","Norm.Tam23","Norm.Tam4","Norm.Tam13","Norm.Tam5","Norm.Agg52","Norm.Agg55","Norm.Agg44","Norm.Agg64","Norm.Agg50","Norm.Con71","Norm.Con73","Norm.Con74","Norm.Con77","Norm.Con83")

#fit linear model
linmod <- lmFit(samples, design)

#Make Contrast Matrix to tell the model what groups you want to compare
contrast.matrix <- makeContrasts(TvsA = Tame - Aggressive,TvsC = Tame - Conventional,AvsC = Aggressive - Conventional, levels = colnames(design))

#fit the contrast matrix to the model
fit2 <- contrasts.fit(linmod, contrast.matrix)
fit2 <- eBayes(fit2)

#results
resultsTvsA <- topTable(fit2, coef = "TvsA", adjust = "BH", number=Inf, sort.by = "none")
resultsTvsC <- topTable(fit2, coef = "TvsC", adjust = "BH", number=Inf, sort.by = "none")
resultsAvsC <- topTable(fit2, coef = "AvsC", adjust = "BH", number=Inf, sort.by = "none")

#combine results into 1 table
colnames(resultsTvsA) <- paste0("TvsA_", colnames(resultsTvsA))
colnames(resultsTvsC) <- paste0("TvsC_", colnames(resultsTvsC))
colnames(resultsAvsC) <- paste0("AvsC_", colnames(resultsAvsC))

results <-cbind(Data,resultsTvsA,resultsTvsC,resultsAvsC)

#results <-cbind(Data,resultsTvsC)
#results <-cbind(Data,resultsTvsA)
#results <-cbind(Data,resultsAvsC)

write.csv(results, "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Limma/LimmaUngrouped.csv", row.names = TRUE)

#write.csv(results, "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Limma/TvCLimmaResults.csv", row.names = TRUE)
#write.csv(results, "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Limma/TvALimmaResults.csv", row.names = TRUE)
#write.csv(results, "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Limma/AvCLimmaResults.csv", row.names = TRUE)
