# Layoffs Data Cleaning and EDA with SQL

This project demonstrates a complete data preprocessing and exploratory data analysis (EDA) workflow using SQL on a layoffs dataset. The data was cleaned and transformed to prepare it for insights into global layoffs across industries, countries, and time periods.


## 📌 Project Objectives

1. **Data Cleaning**
   - Remove duplicate records
   - Standardize inconsistent values
   - Handle null or missing data
   - Prepare a clean and reliable dataset for analysis

2. **Exploratory Data Analysis (EDA)**
   - Analyze total layoffs by company, industry, and country
   - Explore trends over time (monthly, yearly)
   - Identify top companies by number of layoffs
   - Use window functions to derive rolling totals and rankings

## 🧼 Cleaning Steps (See `CleaningData.sql`)

- Created backups of raw data to ensure integrity
- Removed duplicate rows using `ROW_NUMBER()` and CTEs
- Standardized:
  - Company names (using `TRIM()`)
  - Industry names (e.g., unifying "Crypto" variants)
  - Country names (e.g., removing trailing periods)
  - Dates (converted to proper `DATE` format)
- Filled missing industries by matching with other rows from the same company
- Deleted rows where both `total_laid_off` and `percentage_laid_off` were null
- Dropped temporary columns after cleaning


## 📊 Analysis Insights (See `EDA.sql`)

- **Top companies** by total layoffs
- **Industries and countries** most affected
- **Yearly and monthly trends** of layoffs
- **Rolling total** of layoffs to visualize the progression
- **Ranking** top 5 companies per year using `DENSE_RANK()`

---

## 🛠️ Tech Stack

- **Language:** SQL (MySQL)
- **Database Used:** MySQL (world_layoffs)

