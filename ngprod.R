library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

ngprod <- read.xlsx("C:\\Enerdata.xlsx", sheet = "Natural gas production",colNames = TRUE)

#omitting NA
ngprod <- na.omit(ngprod)

#remove rows
ngprod <- ngprod[-c(1,2,3,4,5,6),]

#remove Cols
ngprod <- ngprod[,-c(2:18,30,31)]


#rename header
colnames(ngprod) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

write.csv(ngprod,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\ngprod.csv", row.names = FALSE)
