# run_analysis.R
# Rich Morrison, 03 April 2016
# built under R version 3.2.4 

# check and install R packages
ifelse(any(grepl("dplyr", installed.packages())),"dplyr already installed", 
       install.package("dplyr"))
library(dplyr)

# download and extract the files into the working directory

# read the training and the test sets to create one data set.
# set file paths for input files, 
fileActivityLabels <- "./UCI HAR Dataset/activity_labels.txt"
fileFeatures <- "./UCI HAR Dataset/features.txt"
fileSubjectTest <- "./UCI HAR Dataset/test/subject_test.txt"
fileXTest <- "./UCI HAR Dataset/test/X_test.txt"
fileYTest <- "./UCI HAR Dataset/test/y_test.txt"
fileSubjectTrain <- "./UCI HAR Dataset/train/subject_train.txt"
fileXTrain <- "./UCI HAR Dataset/train/X_train.txt"
fileYTrain <- "./UCI HAR Dataset/train/y_train.txt"

# read test and train subject labels "subject_train.txt", "subject_test.txt"
df_subject <- data.frame(
        rbind(  read.table(fileSubjectTrain, header=FALSE),
                read.table(fileSubjectTest, header=FALSE)
              )
        )
        
# read and test and train activity labels from "Y_test.txt", "Y_train.txt" 
df_activity_codes <- data.frame(
        rbind(  read.table(fileYTrain, header=FALSE),
                read.table(fileYTest, header=FALSE)
             )
        )
df_activity_labels <- data.frame(read.table(fileActivityLabels, header=FALSE))

# read the variable names of the feature vector
df_feature_names <- data.frame(read.table(fileFeatures, header=FALSE, 
                                          stringsAsFactors = FALSE))

# merge measurement observation data: "X_test.txt", "X_train.txt"
df_observations <- data.frame(
        rbind(  read.table(fileXTrain, header=FALSE),
                read.table(fileXTest, header=FALSE)
                )
        )
names(df_observations) <- df_feature_names$V2

# Extract only the measurements on the mean and standard deviation variables
# mean(): Mean value; # std(): Standard deviation
# use df_feature_names to find the columns with mean() and std() values
df_observations_mean_std <- 
        df_observations[,which(grepl("mean\\(\\)|std\\(\\)",
                                     df_feature_names$V2))]

# build one data structure (data.frame), match the activity label to the row
df_all <- data.frame("subject"=df_subject$V1,
                     "activity"=df_activity_labels[
                             match(df_activity_codes$V1, 
                                   df_activity_labels$V1),
                                   "V2"],
                     df_observations_mean_std)

# new data.frame to summarize mean variable values by subject and activity
by_subject_activity <- group_by(df_all, subject, activity)
df_summary <- summarize_each(by_subject_activity, funs(mean), 
                             one_of(df_feature_names$V2))

# TODO: 4.) Appropriately labels the data set with descriptive variable names.
# all variables have descriptive variable names in new data structure.
names(df_summary) <- gsub("^t","time",names(df_summary))
names(df_summary) <- gsub("^f","frequency",names(df_summary))
names(df_summary) <- gsub("\\.m","M",names(df_summary))
names(df_summary) <- gsub("\\.std","StdDev",names(df_summary))
names(df_summary) <- gsub("Acc","Acceleration",names(df_summary))
names(df_summary) <- gsub("\\.","",names(df_summary))

write.table(df_summary, file="data_summary.txt", row.name=FALSE)
"Analysis complete.  No errors. No warnings. Output file: data_summary.txt"
