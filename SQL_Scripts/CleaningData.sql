-- Data Cleaning

use world_layoffs;

-- 1) Remove Duplicates
-- 2) Standardize the data
-- 3) Null Values or blank Values
-- 4) Remove any columns

select *
from layoffs;

CREATE TABLE layoffs_backup
LIKE layoffs ;

SELECT *
FROM layoffs_backup;

INSERT layoffs_backup
SELECT *
FROM layoffs;

-- Removing Duplicates

SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
company,industry,total_laid_off,percentage_laid_off,`date`) as row_num
FROM layoffs_backup;

WITH duplicate_cte AS
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY 
	company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
	FROM layoffs_backup
)
SELECT *
FROM duplicate_cte
WHERE row_num>1;


SELECT *
FROM layoffs_backup
WHERE company='Casper'; 

CREATE TABLE `layoffs_backup2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_no` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_backup2;

INSERT INTO layoffs_backup2
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY 
	company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
	FROM layoffs_backup;

SELECT *
FROM layoffs_backup2
WHERE row_no >1;

DELETE
FROM layoffs_backup2
WHERE row_no>1;


SELECT *
FROM layoffs_backup2;



-- STANDARDIZING DATA

select company
from layoffs_backup2;


UPDATE layoffs_backup2
SET company=TRIM(company);

SELECT DISTINCT industry
FROM layoffs_backup2
ORDER BY 1;


SELECT industry
FROM layoffs_backup2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_backup2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT(industry)
FROM layoffs_backup2;

SELECT *
FROM layoffs_backup2;

-- standardizing --

SELECT DISTINCT(country)
FROM layoffs_backup2
ORDER BY 1;

SELECT DISTINCT country,TRIM(TRAILING '.' FROM country)
FROM layoffs_backup2
ORDER BY 1;

UPDATE layoffs_backup2
SET country=TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT *
FROM layoffs_backup2
WHERE country='United States';


SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_backup2;

UPDATE layoffs_backup2
SET `date`=STR_TO_DATE(`date`,'%m/%d/%Y');

SELECT `date`
FROM layoffs_backup2;

ALTER TABLE layoffs_backup2
MODIFY COLUMN `date` DATE;

-- NULL AND BLANK VALUES

SELECT *
FROM layoffs_backup2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_backup2
WHERE industry IS NULL
OR industry='';

SELECT *
FROM layoffs_backup2
WHERE company ='Airbnb';

UPDATE layoffs_backup2
SET industry=NULL
WHERE industry ='';

SELECT *
FROM layoffs_backup2
WHERE industry ='' OR industry IS NULL;

SELECT t1.industry,t2.industry
FROM layoffs_backup2 t1
JOIN layoffs_backup2 t2
	on t1.company=t2.company
WHERE (t1.industry IS NULL OR t1.industry ='')
AND t2.industry IS NOT NULL;


UPDATE layoffs_backup2 t1
JOIN layoffs_backup2 t2
	ON t1.company=t2.company
SET t1.industry =t2.industry
WHERE (t1.industry IS NULL OR t1.industry ='')
AND t2.industry IS NOT NULL;


select company,industry
from layoffs_backup2;


SELECT *
FROM layoffs_backup2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoffs_backup2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_backup2;

ALTER TABLE layoffs_backup2
DROP COLUMN row_no;