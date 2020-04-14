#Readind data to R
wine <- read.csv("wine.csv")

#It show the first few rows 
head(wine)

#To see a bar graph for a particular column
barplot(table(wine$quality))

#Creating a new column 
wine$taste <- ifelse(wine$quality <6,"bad","good")
wine$taste[wine$quality==6]<-"normal"

#Converting into factor
wine$taste <- as.factor(wine$taste)

#TO see new created column in tabular format
table(wine$taste)

#Data Partitioning into 60-40 
set.seed(123)
samp <- sample(nrow(wine),0.6*nrow(wine))
train <- wine[samp,]
test <- wine[-samp,]

#Import library 
library(randomForest)

#Creating a model and prediction
my_model <- randomForest(taste ~ . -quality,data=train)
pred <- predict(my_model, newdata = test)
table(pred,test$taste)

#To calculate accuracy 
(237+42+180)/nrow(test)

#Note: accuracy can be further improved by features selection.
