path_activity_labels <- paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep="")
df_activity_labels <- read.csv(path_activity_labels,header=FALSE)
path_train <- paste(getwd(),"/UCI HAR Dataset/train",sep="")
flist_train <- list.files(path_train, full.names = TRUE, recursive=TRUE)
df_subject <- read.csv(flist_train[1],colClasses = "character")
df_x <- read.csv(flist_train[2],header=TRUE)
names(df_x) <- "X2"
df_y <- read.csv(flist_train[3],colClasses = "character")
df_combined<- cbind(df_subject,df_x,df_y)

## rm(list = ls())

