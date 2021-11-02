# data preparation
outdata <- paste(c(getwd(),"/Data_m4_w4"),collapse="")
dir.create(outdata)
unzip("exdata_data_NEI_data.zip",exdir=outdata)
innerfolder = "/"
# data to data.frame
NEI <- readRDS(paste(c(outdata,innerfolder,"summarySCC_PM25.rds"),collapse = ""))
SCC <- readRDS(paste(c(outdata,innerfolder,"Source_Classification_Code.rds"),collapse = ""))


## Motor related vehicles
motor_related <- subset(SCC,SCC.Level.One == "Internal Combustion Engines")
motor_vehicle <- motor_related$SCC
motor_vehicle <- as.data.frame(motor_vehicle)
baltimore_motor_v_data <- subset(NEI,fips=="24510")
baltimore_motor_v_data <- subset(baltimore_motor_v_data,SCC %in% motor_vehicle$motor_vehicle)
years <- tapply(baltimore_motor_v_data$Emissions,baltimore_motor_v_data$year,sum)
years <- as.data.frame.table(years)
colnames(years)<- c("year","Emissions")
#plot(years)

png("plot5.png",width = 480,height = 480)
barplot(Emissions ~ year,data=years)
dev.off()


question = "
How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
"
answer = "
Yes, the peak is in 2005 reaching its minimun in 2008
"