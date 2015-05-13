path_activity_labels <- paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep="")  ##set the path including file name for the activity labels text file
path_feature_labels <- paste(getwd(),"/UCI HAR Dataset/features.txt",sep="")  ##set the path including file name for the feature labels text file
df_activity_labels <- read.csv(path_activity_labels,header=FALSE,colClasses = "character")  ##read the activity labels into a data frame as character
df_feature_labels <- read.csv(path_feature_labels,header=FALSE,sep="",colClasses = "character")  ##read the feature labels into a data frame as character
tmp1 <- grep(pattern="-std()",x=df_feature_labels[,2],fixed=TRUE)  ##tmp1 holds the indices for labels that have "-std()" in the name
tmp2 <- grep(pattern="-mean()",x=df_feature_labels[,2],fixed=TRUE) ##tmp2 holds the indices for labels that have "-mean()" in the name
tmp3 <- c(tmp1,tmp2)  ##join tmp1 and tmp2 vectors to get a vector of indices of df_feature_labels with our desired measurements
v_final_feature_labels <- unlist(df_feature_labels[tmp3,2]) ##vector of measurement labels
path_train <- paste(getwd(),"/UCI HAR Dataset/train",sep="")  ##set the directory for training dataset to a subdirectory of the working directory
path_test <- paste(getwd(),"/UCI HAR Dataset/test",sep="")  ##set the directory for testing dataset to a subdirectory of the working directory
flist_train <- list.files(path_train, full.names = TRUE, recursive=TRUE)
flist_test <- list.files(path_test, full.names = TRUE, recursive=TRUE)
df_subject_train <- read.csv(flist_train[1],colClasses = "character")
df_subject_test <- read.csv(flist_test[1],colClasses = "character")
df_x_train <- read.csv(flist_train[2],header=TRUE)
df_x_test <- read.csv(flist_test[2],header=TRUE)
names(df_x_train) <- "X2" ## fix the header name problem in the data file
names(df_x_test) <- "X2" ## fix the header name problem in the data file
df_y_train <- read.csv(flist_train[3],colClasses = "character")
df_y_test <- read.csv(flist_test[3],colClasses = "character")
## combine the subject, x measures, and position variable into 2 data frames (train & test)
df_combined_train<- cbind(df_subject_train,df_x_train,df_y_train)
df_combined_test<- cbind(df_subject_test,df_x_test,df_y_test)
names(df_combined_train) <- c("Subject","Measures","Activity") ##name the columns to describe the data contained in the observations
names(df_combined_test) <- c("Subject","Measures","Activity") ##name the columns to describe the data contained in the observations
## begin apply the activity labels to the data sets (at this point train and test are still separate)  *NOTE - clean this up with lapply*
for (i in 1:nrow(df_combined_train)) {
    if (df_combined_train[i,3] == "1") {
        df_combined_train[i,3] <- df_activity_labels[1,1]
    }
    if (df_combined_train[i,3] == "2") {
        df_combined_train[i,3] <- df_activity_labels[2,1]
    }
    if (df_combined_train[i,3] == "3") {
        df_combined_train[i,3] <- df_activity_labels[3,1]
    }
    if (df_combined_train[i,3] == "4") {
        df_combined_train[i,3] <- df_activity_labels[4,1]
    }
    if (df_combined_train[i,3] == "5") {
        df_combined_train[i,3] <- df_activity_labels[5,1]
    }
    if (df_combined_train[i,3] == "6") {
        df_combined_train[i,3] <- df_activity_labels[6,1]
    }
}
for (i in 1:nrow(df_combined_test)) {
    if (df_combined_test[i,3] == "1") {
        df_combined_test[i,3] <- df_activity_labels[1,1]
    }
    if (df_combined_test[i,3] == "2") {
        df_combined_test[i,3] <- df_activity_labels[2,1]
    }
    if (df_combined_test[i,3] == "3") {
        df_combined_test[i,3] <- df_activity_labels[3,1]
    }
    if (df_combined_test[i,3] == "4") {
        df_combined_test[i,3] <- df_activity_labels[4,1]
    }
    if (df_combined_test[i,3] == "5") {
        df_combined_test[i,3] <- df_activity_labels[5,1]
    }
    if (df_combined_test[i,3] == "6") {
        df_combined_test[i,3] <- df_activity_labels[6,1]
    }
}
## end apply the activity labels to the data set
df_merged <- merge(df_combined_train,df_combined_test,all=TRUE)  ##combine train and test

# df_merged[, v_final_feature_labels] <- NA  ##add columns for 66 features -std or -mean

## rm(list = ls())
