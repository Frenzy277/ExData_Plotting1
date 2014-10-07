# Load requirement package sqldf to subset dates from gross txt file
library(sqldf)

# Read by using SQL select
d <- read.csv.sql("household_power_consumption.txt", 
                  sql = 'select * from file where Date IN ("1/2/2007","2/2/2007")', 
                  header=T, 
                  sep=';')

# Conversion Date and Time to datetime type
d$Datetime <- as.POSIXct(paste(as.Date(d$Date,"%d/%m/%Y"), d$Time))

# Create plot3
with(d, { plot(Sub_metering_1 ~ Datetime, 
                type = 'l',
                xlab = '',
                ylab = 'Energy sub metering'
          )
          lines(Sub_metering_2 ~ Datetime, col='Red')
          lines(Sub_metering_3 ~ Datetime, col='Blue')
})
legend('topright', 
       lty = 'solid',
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue')
)

# Write plot3 to png with height 480 and width 480
dev.copy(png, file='plot3.png', height=480, width=480)
dev.off()