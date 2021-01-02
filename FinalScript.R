library(tidyverse)
library(dplyr)
library(openxlsx)
library(ggplot2)

carbon <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\carbon.xlsx",colNames = TRUE)

#remove Cols
carbon <- carbon[,-c(2:18,19,20,31)]

#remove rows
carbon <- carbon[-c(1,2,3,4,9,20,23,27,44,45,46,47,48),]
#rename header
colnames(carbon) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016")

df<-carbon
library(reshape2)

p<-melt(df,id.vars = "Country" , variable.name = "Year" , value.name = "CO")
  

write.csv (p,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Carbon.csv", row.names = FALSE)


###############ECONS

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

df<-Econs
library(reshape2)

x<-melt(df,id.vars = "Country" , variable.name = "Year" , value.name = "Econ")

write.csv(x,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\ECons.csv", row.names = FALSE)


##########EPROD

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
colnames(EProd) <- c("Year","Electricity_Production")

write.csv(EProd,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\EProdStatista.csv", row.names = FALSE)


########################GASOLINEPRICE

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
write.csv(gasoline,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\gasolineBeforeCleaning.csv")


#Cleaning
uncleangasoline <- read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\gasolinebeforecleaning.csv")
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

#remove Cols
uncleangasoline <- uncleangasoline[,-c(1)]

#rename header
colnames(uncleangasoline) <- c("Country","Gasoline Price")



write.csv(uncleangasoline,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\GasolineAfterCleaning.csv", row.names = FALSE)


###############INDUSTRY

library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

Industry <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Dataset\\Major Dataset\\energyusebyindustrysourcefuel.xlsx", sheet = "Industry, source and fuel",colNames = TRUE)


#omitting NA
Industry <- na.omit(Industry)

#remove Cols
Industry <- Industry[,-c(1,2,5:21)]

#remove rows
Industry <- Industry[-c(1,3868,3869),]
Industry <- Industry[apply(Industry!=0, 1, all),]

#rename header
colnames(Industry) <- c("Industry","Fuel Used","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016")


write.csv(Industry,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Industry.csv", row.names = FALSE)


###################LPGCLEANING

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
write.csv(lpg,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\LpgBeforeCleaning.csv")

#Cleaning
uncleanlpg <- read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Lpgbeforecleaning.csv")
Algeria <- uncleanlpg$lpgpricevalue[1]
Algeria <-  substring(Algeria,regexpr("=",Algeria)+1)

uncleanlpg$lpgpricevalue <- as.character(uncleanlpg$lpgpricevalue)
uncleanlpg$lpgpricevalue[1] <- Algeria

Sweden <- uncleanlpg$lpgpricevalue[53]
Sweden <- substr(Sweden,1,4)
uncleanlpg$lpgpricevalue[53] <- Sweden

uncleanlpg$lpgcountrynames <- gsub("*", "", uncleanlpg$lpgcountrynames, fixed = TRUE)

#remove Cols
uncleanlpg <- uncleanlpg[,-c(1)]

#rename header
colnames(uncleanlpg) <- c("Country","Natural Gas Price")


write.csv(uncleanlpg,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\LpgAfterCleaning.csv", row.names = FALSE)


#####################NGCONS

library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

ngcons <- read.xlsx("C:\\Enerdata.xlsx", sheet = "Natural gas domestic consumpti",colNames = TRUE)

#omitting NA
ngcons <- na.omit(ngcons)

#remove rows
ngcons <- ngcons[-c(1,2,3,4,5,6),]

#remove Cols
ngcons <- ngcons[,-c(2:18,30,31)]


#rename header
colnames(ngcons) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
df<-ngcons
library(reshape2)

y<-melt(df,id.vars = "Country" , variable.name = "Year" , value.name = "NGCons")

write.csv(y,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\NGCons.csv", row.names = FALSE)


#############NITROGEN

library(tidyverse)
library(dplyr)
library(ggplot2)
library(openxlsx)

Nitrogen <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Nitrogen Oxide.xlsx",colNames = TRUE)

#remove Cols
#remove Cols
Nitrogen <- Nitrogen[,-c(2:20,31)]

#remove rows
Nitrogen <- Nitrogen[-c(1,2,3,4,9,20,23,27,44,45,46,47,48),]


#rename header
colnames(Nitrogen) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016")
df<-Nitrogen
library(reshape2)

d<-melt(df,id.vars = "Country" , variable.name = "Year" , value.name = "NO2")


write.csv (d,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Nitrogen.csv", row.names = FALSE)


################OILCONS

library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

oilcons <- read.xlsx("C:\\Enerdata.xlsx", sheet = "Oil products domestic consumpt",colNames = TRUE)

#remove rows
oilcons <- oilcons[-c(1:8),]

#remove Cols
oilcons <- oilcons[,-c(2:18,30,31)]

#omitting NA
oilcons <- na.omit(oilcons)

#rename header
colnames(oilcons) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")
df<-oilcons
library(reshape2)

z<-melt(df,id.vars = "Country" , variable.name = "Year" , value.name = "Oilcons")


write.csv(z,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\OilCons.csv", row.names = FALSE)

###############OILPROD

library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

oilprod <- read.xlsx("C:\\Enerdata.xlsx", sheet = "Refined oil products productio",colNames = TRUE)

#omitting NA
oilprod <- na.omit(oilprod)

#remove rows
oilprod <- oilprod[-c(1:6),]

#remove Cols
oilprod <- oilprod[,-c(2:18,30,31)]

#rename header
colnames(oilprod) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

df<-oilprod
library(reshape2)

a<-melt(df,id.vars = "Country" , variable.name = "Year" , value.name = "Oilprod")


write.csv(a,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Oiprod.csv", row.names = FALSE)


###################PGPROD

PGPROD <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Statista\\PG.xlsx", sheet = "Data",colNames = TRUE)

#remove rows
PGPROD <- PGPROD[-c(1,2),]

#remove Cols
PGPROD <- PGPROD[,-c(3,5,6,7)]

#rename header
colnames(PGPROD) <- c("Year","Gasoline","Natural Gas")


write.csv(PGPROD,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\PGPRODStatista.csv", row.names = FALSE)


###################Sulphur

Sulphur <- read.xlsx("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\sulphur.xlsx",colNames = TRUE)

#remove Cols
Sulphur <- Sulphur[,-c(2:20,31)]

#remove rows
Sulphur <- Sulphur[-c(1,2,3,4,9,20,23,27,44:48),]


#rename header
colnames(Sulphur) <- c("Country","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016")

df<-Sulphur
library(reshape2)

c<-melt(df,id.vars = "Country" , variable.name = "Year" , value.name = "SO2")


write.csv (c,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Sulphur.csv", row.names = FALSE)


####################GDP

totalenergygdp <- read.xlsx("C:\\Enerdata.xlsx", sheet = "Energy intensity of GDP",colNames = TRUE)

#rename header
colnames(totalenergygdp) <- c("Country","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

#remove rows
totalenergygdp <- totalenergygdp[-c(1:8),]
#remove Cols
totalenergygdp <- totalenergygdp[,-c(2:18,30,31)]


#omitting NA
totalenergygdp <- na.omit(totalenergygdp)

df<-oilcons
library(reshape2)

b<-melt(df,id.vars = "Country" , variable.name = "Year" , value.name = "GDP")


write.csv(b,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\totalenergyGDP.csv", row.names = FALSE)


#############ELEPRICE

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
write.csv(electricity,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\ElectricityBeforeCleaning.csv")

#Cleaning
unclean <- read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\ElectricityBeforeCleaning.csv")
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

#remove Cols
unclean <- unclean[,-c(1)]

#rename header
colnames(unclean) <- c("Country","Electricity Price")


class(pricevalue)
write.csv(unclean,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\ElectricityAfterCleaning.csv", row.names = FALSE)

################Emission combine

carbon.df = read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Carbon.csv", header = T)
Nitrogen.df = read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Nitrogen.csv", header = T)
#merge files
merge(carbon.df,Nitrogen.df, all = TRUE)
write.csv(merge(carbon.df,Nitrogen.df, all = TRUE),"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Emission.csv")

emission.df = read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Emission.csv", header = T)
Sulphur.df = read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Sulphur.csv", header = T)
emission.df<- merge(emission.df,Sulphur.df, all = TRUE)

emission.df <- na.omit(emission.df)

emission.df <- emission.df[,-c(3)]

write.csv(emission.df,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\Emission.csv",row.names = FALSE)

###############FUELPRICE_COMBINE

gasoline.df = read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\GasolineAfterCleaning.csv", header = T)
electricity.df = read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\ElectricityAfterCleaning.csv", header = T)
#merge files
fuelprice <- merge(gasoline.df,electricity.df, all = TRUE)

fuelprice <- na.omit(fuelprice)
write.csv(merge(gasoline.df,electricity.df, all = TRUE),"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\fuelprice.csv")

fuelprice.df = read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\fuelprice.csv", header = T)
LPG.df = read.csv("C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\LpgAfterCleaning.csv", header = T)
fuelprice<- merge(fuelprice.df,LPG.df, all = TRUE)

fuelprice <- na.omit(fuelprice)

fuelprice <- fuelprice[,-c(2)]

colnames(fuelprice) <- c("Country","Gasoline Price","Electricity Price","Natural Gas Price")

write.csv(fuelprice,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\fuelprice.csv", row.names = FALSE)

