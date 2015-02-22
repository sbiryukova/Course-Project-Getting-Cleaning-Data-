#Install and load the plyr (or dplyr) package
install.packages("plyr", type="source")
library(plyr)

#Set the UCI HAR Dataset folder as your working directory (UCI HAR Dataset should be in your default WD)
setwd(paste(getwd(), "/", "UCI HAR Dataset", sep=""))

#STEP 1
#Read the test & train data
#Train data
train <- read.table("./train/X_train.txt")
#Test data
test <- read.table("./test/X_test.txt")

#Each file contains 561 features, i.e. 561 columns
#Now add to these filess the labels data (col.562) & the subject identifier (col.563)
train[,562] <- read.table("./train/y_train.txt")
train[,563] <- read.table("./train/subject_train.txt")
test[,562] <- read.table("./test/y_test.txt")
test[,563] <- read.table("./test/subject_test.txt")

#Merge the data sets
MergedData <- rbind(train, test)

#STEP 2
#Read the file with feature names (and here we are working with characters)
features <- read.table("features.txt", colClasses = c("character"))

#Label the data set (adding labels for the last two columns manually)
a <- c(562, "Activity")
b <- c(563, "SubjectID")
Fullnames <- rbind(rbind(features, a), b)
names(MergedData) <- Fullnames[,2]

#Select features that represent means or standard errors
#Take only those having 'mean()' or 'std()' in the name together with the last two columns
selection <- grep("(mean|std)\\(\\)|Activity|SubjectID", Fullnames[, 2])
#Now subset to the new data set using this selection
AlmostTidy <- MergedData[,selection]

#STEP 3
#Read the activity names (labels)
activities_names <- read.table("activity_labels.txt")
#Rename the columns in the table to perform the following matching
activities_names <- rename(activities_names, c("V1" = "Activity", "V2" = "Activity_Name"))
#Name the activities in the data set with the descriptive activity names (add the names)
Tidy <- join(AlmostTidy, activities_names, by = "Activity")

#STEP 4
#Use the 'features_info' file to label the data set with descriptive variable names appropriately
#Decode 't' and 'f' shortcuts
names(Tidy) <- gsub('^t',"TimeDomain_",names(Tidy))
names(Tidy) <- gsub('^f',"FrequencyDomain_",names(Tidy))
#Decode 'Mag', 'Acc' and 'Gyro'
names(Tidy) <- gsub('Mag',"Magnitude",names(Tidy))
names(Tidy) <- gsub('Acc',"Acceleration",names(Tidy))
names(Tidy) <- gsub('Gyro',"AngularVelocity",names(Tidy))
#Decode 'std'
names(Tidy) <- gsub('std',"StandardDeviation",names(Tidy))
#Remove ()
names(Tidy) <- gsub('\\(|\\)',"",names(Tidy))
#Tidy DATA SET IS NOW TIDY.

#STEP 5
#compute averages by activity and subject for variables in columns 1-66
Tidy_output <- ddply(Tidy, .(SubjectID, Activity_Name), function(x) colMeans(x[, 1:66]))
write.table(Tidy_output, file = "Output.txt", row.name=FALSE)
