#Read in 2 tailed pvalues for TvC TvA AvC and correct pvalues and save
TvC2 <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/tTest/UncorrectedTvC.txt", sep = "\n")
TvA2 <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/tTest/UncorrectedTvA.txt", sep = "\n")
AvC2 <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/tTest/UncorrectedAvC.txt", sep = "\n")
#TvC1 <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/BenjaminiHochberg/1tailTvC.txt", sep = "\n")
#TvA1 <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/BenjaminiHochberg/1tailTvA.txt", sep = "\n")
#AvC1 <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/BenjaminiHochberg/1tailAvC.txt", sep = "\n")

#Unlist the table
TvC2 <- unlist(TvC2,use.names = FALSE)
TvA2 <- unlist(TvA2,use.names = FALSE)
AvC2 <- unlist(AvC2,use.names = FALSE)
#TvC1 <- unlist(TvC1,use.names = FALSE)
#TvA1 <- unlist(TvA1,use.names = FALSE)
#AvC1 <- unlist(AvC1,use.names = FALSE)

#Run Benjamini Hochsburg
TvC2.corrected <- p.adjust(TvC2,method = "BH")
TvA2.corrected <- p.adjust(TvA2,method = "BH")
AvC2.corrected <- p.adjust(AvC2,method = "BH")
#TvC1.corrected <- p.adjust(TvC1,method = "BH")
#TvA1.corrected <- p.adjust(TvA1,method = "BH")
#AvC1.corrected <- p.adjust(AvC1,method = "BH")

#Double Check
#View(TvC2.corrected)
#View(TvC2)
#View(TvA2.corrected)
#View(TvA2)
#View(AvC2.corrected)
#View(AvC2)

#turn results into a list
TvC2.corrected.frame <- data.frame(TvC2.corrected)
TvA2.corrected.frame <- data.frame(TvA2.corrected)
AvC2.corrected.frame <- data.frame(AvC2.corrected)
#TvC1.corrected.frame <- data.frame(TvC1.corrected)
#TvA1.corrected.frame <- data.frame(TvA1.corrected)
#AvC1.corrected.frame <- data.frame(AvC1.corrected)

#Write out results
write.table(TvC2.corrected.frame[1], "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/tTest/CorrectedTvC.txt", row.names = FALSE)
write.table(TvA2.corrected.frame[1], "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/tTest/CorrectedTvA.txt", row.names = FALSE)
write.table(AvC2.corrected.frame[1], "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/tTest/CorrectedAvC.txt", row.names = FALSE)
#write.table(TvC1.corrected.frame[1], "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/BenjaminiHochberg/1tailTvC.corrected.txt", row.names = FALSE)
#write.table(TvA1.corrected.frame[1], "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/BenjaminiHochberg/1tailTvA.corrected.txt", row.names = FALSE)
#write.table(AvC1.corrected.frame[1], "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/BenjaminiHochberg/tailAvC.corrected.txt", row.names = FALSE)
