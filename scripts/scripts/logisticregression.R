setwd("/Users/pc/Downloads")

library(readxl)
library(dplyr)
library(ggplot2)
library(dplyr)
library(tidyr)
library(s20x)

#loading + cleaning data for ethnicity and occupation index
data1 <- read.csv("occupation_ehtnicity.csv")
data1[qb_occ_eths_conf == 'S'] = "0"
data1 <-qb_occ_eths_conf[qb_occ_eths_conf$`Ethnic.Group` != "Unknown", ]
data1 <- qb_occ_eths_conf[, -1]
names(data1)[2:3] <- c("Occupation.Index", "Count")


#converting occuaption index data to binary
#index 1 and 2 considered "STEM" occupations (yes), other index classed as not (no)
binarydata <- data1
binarydata$`Occupation.Index` <- ifelse(binarydata$`Occupation.Index` %in% c(1, 2), 'yes', 'no')

#converting aggregate count data to individual for logistic regression
xpanded_data <- binarydata %>%
  slice(rep(1:n(), binarydata$Count)) %>%
  select(`Ethnic.Group`,`Occupation.Index`)

#setting reference/base ehtnicity to asian
occupation.df <- data.frame(lapply(expanded_data, as.factor))
occupation.df$Ethnic.Group <- relevel(occupation.df$Ethnic.Group, ref = "Asian")


head(occupation.df)

#logistic regression giving odds students pursue STEM occupation or not based on ethnicity
qb.fit = glm(Occupation.Index ~ Ethnic.Group, family = "binomial", data = qb_occupation.df) 
plot(qb.fit, which = 1)
summary(qb.fit) #gives summary of logistic regression
confint(qb.fit) #gives confidence intervals
100 * (exp(confint(qb.fit)) - 1) #converting odds ratio to percentage



