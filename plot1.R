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

png(filename = "plot1.png", width = 480, height = 480)

hist(power_data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

dev.off()
unlink(temp)