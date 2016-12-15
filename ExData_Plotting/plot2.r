setwd("c:/MyWorkspace/MyLearning/Data Science/Data Science Coursera/ExData_Plotting1")

# load the data and find out required data
original <- read.table ("household_power_consumption.txt",header =TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

required <- original[original$Date %in% c("1/2/2007","2/2/2007") ,]

# makeup the plot
datetime <- strptime(paste(required$Date, required$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subSetData$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
