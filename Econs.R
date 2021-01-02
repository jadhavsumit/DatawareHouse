library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

Econs <- read.xlsx("C:\\Enerdata.xlsx", sheet = "Electricity domestic consumpti",colNames = TRUE)

#omitting NA
Econs <- na.omit(Econs)

#remove rows
Econs <- Econs[-c(1,2,3,4,5,6),]

#remove Cols
Econs <- Econs[,-c(2:18,30,31)]

#rename header
colnames(Econs) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")


write.csv(Econs,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\ElectricityCons.csv", row.names = FALSE)
