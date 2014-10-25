Getting-and-Cleaning-Data-Course-Project
========================================

I. Variables: 

Both tidyDataSet.txt and tidyDataSetOfAverage.txt have the same variables. The variables tell
who did the test and performed which activity, and the measurements collected from sensors.

subjectid : represent the individual subject who participated the test
activityid : represent the index of activities which subjects performed
activitylabel : represent activities which subjects performed

The measurements variables of tidyDataSet.txt represent every observation.
The measurements variables of tidyDataSetOfAverage.txt represent the mean of all observations of
the same activity of the same subject.

For more information, please see features.txt and features_info.txt.

II. Data

a. data set context
activityLabels : list of all activities tested
features : list of all measurements collected
meanStdFeatures : list of the measurements on the mean("mean()"") and standard deviation("std()")

b. data set
testDataSet : tidy data set of UCI HAR Dataset Test set.
trainDataSet : tidy data set of UCI HAR Dataset Test set. 
tidyDataSet : combination of testDataSet and trainDataSet
newTidyDataSet : This dataset contains the average of measurements of each activity for each subject.

III. Process

A. Tidy original data set

1. Create context by reading activity_labels.txt and features.txt use read.table().
2. Create new features with mean() and std() only using grepl("(mean[(][)])|(std[(][)])"
3. For test data set and traning data set, use the following processes 
	a. Load subject list coorresponding to each measurement
	b. Load activity list coorresponding to each measurement
	c. Rename their varibles and combine them use cbind()
	d. Add a new varible "activitylabel" coorresponding to activity list 
	e. Load raw data set use read.table()
	f. Select columns on the mean() and std() using the features created at 2.
	g. Rename the variables of f. 
	h. cbind() d. and g.
4. Combine tidy test data set and tidy training data set.
5. Write the data set into file.

B. Create independent new data set

1. Create a subject id list from tidyDataSet.
2. For each subject, create a subset of this subject
3. Create a activity id list from the subset of this subject.
4. For each activity id, apply mean method to the the subset 
   of this subject with the same activity id and rbind the result to
   newTidyDataSet. The apply method I used here is sapply(x, mean).
5. Convert newTidyDataSet from matrix to dataframe.
6. newTidyDataSet$activitylabel will be NA after sapply(). Re-assign 
   the value to appropriate activity labels.
7. Write the data set into file.


