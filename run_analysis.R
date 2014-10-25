runAnalysis <- function() {
	### create data context
	activityLabels <- read.table("./activity_labels.txt")
	names(activityLabels) <- c("activityid","activitylabel")
	features <- read.table("features.txt")
	names(features) <- c("featureId","featureInfo")
	meanStdFeatures <- features[grepl("(mean[(][)])|(std[(][)])", features$featureInfo, fixed = FALSE),]
	
	### process test dataset
	testActivityId <- read.table("./test/y_test.txt")
	testSubjectId <- read.table("./test/subject_test.txt")
	names(testActivityId) <- c("activityid")
	names(testSubjectId) <- c("subjectid")
	testDataSet <- cbind(testSubjectId, testActivityId)
	testDataSet$activitylabel <- activityLabels$activitylabel[as.numeric(testDataSet$activityid)]
	### process data and variables
	testDataRaw <- read.table("./test/X_test.txt")
	### select measurements of mean() and std()
	meanStdDataRaw <- testDataRaw[ ,meanStdFeatures$featureId]
	### rename feature variables with appropriate activity labels
	names(meanStdDataRaw) <- meanStdFeatures$featureInfo
	### combine subject and activity information with data collected
	testDataSet <- cbind(testDataSet, meanStdDataRaw) 

	### process train dataset
	trainActivityId <- read.table("./train/y_train.txt")
	trainSubjectId <- read.table("./train/subject_train.txt")
	names(trainActivityId) <- c("activityid")
	names(trainSubjectId) <- c("subjectid")
	trainDataSet <- cbind(trainSubjectId, trainActivityId)
	trainDataSet$activitylabel <- activityLabels$activitylabel[as.numeric(trainDataSet$activityid)]
	trainDataRaw <- read.table("./train/X_train.txt")
	meanStdDataRaw <- trainDataRaw[ ,meanStdFeatures$featureId]
	names(meanStdDataRaw) <- meanStdFeatures$featureInfo
	trainDataSet <- cbind(trainDataSet, meanStdDataRaw) 

	tidyDataSet <- rbind(testDataSet, trainDataSet)
	write.table(tidyDataSet, file = "tidyDataSet.txt", row.names = FALSE)
	##summary(tidyDataSet)	
	subjectList <- as.numeric(levels(as.factor(tidyDataSet$subjectid)))
	rm(newTidyDataSet)
	for(subjectid in subjectList){
		subject1TestData <- tidyDataSet[(tidyDataSet$subjectid == subjectid),]	
		activityTested <- as.factor(subject1TestData$activityid) ### extract activities tested ##4:69
		activityTested <- as.numeric(as.factor(levels(activityTested))) ### summarize activities
		for(activityid in activityTested){
			averageEachActivity <- sapply(subject1TestData[(subject1TestData$activityid == activityid),], mean)
			if(!exists("newTidyDataSet")){
				newTidyDataSet <- averageEachActivity
			}else{
				newTidyDataSet <- rbind(newTidyDataSet, averageEachActivity)		
			}
		}
	}
	rm(subjectid)
	rm(activityid)
	rm(subject1TestData)
	rm(averageEachActivity)

	dim <- dim(newTidyDataSet)
	newTidyDataSet <- data.frame(newTidyDataSet,dim[1],dim[2])
	newTidyDataSet <- newTidyDataSet[,1:69]
	newTidyDataSet$activitylabel <- activityLabels$activitylabel[as.numeric(newTidyDataSet$activityid)]
	write.table(newTidyDataSet, file = "tidyDataSetOfAverage.txt", row.names = FALSE)
	##summary(newTidyDataSet)
}



