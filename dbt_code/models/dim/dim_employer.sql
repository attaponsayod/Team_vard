WITH src_employer AS (SELECT * FROM {{ ref('src_employer') }})

SELECT  
    {{ dbt.dbt_utils.generate_surrogate_key(['id', 'employer_name']) }} AS employer_id
    employer_name,
    workplace_city
FROM src_employer