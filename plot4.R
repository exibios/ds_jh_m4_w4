# data preparation
outdata <- paste(c(getwd(),"/Data_m4_w4"),collapse="")
dir.create(outdata)
unzip("exdata_data_NEI_data.zip",exdir=outdata)
innerfolder = "/"
# data to data.frame
NEI <- readRDS(paste(c(outdata,innerfolder,"summarySCC_PM25.rds"),collapse = ""))
SCC <- readRDS(paste(c(outdata,innerfolder,"Source_Classification_Code.rds"),collapse = ""))

#find the coal related scc
coal_related <- subset(SCC,grepl("Coal", Short.Name,fixed = TRUE)) 
#names(coal_related) SCC
coal_data <- subset(NEI,SCC %in% coal_related$SCC)
years <- tapply(coal_data$Emissions,coal_data$year,sum)
years <- as.data.frame.table(years)
colnames(years)<- c("year","Emissions")

png("plot4.png",width = 480,height = 480)
barplot(Emissions ~ year,data=years)
dev.off()



question = "
Across the United States, how have emissions from coal 
combustion-related sources changed from 1999–2008?
"
answer = "
Decreasing
"