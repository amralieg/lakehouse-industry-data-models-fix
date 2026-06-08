-- Metric views for domain: patient | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety surveillance metrics tracking adverse event incidence, severity, seriousness, and regulatory reporting compliance for pharmacovigilance and risk management"
  source: "`pharmaceuticals_ecm`.`patient`.`adverse_event`"
  dimensions:
    - name: "seriousness_flag"
      expr: seriousness_flag
      comment: "Whether the adverse event meets regulatory criteria for seriousness"
    - name: "severity_grade"
      expr: severity_grade
      comment: "Clinical severity grade of the adverse event (e.g., Grade 1-5)"
    - name: "susar_flag"
      expr: susar_flag
      comment: "Suspected Unexpected Serious Adverse Reaction flag requiring expedited regulatory reporting"
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Assessment of causal relationship between study drug and adverse event"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the adverse event (e.g., recovered, fatal, ongoing)"
    - name: "meddra_soc_name"
      expr: meddra_soc_name
      comment: "MedDRA System Organ Class for standardized adverse event classification"
    - name: "meddra_pt_name"
      expr: meddra_pt_name
      comment: "MedDRA Preferred Term for specific adverse event description"
    - name: "reporting_timeline_compliance_status"
      expr: reporting_timeline_compliance_status
      comment: "Compliance status with regulatory reporting timelines"
    - name: "expectedness"
      expr: expectedness
      comment: "Whether the adverse event was expected based on known product profile"
    - name: "onset_year"
      expr: YEAR(onset_date)
      comment: "Year of adverse event onset for temporal trend analysis"
    - name: "onset_quarter"
      expr: CONCAT(CAST(YEAR(onset_date) AS STRING), '-Q', CAST(QUARTER(onset_date) AS STRING))
      comment: "Year-quarter of adverse event onset"
    - name: "report_year"
      expr: YEAR(report_date)
      comment: "Year the adverse event was reported"
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse event reports for safety signal detection"
    - name: "serious_adverse_events"
      expr: COUNT(CASE WHEN seriousness_flag = TRUE THEN 1 END)
      comment: "Count of serious adverse events requiring regulatory attention and risk assessment"
    - name: "susar_events"
      expr: COUNT(CASE WHEN susar_flag = TRUE THEN 1 END)
      comment: "Count of Suspected Unexpected Serious Adverse Reactions requiring expedited reporting"
    - name: "fatal_outcomes"
      expr: COUNT(CASE WHEN seriousness_criteria_death = TRUE THEN 1 END)
      comment: "Count of adverse events resulting in death, critical for benefit-risk assessment"
    - name: "hospitalization_events"
      expr: COUNT(CASE WHEN seriousness_criteria_hospitalization = TRUE THEN 1 END)
      comment: "Count of adverse events requiring or prolonging hospitalization"
    - name: "life_threatening_events"
      expr: COUNT(CASE WHEN seriousness_criteria_life_threatening = TRUE THEN 1 END)
      comment: "Count of life-threatening adverse events for immediate safety review"
    - name: "reporting_compliant_events"
      expr: COUNT(CASE WHEN reporting_timeline_compliance_status = 'Compliant' THEN 1 END)
      comment: "Count of adverse events reported within regulatory timelines"
    - name: "unique_patients_with_ae"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients experiencing adverse events for incidence rate calculation"
    - name: "unique_trials_with_ae"
      expr: COUNT(DISTINCT trial_id)
      comment: "Number of unique trials reporting adverse events for cross-study safety profiling"
    - name: "avg_ae_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration of adverse events in days for severity assessment"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial enrollment and retention metrics tracking recruitment velocity, disposition, and population eligibility for trial operations and regulatory submissions"
  source: "`pharmaceuticals_ecm`.`patient`.`patient_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the patient in the trial"
    - name: "treatment_arm"
      expr: treatment_arm
      comment: "Treatment arm assignment for efficacy and safety analysis by cohort"
    - name: "disposition_event_type"
      expr: disposition_event_type
      comment: "Type of disposition event (e.g., completed, withdrawn, discontinued)"
    - name: "disposition_primary_reason"
      expr: disposition_primary_reason
      comment: "Primary reason for patient disposition for retention analysis"
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason for screening failure to optimize eligibility criteria"
    - name: "safety_population_flag"
      expr: safety_population_flag
      comment: "Whether patient is included in safety analysis population"
    - name: "itt_population_flag"
      expr: itt_population_flag
      comment: "Whether patient is included in intent-to-treat analysis population"
    - name: "pp_population_flag"
      expr: pp_population_flag
      comment: "Whether patient is included in per-protocol analysis population"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of patient enrollment for temporal recruitment trend analysis"
    - name: "enrollment_quarter"
      expr: CONCAT(CAST(YEAR(enrollment_date) AS STRING), '-Q', CAST(QUARTER(enrollment_date) AS STRING))
      comment: "Year-quarter of patient enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of patient enrollment for granular recruitment tracking"
    - name: "region"
      expr: region
      comment: "Geographic region of enrollment for site performance and diversity analysis"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of patient enrollments across all trials and sites"
    - name: "unique_patients_enrolled"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients enrolled for recruitment velocity tracking"
    - name: "unique_trials"
      expr: COUNT(DISTINCT trial_id)
      comment: "Number of unique trials with patient enrollments"
    - name: "unique_sites"
      expr: COUNT(DISTINCT investigational_site_id)
      comment: "Number of unique investigational sites enrolling patients for site performance benchmarking"
    - name: "screen_failures"
      expr: COUNT(CASE WHEN screen_failure_reason IS NOT NULL THEN 1 END)
      comment: "Count of screening failures to assess eligibility criteria feasibility"
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN disposition_event_type = 'Completed' THEN 1 END)
      comment: "Count of patients who completed the trial for retention rate calculation"
    - name: "discontinued_enrollments"
      expr: COUNT(CASE WHEN disposition_event_type = 'Discontinued' THEN 1 END)
      comment: "Count of patients who discontinued for dropout analysis"
    - name: "withdrawn_enrollments"
      expr: COUNT(CASE WHEN disposition_event_type = 'Withdrawn' THEN 1 END)
      comment: "Count of patients who withdrew consent for retention strategy optimization"
    - name: "safety_population_count"
      expr: COUNT(CASE WHEN safety_population_flag = TRUE THEN 1 END)
      comment: "Count of patients in safety analysis population for regulatory submissions"
    - name: "itt_population_count"
      expr: COUNT(CASE WHEN itt_population_flag = TRUE THEN 1 END)
      comment: "Count of patients in intent-to-treat population for efficacy analysis"
    - name: "pp_population_count"
      expr: COUNT(CASE WHEN pp_population_flag = TRUE THEN 1 END)
      comment: "Count of patients in per-protocol population for protocol compliance assessment"
    - name: "total_benefit_amount"
      expr: SUM(CAST(benefit_amount_received AS DOUBLE))
      comment: "Total benefit amount received by enrolled patients for program cost tracking"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_protocol_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol compliance and quality metrics tracking deviations, severity, regulatory reportability, and corrective actions for GCP compliance and inspection readiness"
  source: "`pharmaceuticals_ecm`.`patient`.`protocol_deviation`"
  dimensions:
    - name: "deviation_type"
      expr: deviation_type
      comment: "Type of protocol deviation for root cause categorization"
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity classification of the deviation (e.g., minor, major, critical)"
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current status of the deviation (e.g., open, closed, under review)"
    - name: "regulatory_reportability_flag"
      expr: regulatory_reportability_flag
      comment: "Whether the deviation requires regulatory authority notification"
    - name: "impact_on_subject_safety"
      expr: impact_on_subject_safety
      comment: "Assessment of deviation impact on patient safety"
    - name: "impact_on_data_integrity"
      expr: impact_on_data_integrity
      comment: "Assessment of deviation impact on data integrity and study validity"
    - name: "deviation_year"
      expr: YEAR(deviation_date)
      comment: "Year the deviation occurred for temporal trend analysis"
    - name: "deviation_quarter"
      expr: CONCAT(CAST(YEAR(deviation_date) AS STRING), '-Q', CAST(QUARTER(deviation_date) AS STRING))
      comment: "Year-quarter of deviation occurrence"
    - name: "discovery_year"
      expr: YEAR(discovery_date)
      comment: "Year the deviation was discovered for detection lag analysis"
  measures:
    - name: "total_protocol_deviations"
      expr: COUNT(1)
      comment: "Total number of protocol deviations for compliance monitoring and quality oversight"
    - name: "major_deviations"
      expr: COUNT(CASE WHEN severity_classification = 'Major' THEN 1 END)
      comment: "Count of major protocol deviations requiring immediate corrective action"
    - name: "critical_deviations"
      expr: COUNT(CASE WHEN severity_classification = 'Critical' THEN 1 END)
      comment: "Count of critical deviations with significant impact on safety or data integrity"
    - name: "regulatory_reportable_deviations"
      expr: COUNT(CASE WHEN regulatory_reportability_flag = TRUE THEN 1 END)
      comment: "Count of deviations requiring regulatory authority notification"
    - name: "deviations_with_safety_impact"
      expr: COUNT(CASE WHEN impact_on_subject_safety IS NOT NULL AND impact_on_subject_safety != 'None' THEN 1 END)
      comment: "Count of deviations impacting patient safety for risk management"
    - name: "deviations_with_data_integrity_impact"
      expr: COUNT(CASE WHEN impact_on_data_integrity IS NOT NULL AND impact_on_data_integrity != 'None' THEN 1 END)
      comment: "Count of deviations affecting data integrity for study validity assessment"
    - name: "closed_deviations"
      expr: COUNT(CASE WHEN deviation_status = 'Closed' THEN 1 END)
      comment: "Count of closed deviations for resolution rate tracking"
    - name: "open_deviations"
      expr: COUNT(CASE WHEN deviation_status = 'Open' THEN 1 END)
      comment: "Count of open deviations requiring ongoing corrective action"
    - name: "unique_trials_with_deviations"
      expr: COUNT(DISTINCT trial_id)
      comment: "Number of unique trials with protocol deviations for site quality benchmarking"
    - name: "unique_sites_with_deviations"
      expr: COUNT(DISTINCT investigational_site_id)
      comment: "Number of unique sites with protocol deviations for site performance monitoring"
    - name: "unique_patients_with_deviations"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients affected by protocol deviations"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_biomarker_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Precision medicine and companion diagnostics metrics tracking biomarker testing, CDx approval status, mutation detection, and result interpretation for personalized therapy selection"
  source: "`pharmaceuticals_ecm`.`patient`.`biomarker_result`"
  dimensions:
    - name: "biomarker_name"
      expr: biomarker_name
      comment: "Name of the biomarker tested for therapeutic targeting"
    - name: "gene_name"
      expr: gene_name
      comment: "Gene name associated with the biomarker for genomic profiling"
    - name: "mutation_type"
      expr: mutation_type
      comment: "Type of genetic mutation detected (e.g., SNV, indel, fusion)"
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the biomarker result (e.g., positive, negative, indeterminate)"
    - name: "cdx_approved_flag"
      expr: cdx_approved_flag
      comment: "Whether the biomarker is a companion diagnostic approved by regulatory authorities"
    - name: "cdx_drug_indication"
      expr: cdx_drug_indication
      comment: "Drug indication associated with the companion diagnostic"
    - name: "assay_type"
      expr: assay_type
      comment: "Type of assay used for biomarker testing (e.g., NGS, IHC, PCR)"
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "Quality control status of the biomarker test result"
    - name: "result_status"
      expr: result_status
      comment: "Status of the biomarker result (e.g., final, preliminary, amended)"
    - name: "result_year"
      expr: YEAR(result_date)
      comment: "Year of biomarker result for temporal trend analysis"
    - name: "result_quarter"
      expr: CONCAT(CAST(YEAR(result_date) AS STRING), '-Q', CAST(QUARTER(result_date) AS STRING))
      comment: "Year-quarter of biomarker result"
  measures:
    - name: "total_biomarker_tests"
      expr: COUNT(1)
      comment: "Total number of biomarker tests performed for precision medicine utilization tracking"
    - name: "cdx_approved_tests"
      expr: COUNT(CASE WHEN cdx_approved_flag = TRUE THEN 1 END)
      comment: "Count of companion diagnostic tests for regulatory-approved biomarker utilization"
    - name: "positive_results"
      expr: COUNT(CASE WHEN result_interpretation = 'Positive' THEN 1 END)
      comment: "Count of positive biomarker results for patient selection and targeting rate"
    - name: "negative_results"
      expr: COUNT(CASE WHEN result_interpretation = 'Negative' THEN 1 END)
      comment: "Count of negative biomarker results for screening efficiency assessment"
    - name: "unique_patients_tested"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with biomarker testing for precision medicine reach"
    - name: "unique_genes_tested"
      expr: COUNT(DISTINCT gene_name)
      comment: "Number of unique genes tested for genomic profiling breadth"
    - name: "unique_biomarkers_tested"
      expr: COUNT(DISTINCT biomarker_name)
      comment: "Number of unique biomarkers tested for diagnostic portfolio coverage"
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average numeric biomarker result value for quantitative biomarker analysis"
    - name: "avg_allele_frequency"
      expr: AVG(CAST(allele_frequency AS DOUBLE))
      comment: "Average allele frequency for mutation prevalence assessment"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_treatment_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug exposure and compliance metrics tracking dosing, administration, modifications, and treatment adherence for safety analysis and efficacy correlation"
  source: "`pharmaceuticals_ecm`.`patient`.`treatment_exposure`"
  dimensions:
    - name: "treatment_arm"
      expr: treatment_arm
      comment: "Treatment arm for exposure comparison across study cohorts"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of drug administration (e.g., IV, oral, subcutaneous)"
    - name: "treatment_status"
      expr: treatment_status
      comment: "Current treatment status (e.g., ongoing, completed, discontinued)"
    - name: "dose_modification_flag"
      expr: dose_modification_flag
      comment: "Whether dose was modified from planned dose"
    - name: "dose_modification_reason"
      expr: dose_modification_reason
      comment: "Reason for dose modification (e.g., adverse event, efficacy, protocol)"
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the treatment for trial integrity monitoring"
    - name: "administration_year"
      expr: YEAR(administration_date)
      comment: "Year of drug administration for temporal exposure analysis"
    - name: "administration_quarter"
      expr: CONCAT(CAST(YEAR(administration_date) AS STRING), '-Q', CAST(QUARTER(administration_date) AS STRING))
      comment: "Year-quarter of drug administration"
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_date)
      comment: "Month of drug administration for granular exposure tracking"
  measures:
    - name: "total_treatment_exposures"
      expr: COUNT(1)
      comment: "Total number of treatment exposure records for dosing frequency analysis"
    - name: "unique_patients_treated"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients receiving treatment for exposure population sizing"
    - name: "dose_modifications"
      expr: COUNT(CASE WHEN dose_modification_flag = TRUE THEN 1 END)
      comment: "Count of dose modifications for safety and tolerability assessment"
    - name: "total_dose_administered"
      expr: SUM(CAST(dose_administered AS DOUBLE))
      comment: "Total cumulative dose administered across all exposures for drug utilization"
    - name: "total_planned_dose"
      expr: SUM(CAST(planned_dose AS DOUBLE))
      comment: "Total planned dose across all exposures for protocol adherence comparison"
    - name: "total_cumulative_dose"
      expr: SUM(CAST(cumulative_dose AS DOUBLE))
      comment: "Total cumulative dose per patient for exposure-response analysis"
    - name: "avg_dose_administered"
      expr: AVG(CAST(dose_administered AS DOUBLE))
      comment: "Average dose administered per exposure event"
    - name: "avg_treatment_compliance_pct"
      expr: AVG(CAST(treatment_compliance_percentage AS DOUBLE))
      comment: "Average treatment compliance percentage for adherence monitoring"
    - name: "avg_infusion_duration_minutes"
      expr: AVG(CAST(duration_of_infusion_minutes AS DOUBLE))
      comment: "Average infusion duration in minutes for administration protocol compliance"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_informed_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory compliance and patient rights metrics tracking consent status, withdrawal, data subject rights, and GDPR/HIPAA compliance for ethical trial conduct and privacy governance"
  source: "`pharmaceuticals_ecm`.`patient`.`informed_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of informed consent (e.g., obtained, withdrawn, expired)"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent obtained (e.g., main study, substudy, genetic)"
    - name: "consent_method"
      expr: consent_method
      comment: "Method of consent collection (e.g., paper, electronic, verbal)"
    - name: "consent_channel"
      expr: consent_channel
      comment: "Channel through which consent was obtained"
    - name: "withdrawal_reason"
      expr: withdrawal_reason
      comment: "Reason for consent withdrawal for retention strategy optimization"
    - name: "gdpr_lawful_basis"
      expr: gdpr_lawful_basis
      comment: "GDPR lawful basis for data processing for privacy compliance"
    - name: "hipaa_authorization_flag"
      expr: hipaa_authorization_flag
      comment: "Whether HIPAA authorization was obtained for US regulatory compliance"
    - name: "future_use_consent_flag"
      expr: future_use_consent_flag
      comment: "Whether patient consented to future use of data/samples"
    - name: "genetic_substudy_consent_flag"
      expr: genetic_substudy_consent_flag
      comment: "Whether patient consented to genetic substudy participation"
    - name: "biomarker_substudy_consent_flag"
      expr: biomarker_substudy_consent_flag
      comment: "Whether patient consented to biomarker substudy participation"
    - name: "data_subject_rights_request_type"
      expr: data_subject_rights_request_type
      comment: "Type of data subject rights request (e.g., access, erasure, portability)"
    - name: "consent_obtained_year"
      expr: YEAR(consent_obtained_date)
      comment: "Year consent was obtained for temporal compliance tracking"
    - name: "consent_obtained_quarter"
      expr: CONCAT(CAST(YEAR(consent_obtained_date) AS STRING), '-Q', CAST(QUARTER(consent_obtained_date) AS STRING))
      comment: "Year-quarter consent was obtained"
  measures:
    - name: "total_consents"
      expr: COUNT(1)
      comment: "Total number of informed consent records for regulatory compliance tracking"
    - name: "active_consents"
      expr: COUNT(CASE WHEN consent_status = 'Active' THEN 1 END)
      comment: "Count of active consents for current enrollment eligibility"
    - name: "withdrawn_consents"
      expr: COUNT(CASE WHEN consent_status = 'Withdrawn' THEN 1 END)
      comment: "Count of withdrawn consents for retention analysis and ethics monitoring"
    - name: "expired_consents"
      expr: COUNT(CASE WHEN consent_status = 'Expired' THEN 1 END)
      comment: "Count of expired consents requiring re-consent for continued participation"
    - name: "econsent_adoptions"
      expr: COUNT(CASE WHEN consent_method = 'Electronic' THEN 1 END)
      comment: "Count of electronic consents for digital transformation tracking"
    - name: "hipaa_authorizations"
      expr: COUNT(CASE WHEN hipaa_authorization_flag = TRUE THEN 1 END)
      comment: "Count of HIPAA authorizations for US regulatory compliance"
    - name: "future_use_consents"
      expr: COUNT(CASE WHEN future_use_consent_flag = TRUE THEN 1 END)
      comment: "Count of future use consents for long-term research asset value"
    - name: "genetic_substudy_consents"
      expr: COUNT(CASE WHEN genetic_substudy_consent_flag = TRUE THEN 1 END)
      comment: "Count of genetic substudy consents for precision medicine research capacity"
    - name: "biomarker_substudy_consents"
      expr: COUNT(CASE WHEN biomarker_substudy_consent_flag = TRUE THEN 1 END)
      comment: "Count of biomarker substudy consents for translational research participation"
    - name: "data_subject_rights_requests"
      expr: COUNT(CASE WHEN data_subject_rights_request_type IS NOT NULL THEN 1 END)
      comment: "Count of data subject rights requests for GDPR compliance monitoring"
    - name: "unique_patients_consented"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with informed consent for enrollment tracking"
    - name: "unique_trials_with_consent"
      expr: COUNT(DISTINCT trial_id)
      comment: "Number of unique trials with informed consent records"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_support_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient support program performance metrics tracking enrollment, benefit disbursement, adherence monitoring, and operational efficiency for commercial patient services and access programs"
  source: "`pharmaceuticals_ecm`.`patient`.`support_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of the patient support program"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area served by the support program"
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method of patient enrollment into the support program"
    - name: "adherence_monitoring_enabled_flag"
      expr: adherence_monitoring_enabled_flag
      comment: "Whether adherence monitoring is enabled for the program"
    - name: "reimbursement_support_flag"
      expr: reimbursement_support_flag
      comment: "Whether the program provides reimbursement support services"
    - name: "prior_authorization_support_flag"
      expr: prior_authorization_support_flag
      comment: "Whether the program provides prior authorization support"
    - name: "nurse_educator_support_flag"
      expr: nurse_educator_support_flag
      comment: "Whether the program provides nurse educator support services"
    - name: "commercial_payer_only_flag"
      expr: commercial_payer_only_flag
      comment: "Whether the program is restricted to commercial payer patients only"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the program with regulatory and legal requirements"
    - name: "program_start_year"
      expr: YEAR(program_start_date)
      comment: "Year the program started for program lifecycle analysis"
  measures:
    - name: "total_support_programs"
      expr: COUNT(1)
      comment: "Total number of patient support programs for portfolio coverage assessment"
    - name: "active_support_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Count of active patient support programs for current operational capacity"
    - name: "total_enrolled_patients_sum"
      expr: SUM(CAST(total_enrolled_patients AS DOUBLE))
      comment: "Total number of patients enrolled across all support programs for reach assessment"
    - name: "active_enrolled_patients_sum"
      expr: SUM(CAST(active_enrolled_patients AS DOUBLE))
      comment: "Total number of currently active enrolled patients for operational workload"
    - name: "total_benefit_disbursed"
      expr: SUM(CAST(total_benefit_disbursed_amount AS DOUBLE))
      comment: "Total financial benefit disbursed to patients for program cost and ROI analysis"
    - name: "programs_with_adherence_monitoring"
      expr: COUNT(CASE WHEN adherence_monitoring_enabled_flag = TRUE THEN 1 END)
      comment: "Count of programs with adherence monitoring for patient outcomes optimization"
    - name: "programs_with_reimbursement_support"
      expr: COUNT(CASE WHEN reimbursement_support_flag = TRUE THEN 1 END)
      comment: "Count of programs offering reimbursement support for access barrier mitigation"
    - name: "programs_with_pa_support"
      expr: COUNT(CASE WHEN prior_authorization_support_flag = TRUE THEN 1 END)
      comment: "Count of programs offering prior authorization support for access acceleration"
    - name: "programs_with_nurse_educator"
      expr: COUNT(CASE WHEN nurse_educator_support_flag = TRUE THEN 1 END)
      comment: "Count of programs with nurse educator support for patient education and adherence"
    - name: "avg_benefit_per_program"
      expr: AVG(CAST(total_benefit_disbursed_amount AS DOUBLE))
      comment: "Average benefit disbursed per program for cost benchmarking"
$$;