# Getting and Cleaning Data Course Project


# Load the data into R
test_set <- read.table("/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/test/X_test.txt")
test_lbl <- read.table("/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/test/Y_test.txt")
test_subject <- read.table("/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/test/subject_test.txt")
train_set <- read.table("/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/train/X_train.txt")
train_lbl <- read.table("/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/train/subject_train.txt")
features <- read.table("/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/features.txt")
activity_lbl <- read.table("/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/activity_labels.txt")

# Rename the variables using features list
names(test_set) <- features$V2
names(train_set) <- features$V2
names(activity_lbl) <- c("activity_id","activity")

# Merge the data with the labels and subject number and create a binary variable to indicate data type
test <- as.data.frame(c("test",test_subject,test_lbl,test_set))
train <- as.data.frame(c("train",train_subject,train_lbl,train_set))

# Label activites with apropriate name
test2 <- merge(activity_lbl,test, by.x = "activity_id", by.y = "V1.1")
train2 <- merge(activity_lbl,train, by.x = "activity_id", by.y = "V1.1")

# Rename the bunary variable before apending the data
names(test2)[names(test2)=="X.test."] <- "type"
names(train2)[names(train2)=="X.train."] <- "type"

# Append the data frames to eachother
full <- rbind(test2,train2)

# Drop variables contains meanFreq
full2 <- full[,-grep("Freq",names(full), value = F)]

# Drop variables other than mean & std
final_list <- c(4,3,2,grep("mean|std",names(full2), value = F))
final_data <- full2[,final_list]

# Rename variables properly
names(final_data) <- (gsub("[[:punct:]]","",names(final_data)))
names(final_data) <- (gsub("BodyBody","Body",names(final_data)))
names(final_data) <- (gsub("mean","Mean",names(final_data)))
names(final_data) <- (gsub("std","STD",names(final_data)))
names(final_data) <- (gsub("V1","subject_id",names(final_data)))

# Reorder data by: subject_id, type and activity
final_data <- final_data[order(final_data[,1],final_data[,2],final_data[,3]),]
rownames(final_data) <- 1:nrow(final_data) # Correct row numbers after ordering the data as desired.

# By now we have a tidy dataset, next step is to creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
final_summary <- aggregate(final_data[,4:69], final_data[,1:3], mean)

# Reorder data by: subject_id, type and activity
final_summary <- final_summary[order(final_summary[,1],final_summary[,2],final_summary[,3]),]
rownames(final_summary) <- 1:nrow(final_summary) # Correct row numbers after ordering the data as desired.

# Remove all data sets in memory except the final ones (final_data & final_summary)
rm(list=setdiff(ls(), c("final_data","final_summary")))

# Save the final data sets on the local drive as csv files
write.csv(final_data, "/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/final_data.csv")
write.csv(final_summary, "/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/final_summary.csv")

# Save final_summary as txt file for the automated grader
write.table(final_summary, "/Users/aalmuhaisen/Documents/R/datasci/UCI HAR Dataset/final_summary.txt", row.names = F)

# Done