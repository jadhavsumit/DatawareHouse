library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

Industry <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Dataset\\Major Dataset\\energyusebyindustrysourcefuel.xlsx", sheet = "Industry, source and fuel",colNames = TRUE)


#omitting NA
Industry <- na.omit(Industry)

#remove Cols
Industry <- Industry[,-c(1,2,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21)]

#remove rows
Industry <- Industry[-c(1,3868,3869),]

#rename header
colnames(Industry) <- c("Source Name","Fuel Used","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016")

Industry <- Industry[apply(Industry!=0, 1, all),]

write.csv(Industry,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Industry.csv", row.names = FALSE)
