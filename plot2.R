# script to create plot 2
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
png(file="plot2.png",width=480,height=480)

# create line chart with datetime on the x-axis and global active power on the y-axis
plot(data$DateTime,
     data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# close graphic device
dev.off()