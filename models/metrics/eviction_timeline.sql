

{{ config(materialized='view') }}


WITH 
eviction_case_timeline AS
(

SELECT DATE_TRUNC(file_date, MONTH) as month, COUNT(*) as cases_count
FROM {{ ref('stg_eviction') }}
GROUP BY month
ORDER BY cases_count desc
)
select * from eviction_case_timeline
