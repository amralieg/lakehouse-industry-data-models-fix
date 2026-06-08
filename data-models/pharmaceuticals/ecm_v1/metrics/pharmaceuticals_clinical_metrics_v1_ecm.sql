-- Metric views for domain: clinical | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_trial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core trial performance metrics including enrollment, timeline adherence, and operational efficiency"
  source: "`pharmaceuticals_ecm`.`clinical`.`trial`"
  dimensions:
    - name: "trial_phase"
      expr: phase
      comment: "Clinical trial phase (Phase I, II, III, IV)"
    - name: "trial_status"
      expr: trial_status
      comment: "Current status of the trial (Active, Completed, Terminated, etc.)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the trial (Oncology, Immunology, etc.)"
    - name: "indication"
      expr: indication
      comment: "Medical indication being studied"
    - name: "study_design_type"
      expr: study_design_type
      comment: "Type of study design (RCT, observational, etc.)"
    - name: "blinding_type"
      expr: blinding_type
      comment: "Blinding approach (double-blind, open-label, etc.)"
    - name: "gcp_compliance_status"
      expr: gcp_compliance_status
      comment: "Good Clinical Practice compliance status"
    - name: "is_pediatric_study"
      expr: is_pediatric_study
      comment: "Whether the trial includes pediatric population"
    - name: "start_year"
      expr: YEAR(actual_start_date)
      comment: "Year the trial actually started"
    - name: "start_quarter"
      expr: CONCAT('Q', QUARTER(actual_start_date), '-', YEAR(actual_start_date))
      comment: "Quarter and year the trial started"
  measures:
    - name: "total_trials"
      expr: COUNT(1)
      comment: "Total number of clinical trials"
    - name: "total_planned_enrollment"
      expr: SUM(CAST(planned_enrollment AS BIGINT))
      comment: "Sum of planned enrollment targets across trials"
    - name: "total_actual_enrollment"
      expr: SUM(CAST(actual_enrollment AS BIGINT))
      comment: "Sum of actual enrollment achieved across trials"
    - name: "avg_planned_enrollment"
      expr: AVG(CAST(planned_enrollment AS BIGINT))
      comment: "Average planned enrollment per trial"
    - name: "avg_actual_enrollment"
      expr: AVG(CAST(actual_enrollment AS BIGINT))
      comment: "Average actual enrollment per trial"
    - name: "enrollment_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_enrollment AS BIGINT)) / NULLIF(SUM(CAST(planned_enrollment AS BIGINT)), 0), 2)
      comment: "Percentage of planned enrollment achieved across trials"
    - name: "trials_with_delayed_start"
      expr: COUNT(CASE WHEN actual_start_date > planned_start_date THEN 1 END)
      comment: "Number of trials that started later than planned"
    - name: "trials_with_delayed_completion"
      expr: COUNT(CASE WHEN actual_primary_completion_date > planned_primary_completion_date THEN 1 END)
      comment: "Number of trials that completed later than planned"
    - name: "avg_enrollment_duration_days"
      expr: AVG(DATEDIFF(actual_primary_completion_date, actual_start_date))
      comment: "Average duration from trial start to primary completion in days"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject enrollment and retention metrics for clinical trial performance"
  source: "`pharmaceuticals_ecm`.`clinical`.`clinical_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (Enrolled, Completed, Withdrawn, etc.)"
    - name: "treatment_arm"
      expr: treatment_arm_code
      comment: "Treatment arm assignment code"
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the subject"
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason for screening failure if applicable"
    - name: "withdrawal_reason"
      expr: withdrawal_reason
      comment: "Reason for withdrawal if applicable"
    - name: "itt_population"
      expr: itt_population_flag
      comment: "Whether subject is in intent-to-treat population"
    - name: "pp_population"
      expr: pp_population_flag
      comment: "Whether subject is in per-protocol population"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment"
  measures:
    - name: "total_subjects"
      expr: COUNT(1)
      comment: "Total number of enrolled subjects"
    - name: "screened_subjects"
      expr: COUNT(CASE WHEN screening_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who were screened"
    - name: "enrolled_subjects"
      expr: COUNT(CASE WHEN enrollment_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who were enrolled"
    - name: "completed_subjects"
      expr: COUNT(CASE WHEN completion_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who completed the trial"
    - name: "withdrawn_subjects"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who withdrew from the trial"
    - name: "screen_failure_count"
      expr: COUNT(CASE WHEN screen_failure_reason IS NOT NULL THEN 1 END)
      comment: "Number of screen failures"
    - name: "screen_to_enroll_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN enrollment_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN screening_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of screened subjects who were enrolled"
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN enrollment_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of enrolled subjects who completed the trial"
    - name: "withdrawal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN enrollment_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of enrolled subjects who withdrew"
    - name: "itt_population_count"
      expr: COUNT(CASE WHEN itt_population_flag = TRUE THEN 1 END)
      comment: "Number of subjects in intent-to-treat population"
    - name: "pp_population_count"
      expr: COUNT(CASE WHEN pp_population_flag = TRUE THEN 1 END)
      comment: "Number of subjects in per-protocol population"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_trial_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety and adverse event metrics for clinical trial monitoring and regulatory reporting"
  source: "`pharmaceuticals_ecm`.`clinical`.`trial_adverse_event`"
  dimensions:
    - name: "ae_severity"
      expr: ae_severity
      comment: "Severity classification of the adverse event"
    - name: "ae_status"
      expr: ae_status
      comment: "Current status of the adverse event"
    - name: "is_serious"
      expr: is_serious
      comment: "Whether the adverse event is classified as serious"
    - name: "is_susar"
      expr: is_susar
      comment: "Whether the event is a Suspected Unexpected Serious Adverse Reaction"
    - name: "is_unexpected"
      expr: is_unexpected
      comment: "Whether the adverse event was unexpected"
    - name: "ctcae_grade"
      expr: ctcae_grade
      comment: "Common Terminology Criteria for Adverse Events grade"
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Assessment of causality relationship to study drug"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the adverse event"
    - name: "led_to_discontinuation"
      expr: led_to_discontinuation
      comment: "Whether the AE led to study discontinuation"
    - name: "meddra_system_organ_class"
      expr: meddra_system_organ_class
      comment: "MedDRA System Organ Class classification"
    - name: "ae_reporting_category"
      expr: ae_reporting_category
      comment: "Regulatory reporting category of the adverse event"
    - name: "onset_year"
      expr: YEAR(onset_date)
      comment: "Year of adverse event onset"
    - name: "onset_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Month of adverse event onset"
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse events reported"
    - name: "serious_adverse_events"
      expr: COUNT(CASE WHEN is_serious = TRUE THEN 1 END)
      comment: "Number of serious adverse events"
    - name: "susar_events"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Number of Suspected Unexpected Serious Adverse Reactions"
    - name: "unexpected_events"
      expr: COUNT(CASE WHEN is_unexpected = TRUE THEN 1 END)
      comment: "Number of unexpected adverse events"
    - name: "events_leading_to_discontinuation"
      expr: COUNT(CASE WHEN led_to_discontinuation = TRUE THEN 1 END)
      comment: "Number of AEs that led to study discontinuation"
    - name: "grade_3_or_higher_events"
      expr: COUNT(CASE WHEN ctcae_grade IN ('3', '4', '5') THEN 1 END)
      comment: "Number of CTCAE Grade 3 or higher events"
    - name: "serious_ae_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_serious = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse events that are serious"
    - name: "discontinuation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN led_to_discontinuation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AEs leading to discontinuation"
    - name: "resolved_events"
      expr: COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END)
      comment: "Number of adverse events that have been resolved"
    - name: "events_reported_to_ha"
      expr: COUNT(CASE WHEN ha_reported_date IS NOT NULL THEN 1 END)
      comment: "Number of events reported to health authorities"
    - name: "avg_time_to_resolution_days"
      expr: AVG(DATEDIFF(resolution_date, onset_date))
      comment: "Average time from onset to resolution in days"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_investigational_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site performance and operational metrics for clinical trial site management"
  source: "`pharmaceuticals_ecm`.`clinical`.`investigational_site`"
  dimensions:
    - name: "site_status"
      expr: investigational_site_status
      comment: "Current operational status of the investigational site"
    - name: "site_type"
      expr: site_type
      comment: "Type of investigational site"
    - name: "gcp_compliance_status"
      expr: gcp_inspection_status
      comment: "Good Clinical Practice inspection status"
    - name: "is_lead_site"
      expr: is_lead_site
      comment: "Whether the site is designated as a lead site"
    - name: "is_gcp_trained"
      expr: is_gcp_trained
      comment: "Whether site staff have completed GCP training"
    - name: "regulatory_jurisdiction"
      expr: regulatory_authority_jurisdiction
      comment: "Regulatory authority jurisdiction for the site"
    - name: "activation_year"
      expr: YEAR(siv_date)
      comment: "Year of site initiation visit"
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of investigational sites"
    - name: "active_sites"
      expr: COUNT(CASE WHEN investigational_site_status = 'Active' THEN 1 END)
      comment: "Number of currently active sites"
    - name: "closed_sites"
      expr: COUNT(CASE WHEN closure_date IS NOT NULL THEN 1 END)
      comment: "Number of sites that have been closed"
    - name: "total_enrolled_subjects"
      expr: SUM(CAST(enrolled_subject_count AS BIGINT))
      comment: "Total subjects enrolled across all sites"
    - name: "total_enrollment_target"
      expr: SUM(CAST(enrollment_target AS BIGINT))
      comment: "Total enrollment target across all sites"
    - name: "avg_subjects_per_site"
      expr: AVG(CAST(enrolled_subject_count AS BIGINT))
      comment: "Average number of subjects enrolled per site"
    - name: "site_enrollment_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(enrolled_subject_count AS BIGINT)) / NULLIF(SUM(CAST(enrollment_target AS BIGINT)), 0), 2)
      comment: "Percentage of enrollment target achieved across sites"
    - name: "total_screen_failures"
      expr: SUM(CAST(screen_failure_count AS BIGINT))
      comment: "Total screen failures across all sites"
    - name: "avg_screen_failures_per_site"
      expr: AVG(CAST(screen_failure_count AS BIGINT))
      comment: "Average screen failures per site"
    - name: "sites_with_delayed_fpfv"
      expr: COUNT(CASE WHEN fpfv_actual_date > fpfv_target_date THEN 1 END)
      comment: "Number of sites with delayed first patient first visit"
    - name: "gcp_compliant_sites"
      expr: COUNT(CASE WHEN is_gcp_trained = TRUE THEN 1 END)
      comment: "Number of sites with GCP-trained staff"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_monitoring_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical monitoring visit quality and compliance metrics for trial oversight"
  source: "`pharmaceuticals_ecm`.`clinical`.`visit`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_monitoring_visits"
      expr: COUNT(1)
      comment: "Total number of monitoring visits conducted"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_trial_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trial milestone tracking and timeline performance metrics for program management"
  source: "`pharmaceuticals_ecm`.`clinical`.`trial_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (enrollment, regulatory, database, etc.)"
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of milestone"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether milestone is on the critical path"
    - name: "is_regulatory_commitment"
      expr: is_regulatory_commitment
      comment: "Whether milestone is a regulatory commitment"
    - name: "variance_reason_code"
      expr: variance_reason_code
      comment: "Code indicating reason for milestone variance"
    - name: "responsible_function"
      expr: responsible_function
      comment: "Function responsible for milestone delivery"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year milestone was planned"
    - name: "actual_year"
      expr: YEAR(actual_date)
      comment: "Year milestone was actually achieved"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of trial milestones"
    - name: "completed_milestones"
      expr: COUNT(CASE WHEN actual_date IS NOT NULL THEN 1 END)
      comment: "Number of milestones that have been completed"
    - name: "delayed_milestones"
      expr: COUNT(CASE WHEN actual_date > planned_date THEN 1 END)
      comment: "Number of milestones completed later than planned"
    - name: "early_milestones"
      expr: COUNT(CASE WHEN actual_date < planned_date THEN 1 END)
      comment: "Number of milestones completed earlier than planned"
    - name: "critical_path_milestones"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical path milestones"
    - name: "regulatory_commitment_milestones"
      expr: COUNT(CASE WHEN is_regulatory_commitment = TRUE THEN 1 END)
      comment: "Number of regulatory commitment milestones"
    - name: "milestone_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed"
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_date <= planned_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed milestones delivered on or before planned date"
    - name: "avg_variance_days"
      expr: AVG(CAST(variance_days AS BIGINT))
      comment: "Average variance in days between planned and actual milestone dates"
    - name: "total_variance_days"
      expr: SUM(CAST(variance_days AS BIGINT))
      comment: "Total variance in days across all milestones"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_protocol`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol design and amendment metrics for clinical development planning"
  source: "`pharmaceuticals_ecm`.`clinical`.`protocol`"
  dimensions:
    - name: "protocol_status"
      expr: protocol_status
      comment: "Current status of the protocol"
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the protocol"
    - name: "indication"
      expr: indication
      comment: "Medical indication being studied"
    - name: "study_type"
      expr: study_type
      comment: "Type of study (interventional, observational, etc.)"
    - name: "design_type"
      expr: design_type
      comment: "Study design type"
    - name: "blinding_method"
      expr: blinding_method
      comment: "Blinding method used in the protocol"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of protocol amendment if applicable"
    - name: "gcp_compliance"
      expr: gcp_compliance_attestation
      comment: "Whether protocol attests to GCP compliance"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year protocol was approved"
  measures:
    - name: "total_protocols"
      expr: COUNT(1)
      comment: "Total number of protocols"
    - name: "active_protocols"
      expr: COUNT(CASE WHEN protocol_status = 'Active' THEN 1 END)
      comment: "Number of active protocols"
    - name: "amended_protocols"
      expr: COUNT(CASE WHEN amendment_number IS NOT NULL THEN 1 END)
      comment: "Number of protocols that have been amended"
    - name: "total_planned_sample_size"
      expr: SUM(CAST(planned_sample_size AS BIGINT))
      comment: "Total planned sample size across all protocols"
    - name: "avg_planned_sample_size"
      expr: AVG(CAST(planned_sample_size AS BIGINT))
      comment: "Average planned sample size per protocol"
    - name: "protocols_with_irb_approval"
      expr: COUNT(CASE WHEN irb_approval_date IS NOT NULL THEN 1 END)
      comment: "Number of protocols with IRB approval"
    - name: "gcp_compliant_protocols"
      expr: COUNT(CASE WHEN gcp_compliance_attestation = TRUE THEN 1 END)
      comment: "Number of protocols attesting to GCP compliance"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`clinical_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical visit execution and data quality metrics for trial operations"
  source: "`pharmaceuticals_ecm`.`clinical`.`visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (scheduled, unscheduled, etc.)"
    - name: "epoch"
      expr: epoch
      comment: "Study epoch of the visit"
    - name: "within_window"
      expr: within_window_flag
      comment: "Whether visit occurred within protocol-defined window"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Whether visit had a protocol deviation"
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of protocol deviation if applicable"
    - name: "ae_reported"
      expr: ae_reported_flag
      comment: "Whether adverse events were reported at this visit"
    - name: "sae_reported"
      expr: sae_reported_flag
      comment: "Whether serious adverse events were reported at this visit"
    - name: "source_verified"
      expr: source_verified_flag
      comment: "Whether visit data has been source verified"
    - name: "visit_year"
      expr: YEAR(actual_date)
      comment: "Year of actual visit"
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Month of actual visit"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of clinical visits"
    - name: "completed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Completed' THEN 1 END)
      comment: "Number of completed visits"
    - name: "visits_within_window"
      expr: COUNT(CASE WHEN within_window_flag = TRUE THEN 1 END)
      comment: "Number of visits conducted within protocol window"
    - name: "visits_with_deviations"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END)
      comment: "Number of visits with protocol deviations"
    - name: "visits_with_ae"
      expr: COUNT(CASE WHEN ae_reported_flag = TRUE THEN 1 END)
      comment: "Number of visits where adverse events were reported"
    - name: "visits_with_sae"
      expr: COUNT(CASE WHEN sae_reported_flag = TRUE THEN 1 END)
      comment: "Number of visits where serious adverse events were reported"
    - name: "source_verified_visits"
      expr: COUNT(CASE WHEN source_verified_flag = TRUE THEN 1 END)
      comment: "Number of visits with source-verified data"
    - name: "avg_completion_pct"
      expr: AVG(CAST(completion_pct AS DOUBLE))
      comment: "Average visit completion percentage"
    - name: "avg_open_queries"
      expr: AVG(CAST(query_open_count AS BIGINT))
      comment: "Average number of open queries per visit"
    - name: "total_open_queries"
      expr: SUM(CAST(query_open_count AS BIGINT))
      comment: "Total open queries across all visits"
    - name: "window_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN within_window_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits conducted within protocol window"
    - name: "source_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN source_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits with source-verified data"
$$;