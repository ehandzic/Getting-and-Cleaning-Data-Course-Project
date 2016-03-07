# Download data and unzip data
dataDir <- file.path(getwd(),"data")
fileName <- file.path(dataDir, "Dataset.zip")
outputFileName <- file.path(dataDir,"TidyDataSet.txt")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists(dataDir)){dir.create(dataDir)}

# download.file(url,fileName)
# 
# unzip(fileName, exdir = dataDir)

# Merges the training and the test sets to create one data set.

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")


activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

features <- read.table('./data/UCI HAR Dataset/features.txt')



colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')


trainMerge <- cbind(y_train, subject_train, x_train)
testMerge <- cbind(y_test, subject_test, x_test)
mergeFinal <- rbind(trainMerge, testMerge)

# Extracts only the measurements on the mean and standard deviation for each measurement.
colNames <- colnames(mergeFinal)

meanStd <- (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))

meanStdDataSet <- mergeFinal[ , meanStd == TRUE]

#Assign descriptive activity names to name the activities in the data set

descriptiveActivityNamesDataSet <- merge(meanStdDataSet, activityLabels,by='activityId',all.x=TRUE)

# Independent tidy data set with the average of each variable for each activity and each subject.

TidyDataSet <- aggregate(. ~subjectId + activityId + activityType, descriptiveActivityNamesDataSet, mean)
TidyDataSet <- TidyDataSet[order(TidyDataSet$subjectId, TidyDataSet$activityId),]

#Write tidy data set to file

write.table(TidyDataSet, file = outputFileName)

