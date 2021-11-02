# data preparation
outdata <- paste(c(getwd(),"/Data_m4_w4"),collapse="")
dir.create(outdata)
unzip("exdata_data_NEI_data.zip",exdir=outdata)
innerfolder = "/"
# data to data.frame
NEI <- readRDS(paste(c(outdata,innerfolder,"summarySCC_PM25.rds"),collapse = ""))
SCC <- readRDS(paste(c(outdata,innerfolder,"Source_Classification_Code.rds"),collapse = ""))



data <- subset(NEI,fips %in% c("24510","06037"))
#motor_related <- subset(SCC,grepl("Motor", Short.Name,fixed = TRUE)) 
motor_related <- subset(SCC,SCC.Level.One == "Internal Combustion Engines")
motor_vehicle <- motor_related$SCC
motor_vehicle <- as.data.frame(motor_vehicle)
data_motor <- subset(data,SCC %in% motor_vehicle$motor_vehicle)


install.packages("dplyr") ## install
library("dplyr")          ## load

year_fips <-
  data_motor %>%
  group_by(year, fips) %>%
  summarize(Emissions_sum = sum(Emissions))

install.packages("tidyverse")
install.packages("ggplot2")
library(ggplot2)
g<- ggplot(year_fips,aes(year,Emissions_sum))
g+geom_point()+facet_grid(.~fips)+scale_y_continuous(trans='sqrt')



question = "
Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
sources in Los Angeles County, California fips == '06037'. Which city has seen greater changes 
over time in motor vehicle emissions?"
answer = "
California shows bigger changes than Baltimore, event when Californa reach it's minimum in 2002 
nowadays in the last lecture is reaching it's maximum value
"