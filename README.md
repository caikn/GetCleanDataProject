##Usage of the run_analysis.R 

Here are the data for this project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

All the data files below must be put in the same folder as run_analysis.R:

file name | file content
---------------- | -----------------
features.txt | _measure function name for each column of dataset_
activity_lables.txt | _mapping of activity id and name_
subject_test.txt | _subject id for test dataset_
subject_train.txt | _subject id for train dataset_
X_test.txt | _train dataset_
X_train.txt | _test dataset_
y_test.txt | _activity id for test dataset_
y_train.txt | _activity id for train dataset_

The result of this script will be kept in a table `allDataAverage` and saved in the file $allDataAverage.txt$.
