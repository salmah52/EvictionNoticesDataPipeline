SELECT
    date_id,
    COUNT(*) AS eviction_count
FROM
   dbt_eviction008.fact_eviction
GROUP BY
    date_id
ORDER BY
    date_id
