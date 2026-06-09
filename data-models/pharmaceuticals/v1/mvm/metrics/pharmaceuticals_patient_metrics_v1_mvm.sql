-- Metric views for domain: patient | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacovigilance KPIs over adverse event records. Tracks serious adverse event rates, SUSAR flags, regulatory reporting compliance, and outcome distributions to support patient safety governance and regulatory obligations."
  source: "`pharmaceuticals_ecm`.`patient`.`adverse_event`"
  dimensions:
    - name: "meddra_soc_name"
      expr: meddra_soc_name
      comment: "MedDRA System Organ Class name — primary clinical taxonomy for grouping adverse events by body system for safety signal detection."
    - name: "meddra_pt_name"
      expr: meddra_pt_name
      comment: "MedDRA Preferred Term — granular adverse event term used for signal detection and regulatory reporting."
    - name: "severity_grade"
      expr: severity_grade
      comment: "Clinical severity grade (e.g. Grade 1–5 per CTCAE) enabling stratification of adverse events by clinical impact."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Investigator causality assessment (e.g. related, unrelated) — critical for benefit-risk evaluation and labeling decisions."
    - name: "outcome"
      expr: outcome
      comment: "Patient outcome of the adverse event (e.g. recovered, fatal) — key dimension for safety signal severity assessment."
    - name: "expectedness"
      expr: expectedness
      comment: "Whether the adverse event was expected per the current product label — drives SUSAR classification and expedited reporting obligations."
    - name: "reporting_timeline_compliance_status"
      expr: reporting_timeline_compliance_status
      comment: "Compliance status of regulatory reporting timelines (e.g. on-time, late) — used to monitor pharmacovigilance regulatory obligations."
    - name: "action_taken_study_drug"
      expr: action_taken_study_drug
      comment: "Action taken with the study drug in response to the adverse event (e.g. dose reduced, discontinued) — informs dose management analysis."
    - name: "onset_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Calendar month of adverse event onset — enables trend analysis of safety signals over time."
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_date)
      comment: "Calendar month the adverse event was reported — used to monitor reporting volumes and timeliness trends."
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse event records. Baseline volume metric for pharmacovigilance dashboards and safety signal monitoring."
    - name: "serious_adverse_events"
      expr: COUNT(CASE WHEN seriousness_flag = TRUE THEN 1 END)
      comment: "Count of serious adverse events (SAEs). A primary safety KPI — elevated SAE counts trigger regulatory notifications and benefit-risk reassessment."
    - name: "serious_adverse_event_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN seriousness_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse events classified as serious. Tracks the proportion of high-severity safety events relative to total AE volume — a key safety governance KPI."
    - name: "susar_count"
      expr: COUNT(CASE WHEN susar_flag = TRUE THEN 1 END)
      comment: "Count of Suspected Unexpected Serious Adverse Reactions (SUSARs). SUSARs require expedited regulatory reporting within 7–15 days; volume directly impacts regulatory compliance posture."
    - name: "susar_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN susar_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse events classified as SUSARs. Elevated rates signal unexpected safety findings that may require label updates or trial suspension."
    - name: "fatal_adverse_events"
      expr: COUNT(CASE WHEN seriousness_criteria_death = TRUE THEN 1 END)
      comment: "Count of adverse events meeting the death seriousness criterion. Fatal AEs are the most critical safety signal and require immediate regulatory notification."
    - name: "hospitalization_adverse_events"
      expr: COUNT(CASE WHEN seriousness_criteria_hospitalization = TRUE THEN 1 END)
      comment: "Count of adverse events resulting in hospitalization. Hospitalization-driven SAEs are a key healthcare utilization and safety burden metric."
    - name: "life_threatening_adverse_events"
      expr: COUNT(CASE WHEN seriousness_criteria_life_threatening = TRUE THEN 1 END)
      comment: "Count of adverse events classified as life-threatening. Tracks the most severe non-fatal safety outcomes for benefit-risk analysis."
    - name: "reporting_compliant_events"
      expr: COUNT(CASE WHEN reporting_timeline_compliance_status = 'COMPLIANT' THEN 1 END)
      comment: "Count of adverse events reported within regulatory timelines. Measures pharmacovigilance operational compliance — non-compliance can result in regulatory sanctions."
    - name: "reporting_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reporting_timeline_compliance_status = 'COMPLIANT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse events reported within required regulatory timelines. A critical operational KPI for pharmacovigilance teams — below-threshold rates trigger regulatory risk escalation."
    - name: "distinct_patients_with_ae"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients who experienced at least one adverse event. Measures patient-level safety exposure breadth across the safety database."
    - name: "avg_ae_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average duration of adverse events in days. Longer durations indicate greater patient burden and may signal need for dose modification or treatment discontinuation."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial and program enrollment KPIs. Tracks enrollment velocity, screen failure rates, randomization efficiency, population flags, and disposition outcomes to support trial operations and portfolio planning."
  source: "`pharmaceuticals_ecm`.`patient`.`patient_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the patient (e.g. screened, enrolled, completed, discontinued) — primary dimension for enrollment funnel analysis."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (e.g. clinical trial, expanded access, registry) — enables cross-program enrollment comparison."
    - name: "treatment_arm"
      expr: treatment_arm
      comment: "Assigned treatment arm (e.g. active, placebo, dose cohort) — essential for comparative efficacy and safety analysis by arm."
    - name: "region"
      expr: region
      comment: "Geographic region of enrollment — used to monitor regional enrollment performance and identify geographic imbalances."
    - name: "disposition_event_type"
      expr: disposition_event_type
      comment: "Type of patient disposition event (e.g. completed, withdrawn, lost to follow-up) — key for understanding trial completion and attrition patterns."
    - name: "disposition_primary_reason"
      expr: disposition_primary_reason
      comment: "Primary reason for patient disposition — identifies leading causes of discontinuation to inform protocol amendments."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the enrollment record (e.g. blinded, unblinded) — critical for data integrity monitoring in randomized controlled trials."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Calendar month of patient enrollment — enables enrollment velocity trending and milestone tracking."
    - name: "screening_month"
      expr: DATE_TRUNC('MONTH', screening_date)
      comment: "Calendar month of patient screening — used to track screening funnel volume over time."
    - name: "randomization_month"
      expr: DATE_TRUNC('MONTH', randomization_date)
      comment: "Calendar month of patient randomization — tracks randomization velocity against trial milestones."
    - name: "patient_enrollment_status"
      expr: patient_enrollment_status
      comment: "Operational enrollment status at the patient level — used for real-time enrollment tracking dashboards."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total enrollment records. Baseline volume metric for trial enrollment tracking and milestone reporting."
    - name: "distinct_enrolled_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients enrolled. The primary enrollment headcount KPI used in trial milestone and portfolio reporting."
    - name: "randomized_patients"
      expr: COUNT(CASE WHEN randomization_date IS NOT NULL THEN 1 END)
      comment: "Count of patients who have been randomized. Randomization count is the primary trial progress KPI tracked against enrollment targets."
    - name: "screen_failure_count"
      expr: COUNT(CASE WHEN screen_failure_reason IS NOT NULL THEN 1 END)
      comment: "Count of patients who failed screening. High screen failure rates increase trial costs and delay timelines — a key operational efficiency metric."
    - name: "screen_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN screen_failure_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screened patients who failed screening. Elevated rates signal eligibility criteria issues or site selection problems requiring protocol review."
    - name: "itt_population_count"
      expr: COUNT(CASE WHEN itt_population_flag = TRUE THEN 1 END)
      comment: "Count of patients in the Intent-to-Treat (ITT) population. The ITT population is the primary efficacy analysis set — its size directly impacts statistical power."
    - name: "pp_population_count"
      expr: COUNT(CASE WHEN pp_population_flag = TRUE THEN 1 END)
      comment: "Count of patients in the Per-Protocol (PP) population. PP population size affects the sensitivity analysis of efficacy endpoints."
    - name: "safety_population_count"
      expr: COUNT(CASE WHEN safety_population_flag = TRUE THEN 1 END)
      comment: "Count of patients in the safety analysis population. Defines the denominator for all safety incidence rate calculations in clinical study reports."
    - name: "discontinued_patients"
      expr: COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END)
      comment: "Count of patients who discontinued from the program. Discontinuation rates are a key trial retention KPI — high rates threaten statistical power and regulatory acceptance."
    - name: "discontinuation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled patients who discontinued. A critical trial quality metric — rates above protocol thresholds trigger operational interventions."
    - name: "total_benefit_amount_received"
      expr: SUM(CAST(benefit_amount_received AS DOUBLE))
      comment: "Total financial benefit amount received by enrolled patients across support programs. Tracks patient support program financial disbursement for budget management."
    - name: "avg_benefit_amount_per_patient"
      expr: AVG(CAST(benefit_amount_received AS DOUBLE))
      comment: "Average financial benefit amount received per enrollment record. Benchmarks per-patient support costs for program financial planning."
    - name: "consent_to_program_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_to_program_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled patients who consented to the program. Low consent rates may indicate patient communication or trust issues requiring intervention."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_treatment_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treatment administration and dosing KPIs. Tracks dose delivery fidelity, compliance rates, dose modifications, and cumulative exposure to support clinical operations, safety monitoring, and efficacy analysis."
  source: "`pharmaceuticals_ecm`.`patient`.`treatment_exposure`"
  dimensions:
    - name: "treatment_arm"
      expr: treatment_arm
      comment: "Treatment arm assignment — primary dimension for comparing dosing patterns and compliance across study arms."
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route of drug administration (e.g. IV, oral, subcutaneous) — used to analyze administration method impact on compliance and outcomes."
    - name: "treatment_status"
      expr: treatment_status
      comment: "Current treatment status (e.g. ongoing, completed, discontinued) — enables active vs. completed treatment cohort analysis."
    - name: "dose_modification_reason"
      expr: dose_modification_reason
      comment: "Reason for dose modification (e.g. toxicity, patient request) — identifies leading drivers of dose changes for protocol optimization."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the treatment record — critical for data integrity monitoring in double-blind trials."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_date)
      comment: "Calendar month of drug administration — enables treatment activity trending and supply planning."
    - name: "cycle_number"
      expr: cycle_number
      comment: "Treatment cycle number — used to analyze dose delivery patterns and compliance across treatment cycles."
    - name: "frequency"
      expr: frequency
      comment: "Dosing frequency (e.g. QD, BID, weekly) — dimension for comparing compliance rates across dosing schedules."
  measures:
    - name: "total_administrations"
      expr: COUNT(1)
      comment: "Total number of drug administration records. Baseline volume metric for treatment activity monitoring and supply consumption tracking."
    - name: "distinct_treated_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients who received at least one treatment administration. The primary treated-population headcount for safety and efficacy analysis denominators."
    - name: "total_dose_administered"
      expr: SUM(CAST(dose_administered AS DOUBLE))
      comment: "Total cumulative dose administered across all patients and administrations. Tracks aggregate drug exposure for pharmacokinetic and safety analyses."
    - name: "avg_dose_administered"
      expr: AVG(CAST(dose_administered AS DOUBLE))
      comment: "Average dose administered per administration record. Benchmarks actual dosing against planned doses to identify systematic under- or over-dosing."
    - name: "total_planned_dose"
      expr: SUM(CAST(planned_dose AS DOUBLE))
      comment: "Total planned dose across all administration records. Used as the denominator for dose delivery fidelity calculations."
    - name: "dose_delivery_fidelity_rate"
      expr: ROUND(100.0 * SUM(CAST(dose_administered AS DOUBLE)) / NULLIF(SUM(CAST(planned_dose AS DOUBLE)), 0), 2)
      comment: "Percentage of planned dose actually administered (administered/planned). A key clinical operations KPI — low fidelity indicates protocol adherence issues affecting efficacy analysis."
    - name: "dose_modification_count"
      expr: COUNT(CASE WHEN dose_modification_flag = TRUE THEN 1 END)
      comment: "Count of administrations with a dose modification. High modification rates signal tolerability issues and may trigger dose-finding protocol amendments."
    - name: "dose_modification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dose_modification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of administrations requiring dose modification. Elevated rates are a leading indicator of tolerability problems and are tracked in safety monitoring committee reviews."
    - name: "avg_treatment_compliance_percentage"
      expr: AVG(CAST(treatment_compliance_percentage AS DOUBLE))
      comment: "Average treatment compliance percentage across all administration records. A direct measure of patient adherence — below-threshold compliance invalidates per-protocol efficacy analyses."
    - name: "avg_cumulative_dose"
      expr: AVG(CAST(cumulative_dose AS DOUBLE))
      comment: "Average cumulative dose per administration record. Tracks aggregate drug exposure levels for dose-response and safety threshold analyses."
    - name: "total_cumulative_dose"
      expr: SUM(CAST(cumulative_dose AS DOUBLE))
      comment: "Total cumulative dose across all patients. Measures aggregate drug exposure for population-level pharmacovigilance and benefit-risk assessments."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_biomarker_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biomarker testing and companion diagnostic KPIs. Tracks biomarker positivity rates, assay quality, CDx utilization, and result interpretation distributions to support precision medicine strategy and regulatory submissions."
  source: "`pharmaceuticals_ecm`.`patient`.`biomarker_result`"
  dimensions:
    - name: "biomarker_name"
      expr: biomarker_name
      comment: "Name of the biomarker tested (e.g. EGFR, PD-L1, BRCA1) — primary dimension for precision medicine patient stratification analysis."
    - name: "biomarker_code"
      expr: biomarker_code
      comment: "Standardized biomarker code — used for cross-study biomarker harmonization and regulatory submission data packages."
    - name: "assay_type"
      expr: assay_type
      comment: "Type of assay used (e.g. IHC, NGS, PCR) — enables comparison of testing methodology performance and CDx platform strategy."
    - name: "assay_name"
      expr: assay_name
      comment: "Name of the specific assay — used to track CDx platform utilization and compare result concordance across assays."
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the biomarker result (e.g. positive, negative, indeterminate) — primary dimension for patient stratification and eligibility analysis."
    - name: "mutation_type"
      expr: mutation_type
      comment: "Type of genomic mutation detected (e.g. point mutation, amplification, deletion) — used for molecular epidemiology and target patient population sizing."
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biological specimen used (e.g. tissue biopsy, liquid biopsy, blood) — enables comparison of specimen source impact on assay performance."
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "QC status of the biomarker result (e.g. passed, failed, repeat required) — monitors laboratory quality and data reliability."
    - name: "result_month"
      expr: DATE_TRUNC('MONTH', result_date)
      comment: "Calendar month of biomarker result — enables testing volume trending and turnaround time analysis."
    - name: "cdx_approved_flag"
      expr: cdx_approved_flag
      comment: "Whether the assay is an approved companion diagnostic — used to track CDx-guided patient selection compliance."
  measures:
    - name: "total_biomarker_tests"
      expr: COUNT(1)
      comment: "Total number of biomarker test results. Baseline volume metric for precision medicine testing program monitoring."
    - name: "distinct_tested_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with at least one biomarker result. Measures breadth of biomarker testing coverage across the patient population."
    - name: "biomarker_positive_count"
      expr: COUNT(CASE WHEN result_interpretation = 'POSITIVE' THEN 1 END)
      comment: "Count of biomarker-positive results. Determines the eligible patient population for targeted therapies — a key input to commercial forecasting and trial enrollment planning."
    - name: "biomarker_positivity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN result_interpretation = 'POSITIVE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biomarker tests returning a positive result. Tracks prevalence of targetable biomarkers in the tested population — directly informs addressable market sizing and trial eligibility rates."
    - name: "cdx_approved_test_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cdx_approved_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biomarker tests performed using an approved companion diagnostic. Measures CDx compliance — regulators and payers require CDx-guided prescribing for targeted therapies."
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_control_status = 'PASSED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biomarker tests passing quality control. Low QC pass rates indicate laboratory quality issues that compromise data integrity and patient eligibility decisions."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average numeric biomarker result value. Tracks population-level biomarker expression levels for dose-response and efficacy correlation analyses."
    - name: "avg_allele_frequency"
      expr: AVG(CAST(allele_frequency AS DOUBLE))
      comment: "Average variant allele frequency across biomarker results. Monitors mutation burden levels in the tested population — relevant for liquid biopsy monitoring and treatment response assessment."
    - name: "indeterminate_result_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN result_interpretation = 'INDETERMINATE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of biomarker tests with indeterminate results. High indeterminate rates indicate assay performance issues that delay patient eligibility decisions and increase testing costs."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_protocol_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial protocol deviation KPIs. Tracks deviation frequency, severity, regulatory reportability, and corrective action compliance to support trial quality management and regulatory inspection readiness."
  source: "`pharmaceuticals_ecm`.`patient`.`protocol_deviation`"
  dimensions:
    - name: "deviation_type"
      expr: deviation_type
      comment: "Type of protocol deviation (e.g. eligibility, dosing, visit window) — primary dimension for identifying systemic protocol compliance issues."
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity classification of the deviation (e.g. major, minor, critical) — used to prioritize CAPA resources and assess regulatory risk."
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current status of the deviation record (e.g. open, closed, under review) — tracks resolution progress for quality management."
    - name: "impact_on_subject_safety"
      expr: impact_on_subject_safety
      comment: "Assessment of the deviation's impact on subject safety — critical dimension for regulatory risk stratification."
    - name: "impact_on_data_integrity"
      expr: impact_on_data_integrity
      comment: "Assessment of the deviation's impact on data integrity — used to identify deviations that may compromise the statistical analysis dataset."
    - name: "deviation_month"
      expr: DATE_TRUNC('MONTH', deviation_date)
      comment: "Calendar month of protocol deviation occurrence — enables trending of deviation rates over the trial lifecycle."
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Calendar month the deviation was discovered — used to measure detection lag and monitoring effectiveness."
  measures:
    - name: "total_protocol_deviations"
      expr: COUNT(1)
      comment: "Total number of protocol deviation records. Baseline volume metric for trial quality monitoring — high deviation counts are a leading indicator of site quality issues."
    - name: "distinct_patients_with_deviation"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with at least one protocol deviation. Measures the breadth of protocol non-compliance across the patient population."
    - name: "major_deviation_count"
      expr: COUNT(CASE WHEN severity_classification = 'MAJOR' THEN 1 END)
      comment: "Count of major protocol deviations. Major deviations can exclude patients from per-protocol analysis and trigger regulatory queries — a critical trial quality KPI."
    - name: "major_deviation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity_classification = 'MAJOR' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations classified as major. Elevated rates signal systemic site quality problems requiring immediate CAPA and potential site suspension."
    - name: "regulatory_reportable_deviation_count"
      expr: COUNT(CASE WHEN regulatory_reportability_flag = TRUE THEN 1 END)
      comment: "Count of deviations requiring regulatory reporting. Tracks the volume of deviations that create regulatory submission obligations — a direct compliance risk metric."
    - name: "regulatory_reportable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reportability_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations that are regulatory reportable. High rates increase regulatory scrutiny and submission workload — tracked in quality management reviews."
    - name: "open_deviation_count"
      expr: COUNT(CASE WHEN deviation_status = 'OPEN' THEN 1 END)
      comment: "Count of currently open (unresolved) protocol deviations. Open deviation backlog is a key inspection readiness metric — regulators expect timely CAPA closure."
    - name: "capa_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations with a completed corrective action. Measures CAPA effectiveness — low rates indicate quality system deficiencies that increase regulatory inspection risk."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_informed_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient informed consent governance KPIs. Tracks consent coverage, GDPR/HIPAA compliance, withdrawal rates, and re-consent activity to support regulatory compliance, data privacy governance, and patient rights management."
  source: "`pharmaceuticals_ecm`.`patient`.`informed_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the informed consent (e.g. active, withdrawn, expired) — primary dimension for consent coverage monitoring."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g. main study, biomarker substudy, genetic substudy) — used to track consent coverage across study components."
    - name: "consent_category"
      expr: consent_category
      comment: "Category of consent (e.g. initial, re-consent, amendment) — tracks consent lifecycle events and re-consent compliance."
    - name: "gdpr_lawful_basis"
      expr: gdpr_lawful_basis
      comment: "GDPR lawful basis for data processing (e.g. consent, legitimate interest) — critical for data privacy compliance monitoring in EU jurisdictions."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent (e.g. paper, eConsent) — tracks digital consent adoption and process standardization."
    - name: "consent_language"
      expr: consent_language
      comment: "Language in which consent was obtained — monitors language accessibility compliance for diverse patient populations."
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_obtained_date)
      comment: "Calendar month consent was obtained — enables consent activity trending and enrollment correlation analysis."
    - name: "withdrawal_month"
      expr: DATE_TRUNC('MONTH', consent_withdrawal_date)
      comment: "Calendar month of consent withdrawal — tracks withdrawal trends that may signal patient trust or communication issues."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of informed consent records. Baseline volume metric for consent governance monitoring."
    - name: "distinct_consented_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with an informed consent record. Measures consent coverage across the patient population — a fundamental regulatory compliance requirement."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active informed consents. Active consent is a prerequisite for patient data use — tracking ensures no data is processed without valid consent."
    - name: "consent_withdrawal_count"
      expr: COUNT(CASE WHEN consent_withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Count of consent withdrawals. Withdrawal events trigger data deletion or anonymization obligations under GDPR — volume drives data privacy operational workload."
    - name: "consent_withdrawal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_withdrawal_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that have been withdrawn. Elevated withdrawal rates signal patient trust issues or inadequate consent processes requiring intervention."
    - name: "hipaa_authorization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hipaa_authorization_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with HIPAA authorization. Measures HIPAA compliance coverage for US-based patients — non-compliance creates significant regulatory and legal risk."
    - name: "future_use_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN future_use_consent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients consenting to future use of their data/samples. Higher rates expand the research data asset and reduce future re-consent burden — a strategic data governance KPI."
    - name: "biomarker_substudy_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN biomarker_substudy_consent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients consenting to biomarker substudy participation. Determines the biomarker-evaluable population size — critical for precision medicine substudy statistical planning."
    - name: "genetic_substudy_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN genetic_substudy_consent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of patients consenting to genetic substudy participation. Determines the pharmacogenomics-evaluable population — informs companion diagnostic development strategy."
    - name: "data_subject_rights_pending_count"
      expr: COUNT(CASE WHEN data_subject_rights_request_date IS NOT NULL AND data_subject_rights_fulfillment_date IS NULL THEN 1 END)
      comment: "Count of data subject rights requests not yet fulfilled. GDPR mandates fulfillment within 30 days — open request backlog is a direct regulatory compliance risk metric."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_reported_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient-reported outcome (PRO) and clinical endpoint KPIs. Tracks PRO completion rates, score distributions, clinically meaningful change rates, and data quality to support regulatory submissions and health economics evidence generation."
  source: "`pharmaceuticals_ecm`.`patient`.`reported_outcome`"
  dimensions:
    - name: "instrument_name"
      expr: instrument_name
      comment: "Name of the PRO instrument (e.g. EQ-5D, FACT-G, SF-36) — primary dimension for comparing patient-reported outcomes across validated instruments."
    - name: "domain_name"
      expr: domain_name
      comment: "PRO domain or subscale name (e.g. physical functioning, pain, fatigue) — enables granular quality-of-life dimension analysis."
    - name: "completion_status"
      expr: completion_status
      comment: "Status of PRO completion (e.g. complete, partial, missing) — used to monitor data completeness and compliance."
    - name: "completion_method"
      expr: completion_method
      comment: "Method of PRO completion (e.g. ePRO, paper, interview) — tracks digital PRO adoption and mode-of-administration effects."
    - name: "language_code"
      expr: language_code
      comment: "Language in which the PRO was completed — monitors linguistic accessibility and cross-cultural validity of PRO data."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Calendar month of PRO completion — enables longitudinal quality-of-life trending across the treatment timeline."
    - name: "baseline_flag"
      expr: baseline_flag
      comment: "Whether the assessment is a baseline measurement — used to separate baseline from on-treatment PRO assessments for change-from-baseline analyses."
  measures:
    - name: "total_pro_assessments"
      expr: COUNT(1)
      comment: "Total number of patient-reported outcome assessments. Baseline volume metric for PRO data collection monitoring."
    - name: "distinct_patients_with_pro"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with at least one PRO assessment. Measures PRO coverage across the enrolled population — a key data completeness metric for regulatory submissions."
    - name: "pro_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'COMPLETE' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PRO assessments completed. PRO completion rates below regulatory thresholds (typically 80%) can invalidate PRO endpoints in regulatory submissions — a critical data quality KPI."
    - name: "clinically_meaningful_change_count"
      expr: COUNT(CASE WHEN clinically_meaningful_change_flag = TRUE THEN 1 END)
      comment: "Count of PRO assessments showing clinically meaningful change from baseline. Tracks the proportion of patients achieving meaningful symptom or quality-of-life improvement — a primary PRO efficacy endpoint."
    - name: "clinically_meaningful_change_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN clinically_meaningful_change_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PRO assessments showing clinically meaningful change. A key patient-centered efficacy KPI used in health technology assessments and payer value dossiers."
    - name: "avg_total_score"
      expr: AVG(CAST(total_score AS DOUBLE))
      comment: "Average total PRO score across assessments. Tracks population-level quality-of-life or symptom burden — the primary summary statistic for PRO endpoint reporting."
    - name: "avg_subscale_score"
      expr: AVG(CAST(subscale_score AS DOUBLE))
      comment: "Average subscale PRO score. Enables domain-level quality-of-life analysis (e.g. average pain subscale score) for granular patient burden assessment."
    - name: "data_locked_assessment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_lock_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PRO assessments with data locked. Data lock rate measures database cleaning progress — a key milestone metric for clinical study report timelines."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PRO assessments completed within the protocol-defined assessment window. Window compliance is required for valid longitudinal PRO analysis in regulatory submissions."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_support_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient support program financial and operational KPIs. Tracks benefit disbursement, program compliance, service capability coverage, and operational performance to support commercial access strategy and patient services investment decisions."
  source: "`pharmaceuticals_ecm`.`patient`.`support_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of the support program (e.g. active, closed, suspended) — primary dimension for active program portfolio monitoring."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area served by the support program — enables cross-TA comparison of patient support investment and reach."
    - name: "enrollment_method"
      expr: enrollment_method
      comment: "Method used to enroll patients in the support program (e.g. HCP referral, patient self-enroll) — tracks channel effectiveness for patient services outreach."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the support program (e.g. compliant, non-compliant, under review) — monitors regulatory and operational compliance of patient services."
    - name: "program_start_month"
      expr: DATE_TRUNC('MONTH', program_start_date)
      comment: "Calendar month the support program launched — used for program cohort analysis and benefit disbursement trending."
  measures:
    - name: "total_support_programs"
      expr: COUNT(1)
      comment: "Total number of patient support program records. Baseline portfolio count for patient services management."
    - name: "total_benefit_disbursed"
      expr: SUM(CAST(total_benefit_disbursed_amount AS DOUBLE))
      comment: "Total financial benefit disbursed across all support programs. The primary financial KPI for patient support program investment — tracked against budget and commercial access strategy targets."
    - name: "avg_benefit_disbursed_per_program"
      expr: AVG(CAST(total_benefit_disbursed_amount AS DOUBLE))
      comment: "Average benefit disbursed per support program. Benchmarks per-program financial performance for resource allocation and vendor contract management."
    - name: "active_program_count"
      expr: COUNT(CASE WHEN program_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active patient support programs. Tracks the active patient services portfolio size for operational capacity planning."
    - name: "nurse_educator_support_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN nurse_educator_support_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support programs offering nurse educator support. Nurse educator programs improve adherence and outcomes — coverage rate informs patient services capability investment decisions."
    - name: "prior_authorization_support_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN prior_authorization_support_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support programs offering prior authorization support. PA support is a critical access enabler — coverage rate directly impacts patient access to therapy."
    - name: "reimbursement_support_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reimbursement_support_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support programs offering reimbursement support. Reimbursement support reduces patient financial burden and improves therapy initiation rates — a key access strategy metric."
    - name: "adherence_monitoring_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN adherence_monitoring_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of support programs with adherence monitoring enabled. Adherence monitoring programs improve persistence and outcomes — coverage rate informs patient services technology investment."
    - name: "sunshine_act_reportable_program_count"
      expr: COUNT(CASE WHEN sunshine_act_reportable_flag = TRUE THEN 1 END)
      comment: "Count of support programs subject to Sunshine Act reporting. Tracks the volume of programs creating Open Payments reporting obligations — a direct compliance workload and risk metric."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`patient_clinical_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical observation and laboratory result KPIs. Tracks out-of-range rates, toxicity grade distributions, baseline deviations, and endpoint response rates to support safety monitoring and efficacy signal detection."
  source: "`pharmaceuticals_ecm`.`patient`.`clinical_observation`"
  dimensions:
    - name: "observation_category"
      expr: observation_category
      comment: "Category of clinical observation (e.g. laboratory, vital signs, ECG) — primary dimension for clinical data type stratification."
    - name: "test_name"
      expr: test_name
      comment: "Name of the clinical test or assessment — enables parameter-level safety and efficacy signal monitoring."
    - name: "toxicity_grade"
      expr: toxicity_grade
      comment: "CTCAE toxicity grade of the observation — primary safety dimension for dose-limiting toxicity and safety monitoring committee reviews."
    - name: "clinical_endpoint_type"
      expr: clinical_endpoint_type
      comment: "Type of clinical endpoint (e.g. primary, secondary, exploratory) — used to stratify observations by their regulatory and statistical significance."
    - name: "result_interpretation"
      expr: result_interpretation
      comment: "Clinical interpretation of the observation result (e.g. normal, abnormal, clinically significant) — key dimension for safety signal detection."
    - name: "biomarker_type"
      expr: biomarker_type
      comment: "Type of biomarker assessed (e.g. predictive, prognostic, pharmacodynamic) — used to stratify observations by their clinical utility."
    - name: "observation_month"
      expr: DATE_TRUNC('MONTH', collection_datetime)
      comment: "Calendar month of clinical observation collection — enables longitudinal safety and efficacy parameter trending."
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the observation record (e.g. final, preliminary, amended) — used to filter analysis to verified data."
  measures:
    - name: "total_observations"
      expr: COUNT(1)
      comment: "Total number of clinical observation records. Baseline volume metric for clinical data collection monitoring."
    - name: "distinct_patients_observed"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with at least one clinical observation. Measures clinical assessment coverage across the enrolled population."
    - name: "out_of_range_observation_count"
      expr: COUNT(CASE WHEN out_of_range_indicator IS NOT NULL AND out_of_range_indicator != 'NORMAL' THEN 1 END)
      comment: "Count of clinical observations outside the reference range. Out-of-range observations are the primary safety signal source — volume and trend drive safety monitoring committee agendas."
    - name: "out_of_range_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_range_indicator IS NOT NULL AND out_of_range_indicator != 'NORMAL' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clinical observations outside the reference range. Elevated rates signal systemic safety concerns or assay quality issues requiring clinical review."
    - name: "avg_result_value_numeric"
      expr: AVG(CAST(result_value_numeric AS DOUBLE))
      comment: "Average numeric result value across clinical observations. Tracks population-level parameter trends for pharmacodynamic and safety endpoint analyses."
    - name: "avg_baseline_value"
      expr: AVG(CAST(baseline_value AS DOUBLE))
      comment: "Average baseline value across clinical observations. Establishes population-level baseline for change-from-baseline efficacy and safety analyses."
    - name: "delta_from_baseline_count"
      expr: COUNT(CASE WHEN delta_from_baseline_flag = TRUE THEN 1 END)
      comment: "Count of observations flagged as showing a meaningful delta from baseline. Tracks the number of patients with clinically significant parameter changes — a key efficacy and safety signal metric."
    - name: "high_toxicity_grade_count"
      expr: COUNT(CASE WHEN toxicity_grade IN ('3', '4', '5') THEN 1 END)
      comment: "Count of observations with Grade 3, 4, or 5 toxicity. High-grade toxicities are dose-limiting and safety-critical — volume drives dose modification decisions and safety committee escalations."
    - name: "high_toxicity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN toxicity_grade IN ('3', '4', '5') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of observations with Grade 3+ toxicity. A primary safety KPI for oncology trials — rates above protocol thresholds trigger dose modification rules and safety holds."
$$;