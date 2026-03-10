setwd("/Users/pc/Downloads")

library(readxl)
library(dplyr)
library(ggplot2)
library(dplyr)
library(tidyr)

#loading excel files
cenus_data2 <- read_excel("cenus_data2.xlsx")
colnames(ccenus_data2 )[3] = "Index"
cenus_data2[cenus_data2   == 'S'] = "0"
cenus_data2 <- cenus_data2[cenus_data2$`Ethnic Group` != "Unknown", ]

#Ensure `Total` is treated as numeric
cenus_data2$Total <- as.numeric(cenus_data2$Total)


#Calculate the total number of students in each ethnicity
total_ethnicity <- aggregate(Total ~ `Ethnic Group`, data = cenus_data2, sum)

#Merge the total counts back into the contingency_df
contingency_df <- merge(cenus_data2, total_ethnicity, by = "Ethnic Group", suffixes = c("", "_total"))

# Normalize the counts by dividing by the total count of each ethnicity
contingency_df$normalized_count <- (contingency_df$Total / contingency_df$Total_total)* 100


#Group by ethnicity and standard
consolidated_data <- contingency_df %>%
  group_by(`Ethnic Group`, Standards) %>%   
  summarise(total_count_sum = sum(normalized_count, na.rm = TRUE))  #Sum the total count


#Create the heatmap of Ethnicity and Standard
ggplot(consolidated_data, aes(x = Standards, y = `Ethnic Group`, fill = total_count_sum)) +
  geom_tile() + 
  scale_fill_gradient(low = "white", high = "blue") +  #Continuous color scale
  labs(title = "Heatmap of Ethnicity and Standard",
       x = "Standard (Subject)",
       y = "Ethnicity",
       fill = "Proportion of Students %") +
  theme_minimal()


#Calculate the total number of students in each Index
total_index <- aggregate(Total ~ `Index`, data = index_data, sum)

#Merge the total counts back into the contingency_df
contingency_df1 <- merge(index_data, total_index, by = "Index", suffixes = c("", "_total"))

#Normalize the counts by dividing by the total count of each Index
contingency_df1$normalized_count <- (contingency_df1$Total / contingency_df1$Total_total)* 100


#Group by ethnicity and standard
consolidated_data1 <- contingency_df1 %>%
  group_by(`Index`, Standards) %>%  
  summarise(total_count_sum = sum(normalized_count, na.rm = TRUE))  #Sum the total_count


#Create the heatmap of Occupation Index and Standard
ggplot(consolidated_data1, aes(x = Standards, y = Index, fill = total_count_sum)) +
  geom_tile() + 
  scale_fill_gradient(low = "white", high = "red") +  # Continuous color scale
  labs(title = "Heatmap of Occupation Index and Standard",
       x = "Standard (Subject)",
       y = "Index",
       fill = "Proportion of Students % ") +
  theme_minimal()





#USING CHI SQUARE METHOD FOR STANDARDS AND OCCUPATION INDEX
df_wide1 <- consolidated_data1 %>%
  pivot_wider(
    names_from = Index,  # The column with index values (1-8)
    values_from = total_count_sum, # The column with the total values
    values_fill = 0  # Fill missing values with 0
  )

contingency_matrix1 <- as.matrix(df_wide1[, -1])

# Perform the Chi-squared test
chi_test_result1 <- chisq.test(contingency_matrix1)

