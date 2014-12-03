
# location of raw data
file <- "./exdata-data-household_power_consumption/household_power_consumption.txt"

# extract column names
col.names <- colnames(read.table(file, sep = ";", nrow = 1, header = TRUE))

# checking row numbers in the txt file to calculate nrows
69518-66637 # 2881

# read in specific rows (skip to first row of req date)
data <- read.table(file, sep = ";", stringsAsFactor=FALSE, skip = 66637, na.strings = "?", col.names = col.names, nrows = 2881)

# check classes of data
summary(data)

# change .Date and .Time to date format - use lubridate
library(lubridate)

data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
