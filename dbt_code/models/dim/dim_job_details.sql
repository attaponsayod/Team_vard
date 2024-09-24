WITH src_job_details AS (SELECT * 
                         FROM {{ ref('src_job_details') }})

SELECT 
    {{ dbt_utils.generate_surrogate_key(['id', 'headline'])}} AS job_details_id,
    headline,
    description,
    description_html_formatted,
    employment_type,
    duration,
    salary_type,
    scope_of_work_min,
    scope_of_work_max,
        CASE
        WHEN working_hours_type = 1 THEN 'förmiddags skift'
        WHEN working_hours_type = 2 THEN 'eftermiddags skift'
        ELSE 'ej specificerad'
    END AS working_hours_type

FROM src_job_details