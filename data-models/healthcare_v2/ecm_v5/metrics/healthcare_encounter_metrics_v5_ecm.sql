-- Metric views for domain: encounter | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core encounter visit metrics tracking patient throughput, length of stay, observation utilization, and readmission risk for operational and financial steering."
  source: "`healthcare_ecm_v1`.`encounter`.`visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (inpatient, outpatient, ED, observation) for volume segmentation"
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit for pipeline and census tracking"
    - name: "admission_type"
      expr: admission_type
      comment: "Admission type (elective, urgent, emergent) for capacity planning"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting classification for service line analysis"
    - name: "financial_class"
      expr: financial_class
      comment: "Financial class (commercial, Medicare, Medicaid, self-pay) for payer mix analysis"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition code for post-acute care and outcome analysis"
    - name: "admission_source"
      expr: admission_source
      comment: "Source of admission for referral pattern analysis"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_timestamp)
      comment: "Month of admission for trend analysis"
    - name: "admission_year"
      expr: YEAR(admission_timestamp)
      comment: "Year of admission for annual comparisons"
    - name: "is_readmission"
      expr: readmission_flag
      comment: "Whether the visit is a readmission for quality tracking"
    - name: "is_observation"
      expr: observation_status
      comment: "Whether the visit is observation status for two-midnight compliance"
    - name: "two_midnight_compliant"
      expr: two_midnight_compliant
      comment: "Two-midnight rule compliance flag for CMS audit readiness"
    - name: "drg_type"
      expr: drg_type
      comment: "DRG type (MS-DRG, APR-DRG) for reimbursement methodology segmentation"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of patient visits for volume tracking"
    - name: "avg_length_of_stay_days"
      expr: AVG(CAST(expected_los_days AS DOUBLE))
      comment: "Average expected length of stay in days for capacity and efficiency benchmarking"
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight indicating case mix index for revenue and acuity analysis"
    - name: "total_drg_weight"
      expr: SUM(CAST(drg_weight AS DOUBLE))
      comment: "Total DRG weight for aggregate case mix volume"
    - name: "avg_observation_hours"
      expr: AVG(CAST(observation_hours AS DOUBLE))
      comment: "Average observation hours per visit for two-midnight rule compliance monitoring"
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score for population risk stratification"
    - name: "readmission_count"
      expr: SUM(CASE WHEN readmission_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of readmission visits for HRRP penalty exposure tracking"
    - name: "observation_conversion_count"
      expr: SUM(CASE WHEN converted_to_inpatient = TRUE THEN 1 ELSE 0 END)
      comment: "Count of observation-to-inpatient conversions for utilization review"
    - name: "discharge_instructions_compliance_count"
      expr: SUM(CASE WHEN discharge_instructions_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Count of visits with discharge instructions issued for quality compliance"
    - name: "care_transition_plan_count"
      expr: SUM(CASE WHEN care_transition_plan_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of visits with completed care transition plans for transitions of care quality measure"
    - name: "telehealth_visit_count"
      expr: SUM(CASE WHEN telehealth_platform IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of telehealth visits for digital health adoption tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_readmission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Readmission analytics for HRRP penalty avoidance, root cause analysis, and care transition effectiveness measurement."
  source: "`healthcare_ecm_v1`.`encounter`.`readmission`"
  dimensions:
    - name: "readmission_type"
      expr: readmission_type
      comment: "Type of readmission (planned, unplanned) for CMS penalty applicability"
    - name: "readmission_status"
      expr: readmission_status
      comment: "Current status of readmission review workflow"
    - name: "hrrp_measure_category"
      expr: hrrp_measure_category
      comment: "HRRP measure category (AMI, HF, pneumonia, COPD, THA/TKA, CABG) for penalty exposure"
    - name: "is_hrrp_applicable"
      expr: is_hrrp_applicable
      comment: "Whether readmission falls under HRRP penalty program"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for intervention targeting"
    - name: "preventability_assessment"
      expr: preventability_assessment
      comment: "Preventability classification for quality improvement prioritization"
    - name: "payer_type"
      expr: payer_type
      comment: "Payer type for financial impact segmentation"
    - name: "risk_score_model"
      expr: risk_score_model
      comment: "Risk model used for score validation and model comparison"
    - name: "index_discharge_month"
      expr: DATE_TRUNC('MONTH', index_discharge_date)
      comment: "Month of index discharge for trend analysis"
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Whether SDOH factors contributed to readmission"
    - name: "aco_attributed"
      expr: aco_attributed
      comment: "Whether patient is attributed to an ACO for shared savings impact"
  measures:
    - name: "total_readmissions"
      expr: COUNT(1)
      comment: "Total readmission count for volume tracking and rate calculation"
    - name: "hrrp_applicable_readmissions"
      expr: SUM(CASE WHEN is_hrrp_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HRRP-applicable readmissions for CMS penalty exposure quantification"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average readmission risk score for population risk stratification"
    - name: "total_estimated_penalty_amount"
      expr: SUM(CAST(estimated_penalty_amount AS DOUBLE))
      comment: "Total estimated HRRP penalty dollars for financial impact assessment"
    - name: "avg_hrrp_excess_ratio"
      expr: AVG(CAST(hrrp_excess_readmission_ratio AS DOUBLE))
      comment: "Average HRRP excess readmission ratio for penalty threshold monitoring"
    - name: "medication_reconciliation_completed_count"
      expr: SUM(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count with medication reconciliation completed for care transition quality"
    - name: "follow_up_scheduled_count"
      expr: SUM(CASE WHEN follow_up_appointment_scheduled = TRUE THEN 1 ELSE 0 END)
      comment: "Count with follow-up appointments scheduled for transition of care compliance"
    - name: "transition_of_care_completed_count"
      expr: SUM(CASE WHEN transition_of_care_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count with completed transitions of care for quality measure reporting"
    - name: "sdoh_related_readmissions"
      expr: SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SDOH-related readmissions for social determinants intervention targeting"
    - name: "preventable_readmissions"
      expr: SUM(CASE WHEN preventability_assessment = 'preventable' THEN 1 ELSE 0 END)
      comment: "Count of preventable readmissions for quality improvement ROI calculation"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG assignment metrics for case mix index monitoring, revenue integrity, CDI program effectiveness, and LOS variance analysis."
  source: "`healthcare_ecm_v1`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "drg_description"
      expr: drg_description
      comment: "DRG description for service line and case type analysis"
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major Diagnostic Category for broad clinical grouping"
    - name: "mdc_description"
      expr: mdc_description
      comment: "MDC description for executive reporting"
    - name: "drg_version"
      expr: drg_version
      comment: "DRG version (MS-DRG, APR-DRG) for methodology comparison"
    - name: "cc_mcc_flag"
      expr: cc_mcc_flag
      comment: "CC/MCC flag indicating complication/comorbidity capture for CDI effectiveness"
    - name: "grouper_software"
      expr: grouper_software
      comment: "Grouper software used for system comparison"
    - name: "patient_type"
      expr: patient_type
      comment: "Patient type for volume segmentation"
    - name: "is_outlier"
      expr: is_outlier
      comment: "Outlier flag for cost outlier payment analysis"
    - name: "drg_changed_flag"
      expr: drg_changed_flag
      comment: "Whether DRG changed from initial assignment indicating CDI impact"
    - name: "grouping_month"
      expr: DATE_TRUNC('MONTH', grouping_date)
      comment: "Month of DRG grouping for trend analysis"
    - name: "provider_assignment_type"
      expr: provider_assignment_type
      comment: "Provider assignment type for attribution analysis"
  measures:
    - name: "total_drg_assignments"
      expr: COUNT(1)
      comment: "Total DRG assignments for volume tracking"
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight representing case mix index for revenue and acuity benchmarking"
    - name: "total_drg_weight"
      expr: SUM(CAST(drg_weight AS DOUBLE))
      comment: "Total DRG weight for aggregate case mix volume"
    - name: "avg_expected_reimbursement"
      expr: AVG(CAST(expected_reimbursement AS DOUBLE))
      comment: "Average expected reimbursement per case for revenue forecasting"
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement AS DOUBLE))
      comment: "Total expected reimbursement for revenue projection"
    - name: "total_outlier_payment"
      expr: SUM(CAST(outlier_payment AS DOUBLE))
      comment: "Total outlier payments for cost management"
    - name: "avg_actual_los"
      expr: AVG(CAST(actual_los AS DOUBLE))
      comment: "Average actual length of stay for efficiency benchmarking"
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean LOS for LOS variance analysis against CMS benchmarks"
    - name: "drg_change_count"
      expr: SUM(CASE WHEN drg_changed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DRG changes indicating CDI query effectiveness"
    - name: "cdi_query_response_count"
      expr: SUM(CASE WHEN cdi_query_response_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CDI query responses for CDI program productivity"
    - name: "avg_initial_vs_final_weight_delta"
      expr: AVG(CAST(drg_weight AS DOUBLE) - CAST(initial_drg_weight AS DOUBLE))
      comment: "Average DRG weight improvement from CDI for revenue capture effectiveness"
    - name: "outlier_case_count"
      expr: SUM(CASE WHEN is_outlier = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cost outlier cases for financial risk monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_triage_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency department triage metrics for throughput optimization, acuity distribution, and critical alert monitoring."
  source: "`healthcare_ecm_v1`.`encounter`.`triage_assessment`"
  dimensions:
    - name: "esi_level"
      expr: esi_level
      comment: "Emergency Severity Index level (1-5) for acuity distribution and staffing"
    - name: "triage_category"
      expr: triage_category
      comment: "Triage category for patient flow segmentation"
    - name: "triage_status"
      expr: triage_status
      comment: "Current triage status for workflow monitoring"
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Patient arrival mode (ambulance, walk-in, transfer) for resource planning"
    - name: "chief_complaint_code"
      expr: chief_complaint_code
      comment: "Standardized chief complaint for clinical pattern analysis"
    - name: "trauma_level"
      expr: trauma_level
      comment: "Trauma activation level for trauma center performance"
    - name: "isolation_type"
      expr: isolation_type
      comment: "Isolation type for infection control resource planning"
    - name: "triage_month"
      expr: DATE_TRUNC('MONTH', triage_timestamp)
      comment: "Month of triage for seasonal trend analysis"
    - name: "mental_health_flag"
      expr: mental_health_flag
      comment: "Mental health presentation flag for behavioral health resource planning"
    - name: "sepsis_alert_flag"
      expr: sepsis_alert_flag
      comment: "Sepsis alert triggered for early intervention compliance"
  measures:
    - name: "total_triage_assessments"
      expr: COUNT(1)
      comment: "Total triage assessments for ED volume tracking"
    - name: "avg_spo2_percent"
      expr: AVG(CAST(spo2_percent AS DOUBLE))
      comment: "Average SpO2 for respiratory acuity monitoring"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature for fever surveillance"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average patient weight for medication dosing population analysis"
    - name: "sepsis_alert_count"
      expr: SUM(CASE WHEN sepsis_alert_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sepsis alerts for SEP-1 bundle compliance tracking"
    - name: "stroke_alert_count"
      expr: SUM(CASE WHEN stroke_alert_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of stroke alerts for door-to-needle time monitoring"
    - name: "trauma_activation_count"
      expr: SUM(CASE WHEN trauma_activation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of trauma activations for trauma center volume and readiness"
    - name: "lwbs_count"
      expr: SUM(CASE WHEN lwbs_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Left without being seen count - key ED throughput and patient satisfaction indicator"
    - name: "isolation_required_count"
      expr: SUM(CASE WHEN isolation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count requiring isolation for infection control resource demand"
    - name: "mental_health_presentation_count"
      expr: SUM(CASE WHEN mental_health_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of mental health presentations for behavioral health resource planning"
    - name: "reassessment_count"
      expr: SUM(CASE WHEN triage_reassessment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of triage reassessments indicating acuity changes for quality monitoring"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge summary metrics for care transition quality, documentation compliance, and post-discharge follow-up effectiveness."
  source: "`healthcare_ecm_v1`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "summary_status"
      expr: summary_status
      comment: "Documentation status for completion compliance tracking"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition for post-acute care pathway analysis"
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Standardized discharge disposition code for CMS reporting"
    - name: "discharge_condition"
      expr: discharge_condition
      comment: "Patient condition at discharge for outcome analysis"
    - name: "functional_status_at_discharge"
      expr: functional_status_at_discharge
      comment: "Functional status for rehabilitation and post-acute care planning"
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month of discharge for trend analysis"
    - name: "source_system"
      expr: source_system
      comment: "Source system for multi-system integration monitoring"
  measures:
    - name: "total_discharge_summaries"
      expr: COUNT(1)
      comment: "Total discharge summaries for documentation volume tracking"
    - name: "avg_time_to_completion_hours"
      expr: AVG(CAST(time_to_completion_hours AS DOUBLE))
      comment: "Average hours to complete discharge summary for documentation timeliness compliance"
    - name: "medication_reconciliation_completed_count"
      expr: SUM(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count with medication reconciliation for patient safety quality measure"
    - name: "follow_up_scheduled_count"
      expr: SUM(CASE WHEN follow_up_scheduled = TRUE THEN 1 ELSE 0 END)
      comment: "Count with follow-up scheduled for transitions of care compliance"
    - name: "care_transition_plan_completed_count"
      expr: SUM(CASE WHEN care_transition_plan_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count with care transition plans for quality measure reporting"
    - name: "patient_education_provided_count"
      expr: SUM(CASE WHEN patient_education_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Count with patient education for engagement and readmission prevention"
    - name: "home_health_referral_count"
      expr: SUM(CASE WHEN home_health_referral_made = TRUE THEN 1 ELSE 0 END)
      comment: "Count with home health referrals for post-acute care coordination"
    - name: "discharge_instructions_issued_count"
      expr: SUM(CASE WHEN discharge_instructions_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Count with discharge instructions issued for regulatory compliance"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_visit_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedural volume, revenue, and quality metrics for surgical and interventional service line management."
  source: "`healthcare_ecm_v1`.`encounter`.`visit_procedure`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Procedure type for service line segmentation"
    - name: "procedure_status"
      expr: procedure_status
      comment: "Procedure status for workflow and completion tracking"
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for OR resource planning"
    - name: "asa_class"
      expr: asa_class
      comment: "ASA physical status classification for risk stratification"
    - name: "surgical_approach"
      expr: surgical_approach
      comment: "Surgical approach (open, laparoscopic, robotic) for technology utilization"
    - name: "laterality"
      expr: laterality
      comment: "Laterality for wrong-site surgery prevention tracking"
    - name: "wound_class"
      expr: wound_class
      comment: "Wound classification for surgical site infection risk"
    - name: "is_elective"
      expr: is_elective
      comment: "Elective vs emergent for scheduling and capacity analysis"
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month of procedure for volume trend analysis"
    - name: "body_site"
      expr: body_site
      comment: "Body site for clinical pattern and specialty analysis"
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total procedure count for surgical volume tracking"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total procedure charges for revenue analysis"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per procedure for pricing and margin analysis"
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs for physician productivity and compensation"
    - name: "avg_rvu_work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVUs per procedure for efficiency benchmarking"
    - name: "total_rvu_total"
      expr: SUM(CAST(rvu_total AS DOUBLE))
      comment: "Total RVUs (work + practice expense + malpractice) for comprehensive productivity"
    - name: "complication_count"
      expr: SUM(CASE WHEN complication_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of procedures with complications for quality and safety monitoring"
    - name: "cancellation_count"
      expr: SUM(CASE WHEN is_cancelled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cancelled procedures for OR utilization and scheduling efficiency"
    - name: "implant_procedure_count"
      expr: SUM(CASE WHEN implant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of implant procedures for supply chain and recall tracking"
    - name: "timeout_performed_count"
      expr: SUM(CASE WHEN timeout_performed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count with surgical timeout performed for patient safety compliance"
    - name: "consent_obtained_count"
      expr: SUM(CASE WHEN consent_obtained_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count with consent obtained for regulatory compliance tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_visit_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diagnosis coding metrics for HCC risk adjustment, DRG optimization, CDI effectiveness, and quality measure compliance."
  source: "`healthcare_ecm_v1`.`encounter`.`visit_diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Diagnosis type (admitting, principal, secondary) for coding analysis"
    - name: "coding_status"
      expr: coding_status
      comment: "Coding workflow status for HIM productivity"
    - name: "poa_indicator"
      expr: poa_indicator
      comment: "Present on admission indicator for HAC penalty program"
    - name: "cc_mcc_indicator"
      expr: cc_mcc_indicator
      comment: "CC/MCC indicator for DRG weight and CDI impact analysis"
    - name: "hcc_category_code"
      expr: hcc_category_code
      comment: "HCC category for risk adjustment factor analysis"
    - name: "diagnosis_source"
      expr: diagnosis_source
      comment: "Source of diagnosis for documentation quality analysis"
    - name: "drg_type"
      expr: drg_type
      comment: "DRG type for reimbursement methodology segmentation"
    - name: "coded_month"
      expr: DATE_TRUNC('MONTH', coded_date)
      comment: "Month coded for HIM productivity trending"
    - name: "is_primary"
      expr: primary_diagnosis_flag
      comment: "Whether this is the primary diagnosis"
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "SDOH-related diagnosis flag for social determinants capture rate"
  measures:
    - name: "total_diagnoses"
      expr: COUNT(1)
      comment: "Total diagnosis codes for coding volume and specificity tracking"
    - name: "hcc_flagged_count"
      expr: SUM(CASE WHEN hcc_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HCC-flagged diagnoses for risk adjustment revenue capture"
    - name: "drg_relevant_count"
      expr: SUM(CASE WHEN drg_relevance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DRG-relevant diagnoses for case mix optimization"
    - name: "hai_count"
      expr: SUM(CASE WHEN hai_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hospital-acquired infection diagnoses for patient safety"
    - name: "chronic_condition_count"
      expr: SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of chronic condition diagnoses for population health management"
    - name: "sdoh_diagnosis_count"
      expr: SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SDOH Z-code diagnoses for social determinants capture rate"
    - name: "quality_measure_relevant_count"
      expr: SUM(CASE WHEN quality_measure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of quality measure-relevant diagnoses for measure denominator identification"
    - name: "reportable_condition_count"
      expr: SUM(CASE WHEN reportable_condition_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reportable conditions for public health surveillance compliance"
    - name: "billable_diagnosis_count"
      expr: SUM(CASE WHEN bill_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of billable diagnoses for revenue integrity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_bed_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed management and capacity metrics for census optimization, throughput improvement, and patient flow management."
  source: "`healthcare_ecm_v1`.`encounter`.`bed_assignment`"
  dimensions:
    - name: "bed_type"
      expr: bed_type
      comment: "Bed type (ICU, med-surg, telemetry) for capacity segmentation"
    - name: "bed_class"
      expr: bed_class
      comment: "Bed class for resource categorization"
    - name: "unit_name"
      expr: unit_name
      comment: "Nursing unit name for unit-level capacity analysis"
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class for census type segmentation"
    - name: "adt_event_type"
      expr: adt_event_type
      comment: "ADT event type driving the assignment for flow analysis"
    - name: "is_isolation_bed"
      expr: is_isolation_bed
      comment: "Isolation bed flag for infection control capacity"
    - name: "is_telemetry_monitored"
      expr: is_telemetry_monitored
      comment: "Telemetry monitoring flag for monitored bed utilization"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission for seasonal capacity planning"
  measures:
    - name: "total_bed_assignments"
      expr: COUNT(1)
      comment: "Total bed assignments for throughput volume tracking"
    - name: "avg_los_days"
      expr: AVG(CAST(los_days AS DOUBLE))
      comment: "Average length of stay in days for bed turnover efficiency"
    - name: "total_los_days"
      expr: SUM(CAST(los_days AS DOUBLE))
      comment: "Total patient days for staffing and capacity planning"
    - name: "isolation_bed_count"
      expr: SUM(CASE WHEN is_isolation_bed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of isolation bed assignments for infection control demand"
    - name: "observation_status_count"
      expr: SUM(CASE WHEN is_observation_status = TRUE THEN 1 ELSE 0 END)
      comment: "Count of observation status assignments for two-midnight compliance"
    - name: "private_room_count"
      expr: SUM(CASE WHEN is_private_room = TRUE THEN 1 ELSE 0 END)
      comment: "Count of private room assignments for patient experience and revenue"
    - name: "telemetry_monitored_count"
      expr: SUM(CASE WHEN is_telemetry_monitored = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telemetry-monitored beds for equipment utilization"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_visit_provider`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider assignment metrics for physician productivity, MIPS eligibility tracking, and care team attribution."
  source: "`healthcare_ecm_v1`.`encounter`.`visit_provider`"
  dimensions:
    - name: "provider_role"
      expr: provider_role
      comment: "Provider role (attending, consulting, referring) for care team composition"
    - name: "provider_type"
      expr: provider_type
      comment: "Provider type (physician, NP, PA) for workforce mix analysis"
    - name: "provider_assignment_type"
      expr: provider_assignment_type
      comment: "Assignment type for attribution methodology"
    - name: "provider_assignment_status"
      expr: provider_assignment_status
      comment: "Assignment status for active coverage tracking"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for practice pattern analysis"
    - name: "specialty_at_assignment"
      expr: specialty_at_assignment
      comment: "Specialty at time of assignment for service line analysis"
    - name: "is_primary_provider"
      expr: is_primary_provider
      comment: "Primary provider flag for attribution"
    - name: "mips_eligible_flag"
      expr: mips_eligible_flag
      comment: "MIPS eligibility for quality reporting compliance"
    - name: "telehealth_flag"
      expr: telehealth_flag
      comment: "Telehealth encounter flag for virtual care adoption"
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of assignment for trend analysis"
  measures:
    - name: "total_provider_assignments"
      expr: COUNT(1)
      comment: "Total provider-visit assignments for workload distribution"
    - name: "total_rvu_work_units"
      expr: SUM(CAST(rvu_work_units AS DOUBLE))
      comment: "Total work RVU units for physician productivity and compensation"
    - name: "avg_rvu_work_units"
      expr: AVG(CAST(rvu_work_units AS DOUBLE))
      comment: "Average work RVUs per assignment for efficiency benchmarking"
    - name: "mips_eligible_count"
      expr: SUM(CASE WHEN mips_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of MIPS-eligible assignments for quality program compliance"
    - name: "primary_provider_count"
      expr: SUM(CASE WHEN is_primary_provider = TRUE THEN 1 ELSE 0 END)
      comment: "Count of primary provider assignments for panel size analysis"
    - name: "telehealth_assignment_count"
      expr: SUM(CASE WHEN telehealth_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telehealth assignments for virtual care adoption tracking"
    - name: "attending_of_record_count"
      expr: SUM(CASE WHEN is_attending_of_record = TRUE THEN 1 ELSE 0 END)
      comment: "Count of attending-of-record assignments for accountability tracking"
    - name: "locum_tenens_count"
      expr: SUM(CASE WHEN locum_tenens_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of locum tenens assignments for workforce gap and cost analysis"
    - name: "drg_attribution_count"
      expr: SUM(CASE WHEN drg_attribution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DRG-attributed assignments for revenue attribution"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior authorization metrics for denial prevention, payer turnaround monitoring, and revenue cycle efficiency."
  source: "`healthcare_ecm_v1`.`encounter`.`encounter_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization status (approved, denied, pending) for workflow management"
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization (prior auth, concurrent, retro) for process analysis"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level for turnaround time expectations"
    - name: "submission_method"
      expr: submission_method
      comment: "Submission method (electronic, fax, phone) for automation tracking"
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type for service category analysis"
    - name: "facility_service_type"
      expr: facility_service_type
      comment: "Service type for authorization requirement patterns"
    - name: "peer_to_peer_review_flag"
      expr: peer_to_peer_review_flag
      comment: "Whether peer-to-peer review was required for denial overturn analysis"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of authorization start for trend analysis"
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total authorization requests for volume and workload tracking"
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total authorized dollar amount for revenue assurance"
    - name: "avg_authorized_amount"
      expr: AVG(CAST(authorized_amount AS DOUBLE))
      comment: "Average authorized amount per request for financial planning"
    - name: "denied_count"
      expr: SUM(CASE WHEN authorization_status = 'denied' THEN 1 ELSE 0 END)
      comment: "Count of denied authorizations for denial management and appeal prioritization"
    - name: "approved_count"
      expr: SUM(CASE WHEN authorization_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved authorizations for success rate calculation"
    - name: "peer_to_peer_count"
      expr: SUM(CASE WHEN peer_to_peer_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count requiring peer-to-peer review for physician time burden analysis"
    - name: "extension_requested_count"
      expr: SUM(CASE WHEN extension_requested_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of extension requests for LOS management effectiveness"
    - name: "retro_auth_count"
      expr: SUM(CASE WHEN authorization_type = 'retro' OR retro_authorization_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of retrospective authorizations indicating process gaps"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`encounter_transfer_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient transfer metrics for EMTALA compliance, inter-facility coordination, and bed flow optimization."
  source: "`healthcare_ecm_v1`.`encounter`.`transfer_request`"
  dimensions:
    - name: "transfer_type"
      expr: transfer_type
      comment: "Transfer type (internal, external, inter-facility) for flow analysis"
    - name: "transfer_status"
      expr: transfer_status
      comment: "Transfer status for workflow completion tracking"
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Reason for transfer for clinical pattern analysis"
    - name: "level_of_care_required"
      expr: level_of_care_required
      comment: "Required level of care for capacity matching"
    - name: "acuity_level"
      expr: acuity_level
      comment: "Patient acuity for resource planning"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode (ground, air, wheelchair) for logistics planning"
    - name: "emtala_compliant"
      expr: emtala_compliant
      comment: "EMTALA compliance flag for regulatory risk monitoring"
    - name: "isolation_required"
      expr: isolation_required
      comment: "Isolation requirement for receiving unit preparation"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month of transfer request for trend analysis"
  measures:
    - name: "total_transfer_requests"
      expr: COUNT(1)
      comment: "Total transfer requests for inter-facility coordination volume"
    - name: "emtala_compliant_count"
      expr: SUM(CASE WHEN emtala_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of EMTALA-compliant transfers for regulatory compliance rate"
    - name: "emtala_non_compliant_count"
      expr: SUM(CASE WHEN emtala_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Count of EMTALA non-compliant transfers for immediate risk remediation"
    - name: "approval_required_count"
      expr: SUM(CASE WHEN approval_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count requiring approval for workflow burden analysis"
    - name: "bed_availability_confirmed_count"
      expr: SUM(CASE WHEN bed_availability_confirmed = TRUE THEN 1 ELSE 0 END)
      comment: "Count with bed availability confirmed for placement efficiency"
    - name: "consent_obtained_count"
      expr: SUM(CASE WHEN patient_consent_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Count with patient consent for compliance documentation"
    - name: "cancelled_transfer_count"
      expr: SUM(CASE WHEN transfer_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled transfers for process efficiency analysis"
    - name: "isolation_required_count"
      expr: SUM(CASE WHEN isolation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count requiring isolation for infection control coordination"
$$;