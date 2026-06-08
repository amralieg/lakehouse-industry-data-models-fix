-- Metric views for domain: population_health_cohort_mgmt | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_mgmt_cohort_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for population health cohort definitions - tracks cohort portfolio health, refresh cadence, and active cohort management for population health program oversight."
  source: "`healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_definition`"
  dimensions:
    - name: "cohort_type"
      expr: cohort_type
      comment: "Type/category of cohort (e.g., chronic disease, high-risk, preventive) for segmenting population health program performance"
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How often the cohort membership is refreshed (daily, weekly, monthly) - indicates operational cadence of population health programs"
    - name: "is_active"
      expr: is_active
      comment: "Whether the cohort definition is currently active - distinguishes operational cohorts from retired/archived definitions"
    - name: "created_by"
      expr: created_by
      comment: "User or system that created the cohort definition - tracks ownership and accountability for population health programs"
    - name: "creation_year"
      expr: YEAR(created_at)
      comment: "Year the cohort was created - enables trending of population health program expansion over time"
  measures:
    - name: "total_cohort_definitions"
      expr: COUNT(1)
      comment: "Total number of cohort definitions - baseline measure of population health program breadth and investment"
    - name: "active_cohort_definitions"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active cohort definitions - indicates operational population health program scope driving care management resources"
    - name: "inactive_cohort_definitions"
      expr: SUM(CASE WHEN is_active = FALSE THEN 1 ELSE 0 END)
      comment: "Count of inactive/retired cohort definitions - tracks program lifecycle and potential technical debt in cohort management"
    - name: "active_cohort_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cohort definitions that are active - health indicator for population health program portfolio utilization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_mgmt_cohort_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core population health cohort membership metrics - tracks patient enrollment, retention, and cohort dynamics critical for care management resource planning and program effectiveness evaluation."
  source: "`healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_cohort_membership`"
  dimensions:
    - name: "is_current"
      expr: is_current
      comment: "Whether the membership is currently active - distinguishes current cohort members from historical for point-in-time census"
    - name: "inclusion_reason"
      expr: inclusion_reason
      comment: "Reason patient was included in cohort (e.g., diagnosis-based, risk-score-based, referral) - informs how patients enter population health programs"
    - name: "membership_start_year"
      expr: YEAR(membership_start_date)
      comment: "Year membership began - enables cohort growth trending and program enrollment velocity analysis"
    - name: "membership_start_month"
      expr: MONTH(membership_start_date)
      comment: "Month membership began - enables seasonal enrollment pattern analysis for resource planning"
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total cohort membership records - baseline volume of population health program participation across all cohorts"
    - name: "current_active_members"
      expr: SUM(CASE WHEN is_current = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active cohort members - real-time census of patients under active population health management driving staffing and intervention capacity"
    - name: "historical_members"
      expr: SUM(CASE WHEN is_current = FALSE THEN 1 ELSE 0 END)
      comment: "Count of members who have exited cohorts - tracks program throughput and graduation/attrition patterns"
    - name: "distinct_patients_in_cohorts"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients enrolled across all cohorts - true population reach of population health programs, accounting for patients in multiple cohorts"
    - name: "distinct_cohorts_with_members"
      expr: COUNT(DISTINCT population_health_cohort_mgmt_cohort_definition_id)
      comment: "Number of distinct cohorts that have membership - identifies which cohort definitions are actually populated and operational"
    - name: "member_retention_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_current = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all-time memberships that are currently active - proxy for cohort retention and program stickiness, key indicator of sustained engagement"
    - name: "avg_membership_duration_days"
      expr: AVG(CASE WHEN membership_end_date IS NOT NULL THEN DATEDIFF(membership_end_date, membership_start_date) ELSE NULL END)
      comment: "Average duration in days for completed memberships - measures typical program engagement length for care plan design and outcome measurement windows"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_mgmt_dynamic_cohort_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for AI-driven dynamic cohort definitions - monitors automated cohort refresh operations, member counts, and dynamic vs static cohort balance critical for scalable population health programs."
  source: "`healthcare_ecm_v1`.`population_health_cohort_mgmt`.`population_health_cohort_mgmt_dynamic_cohort_definition`"
  dimensions:
    - name: "is_dynamic"
      expr: is_dynamic
      comment: "Whether the cohort uses dynamic (auto-refreshing) membership criteria - distinguishes AI-driven cohorts from manually curated ones"
    - name: "evaluation_schedule"
      expr: evaluation_schedule
      comment: "Schedule for re-evaluating cohort membership (cron or frequency) - indicates operational burden and freshness of population health targeting"
  measures:
    - name: "total_dynamic_definitions"
      expr: COUNT(1)
      comment: "Total dynamic cohort definitions - measures investment in automated population health segmentation"
    - name: "active_dynamic_cohorts"
      expr: SUM(CASE WHEN is_dynamic = TRUE THEN 1 ELSE 0 END)
      comment: "Count of truly dynamic (auto-refreshing) cohort definitions - indicates maturity of AI-driven population health operations"
    - name: "total_members_across_dynamic_cohorts"
      expr: SUM(CAST(member_count AS DOUBLE))
      comment: "Sum of member counts across all dynamic cohorts - total patient population under automated population health management"
    - name: "avg_members_per_dynamic_cohort"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average number of members per dynamic cohort - indicates typical cohort size for care management team capacity planning"
    - name: "max_cohort_member_count"
      expr: MAX(member_count)
      comment: "Largest dynamic cohort by member count - identifies highest-volume population health programs requiring most resources"
    - name: "dynamic_cohort_ratio_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_dynamic = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cohort definitions that are dynamic - measures automation maturity of population health program, higher indicates more scalable operations"
$$;