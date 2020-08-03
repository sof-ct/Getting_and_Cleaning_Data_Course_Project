#You should create one R script called run_analysis.R that does the following...

#The first step is to make sure the dplyr package is installed
library(dplyr)

# To begin working we need to prepare the data 
# The first step is to download the data file we will be working with 

# We assign a destination to the data set
destfile <- "C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset.zip"

# We assign the URL to a variable
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# We download the file 
download.file(fileURL, destfile)

# Once the file is downloaded it´s important to un-zip it, as it is a zip file. 
unzip(destfile, exdir = "UCI HAR Dataset")


# 1. Merges the training and the test sets to create one data set
# We begin by assigning a variable to each piece of the data set
features <- read.table("C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("C:/Users/sofim/Documents/R/R Programming Coursera/Getting and Cleanning Data/Getting and Cleaning Data Course Project/UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Merge train and test data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# Merge the whole data
Merged_Data <- cbind(x_data,y_data,subject_data)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Tidy_Data <- Merged_Data %>%
  select(subject, code, contains("mean"), contains("std"))


# 3. Uses descriptive activity names to name the activities in the data set.
Tidy_Data$code <- activities[Tidy_Data$code, 2]


# 4. Appropriately labels the data set with descriptive variable names.
names(Tidy_Data)[2] = "activity"
names(Tidy_Data)<-gsub("Acc", "Accelerometer", names(Tidy_Data))
names(Tidy_Data)<-gsub("Gyro", "Gyroscope", names(Tidy_Data))
names(Tidy_Data)<-gsub("BodyBody", "Body", names(Tidy_Data))
names(Tidy_Data)<-gsub("Mag", "Magnitude", names(Tidy_Data))
names(Tidy_Data)<-gsub("^t", "Time", names(Tidy_Data))
names(Tidy_Data)<-gsub("^f", "Frequency", names(Tidy_Data))
names(Tidy_Data)<-gsub("tBody", "TimeBody", names(Tidy_Data))
names(Tidy_Data)<-gsub("-mean()", "Mean", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("-std()", "STD", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("-freq()", "Frequency", names(Tidy_Data), ignore.case = TRUE)
names(Tidy_Data)<-gsub("angle", "Angle", names(Tidy_Data))
names(Tidy_Data)<-gsub("gravity", "Gravity", names(Tidy_Data))

# 5.  Finally, creates a second independent tidy data set with the average of each variable for each activity and each subject.
Tidy_Data2 <- Tidy_Data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))

# To finish we store the data in a table and our tidy data is ready 
write.table(Tidy_Data2, "TidyDataSet.txt", row.names = FALSE)

str(Tidy_Data2)
