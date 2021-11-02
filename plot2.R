# data preparation
outdata <- paste(c(getwd(),"/Data_m4_w4"),collapse="")
dir.create(outdata)
unzip("exdata_data_NEI_data.zip",exdir=outdata)
innerfolder = "/"
# data to data.frame
NEI <- readRDS(paste(c(outdata,innerfolder,"summarySCC_PM25.rds"),collapse = ""))
SCC <- readRDS(paste(c(outdata,innerfolder,"Source_Classification_Code.rds"),collapse = ""))
#fips == "24510"

## all sources included
## Total emmissions = SUM
baltimore <- subset(NEI,fips=="24510")
years <- tapply(baltimore$Emissions,baltimore$year,sum)
years <- as.data.frame.table(years)
colnames(years)<- c("year","Emissions")
png("plot2.png",width = 480,height = 480)
barplot(Emissions ~ year,data=years)
dev.off()


# Reset if necessary
# par(mfrow=c(1,1))

question = "
Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
fips == '24510' from 1999 to 2008? Use the base plotting system to make a 
plot answering this question.
"
answer = " YES, regarding a sustancial increase in 2005, 2008 was the historical minimum" 