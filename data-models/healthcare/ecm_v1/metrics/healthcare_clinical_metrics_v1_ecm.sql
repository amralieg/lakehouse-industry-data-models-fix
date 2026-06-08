-- Metric views for domain: clinical | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_procedure_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of clinical procedures"
  source: "`healthcare_ecm`.`clinical`.`procedure_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site where the procedure occurred"
    - name: "procedure_month"
      expr: DATE_TRUNC('month', procedure_date)
      comment: "Month of the procedure date"
  measures:
    - name: "total_procedure_charge"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total dollar amount charged for procedures"
    - name: "average_procedure_charge"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per procedure record"
    - name: "procedure_count"
      expr: COUNT(1)
      comment: "Number of procedure events recorded"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_care_plan_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key quality indicators for care plans"
  source: "`healthcare_ecm`.`clinical`.`care_plan`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the care plan"
    - name: "care_plan_type"
      expr: plan_type
      comment: "Type/category of the care plan"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the care plan became effective"
    - name: "readmission_risk_level"
      expr: readmission_risk_level
      comment: "Risk level for patient readmission"
  measures:
    - name: "care_plan_count"
      expr: COUNT(1)
      comment: "Total number of care plans"
    - name: "advance_directive_on_file_count"
      expr: SUM(CASE WHEN advance_directive_on_file THEN 1 ELSE 0 END)
      comment: "Count of care plans with an advance directive on file"
    - name: "patient_consent_obtained_count"
      expr: SUM(CASE WHEN patient_consent_obtained THEN 1 ELSE 0 END)
      comment: "Count of care plans where patient consent was obtained"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_observation_numeric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates for numeric clinical observations"
  source: "`healthcare_ecm`.`clinical`.`observation`"
  dimensions:
    - name: "loinc_code_id"
      expr: loinc_code_id
      comment: "LOINC code identifying the observation type"
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the observation (e.g., final, preliminary)"
  measures:
    - name: "avg_numeric_value"
      expr: AVG(CAST(value_numeric AS DOUBLE))
      comment: "Average numeric observation value"
    - name: "observation_count"
      expr: COUNT(1)
      comment: "Number of observation records"
$$;