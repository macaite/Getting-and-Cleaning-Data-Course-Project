# The run_analysis.R script forms for at the project submission for
# the Getting and Cleaning Data Coursera Course
# 20/05/2015


# Clean environment before we being
rm(list=ls())

#
#  1. Merge the training and the test sets to create one data set.
#

# Read all the required text files into tables

# all the features to be used and column headings
features <- read.table("UCI HAR Dataset/features.txt",header = FALSE)

# activity_lables to be used to as descriptions in each observation
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)

# Then read in all the training data
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt",header = FALSE)
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt",header = FALSE)
# all the test data
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt",header = FALSE)
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt",header = FALSE)

# merge the test and training data for subject, X and Y
# I haven't merged into one complete table in this step - this will be completed in step 2

subjects <- rbind(subjects_train,subjects_test)
X <- rbind(X_train,X_test)
Y <- rbind(Y_train,Y_test) 

# add column names

colnames(subjects) <- "Subject_id"
colnames(Y) <- "Activity_id"
# the the data from the features for the X's column names
colnames(X) <- features[,2]
colnames(activity_labels) <- c("Activity_id","Activity_Name")

#
# 2.  Extract only the measurements on the mean and standard deviation for each measurement.
#


# Extract all the columns in X with 'mean()' and 'std' is part of their header text
# use a logical vector showing derived from X's colnames

selectedCols <- grepl("mean\\(\\)|std", colnames(X), ignore.case = TRUE)
X <- X[selectedCols]

# Now finally combine into one data table
combinedData <- cbind(subjects,Y,X)

#
# 3.  Uses descriptive activity names to name the activities in the data set
#

# Not really required in this step, 

combinedData <- merge(combinedData,activity_labels)

#
# 4.  Appropriately labels the data set with descriptive variable names. 
#

# Appropiate labelling is a discussion point.  What I have done here is to shown
# what can be done.  I've used a function to apply the actual changes.  Any new substitutions can be easily
# added to the the function as needed.

colNames <- colnames(combinedData)

getCorrectedColName <- function (colName){
  colName <- gsub("-mean\\(\\)-","_Mean_",colName)
  colName <- gsub("-std\\(\\)-","_StdDev_",colName)
  colName <- gsub("-mean\\(\\)","_Mean",colName)
  colName <- gsub("-std\\(\\)","_StdDev",colName)
  colName <- gsub("^(t)","Time_",colName)
  colName <- gsub("^(f)","Freq_",colName)
  colName <- gsub("(BodyBody)","Body",colName)
  colName
}


for(i in colNames){
  colNames[match(i,colNames)] <- getCorrectedColName(i)
}

colnames(combinedData) <- colNames

#
# 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

# create a data set of of the variables to average  i.e. combinedData less Subject_id, Activity_id, and Activity_Name

justTheData <- combinedData[,4:length(colNames)-1]

# Use a temp data set which will be spit again before the final tidyDataSet is created.

tidyDataTemp <-  aggregate(justTheData,by = list(Activity_id=combinedData$Activity_id,Subject_id=combinedData$Subject_id),mean)

# Split the into label data and the measured data while merging with Acivity labels
# Add the activity labels

labels <- tidyDataTemp[,1:2]
theData <- tidyDataTemp[3:length(colnames(tidyDataTemp))]
labels <- merge(labels,activity_labels)

tidyData <- cbind(labels,theData)

# then order it

tidyData <- tidyData[order(tidyData$Activity_id,tidyData$Subject_id),]

#write the file

write.table(tidyData,"tidyData.txt",row.names = FALSE)
