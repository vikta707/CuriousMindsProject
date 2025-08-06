setwd("/Users/pc/Downloads")

library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

#LOADING EXCEL FILES AND CLEANING DATA
college_data <- read_excel("college_data.xlsx")
other_data <- read_excel("oother_data.xlsx")
census_data <- read_excel("census_data.xlsx")
colnames(college_data)[1] = "Index"
colnames(other_data)[1] = "Index"
colnames(other_data[3] = "Count"
colnames(census_data )[1] = "Index"
college_data$source = "X College"
other_data$source = "Other secondary schools"
census_data $source = "Census"
all = rbind(college_data, other_data, census_data )
#all[all == 'S'] = NA
all[all == 'S'] = "0"
etots = all %>% group_by(`source`, `Ethnic Group`) %>% summarise(total = sum(as.numeric(Count), na.rm=T))
otots = all %>% group_by(`Occupation Index`, source) %>% summarise(total = sum(as.numeric(Count), na.rm=T))
tots = all %>% group_by(source) %>% summarise(total = sum(as.numeric(Count), na.rm=T))
         

#CHI SQUARED METHOD
#note parts of this data will be used for to plot stacked bar chart. change source when needed

#filtering data by source
contingency_table <- all %>%
  filter(source == "Other secondary schools") #conducting chi squared for each source, change when needed
contingency_table$source <- NULL
contingency_table$Index <- NULL

#cleaning data
contingency_table <- contingency_table[contingency_table$`Occupation Index` != "NA", ]
contingency_table$Count <- as.numeric(contingency_table$Count)

#Create a matrix from the contingency table (excluding the ethnicity column)
df_wide <- contingency_table %>%
  pivot_wider(names_from = `Occupation Index`, values_from = Count, values_fill = list(Count = 0))
df_wide <- df_wide[-7,]
contingency_matrix <- as.matrix(df_wide[, -1])

#Perform the Chi-squared test
chi_test_result <- chisq.test(contingency_matrix)




#NORMALLIZED RAW PROPORTIONS CHART

#Normalize each row (excluding the first column) and convert to percentage
normalized_data <- t(apply(df_wide[, -1], 1, function(row) (row / sum(row)) * 100))
normalized_data <- cbind(Ethnic.Group = df_wide$`Ethnic Group`, normalized_data)

#Proper normalized data
df <- contingency_table %>%
  group_by(`Ethnic Group`) %>%
  mutate(normalized_count = (Count / sum(Count))* 100) %>%
  filter(`Ethnic Group` != "Unknown")

df$Count <- NULL

#plotting graph
ggplot(df, aes(x = `Ethnic Group`, y = normalized_count, fill = `Occupation Index`)) +
  geom_bar(stat = "identity") +
  labs(x = "Ethnicity", y = "Normalized Count", title = "Effect of Ethnicity on Occupational Choice (Normalized)") +
  theme_minimal() +
  scale_fill_brewer(palette = "Set3")


