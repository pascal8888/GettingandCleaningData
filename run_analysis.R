##
## STEP 1 <- Merges the training and the test sets to create one data set.
##
##  Get the source data set and extract in working directory (only downloads and unzips if it does not already exist)
if (!file.exists("source_dataset.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ",
                  "source_dataset.zip", "auto", TRUE)
}
if (!file.exists("UCI HAR Dataset")) {
    unzip("source_dataset.zip")
}
##Read the files into vectors for the labels and data frames to hold the values of subject, activity, and measures
vctr_activity_names <- read.table("UCI HAR Dataset/activity_labels.txt", as.is = TRUE)[, 2] ##col 2 only
vctr_feature_labels <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)[, 2] ##col 2 only
df_test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")
df_train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")
df_test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
df_train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
df_test_measures <- read.table("UCI HAR Dataset/test/X_test.txt")
df_train_measures <- read.table("UCI HAR Dataset/train/X_train.txt")
##Combine the data frames (append columns to the right and rows below)
df_combined <-
    cbind(
        rbind(df_train_subject, df_test_subject),
        rbind(df_train_activity, df_test_activity),
        rbind(df_train_measures, df_test_measures)
    )
##
## STEP 2 <- Extracts only the measurements on the mean and standard deviation for each measurement.
##
## Set the names for ALL columns
names(df_combined) <- c("Subject", "Activity", vctr_feature_labels)
##Grep the feature labels to grab only those with "-std()" or "-mean()" in the name
df_combined <- df_combined[, grep("Subject|Activity|-mean()|-std()",names(df_combined))]
##
## STEP 3 <- Uses descriptive activity names to name the activities in the data set
##
##Translate the activity codes and replace the values with the verbs. Thanks to community for grep help!
vctr_activity_names <-
    paste(
        substr(vctr_activity_names , 1, 1),
        sub("_", "", substr(vctr_activity_names , 2, max(nchar(vctr_activity_names )))),
        sep = ""
    )
df_combined$Activity <- vctr_activity_names [df_combined$Activity]
##
## STEP 4 <- Appropriately labels the data set with descriptive variable names.
##
## Partially done in the process of step 2. Additional step - remove the "Freq" meausures.  Otherwise keep the variable names as column headers - changing them would require explanation, this is tidyer. The features_info.txt file, found in the root of the unzipped source data file, gives a very good explanation of the meanings.
df_combined <- df_combined[, grep("Freq",invert=TRUE,names(df_combined))]
##
## STEP 5 <- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Good luck!
##
library(reshape2)
## use melt to break down the measures into key pairs to prepare to cast
finaldata <- melt(df_combined, id=c("Subject","Activity"), measure.vars = colnames(df_combined[, grep("mean|std", colnames(df_combined))]))
## use cast to set the final data frame calculating the mean and grouping by Subject (30) and Activity (6). which results in 180 rows of 68 variables.
finaldata <- dcast(finaldata, Subject + Activity ~ variable, mean)
## final result
write.table(finaldata, file="finaldata.txt", row.names = FALSE)
View(read.table("finaldata.txt",header=T))
##remove objects from environment that are no longer needed
rm("vctr_activity_names","vctr_feature_labels","df_test_subject","df_train_subject","df_test_activity","df_train_activity","df_test_measures","df_train_measures","df_combined")
print("Data has been processed. finaldata.txt has been written to the working directory. It contains the tidy data set of the mean of each subject's activities across each feature measurement. The file has been loaded for viewing and the data frame has been left in the R environment")
