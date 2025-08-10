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
The data confirm the need to strengthen preventive measures, improve early diagnosis, and expand access to treatment, especially in countries with rising incidence rates and insufficient medical coverage. [Khan et all](https://pmc.ncbi.nlm.nih.gov/articles/PMC7310804/) .
We aim to develop a machine learning model that predicts the risk of developing type 2 diabetes mellitus based on complex data, including demographics, laboratory indicators, behavioral indicators, social determinants, and family history.

The goal of this project is to develop a functional diagnostic survey that identifies key risk factors for type 2 diabetes and supports individuals in taking preventive measures. With the Kazakhstani government planning to discontinue support for people with diabetes, this initiative seeks to reduce the incidence of this largely preventable condition through early detection and lifestyle interventions. The survey will allow any citizen to easily assess their personal risk and take action before the disease develops.
## Methodology
Due to the lack of publicly available diabetes-related datasets for Kazakhstan, this project utilizes open data from the **National Health and Nutrition Examination Survey (NHANES)**, United States. The pilot version of the survey and predictive models is therefore based on NHANES data.
This project uses self-reported NHANES questionnaire data (2013-2016) including demographics (age, sex, race, income), lifestyle factors (activity, smoking, alcohol, sleep), and health history (family/self-reported conditions), while excluding clinical measurements.  We selected two time periods (2013–2014 and 2015–2016) and processed the data separately using the scripts `data_processing_*`. 
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
## Variable Selection and Survey

Survey variables were selected based on:
1. Published research on risk factors for type 2 diabetes  
2. Feature importance analysis from our machine learning models  

The table below lists each variable, its corresponding survey question, and the supporting research (if applicable).

| Variable | Question (Russian / English) | Source / Evidence |
|----------|------------------------------|-------------------|
| **RIDAGEYR** | Возраст / Age | Chew, B. H., et al. (2013). *Age ≥ 60 years was an independent risk factor for diabetes-related complications despite good control of cardiovascular risk factors in patients with type 2 diabetes mellitus*. Experimental Gerontology, 48(5), 485–491. [DOI](https://doi.org/10.1016/j.exger.2013.02.017) |
| **BMXBMI** | Индекс массы тела (ИМТ, кг/м²) / Body Mass Index (BMI, kg/m²) | Gray, N., et al. (2015). *The relationship between BMI and onset of diabetes mellitus and its complications*. Journal of Endocrinology and Diabetes, 3(2), 1–9. [DOI](https://doi.org/10.19080/OAJECR.2015.03.555606), [PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC4457375/) |
| **BMXHT** | Рост (см) / Height (cm) | Based on Feature Importance |
| **BPXSY1** | Систолическое давление (мм рт. ст.) / Systolic blood pressure (mm Hg) | Based on Feature Importance |
| **BPXDI1** | Диастолическое давление (мм рт. ст.) / Diastolic blood pressure (mm Hg) | Based on Feature Importance |
| **RIAGENDR** | Пол / Gender | — |
| **HUQ010** | Как Вы оцениваете своё общее состояние здоровья? / How would you rate your general health? | Based on Feature Importance |
| **HUQ030** | Есть ли у Вас постоянное место (врач или поликлиника), куда Вы обращаетесь при необходимости? / Do you have a usual place to go when you are sick or need health advice? | Based on Feature Importance |
| **MCQ010** | Ставил ли Вам врач диагноз «астма»? / Has a doctor ever told you that you have asthma? | Based on Feature Importance |
| **MCQ080** | Сообщал ли Вам врач о наличии лишнего веса? / Has a doctor ever told you that you are overweight? | Gray, N., et al. (2015). *The relationship between BMI and onset of diabetes mellitus and its complications*. [DOI](https://doi.org/10.19080/OAJECR.2015.03.555606), [PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC4457375/) |
| **MCQ160A** | Ставил ли Вам врач диагноз «артрит»? / Has a doctor ever told you that you have arthritis? | Tian, Z., et al. (2021). *The relationship between rheumatoid arthritis and diabetes mellitus: A systematic review and meta-analysis*. Diabetology & Metabolic Syndrome, 13(1), 86. [DOI](https://doi.org/10.1186/s13098-021-00698-4), [PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC8189616/) |
| **MCQ160B** | Ставил ли Вам врач диагноз «сердечная недостаточность»? / Has a doctor ever told you that you have congestive heart failure? | Based on Feature Importance |
| **MCQ160C** | Ставил ли Вам врач диагноз «ишемическая болезнь сердца»? / Has a doctor ever told you that you have coronary heart disease? | Based on Feature Importance |
| **MCQ300C** | Был ли у Ваших близких родственников сахарный диабет? / Have any of your close relatives been diagnosed with diabetes? | Ali, O. (2013). *Genetics of type 2 diabetes*. World Journal of Diabetes, 4(4), 114–123. [DOI](https://doi.org/10.4239/wjd.v4.i4.114), [PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC3746083/) |
| **SLQ050_Yes** | Замечали ли Вы у себя проблемы со сном? / Have you ever had trouble sleeping? | Darraj, A. (2023). *The link between sleeping and type 2 diabetes: A systematic review*. Cureus, 15(11), e49371. [DOI](https://doi.org/10.7759/cureus.49371), [PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC10693913/) |

## Feature Importance

### XGBoost
<img width="2250" height="937" alt="xgboost" src="https://github.com/user-attachments/assets/ea7392fe-1854-4561-8863-e41bfff1069a" />

- **F1 Score:** 0.9715  
- **Accuracy:** 0.9480  
- **Gini Index:** 0.9232  
- **Sensitivity:** 0.9778  
- **Specificity:** 0.6623  
- **Kolmogorov–Smirnov (KS) Statistic:** 0.8268  

---

### Short XGBoost
<img width="2250" height="937" alt="short_xgb" src="https://github.com/user-attachments/assets/39ed69dc-3656-4af4-bd34-22db09ba901b" />

- **F1 Score:** 0.9699  
- **Accuracy:** 0.9451  
- **Gini Index:** 0.9185  
- **Sensitivity (Recall):** 0.9765  
- **Specificity:** 0.6450  
- **Kolmogorov–Smirnov (KS) Statistic:** 0.8129  

---

### LightGBM
<img width="2250" height="937" alt="lightdbm" src="https://github.com/user-attachments/assets/e91a3ddf-ab10-4f49-aee7-5104bb63b1e1" />

- **F1 Score:** 0.9726  
- **Accuracy:** 0.9500  
- **Gini Index:** 0.9321  
- **Sensitivity:** 0.9810  
- **Specificity:** 0.6596  
- **Kolmogorov–Smirnov (KS) Statistic:** 0.8591  

---

### Random Forest
<img width="2250" height="937" alt="rf" src="https://github.com/user-attachments/assets/0d66446d-27c9-422a-aa10-bc90ad60f971" />

- **F1 Score:** 0.9726  
- **Accuracy:** 0.9496  
- **Gini Index:** 0.9314  
- **Sensitivity:** 0.9882  
- **Specificity:** 0.5872  
- **Kolmogorov–Smirnov (KS) Statistic:** 0.8238  

---

### SVM
- **F1 Score:** 0.9755  
- **Accuracy:** 0.9554  
- **Gini Index:** 0.9272  
- **Sensitivity:** 0.9846  
- **Specificity:** 0.6809  
- **Kolmogorov–Smirnov (KS) Statistic:** 0.8504  

## NHANES Data Collection and Processing
This project retrieves and processes data from the National Health and Nutrition Examination Survey (NHANES) using the nhanesA R package.
The workflow integrates data from all major NHANES components for a given survey cycle, cleans them, and produces a unified dataset ready for analysis.
## Components
For each NHANES cycle, data are collected from the following components:
Demographic – Age, sex, race/ethnicity, education, income, etc.
Dietary – Nutrient intake, dietary habits, food frequency.
Questionnaire – Health-related interviews, lifestyle factors.
Examination – Physical measurements, medical examinations.
Laboratory – Clinical and biochemical test results.
## Data Cleaning and Preprocessing
Remove redundant variables – Drop variables that are incompatible or irrelevant before merging.
Remove duplicates – Remove duplicate records based on respondent ID (SEQN).
Standardize responses – Convert "Don't Know" and "Refused" to NA.
Create target variable:
target = 1 if RXDRSC1 == "E11" (diabetes diagnosis, ICD-10 code).
target = 0 otherwise.
## Preprocessing
After we cleaned datasets for each period of time, we combined them. 
Replace NA in DIQ175U.x and DIQ175V.x with "No".
Remove variables with a high proportion of missing values (ALQ110, SMQ040, year).
Replace "Refused" with NA for all character columns.
Convert all remaining character variables to factors.


## Numeric Encoding of Ordinal and Categorical Variables
### Variable Recoding
Several variables were converted from text categories to numeric codes for modeling:

- **SLQ060** → Converted directly to numeric.
- **HUQ010** → Mapped health ratings to an ordinal scale:  
  `Poor` → 1, `Fair` → 2, `Good` → 3, `Very good` → 4, `Excellent` → 5.
- **INDHHIN2** → Mapped household income ranges to an ordered numeric scale (1–12).
- **DMDEDUC2** → Mapped education levels to codes 1–4.
- **DBQ700** → Mapped self-reported diet/health status to codes 1–5.
- **DMDHHSIZ** → Converted `"7 or more people"` to `7`; kept other values numeric.
- **HUQ030** → Binary encoded: `0` if `"There is no place"`, otherwise `1`.
- **Other binary variables** → Encoded as `1` if `"Yes"`, otherwise `0`.

## Machine Learning in Risk estimation

We developed five machine learning models to predict the risk level of the disease.  
All models demonstrated strong performance across multiple evaluation metrics, so we employed an **ensemble approach**.  

### Ensemble Process
- Each model outputs a probability score for the positive class.
- The final probability is calculated as the **mean** of the probabilities from all five models.

### Risk Zone Classification
We use a **percentile-based** method to assign risk zones:  
1. Estimate probabilities for all observations in the original dataset.  
2. Calculate quantile thresholds (75th, 89th, and 90th percentiles).  
3. Classify individuals into one of three zones:

- **Green Zone** — Probability < 75th percentile  
  *Low risk*: Maintain current lifestyle; follow recommendations to remain in this zone.  

- **Yellow Zone** — Probability between the 75th and 89th percentiles  
  *Moderate risk*: Exercise caution; consider consulting a healthcare professional.  

- **Red Zone** — Probability ≥ 90th percentile  
  *High risk*: Seek immediate medical attention and undergo laboratory testing.
## Website
## Survey Application

The survey application is located in the **`project`** folder, file name: **`app.R`**.  

Due to the limited RAM available on the Shiny server, the application cannot be hosted online in its current form, as it requires more memory than Shiny’s free tier provides.

### Application Functionality

- The web interface presents all survey questions to the user.  
- Upon completing the survey, the server calculates the respondent’s **risk probability** and assigns them to one of three **risk zones** (Green, Yellow, or Red).  
- Based on the assigned risk zone, the application provides **personalized recommendations** for reducing the risk of developing type 2 diabetes.

### Interface Overview

- **Left Panel** — Survey questions.  
  <img width="662" height="920" alt="Survey Questions" src="https://github.com/user-attachments/assets/6cce3f1b-f34a-43bf-883f-eb4c4e93c086" />

- **Center Panel** — Predicted risk zone and tailored recommendations.  
  <img width="789" height="855" alt="Risk and Recommendations" src="https://github.com/user-attachments/assets/ef1163d8-35f1-40f6-a71d-b15b33788d0f" />

- **Right Panel** — Probability predictions from each of the five ensemble models.  
  <img width="796" height="628" alt="Model Probabilities" src="https://github.com/user-attachments/assets/3c9918fb-9f39-4ae0-a865-597cc61deef6" />

- **Bottom Section** — Option to save the results as a PDF file.  
  <img width="353" height="538" alt="Save as PDF" src="https://github.com/user-attachments/assets/d3b9f506-7176-4749-8757-17ec40b8ed14" />





