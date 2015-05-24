## Getting-and-Cleaning-Data-Course-Project

## Project brief


The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Submission list

run_analysis.R	
Codebook.md
Readme.md

### run analysis discription

The run_anaylsis.R script must be run in the same directory that the downloaded data is unzipped in

The files listed below are read into a R data table and merged into one tide data set.  

####UCI HAR Dataset/features.txt	
to be as headings for the combined X files

The data is divided into two datasets, Test and Train.  All the Test and Train files are combined into one data table
The X files list all the measred data as per the features file
The Y files list all the acivitity id's
The subject files list all the subject ID's

####UCI HAR Dataset/train/subject_train.txt
####UCI HAR Dataset/train/X_train.txt
####UCI HAR Dataset/train/y_train.txt
####UCI HAR Dataset/test/subject_test.txt
####UCI HAR Dataset/test/X_test.txt
####UCI HAR Dataset/test/y_test.txt

####UCI HAR Dataset/activity_labels.txt	
provides desciptive labels for the activities in the Y files.

Comments in the run_analysis.R script describe the steps 1-5 from project brief above

The tidy dataset is written out using the write.table command to the base directory as tidyData.txt.  
tidyData.txt can be read into R using the read.table command with headers set to TRUE

