
				###////////// PLOT 1 \\\\\\\\\\\\###

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

power_Consum <- power_Consum[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

power_Consum <- power_Consum[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

power_Consum <- power_Consum[(Date >= "2007/02/01") & (Date <= "2007/02/02")]


#as.Date(x = power_Consum[, Date], format, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"))
#x <- power_Consum[(Date >= "01/02/2007") & (Date <= "02/02/2007")]
#x <- as.numeric (power_Consum [, Global_active_power])
#x <- x[(Date >= "01/02/2007") & (Date <= "02/02/2007")]

png("plot1.png", width=480, height=480)
hist(power_Consum[, Global_active_power], col = "red", main = "Global Active Power" , xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
