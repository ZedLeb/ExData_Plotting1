
# location of raw data
file <- "./exdata-data-household_power_consumption/household_power_consumption.txt"

# extract column names
col.names <- colnames(read.table(file, sep = ";", nrow = 1, header = TRUE))

# check row numbers in the txt file (using Notepad++) 
# then calculate nrows
69518-66637 # 2881

# read in specific rows (skip to first row of req date)
hpc <- read.table(file, sep = ";", stringsAsFactor=FALSE, skip = 66637, na.strings = "?", col.names = col.names, nrows = 2881)

# check classes of data
summary(hpc)

# change .Date and .Time to date format - use lubridate
library(lubridate)

hpc$Date <- dmy(hpc$Date)
hpc$Time <- hms(hpc$Time)

png(file = "GlobalActivePower.png")  ## Open PNG device; create a png file in the working directory

#Plot histogram of frequency of Global_active_power
with(hpc, hist(Global_active_power, col = "red1", xlab = "Global Active Power(kilowatts)", main = "Global Active Power"))

dev.off()


