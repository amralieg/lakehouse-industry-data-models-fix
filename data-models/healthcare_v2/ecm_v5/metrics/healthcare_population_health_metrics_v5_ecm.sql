-- Metric views for domain: population_health | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_outcome_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Population health cohort outcome tracking metrics measuring quality measure performance, care gap closure, and patient engagement across value-based care programs."
  source: "`healthcare_ecm_v1`.`population_health`.`cohort_outcome_tracking`"
  dimensions:
    - name: "outcome_type"
      expr: outcome_type
      comment: "Type of clinical or quality outcome being tracked (e.g., clinical improvement, cost reduction, utilization)"
    - name: "measure_domain"
      expr: measure_domain
      comment: "Quality measure domain category (e.g., preventive care, chronic disease, behavioral health)"
    - name: "measure_code"
      expr: measure_code
      comment: "Specific quality measure identifier (e.g., HEDIS measure code) for drill-down analysis"
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of clinical or outreach intervention applied to close care gaps"
    - name: "risk_stratification_level"
      expr: risk_stratification_level
      comment: "Patient risk tier (high/medium/low) for stratified outcome analysis"
    - name: "patient_engagement_level"
      expr: patient_engagement_level
      comment: "Level of patient engagement in their care program for engagement-outcome correlation"
    - name: "cohort_outcome_tracking_status"
      expr: cohort_outcome_tracking_status
      comment: "Current status of the outcome tracking record (active, closed, excluded)"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Measurement reporting year for annual performance trending"
    - name: "gap_in_care_flag"
      expr: CAST(gap_in_care_flag AS STRING)
      comment: "Whether a gap in care exists for this patient-measure combination"
    - name: "value_based_contract_flag"
      expr: CAST(value_based_contract_flag AS STRING)
      comment: "Whether this outcome is tied to a value-based contract for financial impact analysis"
    - name: "sdoh_impact_flag"
      expr: CAST(sdoh_impact_flag AS STRING)
      comment: "Whether social determinants of health impact this outcome for equity analysis"
    - name: "measurement_period_start"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Measurement period start month for time-based performance trending"
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used to attribute patient to provider/program for attribution model comparison"
  measures:
    - name: "total_tracked_outcomes"
      expr: COUNT(1)
      comment: "Total number of patient-measure outcome tracking records for volume assessment"
    - name: "numerator_compliant_count"
      expr: SUM(CASE WHEN is_numerator_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients meeting numerator compliance criteria for quality measure rate calculation"
    - name: "denominator_eligible_count"
      expr: SUM(CASE WHEN is_denominator_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients eligible in measure denominator for rate calculation"
    - name: "care_gap_count"
      expr: SUM(CASE WHEN gap_in_care_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of open care gaps requiring intervention to improve quality scores"
    - name: "care_gap_closed_count"
      expr: SUM(CASE WHEN gap_in_care_flag = TRUE AND gap_closure_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of care gaps that have been successfully closed through intervention"
    - name: "avg_outcome_score"
      expr: AVG(CAST(outcome_score AS DOUBLE))
      comment: "Average outcome score across tracked patients for program effectiveness assessment"
    - name: "avg_improvement_percentage"
      expr: AVG(CAST(improvement_percentage AS DOUBLE))
      comment: "Average improvement percentage from baseline indicating program clinical impact"
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline clinical value before intervention for pre/post comparison"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value set for outcomes to assess goal-setting appropriateness"
    - name: "vbc_linked_outcomes"
      expr: SUM(CASE WHEN value_based_contract_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outcomes tied to value-based contracts for financial exposure quantification"
    - name: "sdoh_impacted_outcomes"
      expr: SUM(CASE WHEN sdoh_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outcomes impacted by social determinants for health equity program targeting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_refresh_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cohort refresh operational metrics tracking data pipeline health, refresh success rates, and membership volatility for population health program integrity."
  source: "`healthcare_ecm_v1`.`population_health`.`cohort_refresh_log`"
  dimensions:
    - name: "refresh_status"
      expr: refresh_status
      comment: "Status of the cohort refresh execution (success, failed, partial) for pipeline monitoring"
    - name: "refresh_type"
      expr: refresh_type
      comment: "Type of refresh (full, incremental, manual) for operational pattern analysis"
    - name: "trigger_source"
      expr: trigger_source
      comment: "What triggered the refresh (scheduled, manual, event-driven) for automation assessment"
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system providing data for the refresh for integration monitoring"
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective month of the refresh for temporal trending"
    - name: "validation_passed_flag"
      expr: CAST(validation_passed_flag AS STRING)
      comment: "Whether data validation passed for quality assurance monitoring"
    - name: "risk_stratification_applied_flag"
      expr: CAST(risk_stratification_applied_flag AS STRING)
      comment: "Whether risk stratification was applied during refresh"
    - name: "care_gap_refresh_flag"
      expr: CAST(care_gap_refresh_flag AS STRING)
      comment: "Whether care gap data was refreshed in this cycle"
  measures:
    - name: "total_refreshes"
      expr: COUNT(1)
      comment: "Total number of cohort refresh executions for pipeline activity monitoring"
    - name: "successful_refreshes"
      expr: SUM(CASE WHEN refresh_status = 'completed' OR refresh_status = 'success' THEN 1 ELSE 0 END)
      comment: "Count of successful refresh executions for reliability tracking"
    - name: "failed_refreshes"
      expr: SUM(CASE WHEN refresh_status = 'failed' OR refresh_status = 'error' THEN 1 ELSE 0 END)
      comment: "Count of failed refresh executions requiring investigation"
    - name: "avg_execution_duration_seconds"
      expr: AVG(CAST(execution_duration_seconds AS DOUBLE))
      comment: "Average refresh execution time in seconds for performance monitoring and SLA tracking"
    - name: "total_members_added"
      expr: SUM(CAST(members_added_count AS DOUBLE))
      comment: "Total members added across all refreshes indicating cohort growth"
    - name: "total_members_removed"
      expr: SUM(CAST(members_removed_count AS DOUBLE))
      comment: "Total members removed across all refreshes indicating cohort attrition"
    - name: "avg_net_membership_change"
      expr: AVG(CAST(members_added_count - members_removed_count AS DOUBLE))
      comment: "Average net membership change per refresh for cohort stability assessment"
    - name: "total_records_evaluated"
      expr: SUM(CAST(records_evaluated_count AS DOUBLE))
      comment: "Total records evaluated across refreshes for data processing volume monitoring"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average data quality score across refreshes for data integrity trending"
    - name: "validation_failure_count"
      expr: SUM(CASE WHEN validation_passed_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of refreshes that failed validation for data quality alerting"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_cohort_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidated cohort management metrics providing executive-level view of population health program performance rates, benchmark comparisons, and cohort sizing for value-based care steering."
  source: "`healthcare_ecm_v1`.`population_health`.`population_health_population_health_cohort_management`"
  dimensions:
    - name: "dynamic_cohort_refresh_frequency"
      expr: dynamic_cohort_definition_refresh_frequency
      comment: "How frequently the dynamic cohort is refreshed for operational cadence analysis"
  measures:
    - name: "total_managed_cohort_records"
      expr: COUNT(1)
      comment: "Total cohort management records representing active population health tracking volume"
    - name: "avg_performance_rate"
      expr: AVG(CAST(cohort_outcome_tracking_performance_rate AS DOUBLE))
      comment: "Average quality measure performance rate across all cohorts for executive VBC scorecard"
    - name: "avg_benchmark_rate"
      expr: AVG(CAST(cohort_outcome_tracking_benchmark_rate AS DOUBLE))
      comment: "Average benchmark rate for comparison against actual performance"
    - name: "total_numerator_count"
      expr: SUM(CAST(cohort_outcome_tracking_numerator_count AS DOUBLE))
      comment: "Aggregate numerator count across all managed cohorts for program-level quality reporting"
    - name: "total_denominator_count"
      expr: SUM(CAST(cohort_outcome_tracking_denominator_count AS DOUBLE))
      comment: "Aggregate denominator count across all managed cohorts for program-level quality reporting"
    - name: "avg_target_population_size"
      expr: AVG(CAST(dynamic_cohort_definition_target_population_size AS DOUBLE))
      comment: "Average target population size across dynamic cohort definitions for capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`population_health_dynamic_cohort_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic cohort definition metrics tracking cohort configuration health, evaluation cadence, and risk model utilization for population health program governance."
  source: "`healthcare_ecm_v1`.`population_health`.`population_health_dynamic_cohort_definition`"
  dimensions:
    - name: "cohort_type"
      expr: cohort_type
      comment: "Type of cohort (disease-based, utilization-based, risk-based) for program portfolio analysis"
    - name: "status"
      expr: status
      comment: "Current status of the cohort definition (active, draft, retired) for lifecycle management"
    - name: "evaluation_frequency"
      expr: evaluation_frequency
      comment: "How often the cohort is re-evaluated for operational planning"
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source feeding the cohort for integration architecture analysis"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the cohort for regional program management"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the cohort definition for resource allocation decisions"
    - name: "risk_model_name"
      expr: risk_model_name
      comment: "Name of the risk model used for stratification methodology comparison"
    - name: "sdoh_criteria_flag"
      expr: CAST(sdoh_criteria_flag AS STRING)
      comment: "Whether SDOH criteria are included in cohort definition for equity program tracking"
    - name: "is_current_version"
      expr: CAST(is_current_version AS STRING)
      comment: "Whether this is the current active version of the definition"
  measures:
    - name: "total_cohort_definitions"
      expr: COUNT(1)
      comment: "Total number of dynamic cohort definitions for program portfolio sizing"
    - name: "active_cohort_definitions"
      expr: SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of actively running cohort definitions for operational load assessment"
    - name: "avg_risk_score_threshold"
      expr: AVG(CAST(risk_score_threshold AS DOUBLE))
      comment: "Average risk score threshold across definitions for risk model calibration assessment"
    - name: "sdoh_inclusive_definitions"
      expr: SUM(CASE WHEN sdoh_criteria_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cohort definitions incorporating SDOH criteria for health equity program coverage"
    - name: "irb_approved_definitions"
      expr: SUM(CASE WHEN is_irb_approved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of IRB-approved cohort definitions for research governance compliance"
$$;