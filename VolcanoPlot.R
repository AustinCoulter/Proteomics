#resd in files and label columns
data1 <- read.delim("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Volcano Plots/TvA.txt", header = TRUE)
colnames(data1) <- c("-Log(PValue)", "Log(Ratio)")
data2 <- read.delim("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Volcano Plots/AvC.txt", header = TRUE)
colnames(data2) <- c("-Log(PValue)", "Log(Ratio)")
data2$`Log(Ratio)2`<- data2$`Log(Ratio)`* -1
data3 <- read.delim("/Users/enima/OneDrive/Desktop/Savas Lab Proteome Research/Results/2024/Fox Genome/Volcano Plots/TvC.txt", header = TRUE)
colnames(data3) <- c("-Log(PValue)", "Log(Ratio)")


par(mfrow = c(1, 3.5))

all_x <- c(data1$"Log(Ratio)", data2$"Log(Ratio)2", data3$"Log(Ratio)")
all_y <- c(data1$"-Log(PValue)", data2$"-Log(PValue)", data3$"-Log(PValue)")

xlim_range <- range(all_x, na.rm = TRUE)
ylim_range <- range(all_y, na.rm = TRUE)

# Create Tame vs Aggressive scatterplot

plot(data1$"Log(Ratio)",data1$"-Log(PValue)",
     main = "A. Tame versus Aggressive",
     xlim = xlim_range,
     ylim = ylim_range,
     xlab = expression(log[10](Fold[Tame/Aggressive])),
     ylab = expression(-log[10](p-value)),
     cex.main = 1.5,
     cex.lab = 1.45,
     cex=2,
     pch = 19,  # Solid circles
     col = "darkgrey")

points(data1$"Log(Ratio)"[1:174],data1$"-Log(PValue)"[1:174],
     pch = 19,
     cex = 2,
     col = ifelse(data1$"Log(Ratio)"[1:174] < 0, "red3", "palegreen3"))


# Create the Conventional versus Aggressive scatterplot

plot(data2$"Log(Ratio)2",data2$"-Log(PValue)",
     main = "B. Conventional versus Aggressive",
     xlab = expression(log[10](Fold[Conventional/Aggressive])),
     ylab = expression(-log[10](p-value)),
     xlim = xlim_range,
     ylim = ylim_range,
     cex.main = 1.5,
     cex.lab = 1.45,
     cex = 2,
     pch = 19,  #Solid circles
     col = "darkgrey")

points(data2$"Log(Ratio)2"[1:5],data2$"-Log(PValue)"[1:5],
       pch = 19,  # Solid circles
       cex = 2,
       col = ifelse(data2$"Log(Ratio)2"[1:5] < 0, "red3", "goldenrod"))



# Create the Tame versus Conventional scatterplot

plot(data3$"Log(Ratio)",data3$"-Log(PValue)",
     main = "C. Tame versus Conventional",
     xlab = expression(log[10](Fold[Tame/Conventional])),
     ylab = expression(-log[10](p-value)),
     xlim = xlim_range,
     ylim = ylim_range,
     cex.main = 1.5,
     cex.lab = 1.45,
     cex = 2,
     pch = 19,  #Solid circles
     col = "darkgrey")

