library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

countrycons <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Statista\\ContryConsumption.xlsx", sheet = "Data",colNames = TRUE)


#omitting NA
countrycons <- na.omit(countrycons)


#remove Cols
countrycons <- countrycons[,-c(3)]

#rename header
colnames(countrycons) <- c("Country","Consumption")


write.csv(countrycons,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\countrycons.csv", row.names = FALSE)
