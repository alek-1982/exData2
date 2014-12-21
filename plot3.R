library(doBy)
library("ggplot2")

# Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



#Plot Data
# baltimore
baltimore <- NEI[which(NEI$fips=="24510"),]
png("plot3.png")
baltimore$type <- as.factor(baltimore$type)
baltimore$year <- as.factor(baltimore$year)
baltSum <- summaryBy(. ~type+year, data=baltimore,FUN=list(sum), keep.names=TRUE)
qplot(year,Emissions,data=baltSum,color=type,main="Baltimore PM2.5 Emissions 1999-2008 by Type",ylab="Emissions (tons)")



dev.off()