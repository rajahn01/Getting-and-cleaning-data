# Getting-and-cleaning-data
This repo contains all the relevant files for my week four assignment. The objective of the assignment to prepare tidy data that can be used for later analysis. A tidy data set has the data arranged in a way that each variable is a column and each observation (or case) is a row.

As well as this README file, the repo also includes a file called CodeBook.MD that describes the variables included in the data set called tidydata.txt that is produced by running the R code file called run_analysis.R as long as the Samsung data is in the working directory. 

The R code file run_analysis.R does five things:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The tidydata.txt file includes data on the mean and standard deviation of several variables which are described in the code book. 
