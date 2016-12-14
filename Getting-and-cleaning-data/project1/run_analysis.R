setwd("C:/MyWorkspace/MyLearning/Data Science/Data Science Coursera/Getting-and-cleaning-data/project1")
library(reshape2)

# load activity label & feature
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

featureLabels <- read.table("UCI HAR Dataset/features.txt")
featureLabels[,2] <- as.character(featureLabels[,2])

# find out required column name of mean and standard deviation
featureWanted <- grep(".*mean.*|.*std.*",featureLabels[,2])
requiredColumnName <- featureLabels[featureWanted,2]

requiredColumnName <- gsub("-mean","Mean",requiredColumnName)
requiredColumnName = gsub('-std', 'Std', requiredColumnName)
requiredColumnName <- gsub('[-()]', '', requiredColumnName)

# load the data set separately. train first, test followed.
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featureWanted]
trainActivities <-  read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featureWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge the data and add column name
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", requiredColumnName)

# create a second data set for average of variables
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
