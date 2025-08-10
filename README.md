# med_assistant

# Diabetes Pre-Screening Analysis
This project is part of the Public Health Hackathon 2025 initiatives.

Supervisor: Gulya Sarybayeva

Team members:
- Madina Abenova
- Sofiia Borovikova
- Adilkhan Ospanov
- Ekaterina Savina
- Askhat Shaltynov
## Repository Overview
This repository contains tool for pre-diagnostic screening of Type 2 Diabetes.
Utilizing data from the National Health and Nutrition Examination Survey (NHANES) (data from 2013-2014, 2015-2016), we develop predictive models to identify high-risk individuals through questionnaire-based assessment before clinical diagnosis becomes necessary.
Primary datasets available [here](https://wwwn.cdc.gov/nchs/nhanes/Default.aspx).
## Introduction 
Diabetes mellitus is a chronic, lifelong condition that requires continuous monitoring, specialized nutrition, access to modern insulins and consumables, and regular medical examinations. For children, it also involves psychological support and assistance in educational institutions.
From 1990 to 2020, there has been a steady increase in the prevalence of type 2 diabetes across all observed regions. Projections through 2040 indicate a high likelihood of further global growth to 7,000 or more cases per 100,000 population, and under an unfavorable scenario — nearly 10,000 cases. Even under the most optimistic scenario, a return to the levels recorded in the early 2000s is not expected.
The data confirm the need to strengthen preventive measures, improve early diagnosis, and expand access to treatment, especially in countries with rising incidence rates and insufficient medical coverage. Khan MAB, Hashim MJ, King JK, Govender RD, Mustafa H, Al Kaabi J. Epidemiology of Type 2 Diabetes - Global Burden of Disease and Forecasted Trends. J Epidemiol Glob Health. 2020 Mar;10(1):107-111. doi: 10.2991/jegh.k.191028.001. PMID: 32175717; PMCID: PMC7310804.
<img width="2771" height="46" alt="image" src="https://github.com/user-attachments/assets/d54f1ecc-f787-4a49-ac82-9efae48c5725" />

## Methodology
This project uses self-reported NHANES questionnaire data (2013-2016) including demographics (age, sex, race, income), lifestyle factors (activity, smoking, alcohol, sleep), and health history (family/self-reported conditions), while excluding clinical measurements.  We selected two time periods (2013–2014 and 2015–2016) and processed the data separately using the scripts `data_processing_*`. Variables for further analysis were manually selected based on available questionnaire data. The datasets for each period were then merged and preprocessed for machine learning: records with excessive missing values were removed, and NA values were reconstructed for certain columns.
The final list of selected variables:
1.	RIAGENDR - Gender
2.	RIDAGEYR - Age
3.	RIDRETH1 - Race/Ethnicity
4.	DMDMARTL - Marital status
5.	DMDEDUC2 - Education level
6.	INDHHIN2 - Household income
7.	DMDHHSIZ - Household size
8.	BMXHT - Height (cm)
9.	BMXBMI - BMI
10.	BPXSY1 - Systolic BP (mmHg)
11.	BPXDI1 - Diastolic BP (mmHg)
12.	HUQ010 - General health rating
13.	HUQ030 - Last doctor visit time
14.	MCQ010 - Asthma diagnosis
15.	MCQ080 - Overweight diagnosis
16.	MCQ160A - Heart failure
17.	MCQ160B - Coronary heart disease
18.	MCQ160D - Heart attack
19.	MCQ160E - Myocardial infarction
20.	MCQ160F - Stroke
21.	MCQ300C - Family diabetes history
22.	SMQ020 - Smoking status (100+ cigarettes)
23.	ALQ101 - Alcohol consumption
24.	DBQ700 - Self-rated diet quality
25.	CBQ505 - Fast food consumption frequency
26.	PAQ605 - Vigorous physical activity
27.	PAQ620 - Moderate physical activity
28.	PAQ635 - Walking/biking activity
29.	SLQ050 - Sleep problems
30.	SLQ060 - Sleep disorder diagnosis
31.	DPQ020 - Feelings of depression
32.	DPQ040 - Feelings of fatigue
33.	PFQ020 - Mobility limitations
34.	DIQ175U - Thirst
35.	DIQ175V - Craving for sweet/eating a lot of sugar

Target variable: Diabetes status (ICD-10 code E11) as binary classification (1 = E11 present, 0 = absent).
