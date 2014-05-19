## 0.1 Load libraries
library(plyr)
library(ggplot2)

## 0.2 Unzip file and get data
unzip('exdata-data-NEI_data.zip')
PM25 <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

## 1.0 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from all
## sources for each of the years 1999, 2002, 2005, and 2008.