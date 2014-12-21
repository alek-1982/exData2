
# Clean upworkspace
rm(list=ls())

library("plyr")
library("ggplot2")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


png(
    "plot6.png",
    width     = 480,
    height    = 480,
    units     = "px",
)


# Motor Vehicle include Light, heavy, petrol and disel 
# Any source which Level Two source includes Highway are consider motor vehile emission
iHighway <- grep("Highway",SCC$SCC.Level.Two,ignore.case = TRUE,perl=TRUE)
highwaySCC <- SCC[iHighway,]

MV <- NEI[which(NEI$SCC %in% highwaySCC$SCC),]
MVsub <- MV[which(MV$fips=="06037" | MV$fips =="24510"),]
MVsub$year <- as.factor(MVsub$year)

# Provide nice labels
MVsub$county <- factor(MVsub$fips, levels=c("06037", "24510"), labels=c("LA", "Baltimore"))

MVsubSummary <- summaryBy(. ~county+year, data=MVsub,FUN=list(sum), keep.names=TRUE)
qplot(year,Emissions,data=MVsubSummary,color=county,main="Baltimore and Los Angles Motor Vehicle PM2.5 Emissions 1999-2008",ylab="Emissions (tons)")
