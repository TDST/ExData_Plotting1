###-----------------------------------------------------------------------------------
# Introduction
#
# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, we will be using the “Individual household electric power consumption Data Set” which I have made available on the course web site:
#         
#         Dataset: Electric power consumption [20Mb]
# 
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
# 
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#         
#         Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
# 
# Loading the data
# 
# When loading the dataset into R, please consider the following:
#         
#         The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates. 
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
# 
# Note that in this dataset missing values are coded as ?.
###-----------------------------------------------------------------------------------

# Set up the environment and read in the data
setwd( "~/Desktop/Courses/Exploratory Data Analysis/ExData_Plotting1" )
df <- read.table( "household_power_consumption.txt", sep=";", header=TRUE, na.strings=c( "NA", "#DIV/0!", "", "?" ), stringsAsFactors=FALSE )

# Subset the data to the date range specififed and format the date/time properly
df <- df[ df$Date %in% c("1/2/2007","2/2/2007"), ]
date_time <- strptime( paste( df$Date, df$Time, sep=" " ), "%d/%m/%Y %H:%M:%S" )

# Open the output file, set the plot size, adding sub-metering lines and a legend, and write the plot to the file
png( "plot4.png", width=480, height=480 )
par( mfrow = c( 2, 2 ) )
plot( date_time, as.numeric( df$Global_active_power ), type="l", xlab="", ylab="Global Active Power", cex=0.2 )
plot( date_time, as.numeric( df$Voltage), type="l", xlab="datetime", ylab="Voltage" )
plot( date_time, as.numeric( df$Sub_metering_1 ), type="l", ylab="Energy Submetering", xlab="" )
lines( date_time, as.numeric( df$Sub_metering_2 ), type="l", col="red" )
lines( date_time, as.numeric( df$Sub_metering_3 ), type="l", col="blue" )
legend( "topright", c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), lty=, lwd=2.5, col=c( "black", "red", "blue" ), bty="o" )
plot( date_time, as.numeric( df$Global_reactive_power ), type="l", xlab="datetime", ylab="Global_reactive_power" )

# Close the output file
dev.off( )
