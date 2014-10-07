library(sqldf)
fn <- "household_power_consumption.txt"
d <- read.csv.sql(fn, sql = 'select * from file where Date IN ("1/2/2007","2/2/2007")', 
    header=T, sep=';')

hist(d$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", col="Red")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()