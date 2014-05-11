hpc <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, sep = ";", colClasses="character", na.string="?", col.names = colnames(read.table("household_power_consumption.txt", nrow = 1, header = TRUE, sep=";")))
hpc$newGAP <-as.numeric(hpc$Global_active_power)
dfrm <-subset(hpc, select=c(Date, Time, newGAP), no.rm=T)
dfrm$date1 <-strptime(paste(dfrm$Date, dfrm$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
dfrm$newdt <-weekdays(dfrm$date1, abbreviate=T)
png(filename="plot2.png", width=480, height=480)
with(dfrm, plot(date1, dfrm$newGAP, ylab="Global Active Power (kilowatts)", xlab=" ", type="l"))
dev.off()

