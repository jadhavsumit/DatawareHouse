library(tidyverse)
library(rvest)
library(stringr)

urlgasoline <- "https://www.globalpetrolprices.com/gasoline_prices/"
readgasolineurl <- read_html(urlgasoline)

gasolinecountrynames <- readgasolineurl %>%
  html_nodes(xpath = '//div[contains(@id,"outsideLinks")]//a') %>%
  html_text()


gaspriceimage <- readgasolineurl %>%
  html_nodes(xpath = '//div[contains(@id,"graphic")]//img') %>%
  html_attr('src')

gaspriceimage
gaspricevalue <- strsplit(gaspriceimage,",")
gaspricevalue <- gaspricevalue[[1]]


gasoline <- cbind(gasolinecountrynames,gaspricevalue)
write.csv(gasoline,"C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\gasolineBeforeCleaning.csv")


#Cleaning
uncleangasoline <- read.csv("C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\gasolinebeforecleaning.csv")
venezuela <- uncleangasoline$gaspricevalue[1]
venezuela <- str_sub(venezuela,51,54)

uncleangasoline$gaspricevalue <- as.character(uncleangasoline$gaspricevalue)
uncleangasoline$gaspricevalue[1] <- venezuela

Zimbabwe <- uncleangasoline$gaspricevalue[164]
Zimbabwe <- substr(Zimbabwe,1,4)
uncleangasoline$gaspricevalue[164] <- Zimbabwe

#removestar
uncleangasoline$gasolinecountrynames <- gsub("*", "", uncleangasoline$gasolinecountrynames, fixed = TRUE)


uncleangasoline$gasolinecountrynames <- gsub("*", "", uncleangasoline$gasolinecountrynames, fixed = TRUE)

write.csv(uncleangasoline,"C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\GasolineAfterCleaning.csv", row.names = FALSE)
