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

sectors <- SCC[SCC$EI.Sector %in% c(grep("On-Road", unique(SCC$EI.Sector), value = TRUE)), ]

# BALTIMORE
baltimore <- NEI[NEI$fips == "24510", ]
vehicleBaltimore <- baltimore[baltimore$SCC %in% sectors$SCC, ]
vehicleBaltimoreEmissions <- ddply(vehicleBaltimore, .(year), summarize, totalEmissions = as.numeric(format(round(sum(Emissions), 2), nsmall = 2)))
vehicleBaltimoreEmissions$city <- paste(rep('Baltimore', 4))

# LA
la <- NEI[NEI$fips == "06037", ]
vehicleLA <- la[la$SCC %in% sectors$SCC, ]
vehicleLAEmissions <- ddply(vehicleLA, .(year), summarize, totalEmissions = as.numeric(format(round(sum(Emissions), 2), nsmall = 2)))
vehicleLAEmissions$city <- paste(rep('LA', 4))

# COMPARISON
vehicleBaltimoreLAEmissions <- as.data.frame(rbind(vehicleBaltimoreEmissions, vehicleLAEmissions))
png("plot6.png", width = 1200, height = 480)
ggplot(vehicleBaltimoreLAEmissions, aes(x = year, y = totalEmissions)) +
        ggtitle("Total Emissions in Baltimore Vs Los Angeles from motor vehicle sources \n from 1999 to 2008") +
        xlab("Year") +
        ylab("Total Emissions (thousands of tons)") +
        geom_bar(aes(fill = totalEmissions), stat = 'identity') +
        facet_grid(. ~ city) +
        scale_x_continuous(breaks = c(vehicleBaltimoreLAEmissions$year)) +
        geom_text(aes(label = totalEmissions, y = totalEmissions), size = 3, hjust = 0.5, vjust = -1) +
        guides(fill = guide_legend(title = expression('PM'[2.5])))
dev.off()