# Clean upworkspace
rm(list=ls())

library("plyr")
library("ggplot2")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


png(
    "plot4.png",
    width     = 480,
    height    = 480,
    units     = "px",
)

isect <- grep("coal",SCC$EI.Sector,ignore.case = TRUE,perl=TRUE)
sector <- SCC[isect,]
coalOnly <- NEI[which(NEI$SCC %in% sector$SCC),]


coalSum <- tapply(coalOnly$Emissions, coalOnly$year,sum)
coalSum1000 <- coalSum / 1000
coalSumDf <- as.data.frame(coalSum1000)

plot( row.names(coalSumDf),coalSumDf$coalSum,  xlab="Year",  ylab="Emissions (1000 tons)")
title(main= "USA PM2.5 Emission 1999-2000 from Coal")

dev.off()