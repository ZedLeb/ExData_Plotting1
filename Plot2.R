## This code will generate a histogram of frequency of Global Active Power from the following raw data of Individual household electric power consumption (held on  http://archive.ics.uci.edu/ml/.)

## The raw data here was downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip on 02/12/2014


# Location of raw data
file <- "./exdata-data-household_power_consumption/household_power_consumption.txt"

# The file is very large and we are only interested in a subset.
# We will extract only the specific rows for the date range 2007-02-01 and 2007-02-02

# First, extract column names to pass to read.table
col.names <- colnames(read.table(file, sep = ";", nrow = 1, header = TRUE))

# Check row numbers for the date range in the txt file (using Notepad++) - the data are between rows 66637 and 69517.  This information gives the row to skip to and the number of rows to read in.

69517-66637 # 2880

# Read in specific rows (skip to first row of req date)
hpc <- read.table(file, sep = ";", stringsAsFactor=FALSE, skip = 66637, na.strings = "?", col.names = col.names, nrows = 2880)

# Check classes of data
summary(hpc)

# Change .Date and .Time to date format - use lubridate
library(lubridate)

paste(hpc$Date, hpc$Time, sep = ' ')
hpc$DateTime <- dmy_hms(hpc$DateTime)


# Open PNG device; create a png file in the working directory
png(file = "Plot2.png")  

# Plot histogram of frequency of Global_active_power
plot(hpc$DateTime, hpc$Global_active_power, xlab= "", ylab= "Global Active Power (kilowatts)", pch = "")

lines(hpc$DateTime, hpc$Global_active_power,)


# Remember to turn off the device
dev.off()


