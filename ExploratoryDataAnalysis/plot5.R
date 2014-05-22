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
