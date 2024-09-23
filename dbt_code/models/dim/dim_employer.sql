WITH src_employer AS (SELECT * FROM {{ ref('src_employer') }})

SELECT  
    {{ dbt_utils.generate_surrogate_key(['id', 'employer_name']) }} AS employer_id,
    employer_name,
    employer_workplace,
    {{ capitalize_firs_letter("coalesce(workplace_city, 'stad ej specificerad')") }} AS workplace_city
FROM src_employer