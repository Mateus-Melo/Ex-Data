download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","data")

unzip("data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)
str(SCC)

EmissionByYear <- tapply(NEI$Emissions,NEI$year, sum, na.rm=T)
png(file="Plot1.png")
barplot(EmissionByYear, xlab = "Year", ylab = "Pollutant Emission")
title(main="Pollutant Emission by Year in the USA")
dev.off()

BaltimoreNEI <- subset(NEI, fips == "24510")
EmissionByYearBaltimore <- tapply(BaltimoreNEI$Emissions, BaltimoreNEI$year, sum, na.rm=T)
png(file="Plot2.png")
barplot(EmissionByYearBaltimore, xlab = "Year", ylab = "Pollutant Emission")
title(main="Pollutant Emission by Year in Baltimore")
dev.off()

library(ggplot2)

png(file="Plot3.png")
ggplot(BaltimoreNEI, aes(x=as.character(year))) + facet_wrap( ~ type) + geom_col(aes(y=Emissions)) +
        labs(title = "Pollutant Emission by Type and Year in Baltimore", x="Year", y="Pollutant Emission")
dev.off()


df<- merge(NEI, SCC)

CoalCombustionSources <- subset(df, grepl("Coal",df$EI.Sector))
png(file="Plot4.png")
ggplot(CoalCombustionSources, aes(x=as.character(year))) + geom_col(aes(y=Emissions)) +
        labs(title = "Pollutant Emission From Coal Combustion-Related Sources by Year\n in The USA", x="Year", y="Pollutant Emission")
dev.off()

EmissionsMotorVehicleBaltimore <- subset(df, grepl())