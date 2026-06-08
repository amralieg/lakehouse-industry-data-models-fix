-- Metric views for domain: patient | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_demographics`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core patient population broken down by key demographic attributes"
  source: "`healthcare_ecm`.`patient`.`demographics`"
  dimensions:
    - name: "gender_identity"
      expr: gender_identity
      comment: "Self‑identified gender of the patient"
    - name: "race_code"
      expr: race_code
      comment: "Race classification code"
    - name: "age_bucket"
      expr: FLOOR(DATEDIFF(current_date(), birth_date) / 365)
      comment: "Patient age in years, bucketed as integer years"
  measures:
    - name: "patient_count"
      expr: COUNT(1)
      comment: "Total number of patients in the demographics table"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_expected_los`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Length‑of‑stay planning KPI derived from registration events"
  source: "`healthcare_ecm`.`patient`.`registration_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where the patient was admitted"
    - name: "admission_type"
      expr: admission_type
      comment: "Admission classification (e.g., emergency, elective)"
  measures:
    - name: "avg_expected_los_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay (in days) across admissions"
    - name: "total_expected_los_days"
      expr: SUM(CAST(expected_los_days AS DOUBLE))
      comment: "Total expected length of stay (in days) for all admissions"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_financial_assistance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial assistance effectiveness and volume"
  source: "`healthcare_ecm`.`patient`.`financial_assistance`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the assistance request"
    - name: "program_type"
      expr: program_type
      comment: "Type of assistance program (e.g., charity, grant)"
    - name: "application_status"
      expr: application_status
      comment: "Current status of the assistance application"
  measures:
    - name: "total_assistance_amount"
      expr: SUM(CAST(approved_assistance_amount AS DOUBLE))
      comment: "Total dollar amount of financial assistance approved"
    - name: "average_assistance_amount"
      expr: AVG(CAST(approved_assistance_amount AS DOUBLE))
      comment: "Average assistance amount per approved case"
    - name: "assistance_case_count"
      expr: COUNT(1)
      comment: "Number of financial assistance cases"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_population_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk stratification metrics for population management"
  source: "`healthcare_ecm`.`patient`.`population_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Logical segment classification (e.g., chronic, acute)"
  measures:
    - name: "total_patients"
      expr: COUNT(1)
      comment: "Total patients in the population segment table"
    - name: "high_risk_patient_count"
      expr: SUM(CASE WHEN hcc_risk_score > 20 THEN 1 ELSE 0 END)
      comment: "Count of patients with HCC risk score above 20 (high risk)"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average overall risk score for the segment"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_communication_success`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness of patient communications across channels"
  source: "`healthcare_ecm`.`patient`.`communication_log`"
  dimensions:
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for communication (e.g., SMS, Email)"
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (e.g., reminder, alert)"
  measures:
    - name: "total_messages"
      expr: COUNT(1)
      comment: "Total communication log entries"
    - name: "delivered_message_count"
      expr: SUM(CASE WHEN delivery_status = 'Delivered' THEN 1 ELSE 0 END)
      comment: "Number of messages successfully delivered"
    - name: "consented_message_count"
      expr: SUM(CASE WHEN consent_obtained_flag THEN 1 ELSE 0 END)
      comment: "Number of messages sent where patient consent was obtained"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`patient_flag_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical flag monitoring for safety and quality"
  source: "`healthcare_ecm`.`patient`.`flag`"
  dimensions:
    - name: "flag_type"
      expr: flag_type
      comment: "Category of the flag (e.g., allergy, infection)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the flag"
    - name: "flag_status"
      expr: flag_status
      comment: "Current status of the flag (Active, Resolved)"
  measures:
    - name: "total_flags"
      expr: COUNT(1)
      comment: "Total number of clinical flags recorded"
    - name: "active_flag_count"
      expr: SUM(CASE WHEN flag_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of flags currently active"
$$;