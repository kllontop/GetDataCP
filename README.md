GetDataCP
=========

JHU - Getting &amp; Clean Data Course Project
Breaking Down the Code
----------------------
My code can be loosely broken down into these 5 steps as given in the assignment:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For the Viewer's ease, I have included comments (eg. ##Step1,##Step2, etc.) which
mark each step in the code. In this markdown, I will explain what I have done in each section.

###Step 1: Merge the Training and Test Data Sets
Skipping over lines 4-10 - involving the reading in of necessary files such as features.txt and activity_labels.txt - Step 1 runs from lines 13-30. Using read.table, I read in both sets of Test and Train data, and merge the three files for each set (subject, X, and y) together to create Test & Train data sets. In lines 27-30, the two data sets are merged and column names are added using the values provided in features.txt.

###Step 2: Extract Measurements of Means and Standard Deviations
Lines 33-39 are used to locate and extract the columns of data. grep() is used to create and index for columns including "mean()" and "std()" in their names. A new data set Mean.Stds is formed to include the Subject, Activity, Means, and Standard Devs.

###Step 3: Use Descriptive Names for Activities
In line 9, I created a character vector of descriptive names such as Walking, Walking Up stairs, Laying Down, etc. In line 44, merge() is used to merge the activity labels with the Mean.Stds data set, using the activity ID (temporarily renamed Action_ID so merge wouldn't get confused) as the merging ID.

###Step 4: Appropriately Label Variable Names with Description
At this point, I decided that I wanted to use melt() to create a "long", tidy data set as per Hadley Wickham's paper titled "Tidy Data" (http://vita.had.co.nz/papers/tidy-data.pdf). The main points of this method are for one variable to be in one column and for one observation to be in one row.

After melting the data set in line 54, I create factor variables (Domain, Acceleration Type, Signal, Jerk, Mag, Function, and Direction) and proceed to add columns for each factor onto the existing data set to properly describe each measurement based on its variables. For example, the tBodyAcc-mean()-X measurement would have have its own row containing Domain="Time", Acceleration Type="Body", Signal="Accelerometer", Jerk="No Jerk", Mag="No Mag", Function="Mean", and Direction="X". Thus I can distinctly understand what a measurement measures.

This section of code ends on line 120 with a data set called "Tidy.Data" which I included as a .txt file on my GitHub repo as an extra bit for anyone who's curious.

###Step 5: Create a Second Tidy Data Set with Averages for the Measurements of Each Subject's Activities
Lines 125 to the end involve this process. First, I used split() to split the large Tidy.Data set by Subject. Then, I wrote a for loop which further split the subsets of Tidy.Data by Activity and applied mean(). The output was collected in All_Ave which I then changed into a data frame Tidy.Data.2. After some reorganization, write.table() on Tidy.Data.2 produces the "second, independent, tidy data set" requested.

Thanks for reading.
