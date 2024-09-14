-- models/my_model.sql
select
    column1,
    column2
from {{ source('job_ads', 'stg_data_ads') }}
where column1 > 0
