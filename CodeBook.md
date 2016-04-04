---
title: "CodeBook:  run_analysis.R"
author: "Rich Morrison"
date: "April 3, 2016"
output: html_document
---

## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.  The goal is to prepare tidy data that can be used for later analysis.

##Study design and data processing
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

The data set was originally separated into test and train subsets.  The script "run_analysis.R" was written to process the data for the course project.  This
script performs the following steps:

1.) Merges the training and the test sets to create one data set. The original 
data set was randomly separated into separate train and test sets.  The data 
from these sets are combined into one set in the script.

Files used to build the data structure for R processing:

- features.txt
- activity_labels.txt
- subject_train.txt
- X_train.txt
- y_train.txt
- subject_test.txt
- X_test.txt
- y_test.txt

2.) Extracts only the measurements on the mean and standard deviation for each measurement.

3.) Uses descriptive activity names to name the activities in the data set

4.) Appropriately labels the data set with descriptive variable names.

5.) From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.


###Collection of the raw data
Description of how the data was collected.

The data set was obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Notes on the original (raw) data 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### License:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

##Creating the tidy datafile

###Guide to create the tidy data file
1.) install the "dplyr" package.
2.) download and unzip the data to the working directory.
3.) read the data into data.frames
4.) remove the data not needed for analysis; keep mean() and std() variables
5.) read the feature variable names
6.) read the activity labels
7.) merge the data.frames using the descriptive activity labels and variable names
8.) rename the variable names for the data.frame
9.) create another data.frame to summarize the data by grouping on subject and activity.  Calculate the mean() for each variable (column)
10.)  the results are stored in "df_summary"

###Cleaning of the data
- Removed any variables that were not mean() or std() values.
- Renamed variables to be more readable and descriptive by: replacing all "." 
with "", using camel case and no spaces, replace "t" with "time", and "f" with
"frequency".

##Description of the variables in the tiny_data.txt file
the data set is called "df_summary" which is 180 rows by 68 columns.  The column names are:

 [1] "subject"  Factors are [1:Number of subjects in data set]                  
 [2] "activity" Factors are:  "WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING,LAYING     
 
All other variable Features are normalized and bounded within [-1,1].
 [3] "timeBodyAccelerationMeanX"                 
 [4] "timeBodyAccelerationMeanY"                 
 [5] "timeBodyAccelerationMeanZ"                 
 [6] "timeBodyAccelerationStdDevX"               
 [7] "timeBodyAccelerationStdDevY"               
 [8] "timeBodyAccelerationStdDevZ"               
 [9] "timeGravityAccelerationMeanX"              
[10] "timeGravityAccelerationMeanY"              
[11] "timeGravityAccelerationMeanZ"              
[12] "timeGravityAccelerationStdDevX"            
[13] "timeGravityAccelerationStdDevY"            
[14] "timeGravityAccelerationStdDevZ"            
[15] "timeBodyAccelerationJerkMeanX"             
[16] "timeBodyAccelerationJerkMeanY"             
[17] "timeBodyAccelerationJerkMeanZ"             
[18] "timeBodyAccelerationJerkStdDevX"           
[19] "timeBodyAccelerationJerkStdDevY"           
[20] "timeBodyAccelerationJerkStdDevZ"           
[21] "timeBodyGyroMeanX"                         
[22] "timeBodyGyroMeanY"                         
[23] "timeBodyGyroMeanZ"                         
[24] "timeBodyGyroStdDevX"                       
[25] "timeBodyGyroStdDevY"                       
[26] "timeBodyGyroStdDevZ"                       
[27] "timeBodyGyroJerkMeanX"                     
[28] "timeBodyGyroJerkMeanY"                     
[29] "timeBodyGyroJerkMeanZ"                     
[30] "timeBodyGyroJerkStdDevX"                   
[31] "timeBodyGyroJerkStdDevY"                   
[32] "timeBodyGyroJerkStdDevZ"                   
[33] "timeBodyAccelerationMagMean"               
[34] "timeBodyAccelerationMagStdDev"             
[35] "timeGravityAccelerationMagMean"            
[36] "timeGravityAccelerationMagStdDev"          
[37] "timeBodyAccelerationJerkMagMean"           
[38] "timeBodyAccelerationJerkMagStdDev"         
[39] "timeBodyGyroMagMean"                       
[40] "timeBodyGyroMagStdDev"                     
[41] "timeBodyGyroJerkMagMean"                   
[42] "timeBodyGyroJerkMagStdDev"                 
[43] "frequencyBodyAccelerationMeanX"            
[44] "frequencyBodyAccelerationMeanY"            
[45] "frequencyBodyAccelerationMeanZ"            
[46] "frequencyBodyAccelerationStdDevX"          
[47] "frequencyBodyAccelerationStdDevY"          
[48] "frequencyBodyAccelerationStdDevZ"          
[49] "frequencyBodyAccelerationJerkMeanX"        
[50] "frequencyBodyAccelerationJerkMeanY"        
[51] "frequencyBodyAccelerationJerkMeanZ"        
[52] "frequencyBodyAccelerationJerkStdDevX"      
[53] "frequencyBodyAccelerationJerkStdDevY"      
[54] "frequencyBodyAccelerationJerkStdDevZ"      
[55] "frequencyBodyGyroMeanX"                    
[56] "frequencyBodyGyroMeanY"                    
[57] "frequencyBodyGyroMeanZ"                    
[58] "frequencyBodyGyroStdDevX"                  
[59] "frequencyBodyGyroStdDevY"                  
[60] "frequencyBodyGyroStdDevZ"                  
[61] "frequencyBodyAccelerationMagMean"          
[62] "frequencyBodyAccelerationMagStdDev"        
[63] "frequencyBodyBodyAccelerationJerkMagMean"  
[64] "frequencyBodyBodyAccelerationJerkMagStdDev"
[65] "frequencyBodyBodyGyroMagMean"              
[66] "frequencyBodyBodyGyroMagStdDev"            
[67] "frequencyBodyBodyGyroJerkMagMean"          
[68] "frequencyBodyBodyGyroJerkMagStdDev"





