remoteLogin(
  "http://test1234mlsvr.koreacentral.cloudapp.azure.com:12800",
  session = TRUE,
  diff = TRUE,
  commandline = TRUE,
  username = "admin",
  password = "Pa$$w0rd2019"
)

conString <- 
  "Driver=SQL Server;Server=testdb12344321.database.windows.net;Database=AirlineData;Uid=admin2019;Pwd=Pa$$w0rd2019"
airportData <- RxSqlServerData(connectionString = conString, table = "Airports")
colClasses <- c(
  "iata" = "character",
  "airport" = "character",
  "city" = "character",
  "state" = "factor",
  "country" = "factor",
  "lat" = "numeric",
  "long" = "numeric")
csvData <- RxTextData(file = "C:\\TestData\\airports.csv", colClasses = colClasses)
rxDataStep(inData = csvData, outFile = airportData, overwrite = TRUE)


sqlConnString <- "Driver=SQL Server;Server=testdb12344321.database.windows.net;Database=AirlineData;Uid=admin2019;Pwd=Pa$$w0rd2019"
connection <- RxSqlServerData(connectionString = sqlConnString,
                              table = "dbo.Airports", rowsPerRead = 1000)

# Use R functions to examine the data in the Airports table
#connection
head(connection) #head
rxGetVarInfo(connection) #str
rxSummary(~., connection)


# Flight delay data for the year 2000
setwd("C:\\강사공유\\20190627")

csvDataFile = "2000.csv" 

# Examine the raw data
rawData <- rxImport(csvDataFile, numRows = 1000)
rxGetVarInfo(rawData)

# Create an XDF file that combines the ArrDelay and DepDelay variables, 
# and that selects a random 10% sample from the data

outFileName <- "C:\\RWorkspace\\2000.xdf"
filteredData <- rxImport(csvDataFile, outFile = outFileName, 
                         overwrite = TRUE, append = "none",
                         transforms = list(Delay = ArrDelay + DepDelay),
                         rowSelection = ifelse(rbinom(.rxNumRows, size=1, prob=0.1), TRUE, FALSE))

# Examine the stucture of the XDF data - it should contain a Delay variable
# Note that Origin is a characater
rxGetVarInfo(filteredData)

# Generate a quick summary of the numeric data in the XDF file
rxSummary(~., filteredData)

# Summarize the delay fields
rxSummary(~Delay+ArrDelay+DepDelay, filteredData)

refactoredData = "C:\\RWorkspace\\2000Refactored.xdf"
refactoredXdf = RxXdfData(refactoredData)

#test_data = RxXdfData("C:\\RWorkspace\\2000.xdf")
#rxGetVarInfo(test_data)

#rxFactors(inData = filteredData, outFile = refactoredXdf, 
rxFactors(inData = "C:\\RWorkspace\\2000.xdf", outFile = refactoredXdf, 
          overwrite = TRUE, factorInfo = c("Origin", "Dest"))

test_data2 = RxXdfData("C:\\RWorkspace\\2000Refactored.xdf")
rxGetVarInfo(test_data2)

rxGetVarInfo()

rxSummary(Delay~Origin, refactoredXdf)

# Generate a crosstab showing the average delay 
# for flights departing from each origin to each destination
rxCrossTabs(Delay ~ Origin:Dest, refactoredXdf, means = TRUE)

# Generate a cube of the same data
rxCube(Delay ~ Origin:Dest, refactoredXdf)

# Omit the routes that don't exist
rxCube(Delay ~ Origin:Dest, refactoredXdf, removeZeroCounts = TRUE)







