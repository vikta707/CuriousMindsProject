setwd("/Users/pc/Downloads")

library(ggplot2)
library(readxl)
library(dplyr)

#loading excel files and cleaning data
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


#Calculate the total count per school
etots <- etots %>%
  group_by(source) %>%
  mutate(Total_School_Count = sum(total)) %>%
  ungroup()

#Calculate the percentage for each ethnicity relative to the school's total count
etots <- etots %>%
  mutate(Percentage = (total / Total_School_Count) * 100)

#Select relevant columns: School, Ethnicity, and Percentage
etots <- etots %>%
  select(source, `Ethnic Group`, Percentage)

#Create a new variable for the "ring" of the donut (each school gets a different ring)
etots$Ring <- factor(etots$source, levels = c("Census", "Other secondary schools", "X College"))

#Create the combined donut chart with 3 rings for the 3 schools
ggplot(etots, aes(x = Ring, y = Percentage, fill = `Ethnic Group`)) +
  geom_bar(stat = "identity", width = 0.6, show.legend = TRUE) +  # Outer bars with width for donut effect
  coord_polar(theta = "y") +  # Converts to polar coordinates (circular shape)
  theme_void() +  # Removes gridlines, axes, and background
  labs(title = "Ethnicities by Source") +  # Adds title to the plot
  theme(legend.position = "right") +  # Position the legend to the right
  scale_fill_brewer(palette = "Set3") +  # Optional: Set a color palette for ethnic groups
  
  #Add custom labels for the rings
  annotate("text", x = 1, y = 10, label = "Census", size = 5, fontface = "bold") +  # Label for the first ring
  annotate("text", x = 2, y = 10, label = "Other Secondary Schools", size = 5, fontface = "bold") +  # Label for the second ring
  annotate("text", x = 3, y = 10, label = "X College", size = 5, fontface = "bold")  # Label for the third ring
