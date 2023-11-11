--Eviction Reasons View:
--To create a view for the eviction reasons, you can use this SQL statement (assuming you have a column named eviction_reason):
-- Eviction Case Distribution by Neighborhood View:
--To create a view for the eviction case distribution by neighborhood, you can use this SQL statement
 --(assuming you have a column named neighborhood):

{{ config(materialized='view') }}


WITH evictiondist  AS (

SELECT neighborhood, COUNT(*) as cases_count
FROM {{ ref('stg_eviction') }}
GROUP BY neighborhood

)

SELECT *
FROM evictiondist
