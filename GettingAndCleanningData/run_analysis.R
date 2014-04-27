##
# Source of data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##

##
# Functions
##

## Getting data from a file
getData <- function(path, file) {
        data <- read.table(paste(path, file, sep=""))
        data
}

##
# Instructions of the assignment
##

##
# 0.1 Import library for melt function.
#     - If is necessary install the library with:
#
#       install.packages('reshape2')
##

library(reshape2)

##
# 0.2 Get path of the data
#       - data_path: specifies the path to the data (change the value for access to your path)
##

data_path <- "./UCI HAR Dataset/"

##
# 0.3 Read all the files
##

X_train_set <- getData(data_path, "train/X_train.txt")
X_test_set <- getData(data_path, "test/X_test.txt")
Y_train_set <- getData(data_path, "train/y_train.txt")
Y_test_set <- getData(data_path, "test/y_test.txt")
subject_train_set <- getData(data_path, "train/subject_train.txt")
subject_test_set <- getData(data_path, "test/subject_test.txt")
features <- getData(data_path, "features.txt")
activities <- getData(data_path, "activity_labels.txt")

##
# 1. Merges the training and the test sets to create one data set.
##

X_data <- rbind(X_train_set, X_test_set)
Y_data <- rbind(Y_train_set, Y_test_set)
subject_data <- rbind(subject_train_set, subject_test_set)
names(Y_data) <- "activity"
names(subject_data) <- "subject"

##
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##

measurements <- grepl('-(mean|std)', features[,2])
X_data <- X_data[, measurements]
names(X_data) <- features[measurements, 2]

##
# 3. Uses descriptive activity names to name the activities in the data set
##

Y_data[,1] = activities[Y_data[,1], 2]

##
# 4. Appropriately labels the data set with descriptive activity names.
##

tidy_data <- cbind(subject_data, Y_data, X_data)

##
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##

vars <- c("subject", "activity")
measure_vars <- setdiff(colnames(tidy_data), vars)
tidy_data_with_averages <- melt(tidy_data, measure.vars = measure_vars)
tidy_data_with_averages <- dcast(tidy_data_with_averages, subject + activity ~ variable, mean)

##
# Exporting files
##

write.csv(tidy_data, file = 'tidy_data.txt')
write.csv(tidy_data_with_averages, file = 'tidy_data_with_averages.txt')