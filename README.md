Getting-and-Cleaning-Data-Course-Project
========================================

I. File Structure:  

run_anaplysis.R must be the same folder with the data of UCI HAR Dataset.
The files in the folder shouls look like the following.

./run_anaplysis.R  
./README.txt  
./features_info.txt  
./features.txt  
./activity_labels.txt  
./test/  
./test/X_test.txt  
./test/y_test.txt  
./test/subject_test.txt  
./test/Inertial Signals/  
./train/  
./train/X_train.txt  
./train/y_train.txt  
./train/subject_train.txt  
./train/Inertial Signals/  

II. File connection: 

run_anaplysis.R reads data from the following files and creates tidy dataset from these data
./features.txt  
./activity_labels.txt  
./test/X_test.txt  
./test/y_test.txt  
./test/subject_test.txt  
./train/X_train.txt  
./train/y_train.txt  
./train/subject_train.txt  

III. Usage:  

1. Put the script file in the folder with the data of UCI HAR Dataset.  
2. Set R working directory to this folder.  
3. source("./run_analysis.R")  
4. runAnalysis()  
5. The script will create 2 txt files in this folder.  
   tidyDataSet.txt: is the tidy data set which combines test and train dataset.  
   tidyDataSetOfAverage.txt: is an independent data set with the average of each variable for each activity and each subject.  
6. For details of the data processing and variables, please see CodeBook.md.  

