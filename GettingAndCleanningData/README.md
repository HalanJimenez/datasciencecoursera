## Data Science: Getting and Cleaning Data - Project

Download and unzip the source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
Option 1: Into a folder of your R workspace.
Option 2: Into a folder on your local drive and change the value of the variable 'data_path' with the path where you unzipped the source.

If you don't have installed the library 'reshape2' execute the next line in you R Studio:
install.packages('reshape2')

Then execute the next line for test the code:
source("run_analysis.R")

You will get two files in your working space:
- tidy_data.txt (9686KB)
- tidy_data_with_averages.txt (263KB)