## Background

## Personal activity data was collected Using devices such as Jawbone Up, Nike FuelBand, and Fitbit from a group of
## enthusiasts who took measurements about themselves regularly and recorded them. In this project, the goal is 
## to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. 
## They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. 

## Citation: Velloso, E.; Bulling, A.; Gellersen, H.; Ugulino, W.; Fuks, H. 
## Qualitative Activity Recognition of Weight Lifting Exercises. Proceedings of 4th International Conference 
## in Cooperation with SIGCHI (Augmented Human '13) . Stuttgart, Germany: ACM SIGCHI, 2013.

# Analyses
  
data = read.csv("~/mlproject/pml-training.csv", header=TRUE)
dim(data)

t = na.omit(data)
dim(t)

## There are 160 variables, many of which have NAs leading to failure of the the model if processed as is. 
## For this analyses the variables with > 50% missing values have been removed. 
## The following lines of code identifies variables that have > 50% missing values

dummy = rep(NA, 160)
n = ncol(data)

for (i in 1:n) {
t = na.omit(data[i])
r = round((nrow(t)/nrow(data))*100,2)
if (r<50) {dummy[i]=r}
else {dummy[i]="YES"}
}

vars = which(dummy=="YES")
vars

names(data[vars])
data <- data[, vars]

data <- data[, -c(1,2)]
dim(data)

t = na.omit(data)
dim(t)

## The processing of the raw dataset removed variables with > 50% missing values. 
## Those removed were largely derived variables like mean, min, max etc. 
## A randomForest model was applied on the dataset with 91 remaining variables
## The data was broken down to 10 folds: the first 4 folds were combined to form the training set.
## the remaining 6 folds were the test and the cross-validation sets to determine the out-of-sample errors

library(ggplot2)
library(lattice)
library(caret)
library(randomForest)

fld = createFolds(data$classe, k=10, list=TRUE, returnTrain=FALSE)

training = rbind(data[fld[[1]],], data[fld[[2]],], data[fld[[3]],], data[fld[[4]],])
dim(training)

test1 = data[fld[[5]],]
dim(test1)

test2 = data[fld[[6]],]
test3 = data[fld[[7]],]
test4 = data[fld[[8]],]
test5 = data[fld[[9]],]
test6= data[fld[[10]],]

#model1 = train(training$classe~., method="rf", data=training)
#model1
#pred <- predict(model1, testing)
#table(pred, testing$classe)



