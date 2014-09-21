##Course Project: clean up activity dataset 

To speed up the merge of train and test dataset, first subset both dataset to the required 66 variables and then add the activtiy and subject variable to both table. Afterwards just use the join function from plyr library to do the merge.

1. Find rows of all mean() and std() measurement from feature.txt, create a table `featureTable_Std_Mean` . The "Nr" column matches the column position in X_train.txt and X_test.txt.
```
featureTable<-read.table("features.txt",header = FALSE,sep="",col.names = c("Nr","Function"))
featureTable_Std_Mean <- featureTable[featureTable$Nr %in% grep("std\\(\\)|mean\\(\\)",featureTable$Function),]
```

2. Use the `featureTable_Std_Mean$Nr` vector to subset the X_train.txt and X_test.txt with the wanted variables in table `x_train_sub` and `x_test_sub`
```
x_train <- read.table("X_train.txt",head=FALSE,sep="",col.names=featureTable$Function)
x_test <- read.table("X_test.txt",head=FALSE,sep="",col.names=featureTable$Function)
x_train_sub<-x_train[,featureTable_Std_Mean$Nr]
x_test_sub<-x_test[,featureTable_Std_Mean$Nr]
```

4. read file y_train.txt, y_test.txt, activity_labels.txt into table
```
y_train<-read.table("y_train.txt",head=FALSE,col.names = ("id"))
y_test<-read.table("y_test.txt",head=FALSE,col.names=("id"))
activity_labels<-read.table("activity_labels.txt",head=FALSE,sep="",col.names = c("id","activity"))
```
	
5. Add a variable `activity` into `x_train_sub` and `x_test_sub`
```	
activity_train<-activity_labels[y_train$id,]
activity_test<-activity_labels[y_test$id,]
x_train_sub$activity<-activity_train$activity	
x_test_sub$activity<-activity_test$activity
```

6.  Create 2 table `subject_train` and `subject_test` from  subject_train.txt and subject_test.txt
```
subject_test<-read.table("subject_test.txt",head=FALSE,col.names=("subject_id"))
subject_train<-read.table("subject_train.txt",head=FALSE,col.names=("subject_id"))
```

7. Add a variable `subject` into `x_train_sub` and `x_test_sub` by using vector `subject_train$subject_id` and `subject_test$subject_id` 
```
x_train_sub$subject<-subject_train$subject_id
x_test_sub$subject<-subject_test$subject_id
```
  
8. Merge `x_train_sub` and `x_test_sub` into new dataframe `allData`
```
library(plyr)
allData<-join(x_train_sub,x_test_sub,type="full")
```
  
9. melt `allData` to calcutlate average
```
allDataMelt<-melt(allData,id.vars = c("subject","activity"),measure.vars = c(1:66))
allDataAverage<-dcast(allDataMelt,c("activity","suject") ~ variable,mean)
write.table(allDataAverage,file = "allDataAverage.txt")
```