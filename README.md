# ANALYSIS ON THE EFFECT OF ETHNICITY ON OCCUPATIONAL CHOICE(R)

This project replicates data analysis I performed during a data science internship. It investigates the relationship between ethnicity and 
occupational choice using data obtained from StatsNZ. Due to confidentiality agreements, the dataset and outputs are not shared, but the 
complete R code and workflow are included for demonstration purposes.

---

## Objective

To explore whether individuals from different ethnic backgrounds are disproportionately represented in specific occupations, specifically
Maori and Pacific ethnic groups. The analysis aims to determine if ethnicity is a statistically significant predictor of occupation 
choice, whilst also considering other factors such as specific standards taken in high school.

---

##  Data


>  The datasets were manually extracted from the StatsNZ database using SQL and R.
>  The datasets used in this project is confidential and **not included** in this repository.

However, the original dataset included the following columns:

- `ethnicity`: Categorical (e.g., White, Black, Asian, etc.)
- `occupation index`: Categorical job title ranging from 1-8 indicating specific. This is derived from the New Zealand National Occupation List
- `gender`: Categorical (e.g., Male, Female)
- `source`: Categorical sources from where the data came from which are X college, 100 sampled schools and the Census. Note X College is a made up school for confidentiality.
- `standards`: Categorical standards the students have completed specifically Mathematics and Science from NCEA level 1 to Level 3.

---

## Methodology


The analysis was structured into multiple stages, each in its own R script:

 1. Heatmap (`heatmap+chisquared.R`)
- Frequency of combinations (ethnicity and occupation index + standard + occupation)
- Chi-squared method was also used to determine any statistical significance between occupation and standard

 2. Staked Bar Chart (`stackedbarchart+chisquared.R`)
- Used Stacked bar charts to visualise:
  - Distribution of occupations across ethnicities
  - Relationships between demographic variables and occupation
- Visualisations created with `ggplot2`
- Data was normalised
- Chi-squared method was also used to determine any statistical significance between occupation and ethnicity

 3. Logistic Regression (`logisticregression.R`)
- Binary logistic regression
- Determining the odds a student will pursue a "STEM" occupation or not for each ethnicity (setting 'Asian' as the base ethnicity)
- Included ethnicity as only predictor
- Interpreted model coefficients and significance

 4. Multinomial Logistic Regression (`multinomiallogisticregression.R`)
- Applied multinomial regression
- Determine odds student will pursue different occupations based on ethnicity and standards taken
- Compared likelihoods and class probabilities

 5. Stacked pie chart (`stackedpiechart.R`)
- Proportional representation of ethnic groups for each source

---

## Tools & Libraries

- **Language**: R
- **Environment**: RStudio
- **Libraries**:
  - `readxl` (load files)
  - `tidyverse` (data wrangling, plotting)
  - `ggplot2` (visualization)
  - `nnet` (multinomial logistic regression)
  - `s20x` (logistic regression)
  - `dplyr`, `tidyr`, 
  
---

## Results & Observations

Although exact figures and some variable names are confidential, the analysis revealed several noteworthy patterns:

- Ethnic groups such as Maori and Pacific are overrepresented in Labour/Machinery Jobs in underrepresented in Manager/Professional jobs.
- Taking Mathematics Standards in Level 3 gives students a higher chance in pursuing "STEM" occupations
- Students who have not taken either a Level 1 Mathematics or Level 1 Science Standard are less likely to pursue in Manager/Professional Jobs

These observations suggest that further investigation into structural or societal factors influencing occupation may be warranted.

---

##  Project Structure
ethnicity-occupation-r/
├── scripts/
│ ├── heatmap+chisquared.R
│ ├── logisticregression.R
│ ├── multinmilalogisticregression.R
│ ├── stackedbarchart+chisquared.R
│ └── stackedpiechart
│
├── data/
│ └── [Confidential – not included]
│
├── outputs/
│ └── [Charts – not included]
│
└── README.md

