library(tidyverse)
library(rvest)
library(stringr)

urllpg <- "https://www.globalpetrolprices.com/lpg_prices/"
readlpgurl <- read_html(urllpg)

lpgcountrynames <- readlpgurl %>%
  html_nodes(xpath = '//div[contains(@id,"outsideLinks")]//a') %>%
  html_text()


lpgpriceimage <- readlpgurl %>%
  html_nodes(xpath = '//div[contains(@id,"graphic")]//img') %>%
  html_attr('src')

lpgpriceimage
lpgpricevalue <- strsplit(lpgpriceimage,",")
lpgpricevalue <- lpgpricevalue[[1]]

lpg <- cbind(lpgcountrynames,lpgpricevalue)
write.csv(lpg,"C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\LpgBeforeCleaning.csv")

#Cleaning
uncleanlpg <- read.csv("C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\Lpgbeforecleaning.csv")
Algeria <- uncleanlpg$lpgpricevalue[1]
Algeria <-  substring(Algeria,regexpr("=",Algeria)+1)

uncleanlpg$lpgpricevalue <- as.character(uncleanlpg$lpgpricevalue)
uncleanlpg$lpgpricevalue[1] <- Algeria

Sweden <- uncleanlpg$lpgpricevalue[53]
Sweden <- substr(Sweden,1,4)
uncleanlpg$lpgpricevalue[53] <- Sweden

uncleanlpg$lpgcountrynames <- gsub("*", "", uncleanlpg$lpgcountrynames, fixed = TRUE)


write.csv(uncleanlpg,"C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\LpgAfterCleaning.csv", row.names = FALSE)
