## 0.1 Load libraries
library(plyr)
library(ggplot2)
library(datasets)

## 0.2 Unzip file and get data
unzip('exdata-data-NEI_data.zip')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 5.0 How have emissions from motor vehicle sources changed from 1999-2008 in
## Baltimore City?

baltimore <- NEI[NEI$fips == "24510", ]
sectors <- SCC[SCC$EI.Sector %in% c(grep("On-Road", unique(SCC$EI.Sector), value = TRUE)), ]
vehicleBaltimore <- baltimore[baltimore$SCC %in% sectors$SCC, ]
vehicleBaltimoreEmissions <- ddply(vehicleBaltimore, .(year), summarize, totalEmissions = as.numeric(format(round(sum(Emissions/1000), 2), nsmall = 2)))
png("plot5.png", width = 500, height = 480)
ggplot(vehicleBaltimoreEmissions, aes(x = vehicleBaltimoreEmissions$year, y = vehicleBaltimoreEmissions$totalEmissions)) +
        ggtitle("Total Emissions in Baltimore from motor vehicle sources \n from 1999 to 2008") +
        xlab("Year") +
        ylab("Total Emissions (thousands of tons)") +
        geom_point(aes(col = vehicleBaltimoreEmissions$totalEmissions)) +
        geom_line(aes(col = vehicleBaltimoreEmissions$totalEmissions)) +
        geom_text(aes(label = vehicleBaltimoreEmissions$totalEmissions, y = vehicleBaltimoreEmissions$totalEmissions), size = 3) +
        theme(legend.position = 'none')
dev.off()