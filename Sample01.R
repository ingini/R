ls("package:datasets")
test_data <-
  c(850,740,900,1050,1020,940,930,870,980,900,
    800,740,630,1050,960,960,810,760,980,1000)
test_data
plot(test_data)
plot(1:10)
stem(test_data)
hist(test_data)
qqnorm(test_data)
boxplot(test_data)
summary(test_data)
mean(test_data)
min(test_data)
sd(test_data)
var(test_data)

plot(attitude)

# y = 2x
# x -> y

# y x -> y = ()x + () -> y ~ x
# 2 1
# 3 2
# y = ()x2 + ()x + ()
# y ~ x + y
test <- lm(rating ~ complaints, data=attitude)
test
summary(test)

# Microsoft R DataSet
library(readr)
library(RevoScaleR)
list.files(rxGetOption("sampleDataDir"))
inDataFile <- 
  file.path(rxGetOption("sampleDataDir"),
            "mortDefaultSmall2000.csv")
mortData <- rxImport(inData = inDataFile)
str(mortData)
rxGetVarInfo(mortData)
nrow(mortData)
ncol(mortData)
names(mortData)
head(mortData, 3)
rxGetInfo(mortData, getVarInfo = TRUE, numRows = 5)
rxHistogram(~creditScore, data=mortData)
mortData2 <-
  rxDataStep(inData = mortData,
             varsToDrop = c("year"),
             rowSelection = creditScore < 800)
rxHistogram(~creditScore, data=mortData2)

mortData3 <- rxDataStep(
  inData = mortData, 
  varsToDrop = c("year"),
  rowSelection = creditScore < 800, 
  transforms = list(catDept = cut(ccDebt, 
              breaks = c(0,6500,13000),
              labels = c("Low Debt", "High Debt")),
  lowScore = creditScore < 625))

rxGetVarInfo(mortData3)

mortCube <- rxCube(~F(creditScore):catDept, 
                   data = mortData3)

head(mortCube)
rxLinePlot(Counts ~ creditScore|catDept,
           data=rxResultsDF(mortCube))
