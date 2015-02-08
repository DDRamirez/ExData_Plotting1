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

xrange <- c(0,2880)
yrange <- c(0,38)

#Create the histogram
png("plot3.png",width=480, height=480) #Save png
# First plot in black.  I keep the 
with(MeterData2,plot(Sub_metering_1, ylab="Energy sub metering",type='l',xlim=xrange,yaxt='n',xaxt='n',ylim=yrange))
par(new=T)
with(MeterData2,plot(Sub_metering_2, ylab="Energy sub metering",type='l',xlim=xrange,yaxt='n',xaxt='n',ylim=yrange,col="blue"))
par(new=T)
with(MeterData2,plot(Sub_metering_3, ylab="Energy sub metering",type='l',xlim=xrange,yaxt='n',xaxt='n',ylim=yrange,col="red"))
axis(1,at=c(0,1440,2880),labels=c("Thu","Fri","Sat"))
axis(2,at=c(0,10,20,30))
par(new=F)
legend("topright",col=c("black","red","blue"),lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off() #Finish saving png

?plot
?lines
