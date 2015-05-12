path_activity_labels <- paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep="")  ##set the path including file name for the activity labels text file
df_activity_labels <- read.csv(path_activity_labels,header=FALSE,colClasses = "character")  ##read the activity labels into a data frame as character
path_train <- paste(getwd(),"/UCI HAR Dataset/train",sep="")  ##set the directory for training dataset to a subdirectory of the working directory
flist_train <- list.files(path_train, full.names = TRUE, recursive=TRUE)
df_subject <- read.csv(flist_train[1],colClasses = "character")
df_x <- read.csv(flist_train[2],header=TRUE)
names(df_x) <- "X2"
df_y <- read.csv(flist_train[3],colClasses = "character")
df_combined<- cbind(df_subject,df_x,df_y)
## begin apply the activity labels to the data set
for (i in 1:nrow(df_combined)) {
    if (df_combined[i,3] == "1") {
        df_combined[i,3] <- df_activity_labels[1,1]
    }
    if (df_combined[i,3] == "2") {
        df_combined[i,3] <- df_activity_labels[2,1]
    }
    if (df_combined[i,3] == "3") {
        df_combined[i,3] <- df_activity_labels[3,1]
    }
    if (df_combined[i,3] == "4") {
        df_combined[i,3] <- df_activity_labels[4,1]
    }
    if (df_combined[i,3] == "5") {
        df_combined[i,3] <- df_activity_labels[5,1]
    }
    if (df_combined[i,3] == "6") {
        df_combined[i,3] <- df_activity_labels[6,1]
    }
## end apply the activity labels to the data set
}



## rm(list = ls())
