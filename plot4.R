hpc <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, sep = ";", colClasses="character", na.string="?", col.names = colnames(read.table("household_power_consumption.txt", nrow = 1, header = TRUE, sep=";")))
dfrm <-subset(hpc, select=c(Date, Time, Global_active_power, Voltage, Global_reactive_power, Sub_metering_1, Sub_metering_2, Sub_metering_3))

dfrm$date1 <-strptime(paste(dfrm$Date, dfrm$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
dfrm$newdt <-weekdays(dfrm$date1, abbreviate=T)

dfrm$newGAP <-as.numeric(dfrm$Global_active_power)
dfrm$newGRP <-as.numeric(dfrm$Global_reactive_power)
dfrm$newvolt <-as.numeric(dfrm$Voltage)
dfrm$Sub1 <-as.numeric(as.character(dfrm$Sub_metering_1))
dfrm$Sub2 <-as.numeric(as.character(dfrm$Sub_metering_2))
dfrm$Sub3 <-as.numeric(as.character(dfrm$Sub_metering_3))

png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(dfrm, {
  with(dfrm, plot(date1, dfrm$newGAP, ylab="Global Active Power (kilowatts)", xlab=" ", type="l"))
  
  with(dfrm, plot(date1, dfrm$newvolt, ylab="Voltage", xlab="datetime", type="l", lty=1, lwd=2.5))
  
  with(dfrm, plot(date1, Sub1, ylab="Energy sub metering", xlab=" ", col="gray 55", type="l"))
  lines(dfrm$date1, dfrm$Sub2, type = "l", col = "red")
  lines(dfrm$date1, dfrm$Sub3, type = "l", col = "blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5), col=c("gray55","blue","red"))
  
  with(dfrm, plot(dfrm$date1, dfrm$newGRP, ylab="Global_reactive_power", xlab="datetime", type="h"))
  
})
dev.off()