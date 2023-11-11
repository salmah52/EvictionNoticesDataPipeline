-- Create a table with aggregated monthly eviction statistics
--CREATE OR REPLACE TABLE aggregated_monthly_evictions AS

{{ config(materialized='view') }}

With monthly_eviction as (
SELECT
    EXTRACT(YEAR FROM file_date) AS year,
    --EXTRACT(MONTH FROM date_id) AS month,
    COUNT(*) AS total_evictions
FROM
    {{ ref('stg_eviction') }}
GROUP BY
    year
    --month
ORDER BY
    year
)

SELECT * from monthly_eviction