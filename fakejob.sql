create table public.fake_jobs_clean(
job_id serial primary key,
title text,
location text,
department text,
salary_range text,
employment_type text,
required_experience text,
required_education text,
industry text,
function text,
fraud int
);

select 
	count(*) as total_rows,
	count(distinct title)AS unique_titles,
	count(distinct location)AS unique_locations,
	count(distinct industry) AS unique_industries
FROM fake_jobs_clean;

SELECT 
    fraud,
    COUNT(*) AS total_jobs,
    ROUND( (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fake_jobs_clean)), 2 ) AS percentage
FROM fake_jobs_clean
GROUP BY fraud
ORDER BY fraud;

SELECT location,
	COUNT(*) AS total_fake_jobs
	FROM fake_jobs_clean
	WHERE fraud =1
	GROUP BY location
	ORDER BY total_fake_jobs DESC
	LIMIT 10;


SELECT title,
	COUNT (*) AS fake_count
	FROM fake_jobs_clean
	WHERE fraud =1
	GROUP BY title
	ORDER BY fake_count DESC
	LIMIT 10;

SELECT industry,
	SUM(CASE WHEN fraud = 1 THEN 1 ELSE 0 END)AS fake_jobs,
	COUNT(*)AS total_jobs,
	ROUND(SUM(CASE WHEN fraud=1 THEN 1 ELSE 0 END)*100.0 / COUNT(*),2)AS fake_percentage
	FROM fake_jobs_clean
	GROUP BY industry
	ORDER BY fake_percentage DESC
	LIMIT 10;

SELECT*
	FROM fake_jobs_clean
	WHERE fraud = 1
	AND location IN (
	SELECT location
	FROM fake_jobs_clean
	WHERE fraud = 1
	GROUP BY location
	ORDER BY COUNT(*)DESC
	LIMIT 5
);

SELECT 
	industry,
	fake_jobs,
	total_jobs,
	fake_percentage,
	RANK() OVER (ORDER BY fake_percentage DESC)AS rank_by_fraud
	FROM(
		SELECT
		industry,
		COUNT(*) AS total_jobs,
		SUM(CASE WHEN fraud = 1 THEN 1 ELSE 0 END)AS fake_jobs,
		ROUND(SUM(CASE WHEN fraud = 1 THEN 1 ELSE 0 END)*100.0/ COUNT(*), 2)AS fake_percentage
		FROM fake_jobs_clean
		GROUP BY industry
		)sub
		ORDER BY rank_by_fraud;


SELECT
	required_education,
	COUNT(*) AS total_jobs,
	SUM(CASE WHEN fraud =1 THEN 1 ELSE 0 END)AS fake_jobs,
	ROUND(SUM (CASE WHEN fraud =1 THEN 1 ELSE 0 END)*100.0/ COUNT(*), 2)AS fake_percentage
	FROM fake_jobs_clean
	GROUP BY required_education
	ORDER BY fake_percentage DESC;

SELECT 
	function,
	COUNT(*) AS total_jobs,
	SUM(CASE WHEN fraud =1 THEN 1 ELSE 0 END ) AS fake_jobs,
	ROUND(SUM(CASE WHEN fraud = 1 THEN 1 ELSE 0 END )*100.0/ COUNT(*),2 )AS fake_percentage
	FROM fake_jobs_clean
	GROUP BY function
	HAVING COUNT(*) > 10
	ORDER BY fake_percentage DESC;


SELECT 
	location,
	industry,
	COUNT(*)AS total_jobs,
	SUM(CASE WHEN fraud = 1 THEN 1 ELSE 0 END) AS fake_jobs,
	ROUND(SUM (CASE WHEN fraud = 1 THEN 1 ELSE 0 END)* 100.0/COUNT(*),2) AS fake_percentage
	FROM fake_jobs_clean
	GROUP BY location, industry
	HAVING COUNT(*)>5
	ORDER BY fake_percentage DESC
	LIMIT 15;

SELECT 
	 required_education,
	function,
	COUNT(*) AS total_jobs,
	SUM (CASE WHEN fraud = 1 THEN 1 ELSE 0 END)AS fake_jobs,
	ROUND(SUM(CASE WHEN fraud =1 THEN 1 ELSE 0 END)* 100.0/ COUNT(*), 2) AS fake_percentage
	FROM fake_jobs_clean
	GROUP BY  required_education, function
	HAVING COUNT(*) > 5
	ORDER BY fake_percentage DESC
	LIMIT 20;
	
	