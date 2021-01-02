library(tidyverse)
library(rvest)
library(stringr)

url <- "https://www.globalpetrolprices.com/electricity_prices/"
readurl <- read_html(url)

countrynames <- readurl %>%
  html_nodes(xpath = '//div[contains(@id,"outsideLinks")]//a') %>%
  html_text()

priceimage <- readurl %>%
  html_nodes(xpath = '//div[contains(@id,"graphic")]//img') %>%
  html_attr('src')

priceimage
pricevalue <- strsplit(priceimage,",")
pricevalue <- pricevalue[[1]]

electricity <- cbind(countrynames,pricevalue)
write.csv(electricity,"C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\ElectricityBeforeCleaning.csv")

#Cleaning
unclean <- read.csv("C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\ElectricityBeforeCleaning.csv")
burma <- unclean$pricevalue[1]
burma <- substring(burma,regexpr("=",burma)+1)
unclean$pricevalue <- as.character(unclean$pricevalue)

unclean$pricevalue <- as.character(unclean$pricevalue)

unclean$pricevalue[1] <- burma

denmark <- unclean$pricevalue[94]
denmark <- substr(denmark,1,4)
str(unclean)
a <- sub('"',"",denmark)
unclean$pricevalue[94] <- as.factor(a)

unclean$countrynames <- gsub("*", "", unclean$countrynames, fixed = TRUE)


class(pricevalue)
write.csv(unclean,"C:\\Users\\MOLAP\\Desktop\\DWBI\\Cleaned Data\\ElectricityAfterCleaning.csv", row.names = FALSE)
