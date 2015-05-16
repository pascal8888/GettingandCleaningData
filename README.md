#README - Tidy Data Set Created From:
Human Activity Recognition Using Smartphones Dataset
Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws | www.smartlab.ws
### This tidy data set contains the mean of standard deviation and mean of 66 feature measures for 30 subjects across 6 activities.  It was derived from the study data as described below.
#DESCRIPTION OF run_analysis.R SCRIPT
1. STEP 1 <- Merges the training and the test sets to create one data set.
    1. downloads and unzips source data if it does not already exist
    2. reads files into vectors and data frames
    3. appends the data frames column and row wise
2. STEP 2 <- Extracts only the measurements on the mean and standard deviation for each measurement.
    1. Sets the names for the measures variables according to the vector of feature labels
    2. Sets the data frame to a subset of only those with "std()" & "mean()" measures
3. STEP 3 <- Uses descriptive activity names to name the activities in the data set
    1. Use grep to translate the numbers 1 - 6 to the corresponding verbs
    2. Overwrite the numbers in the data frame with the corresponding verbs
4. STEP 4 <- Appropriately labels the data set with descriptive variable names.
    1. Removes unwanted "Freq" column
    2. Columns retain variable names described in CodeBook.md
5. STEP 5 <- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Good luck!
    1. Uses reshape2 to melt the measures variables to key pairs
    2. Uses reshape2 - cast to set the final data frame calculating the mean and grouping by Subject (30) and Activity (6). which results in 180 rows of 68 variables.
    3. Writes the result to a table - "finaldata.txt"
    4. Opens the file for viewing
    5. Cleans up the objects in the environment, leaving finaldata data frame.
