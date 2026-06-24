-- Metric views for domain: clinical | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diagnosis coding quality, CDI, and DRG-relevance KPIs used by HIM, CDI, and quality leadership to monitor coding accuracy, complication/comorbidity capture, and hospital-acquired condition risk."
  source: "`vibe_healthcare_v1`.`clinical`.`diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (admitting, principal, secondary) for coding and reimbursement analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (inpatient, outpatient, ED) for stratifying coding quality."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Encounter type grouping for service-line analysis."
    - name: "coding_status"
      expr: coding_status
      comment: "Coding workflow status to monitor backlog and completion."
    - name: "diagnosis_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Month of diagnosis for trending volumes and quality over time."
  measures:
    - name: "Diagnosis Count"
      expr: COUNT(1)
      comment: "Total number of coded diagnoses; baseline volume for coding workload and quality denominators."
    - name: "Distinct Patients Diagnosed"
      expr: COUNT(DISTINCT visit_id)
      comment: "Distinct encounters with at least one diagnosis; drives population sizing for clinical programs."
    - name: "MCC Capture Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mcc_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of diagnoses flagged as Major Complication/Comorbidity; key driver of DRG reimbursement and CDI focus."
    - name: "HAC Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN hac_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of diagnoses flagged as hospital-acquired conditions; CMS penalty risk and patient-safety steering metric."
    - name: "CDI Query Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cdi_query_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of diagnoses generating a CDI query; signals documentation gaps and CDI workload."
    - name: "Chronic Condition Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN chronic_condition_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of diagnoses that are chronic conditions; informs population health and risk-adjustment strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_cdi_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical Documentation Integrity query performance and financial-impact KPIs for HIM/CDI leadership to track query response, agreement, and reimbursement uplift."
  source: "`vibe_healthcare_v1`.`clinical`.`cdi_query`"
  dimensions:
    - name: "query_type"
      expr: query_type
      comment: "Type of CDI query for categorizing documentation improvement opportunities."
    - name: "query_status"
      expr: query_status
      comment: "Current status of the query to monitor open/closed pipeline."
    - name: "query_outcome"
      expr: query_outcome
      comment: "Outcome of the query (agree, disagree, no change) for agreement-rate analysis."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Encounter type for service-line CDI performance breakdown."
    - name: "query_issue_month"
      expr: DATE_TRUNC('MONTH', query_issue_date)
      comment: "Month query was issued for trending CDI activity."
  measures:
    - name: "Query Count"
      expr: COUNT(1)
      comment: "Total CDI queries issued; baseline CDI productivity volume."
    - name: "Expected Reimbursement Impact"
      expr: SUM(CAST(expected_reimbursement_impact AS DOUBLE))
      comment: "Total expected reimbursement impact of queries; quantifies revenue opportunity from documentation improvement."
    - name: "Actual Reimbursement Impact"
      expr: SUM(CAST(actual_reimbursement_impact AS DOUBLE))
      comment: "Total realized reimbursement impact; measures financial value delivered by the CDI program."
    - name: "Query Opportunity Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN query_opportunity_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reviews surfacing a documentation opportunity; drives CDI staffing and targeting decisions."
    - name: "Coding Impact Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN coding_impact_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of queries that changed final coding; demonstrates CDI effectiveness in code accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_procedure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedure throughput, duration, and RVU/charge KPIs for perioperative and procedural-service leadership to manage capacity, productivity, and cost."
  source: "`vibe_healthcare_v1`.`clinical`.`procedure_event`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type of procedure for service-line and OR planning."
    - name: "procedure_category"
      expr: procedure_category
      comment: "Procedure category grouping for volume and resource analysis."
    - name: "service_line"
      expr: service_line
      comment: "Service line for productivity and margin steering."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for case-mix and staffing analysis."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month of procedure for volume trending."
  measures:
    - name: "Procedure Count"
      expr: COUNT(1)
      comment: "Total procedures performed; core volume KPI for capacity and throughput."
    - name: "Total Work RVU"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs generated; drives provider productivity and compensation analysis."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total procedural charges; informs revenue and pricing strategy."
    - name: "Avg Procedure Duration Minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average procedure duration; key driver of OR utilization and scheduling efficiency."
    - name: "Timeout Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN timeout_performed = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of procedures with a surgical timeout performed; patient-safety compliance metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_gap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care gap closure and outreach KPIs for population health and quality leadership to manage measure performance and patient outreach effectiveness."
  source: "`vibe_healthcare_v1`.`clinical`.`care_gap`"
  dimensions:
    - name: "gap_category"
      expr: gap_category
      comment: "Category of care gap for quality-measure grouping."
    - name: "gap_status"
      expr: gap_status
      comment: "Open/closed status of the gap to monitor closure pipeline."
    - name: "measure_program"
      expr: measure_program
      comment: "Quality program (HEDIS, MIPS) the gap is tied to."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the gap for outreach prioritization."
    - name: "identification_month"
      expr: DATE_TRUNC('MONTH', identification_date)
      comment: "Month the gap was identified for trending."
  measures:
    - name: "Care Gap Count"
      expr: COUNT(1)
      comment: "Total care gaps identified; baseline volume for population health workload."
    - name: "Patients With Gaps"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with open or closed gaps; population sizing for outreach."
    - name: "Gap Closure Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN closure_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of gaps closed; primary quality-measure performance KPI tied to VBP revenue."
    - name: "Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of gaps in measure compliance; drives quality bonus and contract performance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_hai_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Healthcare-associated infection KPIs for infection prevention and patient-safety leadership to monitor HAI burden and NHSN reporting compliance."
  source: "`vibe_healthcare_v1`.`clinical`.`hai_event`"
  dimensions:
    - name: "hai_type"
      expr: hai_type
      comment: "Type of healthcare-associated infection (CLABSI, CAUTI, etc.) for targeted prevention."
    - name: "organism_name"
      expr: organism_name
      comment: "Causative organism for surveillance and antibiogram analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of HAI event for trending infection rates."
  measures:
    - name: "HAI Event Count"
      expr: COUNT(1)
      comment: "Total HAI events; core patient-safety metric tied to CMS penalties and quality scores."
    - name: "Patients Affected"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with an HAI; quantifies patient-safety burden."
    - name: "NHSN Reporting Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN nhsn_reported = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of HAI events reported to NHSN; regulatory reporting compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_patient_risk_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Predictive risk-stratification KPIs for population health and clinical-AI leadership to monitor model-driven risk distribution and intervention targeting."
  source: "`vibe_healthcare_v1`.`clinical`.`patient_risk_score`"
  dimensions:
    - name: "risk_model_name"
      expr: risk_model_name
      comment: "Name of the risk model (readmission, sepsis, fall) for model-specific tracking."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier (high/medium/low) for stratifying patient populations."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category for intervention prioritization."
    - name: "score_status"
      expr: score_status
      comment: "Status of the risk score for active vs superseded analysis."
    - name: "score_month"
      expr: DATE_TRUNC('MONTH', score_event_timestamp)
      comment: "Month the score was generated for trending."
  measures:
    - name: "Risk Score Count"
      expr: COUNT(1)
      comment: "Total risk scores generated; baseline volume for model usage."
    - name: "Patients Scored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients scored; population coverage of risk stratification."
    - name: "Avg Risk Probability"
      expr: AVG(CAST(risk_probability AS DOUBLE))
      comment: "Average predicted risk probability; informs population risk burden and resource planning."
    - name: "Avg Comorbidity Index"
      expr: AVG(CAST(comorbidity_index_score AS DOUBLE))
      comment: "Average comorbidity index; drives care-management staffing and cost projections."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_model_inference_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical AI model inference operational KPIs for ML/AI governance leadership to monitor model performance, drift, and clinician adoption."
  source: "`vibe_healthcare_v1`.`clinical`.`model_inference_log`"
  dimensions:
    - name: "model_name"
      expr: model_name
      comment: "Name of the deployed model for per-model monitoring."
    - name: "model_task_type"
      expr: model_task_type
      comment: "Task type (classification, regression) for performance grouping."
    - name: "inference_status"
      expr: inference_status
      comment: "Status of the inference call to monitor failures."
    - name: "serving_environment"
      expr: serving_environment
      comment: "Serving environment for infrastructure analysis."
    - name: "inference_month"
      expr: DATE_TRUNC('MONTH', inference_timestamp)
      comment: "Month of inference for usage trending."
  measures:
    - name: "Inference Count"
      expr: COUNT(1)
      comment: "Total model inferences; baseline AI usage volume for governance and cost."
    - name: "Avg Confidence Score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence; signals model reliability and review-need."
    - name: "Clinician Override Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN clinician_override_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of inferences overridden by clinicians; key model-trust and adoption signal."
    - name: "Data Drift Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_drift_detected = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of inferences with detected data drift; triggers model retraining decisions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_allergy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergy documentation quality and safety KPIs for patient-safety and pharmacy leadership to monitor reconciliation and verification of allergy records."
  source: "`vibe_healthcare_v1`.`clinical`.`allergy`"
  dimensions:
    - name: "allergy_category"
      expr: allergy_category
      comment: "Category of allergy (drug, food, environmental) for safety analysis."
    - name: "criticality"
      expr: criticality
      comment: "Criticality of the allergy for high-risk patient identification."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status to monitor data quality."
    - name: "clinical_status"
      expr: clinical_status
      comment: "Clinical status (active, resolved) of the allergy."
    - name: "recorded_month"
      expr: DATE_TRUNC('MONTH', recorded_date)
      comment: "Month the allergy was recorded for trending."
  measures:
    - name: "Allergy Record Count"
      expr: COUNT(1)
      comment: "Total allergy records; baseline volume for medication-safety analysis."
    - name: "Reconciliation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_status = 'Reconciled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of allergies reconciled; medication-safety and care-transition KPI."
    - name: "Data Quality Issue Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_quality_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of allergy records flagged for data quality; drives data-governance remediation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal achievement KPIs for care-management and population-health leadership to monitor goal attainment and patient engagement."
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan_goal`"
  dimensions:
    - name: "goal_status"
      expr: goal_status
      comment: "Current status of the goal to monitor progress."
    - name: "achievement_status"
      expr: achievement_status
      comment: "Achievement status for outcome measurement."
    - name: "priority"
      expr: priority
      comment: "Priority of the goal for care-management prioritization."
    - name: "goal_category_display"
      expr: goal_category_display
      comment: "Goal category for clinical-domain grouping."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the goal started for trending."
  measures:
    - name: "Goal Count"
      expr: COUNT(1)
      comment: "Total care plan goals; baseline care-management workload."
    - name: "Goal Achievement Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN achieved_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of goals achieved; primary outcome KPI for care-management effectiveness."
    - name: "Patient Agreement Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_agreement = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of goals with patient agreement; patient-engagement and shared-decision metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical documentation timeliness and integrity KPIs for HIM and medical-staff leadership to monitor note signing, late entries, and CDI impact."
  source: "`vibe_healthcare_v1`.`clinical`.`note`"
  dimensions:
    - name: "note_type"
      expr: note_type
      comment: "Type of clinical note for documentation analysis."
    - name: "note_status"
      expr: note_status
      comment: "Status of the note (draft, signed) to monitor completion."
    - name: "author_role"
      expr: author_role
      comment: "Role of the note author for accountability analysis."
    - name: "service_line"
      expr: service_line
      comment: "Service line for documentation-performance breakdown."
    - name: "authored_month"
      expr: DATE_TRUNC('MONTH', authored_timestamp)
      comment: "Month note was authored for trending."
  measures:
    - name: "Note Count"
      expr: COUNT(1)
      comment: "Total clinical notes; baseline documentation volume."
    - name: "Late Entry Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_late_entry = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of notes entered late; documentation-timeliness compliance KPI."
    - name: "CDI Query Note Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cdi_query_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of notes generating a CDI query; identifies documentation-improvement focus areas."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key quality indicators for care plans"
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan`"
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

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_observation_numeric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates for numeric clinical observations"
  source: "`vibe_healthcare_v1`.`clinical`.`observation`"
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

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_procedure_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of clinical procedures"
  source: "`vibe_healthcare_v1`.`clinical`.`procedure_event`"
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