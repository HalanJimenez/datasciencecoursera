## 0.1 Load libraries
library(plyr)
library(ggplot2)
library(datasets)

## 0.2 Unzip file and get data
unzip('exdata-data-NEI_data.zip')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 6.0 Compare emissions from motor vehicle sources in Baltimore City with
## emissions from motor vehicle sources in Los Angeles County, California
## (fips == "06037"). Which city has seen greater changes over time in motor
## vehicle emissions?

baltimore <- NEI[NEI$fips == "24510", ]
la <- NEI[NEI$fips == "06037",]
sectors <- SCC[SCC$EI.Sector %in% c(grep("On-Road", unique(SCC$EI.Sector), value = TRUE)), ]
vehicleBaltimore <- baltimore[baltimore$SCC %in% sectors$SCC, ]
vehicleLA <- la[la$SCC %in% sectors$SCC, ]
vehicleBaltimoreLA <- rbind(vehicleBaltimore, vehicleLA)
vehicleBaltimoreLAEmissions <- ddply(vehicleBaltimoreLA, .(year, fips), summarize, totalEmissions = as.numeric(format(round(sum(Emissions), 2), nsmall = 2)))
vehicleBaltimoreLAEmissions$fips <- factor(vehicleBaltimoreLAEmissions$fips, levels = c("06037", "24510"), 
                                   labels = c("LA", "Baltimore"))
png("plot6.png", width = 800, height = 480)
ggplot(vehicleBaltimoreLAEmissions, aes(x = vehicleBaltimoreLAEmissions$year, y = vehicleBaltimoreLAEmissions$totalEmissions)) +
        ggtitle("Total Emissions in Baltimore Vs Los Angeles from motor vehicle sources \n from 1999 to 2008") +
        xlab("Year") +
        ylab("Total Emissions (thousands of tons)") +
        geom_bar(aes(col = vehicleBaltimoreLAEmissions$totalEmissions), stat = 'identity') +
        geom_text(aes(label = vehicleBaltimoreLAEmissions$totalEmissions, y = vehicleBaltimoreLAEmissions$totalEmissions), size = 3) +
        theme(legend.position = 'none')
dev.off()