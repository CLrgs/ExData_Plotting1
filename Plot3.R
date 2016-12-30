##"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file (url, "Household_Power_Consumption")
## unzip file , extract to new directory "Household_Power_Consumption"
unzip("Household_Power_Consumption")
##set working directory
setwd("/Users/constantinoslirigos/Dropbox/COURSERA/R Working Directory")

read.table("household_power_consumption.txt", sep = ";", skip = 56000, nrow = 160000, colClasses = c(rep("character", 9))) -> HPC
library(dplyr)
mutate(HPC, datetime = paste(V1, V2)) -> HPC
HPC$V1 <- as.Date(HPC$V1, "%d/%m/%Y")
HPC$V1 <- as.POSIXct(HPC$V1)
HPC$V2 <- strptime(HPC$datetime, "%d/%m/%Y %H:%M:%S")
HPC$V2 <- as.POSIXct(HPC$V2)
HPC <- subset(HPC, V2 >= "2007-02-01" & V2 < "2007-02-03")
for(i in 3:9) {HPC[,i] <- as.numeric(HPC[,i]) }
HPC$datetime <- NULL
colnames(HPC)[2] <- "Time"
colnames(HPC)[3] <- "Global_Active_Power"
colnames(HPC)[4] <- "Global_Reactive_Power"
colnames(HPC)[5] <- "Voltage"
colnames(HPC)[7] <- "Sub_Metering_1"
colnames(HPC)[8] <- "Sub_Metering_2"
colnames(HPC)[9] <- "Sub_Metering_3"



dev.off()
png("plot3.png")
par(mfcol = c(1,1))
plot(HPC$Time, HPC$Sub_Metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(HPC$Time, HPC$Sub_Metering_2, type = "l", col = "red", xlab = "")
lines(HPC$Time, HPC$Sub_Metering_3, type = "l", col = "blue", xlab = "")
legend("topright", legend = c("Sub_Metering_1           ", "Sub_Metering_2", "Sub_Metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 0.8, bty = "o")
dev.off()

