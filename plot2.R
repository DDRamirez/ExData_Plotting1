#Read in the file
#Consider using lubridate

filename <- "E:\\Cousera\\Exploratory Data Analysis\\Course Project 1\\household_power_consumption.txt"

#Big file, could take a while.  Need to think about using SQL to subset
#before loading if needed.
MeterData <- read.table(filename,header = TRUE,sep=";",na.strings="?")

#We only need certain dates, so convert the date column and subset.
MeterData$Date.Time <- paste(MeterData$Date,MeterData$Time,sep=" ")

MeterData$Date.Time <- strptime(MeterData$Date.Time,"%d/%m/%Y %T")

#as.Date doesn't work here, you have to use the POSIXlt date type.
MeterData2 <- MeterData[(MeterData$Date.Time >= as.POSIXlt("2007-02-01 00:00:00") & MeterData$Date.Time <= as.POSIXlt("2007-02-02 23:59:59")),]

#Save memory after you're sure the subsetting worked.
rm(MeterData)

#Create the histogram
png("plot1.png",width=480, height=480) #Save png
plot(MeterData2$Global_active_power, ylab="Global Active Power (kilowatts)",type="line")
dev.off() #Finish saving png

?plot
?lines
