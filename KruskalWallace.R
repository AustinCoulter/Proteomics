#install.packages("FSA")
library(dunn.test)

#read in file
Data <- read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/KW Test/FoxGroupedpreKW.txt", sep="\t", row.names = 1, header=TRUE)

#Make vector with groups for kruskal wallace#Make vector with groups for kruskal wallaceTRUE
group <- c("Tam",	"Tam",	"Tam",	"Tam",	"Tam",	"Tam",	"Agg",	"Agg",	"Agg",	"Agg",	"Agg",	"Con",	"Con",	"Con",	"Con",	"Con")
#rotate file
d <- data.frame(t(Data))

#Prepare file to append to
results <- data.frame(accession=c(),Xsquared=c(),pvalue=c())
dunnresults <- data.frame(accession=c(),Comparison=c(),Z=c(),P.unadj=c(),P.adj=c())

#Loop through every protein in list, for each protein run kruskal, then append the results to the data frame
for(i in seq(1,length(Data$Norm.Agg44))) {
  if(rowsum(d[,i],group,na.rm=TRUE)[1]>0 & rowsum(d[,i],group,na.rm=TRUE)[2]>0 & rowsum(d[,i],group,na.rm=TRUE)[3]>0)
  kw <- kruskal.test(d[,i]~group) else kw <- data.frame(statistic=c(0),p.value=c(0));
  dunn <- dunn.test(d[,i],g=group, method="Bonferroni");
  values <- data.frame(accession=c(colnames(d[i])), Xsquared=c(kw$statistic), pvalue=c(kw$p.value));
  dunnvalues <- data.frame(accession=c(colnames(d[i])), Comparison=c(dunn[["comparisons"]]), Z=c(dunn[["Z"]]), P.unadj=c(dunn[["P"]]), P.adj=c(dunn[["P.adjusted"]]));
  results<-rbind(results,values);
  dunnresults <- rbind(dunnresults, dunnvalues)}


write.table(results, "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/KW Test/FoxKWGrouped.csv", row.names = TRUE)
write.table(dunnresults, "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/KW Test/FoxDunns.csv", row.names = TRUE)

