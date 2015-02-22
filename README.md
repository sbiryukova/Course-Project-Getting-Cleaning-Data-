# Course Project (Getting & Cleaning Data Course)

This is a repo for "Getting and Cleaning Data" Course Project.

The main file here is the script file <a href="https://github.com/sbiryukova/Course-Project-Getting-Cleaning-Data-/blob/master/run_analysis.R">run_analysis.R</a>.<br>
The <a href="https://github.com/sbiryukova/Course-Project-Getting-Cleaning-Data-/blob/master/Output.txt">Output.txt</a> file contains the output file for the code with the averages of each variable for each activity and each subject computed on the basis of the tidy data file.<br>
The <a href="https://github.com/sbiryukova/Course-Project-Getting-Cleaning-Data-/blob/master/Codebook.md">Codebook.md</a> file contains some comments on the file and variables names and on the logic of work done within the project.

<h1>The script file</h1>

The script works if the UCI HAR Dataset folder is unpacked into the default working directory.<br>
The script does the following:
<ul><li type=none>It merges the training and the test data into one data set.
<li type=none>Then it extracts the variables with the mean and standard deviation for each measurement. 
<li type=none>It takes the descriptive activity names and uses it to name the activities in the data set.
<li type=none>It labels the data set with descriptive variable names. 
<li type=none>And, finally, it creates an independent tidy data set with the average of each variable for each activity and each subject.</ul><br>
The script itself contains some extra comments about each step of the process.
