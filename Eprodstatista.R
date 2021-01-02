library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

EProd <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Statista\\E.xlsx", sheet = "Data",colNames = TRUE)

#omitting NA
EProd <- na.omit(EProd)

#remove rows
EProd <- EProd[-c(1,2,3,4,5),]

#rename header
colnames(EProd) <- c("Year","Consumption")

write.csv(EProd,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\EProdStatista.csv", row.names = FALSE)
