## 0.1 Load libraries

library(plyr)
library(ggplot2)
library(datasets)

## 0.2 Unzip file and get data

unzip('exdata-data-NEI_data.zip')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 3.0 Of the four types of sources indicated by the type (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases in
## emissions from 1999-2008 for Baltimore City? Which have seen increases in
## emissions from 1999-2008? Use the ggplot2 plotting system to make a plot
## answer this question.

baltimore <- NEI[NEI$fips == "24510", ]
baltimoreEmmissionByType <- ddply(baltimore, .(year, type), summarize, totalEmissions = as.numeric(format(round(sum(Emissions), 2), nsmall = 2)))
png("plot3.png", width = 600, height = 480)
qplot(year, totalEmissions, data = baltimoreEmmissionByType, color = type, geom = c("point", "line"),
      main = "Total emissions from PM2.5 in the Baltimore City, Maryland \n from 1999 to 2008 by type",
      xlab = "Year", ylab = "Total Emissions (tons)") +
        geom_text(aes(label = baltimoreEmmissionByType$totalEmissions, y = baltimoreEmmissionByType$totalEmissions), size = 3)        
dev.off()