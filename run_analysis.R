#!/usr/bin/Rscript

rawDataZip <- "rawData.zip"
if (!file.exists(rawDataZip)){
	rawDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(rawDataUrl, destfile = rawDataZip, method = "curl")
	unzip(rawDataZip)
}

featuresPath <- "UCI HAR Dataset/features.txt"
features <- read.table(featuresPath, colClasses = c("numeric", "character"))[,2]

activitiesPath <- "UCI HAR Dataset/activity_labels.txt"
activities <- read.table(activitiesPath, colClasses = c("numeric", "character"))[,2]

xTestPath <- "UCI HAR Dataset/test/X_test.txt"
xTest <- read.table(xTestPath, col.names = features)

yTestPath <- "UCI HAR Dataset/test/y_test.txt"
yTest <- read.table(yTestPath)[,1]
yTestFactors <- factor(yTest, labels = activities)
yTestChar <- as.character(yTestFactors)

test <- cbind(yTestChar, xTest)

xTrainPath <- "UCI HAR Dataset/train/X_train.txt"
xTrain <- read.table(xTrainPath, col.names = features)

yTrainPath <- "UCI HAR Dataset/train/y_train.txt"
yTrain <- read.table(yTrainPath)[,1]
yTrainFactors <- factor(yTrain, labels = activities)
yTrainChar <- as.character(yTrainFactors)

train <- cbind(yTrainChar, xTrain)

names(train)[1] <- "activities"
names(test)[1] <- "activities"
whole <- rbind(test, train)

allNames <- names(whole)
isActivityCol <- grepl("activities", allNames)
isMeanCol <- grepl(".mean.", allNames)
isStdCol <- grepl(".std.", allNames)
selectedCols <- isActivityCol | isMeanCol | isStdCol

targetData <- whole[,selectedCols]
targetData$activities <- as.character(targetData$activities)

write.csv(targetData, "clean.csv")
