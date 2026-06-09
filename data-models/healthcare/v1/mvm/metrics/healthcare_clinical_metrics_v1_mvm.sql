-- Metric views for domain: clinical | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical diagnosis metrics tracking disease burden, chronic condition prevalence, coding quality, and principal diagnosis patterns across patient populations and care settings. Supports CMO, quality, and CDI program steering."
  source: "`healthcare_ecm`.`clinical`.`diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (e.g., admitting, working, final, discharge) used to segment disease burden by clinical context."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the diagnosis was recorded (e.g., inpatient, outpatient, ED) for cross-setting disease burden analysis."
    - name: "diagnosis_date_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Month of diagnosis date for trending disease incidence and coding volume over time."
    - name: "clinical_status"
      expr: clinical_status
      comment: "Clinical status of the diagnosis (e.g., active, resolved, inactive) to distinguish active disease burden from historical records."
    - name: "coding_status"
      expr: coding_status
      comment: "Coding completion status (e.g., coded, pending, queried) to monitor CDI and coding workflow performance."
    - name: "severity"
      expr: severity
      comment: "Severity level of the diagnosis for risk stratification and acuity-based analysis."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Type of encounter associated with the diagnosis (e.g., inpatient, ambulatory) for encounter-level disease analysis."
    - name: "present_on_admission"
      expr: present_on_admission
      comment: "Present-on-admission indicator for HAC (Hospital-Acquired Condition) surveillance and regulatory reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the diagnosis (e.g., confirmed, differential, suspected) for clinical accuracy tracking."
  measures:
    - name: "total_diagnoses"
      expr: COUNT(1)
      comment: "Total number of diagnosis records. Baseline volume metric for disease burden and coding throughput monitoring."
    - name: "distinct_patients_diagnosed"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Count of unique patients with at least one diagnosis. Core population health metric for disease prevalence reporting."
    - name: "chronic_condition_diagnoses"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE THEN 1 END)
      comment: "Number of diagnoses flagged as chronic conditions. Drives chronic disease management program investment and population health strategy."
    - name: "chronic_condition_patient_count"
      expr: COUNT(DISTINCT CASE WHEN chronic_condition_flag = TRUE THEN demographics_id END)
      comment: "Distinct patients with at least one chronic condition diagnosis. Key metric for chronic disease program enrollment and care management resource allocation."
    - name: "principal_diagnosis_count"
      expr: COUNT(CASE WHEN principal_diagnosis_flag = TRUE THEN 1 END)
      comment: "Number of principal diagnoses. Used for DRG assignment validation, case mix analysis, and reimbursement accuracy."
    - name: "hac_flagged_diagnoses"
      expr: COUNT(CASE WHEN hac_flag = TRUE THEN 1 END)
      comment: "Number of diagnoses flagged as Hospital-Acquired Conditions. Critical patient safety and regulatory compliance metric — HACs directly impact CMS reimbursement penalties."
    - name: "cdi_queried_diagnoses"
      expr: COUNT(CASE WHEN cdi_query_flag = TRUE THEN 1 END)
      comment: "Number of diagnoses that triggered a CDI (Clinical Documentation Improvement) query. Measures CDI program activity and documentation gap identification."
    - name: "mcc_flagged_diagnoses"
      expr: COUNT(CASE WHEN mcc_flag = TRUE THEN 1 END)
      comment: "Number of diagnoses flagged as Major Complication or Comorbidity (MCC). Directly impacts DRG weight and reimbursement — essential for revenue integrity and case mix management."
    - name: "sdoh_flagged_diagnoses"
      expr: COUNT(CASE WHEN sdoh_flag = TRUE THEN 1 END)
      comment: "Number of diagnoses with a Social Determinants of Health flag. Supports population health equity programs and SDOH-driven care intervention targeting."
    - name: "drg_relevant_diagnoses"
      expr: COUNT(CASE WHEN drg_relevant_flag = TRUE THEN 1 END)
      comment: "Number of diagnoses flagged as DRG-relevant. Supports revenue integrity analysis by identifying diagnoses that influence DRG assignment and reimbursement."
    - name: "quality_measure_diagnoses"
      expr: COUNT(CASE WHEN quality_measure_flag = TRUE THEN 1 END)
      comment: "Number of diagnoses tied to quality measures. Supports HEDIS, CMS quality program reporting, and value-based care performance tracking."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_procedure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedure event metrics covering surgical and clinical procedure volume, financial performance, quality indicators, and operational efficiency. Supports OR utilization, revenue cycle, and clinical quality steering."
  source: "`healthcare_ecm`.`clinical`.`procedure_event`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type of procedure (e.g., surgical, diagnostic, therapeutic) for procedure mix and service line analysis."
    - name: "procedure_category"
      expr: procedure_category
      comment: "Clinical category of the procedure for service line performance and capacity planning."
    - name: "procedure_status"
      expr: procedure_status
      comment: "Status of the procedure (e.g., completed, cancelled, in-progress) for throughput and cancellation rate analysis."
    - name: "procedure_date_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month of procedure date for trending procedure volume, revenue, and RVU production over time."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used (e.g., general, regional, local) for anesthesia utilization and risk stratification."
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification for patient acuity segmentation and surgical risk analysis."
    - name: "wound_classification"
      expr: wound_classification
      comment: "Wound classification (e.g., clean, contaminated) for surgical site infection risk monitoring and quality reporting."
    - name: "approach"
      expr: approach
      comment: "Surgical approach (e.g., open, laparoscopic, robotic) for minimally invasive surgery adoption and outcomes analysis."
    - name: "priority"
      expr: priority
      comment: "Procedure priority (e.g., elective, urgent, emergent) for OR scheduling optimization and capacity management."
    - name: "laterality"
      expr: laterality
      comment: "Laterality of the procedure (e.g., left, right, bilateral) for wrong-site surgery prevention and quality monitoring."
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total number of procedure events. Baseline volume metric for OR throughput, service line capacity, and revenue cycle analysis."
    - name: "distinct_patients_treated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients who received at least one procedure. Measures procedural care reach across the patient population."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total gross charges for all procedure events. Core revenue cycle metric for financial performance and payer contract analysis."
    - name: "avg_charge_per_procedure"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average gross charge per procedure event. Used for pricing benchmarking, payer negotiation, and service line profitability analysis."
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs (Relative Value Units) generated by procedures. Primary physician productivity and compensation metric; drives value-based reimbursement calculations."
    - name: "avg_rvu_work_per_procedure"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVUs per procedure. Benchmarks procedural complexity and physician productivity against national standards."
    - name: "cancelled_procedures"
      expr: COUNT(CASE WHEN procedure_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled procedures. High cancellation rates signal OR scheduling inefficiency, patient access barriers, or pre-op process failures — directly impacts revenue and throughput."
    - name: "timeout_compliance_count"
      expr: COUNT(CASE WHEN timeout_performed = TRUE THEN 1 END)
      comment: "Number of procedures where a surgical timeout was performed. Critical patient safety metric — timeout compliance is a Joint Commission requirement and wrong-site surgery prevention measure."
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END)
      comment: "Number of procedures with documented patient consent. Regulatory compliance and risk management metric — missing consent documentation creates significant liability exposure."
    - name: "specimen_collected_count"
      expr: COUNT(CASE WHEN specimen_collected = TRUE THEN 1 END)
      comment: "Number of procedures where a specimen was collected for pathology. Supports surgical pathology volume forecasting and lab capacity planning."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_vital_sign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vital sign metrics tracking clinical measurement volume, abnormal value rates, and physiologic monitoring patterns. Supports nursing quality, early warning system (EWS) performance, and patient deterioration surveillance."
  source: "`healthcare_ecm`.`clinical`.`vital_sign`"
  dimensions:
    - name: "observation_type"
      expr: observation_type
      comment: "Type of vital sign observation (e.g., blood pressure, heart rate, temperature) for measurement-specific trend analysis."
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the vital sign observation (e.g., final, amended, entered-in-error) for data quality monitoring."
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Abnormality flag for the vital sign value (e.g., high, low, critical) for patient deterioration and early warning analysis."
    - name: "care_unit"
      expr: care_unit
      comment: "Care unit where the vital sign was recorded for unit-level monitoring intensity and nursing workload analysis."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to obtain the vital sign measurement (e.g., manual, automated, telemetry) for data source quality analysis."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of vital sign measurement for trending monitoring volume and abnormal rate over time."
    - name: "ews_score_type"
      expr: ews_score_type
      comment: "Type of Early Warning Score (e.g., NEWS, MEWS) associated with the vital sign for deterioration surveillance program analysis."
    - name: "pain_scale_type"
      expr: pain_scale_type
      comment: "Pain scale type used (e.g., numeric, FACES, FLACC) for pain management program monitoring and quality reporting."
  measures:
    - name: "total_vital_sign_measurements"
      expr: COUNT(1)
      comment: "Total number of vital sign measurements recorded. Baseline metric for nursing monitoring intensity and documentation compliance."
    - name: "distinct_patients_monitored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with at least one vital sign recorded. Measures monitoring coverage across the patient population."
    - name: "abnormal_vital_sign_count"
      expr: COUNT(CASE WHEN abnormal_flag IS NOT NULL AND abnormal_flag != 'Normal' THEN 1 END)
      comment: "Number of vital sign measurements flagged as abnormal. Key patient safety metric — high abnormal rates may indicate deteriorating patient populations or inadequate intervention response."
    - name: "avg_numeric_vital_value"
      expr: AVG(CAST(numeric_value AS DOUBLE))
      comment: "Average numeric vital sign value across all measurements. Used for population-level physiologic benchmarking and trend monitoring by vital sign type."
    - name: "patient_reported_vital_count"
      expr: COUNT(CASE WHEN is_patient_reported = TRUE THEN 1 END)
      comment: "Number of patient-reported vital sign measurements. Tracks remote patient monitoring and patient engagement program adoption — critical for virtual care and RPM program ROI."
    - name: "telemetry_derived_vital_count"
      expr: COUNT(CASE WHEN is_telemetry_derived = TRUE THEN 1 END)
      comment: "Number of vital signs derived from telemetry monitoring. Measures continuous monitoring utilization and telemetry bed capacity usage."
    - name: "avg_supplemental_oxygen_flow_rate"
      expr: AVG(CAST(supplemental_oxygen_flow_rate AS DOUBLE))
      comment: "Average supplemental oxygen flow rate across measurements. Tracks respiratory support intensity across patient populations — informs respiratory therapy staffing and oxygen supply management."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical observation metrics covering assessment scores, critical value rates, SDOH screening, and clinical measurement quality. Supports quality programs, patient safety surveillance, and population health management."
  source: "`healthcare_ecm`.`clinical`.`observation`"
  dimensions:
    - name: "observation_category"
      expr: observation_category
      comment: "Category of the clinical observation (e.g., vital-signs, laboratory, social-history) for cross-category performance analysis."
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the observation (e.g., final, preliminary, amended) for data completeness and quality monitoring."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the observation was recorded for cross-setting clinical monitoring analysis."
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of observation for trending clinical assessment volume and critical value rates over time."
    - name: "assessment_tool"
      expr: assessment_tool
      comment: "Standardized assessment tool used (e.g., PHQ-9, GAD-7, Braden Scale) for tool-specific outcome and compliance analysis."
    - name: "sdoh_domain"
      expr: sdoh_domain
      comment: "SDOH domain captured in the observation (e.g., food insecurity, housing instability) for social needs screening program performance."
    - name: "interpretation_flag"
      expr: interpretation_flag
      comment: "Clinical interpretation of the observation value (e.g., high, low, critical) for abnormality and alert rate analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level of the observation finding for acuity-based population segmentation."
  measures:
    - name: "total_observations"
      expr: COUNT(1)
      comment: "Total number of clinical observations recorded. Baseline metric for clinical documentation volume and assessment program throughput."
    - name: "distinct_patients_assessed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with at least one clinical observation. Measures assessment program reach and screening coverage."
    - name: "critical_value_observations"
      expr: COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END)
      comment: "Number of observations with a critical value. Patient safety metric — critical value notification compliance is a Joint Commission standard and directly impacts patient outcomes."
    - name: "critical_value_patients"
      expr: COUNT(DISTINCT CASE WHEN is_critical_value = TRUE THEN mpi_record_id END)
      comment: "Distinct patients with at least one critical observation value. Measures the breadth of high-acuity patient exposure requiring urgent clinical response."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average standardized assessment score (e.g., PHQ-9, pain, fall risk) across observations. Tracks population-level clinical risk and program effectiveness over time."
    - name: "amended_observation_count"
      expr: COUNT(CASE WHEN is_amended = TRUE THEN 1 END)
      comment: "Number of observations that were amended after initial entry. Elevated amendment rates signal documentation quality issues, workflow problems, or potential compliance risk."
    - name: "sdoh_screened_patients"
      expr: COUNT(DISTINCT CASE WHEN sdoh_domain IS NOT NULL THEN mpi_record_id END)
      comment: "Distinct patients screened for at least one SDOH domain. Measures SDOH screening program penetration — a CMS and Joint Commission quality requirement with direct impact on health equity outcomes."
    - name: "avg_reference_range_high"
      expr: AVG(CAST(reference_range_high AS DOUBLE))
      comment: "Average upper reference range value across observations. Used for population-level clinical threshold benchmarking and lab/observation standardization analysis."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_allergy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergy record metrics tracking allergy documentation completeness, drug allergy prevalence, severity distribution, and override safety events. Supports medication safety programs, patient safety governance, and clinical risk management."
  source: "`healthcare_ecm`.`clinical`.`allergy`"
  dimensions:
    - name: "allergen_type"
      expr: allergen_type
      comment: "Type of allergen (e.g., drug, food, environmental) for allergy category prevalence and safety program targeting."
    - name: "allergy_category"
      expr: allergy_category
      comment: "Clinical category of the allergy for cross-category safety analysis and formulary management."
    - name: "severity"
      expr: severity
      comment: "Severity of the allergic reaction (e.g., mild, moderate, severe, life-threatening) for risk stratification and safety alert prioritization."
    - name: "clinical_status"
      expr: clinical_status
      comment: "Clinical status of the allergy record (e.g., active, inactive, resolved) for active allergy burden analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the allergy (e.g., confirmed, unconfirmed, refuted) for documentation quality and clinical accuracy monitoring."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the allergy was recorded for cross-setting documentation consistency analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Allergy reconciliation status for medication reconciliation compliance monitoring — a key patient safety and accreditation requirement."
    - name: "onset_date_year"
      expr: YEAR(onset_date)
      comment: "Year of allergy onset for longitudinal allergy prevalence trending."
  measures:
    - name: "total_allergy_records"
      expr: COUNT(1)
      comment: "Total number of allergy records. Baseline metric for allergy documentation volume and registry completeness."
    - name: "distinct_patients_with_allergies"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with at least one documented allergy. Measures allergy documentation coverage across the patient population — gaps create medication safety risk."
    - name: "drug_allergy_patient_count"
      expr: COUNT(DISTINCT CASE WHEN is_no_known_drug_allergy = FALSE THEN demographics_id END)
      comment: "Distinct patients with at least one documented drug allergy (excluding NKDA). Core medication safety metric for formulary management and prescribing decision support."
    - name: "no_known_allergy_patients"
      expr: COUNT(DISTINCT CASE WHEN is_no_known_allergy = TRUE THEN demographics_id END)
      comment: "Distinct patients documented as having no known allergies. Measures allergy screening completion — NKDA documentation is required for safe medication administration."
    - name: "severe_allergy_count"
      expr: COUNT(CASE WHEN severity IN ('Severe', 'Life-threatening') THEN 1 END)
      comment: "Number of allergy records with severe or life-threatening severity. High-priority patient safety metric — these patients require special prescribing safeguards and emergency preparedness."
    - name: "allergy_override_events"
      expr: COUNT(CASE WHEN alert_override_reason IS NOT NULL THEN 1 END)
      comment: "Number of allergy alert override events. Critical medication safety metric — excessive overrides indicate alert fatigue and increase adverse drug event risk, requiring pharmacy and safety committee review."
    - name: "unverified_allergy_count"
      expr: COUNT(CASE WHEN verification_status NOT IN ('Confirmed', 'Verified') OR verification_status IS NULL THEN 1 END)
      comment: "Number of allergy records that are unverified or unconfirmed. Documentation quality metric — unverified allergies reduce clinical decision support reliability and create prescribing risk."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_immunization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Immunization metrics tracking vaccination administration volume, series completion rates, adverse reaction surveillance, and immunization registry reporting compliance. Supports public health programs, HEDIS quality measures, and infection prevention."
  source: "`healthcare_ecm`.`clinical`.`immunization`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the immunization administration (e.g., completed, not given, refused) for vaccination completion rate analysis."
    - name: "series_name"
      expr: series_name
      comment: "Name of the vaccine series (e.g., COVID-19, influenza, HPV) for series-specific coverage and completion analysis."
    - name: "series_completion_status"
      expr: series_completion_status
      comment: "Completion status of the vaccine series for immunization series completion rate reporting."
    - name: "administration_route_code"
      expr: administration_route_code
      comment: "Route of vaccine administration (e.g., IM, SC, oral) for administration practice standardization."
    - name: "vfc_eligibility_code"
      expr: vfc_eligibility_code
      comment: "Vaccines for Children (VFC) eligibility code for public health program compliance and funding reporting."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_timestamp)
      comment: "Month of vaccine administration for seasonal vaccination campaign performance and coverage trending."
    - name: "funding_source_code"
      expr: funding_source_code
      comment: "Funding source for the vaccine (e.g., public, private, VFC) for program cost and reimbursement analysis."
  measures:
    - name: "total_immunizations_administered"
      expr: COUNT(1)
      comment: "Total number of immunizations administered. Baseline metric for vaccination program throughput and public health coverage reporting."
    - name: "distinct_patients_vaccinated"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients who received at least one immunization. Core HEDIS and public health metric for population vaccination coverage."
    - name: "iis_reported_count"
      expr: COUNT(CASE WHEN iis_reported = TRUE THEN 1 END)
      comment: "Number of immunizations reported to the Immunization Information System (IIS). Regulatory compliance metric — IIS reporting is mandated in most states and required for public health surveillance."
    - name: "reaction_observed_count"
      expr: COUNT(CASE WHEN reaction_observed = TRUE THEN 1 END)
      comment: "Number of immunizations where an adverse reaction was observed. Patient safety metric for vaccine adverse event surveillance and VAERS reporting compliance."
    - name: "vaers_reported_count"
      expr: COUNT(CASE WHEN vaers_reported = TRUE THEN 1 END)
      comment: "Number of adverse vaccine reactions reported to VAERS (Vaccine Adverse Event Reporting System). Federal regulatory compliance metric — VAERS reporting is required by the National Childhood Vaccine Injury Act."
    - name: "consent_obtained_count"
      expr: COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END)
      comment: "Number of immunizations with documented patient consent. Regulatory and risk management metric — consent documentation is required for vaccine administration and liability protection."
    - name: "avg_dose_quantity"
      expr: AVG(CAST(dose_quantity AS DOUBLE))
      comment: "Average vaccine dose quantity administered. Used for dosing standardization monitoring and identification of potential dosing errors across vaccine types."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan metrics tracking care plan creation, goal attainment, readmission risk stratification, and population health program enrollment. Supports care management, value-based care performance, and transitions of care quality."
  source: "`healthcare_ecm`.`clinical`.`care_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (e.g., chronic disease, post-acute, behavioral health) for program-specific performance analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the care plan (e.g., active, completed, revoked) for active care management population tracking."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting associated with the care plan for cross-setting care coordination analysis."
    - name: "readmission_risk_level"
      expr: readmission_risk_level
      comment: "Readmission risk stratification level (e.g., low, medium, high) for targeted intervention and resource allocation."
    - name: "population_health_program"
      expr: population_health_program
      comment: "Population health program associated with the care plan for program enrollment and outcome tracking."
    - name: "authored_date_month"
      expr: DATE_TRUNC('MONTH', authored_date)
      comment: "Month the care plan was authored for care plan creation volume trending."
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition associated with the care plan for post-acute care coordination and transitions of care analysis."
    - name: "review_frequency"
      expr: review_frequency
      comment: "Frequency at which the care plan is reviewed for care management intensity and compliance monitoring."
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total number of care plans created. Baseline metric for care management program capacity and care coordination throughput."
    - name: "distinct_patients_with_care_plans"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients enrolled in at least one care plan. Measures care management program reach — a key value-based care and ACO performance metric."
    - name: "active_care_plans"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active care plans. Measures active care management caseload for staffing and resource allocation decisions."
    - name: "high_readmission_risk_plans"
      expr: COUNT(CASE WHEN readmission_risk_level = 'High' THEN 1 END)
      comment: "Number of care plans for patients at high readmission risk. Drives targeted intervention investment — readmission penalties under CMS HRRP make this a direct financial risk metric."
    - name: "sdoh_flagged_care_plans"
      expr: COUNT(CASE WHEN sdoh_flag = TRUE THEN 1 END)
      comment: "Number of care plans with SDOH flags. Measures social needs integration into care management — required for health equity program reporting and CMS quality initiatives."
    - name: "behavioral_health_care_plans"
      expr: COUNT(CASE WHEN behavioral_health_flag = TRUE THEN 1 END)
      comment: "Number of care plans with a behavioral health component. Tracks integrated behavioral health program enrollment — critical for mental health parity compliance and whole-person care models."
    - name: "transitions_of_care_plans"
      expr: COUNT(CASE WHEN transitions_of_care_flag = TRUE THEN 1 END)
      comment: "Number of care plans flagged for transitions of care. Measures post-discharge care coordination intensity — directly linked to readmission prevention and CMS Transitional Care Management billing."
    - name: "consent_obtained_plans"
      expr: COUNT(CASE WHEN patient_consent_obtained = TRUE THEN 1 END)
      comment: "Number of care plans with documented patient consent. Regulatory compliance metric — patient consent for care plan participation is required under HIPAA and value-based care program rules."
    - name: "aco_attributed_plans"
      expr: COUNT(CASE WHEN aco_attributed = TRUE THEN 1 END)
      comment: "Number of care plans for ACO-attributed patients. Directly measures ACO care management program coverage — a key metric for shared savings performance and CMS MSSP reporting."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal metrics tracking goal achievement rates, patient engagement, SDOH goal prevalence, and care gap closure. Supports value-based care performance, care management quality, and population health outcome reporting."
  source: "`healthcare_ecm`.`clinical`.`care_plan_goal`"
  dimensions:
    - name: "goal_status"
      expr: goal_status
      comment: "Current status of the care plan goal (e.g., in-progress, achieved, cancelled) for goal attainment analysis."
    - name: "achievement_status"
      expr: achievement_status
      comment: "Achievement status of the goal (e.g., achieved, not-achieved, sustaining) for outcome measurement and program effectiveness."
    - name: "goal_category_display"
      expr: goal_category_display
      comment: "Display category of the goal (e.g., dietary, exercise, medication adherence) for goal type distribution and program design analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the care plan goal (e.g., high, medium, low) for resource allocation and goal sequencing analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the goal was initiated for goal creation volume trending and program ramp analysis."
    - name: "review_frequency"
      expr: review_frequency
      comment: "Frequency of goal review for care management intensity and follow-up compliance monitoring."
    - name: "expressed_by_type"
      expr: expressed_by_type
      comment: "Who expressed the goal (e.g., patient, clinician, care team) for patient-centered care and shared decision-making analysis."
  measures:
    - name: "total_care_plan_goals"
      expr: COUNT(1)
      comment: "Total number of care plan goals defined. Baseline metric for care management goal-setting volume and program comprehensiveness."
    - name: "distinct_patients_with_goals"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with at least one care plan goal. Measures goal-based care management program reach."
    - name: "achieved_goals"
      expr: COUNT(CASE WHEN achievement_status = 'Achieved' THEN 1 END)
      comment: "Number of care plan goals that have been achieved. Primary outcome metric for care management program effectiveness and value-based care performance."
    - name: "patient_agreed_goals"
      expr: COUNT(CASE WHEN patient_agreement = TRUE THEN 1 END)
      comment: "Number of goals where the patient has agreed to the goal. Measures patient engagement and shared decision-making — a key predictor of goal achievement and care plan adherence."
    - name: "sdoh_related_goals"
      expr: COUNT(CASE WHEN sdoh_related = TRUE THEN 1 END)
      comment: "Number of goals related to Social Determinants of Health. Tracks social needs intervention intensity — required for health equity program reporting and CMS quality initiatives."
    - name: "care_gap_related_goals"
      expr: COUNT(CASE WHEN care_gap_related = TRUE THEN 1 END)
      comment: "Number of goals tied to identified care gaps. Measures care gap closure program activity — directly linked to HEDIS measure performance and value-based contract quality bonuses."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value set for quantitative care plan goals (e.g., target HbA1c, target weight). Used for population-level clinical target benchmarking and goal ambition analysis."
    - name: "avg_current_value"
      expr: AVG(CAST(current_value AS DOUBLE))
      comment: "Average current value for quantitative care plan goals. Compared against target values to assess population-level goal progress and program effectiveness."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_problem`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Problem list metrics tracking active problem burden, chronic disease prevalence, SDOH problem documentation, and CDI query activity. Supports population health management, chronic disease programs, and clinical documentation quality."
  source: "`healthcare_ecm`.`clinical`.`problem`"
  dimensions:
    - name: "problem_status"
      expr: problem_status
      comment: "Status of the problem (e.g., active, resolved, inactive) for active disease burden analysis."
    - name: "problem_type"
      expr: problem_type
      comment: "Type of problem (e.g., medical, behavioral, social) for cross-domain problem burden analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the problem was documented for cross-setting problem list completeness analysis."
    - name: "severity"
      expr: severity
      comment: "Severity of the problem for risk stratification and care intensity planning."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the problem (e.g., confirmed, provisional, refuted) for problem list accuracy monitoring."
    - name: "noted_date_year"
      expr: YEAR(noted_date)
      comment: "Year the problem was first noted for longitudinal disease burden trending."
    - name: "stage_code"
      expr: stage_code
      comment: "Clinical stage code for the problem (e.g., cancer staging) for disease severity and progression analysis."
  measures:
    - name: "total_problems"
      expr: COUNT(1)
      comment: "Total number of problems on the problem list. Baseline metric for disease burden documentation volume and problem list completeness."
    - name: "distinct_patients_with_problems"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with at least one documented problem. Measures problem list coverage across the patient population."
    - name: "active_problems"
      expr: COUNT(CASE WHEN problem_status = 'Active' THEN 1 END)
      comment: "Number of currently active problems. Measures active disease burden for care management caseload planning and population health program targeting."
    - name: "chronic_condition_problems"
      expr: COUNT(CASE WHEN chronic_condition_flag = TRUE THEN 1 END)
      comment: "Number of problems flagged as chronic conditions. Core population health metric for chronic disease program enrollment and care management resource allocation."
    - name: "sdoh_flagged_problems"
      expr: COUNT(CASE WHEN sdoh_flag = TRUE THEN 1 END)
      comment: "Number of problems with SDOH flags. Measures social needs documentation on the problem list — required for health equity reporting and whole-person care program design."
    - name: "cdi_queried_problems"
      expr: COUNT(CASE WHEN cdi_query_flag = TRUE THEN 1 END)
      comment: "Number of problems that triggered a CDI query. Measures CDI program activity at the problem level — documentation specificity directly impacts DRG assignment and reimbursement."
    - name: "principal_problems"
      expr: COUNT(CASE WHEN principal_problem_flag = TRUE THEN 1 END)
      comment: "Number of problems flagged as the principal problem. Used for primary diagnosis validation, DRG accuracy, and case mix analysis."
    - name: "patients_with_chronic_conditions"
      expr: COUNT(DISTINCT CASE WHEN chronic_condition_flag = TRUE THEN mpi_record_id END)
      comment: "Distinct patients with at least one chronic condition on the problem list. Key population health metric for chronic disease program enrollment targeting and risk stratification."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_advance_directive`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advance directive metrics tracking documentation rates, hospice enrollment, palliative care referrals, ethics consult activity, and patient capacity assessment. Supports palliative care programs, ethics governance, and end-of-life care quality reporting."
  source: "`healthcare_ecm`.`clinical`.`advance_directive`"
  dimensions:
    - name: "directive_type"
      expr: directive_type
      comment: "Type of advance directive (e.g., DNR, POLST, living will, healthcare proxy) for directive type distribution analysis."
    - name: "directive_status"
      expr: directive_status
      comment: "Current status of the advance directive (e.g., active, revoked, superseded) for active directive coverage analysis."
    - name: "code_status"
      expr: code_status
      comment: "Patient code status (e.g., full code, DNR, DNI) for code status distribution and end-of-life care planning analysis."
    - name: "life_sustaining_treatment_preference"
      expr: life_sustaining_treatment_preference
      comment: "Patient preference for life-sustaining treatment for end-of-life care planning and goals-of-care alignment analysis."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the advance directive became effective for longitudinal directive documentation trending."
    - name: "state_of_execution"
      expr: state_of_execution
      comment: "State where the advance directive was executed for multi-state legal validity and portability analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the advance directive (e.g., original document, scanned copy, verbal) for documentation quality analysis."
  measures:
    - name: "total_advance_directives"
      expr: COUNT(1)
      comment: "Total number of advance directives documented. Baseline metric for advance care planning program volume and documentation completeness."
    - name: "distinct_patients_with_directives"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with at least one advance directive on file. Core advance care planning metric — low rates indicate gaps in goals-of-care conversations and patient autonomy support."
    - name: "hospice_enrolled_patients"
      expr: COUNT(DISTINCT CASE WHEN hospice_enrolled = TRUE THEN demographics_id END)
      comment: "Distinct patients enrolled in hospice with an advance directive. Measures hospice program reach and end-of-life care planning integration."
    - name: "palliative_care_referrals"
      expr: COUNT(CASE WHEN palliative_care_referral = TRUE THEN 1 END)
      comment: "Number of advance directives associated with a palliative care referral. Measures palliative care program integration with advance care planning — a key quality metric for serious illness care."
    - name: "ethics_consults_requested"
      expr: COUNT(CASE WHEN ethics_consult_requested = TRUE THEN 1 END)
      comment: "Number of cases where an ethics consult was requested in conjunction with an advance directive. Measures ethics program utilization and complex end-of-life decision-making volume."
    - name: "patient_capacity_assessed_count"
      expr: COUNT(CASE WHEN patient_capacity_assessed = TRUE THEN 1 END)
      comment: "Number of advance directives where patient decision-making capacity was formally assessed. Measures compliance with informed consent and capacity assessment standards — required for valid advance directive execution."
    - name: "notarized_directives"
      expr: COUNT(CASE WHEN notarized = TRUE THEN 1 END)
      comment: "Number of notarized advance directives. Measures legal documentation quality — notarization requirements vary by state and affect directive enforceability."
    - name: "organ_donation_documented_count"
      expr: COUNT(CASE WHEN organ_donation_status IS NOT NULL AND organ_donation_status != '' THEN 1 END)
      comment: "Number of advance directives with documented organ donation status. Supports organ donation program reporting and OPO (Organ Procurement Organization) compliance."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`clinical_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical note metrics tracking documentation volume, CDI query activity, late entry rates, and note completion quality. Supports CDI programs, HIM operations, revenue integrity, and clinical documentation quality governance."
  source: "`healthcare_ecm`.`clinical`.`note`"
  dimensions:
    - name: "note_type"
      expr: note_type
      comment: "Type of clinical note (e.g., H&P, discharge summary, progress note, operative note) for documentation type distribution and compliance analysis."
    - name: "note_status"
      expr: note_status
      comment: "Status of the note (e.g., signed, unsigned, amended, addendum) for documentation completion and workflow monitoring."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the note was authored for cross-setting documentation volume and quality analysis."
    - name: "author_role"
      expr: author_role
      comment: "Role of the note author (e.g., attending, resident, NP, PA) for documentation responsibility and supervision compliance analysis."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Type of encounter associated with the note for encounter-level documentation completeness analysis."
    - name: "service_line"
      expr: service_line
      comment: "Clinical service line associated with the note for service line documentation volume and quality benchmarking."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service date for documentation volume trending and CDI program performance over time."
    - name: "dictation_method"
      expr: dictation_method
      comment: "Method used to create the note (e.g., dictation, voice recognition, typed) for documentation efficiency and technology adoption analysis."
  measures:
    - name: "total_notes"
      expr: COUNT(1)
      comment: "Total number of clinical notes authored. Baseline metric for documentation volume, HIM workload, and clinical productivity."
    - name: "distinct_patients_documented"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with at least one clinical note. Measures documentation coverage across the patient population."
    - name: "cdi_queried_notes"
      expr: COUNT(CASE WHEN cdi_query_flag = TRUE THEN 1 END)
      comment: "Number of notes that triggered a CDI query. Measures CDI program activity — documentation specificity in notes directly impacts DRG assignment, case mix index, and reimbursement."
    - name: "drg_impact_notes"
      expr: COUNT(CASE WHEN drg_impact_flag = TRUE THEN 1 END)
      comment: "Number of notes flagged as having DRG impact. Revenue integrity metric — these notes contain documentation that directly affects DRG assignment and reimbursement accuracy."
    - name: "late_entry_notes"
      expr: COUNT(CASE WHEN is_late_entry = TRUE THEN 1 END)
      comment: "Number of notes entered late (after the encounter). Documentation quality and compliance metric — late entries create legal risk and may indicate workflow inefficiencies."
    - name: "addendum_notes"
      expr: COUNT(CASE WHEN is_addendum = TRUE THEN 1 END)
      comment: "Number of addendum notes. Elevated addendum rates may indicate initial documentation gaps, CDI query responses, or amendment workflows requiring process improvement."
    - name: "unsigned_notes"
      expr: COUNT(CASE WHEN note_status = 'Unsigned' THEN 1 END)
      comment: "Number of unsigned clinical notes. Critical compliance metric — unsigned notes are not legally valid, create billing risk, and violate accreditation standards."
$$;