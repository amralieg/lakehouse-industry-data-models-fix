-- Metric views for domain: population_health_cohort_management | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_management_cohort_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for population health cohort definitions - tracks cohort portfolio health, refresh cadence, and population targeting effectiveness for value-based care programs."
  source: "`healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_definition`"
  dimensions:
    - name: "cohort_type"
      expr: cohort_type_code
      comment: "Classification of cohort purpose (e.g., chronic disease management, high-risk, quality measure, research) for portfolio analysis"
    - name: "cohort_status"
      expr: status_code
      comment: "Current lifecycle status of the cohort definition (active, draft, retired) for operational readiness assessment"
    - name: "refresh_frequency"
      expr: refresh_frequency_code
      comment: "How often the cohort membership is recalculated (daily, weekly, monthly) indicating operational cadence"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the cohort definition became effective for trending cohort creation over time"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the cohort definition became effective for granular trending"
  measures:
    - name: "total_cohort_definitions"
      expr: COUNT(1)
      comment: "Total number of cohort definitions in the portfolio - baseline for understanding population health program breadth"
    - name: "active_cohort_definitions"
      expr: COUNT(CASE WHEN status_code = 'active' THEN 1 END)
      comment: "Number of actively maintained cohort definitions driving current population health interventions"
    - name: "avg_target_population_size"
      expr: AVG(CAST(target_population_size AS DOUBLE))
      comment: "Average intended population size across cohorts - indicates scale of population health programs and resource planning needs"
    - name: "total_target_population_coverage"
      expr: SUM(CAST(target_population_size AS DOUBLE))
      comment: "Sum of all target population sizes across active cohorts - represents total patient reach of population health programs (note: patients may appear in multiple cohorts)"
    - name: "stale_cohort_count"
      expr: COUNT(CASE WHEN DATEDIFF(CURRENT_DATE(), last_refresh_ts) > 30 THEN 1 END)
      comment: "Number of cohorts not refreshed in over 30 days - identifies governance risk where clinical decisions may be based on outdated membership"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_management_cohort_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic metrics for cohort membership - tracks patient enrollment dynamics, risk stratification distribution, and membership lifecycle for population health management."
  source: "`healthcare_ecm_v1`.`population_health_cohort_management`.`population_health_cohort_management_cohort_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status_code
      comment: "Current membership status (active, excluded, graduated, expired) for understanding cohort composition and patient flow"
    - name: "inclusion_reason"
      expr: inclusion_reason_code
      comment: "Reason patient was included in cohort - identifies primary drivers of cohort qualification for intervention targeting"
    - name: "exclusion_reason"
      expr: exclusion_reason_code
      comment: "Reason patient was excluded from cohort - identifies barriers to care program enrollment and potential coverage gaps"
    - name: "membership_start_month"
      expr: DATE_TRUNC('MONTH', membership_start_date)
      comment: "Month of cohort enrollment for trending membership growth and seasonal patterns"
    - name: "membership_start_year"
      expr: YEAR(membership_start_date)
      comment: "Year of cohort enrollment for annual population health program growth analysis"
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total cohort membership records - represents aggregate patient-cohort assignments across all population health programs"
    - name: "active_memberships"
      expr: COUNT(CASE WHEN membership_status_code = 'active' THEN 1 END)
      comment: "Currently active cohort memberships - represents patients actively receiving population health interventions"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across cohort members - key indicator for resource allocation, care management staffing, and actuarial planning in value-based contracts"
    - name: "high_risk_member_count"
      expr: COUNT(CASE WHEN risk_score >= 3.0 THEN 1 END)
      comment: "Number of members with risk score >= 3.0 (high-risk threshold) - drives intensive care management program sizing and cost projections"
    - name: "graduated_member_count"
      expr: COUNT(CASE WHEN membership_status_code = 'graduated' THEN 1 END)
      comment: "Members who successfully graduated from cohort programs - measures population health intervention effectiveness and program ROI"
    - name: "excluded_member_count"
      expr: COUNT(CASE WHEN membership_status_code = 'excluded' THEN 1 END)
      comment: "Members excluded from cohorts - identifies potential access barriers or data quality issues requiring investigation"
    - name: "distinct_patients_managed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients under active population health management across all cohorts - true reach metric for enterprise population health programs"
    - name: "membership_churn_rate_numerator"
      expr: COUNT(CASE WHEN membership_status_code IN ('expired', 'excluded') AND DATEDIFF(CURRENT_DATE(), membership_end_date) <= 90 THEN 1 END)
      comment: "Members who exited cohorts in last 90 days (expired or excluded) - numerator for churn rate calculation when combined with total active memberships in BI layer"
$$;