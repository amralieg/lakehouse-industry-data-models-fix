-- Metric views for domain: clinical | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical diagnosis metrics for tracking diagnostic patterns, coding quality, and clinical documentation integrity across encounters"
  source: "`healthcare_ecm_v1`.`clinical`.`diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (admitting, discharge, principal, secondary) for categorizing diagnostic events"
    - name: "clinical_status"
      expr: clinical_status
      comment: "Current clinical status of the diagnosis (active, resolved, recurrence) for tracking disease progression"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the diagnosis for acuity analysis"
    - name: "present_on_admission"
      expr: present_on_admission
      comment: "POA indicator critical for HAC penalty program and CMS quality reporting"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where diagnosis was recorded (inpatient, outpatient, ED) for utilization analysis"
    - name: "encounter_type"
      expr: encounter_type
      comment: "Encounter type associated with the diagnosis for volume segmentation"
    - name: "coding_status"
      expr: coding_status
      comment: "Status of diagnosis coding workflow for CDI productivity tracking"
    - name: "diagnosis_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Month of diagnosis for temporal trending"
    - name: "sdoh_flag"
      expr: CASE WHEN sdoh_flag = TRUE THEN 'SDOH-Related' ELSE 'Non-SDOH' END
      comment: "Flag indicating social determinants of health related diagnosis (Z-codes)"
    - name: "chronic_condition_flag"
      expr: CASE WHEN chronic_condition_flag = TRUE THEN 'Chronic' ELSE 'Non-Chronic' END
      comment: "Identifies chronic conditions for population health stratification"
    - name: "hac_flag"
      expr: CASE WHEN hac_flag = TRUE THEN 'HAC-Relevant' ELSE 'Non-HAC' END
      comment: "Hospital-Acquired Condition flag for CMS penalty program monitoring"
  measures:
    - name: "total_diagnoses"
      expr: COUNT(1)
      comment: "Total diagnosis records for volume baseline"
    - name: "unique_patients_diagnosed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with diagnoses for population-level analysis"
    - name: "principal_diagnosis_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN principal_diagnosis_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses flagged as principal - monitors coding completeness for DRG assignment"
    - name: "poa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN present_on_admission IS NOT NULL AND present_on_admission != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of diagnoses with POA indicator documented - required for HAC penalty avoidance"
    - name: "hac_flag_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hac_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses flagged as hospital-acquired conditions - directly impacts CMS reimbursement penalties"
    - name: "chronic_condition_prevalence"
      expr: ROUND(100.0 * SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Prevalence of chronic conditions in diagnosis mix for population health program planning"
    - name: "sdoh_diagnosis_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of SDOH-related diagnoses (Z-codes) - tracks compliance with CMS SDOH screening mandates"
    - name: "cdi_query_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cdi_query_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of diagnoses triggering CDI queries - measures documentation improvement opportunity"
    - name: "drg_relevant_diagnosis_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drg_relevant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses relevant to DRG assignment - monitors revenue integrity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan effectiveness and compliance metrics for population health management and value-based care programs"
  source: "`healthcare_ecm_v1`.`clinical`.`care_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (chronic disease, transitional, palliative) for program segmentation"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the care plan for workflow monitoring"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the plan (inpatient, ambulatory, home) for resource allocation"
    - name: "intent"
      expr: intent
      comment: "Plan intent (curative, palliative, preventive) for clinical strategy alignment"
    - name: "readmission_risk_level"
      expr: readmission_risk_level
      comment: "Patient readmission risk stratification for targeted intervention planning"
    - name: "population_health_program"
      expr: population_health_program
      comment: "Population health program the plan is associated with for VBC reporting"
    - name: "sdoh_flag"
      expr: CASE WHEN sdoh_flag = TRUE THEN 'SDOH-Addressed' ELSE 'No-SDOH' END
      comment: "Whether plan addresses social determinants for CMS compliance tracking"
    - name: "plan_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month plan was created for temporal analysis of care planning activity"
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total care plans for volume tracking"
    - name: "unique_patients_with_plans"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with active care plans for population coverage measurement"
    - name: "goal_achievement_rate"
      expr: ROUND(100.0 * AVG(CASE WHEN goal_count IS NOT NULL AND goal_count != '0' AND goals_achieved_count IS NOT NULL THEN CAST(goals_achieved_count AS DOUBLE) / NULLIF(CAST(goal_count AS DOUBLE), 0) ELSE NULL END), 2)
      comment: "Average ratio of goals achieved to total goals - primary effectiveness measure for care coordination"
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of plans with documented patient consent - regulatory compliance indicator"
    - name: "advance_directive_on_file_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN advance_directive_on_file = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of patients with advance directives documented - Joint Commission quality measure"
    - name: "high_readmission_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN readmission_risk_level IN ('High', 'Very High') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans for high readmission risk patients - drives transitional care resource allocation"
    - name: "vbc_program_coverage"
      expr: ROUND(100.0 * SUM(CASE WHEN population_health_program IS NOT NULL AND population_health_program != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of plans linked to value-based care programs - measures VBC program penetration"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_procedure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedural volume, efficiency, and quality metrics for surgical services and revenue cycle optimization"
  source: "`healthcare_ecm_v1`.`clinical`.`procedure_event`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type of procedure for service line analysis"
    - name: "procedure_category"
      expr: procedure_category
      comment: "Category grouping for strategic procedure mix analysis"
    - name: "procedure_status"
      expr: procedure_status
      comment: "Current status of the procedure for workflow monitoring"
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type for resource planning and cost analysis"
    - name: "wound_classification"
      expr: wound_classification
      comment: "Wound classification for SSI risk stratification"
    - name: "laterality"
      expr: laterality
      comment: "Laterality for wrong-site surgery prevention monitoring"
    - name: "facility_service_line"
      expr: facility_service_line
      comment: "Service line for strategic planning and margin analysis"
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month of procedure for volume trending"
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total procedure events for volume tracking and capacity planning"
    - name: "unique_patients"
      expr: COUNT(DISTINCT procedure_mpi_record_id)
      comment: "Distinct patients undergoing procedures for utilization analysis"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges generated from procedures for revenue cycle monitoring"
    - name: "avg_charge_per_procedure"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per procedure for pricing and margin analysis"
    - name: "total_work_rvus"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs generated - primary physician productivity measure"
    - name: "avg_rvus_per_procedure"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVUs per procedure for provider productivity benchmarking"
    - name: "consent_documentation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of procedures with documented consent - patient safety and compliance metric"
    - name: "timeout_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN timeout_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Surgical timeout compliance rate - Joint Commission National Patient Safety Goal"
    - name: "specimen_collection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN specimen_collected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of procedures with specimen collection - pathology workflow indicator"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cancellation_reason IS NOT NULL AND cancellation_reason != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Procedure cancellation rate - OR utilization and patient experience indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_cdi_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical Documentation Integrity query metrics for revenue integrity, coding accuracy, and DRG optimization"
  source: "`healthcare_ecm_v1`.`clinical`.`cdi_query`"
  dimensions:
    - name: "query_type"
      expr: query_type
      comment: "Type of CDI query for workflow categorization"
    - name: "query_status"
      expr: query_status
      comment: "Current status of the query for productivity tracking"
    - name: "query_outcome"
      expr: query_outcome
      comment: "Outcome of the query (agreed, disagreed, no response) for effectiveness measurement"
    - name: "query_category"
      expr: query_category
      comment: "Clinical category of the query for targeting documentation gaps"
    - name: "encounter_type"
      expr: encounter_type
      comment: "Encounter type for segmenting CDI impact by care setting"
    - name: "drg_type"
      expr: drg_type
      comment: "DRG type (MS-DRG, APR-DRG) for payer-specific analysis"
    - name: "cc_mcc_status"
      expr: cc_mcc_status
      comment: "CC/MCC capture status for severity of illness documentation"
    - name: "query_month"
      expr: DATE_TRUNC('MONTH', query_issue_date)
      comment: "Month query was issued for trending CDI productivity"
  measures:
    - name: "total_cdi_queries"
      expr: COUNT(1)
      comment: "Total CDI queries issued for productivity measurement"
    - name: "query_agreement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN query_outcome = 'Agreed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Physician agreement rate with CDI queries - primary CDI program effectiveness KPI"
    - name: "total_expected_reimbursement_impact"
      expr: SUM(CAST(expected_reimbursement_impact AS DOUBLE))
      comment: "Total expected revenue impact from CDI queries - justifies CDI program ROI"
    - name: "total_actual_reimbursement_impact"
      expr: SUM(CAST(actual_reimbursement_impact AS DOUBLE))
      comment: "Total actual revenue captured from CDI queries - realized CDI program value"
    - name: "avg_reimbursement_impact_per_query"
      expr: AVG(CAST(actual_reimbursement_impact AS DOUBLE))
      comment: "Average revenue impact per query for CDI specialist productivity benchmarking"
    - name: "coding_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN coding_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of queries that resulted in coding changes - measures documentation improvement effectiveness"
    - name: "concurrent_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN concurrent_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of concurrent vs retrospective reviews - concurrent reviews have higher impact on final coding"
    - name: "compliance_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of queries flagged for compliance review - monitors regulatory risk in documentation"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_vital_sign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vital sign monitoring metrics for early warning system effectiveness and clinical deterioration detection"
  source: "`healthcare_ecm_v1`.`clinical`.`vital_sign`"
  dimensions:
    - name: "observation_type"
      expr: observation_type
      comment: "Type of vital sign (BP, HR, RR, SpO2, Temp) for clinical monitoring segmentation"
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Whether the vital sign is outside normal range for alert analysis"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method of measurement (manual, automated, telemetry) for data quality assessment"
    - name: "care_unit"
      expr: care_unit
      comment: "Clinical unit where vital was recorded for unit-level quality comparison"
    - name: "ews_score_type"
      expr: ews_score_type
      comment: "Early warning score type (NEWS, MEWS, PEWS) for deterioration detection analysis"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of measurement for temporal trending"
  measures:
    - name: "total_vital_measurements"
      expr: COUNT(1)
      comment: "Total vital sign measurements for documentation compliance baseline"
    - name: "unique_patients_monitored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with vital signs recorded for monitoring coverage"
    - name: "abnormal_vital_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN abnormal_flag IS NOT NULL AND abnormal_flag != '' AND abnormal_flag != 'Normal' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of abnormal vital signs - triggers clinical deterioration investigation"
    - name: "telemetry_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_telemetry_derived = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of vitals captured via telemetry - measures automation and continuous monitoring adoption"
    - name: "patient_reported_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_patient_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of patient-reported vitals for RPM program effectiveness tracking"
    - name: "avg_numeric_value"
      expr: AVG(CAST(numeric_value AS DOUBLE))
      comment: "Average numeric vital sign value for population health trending and benchmarking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_immunization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Immunization administration metrics for public health compliance, HEDIS quality measures, and vaccine program management"
  source: "`healthcare_ecm_v1`.`clinical`.`immunization`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of immunization administration for completion tracking"
    - name: "series_completion_status"
      expr: series_completion_status
      comment: "Whether vaccine series is complete for population immunity analysis"
    - name: "funding_source_code"
      expr: funding_source_code
      comment: "Funding source (VFC, private, state) for program financial analysis"
    - name: "vfc_eligibility_code"
      expr: vfc_eligibility_code
      comment: "Vaccines for Children eligibility for federal program compliance"
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_timestamp)
      comment: "Month of administration for seasonal and campaign tracking"
  measures:
    - name: "total_immunizations_administered"
      expr: COUNT(1)
      comment: "Total immunizations administered for volume and capacity tracking"
    - name: "unique_patients_immunized"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients receiving immunizations for coverage rate calculation"
    - name: "series_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN series_completion_status = 'Complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Vaccine series completion rate - HEDIS childhood and adult immunization measure"
    - name: "consent_documentation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of immunizations with documented consent - regulatory compliance requirement"
    - name: "adverse_reaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reaction_observed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of observed adverse reactions - patient safety and VAERS reporting trigger"
    - name: "iis_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iis_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of immunizations reported to Immunization Information System - public health compliance"
    - name: "refusal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN not_given_reason_code IS NOT NULL AND not_given_reason_code != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Vaccine refusal/deferral rate - identifies patient education opportunities and community health risks"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_hai_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Healthcare-Associated Infection metrics for patient safety, CMS penalty avoidance, and infection prevention program effectiveness"
  source: "`healthcare_ecm_v1`.`clinical`.`hai_event`"
  dimensions:
    - name: "infection_type"
      expr: infection_type
      comment: "Type of HAI (CLABSI, CAUTI, SSI, MRSA, CDI) for targeted prevention programs"
    - name: "device_type"
      expr: device_type
      comment: "Device associated with infection for device-days denominator analysis"
    - name: "unit_location_description"
      expr: unit_location_description
      comment: "Unit where infection occurred for location-specific intervention"
    - name: "infection_onset_setting"
      expr: infection_onset_setting
      comment: "Setting of infection onset for community vs hospital-acquired classification"
    - name: "patient_outcome"
      expr: patient_outcome
      comment: "Patient outcome following HAI for mortality and morbidity tracking"
    - name: "nhsn_reporting_status"
      expr: nhsn_reporting_status
      comment: "NHSN reporting status for regulatory compliance monitoring"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month of HAI event for SIR trending"
  measures:
    - name: "total_hai_events"
      expr: COUNT(1)
      comment: "Total HAI events - primary infection prevention program outcome measure"
    - name: "unique_patients_affected"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with HAIs for patient-level impact analysis"
    - name: "nhsn_definition_met_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN nhsn_definition_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of events meeting NHSN surveillance definition - determines reportable infections"
    - name: "present_on_admission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN present_on_admission = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of infections present on admission vs hospital-acquired - impacts HAC penalty calculation"
    - name: "hac_penalty_exposure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hac_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of HAIs contributing to HAC penalty - direct financial risk indicator"
    - name: "vbp_penalty_exposure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vbp_penalty_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of HAIs impacting Value-Based Purchasing score - reimbursement risk metric"
    - name: "outbreak_associated_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outbreak_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of HAIs associated with outbreaks - triggers enhanced infection control response"
    - name: "state_reportable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN state_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of state-reportable infections for public health compliance tracking"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_problem`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Problem list management metrics for chronic disease tracking, HCC risk adjustment, and care gap identification"
  source: "`healthcare_ecm_v1`.`clinical`.`problem`"
  dimensions:
    - name: "problem_status"
      expr: problem_status
      comment: "Current status of the problem (active, resolved, inactive) for list hygiene analysis"
    - name: "problem_type"
      expr: problem_type
      comment: "Type of problem for clinical categorization"
    - name: "severity"
      expr: severity
      comment: "Problem severity for acuity-based resource allocation"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where problem is managed for utilization analysis"
    - name: "chronic_condition_flag"
      expr: CASE WHEN chronic_condition_flag = TRUE THEN 'Chronic' ELSE 'Acute' END
      comment: "Chronic vs acute classification for population health segmentation"
    - name: "sdoh_flag"
      expr: CASE WHEN sdoh_flag = TRUE THEN 'SDOH-Related' ELSE 'Clinical' END
      comment: "SDOH-related problem flag for social needs identification"
  measures:
    - name: "total_active_problems"
      expr: SUM(CASE WHEN problem_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active problems for disease burden analysis"
    - name: "unique_patients"
      expr: COUNT(DISTINCT problem_mpi_record_id)
      comment: "Distinct patients with documented problems for population coverage"
    - name: "chronic_condition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Prevalence of chronic conditions on problem lists - drives care management program sizing"
    - name: "hcc_documented_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hcc_category_code IS NOT NULL AND hcc_category_code != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of problems with HCC category documented - critical for Medicare Advantage risk adjustment revenue"
    - name: "cdi_query_opportunity_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cdi_query_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of problems flagged for CDI query - identifies documentation improvement revenue opportunity"
    - name: "problem_resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of problems with documented resolution - measures care effectiveness and list maintenance"
    - name: "sdoh_problem_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of SDOH-related problems documented - CMS and Joint Commission compliance indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical documentation metrics for note completion, timeliness, and CDI program support"
  source: "`healthcare_ecm_v1`.`clinical`.`note`"
  dimensions:
    - name: "note_type"
      expr: note_type
      comment: "Type of clinical note (H&P, progress, discharge, operative) for documentation analysis"
    - name: "note_status"
      expr: note_status
      comment: "Current status of the note (draft, signed, amended) for completion tracking"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for documentation volume analysis"
    - name: "encounter_type"
      expr: encounter_type
      comment: "Encounter type for documentation requirements analysis"
    - name: "specialty"
      expr: specialty
      comment: "Clinical specialty authoring the note for provider productivity"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Note confidentiality level for 42 CFR Part 2 and sensitive data governance"
    - name: "authored_month"
      expr: DATE_TRUNC('MONTH', authored_timestamp)
      comment: "Month note was authored for productivity trending"
  measures:
    - name: "total_notes"
      expr: COUNT(1)
      comment: "Total clinical notes for documentation volume tracking"
    - name: "unique_patients_documented"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with clinical documentation for coverage analysis"
    - name: "signed_note_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN note_status = 'Signed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of notes in signed status - measures documentation completion compliance"
    - name: "late_entry_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_late_entry = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of late entries - identifies documentation timeliness issues affecting CDI and billing"
    - name: "addendum_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_addendum = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of addenda - high rates may indicate initial documentation quality issues"
    - name: "cdi_query_flag_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cdi_query_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of notes flagged for CDI review - measures documentation improvement opportunity"
    - name: "drg_impact_flag_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN drg_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of notes with DRG impact - identifies revenue integrity documentation opportunities"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_allergy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergy documentation and reconciliation metrics for patient safety and medication safety programs"
  source: "`healthcare_ecm_v1`.`clinical`.`allergy`"
  dimensions:
    - name: "allergy_category"
      expr: allergy_category
      comment: "Category of allergy (drug, food, environmental) for safety program focus"
    - name: "clinical_status"
      expr: clinical_status
      comment: "Clinical status of the allergy (active, inactive, resolved) for list accuracy"
    - name: "criticality"
      expr: criticality
      comment: "Criticality level (high, low, unable-to-assess) for risk stratification"
    - name: "severity"
      expr: severity
      comment: "Reaction severity for clinical decision support tuning"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Medication reconciliation status for transitions of care compliance"
  measures:
    - name: "total_allergies_documented"
      expr: COUNT(1)
      comment: "Total allergy records for documentation completeness baseline"
    - name: "unique_patients_with_allergies"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with documented allergies for coverage analysis"
    - name: "high_criticality_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN criticality = 'high' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of high-criticality allergies - drives CPOE alert configuration priorities"
    - name: "reconciliation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Allergy reconciliation completion rate - Joint Commission medication management standard"
    - name: "alert_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_override_reason IS NOT NULL AND alert_override_reason != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of allergy alerts overridden by providers - measures alert fatigue and CDS effectiveness"
    - name: "nkda_documentation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_no_known_drug_allergy = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of explicit NKDA documentation - ensures allergy status is actively assessed not just absent"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`clinical_care_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care team composition and coordination metrics for multidisciplinary care effectiveness and value-based care attribution"
  source: "`healthcare_ecm_v1`.`clinical`.`care_team`"
  dimensions:
    - name: "team_type"
      expr: team_type
      comment: "Type of care team for organizational analysis"
    - name: "team_status"
      expr: team_status
      comment: "Current team status for active team monitoring"
    - name: "member_type"
      expr: member_type
      comment: "Type of team member (physician, nurse, social worker) for composition analysis"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for team deployment analysis"
    - name: "care_coordination_level"
      expr: care_coordination_level
      comment: "Level of care coordination for resource intensity tracking"
    - name: "vbp_program_code"
      expr: vbp_program_code
      comment: "Value-based program code for attribution and performance tracking"
  measures:
    - name: "total_care_teams"
      expr: COUNT(DISTINCT care_team_id)
      comment: "Total distinct care teams for organizational capacity analysis"
    - name: "unique_patients_with_teams"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients assigned to care teams for coverage measurement"
    - name: "multidisciplinary_team_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_multidisciplinary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of multidisciplinary teams - evidence shows better outcomes for complex patients"
    - name: "aco_attribution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN aco_attributed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of teams with ACO attribution - measures value-based care program coverage"
    - name: "hie_sharing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hie_shared = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of care team information shared via HIE - measures interoperability and care coordination"
    - name: "sdoh_addressed_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of teams addressing SDOH needs - CMS social needs integration compliance"
$$;