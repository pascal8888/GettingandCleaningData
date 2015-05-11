path_train <- paste(getwd(),"/UCI HAR Dataset/train",sep="")
flist_train <- list.files(path_train, full.names = TRUE, recursive=TRUE)
for (file in flist_train){
     if (!exists("dataset")){
         dataset <- read.csv(file)
     }
    if (exists("dataset")){
        temp_dataset <-read.csv(file)
        dataset<-rbind(dataset, temp_dataset)
        rm(temp_dataset)
    }
}
# path2 <- paste(getwd(),"/UCI HAR Dataset/test",sep="")
# flist1 <- list.files(path1, full.names = TRUE, recursive=TRUE)
# for (file in flist1){
#     if (!exists("dataset")){
#         dataset <- read.table(file)
#     }
#     if (exists("dataset")){
#         temp_dataset <-read.table(file)
#         dataset<-rbind(dataset, temp_dataset)
#         rm(temp_dataset)
#     }
# }
