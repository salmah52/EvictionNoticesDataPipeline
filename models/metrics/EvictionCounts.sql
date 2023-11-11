{{ config(materialized='view') }}


WITH evictioncounts  AS (
SELECT COUNT(*) as eviction_id
FROM {{ ref('stg_eviction') }}
)

SELECT *
FROM evictioncounts

