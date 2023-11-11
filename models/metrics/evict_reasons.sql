{{ config(materialized='view') }}


WITH evictiondist  AS (


  SELECT

    SUM(CASE WHEN non_payment THEN 1 ELSE 0 END) AS non_payment_count,
    SUM(CASE WHEN breach THEN 1 ELSE 0 END) AS breach_count,
    SUM(CASE WHEN nuisance THEN 1 ELSE 0 END) AS nuisance_count,
    SUM(CASE WHEN illegal_use THEN 1 ELSE 0 END) AS illegal_use_count,
    SUM(CASE WHEN failure_to_sign_renewal THEN 1 ELSE 0 END) AS failure_to_sign_renewal_count,
    SUM(CASE WHEN access_denial THEN 1 ELSE 0 END) AS access_denial_count,
    SUM(CASE WHEN unapproved_subtenant THEN 1 ELSE 0 END) AS unapproved_subtenant_count,
    SUM(CASE WHEN owner_move_in THEN 1 ELSE 0 END) AS owner_move_in_count,
    SUM(CASE WHEN demolition THEN 1 ELSE 0 END) AS demolition_count,
    SUM(CASE WHEN capital_improvement THEN 1 ELSE 0 END) AS capital_improvement_count,
    SUM(CASE WHEN substantial_rehab THEN 1 ELSE 0 END) AS substantial_rehab_count,
    SUM(CASE WHEN ellis_act_withdrawal THEN 1 ELSE 0 END) AS ellis_act_withdrawal_count,
    SUM(CASE WHEN condo_conversion THEN 1 ELSE 0 END) AS condo_conversion_count,
    SUM(CASE WHEN roommate_same_unit THEN 1 ELSE 0 END) AS roommate_same_unit_count,
    SUM(CASE WHEN other_cause THEN 1 ELSE 0 END) AS other_cause_count,
    SUM(CASE WHEN late_payments THEN 1 ELSE 0 END) AS late_payments_count,
    SUM(CASE WHEN lead_remediation THEN 1 ELSE 0 END) AS lead_remediation_count,
    SUM(CASE WHEN development THEN 1 ELSE 0 END) AS development_count,
    SUM(CASE WHEN good_samaritan_ends THEN 1 ELSE 0 END) AS good_samaritan_ends_count
  FROM {{ ref('stg_eviction') }}
)
SELECT * FROM evictiondist
