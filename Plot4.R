## This code will generate four plots of Global Active Power from the following raw data of Individual household electric power consumption (held on  http://archive.ics.uci.edu/ml/.)

## The raw data here was downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip on 02/12/2014


# Location of raw data
  file <- "./exdata-data-household_power_consumption/household_power_consumption.txt"

# The file is very large and we are only interested in a subset.
# We will extract only the specific rows for the date range 2007-02-01 and 2007-02-02

# First, extract column names to pass to read.table
  col.names <- colnames(read.table(file, sep = ";", nrow = 1, header = TRUE))

# Check row numbers for the date range in the txt file (using Notepad++) - the data are between rows 66637 and 69517.  This information gives the row to skip to and the number of rows to read in.

# 69517-66637 # 2880

# Read in specific rows (skip to first row of req date)
  hpc <- read.table(file, sep = ";", stringsAsFactor=FALSE, skip = 66637, na.strings = "?", col.names = col.names, nrows = 2880)

# Check classes of data
  summary(hpc)


# Create a date/time variable to enable analysis over time
  hpc$DateTime <- paste(hpc$Date, hpc$Time, sep = ' ')

# use lubridate to change DateTime to date format
  library(lubridate)
  hpc$DateTime <- dmy_hms(hpc$DateTime)


# Open PNG device; create a png file in the working directory
  png(file = "Plot4.png")  

# Plot four plots of Global_active_power over the time period in a 2x2 frame
  
  par(mfrow = c(2,2))

# Specify the dataset  
  with(hpc, {

# Plot (i) Global Active Power in kilowatts
  plot(DateTime, Global_active_power, xlab= "", ylab= "Global Active Power", type = "l")

# Plot (ii) Voltage  
  plot(DateTime, Voltage, xlab= "datetime", ylab= "Voltage", type = "l")

# Plot (iii)  Energy Sub Metering
  plot(DateTime, Sub_metering_1, xlab= "", ylab= "Energy sub metering", type = "n")
  
  lines(hpc$DateTime, hpc$Sub_metering_1)
  lines(hpc$DateTime, hpc$Sub_metering_2, col = "red1")
  lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue1")
  
  legend("topright", lty = 1, bty = "n", col = c("black", "red1", "blue1"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot (iv) Global Reactive Power
  plot(DateTime, Global_reactive_power, xlab= "datetime", ylab= "Global_reactive_power", type = "l")
  
  }) # close the plot
  
# Remember to turn off the device
  dev.off()


