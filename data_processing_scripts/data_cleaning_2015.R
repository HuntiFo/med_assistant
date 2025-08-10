# Load required packages for data processing and analysis
library(nhanesA)       # Access NHANES datasets
library(tidyverse)     # Data manipulation and visualization
library(dplyr)         # Data wrangling (loaded via tidyverse but explicit)
library(summarytools)  # Generate summary statistics

# Load core NHANES examination datasets
demo <- nhanes("DEMO_I")  # Demographic data
blood_pressure <- nhanes("BPX_I")  # Blood pressure measurements
body_measures <- nhanes("BMX_I")  # Body measurements (height, weight, etc.)
diabetes_questionnaire <- nhanes("DIQ_I")  # Diabetes-related questions

# Search and identify all available NHANES data tables
all_tables <- nhanesSearch("") 

# Subset and load dietary data tables
diet_tables <- subset(all_tables, grepl("^DR", all_tables$Data.File.Name))
diet_data <- nhanes("DR1TOT_I")  # First day total nutrient intake

# Subset and load examination data tables
exam_tables <- subset(all_tables, grepl("^BMX|^BPX|^OHX", all_tables$Data.File.Name))
oral_exam <- nhanes("OHXPER_I")  # Oral health examination data

# List of all questionnaire tables to be combined
questionnaire_tables <- c(
  "DLQ_I", "DEQ_I", "OSQ_I", "IMQ_I", "SXQ_I", "CDQ_I", "BPQ_I", "MCQ_I", "HIQ_I",
  "HUQ_I", "PAQ_I", "PFQ_I", "HEQ_I", "ECQ_I", "DIQ_I", "SMQFAM_I", "SMQ_I", 
  "SMQRTU_I", "HOQ_I", "PUQMEC_I", "SMQSHS_I", "INQ_I", "CSQ_I", "DBQ_I", "CBQ_I", 
  "HSQ_I", "SLQ_I", "RXQASA_I", "DUQ_I", "WHQMEC_I", "ALQ_I", "DPQ_I", "ACQ_I", 
  "WHQ_I", "RHQ_I", "FSQ_I", "OHQ_I", "OCQ_I", "RXQ_RX_I", "KIQ_U_I", "CKQ_I", 
  "VTQ_I", "CFQ_I"
)

# Combine all questionnaire data by participant ID (SEQN)
questionnaire_data <- questionnaire_tables %>%
  map(~ nhanes(.x)) %>%
  discard(is.null) %>% 
  keep(~ "SEQN" %in% names(.x)) %>%  # Ensure tables have SEQN column
  reduce(full_join, by = "SEQN")

# Data cleaning steps
questionnaire_data2 <- questionnaire_data %>%
  select(-c(RXDDRGID, RXDDAYS, RXDDRGID,RXDDRUG, RXDRSD2 ,RXDRSD3))  # Remove medication-related columns

# Filter for diabetes cases (E11 code) or missing values
questionnaire_data3 <- questionnaire_data2 %>% filter(RXDRSC1 == "E11" | RXDRSC1 == "")
questionnaire_data4 <- distinct(questionnaire_data3)  # Remove exact duplicates

# Merge all datasets sequentially by participant ID
data1 <- inner_join(questionnaire_data4, demo, by = "SEQN")
data2 <- inner_join(data1, blood_pressure, by = "SEQN")
data3 <- inner_join(data2, body_measures, by = "SEQN")
data4 <- inner_join(data3, diabetes_questionnaire, by = "SEQN")
data5 <- inner_join(data4, diet_data, by = "SEQN")

# Rename sleep duration variable for consistency
data5 <- data5 %>%  rename(SLQ060=SLD012)

# Create target variable for diabetes (1 = E11 code, 0 = otherwise)
data7 <- data5 %>% mutate(target = ifelse(RXDRSC1 == "E11",1,0))
id_to_sub <- c(73557 ,74861, 74958, 75654, 75938, 76164, 76655, 77142, 77874, 78134, 78394, 80483, 80804)
data7 <- data7 %>%
  mutate(target = ifelse(SEQN %in% id_to_sub, 1, target))  # Manual override for specific IDs
data8 <- data7 %>%
  distinct(SEQN, target, .keep_all = TRUE)  # Keep one record per participant

# Add survey year and select final variables
data8 <- data8 %>% mutate(year = 2015)
selected_data <- data8 %>%
  select(
    year,
    DIQ175U.x,
    DIQ175V.x,
    CBQ505,
    RIAGENDR,
    RIDAGEYR,
    RIDRETH1,
    DMDMARTL,
    DMDEDUC2,
    INDHHIN2, 
    DMDHHSIZ, 
    BMXHT,
    BMXWT, 
    BMXBMI,
    BMXWAIST,     
    BPXSY1, 
    BPXDI1,
    HUQ010, 
    HUQ030,
    MCQ010, 
    MCQ080,
    MCQ160A,
    MCQ160B,
    MCQ160C,
    MCQ160D,
    MCQ160E,
    MCQ160F,      
    MCQ300C,      
    SMQ020,
    SMQ040, 
    ALQ101,       
    ALQ110,       
    DBQ700,       
    PAQ605,
    PAQ620,
    PAQ635,
    SLQ050, 
    SLQ060,
    DPQ020,
    DPQ040,
    PFQ020,
    target        
  )

# Clean "Don't know" responses by converting to NA
selected_data[] <- lapply(selected_data, function(x) {
  if (is.character(x) | is.factor(x)) {
    x[grepl("^do(n't| not) know$", x, ignore.case = TRUE)] <- NA
  }
  return(x)
})

# Generate and save summary statistics
summary_output <- dfSummary(selected_data, title.freq = "Summary of data", style = "grid", plain.ascii = FALSE) 
view(summary_output, file = "summary_2015.html")  # Interactive HTML summary
write.csv(selected_data, "selected_2015.csv")  # Save final dataset