-- Metric views for domain: quality | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`quality_accreditation_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation program performance metrics"
  source: "`healthcare_ecm`.`quality`.`accreditation_program`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site"
    - name: "program_name"
      expr: program_name
      comment: "Name of the accreditation program"
    - name: "program_type"
      expr: program_type
      comment: "Type of accreditation program"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the accreditation program became effective"
  measures:
    - name: "total_accreditations"
      expr: COUNT(1)
      comment: "Total number of accreditation program records"
    - name: "active_accreditations"
      expr: SUM(CASE WHEN expiration_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of currently active accreditations (expiration date in the future)"
    - name: "avg_readiness_score"
      expr: AVG(CAST(readiness_score AS DOUBLE))
      comment: "Average readiness score across accreditation programs"
    - name: "deemed_accreditations"
      expr: SUM(CASE WHEN deemed_status THEN 1 ELSE 0 END)
      comment: "Count of accreditations where deemed_status is true"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`quality_cahps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient experience (CAHPS) survey metrics"
  source: "`healthcare_ecm`.`quality`.`cahps_survey`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the survey was administered"
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan associated with the survey"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of CAHPS survey"
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey"
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of CAHPS surveys conducted"
    - name: "responded_surveys"
      expr: SUM(CASE WHEN response_received THEN 1 ELSE 0 END)
      comment: "Number of surveys with a response received"
    - name: "avg_linear_score"
      expr: AVG(CAST(hcahps_linear_mean_score AS DOUBLE))
      comment: "Average linear mean score across surveys"
    - name: "avg_care_transition_score"
      expr: AVG(CAST(score_care_transition AS DOUBLE))
      comment: "Average care transition score"
    - name: "avg_communication_doctors_score"
      expr: AVG(CAST(score_communication_doctors AS DOUBLE))
      comment: "Average doctor communication score"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`quality_hedis_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HEDIS measure performance metrics"
  source: "`healthcare_ecm`.`quality`.`hedis_measure`"
  dimensions:
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan linked to the HEDIS measure"
    - name: "measure_year"
      expr: measurement_year
      comment: "Year of the measurement period"
    - name: "clinical_area"
      expr: clinical_area
      comment: "Clinical area of the measure"
    - name: "measure_type"
      expr: measure_type
      comment: "Type/category of the measure"
  measures:
    - name: "total_measures"
      expr: COUNT(1)
      comment: "Total number of HEDIS measures defined"
    - name: "avg_target_performance_rate"
      expr: AVG(CAST(target_performance_rate AS DOUBLE))
      comment: "Average target performance rate across measures"
    - name: "avg_national_average_rate"
      expr: AVG(CAST(national_average_rate AS DOUBLE))
      comment: "Average national benchmark rate"
    - name: "avg_minimum_performance_threshold"
      expr: AVG(CAST(minimum_performance_threshold AS DOUBLE))
      comment: "Average minimum performance threshold"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`quality_patient_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient safety event metrics"
  source: "`healthcare_ecm`.`quality`.`patient_safety_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the safety event occurred"
    - name: "event_type"
      expr: event_type
      comment: "Category of the safety event"
    - name: "harm_level_code"
      expr: harm_level_code
      comment: "Harm level code for the event"
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of the safety event"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total patient safety events recorded"
    - name: "serious_events"
      expr: SUM(CASE WHEN harm_level_code = 'Serious' THEN 1 ELSE 0 END)
      comment: "Count of events classified as serious harm"
    - name: "cms_reportable_events"
      expr: SUM(CASE WHEN is_cms_reportable THEN 1 ELSE 0 END)
      comment: "Number of events reportable to CMS"
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(action_plan_due_date, DATE(event_timestamp)))
      comment: "Average number of days between event occurrence and action plan due date"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`quality_improvement_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Improvement initiative performance metrics"
  source: "`healthcare_ecm`.`quality`.`improvement_initiative`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the initiative"
    - name: "quality_program_id"
      expr: quality_program_id
      comment: "Quality program linked to the initiative"
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of the initiative"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the initiative started"
  measures:
    - name: "total_initiatives"
      expr: COUNT(1)
      comment: "Total number of improvement initiatives"
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline performance value"
    - name: "avg_current_performance_value"
      expr: AVG(CAST(current_performance_value AS DOUBLE))
      comment: "Average current performance value"
    - name: "avg_goal_value"
      expr: AVG(CAST(goal_value AS DOUBLE))
      comment: "Average goal performance value"
    - name: "cms_reportable_initiatives"
      expr: SUM(CASE WHEN is_cms_reportable THEN 1 ELSE 0 END)
      comment: "Count of initiatives that are CMS reportable"
$$;