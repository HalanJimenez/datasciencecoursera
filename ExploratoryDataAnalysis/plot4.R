## 0.1 Load libraries

library(plyr)
library(ggplot2)
library(datasets)

## 0.2 Unzip file and get data

unzip('exdata-data-NEI_data.zip')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 4.0 Across the United States, how have emissions from coal combustion-related
## sources changed from 1999-2008?

sectors <- SCC[SCC$EI.Sector %in% c(grep("Coal", unique(SCC$EI.Sector), value = TRUE)), ]
coal <- NEI[NEI$SCC %in% sectors$SCC, ]
coalEmissions <- ddply(coal, .(year), summarize, totalEmissions = as.numeric(format(round(sum(Emissions/1000), 2), nsmall = 2)))
png("plot4.png", width = 500, height = 480)
ggplot(coalEmissions, aes(x = coalEmissions$year, y = coalEmissions$totalEmissions)) +
        ggtitle("Total Emissions across the United States from coal combustion \n from 1999 to 2008") +
        xlab("Year") +
        ylab("Total Emissions (thousands of tons)") +
        geom_point(aes(col = coalEmissions$totalEmissions)) +
        geom_line(aes(col = coalEmissions$totalEmissions)) +
        geom_text(aes(label = coalEmissions$totalEmissions, y = coalEmissions$totalEmissions), size = 3) +
        theme(legend.position = 'none')
dev.off()