# Load requirement package sqldf to subset dates from gross txt file
library(sqldf)

# Read by using SQL select
d <- read.csv.sql("household_power_consumption.txt", 
                  sql = 'select * from file where Date IN ("1/2/2007","2/2/2007")', 
                  header=T, 
                  sep=';')

# Conversion of Date and Time to datetime type
d$Datetime <- as.POSIXct(paste(as.Date(d$Date,"%d/%m/%Y"), d$Time))

# Create plot2
plot(d$Global_active_power ~ d$Datetime,
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)'
)

# Write plot2 to png with height 480 and width 480
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()