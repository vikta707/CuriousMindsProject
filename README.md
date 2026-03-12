# CURIOUS MINDS PROJECT

## Overview

This project replicates data analysis performed during a **Data Science internship**. 
It investigates potential disparities across ethnic groups and examines how early 
subject choices may influence access to professional and STEM-related careers. 

---

##  Data


>  The datasets were manually extracted from the StatsNZ database using SQL and R.
>  The raw datasets used in this project is confidential and **not included** in this repository.

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

## Results Preview
<img width="512" height="406" alt="Censusplot" src="https://github.com/user-attachments/assets/d0268483-e684-4ea3-bbc1-406ca8b2f175" />
<img width="1068" height="930" alt="piechartX" src="https://github.com/user-attachments/assets/bf7c61a0-fc9e-430a-bce1-e02fe1b4db26" />
<img width="386" height="257" alt="Screen Shot 2026-03-12 at 3 00 06 pm" src="https://github.com/user-attachments/assets/94bb9a36-39af-480c-870c-0f84ec48da9b" />
<img width="442" height="196" alt="Screen Shot 2026-03-12 at 2 59 30 pm" src="https://github.com/user-attachments/assets/b99bf0ce-7142-4364-a157-7d97b5a810a0" />

---

## Insights

Although exact figures and some variable names are confidential, the analysis revealed several noteworthy patterns:

- Māori and Pacific students are overrepresented in labour and machinery occupations, while being underrepresented in managerial and professional roles.
- Students who take Level 3 Mathematics standards have a higher likelihood of pursuing STEM-related occupations.
- Students who did not complete either a Level 1 Mathematics or Level 1 Science standard are less likely to enter managerial or professional occupations.
- European students are overrepresented in managerial and professional occupations.
- Most students across all occupation categories have completed at least one Level 3 Science standard.
- Students who complete a Level 2 Mathematics standard are highly likely to continue on to Level 3 Mathematics.

These observations suggest that further investigation into structural or societal factors influencing occupation may be warranted.

---



