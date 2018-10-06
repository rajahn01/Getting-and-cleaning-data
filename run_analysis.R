# This R code file prepares a tidy data set based on data in the Human Actvity Recognition Using Smartphone Dataset
# The Human Activity Recognition Using Smartphone is available at: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# For this file to work the unzipped information in the UCI HAR Dataset folder must be stored in the working directory
# The dplyr package must also have been installed

library(dplyr)

#TASK ONE: MERGE THE TRAINING AND TEST DATA SETS
setwd("UCI HAR Dataset")
getwd()

#1. Read in the names of the variables (ie the names of each column heading)
labelnames<-read.csv("features.txt", sep="", header=FALSE)
labellist<-select(labelnames,2)
colheadings<-t(labellist)

#2. Read in the training data sets
#2a. Read the file with the training data and label the columns
X_train<-read.csv("train/X_train.txt", sep="", header=FALSE)
dim(X_train)
colnames(X_train)=colheadings

#2b. Read the file with the training labels and then label that variable
Y_train<-read.csv ("train/Y_train.txt", sep="", header=FALSE)
dim(Y_train)
colnames(Y_train)="activity_id"

#2c. Read in the file with the subjects in the training data and label that variable
Subject_train<-read.csv("train/subject_train.txt", sep="", header=FALSE)
dim(Subject_train)
colnames(Subject_train)="person_id"

#2d. Merge the columns of these three training files
Totaltrain<-cbind(Subject_train, Y_train, X_train)

#3. Read in the test data sets
#3a. Read in the file with the test data and label the variables
X_test<-read.csv("test/X_test.txt", sep="", header=FALSE)
dim(X_test)
colnames(X_test)=colheadings


#3b. Read in the file with the activity variable and label it
Y_test<-read.csv ("test/Y_test.txt", sep="", header=FALSE)
dim(Y_test)
colnames(Y_test)="activity_id"


#3c. Read in the file with the subject variable in the test data set and label it 
Subject_test<-read.csv("test/subject_test.txt", sep="", header=FALSE)
dim(Subject_test)
colnames(Subject_test)="person_id"


#3d. Merge the columns of these three test data files
Totaltest<-cbind(Subject_test, Y_test, X_test)

#Append the test data to the train data by using the rbind function
Alldata<-rbind(Totaltrain, Totaltest)
dim(Alldata)

#TASK TWO: Extract the measurements on the mean and the standard deviation for each measurement

#Read in the names of the variables (ie the names of each column heading)
labelnames<-read.csv("features.txt", sep="", header=FALSE)
labelnames$V2<-as.character(labelnames$V2)
#Identify the ones which measure mean values or SD values
selectedvars<-labelnames[grep("mean\\(\\)|std\\(\\)",labelnames[,2]),]

#Now create a new data frame called 'meansddata' with the mean values and the SD values
meansddata<-Alldata[,selectedvars[,2]]
names(meansddata)


#TASK THREE: USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
#Read in the file with details on the activity labels
activitylabels<-read.csv("activity_labels.txt", sep="", header=FALSE)
Alldata$activitylabel<-factor(Alldata$activity_id, labels=as.character(activitylabels[,2]))   

#TASK FOUR: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
# Note that in steps 2a-2c and steps 3a-3c we labelled the variables with the variable names in features.txt. 
names(Alldata)

#The next lines of code select the variables of interest which reflect the means and SDs to give a tidy data set. 
#They also append the relevant subject_ids and activities to the data set.
selectedvar2<-append(selectedvars$V2, "person_id")
selectedvar3<-append(selectedvar2, "activitylabel")
newdata<-Alldata[selectedvar3]
names(newdata)

#TASK FIVE: CREATE A SECOND INDEPENDENT DATA SET WITH THE AVERAGES OF EACH VARIABE FOR EACH ACTIVITY AND EACH SUBJECT
Alldatameans<-newdata %>% group_by(activitylabel, person_id)%>%summarise_all(funs(mean))
write.table(Alldatameans, file="tidydata.txt", row.names = FALSE)

 
          
           

