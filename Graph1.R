
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

# Defining Date and Time class to coerce data in loading time
setClass('myDate');
setClass('myTime');
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
setAs("character","myTime", function(from) strptime(from, format = "%H:%M:%S"))

# Loading data from 1/2/2007 and 2/2/2007
# The first record = 1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000
# The last record = 2/2/2007;23:59:00;3.680;0.224;240.370;15.200;0.000;2.000;18.000
data <- read.csv(datafile, header = T, sep = ";", skip = 66636, nrows = 2880, na.strings = "?",
                 col.names = c("Date","Time", "Global_active_power", "Global_reactive_power",
                               "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                               "Sub_metering_3"), colClasses=c("myDate", "myTime", rep("numeric",7)))

# Generating the plot and save in a PNG file
png(file="plot1.png",width = 480, height = 480, unit = "px")
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main="Global Active Power")
dev.off()