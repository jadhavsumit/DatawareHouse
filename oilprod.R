library(openxlsx)
library(tidyverse)
library(dplyr)
library(ggplot2)

oilprod <- read.xlsx("C:\\Enerdata.xlsx", sheet = "Refined oil products productio",colNames = TRUE)

#rename header
colnames(oilprod) <- c("Country","1990","1991","1992","1993","1994","1995","1996","1997","1998","1999","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017")

#remove rows
oilprod <- oilprod[-c(1),]

#remove Cols
oilprod <- oilprod[,-c(2:18,30,31)]

#omitting NA
oilprod <- na.omit(oilprod)

write.csv(oilprod,"C:\\Users\\Sumit\\Desktop\\NCI\\DWBI\\Cleaned Data\\oilprod.csv", row.names = FALSE)
