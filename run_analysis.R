Xtrain <- read.table("train/X_train.txt")
Ytrain <- read.table("train/y_train.txt")
Subtrain <- read.table("train/subject_train.txt")

Xtest <- read.table("test/X_test.txt")
Ytest <- read.table("test/y_test.txt")
Subtest <- read.table("test/subject_test.txt")

# create 'X' data set
Xdata <- rbind(Xtrain, Xtest)

# create 'Y' data set
Ydata <- rbind(Ytrain, Ytest)

# create 'Subject' data set
Subdata <- rbind(Subtrain, Subtest)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

features <- read.table("features.txt")

# extract the columns with mean() or std() in their titles
MeanandStandart <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the columns
Xdata <- Xdata[, MeanandStandart]

# correct the column titles
names(Xdata) <- features[MeanandStandart, 2]

# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################

Acts <- read.table("activity_labels.txt")

# update values with correct activity titles
Ydata[, 1] <- activities[Ydata[, 1], 2]

# correct column title
names(Ydata) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################


names(Subdata) <- "subject"

# bind the data in a single data set
Alldata <- cbind(Xdata, Ydata, Subdata)

# Step 5
# Create a second, independent tidy data set with the average of
# each variable for each activity and each subject
###############################################################################


Avgdata <- ddply(Alldata, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(Avgdata, "Tidydataset.txt", row.name=FALSE)    
