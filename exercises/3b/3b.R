library(e1071)
library(R.matlab)

acs.mat <- readMat('Lecture 3 Classifiers/M3b/M3b/ACS.mat')
x.truncated <- acs.mat$X.truncated
x.scaled <- data.frame(scale(x.truncated))
y <- as.factor(acs.mat$y)
data.df <- cbind(x.scaled, y)

#svm.model <- svm(y~., data=data.df, cost=1, cross=10)

tuned.svm <- tune.svm(y~., data=data.df, cost=c(0.1, 1, 10, 100, 1000),
                      gamma=c(0.5, 1, 2, 3, 4),
                      tunecontrol=tune.control(random=FALSE, sampling='cross', cross=10))
tuned.svm$performances
