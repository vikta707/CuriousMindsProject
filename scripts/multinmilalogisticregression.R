setwd("/Users/pc/Downloads")

library(readxl)
library(nnet)
library(dplyr)

#MULTINOMIAL LOGISTIC REGRESSION
#determining how ethnicities and/or standards students take influence pursuing different occupaitonal choices

#loading excel files
censusdata2 <- read_excel("censusdata2 .xlsx")
colnames(censusdata2 )[3] = "Index"
censusdata2  [censusdata2   == 'S'] = "0"
censusdata2  <- censusdata2 [censusdata2$`Ethnic Group` != "Unknown", ]

#total count for each occuaption index
indextotal = censusdata2  %>% group_by(`Index`) %>% summarise(total = sum(as.numeric(Total), na.rm=T))

#converting aggregate counts to single data
expanded_data <- censusdata2   %>%
  slice(rep(1:n(), censusdata2 $Total)) %>%
  select(`Ethnic Group`, Standards, Index)

#ensuring all colomns set as factor
expanded_data$`Ethnic Group` <- as.factor(expanded_data$`Ethnic Group`)
expanded_data$Standards <- as.factor(expanded_data$Standards)
expanded_data$Index <- as.factor(expanded_data$Index)

#change baseline 
expanded_data$Index <- relevel(expanded_data$Index, ref = "6")

#Fit the multinomial logistic regression model
model <- multinom(Index ~ `Ethnic Group` + Standards, data = expanded_data, maxit = 200)

#View model results
summary(model)

#extractingb results from model
coefficients <- summary(model)$coefficients
std_errors <- summary(model)$standard.errors
OddsRatio <- exp(coefficients)
std_errors1 <- exp(std_errors)

#Calculate the z-values (coefficients / standard errors)
z_values <- coefficients / std_errors1

#Calculate the p-values using the normal distribution (two-tailed test)
p_values <- 2 * (1 - pnorm(abs(z_values)))

#confindence intervals
lower_ci <- exp(coefficients - 1.96 * std_errors)
upper_ci <- exp(coefficients + 1.96 * std_errors)

#consolidating results
error_table <- data.frame(
  Standard_Errors = std_errors1,  # Your standard errors
  Z_Values = z_values,  # Your z-values
  P_Values = p_values  # Your p-values
)

oddsratio_table <- data.frame(
  odds_ratio = OddsRatio,  
  upper_CI = upper_ci,
  lower_CI = lower_ci 
)


write.csv(oddsratio_table, "oddsratiotable.csv", row.names = FALSE)
write.csv(error_table, "errortable.csv", row.names = FALSE)

