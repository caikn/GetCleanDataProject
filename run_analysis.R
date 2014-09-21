
#create table with only std() and mean() varialbes from features.txt
featureTable<-read.table("features.txt",header = FALSE,sep="",col.names = c("Nr","Function"))
featureTable_Std_Mean <- featureTable[featureTable$Nr %in% grep("std\\(\\)|mean\\(\\)",featureTable$Function),]


#read X_train.txt and X_test.txt into table
x_train <- read.table("X_train.txt",head=FALSE,sep="",col.names=featureTable$Function)
x_test <- read.table("X_test.txt",head=FALSE,sep="",col.names=featureTable$Function)

#subset these 2 tables to keep only std() and mean() measurements
x_train_sub<-x_train[,featureTable_Std_Mean$Nr]
x_test_sub<-x_test[,featureTable_Std_Mean$Nr]


#read activity data and label file
y_train<-read.table("y_train.txt",head=FALSE,col.names = ("id"))
y_test<-read.table("y_test.txt",head=FALSE,col.names=("id"))
activity_labels<-read.table("activity_labels.txt",head=FALSE,sep="",col.names = c("id","activity"))

#add varialbe activity to train and test data table
activity_train<-activity_labels[y_train$id,]
activity_test<-activity_labels[y_test$id,]
x_train_sub$activity<-activity_train$activity	
x_test_sub$activity<-activity_test$activity

#add subject variable
subject_test<-read.table("subject_test.txt",head=FALSE,col.names=("subject_id"))
subject_train<-read.table("subject_train.txt",head=FALSE,col.names=("subject_id"))
x_train_sub$subject<-subject_train$subject_id
x_test_sub$subject<-subject_test$subject_id

#merge two table
library(plyr)
allData<-join(x_train_sub,x_test_sub,type="full")

#calculate the average
allDataMelt<-melt(allData,id.vars = c("subject","activity"),measure.vars = c(1:66))
allDataAverage<-dcast(allDataMelt,c("activity","suject") ~ variable,mean)
write.table(allDataAverage,file = "allDataAverage.txt")
