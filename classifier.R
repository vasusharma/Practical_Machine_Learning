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
library(e1071)
#1. Random Forests
nfit <- randomForest(as.factor(classe) ~ . , data=data_training2, importance=TRUE,na.action=na.omit, ntree=500,mtry=floor(sqrt(ncol(data_training2))))
answers <- predict(nfit,data_testing,type='class')

#nfit <- randomForest(classe ~ roll_belt + pitch_belt + yaw_belt + total_accel_belt + roll_dumbbell + pitch_dumbbell + yaw_dumbbell + gyros_arm_x + gyros_arm_y + gyros_arm_z + accel_arm_x + accel_arm_y + accel_arm_z + magnet_arm_x + magnet_arm_y + magnet_arm_z + gyros_belt_x + gyros_belt_y + gyros_belt_z+accel_belt_x+accel_belt_y+accel_belt_z+magnet_belt_x+magnet_belt_y+magnet_belt_z+roll_arm+pitch_arm+yaw_arm+total_accel_arm , data=data_training,na.action=na.omit, ntree=100,mtry=floor(sqrt(ncol(data_training))))


#2. SVM
#m1 <- tune.svm(classe~., data = data_training2, gamma = 2^(-6:-4), cost = 2^(0:1),cross=5)
#m1

