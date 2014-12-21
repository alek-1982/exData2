# Clean upworkspace
rm(list=ls())

library("plyr")
library("ggplot2")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


png(
    "plot5.png",
    width     = 480,
    height    = 480,
    units     = "px",
)

# Motor Vehicle include Light, heavy, petrol and disel 
# Any source which Level Two source includes Highway are consider motor vehile emission
iHighway <- grep("Highway",SCC$SCC.Level.Two,ignore.case = TRUE,perl=TRUE)
highwaySCC <- SCC[iHighway,]

baltimoreMV <- NEI[which(NEI$SCC %in% highwaySCC$SCC),]
baltimoreMVSum <- tapply(baltimoreMV$Emissions, baltimoreMV$year,sum)
baltimoreMVSumDf <- as.data.frame(baltimoreMVSum)
plot( row.names(baltimoreMVSumDf),baltimoreMVSumDf$baltimoreMVSum,  xlab="Year",  ylab="Emissions (tons)")
title(main= "Baltimore Motor Vehicle Emissions 1999-2008")

dev.off()

