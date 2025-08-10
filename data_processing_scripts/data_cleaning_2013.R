# Load required packages
library(nhanesA)
library(tidyverse)
library(summarytools)
library(dplyr)

# Import core NHANES datasets
demo_h <- nhanes("DEMO_H")
blood_pressure <- nhanes("BPX_H")
body_measures <- nhanes("BMX_H")
diabetes_questionnaire <- nhanes("DIQ_H")

# Identify available data tables
all_tables <- nhanesSearch("") 
diet_tables <- subset(all_tables, grepl("^DR", all_tables$Data.File.Name))
diet_data <- nhanes("DR1TOT_H")

exam_tables <- subset(all_tables, grepl("^BMX|^BPX|^OHX", all_tables$Data.File.Name))
oral_exam <- nhanes("OHXPER_H")

# Combine questionnaire data
questionnaire_tables <- c(
  "DLQ_H", "DEQ_H", "OSQ_H", "IMQ_H", "SXQ_H", "CDQ_H", "BPQ_H", "MCQ_H", "HIQ_H",
  "HUQ_H", "PAQ_H", "PFQ_H", "HEQ_H", "ECQ_H", "DIQ_H", "SMQFAM_H", "SMQ_H", 
  "SMQRTU_H", "HOQ_H", "PUQMEC_H", "SMQSHS_H", "INQ_H", "CSQ_H", "DBQ_H", "CBQ_H", 
  "HSQ_H", "SLQ_H", "RXQASA_H", "DUQ_H", "WHQMEC_H", "ALQ_H", "DPQ_H", "ACQ_H", 
  "WHQ_H", "RHQ_H", "FSQ_H", "OHQ_H", "OCQ_H", "RXQ_RX_H", "KIQ_U_H", "CKQ_H", 
  "VTQ_H", "CFQ_H"
)

# Merge questionnaire tables
questionnaire_data <- questionnaire_tables %>%
  map(~ nhanes(.x)) %>%
  reduce(full_join, by = "SEQN")

# Data cleaning steps
questionnaire_data2 <- questionnaire_data %>%
  select(-c(RXDDRGID, RXDDAYS, RXDDRGID,RXDDRUG, RXDRSD2 ,RXDRSD3))

questionnaire_data3 <- questionnaire_data2 %>% filter(RXDRSC1 == "E11" | RXDRSC1 == "")
questionnaire_data4 <- distinct(questionnaire_data3)

# Join all datasets
data1 <- inner_join(questionnaire_data4, demo_h, by = "SEQN")
data2 <- inner_join(data1, blood_pressure, by = "SEQN")
data3 <- inner_join(data2, body_measures, by = "SEQN")
data4 <- inner_join(data3, diabetes_questionnaire, by = "SEQN")
data5 <- inner_join(data4, diet_data, by = "SEQN")
data6 <- left_join(data5, oral_exam, by = "SEQN")

# Create target variable
data7 <- data6 %>% mutate(target = ifelse(RXDRSC1 == "E11",1,0))
id_to_sub <- c(73557 ,74861, 74958, 75654, 75938, 76164, 76655, 77142, 77874, 78134, 78394, 80483, 80804)
data7 <- data7 %>%
  mutate(target = ifelse(SEQN %in% id_to_sub, 1, target))
data8 <- data7 %>%
  distinct(SEQN, target, .keep_all = TRUE)

# Final dataset preparation
data8 <- data8 %>% mutate(year = 2013)
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

# Clean "Don't know" responses
selected_data[] <- lapply(selected_data, function(x) {
  if (is.character(x) | is.factor(x)) {
    x[grepl("^do(n't| not) know$", x, ignore.case = TRUE)] <- NA
  }
  return(x)
})

# Generate and export results
summary_output <- dfSummary(selected_data, title.freq = "Summary of data", style = "grid", plain.ascii = FALSE) 
view(summary_output, file = "summary_2013.html")
write.csv(selected_data, "selected_2013.csv")