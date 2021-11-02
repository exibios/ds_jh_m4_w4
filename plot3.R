# data preparation
outdata <- paste(c(getwd(),"/Data_m4_w4"),collapse="")
dir.create(outdata)
unzip("exdata_data_NEI_data.zip",exdir=outdata)
innerfolder = "/"
# data to data.frame
NEI <- readRDS(paste(c(outdata,innerfolder,"summarySCC_PM25.rds"),collapse = ""))
SCC <- readRDS(paste(c(outdata,innerfolder,"Source_Classification_Code.rds"),collapse = ""))


baltimore <- subset(NEI,fips=="24510")

#install.packages("dplyr") ## install
library("dplyr")          ## load

year_type <-
baltimore %>%
  group_by(year, type) %>%
  summarize(Emissions_sum = sum(Emissions))
#install.packages("tidyverse")
#install.packages("ggplot2")
library(ggplot2)
g<- ggplot(year_type,aes(year,Emissions_sum))

png("plot3.png",width = 480,height = 480)
g+geom_point()+facet_grid(.~type)
dev.off()



question = "
Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to 
make a plot answer this question.

"
answer = "
Decreases: NON-ROAD,NONPOINT,ON-ROAD
Increases: POINT
" 