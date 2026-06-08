-- Metric views for domain: population_health_cohort | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_cohort_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health cohort membership metrics tracking patient enrollment, retention, and exclusion patterns across cohort definitions for population health management and value-based care program oversight."
  source: "`healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_membership`"
  dimensions:
    - name: "membership_status"
      expr: population_health_cohort_cohort_membership_status
      comment: "Current membership status (active, inactive, excluded) for filtering cohort participation"
    - name: "inclusion_reason"
      expr: inclusion_reason
      comment: "Reason patient was included in cohort - used to analyze cohort composition drivers"
    - name: "exclusion_reason"
      expr: exclusion_reason
      comment: "Reason patient was excluded from cohort - used to identify systematic exclusion patterns"
    - name: "membership_start_year"
      expr: YEAR(membership_start_date)
      comment: "Year of cohort membership start for temporal trend analysis"
    - name: "membership_start_month"
      expr: DATE_TRUNC('MONTH', membership_start_date)
      comment: "Month of cohort membership start for enrollment trend tracking"
    - name: "membership_end_month"
      expr: DATE_TRUNC('MONTH', membership_end_date)
      comment: "Month of cohort membership end for attrition analysis"
  measures:
    - name: "total_cohort_members"
      expr: COUNT(1)
      comment: "Total number of cohort membership records - baseline for population health program sizing and resource allocation"
    - name: "distinct_patients_enrolled"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients enrolled across all cohorts - measures population health program reach and patient coverage"
    - name: "distinct_cohort_definitions"
      expr: COUNT(DISTINCT population_health_cohort_cohort_definition_id)
      comment: "Number of distinct cohort definitions with active memberships - measures program breadth"
    - name: "active_members"
      expr: COUNT(CASE WHEN population_health_cohort_cohort_membership_status = 'active' THEN 1 END)
      comment: "Count of currently active cohort members - primary operational metric for population health program capacity"
    - name: "excluded_members"
      expr: COUNT(CASE WHEN population_health_cohort_cohort_membership_status = 'excluded' THEN 1 END)
      comment: "Count of excluded members - monitors exclusion rates that may indicate equity or access issues"
    - name: "members_with_risk_scores"
      expr: COUNT(DISTINCT CASE WHEN clinical_ai_patient_risk_score_id IS NOT NULL THEN mpi_record_id END)
      comment: "Patients with linked AI risk scores - measures integration between population health and clinical AI for risk stratification"
    - name: "avg_membership_duration_days"
      expr: AVG(CAST(DATEDIFF(COALESCE(membership_end_date, CURRENT_DATE()), membership_start_date) AS DOUBLE))
      comment: "Average duration of cohort membership in days - measures patient retention in population health programs and program engagement longevity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_cohort_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cohort definition management metrics tracking the health system's population segmentation strategy, definition freshness, and operational readiness of cohort criteria."
  source: "`healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_cohort_definition`"
  dimensions:
    - name: "cohort_status"
      expr: population_health_cohort_cohort_definition_status
      comment: "Status of cohort definition (draft, active, retired) for lifecycle management"
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How often the cohort is refreshed - indicates operational cadence and data currency requirements"
    - name: "created_year"
      expr: YEAR(created_at)
      comment: "Year cohort definition was created for program maturity analysis"
    - name: "created_by"
      expr: created_by
      comment: "User who created the cohort definition - for governance and accountability tracking"
  measures:
    - name: "total_cohort_definitions"
      expr: COUNT(1)
      comment: "Total cohort definitions - measures breadth of population health segmentation strategy"
    - name: "active_cohort_definitions"
      expr: COUNT(CASE WHEN population_health_cohort_cohort_definition_status = 'active' THEN 1 END)
      comment: "Active cohort definitions currently in use - measures operational population health program scope"
    - name: "ai_linked_definitions"
      expr: COUNT(CASE WHEN clinical_ai_model_card_id IS NOT NULL THEN 1 END)
      comment: "Cohort definitions linked to AI model cards - measures AI governance integration in population health programs"
    - name: "avg_days_since_last_refresh"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), CAST(last_refresh_at AS DATE)) AS DOUBLE))
      comment: "Average days since last cohort refresh - monitors data staleness risk for population health interventions; stale cohorts may miss at-risk patients"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_dynamic_cohort_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic cohort definition metrics tracking AI-driven automated population segmentation, evaluation freshness, and cohort sizing for real-time population health management."
  source: "`healthcare_ecm_v1`.`population_health_cohort`.`population_health_cohort_dynamic_cohort_definition`"
  dimensions:
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the dynamic cohort is currently active - for filtering operational vs retired cohorts"
    - name: "created_by"
      expr: created_by
      comment: "Creator of the dynamic cohort for governance and ownership tracking"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_at)
      comment: "Month of dynamic cohort creation for program growth tracking"
  measures:
    - name: "total_dynamic_cohorts"
      expr: COUNT(1)
      comment: "Total dynamic cohort definitions - measures adoption of AI-driven automated population segmentation"
    - name: "active_dynamic_cohorts"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Currently active dynamic cohorts - operational capacity of real-time population health automation"
    - name: "total_dynamic_cohort_members"
      expr: SUM(CAST(member_count AS DOUBLE))
      comment: "Total patients across all dynamic cohorts - measures scale of AI-driven population health coverage"
    - name: "avg_dynamic_cohort_size"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average member count per dynamic cohort - indicates typical population segment size for resource planning"
    - name: "max_dynamic_cohort_size"
      expr: MAX(member_count)
      comment: "Largest dynamic cohort member count - identifies highest-impact population segments requiring most resources"
    - name: "avg_days_since_evaluation"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), CAST(last_evaluated_at AS DATE)) AS DOUBLE))
      comment: "Average days since last evaluation - monitors freshness of dynamic cohort membership; stale evaluations risk missing newly at-risk patients"
    - name: "ai_linked_dynamic_cohorts"
      expr: COUNT(CASE WHEN clinical_ai_dynamic_cohort_definition_id IS NOT NULL THEN 1 END)
      comment: "Dynamic cohorts linked to clinical AI definitions - measures integration depth between population health and AI governance layer"
$$;