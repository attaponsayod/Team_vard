WITH stg_job_ads AS (selec * from ref {{ source('job_ads', 'stage_data_ads') }})

SELECT id, 
        employer__name AS employer_name, 
        employer__workplace AS employer_workplace.
        workplace_address__city AS workplace_city
FROM stg_job_ads