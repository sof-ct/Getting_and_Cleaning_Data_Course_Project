# Code Book

## Data Set Description 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The Variables
We begin by assigning a variable to each piece of the data set, as a result there are 8 
variables created: features, activities, subject_test, x_test, y_test, subject_train, y_train
and x_train. Each one is created with the function read.table(), assigning column names 
to each piece of the data and organizing the loaded data set for us to easily merge the data.  


## Transformations performed 
### Step 1
To begin with, the raw data set is downloaded and loaded to R under the folder UCI HAR Data set. 
Once the file is loaded and un-zipped, we have to merge the the training and the test sets to create one data set. 
Data set X is created by merging x_train and x_test variables using the rbind() function. Data set Y is created by merging y_train and y_test variables using rbind() function.
The Subject data set is created by merging subject_train and subject_test variables using rbind() function. 
Finally, to create a single data set we create Merged_Data by merging Subject, Y and X using the cbind() function. 

### Step 2
The second step is extracting only the measurements on the mean and standard 
deviation for each measurement. This far we have the train and test data merged
into a single data set: Merged_Data. the next step is only taking into consideration the 
mean and standard deviation columns, to make this possible we use the select() function. 

### Step 3
The thrid step is using descriptive activity names to name the activities in 
the data set. To make this possible the entire numbers in the code column 
of the Tidy_Data Set are replaced with the corresponding activity taken 
from second column of the activities variable. 

### Step 4
The fourth step is appropriately labeling the data set with descriptive 
variable names. First we need to indicate R we are renaming
the name column column contained in the Tidy_Data into activity, 
and by using the gsub() function we indicate how each column will be re-named. 

### Step 5 
The fifth step is taking the data set in step 4 and creating a second, independent tidy 
data set with the average of each variable for each activity and each subject. The first 
function used in here is group_by() for only using the subject and the activity 
variables from the Tidy Data Set, once we use this function we add the 
summarise_all() function for taking into consideration the mean of the data
we have selescted. 

Finally, we take this result, stored in the Tidy_Data2 variable, and use it to create a table 
with the Final Data set, stored in the document "TidyDataSet.txt"
