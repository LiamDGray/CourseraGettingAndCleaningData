# run_analysis.R

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# 0. Set up environment:
install.packages("tidyr")
install.packages("dplyr")
install.packages("data.table")
library(tidyr)
library(dplyr)
library(data.table)

setwd("~/Downloads/UCI HAR Dataset")

# 1. Merge training and test sets to create one data set (for x and y):

xtest <- read.table("test/X_test.txt")
xtrain <- read.table("train/X_train.txt")
x <- rbind(xtrain, xtest)

ytest <- read.table("test/y_test.txt")
ytrain <- read.table("train/y_train.txt")
y <- rbind(ytrain, ytest)

# 2. Extract only the measurements on the mean and standard deviation
#    for each measurement:

xlabel <- read.table("features.txt")
xlab <- xlabel[,2]
xlab_keep <- grepl("-mean", xlab) | grepl("-std", xlab)
c_xlab <- as.character(xlab)
mslabels <- c_xlab[xlab_keep]

# 3. Use descriptive activity names to name the activities in the data set:

act <- read.table("activity_labels.txt")
act_names <- act[,2]
acts <- y[,1]
act_cnames <- as.character(act_names)
named_acts <- vapply(acts, function(i) act_cnames[i], "")

stest <- read.table("test/subject_test.txt")
strain <- read.table("train/subject_train.txt")
subjects <- rbind(strain, stest)

# 4. Appropriately label the data set with descriptive variable names:

names(xkeep) <- mslabels

names(named_acts) <- “activity”

names(subjects) <- "subject"

obs <- cbind(xkeep, named_acts, subjects)

# Step 4 is complete above.
# Now just average the rows for each distinct pair of activity and subject:

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject:

tidy_obs <- obs %>% group_by(columns) %>% summarise_each(funs(mean))

