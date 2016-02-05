# script to create plot 4
# load data from supplied text file. Only load data from dates used in the plots to speed up reading and using the data.
data <- read.table("./data/household_power_consumption.txt",
                   sep = ";",
                   na.strings = "?",
                   skip = 66637, 
                   nrows = 2880,
                   stringsAsFactors = FALSE)

# retrieve header information from file and set in created dataset
header <- read.table("./data/household_power_consumption.txt",
                     sep = ";",
                     nrow = 1,
                     stringsAsFactors = FALSE)

colnames(data) <- header

# create a datetime column combining the Date and Time columns into a single POSIXct date
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# create graphic device
png(file="plot4.png",width=480,height=480)

# set parameters to create 4 plots in 2 by 2
par(mfrow=c(2,2))

# add part 1
# create line chart with datetime on the x-axis and global active power on the y-axis
plot(data$DateTime,
     data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# add part 2
# create line chart with datetime on the x-axis and voltage on the y-axis
plot(data$DateTime,
     data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#add part 3
# get ranges of combined Sub_metering and date columns to setup base chart
meteringRange <- range(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))
dateRange <- range(data$DateTime)

# draw base chart
plot(dateRange, meteringRange, type = "n", xlab = "", ylab = "Energy sub metering")

# draw lines
lines(data$DateTime, data$Sub_metering_1, type = "l")
lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")

# add legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd=c(2.5,2.5,2.5),
       col = c("black", "red", "blue"),
       bty = "n")

# add part 4
# create line chart with datetime on the x-axis and global active power on the y-axis
plot(data$DateTime,
     data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

# close graphic device
dev.off()