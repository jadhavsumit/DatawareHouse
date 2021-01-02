library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)


totalenergygdp <- read.xlsx("C:\\Enerdata.xlsx", sheet = "Energy intensity of GDP",colNames = TRUE)

#rename header
colnames(totalenergygdp) <- c("Country","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

#remove rows
totalenergygdp <- totalenergygdp[-c(1),]
#remove Cols
totalenergygdp <- totalenergygdp[,-c(2:18,30,31)]


#omitting NA
totalenergygdp <- na.omit(totalenergygdp)

write.csv(totalenergygdp,"C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\totalenergyGDP.csv", row.names = FALSE)
