## 0.1 Load libraries
library(plyr)
library(ggplot2)
library(datasets)

## 0.2 Unzip file and get data
unzip('exdata-data-NEI_data.zip')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 1.0 Have total emissions from PM2.5 decreased in the United States from 1999
## to 2008? Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

emissions <- ddply(NEI, .(year), summarize, totalEmissions = as.numeric(format(round(sum(Emissions/1000000), 2), nsmall = 2)))
png("plot1.png", width = 480, height = 480)
plot(emissions$year, emissions$totalEmissions, type = "b",
     main = "Total emissions from PM2.5 in the United States \n from 1999 to 2008",
     xlab = "Year", ylab = "Total Emissions (millions of tons)", xaxt = "n", yaxt = "n")
axis(side = 1, at = emissions$year, las = 1)
axis(side = 2, at = emissions$totalEmissions, las = 2)
dev.off()

## 4.0 Across the United States, how have emissions from coal combustion-related
## sources changed from 1999-2008?



## 5.0 How have emissions from motor vehicle sources changed from 1999-2008 in
## Baltimore City?



## 6.0 Compare emissions from motor vehicle sources in Baltimore City with
## emissions from motor vehicle sources in Los Angeles County, California
## (fips == "06037"). Which city has seen greater changes over time in motor
## vehicle emissions?

