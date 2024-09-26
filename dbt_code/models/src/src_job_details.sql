WITH stg_job_ads AS (SELECT * 
                     FROM {{ source ( 'job_ads', 'stg_data_ads') }})

SELECT
    id,
    headline,
    description__text AS "DESCRIPTION",
    description__text_formatted AS description_html_formatted,
    employment_type__label AS employment_type,
    duration__label AS duration,
    salary_type__label AS salary_type,
    scope_of_work__min AS scope_of_work_min,
    scope_of_work__min AS scope_of_work_max,
    WORKING_HOURS_TYPE__LEGACY_AMS_TAXONOMY_ID AS working_hours_type,
    DRIVING_LICENSE_REQUIRED AS driving_license,
    ACCESS_TO_OWN_CAR AS access_to_car


FROM stg_job_ads 