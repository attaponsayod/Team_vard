WITH stg_job_ads AS (SELECT * 
                     FROM {{ source('job_ads', 'stg_data_ads') }})

SELECT *
    
FROM stg_job_ads
