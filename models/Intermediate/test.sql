WITH latest_eviction AS
(
   SELECT *,
   row_number() over (partition by eviction_id order by file_date DESC) as rn
   FROM {{ ref('stg_eviction') }}
)
SELECT *
FROM latest_eviction
WHERE rn = 1


