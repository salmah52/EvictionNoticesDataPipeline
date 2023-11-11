SELECT
    supervisor_district,
    COUNT(*) AS eviction_count
FROM
    dbt_eviction008.fact_eviction
GROUP BY
    supervisor_district
ORDER BY
    eviction_count DESC

 

