USE ROLE USERADMIN;

CREATE ROLE IF NOT EXISTS job_ads_dlt_role;


USE ROLE SECURITYADMIN;

-- can have different ingestions tools e.g. dlt, airbyte, fivetran, ...
GRANT ROLE job_ads_dlt_role TO USER extract_loader;

GRANT USAGE ON WAREHOUSE dev_wh TO ROLE job_ads_dlt_role;
GRANT USAGE ON DATABASE job_ads TO ROLE job_ads_dlt_role;
GRANT USAGE ON SCHEMA job_ads.staging TO ROLE job_ads_dlt_role;
GRANT CREATE TABLE ON SCHEMA job_ads.staging TO ROLE job_ads_dlt_role;

GRANT SELECT, INSERT,
UPDATE,
DELETE ON ALL TABLES IN SCHEMA job_ads.staging TO ROLE job_ads_dlt_role;
GRANT SELECT, INSERT,
UPDATE,
DELETE ON FUTURE TABLES IN SCHEMA job_ads.staging TO ROLE job_ads_dlt_role;

USE ROLE JOB_ADS_DBT_ROLE;

SELECT * FROM job_ads.staging.data_field_job_ads LIMIT 10;

-- check grants
SHOW GRANTS ON SCHEMA job_ads.staging;
SHOW FUTURE GRANTS IN SCHEMA job_ads.staging;

SHOW GRANTS TO ROLE job_ads_dlt_role;

SHOW GRANTS TO USER extract_loader;

GRANT ROLE job_ads_dlt_role TO USER ATTAPONSAYOD2;