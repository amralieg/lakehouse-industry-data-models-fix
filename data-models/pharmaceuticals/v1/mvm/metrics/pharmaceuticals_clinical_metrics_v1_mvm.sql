-- Metric views for domain: clinical | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_trial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for clinical trial portfolio management — tracks trial pipeline composition, phase distribution, enrollment performance, and timeline adherence to support R&D investment decisions."
  source: "`pharmaceuticals_ecm`.`clinical`.`trial`"
  dimensions:
    - name: "trial_phase"
      expr: phase
      comment: "Clinical development phase (Phase I, II, III, IV) for portfolio segmentation and pipeline analysis."
    - name: "trial_status"
      expr: trial_status
      comment: "Current operational status of the trial (e.g., Ongoing, Completed, Terminated) for portfolio health monitoring."
    - name: "study_design_type"
      expr: study_design_type
      comment: "Design classification of the trial (e.g., Randomized, Open-Label, Crossover) for scientific rigor segmentation."
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding methodology (e.g., Double-Blind, Open-Label) used in the trial."
    - name: "is_adaptive_design"
      expr: is_adaptive_design
      comment: "Indicates whether the trial uses an adaptive design, relevant for regulatory and operational complexity assessment."
    - name: "is_pediatric_study"
      expr: is_pediatric_study
      comment: "Flags pediatric studies for regulatory obligation tracking and portfolio diversity reporting."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year the trial was planned to start, used for cohort and vintage analysis of the trial portfolio."
    - name: "actual_start_year"
      expr: DATE_TRUNC('YEAR', actual_start_date)
      comment: "Year the trial actually started, used to assess planning accuracy and portfolio ramp-up."
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "GCP compliance status of the trial, critical for regulatory risk monitoring."
    - name: "regulatory_submission_type"
      expr: regulatory_submission_type
      comment: "Type of regulatory submission associated with the trial (e.g., IND, NDA, BLA) for regulatory pipeline tracking."
  measures:
    - name: "total_trials"
      expr: COUNT(1)
      comment: "Total number of clinical trials in the portfolio. Baseline KPI for pipeline size and capacity planning."
    - name: "active_trials"
      expr: COUNT(CASE WHEN trial_status = 'Ongoing' THEN 1 END)
      comment: "Number of currently active/ongoing trials. Drives resource allocation and site management decisions."
    - name: "terminated_trials"
      expr: COUNT(CASE WHEN trial_status = 'Terminated' THEN 1 END)
      comment: "Number of terminated trials. A rising count signals pipeline attrition risk and R&D investment loss."
    - name: "trial_termination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN trial_status = 'Terminated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trials that were terminated. Key R&D efficiency and portfolio risk KPI for executive review."
    - name: "adaptive_design_trial_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_adaptive_design = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trials using adaptive design. Reflects innovation in trial methodology and regulatory strategy."
    - name: "pediatric_study_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_pediatric_study = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of trials that are pediatric studies. Tracks regulatory obligation fulfillment for pediatric development plans."
    - name: "trials_with_database_lock"
      expr: COUNT(CASE WHEN database_lock_date IS NOT NULL THEN 1 END)
      comment: "Number of trials that have reached database lock, indicating readiness for statistical analysis and regulatory submission."
    - name: "trials_with_csr_completed"
      expr: COUNT(CASE WHEN csr_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of trials with a completed Clinical Study Report, a key milestone for regulatory dossier submission."
    - name: "gcp_non_compliant_trials"
      expr: COUNT(CASE WHEN gcp_compliance_status != 'Compliant' AND gcp_compliance_status IS NOT NULL THEN 1 END)
      comment: "Number of trials with non-compliant GCP status. A critical quality and regulatory risk indicator for executive oversight."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment performance and subject population KPIs — tracks screening, randomization, retention, and population flag rates to steer trial execution and data integrity decisions."
  source: "`pharmaceuticals_ecm`.`clinical`.`clinical_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the subject (e.g., Enrolled, Withdrawn, Completed, Screen Failure) for cohort tracking."
    - name: "treatment_arm_code"
      expr: treatment_arm_code
      comment: "Treatment arm assignment code for comparative efficacy and safety analysis across arms."
    - name: "treatment_arm_description"
      expr: treatment_arm_description
      comment: "Human-readable description of the treatment arm for reporting and dashboard labeling."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the enrolled subject record, used to monitor unblinding events and data integrity."
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason a subject failed screening, used to optimize eligibility criteria and site selection."
    - name: "withdrawal_reason"
      expr: withdrawal_reason
      comment: "Reason for subject withdrawal, critical for retention analysis and protocol amendment decisions."
    - name: "enrollment_year"
      expr: DATE_TRUNC('YEAR', enrollment_date)
      comment: "Year of subject enrollment for longitudinal enrollment ramp analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of subject enrollment for granular enrollment velocity tracking."
    - name: "randomization_date_month"
      expr: DATE_TRUNC('MONTH', randomization_date)
      comment: "Month of randomization for tracking randomization ramp and site performance."
    - name: "stratification_factor_1"
      expr: stratification_factor_1
      comment: "Primary stratification factor used in randomization, enabling subgroup analysis for efficacy endpoints."
    - name: "stratification_factor_2"
      expr: stratification_factor_2
      comment: "Secondary stratification factor for multi-dimensional subgroup analysis."
    - name: "data_lock_flag"
      expr: data_lock_flag
      comment: "Indicates whether the subject record has been locked for analysis, used to track data readiness."
  measures:
    - name: "total_subjects_screened"
      expr: COUNT(1)
      comment: "Total number of subjects who entered the screening process. Baseline enrollment funnel KPI."
    - name: "subjects_enrolled"
      expr: COUNT(CASE WHEN enrollment_status NOT IN ('Screen Failure') AND eligibility_confirmed = TRUE THEN 1 END)
      comment: "Number of subjects confirmed eligible and enrolled. Core trial execution KPI for enrollment target tracking."
    - name: "screen_failure_count"
      expr: COUNT(CASE WHEN enrollment_status = 'Screen Failure' THEN 1 END)
      comment: "Number of subjects who failed screening. High screen failure rates signal eligibility criteria or site selection issues."
    - name: "screen_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_status = 'Screen Failure' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screened subjects who failed screening. A key operational efficiency KPI — high rates increase trial cost and timeline."
    - name: "subjects_withdrawn"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who withdrew from the trial. Drives retention strategy and protocol amendment decisions."
    - name: "withdrawal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN eligibility_confirmed = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of enrolled subjects who withdrew. A critical retention KPI — high rates threaten statistical power and trial validity."
    - name: "subjects_randomized"
      expr: COUNT(CASE WHEN randomization_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who were randomized. Key milestone count for trial execution progress reporting."
    - name: "randomization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN randomization_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN eligibility_confirmed = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of eligible subjects who were randomized. Measures conversion efficiency from screening to treatment assignment."
    - name: "itt_population_count"
      expr: COUNT(CASE WHEN itt_population_flag = TRUE THEN 1 END)
      comment: "Number of subjects in the Intent-to-Treat population. Directly impacts primary efficacy analysis validity."
    - name: "pp_population_count"
      expr: COUNT(CASE WHEN pp_population_flag = TRUE THEN 1 END)
      comment: "Number of subjects in the Per-Protocol population. Used for confirmatory efficacy analysis and regulatory submissions."
    - name: "informed_consent_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN informed_consent_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled subjects with confirmed informed consent. A GCP compliance KPI — any gap is a critical regulatory finding."
    - name: "subjects_unblinded"
      expr: COUNT(CASE WHEN unblinding_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects whose blinding was broken. Unplanned unblinding events are a critical data integrity and regulatory risk signal."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_trial_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety surveillance KPIs for clinical trials — tracks adverse event incidence, severity, seriousness, causality, and regulatory reporting compliance to support pharmacovigilance and risk management decisions."
  source: "`pharmaceuticals_ecm`.`clinical`.`trial_adverse_event`"
  dimensions:
    - name: "ae_severity"
      expr: ae_severity
      comment: "Severity grade of the adverse event (e.g., Mild, Moderate, Severe) for safety signal stratification."
    - name: "ctcae_grade"
      expr: ctcae_grade
      comment: "NCI CTCAE toxicity grade for standardized severity classification used in oncology and regulatory reporting."
    - name: "ae_reporting_category"
      expr: ae_reporting_category
      comment: "Regulatory reporting category of the AE (e.g., SAE, SUSAR, AESI) for compliance tracking."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Investigator causality assessment (e.g., Related, Unrelated, Possibly Related) for benefit-risk evaluation."
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the adverse event (e.g., Recovered, Fatal, Ongoing) for safety profile characterization."
    - name: "ae_status"
      expr: ae_status
      comment: "Current processing status of the AE record (e.g., Open, Closed, Under Review) for case management tracking."
    - name: "onset_year"
      expr: DATE_TRUNC('YEAR', onset_date)
      comment: "Year of AE onset for longitudinal safety signal trend analysis."
    - name: "onset_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Month of AE onset for granular safety surveillance and signal detection."
    - name: "medical_review_status"
      expr: medical_review_status
      comment: "Status of medical review for the AE, used to track case review backlog and quality."
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse events reported across all trials. Baseline safety surveillance KPI."
    - name: "serious_adverse_events"
      expr: COUNT(CASE WHEN is_serious = TRUE THEN 1 END)
      comment: "Number of Serious Adverse Events (SAEs). A primary safety KPI — SAE rates directly influence trial continuation and regulatory decisions."
    - name: "sae_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_serious = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all AEs that are serious. Tracks safety profile severity and informs benefit-risk assessment."
    - name: "susar_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Number of Suspected Unexpected Serious Adverse Reactions (SUSARs). Regulatory expedited reporting obligation — any SUSAR requires immediate action."
    - name: "aesi_count"
      expr: COUNT(CASE WHEN aesi_flag = TRUE THEN 1 END)
      comment: "Number of Adverse Events of Special Interest (AESIs). Pre-specified safety signals requiring enhanced monitoring per protocol."
    - name: "ae_led_to_discontinuation_count"
      expr: COUNT(CASE WHEN led_to_discontinuation = TRUE THEN 1 END)
      comment: "Number of AEs that led to subject discontinuation. High counts signal tolerability issues that may require dose modification or protocol amendment."
    - name: "discontinuation_due_to_ae_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN led_to_discontinuation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AEs that resulted in subject discontinuation. A key tolerability KPI for benefit-risk and label negotiations."
    - name: "related_ae_count"
      expr: COUNT(CASE WHEN causality_assessment IN ('Related', 'Possibly Related', 'Probably Related') THEN 1 END)
      comment: "Number of AEs assessed as drug-related. Directly informs the safety section of regulatory submissions and product labeling."
    - name: "ha_reporting_overdue_count"
      expr: COUNT(CASE WHEN ha_report_due_date < CURRENT_DATE AND ha_reported_date IS NULL THEN 1 END)
      comment: "Number of AEs where health authority reporting is overdue. A critical compliance KPI — overdue reports are regulatory violations with significant consequences."
    - name: "unexpected_ae_count"
      expr: COUNT(CASE WHEN is_unexpected = TRUE THEN 1 END)
      comment: "Number of unexpected adverse events (not listed in the current IB/label). Signals emerging safety risks requiring label update or protocol amendment."
    - name: "fatal_outcome_count"
      expr: COUNT(CASE WHEN outcome = 'Fatal' THEN 1 END)
      comment: "Number of AEs with fatal outcome. A critical safety KPI requiring immediate executive and regulatory attention."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit compliance and data quality KPIs — tracks visit completion, protocol deviation rates, query burden, and source data verification to steer trial data integrity and site performance decisions."
  source: "`pharmaceuticals_ecm`.`clinical`.`visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g., Screening, Treatment, Follow-Up, Unscheduled) for visit pattern and compliance analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (e.g., Completed, Missed, Pending) for visit completion tracking."
    - name: "epoch"
      expr: epoch
      comment: "Study epoch (e.g., Screening, Treatment, Follow-Up) for phase-level compliance analysis."
    - name: "arm_name"
      expr: arm_name
      comment: "Treatment arm name associated with the visit for arm-level data quality comparison."
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of protocol deviation observed at the visit, used to identify systemic compliance issues."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Month of actual visit date for longitudinal visit volume and compliance trend analysis."
    - name: "within_window_flag"
      expr: within_window_flag
      comment: "Indicates whether the visit occurred within the protocol-defined visit window. Key protocol compliance dimension."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status at the time of the visit, used to monitor unblinding events during trial conduct."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of visits across all subjects and sites. Baseline operational KPI for trial activity volume."
    - name: "completed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Completed' THEN 1 END)
      comment: "Number of completed visits. Tracks trial execution progress and subject engagement."
    - name: "visit_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN visit_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled visits that were completed. A primary trial execution quality KPI — low rates threaten data completeness and statistical power."
    - name: "protocol_deviation_visits"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END)
      comment: "Number of visits with a protocol deviation. High deviation counts trigger regulatory scrutiny and potential data exclusion."
    - name: "protocol_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits with a protocol deviation. A critical GCP compliance KPI used in site performance reviews and regulatory inspections."
    - name: "visits_within_window_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN within_window_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN visit_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed visits that occurred within the protocol-defined visit window. Measures protocol adherence quality."
    - name: "sae_reported_visits"
      expr: COUNT(CASE WHEN sae_reported_flag = TRUE THEN 1 END)
      comment: "Number of visits at which an SAE was reported. Used to correlate safety events with visit timing and treatment exposure."
    - name: "source_verified_visits"
      expr: COUNT(CASE WHEN source_verified_flag = TRUE THEN 1 END)
      comment: "Number of visits with source data verification completed. Tracks SDV progress, a key data quality and audit readiness KPI."
    - name: "source_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN source_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN visit_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed visits with source data verification done. Directly impacts data quality and regulatory inspection readiness."
    - name: "avg_visit_completion_pct"
      expr: ROUND(AVG(CAST(completion_pct AS DOUBLE)), 2)
      comment: "Average completion percentage across all visits. Provides a continuous measure of visit data completeness beyond binary completion status."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_trial_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Efficacy and endpoint assessment KPIs — tracks endpoint evaluability, response rates, and data readiness to support go/no-go decisions, regulatory submissions, and HTA dossier preparation."
  source: "`pharmaceuticals_ecm`.`clinical`.`trial_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Classification of the endpoint (e.g., Primary, Secondary, Exploratory) for hierarchical efficacy analysis."
    - name: "endpoint_category"
      expr: endpoint_category
      comment: "Therapeutic category of the endpoint (e.g., Survival, Response, Biomarker) for cross-trial benchmarking."
    - name: "endpoint_name"
      expr: endpoint_name
      comment: "Name of the specific endpoint being assessed, used for endpoint-level performance tracking."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used to assess the endpoint (e.g., RECIST, BICR, Investigator) for methodology-level quality analysis."
    - name: "response_category"
      expr: response_category
      comment: "Response category (e.g., CR, PR, SD, PD) for response rate calculation and efficacy signal monitoring."
    - name: "best_overall_response"
      expr: best_overall_response
      comment: "Best overall response achieved by the subject, a key oncology efficacy endpoint dimension."
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Status of independent adjudication for the endpoint, used to track adjudication committee workload and data readiness."
    - name: "assessment_year"
      expr: DATE_TRUNC('YEAR', assessment_date)
      comment: "Year of endpoint assessment for longitudinal efficacy trend analysis."
    - name: "itt_flag"
      expr: itt_flag
      comment: "Indicates whether the endpoint record belongs to the ITT analysis population."
    - name: "pp_flag"
      expr: pp_flag
      comment: "Indicates whether the endpoint record belongs to the Per-Protocol analysis population."
  measures:
    - name: "total_endpoint_assessments"
      expr: COUNT(1)
      comment: "Total number of endpoint assessments performed. Baseline KPI for endpoint data volume and completeness."
    - name: "evaluable_endpoint_count"
      expr: COUNT(CASE WHEN evaluable_flag = TRUE THEN 1 END)
      comment: "Number of evaluable endpoint assessments. Determines the effective analysis population size for efficacy conclusions."
    - name: "evaluability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN evaluable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoint assessments that are evaluable. Low evaluability threatens statistical power and regulatory acceptability of efficacy data."
    - name: "event_occurred_count"
      expr: COUNT(CASE WHEN event_occurred = TRUE THEN 1 END)
      comment: "Number of endpoint events observed (e.g., disease progression, death for time-to-event endpoints). Drives interim analysis and trial continuation decisions."
    - name: "event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN event_occurred = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN evaluable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of evaluable subjects with an endpoint event. Core efficacy KPI for time-to-event analyses and go/no-go decisions."
    - name: "confirmed_response_count"
      expr: COUNT(CASE WHEN confirmed_response = TRUE THEN 1 END)
      comment: "Number of subjects with a confirmed response. Numerator for Objective Response Rate (ORR), a primary regulatory endpoint in oncology."
    - name: "confirmed_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN confirmed_response = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN evaluable_flag = TRUE THEN 1 END), 0), 2)
      comment: "Confirmed response rate among evaluable subjects. A primary efficacy KPI for regulatory submissions and HTA value dossiers."
    - name: "avg_percent_change_from_baseline"
      expr: ROUND(AVG(CAST(percent_change_from_baseline AS DOUBLE)), 2)
      comment: "Average percent change from baseline across endpoint assessments. Quantifies treatment effect magnitude for efficacy reporting."
    - name: "avg_result_value"
      expr: ROUND(AVG(CAST(result_value AS DOUBLE)), 4)
      comment: "Average endpoint result value across assessments. Provides a continuous efficacy signal for dose-response and subgroup analyses."
    - name: "adjudication_pending_count"
      expr: COUNT(CASE WHEN adjudication_required = TRUE AND adjudication_status NOT IN ('Completed', 'Adjudicated') AND adjudication_status IS NOT NULL THEN 1 END)
      comment: "Number of endpoint assessments requiring adjudication that are not yet completed. Tracks adjudication backlog impacting data lock timelines."
    - name: "data_locked_endpoint_count"
      expr: COUNT(CASE WHEN data_lock_flag = TRUE THEN 1 END)
      comment: "Number of endpoint records with data lock confirmed. Tracks data readiness for statistical analysis and regulatory submission."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_investigational_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site performance and activation KPIs — tracks site readiness, GCP compliance, and activation milestones to support site selection, oversight, and enrollment strategy decisions."
  source: "`pharmaceuticals_ecm`.`clinical`.`investigational_site`"
  dimensions:
    - name: "investigational_site_status"
      expr: investigational_site_status
      comment: "Current operational status of the site (e.g., Active, Closed, On Hold) for site portfolio management."
    - name: "site_type"
      expr: site_type
      comment: "Type of investigational site (e.g., Academic, Community, Hospital) for site mix and performance benchmarking."
    - name: "gcp_inspection_status"
      expr: gcp_inspection_status
      comment: "GCP inspection status of the site, a critical regulatory compliance dimension for site risk stratification."
    - name: "regulatory_authority_jurisdiction"
      expr: regulatory_authority_jurisdiction
      comment: "Regulatory jurisdiction of the site for geographic compliance and submission strategy analysis."
    - name: "is_lead_site"
      expr: is_lead_site
      comment: "Indicates whether the site is designated as a lead site, used for performance benchmarking and resource prioritization."
    - name: "is_gcp_trained"
      expr: is_gcp_trained
      comment: "Indicates whether site staff have current GCP training, a prerequisite for site activation and regulatory compliance."
    - name: "feasibility_year"
      expr: DATE_TRUNC('YEAR', feasibility_date)
      comment: "Year of site feasibility assessment for site selection pipeline analysis."
    - name: "fpfv_actual_year"
      expr: DATE_TRUNC('YEAR', fpfv_actual_date)
      comment: "Year of First Patient First Visit at the site, used for enrollment ramp and site activation timeline analysis."
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of investigational sites in the network. Baseline KPI for site portfolio size and geographic coverage."
    - name: "active_sites"
      expr: COUNT(CASE WHEN investigational_site_status = 'Active' THEN 1 END)
      comment: "Number of currently active investigational sites. Drives enrollment capacity planning and resource allocation."
    - name: "site_activation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fpfv_actual_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites that have achieved First Patient First Visit. Measures site activation efficiency against the full site network."
    - name: "sites_with_irb_approval"
      expr: COUNT(CASE WHEN irb_iec_approval_number IS NOT NULL THEN 1 END)
      comment: "Number of sites with IRB/IEC approval obtained. Tracks regulatory readiness for site activation."
    - name: "irb_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN irb_iec_approval_number IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with IRB/IEC approval. A key site activation readiness KPI for trial start-up timeline management."
    - name: "sites_with_fpfv_delay"
      expr: COUNT(CASE WHEN fpfv_actual_date > fpfv_target_date AND fpfv_actual_date IS NOT NULL AND fpfv_target_date IS NOT NULL THEN 1 END)
      comment: "Number of sites where First Patient First Visit occurred after the target date. Identifies sites contributing to enrollment timeline delays."
    - name: "fpfv_delay_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fpfv_actual_date > fpfv_target_date AND fpfv_actual_date IS NOT NULL AND fpfv_target_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN fpfv_target_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of sites with delayed FPFV vs. target. A critical trial timeline KPI — high delay rates signal systemic site activation issues."
    - name: "gcp_non_compliant_sites"
      expr: COUNT(CASE WHEN gcp_inspection_status NOT IN ('Compliant', 'No Action Indicated') AND gcp_inspection_status IS NOT NULL THEN 1 END)
      comment: "Number of sites with non-compliant GCP inspection status. A critical regulatory risk KPI requiring immediate remediation action."
    - name: "sites_with_expired_irb"
      expr: COUNT(CASE WHEN irb_iec_approval_expiry_date < CURRENT_DATE AND irb_iec_approval_expiry_date IS NOT NULL THEN 1 END)
      comment: "Number of sites with expired IRB/IEC approval. Expired approvals halt subject enrollment and constitute a GCP violation — requires urgent action."
    - name: "gcp_trained_site_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_gcp_trained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with GCP-trained staff. A regulatory compliance prerequisite — untrained sites cannot conduct trial activities."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_trial_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trial timeline and milestone execution KPIs — tracks planned vs. actual milestone achievement, critical path adherence, and regulatory commitment fulfillment to support portfolio governance and executive steering."
  source: "`pharmaceuticals_ecm`.`clinical`.`trial_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., Enrollment, Regulatory, Data Lock, CSR) for category-level timeline analysis."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Business category of the milestone for portfolio-level aggregation and executive reporting."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., Completed, In Progress, Delayed) for real-time portfolio health monitoring."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the milestone is on the critical path. Critical path delays directly impact trial completion and regulatory submission dates."
    - name: "is_regulatory_commitment"
      expr: is_regulatory_commitment
      comment: "Indicates whether the milestone is a regulatory commitment. Missed regulatory commitments have direct legal and approval consequences."
    - name: "is_interim_analysis"
      expr: is_interim_analysis
      comment: "Indicates whether the milestone is an interim analysis. Interim analyses trigger go/no-go decisions and potential early stopping."
    - name: "region"
      expr: region
      comment: "Geographic region associated with the milestone for regional timeline and regulatory strategy analysis."
    - name: "health_authority"
      expr: health_authority
      comment: "Health authority associated with the milestone for jurisdiction-specific regulatory timeline tracking."
    - name: "planned_year"
      expr: DATE_TRUNC('YEAR', planned_date)
      comment: "Planned year of milestone completion for annual portfolio planning and resource forecasting."
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Coded reason for milestone variance, used to identify systemic root causes of timeline delays."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of trial milestones tracked. Baseline KPI for portfolio timeline complexity and governance scope."
    - name: "completed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Number of milestones completed. Tracks trial execution progress against the planned timeline."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed. A primary portfolio execution KPI for quarterly business reviews and board reporting."
    - name: "delayed_milestones"
      expr: COUNT(CASE WHEN actual_date > planned_date AND actual_date IS NOT NULL AND planned_date IS NOT NULL THEN 1 END)
      comment: "Number of milestones completed after their planned date. Quantifies timeline slippage across the trial portfolio."
    - name: "milestone_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_date <= planned_date AND actual_date IS NOT NULL AND planned_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_date IS NOT NULL AND planned_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed milestones delivered on or before the planned date. A key R&D execution efficiency KPI for executive steering."
    - name: "critical_path_milestones_delayed"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND actual_date > planned_date AND actual_date IS NOT NULL AND planned_date IS NOT NULL THEN 1 END)
      comment: "Number of critical path milestones that were delayed. Critical path delays directly extend trial duration and delay regulatory submission — highest priority KPI."
    - name: "regulatory_commitment_milestones_overdue"
      expr: COUNT(CASE WHEN is_regulatory_commitment = TRUE AND planned_date < CURRENT_DATE AND milestone_status != 'Completed' THEN 1 END)
      comment: "Number of overdue regulatory commitment milestones. Overdue regulatory commitments risk approval withdrawal and enforcement action — requires immediate executive escalation."
    - name: "milestones_pending_approval"
      expr: COUNT(CASE WHEN approval_timestamp IS NULL AND milestone_status = 'Completed' THEN 1 END)
      comment: "Number of completed milestones awaiting formal approval sign-off. Tracks governance process bottlenecks in milestone closure."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_lab_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory data quality and safety signal KPIs — tracks out-of-range rates, toxicity grades, panic values, and clinically significant findings to support safety monitoring and data quality decisions."
  source: "`pharmaceuticals_ecm`.`clinical`.`lab_result`"
  dimensions:
    - name: "test_category"
      expr: test_category
      comment: "Category of laboratory test (e.g., Hematology, Chemistry, Urinalysis) for panel-level safety analysis."
    - name: "test_name"
      expr: test_name
      comment: "Specific laboratory test name for individual analyte safety signal monitoring."
    - name: "lab_type"
      expr: lab_type
      comment: "Type of laboratory (e.g., Central, Local) for data quality and comparability analysis."
    - name: "toxicity_grade"
      expr: toxicity_grade
      comment: "CTCAE toxicity grade of the lab result for standardized safety grading and dose modification decisions."
    - name: "normal_flag"
      expr: normal_flag
      comment: "Flag indicating whether the result is within normal range (e.g., Normal, High, Low) for safety signal stratification."
    - name: "result_status"
      expr: result_status
      comment: "Processing status of the lab result (e.g., Final, Preliminary, Corrected) for data completeness tracking."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of sample collection for longitudinal safety trend analysis."
    - name: "fasting_status"
      expr: fasting_status
      comment: "Fasting status at time of collection, relevant for metabolic and lipid panel result interpretation."
    - name: "loinc_code"
      expr: loinc_code
      comment: "LOINC code for the laboratory test, enabling standardized cross-trial and cross-site comparisons."
  measures:
    - name: "total_lab_results"
      expr: COUNT(1)
      comment: "Total number of laboratory results. Baseline KPI for lab data volume and completeness assessment."
    - name: "out_of_range_results"
      expr: COUNT(CASE WHEN out_of_range_flag = TRUE THEN 1 END)
      comment: "Number of lab results outside the reference range. Tracks safety signal burden and potential dose-limiting toxicities."
    - name: "out_of_range_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_range_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab results outside the reference range. A key safety monitoring KPI — high rates may trigger dose modification or trial hold."
    - name: "clinically_significant_results"
      expr: COUNT(CASE WHEN clinically_significant_flag = TRUE THEN 1 END)
      comment: "Number of lab results flagged as clinically significant. Requires medical review and potential AE reporting — a critical safety surveillance KPI."
    - name: "clinically_significant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clinically_significant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab results that are clinically significant. Tracks safety signal intensity and informs benefit-risk assessment."
    - name: "panic_value_count"
      expr: COUNT(CASE WHEN panic_value_flag = TRUE THEN 1 END)
      comment: "Number of lab results with panic (critical) values requiring immediate clinical intervention. A patient safety KPI demanding real-time monitoring."
    - name: "avg_result_value"
      expr: ROUND(AVG(CAST(result_value_numeric AS DOUBLE)), 4)
      comment: "Average numeric lab result value across assessments. Enables trend analysis of key safety biomarkers over time."
    - name: "protocol_deviation_lab_count"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of lab results associated with a protocol deviation. Tracks data quality issues that may affect result interpretability and regulatory acceptability."
    - name: "query_open_lab_count"
      expr: COUNT(CASE WHEN query_flag = TRUE THEN 1 END)
      comment: "Number of lab results with open data queries. Tracks data cleaning backlog impacting database lock timelines."
    - name: "avg_reference_range_high"
      expr: ROUND(AVG(CAST(reference_range_high AS DOUBLE)), 4)
      comment: "Average upper reference range value across lab results. Used for cross-site and cross-lab reference range harmonization analysis."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_biospecimen`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biospecimen collection, quality, and chain-of-custody KPIs — tracks specimen availability, quality rates, and protocol compliance to support translational research and biomarker strategy decisions."
  source: "`pharmaceuticals_ecm`.`clinical`.`biospecimen`"
  dimensions:
    - name: "specimen_type"
      expr: specimen_type
      comment: "Type of biospecimen (e.g., Blood, Tissue, Urine) for collection portfolio and assay planning analysis."
    - name: "specimen_subtype"
      expr: specimen_subtype
      comment: "Subtype of biospecimen (e.g., Serum, Plasma, FFPE) for granular specimen inventory management."
    - name: "specimen_status"
      expr: specimen_status
      comment: "Current status of the specimen (e.g., Available, Depleted, Destroyed) for biobank inventory management."
    - name: "specimen_quality"
      expr: specimen_quality
      comment: "Quality assessment of the specimen (e.g., Acceptable, Unacceptable, Hemolyzed) for assay eligibility determination."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect the specimen for protocol compliance and pre-analytical variability analysis."
    - name: "anatomical_site"
      expr: anatomical_site
      comment: "Anatomical site of specimen collection, relevant for tissue-based biomarker and pathology analyses."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of specimen collection for longitudinal biospecimen volume and quality trend analysis."
    - name: "consent_biobank_flag"
      expr: consent_biobank_flag
      comment: "Indicates whether the subject consented to biobanking. Determines specimen eligibility for future research use."
    - name: "consent_genetic_testing_flag"
      expr: consent_genetic_testing_flag
      comment: "Indicates whether the subject consented to genetic testing. Governs eligibility for pharmacogenomics analyses."
    - name: "storage_temperature"
      expr: storage_temperature
      comment: "Storage temperature condition for the specimen, used to assess cold chain compliance and specimen integrity."
  measures:
    - name: "total_specimens_collected"
      expr: COUNT(1)
      comment: "Total number of biospecimens collected. Baseline KPI for translational research sample availability."
    - name: "acceptable_quality_specimens"
      expr: COUNT(CASE WHEN specimen_quality = 'Acceptable' THEN 1 END)
      comment: "Number of specimens meeting quality acceptance criteria. Determines the usable sample pool for biomarker and translational analyses."
    - name: "specimen_quality_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN specimen_quality = 'Acceptable' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collected specimens meeting quality acceptance criteria. A key translational research KPI — low rates reduce biomarker analysis power."
    - name: "chain_of_custody_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chain_of_custody_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specimens with verified chain of custody. A regulatory and data integrity KPI — unverified specimens may be inadmissible in regulatory submissions."
    - name: "protocol_deviation_specimens"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of specimens collected with a protocol deviation. Deviations may render specimens unusable for primary analyses."
    - name: "biobank_consented_specimens"
      expr: COUNT(CASE WHEN consent_biobank_flag = TRUE THEN 1 END)
      comment: "Number of specimens with biobanking consent. Determines the size of the biobank repository available for future research."
    - name: "genetic_testing_consented_specimens"
      expr: COUNT(CASE WHEN consent_genetic_testing_flag = TRUE THEN 1 END)
      comment: "Number of specimens with genetic testing consent. Determines the eligible pool for pharmacogenomics and companion diagnostic development."
    - name: "total_volume_collected"
      expr: ROUND(SUM(CAST(volume_collected AS DOUBLE)), 2)
      comment: "Total volume of biospecimens collected across all subjects. Tracks sample inventory sufficiency for planned assay workload."
    - name: "avg_volume_per_specimen"
      expr: ROUND(AVG(CAST(volume_collected AS DOUBLE)), 4)
      comment: "Average volume collected per specimen. Used to assess collection protocol adherence and adequacy for downstream assays."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_subject_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject-level clinical observation data quality and SDV KPIs — tracks data completeness, query burden, protocol deviation rates, and source data verification to support data management and regulatory inspection readiness."
  source: "`pharmaceuticals_ecm`.`clinical`.`subject_observation`"
  dimensions:
    - name: "sdtm_domain"
      expr: sdtm_domain
      comment: "CDISC SDTM domain of the observation (e.g., VS, LB, EG) for domain-level data quality analysis."
    - name: "observation_status"
      expr: observation_status
      comment: "Current status of the observation record (e.g., Entered, Verified, Locked) for data pipeline tracking."
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source Data Verification status of the observation for audit readiness and data quality monitoring."
    - name: "query_status"
      expr: query_status
      comment: "Status of any open data query on the observation (e.g., Open, Answered, Closed) for data cleaning workload management."
    - name: "toxicity_grade"
      expr: toxicity_grade
      comment: "CTCAE toxicity grade associated with the observation for safety signal monitoring."
    - name: "is_baseline"
      expr: is_baseline
      comment: "Indicates whether the observation is a baseline measurement, critical for change-from-baseline efficacy analyses."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of observation collection for longitudinal data volume and quality trend analysis."
    - name: "data_lock_flag"
      expr: data_lock_flag
      comment: "Indicates whether the observation record has been locked, tracking data readiness for analysis."
  measures:
    - name: "total_observations"
      expr: COUNT(1)
      comment: "Total number of subject observations recorded. Baseline KPI for EDC data volume and completeness."
    - name: "out_of_range_observations"
      expr: COUNT(CASE WHEN out_of_range_flag = TRUE THEN 1 END)
      comment: "Number of observations outside the normal range. Tracks safety signal burden and potential clinically significant findings."
    - name: "out_of_range_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_range_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of observations outside the normal range. A data quality and safety monitoring KPI for clinical data management."
    - name: "protocol_deviation_observations"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of observations associated with a protocol deviation. High counts signal systemic protocol compliance issues at the data collection level."
    - name: "open_query_count"
      expr: COUNT(CASE WHEN query_status = 'Open' THEN 1 END)
      comment: "Number of observations with open data queries. Tracks data cleaning backlog — a key database lock readiness KPI."
    - name: "query_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN query_status = 'Open' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of observations with open queries. High query rates indicate data entry quality issues requiring site retraining or process improvement."
    - name: "sdv_completed_observations"
      expr: COUNT(CASE WHEN sdv_status = 'Verified' THEN 1 END)
      comment: "Number of observations with completed source data verification. Tracks SDV progress, a key GCP compliance and audit readiness KPI."
    - name: "sdv_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdv_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of observations with completed SDV. Directly impacts regulatory inspection readiness and data credibility."
    - name: "data_locked_observations"
      expr: COUNT(CASE WHEN data_lock_flag = TRUE THEN 1 END)
      comment: "Number of observations with data lock confirmed. Tracks data readiness for statistical analysis and regulatory submission."
    - name: "avg_numeric_observation_value"
      expr: ROUND(AVG(CAST(numeric_value AS DOUBLE)), 4)
      comment: "Average numeric value across subject observations. Provides a continuous signal for treatment effect monitoring and safety surveillance."
$$;