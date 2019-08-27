
				###////////// PLOT 3 \\\\\\\\\\\\###

# Dataset: Electric power consumption [20Mb] 
#URL:https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Description: Measurements of electric power consumption in one 
#household with a one-minute sampling rate over a period of almost 4 years.
#Different electrical quantities and some sub-metering values are available.


# Get the Data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, file.path(getwd(), "exdata_data_household_power_consumption.zip"))

unzip(zipfile = "exdata_data_household_power_consumption.zip")


# Load the documents of activity labels and features

power_Consum <- data.table::fread(file.path(getwd(), "household_power_consumption.txt"), header = TRUE, na.strings = "?")

# Take the column to plot and convert it to numeric

power_Consum <- power_Consum[, Sub_metering_1 := lapply(.SD, as.numeric), .SDcols = c("Sub_metering_1")]
power_Consum <- power_Consum[, Sub_metering_2 := lapply(.SD, as.numeric), .SDcols = c("Sub_metering_2")]
power_Consum <- power_Consum[, Sub_metering_3 := lapply(.SD, as.numeric), .SDcols = c("Sub_metering_3")]

power_Consum <- power_Consum[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

power_Consum <- power_Consum[(dateTime >= "2007/02/01") & (dateTime < "2007/02/03")]

#Plotting and saving PNG

png("plot3.png", width=480, height=480)

plot(power_Consum[, dateTime], power_Consum[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power_Consum[, dateTime], power_Consum[, Sub_metering_2],col="red")
lines(power_Consum[, dateTime], power_Consum[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.off()
