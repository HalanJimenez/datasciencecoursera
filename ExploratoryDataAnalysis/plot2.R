## 0.1 Load libraries

library(plyr)
library(ggplot2)
library(datasets)

## 0.2 Unzip file and get data

unzip('exdata-data-NEI_data.zip')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 2.0 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.

baltimore <- NEI[NEI$fips == "24510", ]
baltimoreEmissions <- ddply(baltimore, .(year), summarize, totalEmissions = as.numeric(format(round(sum(Emissions/1000), 2), nsmall = 2)))
png("plot2.png", width = 480, height = 480)
plot(baltimoreEmissions$year, baltimoreEmissions$totalEmissions, type = "b",
     main = "Total emissions from PM2.5 in the Baltimore City, Maryland \n from 1999 to 2008",
     xlab = "Year", ylab = "Total Emissions (thousands of tons)", xaxt = "n", yaxt = "n")
axis(side = 1, at = baltimoreEmissions$year, las = 1)
axis(side = 2, at = baltimoreEmissions$totalEmissions, las = 2)
dev.off()