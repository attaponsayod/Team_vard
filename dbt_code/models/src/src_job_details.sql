WITH stg_job_ads AS (SELECT * 
                     FROM {{ source ( 'job_ads', 'stg_data_ads') }})

SELECT
    id,
    headline,
    descruption__text AS "DESCRIPTION",
    descruption__text_formatted AS description_html_formatted,
    employment_type__label AS employment_type,
    duration__label AS duration,
    salary_type__label AS salary_type,
    scope_of_work__min AS scope_of_work_min,
    scope_of_work__min AS scope_of_work_max
FROM stg_job_ads 