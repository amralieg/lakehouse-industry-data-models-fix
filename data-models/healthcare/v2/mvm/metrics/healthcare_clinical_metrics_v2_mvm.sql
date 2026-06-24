-- Metric views for domain: clinical | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 16:05:56

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical diagnosis KPIs tracking chronic disease burden, coding quality, complication rates, and CDI performance — core metrics for quality, risk adjustment, and revenue integrity programs."
  source: "`vibe_healthcare_v1`.`clinical`.`diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (e.g., primary, secondary, admitting) used to segment coding and quality metrics."
    - name: "care_setting"
      expr: care_setting
      comment: "Clinical setting where the diagnosis was recorded (inpatient, outpatient, ED) for site-of-care analysis."
    - name: "clinical_status"
      expr: clinical_status
      comment: "Active/resolved/inactive status of the diagnosis for prevalence and burden analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Confirmed, provisional, or differential status — critical for coding accuracy and quality reporting."
    - name: "severity"
      expr: severity
      comment: "Severity level of the diagnosis for acuity stratification and resource utilization analysis."
    - name: "coding_status"
      expr: coding_status
      comment: "Status of ICD coding workflow — used to track coding completion and revenue cycle performance."
    - name: "cdi_query_status"
      expr: cdi_query_status
      comment: "Clinical Documentation Improvement query status — tracks CDI program effectiveness."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Type of encounter associated with the diagnosis for encounter-level segmentation."
    - name: "diagnosis_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Month of diagnosis date for trend analysis of disease incidence over time."
    - name: "present_on_admission"
      expr: present_on_admission
      comment: "POA indicator — distinguishes hospital-acquired conditions from pre-existing diagnoses, critical for HAC reporting."
  measures:
    - name: "total_diagnoses"
      expr: COUNT(1)
      comment: "Total number of diagnosis records — baseline volume metric for disease burden and coding throughput."
    - name: "distinct_patients_diagnosed"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Number of unique patients with at least one diagnosis — measures population disease prevalence."
    - name: "chronic_condition_count"
      expr: SUM(CAST(chronic_condition_flag AS INT))
      comment: "Count of diagnoses flagged as chronic conditions — drives population health program enrollment and risk stratification."
    - name: "chronic_condition_rate"
      expr: ROUND(100.0 * SUM(CAST(chronic_condition_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses that are chronic conditions — key indicator of population chronic disease burden."
    - name: "principal_diagnosis_count"
      expr: SUM(CAST(principal_diagnosis_flag AS INT))
      comment: "Count of principal diagnoses — used for DRG assignment accuracy and reimbursement integrity."
    - name: "complication_comorbidity_count"
      expr: SUM(CAST(complication_comorbidity_flag AS INT))
      comment: "Count of diagnoses flagged as complications or comorbidities (CC/MCC) — directly impacts DRG weight and reimbursement."
    - name: "mcc_count"
      expr: SUM(CAST(mcc_flag AS INT))
      comment: "Count of Major Complication or Comorbidity (MCC) diagnoses — highest-impact DRG severity tier for revenue integrity."
    - name: "hac_count"
      expr: SUM(CAST(hac_flag AS INT))
      comment: "Count of Hospital-Acquired Condition (HAC) diagnoses — critical patient safety and CMS penalty risk metric."
    - name: "hac_rate"
      expr: ROUND(100.0 * SUM(CAST(hac_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of hospital-acquired conditions per total diagnoses — key patient safety quality indicator."
    - name: "cdi_query_flag_count"
      expr: SUM(CAST(cdi_query_flag AS INT))
      comment: "Number of diagnoses with an open CDI query — measures CDI program workload and documentation gap volume."
    - name: "sdoh_diagnosis_count"
      expr: SUM(CAST(sdoh_flag AS INT))
      comment: "Count of diagnoses with a Social Determinants of Health flag — supports population health equity reporting."
    - name: "quality_measure_diagnosis_count"
      expr: SUM(CAST(quality_measure_flag AS INT))
      comment: "Count of diagnoses tied to quality measures — used to track performance on value-based care quality programs."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_procedure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedure-level KPIs covering surgical volume, revenue, efficiency, and quality — essential for OR management, service line performance, and value-based care reporting."
  source: "`vibe_healthcare_v1`.`clinical`.`procedure_event`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type of procedure (surgical, diagnostic, therapeutic) for service line segmentation."
    - name: "procedure_category"
      expr: procedure_category
      comment: "Clinical category of the procedure for departmental and specialty-level performance analysis."
    - name: "procedure_status"
      expr: procedure_status
      comment: "Status of the procedure (completed, cancelled, in-progress) for throughput and cancellation analysis."
    - name: "service_line"
      expr: service_line
      comment: "Hospital service line (e.g., Cardiology, Orthopedics) for service line P&L and volume reporting."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used — relevant for OR cost modeling and anesthesia utilization reporting."
    - name: "wound_classification"
      expr: wound_classification
      comment: "Surgical wound classification (clean, contaminated, etc.) — key surgical quality and infection risk indicator."
    - name: "priority"
      expr: priority
      comment: "Procedure priority (elective, urgent, emergent) for capacity planning and scheduling optimization."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month of procedure for trend analysis of surgical volume and revenue over time."
    - name: "laterality"
      expr: laterality
      comment: "Laterality of the procedure (left, right, bilateral) for surgical accuracy and quality reporting."
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total number of procedure events — baseline volume metric for OR throughput and service line activity."
    - name: "distinct_patients_treated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients who received a procedure — measures procedural reach across the patient population."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total gross charges for all procedures — primary revenue integrity and service line financial performance metric."
    - name: "avg_charge_per_procedure"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per procedure — used for pricing benchmarking and service line margin analysis."
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work Relative Value Units (wRVUs) — the standard physician productivity and compensation metric in healthcare."
    - name: "avg_rvu_work_per_procedure"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average wRVU per procedure — benchmarks procedural complexity and physician productivity."
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total OR/procedure time in minutes — key input for OR utilization and capacity planning."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average procedure duration in minutes — used for OR scheduling efficiency and block time optimization."
    - name: "cancellation_count"
      expr: SUM(CASE WHEN procedure_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled procedures — measures OR efficiency loss and scheduling quality."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN procedure_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procedures cancelled — key OR operational quality metric tracked by surgical leadership."
    - name: "consent_obtained_count"
      expr: SUM(CAST(consent_obtained AS INT))
      comment: "Count of procedures with documented patient consent — compliance and patient safety quality indicator."
    - name: "timeout_compliance_count"
      expr: SUM(CAST(timeout_performed AS INT))
      comment: "Count of procedures where surgical timeout was performed — critical Joint Commission patient safety metric."
    - name: "timeout_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(timeout_performed AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procedures with surgical timeout performed — mandatory patient safety compliance KPI."
    - name: "specimen_collection_count"
      expr: SUM(CAST(specimen_collected AS INT))
      comment: "Count of procedures where a specimen was collected — supports pathology workflow and surgical quality tracking."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_vital_sign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vital sign monitoring KPIs covering abnormality rates, patient-reported data quality, and early warning score contributions — essential for clinical quality, deterioration detection, and nursing performance."
  source: "`vibe_healthcare_v1`.`clinical`.`vital_sign`"
  dimensions:
    - name: "observation_type"
      expr: observation_type
      comment: "Type of vital sign observation (e.g., blood pressure, heart rate, temperature) for clinical segmentation."
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the vital sign record (final, amended, entered-in-error) for data quality filtering."
    - name: "care_unit"
      expr: care_unit
      comment: "Clinical care unit where the vital sign was recorded — enables unit-level monitoring and staffing analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to obtain the vital sign (manual, automated, telemetry) for data quality stratification."
    - name: "ews_score_type"
      expr: ews_score_type
      comment: "Early Warning Score type (NEWS, MEWS, etc.) — used to track deterioration detection program performance."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measurement for the vital sign value — required for clinical interpretation and standardization."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of vital sign measurement for trend analysis of monitoring volume and abnormality rates."
    - name: "patient_position"
      expr: patient_position
      comment: "Patient position during measurement (supine, sitting, standing) — relevant for orthostatic vital sign analysis."
  measures:
    - name: "total_vital_sign_readings"
      expr: COUNT(1)
      comment: "Total number of vital sign readings — baseline metric for nursing documentation compliance and monitoring intensity."
    - name: "distinct_patients_monitored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with at least one vital sign recorded — measures monitoring program reach."
    - name: "abnormal_reading_count"
      expr: SUM(CAST(abnormal_flag AS INT))
      comment: "Count of vital sign readings flagged as abnormal — key clinical quality and patient deterioration risk metric."
    - name: "abnormal_reading_rate"
      expr: ROUND(100.0 * SUM(CAST(abnormal_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vital sign readings that are abnormal — tracks population acuity and early warning signal density."
    - name: "avg_numeric_value"
      expr: AVG(CAST(numeric_value AS DOUBLE))
      comment: "Average numeric vital sign value — used for population-level clinical benchmarking by vital sign type."
    - name: "patient_reported_reading_count"
      expr: SUM(CAST(is_patient_reported AS INT))
      comment: "Count of patient-reported vital signs — measures patient engagement in remote monitoring programs."
    - name: "patient_reported_rate"
      expr: ROUND(100.0 * SUM(CAST(is_patient_reported AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vital signs that are patient-reported — tracks remote patient monitoring adoption and engagement."
    - name: "telemetry_derived_count"
      expr: SUM(CAST(is_telemetry_derived AS INT))
      comment: "Count of telemetry-derived vital signs — measures continuous monitoring utilization in high-acuity units."
    - name: "avg_reference_range_high"
      expr: AVG(CAST(reference_range_high AS DOUBLE))
      comment: "Average upper reference range value — used for clinical threshold calibration and population benchmarking."
    - name: "avg_reference_range_low"
      expr: AVG(CAST(reference_range_low AS DOUBLE))
      comment: "Average lower reference range value — used for clinical threshold calibration and population benchmarking."
    - name: "supplemental_oxygen_avg_flow_rate"
      expr: AVG(CAST(supplemental_oxygen_flow_rate AS DOUBLE))
      comment: "Average supplemental oxygen flow rate — tracks respiratory support intensity across monitored patients."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical observation KPIs covering assessment scores, critical value rates, and SDOH screening — drives quality program performance, patient safety, and population health equity reporting."
  source: "`vibe_healthcare_v1`.`clinical`.`observation`"
  dimensions:
    - name: "observation_category"
      expr: category
      comment: "High-level category of the observation (vital-signs, laboratory, survey, etc.) for clinical domain segmentation."
    - name: "observation_subcategory"
      expr: subcategory
      comment: "Subcategory of the observation for granular clinical program analysis."
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the observation record (final, amended, preliminary) for data quality and completeness tracking."
    - name: "care_setting"
      expr: care_setting
      comment: "Clinical setting of the observation for site-of-care analysis."
    - name: "body_system"
      expr: body_system
      comment: "Body system associated with the observation for clinical domain and specialty reporting."
    - name: "assessment_tool"
      expr: assessment_tool
      comment: "Standardized assessment tool used (e.g., PHQ-9, GAD-7, AUDIT) — critical for behavioral health quality reporting."
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "Social Determinants of Health domain (food insecurity, housing, transportation) for equity program tracking."
    - name: "severity"
      expr: severity
      comment: "Severity level of the observation finding for acuity stratification."
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of observation for trend analysis of clinical assessment volume and critical value rates."
  measures:
    - name: "total_observations"
      expr: COUNT(1)
      comment: "Total number of clinical observations — baseline volume metric for clinical documentation and assessment throughput."
    - name: "distinct_patients_observed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with at least one clinical observation — measures assessment program reach."
    - name: "critical_value_count"
      expr: SUM(CAST(is_critical_value AS INT))
      comment: "Count of observations with critical values — key patient safety metric requiring immediate clinical action."
    - name: "critical_value_rate"
      expr: ROUND(100.0 * SUM(CAST(is_critical_value AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of observations with critical values — tracks patient safety alert burden and clinical response requirements."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average standardized assessment score (e.g., PHQ-9, pain scale) — tracks population-level clinical severity trends."
    - name: "avg_numeric_value"
      expr: AVG(CAST(value_numeric AS DOUBLE))
      comment: "Average numeric observation value — used for population clinical benchmarking by observation type."
    - name: "amended_observation_count"
      expr: SUM(CAST(is_amended AS INT))
      comment: "Count of amended observations — measures documentation correction burden and data quality issues."
    - name: "amended_observation_rate"
      expr: ROUND(100.0 * SUM(CAST(is_amended AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of observations that were amended — tracks clinical documentation accuracy and rework rate."
    - name: "sdoh_screening_count"
      expr: SUM(CASE WHEN sdoh_domain IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of observations with an SDOH domain recorded — measures SDOH screening program penetration."
    - name: "avg_reference_range_high"
      expr: AVG(CAST(reference_range_high AS DOUBLE))
      comment: "Average upper reference range for observations — supports clinical threshold and population norm analysis."
    - name: "avg_reference_range_low"
      expr: AVG(CAST(reference_range_low AS DOUBLE))
      comment: "Average lower reference range for observations — supports clinical threshold and population norm analysis."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan KPIs measuring population health program enrollment, care gap closure, readmission risk stratification, and patient consent — core metrics for value-based care and population health management."
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (chronic disease, preventive, transitional care) for program-level performance analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the care plan (active, completed, cancelled) for active population tracking."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting associated with the plan for site-of-care population health analysis."
    - name: "readmission_risk_level"
      expr: readmission_risk_level
      comment: "Readmission risk stratification level — critical for transitional care program targeting and resource allocation."
    - name: "population_health_program"
      expr: population_health_program
      comment: "Population health program the care plan is associated with — measures program enrollment and coverage."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition for transitional care planning and post-acute utilization analysis."
    - name: "intent"
      expr: intent
      comment: "Intent of the care plan (proposal, plan, order) for workflow stage analysis."
    - name: "authored_month"
      expr: DATE_TRUNC('MONTH', authored_date)
      comment: "Month the care plan was authored for trend analysis of care plan creation volume."
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Whether the care plan addresses SDOH needs — tracks equity-focused care planning penetration."
    - name: "behavioral_health_flag"
      expr: behavioral_health_flag
      comment: "Whether the care plan includes behavioral health components — measures integrated care program reach."
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total number of care plans — baseline metric for population health program enrollment volume."
    - name: "distinct_patients_with_care_plan"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Number of unique patients with at least one care plan — measures population health program reach."
    - name: "active_care_plan_count"
      expr: SUM(CASE WHEN plan_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active care plans — measures live population health program enrollment."
    - name: "sdoh_care_plan_count"
      expr: SUM(CAST(sdoh_flag AS INT))
      comment: "Count of care plans with SDOH flags — tracks equity-focused care planning and social needs program penetration."
    - name: "sdoh_care_plan_rate"
      expr: ROUND(100.0 * SUM(CAST(sdoh_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans addressing SDOH needs — key health equity program performance indicator."
    - name: "behavioral_health_care_plan_count"
      expr: SUM(CAST(behavioral_health_flag AS INT))
      comment: "Count of care plans with behavioral health components — measures integrated behavioral health program reach."
    - name: "patient_consent_obtained_count"
      expr: SUM(CAST(patient_consent_obtained AS INT))
      comment: "Count of care plans with documented patient consent — compliance and patient engagement quality metric."
    - name: "patient_consent_rate"
      expr: ROUND(100.0 * SUM(CAST(patient_consent_obtained AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans with patient consent obtained — tracks patient engagement and regulatory compliance."
    - name: "aco_attributed_care_plan_count"
      expr: SUM(CAST(aco_attributed AS INT))
      comment: "Count of care plans for ACO-attributed patients — measures ACO population management program coverage."
    - name: "transitions_of_care_plan_count"
      expr: SUM(CAST(transitions_of_care_flag AS INT))
      comment: "Count of care plans flagged for transitions of care — tracks post-discharge care coordination program volume."
    - name: "advance_directive_on_file_count"
      expr: SUM(CAST(advance_directive_on_file AS INT))
      comment: "Count of care plans where an advance directive is on file — measures advance care planning program penetration."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal KPIs measuring goal achievement rates, patient agreement, and SDOH-related goal tracking — essential for value-based care program effectiveness and population health outcome reporting."
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan_goal`"
  dimensions:
    - name: "goal_status"
      expr: goal_status
      comment: "Current status of the care plan goal (active, achieved, cancelled) for goal lifecycle tracking."
    - name: "achievement_status"
      expr: achievement_status
      comment: "Achievement status of the goal — directly measures care plan effectiveness and patient outcome attainment."
    - name: "goal_category_display"
      expr: goal_category_display
      comment: "Clinical category of the goal (e.g., blood pressure, weight, A1C) for disease management program analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the goal (high, medium, low) for care team workload and focus analysis."
    - name: "care_team_role"
      expr: care_team_role
      comment: "Role of the care team member responsible for the goal — measures accountability and role-based performance."
    - name: "expressed_by_type"
      expr: expressed_by_type
      comment: "Who expressed the goal (patient, clinician, care team) — tracks patient-centered goal-setting practices."
    - name: "sdoh_related"
      expr: sdoh_related
      comment: "Whether the goal is related to SDOH — measures social needs goal-setting in population health programs."
    - name: "care_gap_related"
      expr: care_gap_related
      comment: "Whether the goal is tied to a care gap — measures care gap closure program effectiveness."
    - name: "goal_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the goal was started for trend analysis of goal creation and program enrollment."
  measures:
    - name: "total_care_plan_goals"
      expr: COUNT(1)
      comment: "Total number of care plan goals — baseline metric for care management program activity and goal-setting volume."
    - name: "distinct_patients_with_goals"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Number of unique patients with at least one care plan goal — measures active care management program reach."
    - name: "achieved_goal_count"
      expr: SUM(CASE WHEN achievement_status = 'Achieved' THEN 1 ELSE 0 END)
      comment: "Count of goals with achieved status — primary outcome metric for care management program effectiveness."
    - name: "goal_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN achievement_status = 'Achieved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plan goals that have been achieved — top-line KPI for population health program outcomes."
    - name: "patient_agreement_count"
      expr: SUM(CAST(patient_agreement AS INT))
      comment: "Count of goals where the patient has agreed — measures patient engagement and shared decision-making quality."
    - name: "patient_agreement_rate"
      expr: ROUND(100.0 * SUM(CAST(patient_agreement AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goals with patient agreement — tracks patient-centered care and engagement program performance."
    - name: "sdoh_goal_count"
      expr: SUM(CAST(sdoh_related AS INT))
      comment: "Count of goals related to SDOH — measures social needs integration into care management programs."
    - name: "care_gap_goal_count"
      expr: SUM(CAST(care_gap_related AS INT))
      comment: "Count of goals tied to care gaps — measures care gap closure program activity and prioritization."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target clinical value across goals — used for population-level clinical target benchmarking."
    - name: "avg_current_value"
      expr: AVG(CAST(current_value AS DOUBLE))
      comment: "Average current clinical value across goals — measures population-level progress toward clinical targets."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_allergy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergy documentation KPIs covering drug allergy prevalence, severity distribution, and documentation quality — critical for patient safety, medication safety programs, and regulatory compliance."
  source: "`vibe_healthcare_v1`.`clinical`.`allergy`"
  dimensions:
    - name: "allergen_type"
      expr: allergen_type
      comment: "Type of allergen (drug, food, environmental, latex) for patient safety and medication safety segmentation."
    - name: "allergy_category"
      expr: category
      comment: "Category of the allergy record for clinical classification and safety reporting."
    - name: "clinical_status"
      expr: clinical_status
      comment: "Active/inactive/resolved status of the allergy for current medication safety decision support."
    - name: "criticality"
      expr: criticality
      comment: "Criticality level of the allergy (low, high, unable-to-assess) — drives alert severity in medication safety systems."
    - name: "severity"
      expr: severity
      comment: "Severity of the allergic reaction (mild, moderate, severe, life-threatening) for risk stratification."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the allergy (confirmed, unconfirmed, refuted) for data quality and safety reporting."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the allergy was recorded for site-of-care documentation quality analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Medication reconciliation status — tracks allergy reconciliation compliance at care transitions."
    - name: "onset_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Month of allergy onset for epidemiological trend analysis."
  measures:
    - name: "total_allergy_records"
      expr: COUNT(1)
      comment: "Total number of allergy records — baseline metric for allergy documentation volume and completeness."
    - name: "distinct_patients_with_allergies"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Number of unique patients with at least one documented allergy — measures allergy documentation program reach."
    - name: "drug_allergy_count"
      expr: SUM(CAST(is_no_known_drug_allergy AS INT))
      comment: "Count of records documenting no known drug allergies — measures NKDA documentation completeness for medication safety."
    - name: "no_known_allergy_count"
      expr: SUM(CAST(is_no_known_allergy AS INT))
      comment: "Count of patients with documented no known allergies (NKA) — measures allergy screening completeness."
    - name: "active_allergy_count"
      expr: SUM(CASE WHEN clinical_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active allergy records — measures live patient safety alert burden."
    - name: "high_criticality_allergy_count"
      expr: SUM(CASE WHEN criticality = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-criticality allergies — measures high-risk patient safety alert volume requiring clinical vigilance."
    - name: "high_criticality_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN criticality = 'High' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allergies classified as high criticality — tracks patient safety risk concentration in the population."
    - name: "override_event_count"
      expr: SUM(CASE WHEN alert_override_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of allergy alerts that were overridden — key medication safety metric for alert fatigue and override pattern analysis."
    - name: "data_quality_issue_count"
      expr: SUM(CAST(data_quality_flag AS INT))
      comment: "Count of allergy records with data quality flags — measures documentation quality and data integrity issues."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_immunization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Immunization KPIs covering vaccination rates, series completion, adverse reaction rates, and registry reporting compliance — essential for public health, quality measure performance, and regulatory reporting."
  source: "`vibe_healthcare_v1`.`clinical`.`immunization`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the immunization administration (completed, not given, historical) for coverage rate calculation."
    - name: "series_name"
      expr: series_name
      comment: "Name of the vaccine series (e.g., COVID-19, Influenza, HPV) for vaccine-specific coverage analysis."
    - name: "series_completion_status"
      expr: series_completion_status
      comment: "Whether the vaccine series is complete — measures full immunization coverage vs. partial series."
    - name: "vfc_eligibility_code"
      expr: vfc_eligibility_code
      comment: "Vaccines for Children (VFC) eligibility code — tracks publicly funded vaccination program utilization."
    - name: "funding_source_code"
      expr: funding_source_code
      comment: "Funding source for the vaccine — used for public health program cost and coverage reporting."
    - name: "administration_route_code"
      expr: administration_route_code
      comment: "Route of vaccine administration (IM, SC, oral) for clinical protocol compliance monitoring."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', vis_presentation_date)
      comment: "Month of VIS presentation date used as a proxy for administration month for immunization trend analysis."
  measures:
    - name: "total_immunizations"
      expr: COUNT(1)
      comment: "Total number of immunization records — baseline metric for vaccination program volume and throughput."
    - name: "distinct_patients_vaccinated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients who received at least one vaccine — measures vaccination program population reach."
    - name: "total_dose_quantity"
      expr: SUM(CAST(dose_quantity AS DOUBLE))
      comment: "Total vaccine doses administered — measures vaccination program throughput and supply utilization."
    - name: "avg_dose_quantity"
      expr: AVG(CAST(dose_quantity AS DOUBLE))
      comment: "Average dose quantity per immunization record — used for dosing protocol compliance monitoring."
    - name: "reaction_observed_count"
      expr: SUM(CAST(reaction_observed AS INT))
      comment: "Count of immunizations where an adverse reaction was observed — key vaccine safety surveillance metric."
    - name: "reaction_rate"
      expr: ROUND(100.0 * SUM(CAST(reaction_observed AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of immunizations with an observed adverse reaction — vaccine safety quality indicator."
    - name: "vaers_reported_count"
      expr: SUM(CAST(vaers_reported AS INT))
      comment: "Count of adverse reactions reported to VAERS — measures regulatory reporting compliance for vaccine safety."
    - name: "iis_reported_count"
      expr: SUM(CAST(iis_reported AS INT))
      comment: "Count of immunizations reported to the Immunization Information System (IIS/registry) — measures public health reporting compliance."
    - name: "iis_reporting_rate"
      expr: ROUND(100.0 * SUM(CAST(iis_reported AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of immunizations reported to the IIS — tracks immunization registry reporting compliance rate."
    - name: "consent_obtained_count"
      expr: SUM(CAST(consent_obtained AS INT))
      comment: "Count of immunizations with documented patient consent — measures vaccination consent compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_problem`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Problem list KPIs measuring chronic disease burden, HCC capture rates, and problem list quality — critical for risk adjustment, value-based care performance, and population health management."
  source: "`vibe_healthcare_v1`.`clinical`.`problem`"
  dimensions:
    - name: "problem_status"
      expr: problem_status
      comment: "Status of the problem (active, resolved, inactive) for current disease burden analysis."
    - name: "problem_type"
      expr: problem_type
      comment: "Type of problem (chronic, acute, social) for disease classification and program targeting."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the problem was documented for site-of-care quality analysis."
    - name: "severity"
      expr: severity
      comment: "Severity of the problem for acuity stratification and resource allocation."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the problem (confirmed, provisional) for data quality and coding accuracy."
    - name: "hcc_category_code"
      expr: hcc_category_code
      comment: "Hierarchical Condition Category (HCC) code — directly drives CMS risk adjustment scores and capitation payments."
    - name: "laterality"
      expr: laterality
      comment: "Laterality of the problem for surgical and procedural planning accuracy."
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Whether the problem is SDOH-related — tracks social needs documentation on the problem list."
    - name: "noted_month"
      expr: DATE_TRUNC('MONTH', noted_date)
      comment: "Month the problem was noted for trend analysis of new problem documentation."
  measures:
    - name: "total_problems"
      expr: COUNT(1)
      comment: "Total number of problem list entries — baseline metric for problem list completeness and documentation volume."
    - name: "distinct_patients_with_problems"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with at least one problem documented — measures problem list coverage."
    - name: "active_problem_count"
      expr: SUM(CASE WHEN problem_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active problems — measures live disease burden across the patient population."
    - name: "chronic_problem_count"
      expr: SUM(CAST(chronic_condition_flag AS INT))
      comment: "Count of chronic condition problems — key metric for chronic disease management program targeting."
    - name: "chronic_problem_rate"
      expr: ROUND(100.0 * SUM(CAST(chronic_condition_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of problems that are chronic conditions — measures chronic disease burden concentration in the population."
    - name: "hcc_coded_problem_count"
      expr: SUM(CASE WHEN hcc_category_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of problems with an HCC category code — measures HCC capture completeness for risk adjustment revenue."
    - name: "hcc_capture_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hcc_category_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of problems with HCC codes captured — critical risk adjustment and revenue integrity KPI."
    - name: "principal_problem_count"
      expr: SUM(CAST(principal_problem_flag AS INT))
      comment: "Count of problems flagged as principal — used for DRG assignment accuracy and coding quality."
    - name: "sdoh_problem_count"
      expr: SUM(CAST(sdoh_flag AS INT))
      comment: "Count of SDOH-related problems on the problem list — measures social needs documentation and equity program reach."
    - name: "cdi_query_flag_count"
      expr: SUM(CAST(cdi_query_flag AS INT))
      comment: "Count of problems with open CDI queries — measures CDI program workload and documentation gap volume."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical note KPIs measuring documentation volume, CDI query rates, late entry rates, and DRG impact — essential for revenue integrity, coding quality, and clinical documentation program performance."
  source: "`vibe_healthcare_v1`.`clinical`.`note`"
  dimensions:
    - name: "note_type"
      expr: note_type
      comment: "Type of clinical note (H&P, progress note, discharge summary, consult) for documentation workflow analysis."
    - name: "note_status"
      expr: note_status
      comment: "Status of the note (signed, unsigned, amended, in-progress) for documentation completion tracking."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the note was authored for site-of-care documentation quality analysis."
    - name: "author_role"
      expr: author_role
      comment: "Role of the note author (attending, resident, NP, PA) for provider-level documentation performance analysis."
    - name: "service_line"
      expr: service_line
      comment: "Service line associated with the note for departmental documentation quality reporting."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Type of encounter for the note for encounter-level documentation analysis."
    - name: "dictation_method"
      expr: dictation_method
      comment: "Method used to create the note (dictation, direct entry, voice recognition) for workflow efficiency analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service for trend analysis of clinical documentation volume over time."
  measures:
    - name: "total_notes"
      expr: COUNT(1)
      comment: "Total number of clinical notes — baseline metric for documentation volume and provider productivity."
    - name: "distinct_patients_with_notes"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Number of unique patients with at least one clinical note — measures documentation coverage across the patient population."
    - name: "unsigned_note_count"
      expr: SUM(CASE WHEN note_status = 'Unsigned' THEN 1 ELSE 0 END)
      comment: "Count of unsigned notes — measures documentation completion backlog and compliance risk."
    - name: "late_entry_count"
      expr: SUM(CAST(is_late_entry AS INT))
      comment: "Count of late entry notes — measures documentation timeliness compliance and potential billing risk."
    - name: "late_entry_rate"
      expr: ROUND(100.0 * SUM(CAST(is_late_entry AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of notes entered late — tracks documentation timeliness quality and regulatory compliance risk."
    - name: "cdi_query_flag_count"
      expr: SUM(CAST(cdi_query_flag AS INT))
      comment: "Count of notes with CDI queries — measures CDI program activity and documentation improvement workload."
    - name: "drg_impact_note_count"
      expr: SUM(CAST(drg_impact_flag AS INT))
      comment: "Count of notes flagged for DRG impact — measures revenue integrity documentation opportunities identified."
    - name: "drg_impact_rate"
      expr: ROUND(100.0 * SUM(CAST(drg_impact_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of notes with DRG impact flags — tracks revenue integrity documentation opportunity density."
    - name: "addendum_count"
      expr: SUM(CAST(is_addendum AS INT))
      comment: "Count of addendum notes — measures documentation amendment volume and potential coding correction activity."
$$;