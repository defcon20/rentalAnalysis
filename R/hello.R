# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

library(plyr)
library(dplyr)
library(lubridate)
library(ggplot2)
library(reshape)

#setwd("C:/Users/davidliou/Documents/realestate1")

# filenames <- list.files(path="data", full.names=TRUE)
# import.list <- llply(filenames, read.csv)
# data <- merge_recurse(import.list)

data <- read.csv("./data/sold_export.csv")
data$Listing.Contract.Date <- as.Date(data$Listing.Contract.Date, format = "%Y-%m-%d")
data$Month_Int <- as.numeric(strftime(data$Listing.Contract.Date,"%m"))
data$Month_Char <- month.abb[data$Month_Int]
data$Month_Char <- factor(data$Month_Char, levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ))
groups_zipcode <- with(data, split(data, list(Zip.Code, Month_Char)))


summary_inventory_leased <- lapply(groups_zipcode, nrow)
summary_inventory_leased
#summary_quantile <- lapply(groups_zipcode, function(group){quantile(group)})
#summary_mean <- lapply(groups_zipcode, function(group){mean(group)})

cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
inventory_graph <- ggplot(data = data, aes(x=Month_Char, fill = as.factor(Zip.Code))) + geom_histogram(position = "dodge") + scale_fill_manual(values=cbPalette)
inventory_graph

#price_boxplot <- ggplot(data = data, aes(x=Month_Char, y= as.numeric(Close.Price), fill = as.factor(Zip.Code))) + geom_boxplot()
#price_boxplot

# Create Data
# Time <- seq(as.Date("2003/8/6"), as.Date("2011/8/5"), by = "2 weeks")
# data <- rnorm(209, mean = 15, sd = 1)
# DF <- data.frame(Time = Time, Data = data)
# DF[,3] <- as.numeric(format(DF$Time, "%m"))
# colnames(DF)[3] <- "Month"
#
#ts(x$count, start=c(2011,01,01), end=c(2011,12,01), frequency=12)

#groups_zipcode_date <- split(groups_zipcode, groups_zipcode$Listing.Contract.Date)


# #Data cleaning
# #data$Pool <- as.logical(data$Pool)
# #data_to_predict$Pool <- as.logical(data_to_predict$Pool)
# #data$Lot.Size.SqFt <- as.integer(data$Lot.Size.SqFt)
# #data_to_predict$Lot.Size.SqFt <- as.integer(data_to_predict$Lot.Size.SqFt)
#
# # #Testing Scripts
# # typeof(data$Lot.Size.SqFt)
# # data$Lot.Size.SqFt
# # typeof(data_to_predict$Lot.Size.SqFt)
# # data_to_predict$Lot.Size.SqFt
#
# #data_to_predict$Lot.Size.SqFt <- as.double(data_refined$Lot.Size.SqFt)
#
# #Apply Filtersdata
#
# #data <- filter(data, Close.Price > 200000, Close.Price < 500000)
# #data <- filter(data, Pool == 0)
# #data <- filter(data, Number.Of.Stories == 2)
#
# #Select variables to include
# data_vector <- c("Close.Price", "Baths.Full","Baths.Half", "Beds.Total", "Lot.Size.SqFt", "SqFt.Total", "Yr.Built")
# data_vector2 <- c("Baths.Full","Baths.Half", "Beds.Total", "Lot.Size.SqFt", "SqFt.Total", "Yr.Built")
#
# data_refined <- data[,data_vector]
# data_refined_predict <- data_to_predict[,data_vector2]
#
# #Split based on zipcode
# listofgroups <- split(data_refined, data$Zip.Code)
#
#
# listofregressions <- lapply(listofgroups, function(group){
#
#   lm(Close.Price ~ Baths.Full + Baths.Half + Beds.Total + Lot.Size.SqFt + SqFt.Total + Yr.Built, group)
#
# })
#
#
# #Get summary of regressions, quantile, and predicted values
# summaryofgroup <- lapply(listofregressions, function(group){summary(group)})
#
# quantileofgroup <-lapply(listofgroups, function(group){quantile(group$Close.Price)})
#
# predicted_values <- lapply(listofregressions, function(group){predict(group,data_refined_predict)})
#
# predicted_values


#Zipcodes: 75013, 75025, 75035, 75070, 75071, 75075, 75093
#Zipcodes2:
#657/12=54.75 inventory turnover 2014
#714/12 =59.25
#December 2014 37
#55 11-12-2014-12-11-2014
#47 11-12-2015-12-11-2015
