library(randomForest)

training <- read.csv("../Documents/R_Test/training.csv")
colnames(training)[1] = "Year.since.Katrina"

rf <- randomForest(Patent.Grants ~ ., data=training, mtry=4, ntree=500, importance=TRUE )
#predict(rf,data_predict1)
