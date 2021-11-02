# data preparation
outdata <- paste(c(getwd(),"/Data_m4_w4"),collapse="")
dir.create(outdata)
unzip("exdata_data_NEI_data.zip",exdir=outdata)
innerfolder = "/"
# data to data.frame
NEI <- readRDS(paste(c(outdata,innerfolder,"summarySCC_PM25.rds"),collapse = ""))
SCC <- readRDS(paste(c(outdata,innerfolder,"Source_Classification_Code.rds"),collapse = ""))

## all sources included
## Total emmissions = SUM
years <- tapply(NEI$Emissions,NEI$year,sum)
years <- as.data.frame.table(years)
colnames(years)<- c("year","Emissions")

png("plot1.png",width = 480,height = 480)
barplot(Emissions ~ year,data=years)
dev.off()

# Reset if necessary
# par(mfrow=c(1,1))

question = "
Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
Using the base plotting system, make a plot showing the total PM2.5 emission from 
all sources for each of the years 1999, 2002, 2005, and 2008.
"
answer = " YES " 