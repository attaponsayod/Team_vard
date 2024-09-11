SHOW ROLES;


USE ROLE JOB_ADS_DLT_ROLE;


USE SCHEMA job_ads.staging;


SHOW TABLES;

DESC TABLE data_field_job_ads;

USE WAREHOUSE dev_wh;

SELECT * FROM data_field_job_ads;


 SELECT
 relevance, 
 workplace_address__street_address, 
 workplace_address__postcode, 
 publication_date,
 webpage_url,
 source_type
 FROM data_field_job_ads LIMIT 5;



SELECT 
scope_of_work__min,
scope_of_work__max,
employer__name,
salary_type__label,
salary_description,
duration__label,
logo_url,
employer__workplace,
employer__name,
employer__url
FROM data_field_job_ads LIMIT 5;

SELECT
DISTINCT(salary_description) as different_salary_descriptions
FROM data_field_job_ads;