# Downloading the Dataset file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "Data.zip"
datafile <- "household_power_consumption.txt"

if(!file.exists(zipfile)){
  download.file(url, destfile = zipfile , method = "curl") 
}

# Unziping the file
if(!file.exists(datafile)){
  unzip(zipfile, files = NULL, exdir=".")
}

# Loading data from 1/2/2007 and 2/2/2007
# The first record = 1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000
# The last record = 2/2/2007;23:59:00;3.680;0.224;240.370;15.200;0.000;2.000;18.000
data <- read.csv(datafile, header = T, sep = ";", skip = 66636, nrows = 2880, na.strings = "?",
                 col.names = c("Date","Time", "Global_active_power", "Global_reactive_power",
                               "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                               "Sub_metering_3"), colClasses=c(rep("character",2), rep("numeric",7)))
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Generating the plot and save in a PNG file
png(file="plot3.png",width = 480, height = 480, unit = "px")
with(data, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, col= "red"))
with(data, lines(DateTime, Sub_metering_3, col= "blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black","red","blue"), lty = 1)
dev.off()