library(tidyverse)
library(dplyr)
library(openxlsx)
library(ggplot2)

carbon <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\carbon.xlsx",colNames = TRUE)

#remove Cols
carbon <- carbon[,-c(2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,31)]

#remove rows
carbon <- carbon[-c(1,2,3,4,9,20,23,27,44,45,46,47,48),]


#rename header
colnames(carbon) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016")

write.csv (carbon,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Carbon.csv", row.names = FALSE)
