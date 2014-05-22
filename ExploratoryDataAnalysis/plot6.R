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