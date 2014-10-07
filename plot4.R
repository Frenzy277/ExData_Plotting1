# Load requirement package sqldf to subset dates from gross txt file
library(sqldf)

# Read by using SQL select
d <- read.csv.sql("household_power_consumption.txt", 
                  sql = 'select * from file where Date IN ("1/2/2007","2/2/2007")', 
                  header=T, 
                  sep=';')

# Conversion Date and Time to datetime type
d$Datetime <- as.POSIXct(paste(as.Date(d$Date,"%d/%m/%Y"), d$Time))

# Plot grid
par(mfrow=c(2,2))

# TopLeft plot
plot(d$Global_active_power ~ d$Datetime,
     type = 'l',
     xlab= '',
     ylab='Global Active Power'
)

# TopRight plot
plot(d$Voltage ~ d$Datetime, 
     type='l',
     xlab='datetime', 
     ylab='Voltage'
)

# BottomLeft plot
with(d, {  plot(Sub_metering_1 ~ Datetime, 
                type='l',
                xlab= '',
                ylab= 'Energy sub metering'
           )
           lines(Sub_metering_2 ~ Datetime, col='Red')
           lines(Sub_metering_3 ~ Datetime, col='Blue')
})
legend('topright', 
       lty = 'solid',
       bty= 'n',
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue')
)

# BottomRight plot
plot(d$Global_reactive_power ~ d$Datetime, 
     type='l',
     xlab='datetime', 
     ylab='Global_reactive_power'
)

# Write plot4 to png with height 480 and width 480
dev.copy(png, file='plot4.png', height=480, width=480)
dev.off()