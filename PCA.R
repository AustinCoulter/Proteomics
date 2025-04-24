i<-read.table ("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/PCA/2024PGTvA.txt", header=T, sep="\t", row.names=1)
i<-read.table ("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/PCA/2024PGTvC.txt", header=T, sep="\t", row.names=1)
i<-read.table ("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/PCA/2024PGAvC.txt", header=T, sep="\t", row.names=1)
i<-read.table("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/PCA/2024NoNA.txt", header=T,sep = "\t", row.names=1)

#make PCA
pca.i<-prcomp(i)

#check PCA
names(pca.i)
summary(pca.i)
str(pca.i)

#make data frame of PCA and then save the top 10 dimensions (Hash out after saving)
xi<-data.frame(pca.i$x)
#write.table (xi[1:10], file="PCA1-10.txt")

#Rotate PCA so that rows are the samples & save the top 10 (Hash out after saving)
roti<-data.frame(pca.ti$rot)
#write.table (roti[1:10], file="PCA1-10rot.txt")

#Transpose the file, and do PCA so that samples are rows and check to confirm
pca.ti<-prcomp(t(i))
summary(pca.ti)
str(pca.ti)
pca.ti$x
row.names(pca.ti$x)

#Plotting Principle Components
#Palette by population
palette(c(rep("green",6),rep("goldenrod",5),rep("red",5)))
#palets by comparison
#palette(c(rep("green",6),rep("red",5)))
#palette(c(rep("green",6),rep("goldenrod",5)))
#palette(c(rep("goldenrod",5),rep("red",5)))


#palette by date collected
#palette(c(rep("orchid",2),rep("darkgreen",3),rep("chocolate",5),rep("darkgreen",1),rep("aquamarine",4)))

#plot
plot(pca.ti$x[,1],pca.ti$x[,2],pch=20, col=(1:15))
plot(pca.ti$x[,1],pca.ti$x[,3],pch=20, col=(1:15))
plot(pca.ti$x[,1],pca.ti$x[,4],pch=20, col=(1:15))
plot(pca.ti$x[,1],pca.ti$x[,15],pch=20, col=(1:15))
plot(pca.ti$x[,4],pca.ti$x[,2],pch=20, col=(1:15))
plot(pca.ti$x[,3],pca.ti$x[,4],pch=20, col=(1:15))

#Text for desired PCs
text(pca.ti$x[,1],pca.ti$x[,2],row.names(pca.ti$x),col="black", cex=0.8)

#plot(roti[,1],roti[,2],pch=20, col=(1:15))

write.table(roti, "/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/PCA/AvCPCAloadings.csv", row.names = TRUE)


