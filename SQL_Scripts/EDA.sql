USE world_layoffs;

select *
from layoffs_backup2;

SELECT *
FROM layoffs_backup2
ORDER BY total_laid_off DESC;

SELECT company ,SUM(total_laid_off)
FROM layoffs_backup2
GROUP BY company
ORDER BY 2 DESC;

SELECT industry,SUM(total_laid_off)
FROM layoffs_backup2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country,SUM(total_laid_off)
FROM layoffs_backup2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_backup2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


SELECT stage,SUM(total_laid_off)
FROM layoffs_backup2
GROUP BY stage
ORDER BY 2 DESC;


SELECT SUBSTRING(`date`,1,7),SUM(total_laid_off)
FROM layoffs_backup2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY 1;



WITH rolling_total AS
(

SELECT SUBSTRING(`date`,1,7) as `Month` ,SUM(total_laid_off) AS total_off
FROM layoffs_backup2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC
)
SELECT `Month`,total_off, SUM(total_off) OVER(ORDER BY `Month`)as Rolling_sum 
FROM rolling_total;



SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_backup2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC;


WITH company_year(Company,Years,Total_laid_off) AS
(
	SELECT company,YEAR(`date`),SUM(total_laid_off)
	FROM layoffs_backup2
	GROUP BY company,YEAR(`date`)
	ORDER BY 3 DESC
), company_year_rank AS
( 
	SELECT *,
	DENSE_RANK() OVER(PARTITION BY `Years` ORDER BY Total_laid_off DESC) as Ranking
	FROM company_year
	WHERE years IS NOT NULL
	ORDER BY Ranking ASC
)
SELECT *
FROM company_year_rank
WHERE Ranking <=5
;