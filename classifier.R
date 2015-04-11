#Loading Data
data_training <- read.csv("C:/Users/arpita/Desktop/coursera/Practical_Machine_Learning/pml-training.csv",na.strings=c(""," ","NA","#DIV/0!"))
data_testing <- read.csv("C:/Users/arpita/Desktop/coursera/Practical_Machine_Learning/pml-testing.csv",na.strings=c(""," ","NA","#DIV/0!"))

#Preprocessing
data_training<-data_training[,7:160]  #Removing useless columns
data_testing<-data_testing[,7:160]
data_training2<-data_training[ , apply(data_training, 2, function(x) !any(is.na(x)))]   #Removing columns with NA's
data_testing2<-data_testing[ , apply(data_testing, 2, function(x) !any(is.na(x)))]

#Classifier
library(randomForest)

#1. Random Forests
nfit <- randomForest(as.factor(classe) ~ . , data=data_training2, importance=TRUE,na.action=na.omit, ntree=500,mtry=floor(sqrt(ncol(data_training2))))
answers <- predict(nfit,data_testing,type='class')

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}
pml_write_files(answers)
