#Exercises
#For the exercise below you should import the Iris Dataset as a dataframe called iris.df.
#(1). Create a variable called sepalWidth.mean that contains the mean of the sepalWidth column of iris.df.
iris.df<-read.csv(file="../../data/iris.csv", header=TRUE,sep=",")
sepalWidth.mean<-mean(iris.df$sepalWidth)
sepalWidth.mean
#(2). Create a new column of iris.df called sepalArea that is equal to the sepalWidth times sepalLength.
iris.df$sepalArea<-iris.df$sepalLength*iris.df$sepalWidth
mean(iris.df$sepalArea)
#(3). Create a new dataframe iristrain.df that includes the first 75 rows of the iris dataframe.
iristrain.df<-iris.df[1:75,]
nrow(iristrain.df)
mean(iristrain.df$sepalLength)
mean(iris.df$sepalArea)
#(4). Create a new dataframe iristest.df that includes the last 75 rows of the iris dataframe.
iristest.df<-iris.df[76:150,]
nrow(iristest.df)
mean(iristest.df$sepalLength)
#(5). Create a new vector sepalLength from the sepalLength column of the iris dataframe.
sepalLength<-iris.df$sepalLength
mean(sepalLength)

train<-read.csv(file="../../privatedata/titanictrain.csv", header=TRUE,sep=",")
test<-read.csv(file="../../privatedata/titanictest.csv", header=TRUE,sep=",")

#(6). While we can submit our answer to Kaggle to see how it will perform, we can also utilize our test data to assess accuracy. Accuracy is the percentage of predictions made correctly-i.e., the percentage of people in which our prediction regarding their survival. a. Create columns in the training dataset PredEveryoneDies and PredGender with the same predictions from above. b. Create variables AccEveryoneDies and AccGender using a calculation of accuracy of predictions for the training dataset.
train["PredEveryoneDies"]<-0
train[train$Sex == "male", "PredGender"] <- 0
train[train$Sex == "female", "PredGender"] <- 1
mean(train$PredGender)
correct.EveryoneDies<-nrow(subset(train, PredEveryoneDies ==Survived, select=Survived))
correct.PredGender<-nrow(subset(train, PredGender ==Survived, select=Survived))
train.total<-nrow(train)
AccEveryoneDies<-100*correct.EveryoneDies/train.total
AccGender<-100*correct.PredGender/train.total
AccEveryoneDies
AccGender
#(7). Notice how we are utilizing the code to select out the passengerID and the Survived column and generating a submission file over and over? This is in need of a function. Create a generate_submission function that accepts a DataFrame, a target column, and a filename and writes out the submission file with just the passengerID and the Survived columns, where the survived column is equal to the target column. It should then return a DataFrame with the passengerID and the Survived columns.
#Executeing the following: submitdie <- generate_submission(train, "PredEveryoneDies", "submiteveryonedies.csv")
#Should return a dataframe with just passengerID and the Survived column.
generate_submission<-function(df,targetcolumn,datafile){
    sumbission<-df[,c("PassengerID", targetcolumn)]
    names(submission)[2] <- "Survived"
    write.csv(submission, file = datafile, row.names = F)
}


#(8). In according to the women and children first protocol we hypothesize that our model could be improved by including whether the individual was a child in addition to gender. After coding survival based on gender, update your recommendation to prediction in the training dataset survival based on age. train['PredGenderAge13'] should be the prediction incorporating both Gender and whether Age < 13. train['PredGenderAge18'] should be the prediction incorporating both Gender and whether Age < 18. AccGenderAge13 should be the accuracy of the age prediction, based on train['PredGenderAge13'].  AccGenderAge18 should be the accuracy of the age prediction, based on train['PredGenderAge18'].

train[is.na(train$Age), "Age"]<- mean(train$Age, na.rm = TRUE)
test[is.na(test$Age), "Age"] <- mean(test$Age, na.rm = TRUE)
train$PredGenderAge13<-train$PredGender
train[train['Age'] < 13, "PredGenderAge13"] <- 1
train$PredGenderAge18<-train$PredGender
train[train['Age'] < 18, "PredGenderAge18"] <- 1
correct.PredGenderAge13<-nrow(subset(train, PredGenderAge13 ==Survived, select=Survived))
correct.PredGenderAge18<-nrow(subset(train, PredGenderAge18 ==Survived, select=Survived))
AccGenderAge13<-100*correct.PredGenderAge13/train.total
AccGenderAge18<-100*correct.PredGenderAge18/train.total
#(9). You should find that the AccGenderAge13 is better than AccGenderAge18. Create a new column child in the test and train DataFrames that is 1 if Age < 13 and 0 otherwise. This is a feature.

train$child<-0
train[train$Age < 13, "child"] <- 1
test$child<-0
test[test$Age < 13, "child"] <- 1
sum(train$child)
sum(test$child)