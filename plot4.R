temp = tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power_data = read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";", na.strings = "?", as.is = F)
date_time = paste(power_data$Date, power_data$Time)

date_time = strptime(date_time, format = "%d/%m/%Y %H:%M:%S")
power_data = power_data[,3:9]
power_data = cbind(date_time,power_data)
power_data$date_time = as.POSIXlt(power_data$date_time)

date1 = strptime("01/02/2007", format = "%d/%m/%Y")
date2 = strptime("03/02/2007", format = "%d/%m/%Y")

power_data = power_data[((power_data$date_time >= date1) & (power_data$date_time < date2)),]

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

plot(type = "l", x = power_data$date_time, y = power_data$Global_active_power, main = "", xlab = "", ylab = "Global Active Power")

plot(type = "l", x = power_data$date_time, y = power_data$Voltage, main = "", xlab = "datetime", ylab = "Voltage")

plot(type = "l", x = power_data$date_time, y = power_data$Sub_metering_1, main = "", xlab = "", ylab = "Energy sub metering")
lines(x = power_data$date_time, y = power_data$Sub_metering_2, col = "red")
lines(x = power_data$date_time, y = power_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), lwd=c(1.8,1.8,1.8), col=c("black","red","blue"))

plot(type = "l", x = power_data$date_time, y = power_data$Global_reactive_power, main = "", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
unlink(temp)