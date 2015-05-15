##
## STEP 1 <- Merges the training and the test sets to create one data set.
##
##  Get the source data set  (uncomment lines 4 - 14 when finished so we don't have to download every time it is run while developing the script - also - remove the text in parentheses on this line)
# if (!file.exists("uci_dataset.zip")) {
#     download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ",
#                   "uci_dataset.zip", "curl", TRUE)
# }
#
# # Extract the archive contents to the current working subdirectory.
#
# if (!file.exists("UCI HAR Dataset")) {
#     unzip("uci_dataset.zip")
# }
##Read the files into vectors for the labels and data frames to hold the values of subject, activity, and measures
vctr_activity_names <- read.table('UCI HAR Dataset/activity_labels.txt', as.is = TRUE)[, 2] ##col 2 only
vctr_feature_labels <- read.table('UCI HAR Dataset/features.txt', as.is = TRUE)[, 2] ##col 2 only
df_test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
df_train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
df_test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")
df_train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")
df_test_measures <- read.table('UCI HAR Dataset/test/X_test.txt')
df_train_measures <- read.table('UCI HAR Dataset/train/X_train.txt')
##Combine the data frames
df_combined <-
    cbind(
        rbind(df_train_activity, df_test_activity),
        rbind(df_train_subject, df_test_subject),
        rbind(df_train_measures, df_test_measures)
    )
##Grep the feature labels to grab only those with "-std()" or "-mean()" in the name
std_filter<- grep(pattern="-std()",x=vctr_feature_labels,fixed=TRUE)
mean_filter <- grep(pattern="-mean()",x=vctr_feature_labels,fixed=TRUE)
combined_filter <- c(std_filter,mean_filter)
vctr_final_feature_labels <- unlist(vctr_feature_labels[combined_filter])
##Set the column names
names(df_combined) <- c("Activity","Subject",vctr_feature_labels)
##
## STEP 3 <- Uses descriptive activity names to name the activities in the data set
##
##Translate the activity codes and replace the values with the verbs, Thanks to community for grep help!
vctr_activity_names <-
    paste(
        substr(vctr_activity_names , 1, 1),
        sub("_", "", substr(vctr_activity_names , 2, max(nchar(vctr_activity_names )))),
        sep = ""
    )
df_combined$Activity <- vctr_activity_names [df_combined$Activity]

##remove objects from environment that are no longer needed
rm("vctr_activity_names","vctr_feature_labels","df_test_subject","df_train_subject","df_test_activity","df_train_activity","df_test_measures","df_train_measures","combined_filter","std_filter","mean_filter")
