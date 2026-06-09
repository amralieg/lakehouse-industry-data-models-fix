-- Metric views for domain: safety | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core safety KPIs over the adverse event fact table. Tracks AE incidence, seriousness rates, SUSAR flags, TEAE rates, and regulatory reporting timeliness — the primary dashboard for clinical safety surveillance and pharmacovigilance oversight."
  source: "`clinical_trials_ecm`.`safety`.`adverse_event`"
  filter: is_current_version = TRUE
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study safety breakdowns."
    - name: "investigational_site_id"
      expr: investigational_site_id
      comment: "Foreign key to the investigational site; enables site-level safety surveillance."
    - name: "ae_status"
      expr: ae_status
      comment: "Current lifecycle status of the adverse event (e.g., Open, Closed, Pending)."
    - name: "severity"
      expr: severity
      comment: "Severity grade of the adverse event as reported (e.g., Mild, Moderate, Severe)."
    - name: "ctcae_grade"
      expr: ctcae_grade
      comment: "NCI CTCAE grade assigned to the adverse event for standardized severity classification."
    - name: "meddra_soc_name"
      expr: meddra_soc_name
      comment: "MedDRA System Organ Class name; enables safety signal grouping by body system."
    - name: "meddra_pt_name"
      expr: meddra_pt_name
      comment: "MedDRA Preferred Term name; enables granular event-level safety analysis."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Investigator causality assessment (e.g., Related, Unrelated, Possibly Related)."
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the adverse event (e.g., Recovered, Fatal, Ongoing)."
    - name: "onset_date_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Month of AE onset; enables temporal trend analysis of safety events."
    - name: "arm_id"
      expr: arm_id
      comment: "Foreign key to the treatment arm; enables comparative safety analysis across arms."
    - name: "report_type"
      expr: report_type
      comment: "Type of safety report associated with the AE (e.g., Initial, Follow-up)."
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse event records. Baseline KPI for AE incidence monitoring across studies and sites."
    - name: "distinct_subjects_with_ae"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique trial subjects who experienced at least one adverse event. Core patient safety exposure metric."
    - name: "serious_ae_count"
      expr: COUNT(CASE WHEN is_serious = TRUE THEN 1 END)
      comment: "Count of adverse events classified as serious (SAEs). Directly drives regulatory reporting obligations and benefit-risk assessment."
    - name: "susar_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Count of Suspected Unexpected Serious Adverse Reactions (SUSARs). Triggers expedited regulatory reporting and potential study suspension decisions."
    - name: "teae_count"
      expr: COUNT(CASE WHEN is_teae = TRUE THEN 1 END)
      comment: "Count of Treatment-Emergent Adverse Events (TEAEs). Primary safety endpoint metric for most clinical trial protocols."
    - name: "fatal_outcome_ae_count"
      expr: COUNT(CASE WHEN outcome = 'Fatal' THEN 1 END)
      comment: "Count of adverse events with a fatal outcome. Highest-priority safety signal requiring immediate regulatory notification."
    - name: "regulatory_reporting_overdue_count"
      expr: COUNT(CASE WHEN regulatory_report_due_date < CURRENT_DATE AND regulatory_report_submitted_date IS NULL THEN 1 END)
      comment: "Count of AEs where the regulatory report due date has passed without submission. Directly measures compliance risk and potential regulatory penalty exposure."
    - name: "dsmb_reported_ae_count"
      expr: COUNT(CASE WHEN dsmb_reported = TRUE THEN 1 END)
      comment: "Count of adverse events escalated to the Data Safety Monitoring Board. Indicates severity of safety signals requiring independent oversight."
    - name: "unexpected_ae_count"
      expr: COUNT(CASE WHEN is_expected = FALSE THEN 1 END)
      comment: "Count of adverse events classified as unexpected (not listed in the reference safety information). Key driver of SUSAR determination and expedited reporting."
    - name: "distinct_ae_pt_terms"
      expr: COUNT(DISTINCT meddra_pt_code)
      comment: "Number of distinct MedDRA Preferred Terms observed. Measures breadth of the safety profile across the study population."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_serious_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Focused KPIs on Serious Adverse Events (SAEs). Tracks seriousness criteria distribution, regulatory reporting timeliness, SUSAR escalation, and site-level SAE burden — critical for pharmacovigilance and regulatory compliance decisions."
  source: "`clinical_trials_ecm`.`safety`.`adverse_event`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study SAE burden analysis."
    - name: "investigational_site_id"
      expr: investigational_site_id
      comment: "Foreign key to the investigational site; enables site-level SAE surveillance and outlier detection."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Causality assessment linking the SAE to the investigational product."
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the SAE (e.g., Recovered, Fatal, Ongoing)."
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code for body-system-level SAE grouping."
    - name: "meddra_pt_code"
      expr: meddra_pt_code
      comment: "MedDRA Preferred Term code for granular SAE event classification."
    - name: "ctcae_grade"
      expr: ctcae_grade
      comment: "CTCAE grade of the SAE for severity stratification."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm associated with the SAE; enables comparative safety analysis."
    - name: "onset_date_month"
      expr: DATE_TRUNC('MONTH', onset_date)
      comment: "Month of SAE onset for temporal trend monitoring."
  measures:
    - name: "total_saes"
      expr: COUNT(1)
      comment: "Total number of serious adverse events. Baseline SAE incidence KPI for regulatory reporting and benefit-risk assessment."
    - name: "distinct_subjects_with_sae"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects who experienced at least one SAE. Core patient safety metric for study risk profiling."
    - name: "susar_sae_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Count of SAEs classified as SUSARs. Triggers 7/15-day expedited regulatory reporting obligations."
    - name: "dsmb_reported_sae_count"
      expr: COUNT(CASE WHEN dsmb_reported = TRUE THEN 1 END)
      comment: "Count of SAEs escalated to the DSMB. Measures the volume of safety events requiring independent data monitoring committee review."
    - name: "distinct_sae_sites"
      expr: COUNT(DISTINCT investigational_site_id)
      comment: "Number of distinct sites reporting SAEs. Identifies geographic and site-level safety signal concentration."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_susar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Suspected Unexpected Serious Adverse Reactions (SUSARs). Tracks SUSAR reporting timeliness, blind-break rates, regulatory submission compliance, and DSMB notification — the most time-critical safety reporting domain in clinical trials."
  source: "`clinical_trials_ecm`.`safety`.`susar`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study SUSAR burden tracking."
    - name: "investigational_site_id"
      expr: investigational_site_id
      comment: "Foreign key to the investigational site; enables site-level SUSAR monitoring."
    - name: "reporting_status"
      expr: reporting_status
      comment: "Current reporting status of the SUSAR (e.g., Submitted, Pending, Overdue)."
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the SUSAR event."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Causality assessment linking the SUSAR to the investigational product."
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code for body-system-level SUSAR grouping."
    - name: "meddra_pt_code"
      expr: meddra_pt_code
      comment: "MedDRA Preferred Term code for granular SUSAR event classification."
    - name: "submission_report_type"
      expr: submission_report_type
      comment: "Type of regulatory submission report (e.g., Initial, Follow-up, Final)."
    - name: "awareness_date_month"
      expr: DATE_TRUNC('MONTH', awareness_date)
      comment: "Month of sponsor awareness; anchors the regulatory reporting clock."
    - name: "blind_status"
      expr: blind_status
      comment: "Blinding status of the SUSAR case (Blinded/Unblinded)."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm associated with the SUSAR; enables comparative safety analysis."
  measures:
    - name: "total_susars"
      expr: COUNT(1)
      comment: "Total number of SUSAR records. Baseline KPI for the most critical safety reporting obligation in clinical trials."
    - name: "distinct_subjects_with_susar"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with a SUSAR. Measures patient-level exposure to unexpected serious reactions."
    - name: "blind_broken_susar_count"
      expr: COUNT(CASE WHEN blind_broken = TRUE THEN 1 END)
      comment: "Count of SUSARs requiring unblinding. Measures the frequency of emergency unblinding events, which can compromise trial integrity."
    - name: "dsmb_notified_susar_count"
      expr: COUNT(CASE WHEN dsmb_notified = TRUE THEN 1 END)
      comment: "Count of SUSARs for which the DSMB has been notified. Measures compliance with DSMB notification obligations."
    - name: "irb_iec_notified_susar_count"
      expr: COUNT(CASE WHEN irb_iec_notified = TRUE THEN 1 END)
      comment: "Count of SUSARs for which the IRB/IEC has been notified. Measures compliance with ethics committee notification requirements."
    - name: "susar_7day_deadline_breached_count"
      expr: COUNT(CASE WHEN deadline_7day < CURRENT_DATE AND reporting_status != 'Submitted' THEN 1 END)
      comment: "Count of SUSARs where the 7-day expedited reporting deadline has been breached. Direct measure of critical regulatory compliance failure."
    - name: "susar_15day_deadline_breached_count"
      expr: COUNT(CASE WHEN deadline_15day < CURRENT_DATE AND reporting_status != 'Submitted' THEN 1 END)
      comment: "Count of SUSARs where the 15-day expedited reporting deadline has been breached. Measures regulatory submission compliance for non-fatal/non-life-threatening SUSARs."
    - name: "distinct_susar_pt_terms"
      expr: COUNT(DISTINCT meddra_pt_code)
      comment: "Number of distinct MedDRA Preferred Terms across SUSARs. Measures breadth of unexpected safety signals requiring regulatory attention."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_icsr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Individual Case Safety Reports (ICSRs). Tracks submission timeliness, on-time rates, fatal/life-threatening case volumes, and regulatory acknowledgement — the primary regulatory pharmacovigilance reporting metric view."
  source: "`clinical_trials_ecm`.`safety`.`icsr`"
  filter: is_current_version = TRUE
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study ICSR submission performance tracking."
    - name: "health_authority_id"
      expr: health_authority_id
      comment: "Foreign key to the health authority; enables per-agency submission compliance analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Current submission status of the ICSR (e.g., Submitted, Pending, Rejected)."
    - name: "report_type"
      expr: report_type
      comment: "Type of ICSR report (e.g., Initial, Follow-up, Final)."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the ICSR (e.g., E2B, Paper, Gateway)."
    - name: "awareness_date_month"
      expr: DATE_TRUNC('MONTH', awareness_date)
      comment: "Month of sponsor awareness; anchors the regulatory reporting clock for timeliness analysis."
    - name: "investigational_site_id"
      expr: investigational_site_id
      comment: "Foreign key to the investigational site; enables site-level ICSR submission tracking."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm associated with the ICSR; enables comparative safety reporting analysis."
  measures:
    - name: "total_icsrs"
      expr: COUNT(1)
      comment: "Total number of Individual Case Safety Reports. Baseline KPI for pharmacovigilance reporting volume."
    - name: "on_time_icsr_count"
      expr: COUNT(CASE WHEN is_on_time = TRUE THEN 1 END)
      comment: "Count of ICSRs submitted within the applicable regulatory deadline. Numerator for on-time submission rate."
    - name: "late_icsr_count"
      expr: COUNT(CASE WHEN is_on_time = FALSE THEN 1 END)
      comment: "Count of ICSRs submitted after the applicable regulatory deadline. Direct measure of regulatory compliance failure risk."
    - name: "fatal_icsr_count"
      expr: COUNT(CASE WHEN is_fatal = TRUE THEN 1 END)
      comment: "Count of ICSRs involving a fatal outcome. Highest-priority safety cases requiring immediate regulatory attention."
    - name: "life_threatening_icsr_count"
      expr: COUNT(CASE WHEN is_life_threatening = TRUE THEN 1 END)
      comment: "Count of ICSRs involving a life-threatening event. Drives 7-day expedited reporting clock."
    - name: "susar_icsr_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Count of ICSRs classified as SUSARs. Measures the volume of unexpected serious reactions requiring expedited reporting."
    - name: "rejected_icsr_count"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Count of ICSRs rejected by the health authority. Measures submission quality and potential re-submission workload."
    - name: "dsmb_notified_icsr_count"
      expr: COUNT(CASE WHEN dsmb_notified = TRUE THEN 1 END)
      comment: "Count of ICSRs for which the DSMB has been notified. Measures compliance with independent safety oversight notification obligations."
    - name: "distinct_subjects_in_icsrs"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects represented in ICSRs. Measures patient-level safety reporting coverage."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_expedited_report_deadline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for expedited regulatory reporting deadline compliance. Tracks on-time submission rates, overdue reports, waiver usage, and deadline breach severity — the primary operational metric for regulatory affairs teams managing pharmacovigilance timelines."
  source: "`clinical_trials_ecm`.`safety`.`expedited_report_deadline`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study deadline compliance tracking."
    - name: "health_authority_id"
      expr: health_authority_id
      comment: "Foreign key to the health authority; enables per-agency compliance analysis."
    - name: "deadline_status"
      expr: deadline_status
      comment: "Current status of the reporting deadline (e.g., On Time, Overdue, Submitted)."
    - name: "report_type"
      expr: report_type
      comment: "Type of expedited report (e.g., 7-day, 15-day, Follow-up)."
    - name: "report_category"
      expr: report_category
      comment: "Category of the expedited report (e.g., SUSAR, SAE, Fatal)."
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory agency to which the report must be submitted."
    - name: "reporting_country_code"
      expr: reporting_country_code
      comment: "Country code for the reporting jurisdiction; enables geographic compliance analysis."
    - name: "awareness_date_month"
      expr: DATE_TRUNC('MONTH', awareness_date)
      comment: "Month of sponsor awareness; anchors the reporting clock for trend analysis."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for submission delay; enables root cause analysis of compliance failures."
  measures:
    - name: "total_expedited_report_deadlines"
      expr: COUNT(1)
      comment: "Total number of expedited reporting deadline records. Baseline KPI for regulatory reporting workload."
    - name: "on_time_submission_count"
      expr: COUNT(CASE WHEN is_on_time = TRUE THEN 1 END)
      comment: "Count of expedited reports submitted on time. Numerator for on-time submission rate — primary regulatory compliance KPI."
    - name: "overdue_submission_count"
      expr: COUNT(CASE WHEN is_on_time = FALSE AND submission_date IS NOT NULL THEN 1 END)
      comment: "Count of expedited reports submitted after the deadline. Measures historical compliance failures with regulatory consequences."
    - name: "pending_overdue_count"
      expr: COUNT(CASE WHEN applicable_deadline_date < CURRENT_DATE AND submission_date IS NULL THEN 1 END)
      comment: "Count of expedited reports currently overdue and not yet submitted. Real-time compliance risk indicator requiring immediate action."
    - name: "fatal_or_life_threatening_deadline_count"
      expr: COUNT(CASE WHEN is_fatal_or_life_threatening = TRUE THEN 1 END)
      comment: "Count of expedited report deadlines for fatal or life-threatening events. Measures the volume of highest-priority 7-day reporting obligations."
    - name: "unexpected_event_deadline_count"
      expr: COUNT(CASE WHEN is_unexpected = TRUE THEN 1 END)
      comment: "Count of expedited report deadlines for unexpected events. Measures SUSAR-driven reporting obligations."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted = TRUE THEN 1 END)
      comment: "Count of expedited reports where a submission waiver was granted. Measures regulatory flexibility utilization and potential compliance risk mitigation."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Count of expedited reports requiring a follow-up submission. Measures ongoing reporting workload from incomplete initial reports."
    - name: "distinct_studies_with_overdue_reports"
      expr: COUNT(DISTINCT CASE WHEN applicable_deadline_date < CURRENT_DATE AND submission_date IS NULL THEN study_id END)
      comment: "Number of distinct studies with currently overdue expedited reports. Enables prioritization of regulatory affairs intervention by study."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_causality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for causality assessment of adverse events to investigational products. Tracks related vs. unrelated assessments, sponsor override rates, SUSAR flags, expedited reporting triggers, and signal detection flags — critical for benefit-risk evaluation and regulatory strategy."
  source: "`clinical_trials_ecm`.`safety`.`causality_assessment`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study causality profile analysis."
    - name: "causality_category"
      expr: causality_category
      comment: "Investigator causality category (e.g., Related, Possibly Related, Unrelated)."
    - name: "sponsor_causality_category"
      expr: sponsor_causality_category
      comment: "Sponsor causality category; enables comparison with investigator assessment for override analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the causality assessment (e.g., Completed, Pending, Revised)."
    - name: "assessor_role"
      expr: assessor_role
      comment: "Role of the assessor (e.g., Investigator, Medical Monitor, Sponsor); enables assessment source analysis."
    - name: "dechallenge_result"
      expr: dechallenge_result
      comment: "Result of dechallenge (drug withdrawal); key causality evidence for regulatory submissions."
    - name: "rechallenge_result"
      expr: rechallenge_result
      comment: "Result of rechallenge (drug re-administration); strongest causality evidence."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of causality assessment; enables temporal trend analysis."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm associated with the assessment; enables comparative causality analysis."
  measures:
    - name: "total_causality_assessments"
      expr: COUNT(1)
      comment: "Total number of causality assessments. Baseline KPI for pharmacovigilance workload."
    - name: "related_causality_count"
      expr: COUNT(CASE WHEN causality_category IN ('Related', 'Possibly Related', 'Probably Related') THEN 1 END)
      comment: "Count of assessments where the event is considered related to the investigational product. Core metric for benefit-risk evaluation and safety labeling decisions."
    - name: "susar_flagged_count"
      expr: COUNT(CASE WHEN susar_flag = TRUE THEN 1 END)
      comment: "Count of causality assessments flagged as SUSARs. Drives expedited regulatory reporting obligations."
    - name: "expedited_report_required_count"
      expr: COUNT(CASE WHEN expedited_report_required = TRUE THEN 1 END)
      comment: "Count of assessments triggering an expedited regulatory report. Measures the volume of time-critical reporting obligations generated."
    - name: "sponsor_override_count"
      expr: COUNT(CASE WHEN sponsor_causality_override = TRUE THEN 1 END)
      comment: "Count of assessments where the sponsor overrode the investigator causality. Measures sponsor-investigator disagreement rate, a key regulatory scrutiny indicator."
    - name: "signal_detection_flagged_count"
      expr: COUNT(CASE WHEN signal_detection_flag = TRUE THEN 1 END)
      comment: "Count of assessments flagged for safety signal detection. Measures the volume of potential new safety signals requiring further evaluation."
    - name: "dsmb_reviewed_assessment_count"
      expr: COUNT(CASE WHEN dsmb_reviewed = TRUE THEN 1 END)
      comment: "Count of causality assessments reviewed by the DSMB. Measures independent safety oversight engagement."
    - name: "revised_assessment_count"
      expr: COUNT(CASE WHEN is_revised = TRUE THEN 1 END)
      comment: "Count of causality assessments that have been revised. Measures assessment instability, which can indicate evolving safety understanding or data quality issues."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for safety signal management. Tracks signal detection rates, evaluation timeliness, DSMB referral rates, expedited reporting triggers, and signal strength — the primary metric view for proactive pharmacovigilance and risk management decisions."
  source: "`clinical_trials_ecm`.`safety`.`signal`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study signal burden analysis."
    - name: "signal_status"
      expr: signal_status
      comment: "Current status of the safety signal (e.g., New, Under Evaluation, Closed, Confirmed)."
    - name: "priority"
      expr: priority
      comment: "Priority level of the signal (e.g., High, Medium, Low); drives resource allocation for signal evaluation."
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code; enables body-system-level signal clustering."
    - name: "meddra_pt_code"
      expr: meddra_pt_code
      comment: "MedDRA Preferred Term code; enables granular signal event classification."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the signal (e.g., Spontaneous, Statistical, Literature); informs signal quality and source analysis."
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final disposition of the signal (e.g., Confirmed, Refuted, Ongoing Monitoring)."
    - name: "regulatory_action_status"
      expr: regulatory_action_status
      comment: "Status of regulatory action taken in response to the signal."
    - name: "detection_date_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month of signal detection; enables temporal trend analysis of emerging safety signals."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm associated with the signal; enables comparative signal analysis."
  measures:
    - name: "total_signals"
      expr: COUNT(1)
      comment: "Total number of safety signals detected. Baseline KPI for pharmacovigilance signal management workload."
    - name: "open_signals_count"
      expr: COUNT(CASE WHEN signal_status NOT IN ('Closed', 'Refuted') THEN 1 END)
      comment: "Count of currently open safety signals. Measures active signal management workload requiring evaluation resources."
    - name: "dsmb_referred_signal_count"
      expr: COUNT(CASE WHEN is_dsmb_referred = TRUE THEN 1 END)
      comment: "Count of signals referred to the DSMB. Measures the volume of signals requiring independent safety oversight escalation."
    - name: "expedited_reporting_required_signal_count"
      expr: COUNT(CASE WHEN is_expedited_reporting_required = TRUE THEN 1 END)
      comment: "Count of signals triggering expedited regulatory reporting. Measures the regulatory reporting burden generated by signal management."
    - name: "susar_related_signal_count"
      expr: COUNT(CASE WHEN is_susar_related = TRUE THEN 1 END)
      comment: "Count of signals related to SUSARs. Measures the overlap between signal detection and expedited reporting obligations."
    - name: "overdue_evaluation_signal_count"
      expr: COUNT(CASE WHEN evaluation_due_date < CURRENT_DATE AND signal_status NOT IN ('Closed', 'Refuted') THEN 1 END)
      comment: "Count of signals where the evaluation due date has passed and the signal is still open. Measures signal evaluation backlog and compliance with pharmacovigilance timelines."
    - name: "avg_signal_strength_value"
      expr: AVG(CAST(strength_value AS DOUBLE))
      comment: "Average signal strength value (e.g., ROR, PRR, EBGM) across detected signals. Measures the overall potency of the safety signal portfolio."
    - name: "max_signal_strength_value"
      expr: MAX(strength_value)
      comment: "Maximum signal strength value observed. Identifies the strongest safety signal in the portfolio for prioritization."
    - name: "total_case_weight"
      expr: SUM(CAST(case_weight AS DOUBLE))
      comment: "Sum of case weights across all signals. Measures the weighted signal burden, accounting for case contribution to signal strength."
    - name: "distinct_signal_pt_terms"
      expr: COUNT(DISTINCT meddra_pt_code)
      comment: "Number of distinct MedDRA Preferred Terms with active signals. Measures the breadth of the safety signal landscape."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_signal_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for safety signal evaluation outcomes. Tracks evaluation completion rates, DSMB referral rates, protocol amendment triggers, expedited reporting requirements, and benefit-risk conclusions — critical for signal management governance and regulatory strategy."
  source: "`clinical_trials_ecm`.`safety`.`signal_evaluation`"
  filter: is_current_version = TRUE
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study signal evaluation performance tracking."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the signal evaluation (e.g., In Progress, Completed, Pending)."
    - name: "evaluation_outcome"
      expr: evaluation_outcome
      comment: "Outcome of the signal evaluation (e.g., Confirmed Signal, No Signal, Ongoing Monitoring)."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Causality assessment conclusion from the signal evaluation."
    - name: "regulatory_action_recommended"
      expr: regulatory_action_recommended
      comment: "Regulatory action recommended as a result of the evaluation (e.g., Label Update, Study Suspension)."
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code for body-system-level evaluation grouping."
    - name: "meddra_pt_code"
      expr: meddra_pt_code
      comment: "MedDRA Preferred Term code for granular evaluation classification."
    - name: "evaluation_initiated_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_initiated_date)
      comment: "Month the signal evaluation was initiated; enables temporal trend analysis."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm associated with the evaluation; enables comparative analysis."
  measures:
    - name: "total_signal_evaluations"
      expr: COUNT(1)
      comment: "Total number of signal evaluations. Baseline KPI for pharmacovigilance evaluation workload."
    - name: "completed_evaluations_count"
      expr: COUNT(CASE WHEN evaluation_status = 'Completed' THEN 1 END)
      comment: "Count of completed signal evaluations. Measures throughput of the signal evaluation process."
    - name: "dsmb_dmc_referred_evaluation_count"
      expr: COUNT(CASE WHEN is_dsmb_dmc_referral = TRUE THEN 1 END)
      comment: "Count of signal evaluations referred to the DSMB/DMC. Measures the volume of evaluations requiring independent safety oversight."
    - name: "expedited_reporting_triggered_count"
      expr: COUNT(CASE WHEN expedited_reporting_required = TRUE THEN 1 END)
      comment: "Count of signal evaluations triggering expedited regulatory reporting. Measures the regulatory reporting burden generated by signal evaluation outcomes."
    - name: "protocol_amendment_triggered_count"
      expr: COUNT(CASE WHEN protocol_amendment_required = TRUE THEN 1 END)
      comment: "Count of signal evaluations requiring a protocol amendment. Measures the operational impact of safety signals on study conduct."
    - name: "susar_evaluation_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Count of signal evaluations classified as SUSAR-related. Measures the overlap between signal evaluation and expedited reporting obligations."
    - name: "overdue_evaluation_count"
      expr: COUNT(CASE WHEN expedited_report_due_date < CURRENT_DATE AND evaluation_status != 'Completed' THEN 1 END)
      comment: "Count of signal evaluations where the expedited report due date has passed and evaluation is incomplete. Measures critical compliance risk in signal management."
    - name: "distinct_studies_with_active_evaluations"
      expr: COUNT(DISTINCT CASE WHEN evaluation_status != 'Completed' THEN study_id END)
      comment: "Number of distinct studies with active (incomplete) signal evaluations. Enables resource prioritization across the study portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_dsmb_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Data Safety Monitoring Board (DSMB) review activities. Tracks review completion rates, stopping rule triggers, safety signal identification, quorum achievement, and regulatory notification compliance — critical for independent safety oversight governance."
  source: "`clinical_trials_ecm`.`safety`.`dsmb_review`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study DSMB review tracking."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the DSMB review (e.g., Scheduled, Completed, Pending)."
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of DSMB meeting (e.g., Scheduled, Ad Hoc, Emergency)."
    - name: "recommendation"
      expr: recommendation
      comment: "DSMB recommendation outcome (e.g., Continue, Modify, Stop)."
    - name: "study_phase_reviewed"
      expr: study_phase_reviewed
      comment: "Phase of the study reviewed (e.g., Phase I, Phase II, Phase III)."
    - name: "meeting_date_month"
      expr: DATE_TRUNC('MONTH', meeting_date)
      comment: "Month of the DSMB meeting; enables temporal trend analysis of safety oversight activities."
    - name: "arm_id"
      expr: arm_id
      comment: "Treatment arm reviewed; enables arm-level safety oversight analysis."
  measures:
    - name: "total_dsmb_reviews"
      expr: COUNT(1)
      comment: "Total number of DSMB reviews conducted. Baseline KPI for independent safety oversight activity."
    - name: "stopping_rule_triggered_count"
      expr: COUNT(CASE WHEN stopping_rule_triggered = TRUE THEN 1 END)
      comment: "Count of DSMB reviews where a stopping rule was triggered. Highest-severity safety governance event, potentially halting the study."
    - name: "safety_signal_identified_count"
      expr: COUNT(CASE WHEN safety_signal_identified = TRUE THEN 1 END)
      comment: "Count of DSMB reviews where a new safety signal was identified. Measures the frequency of emerging safety concerns identified through independent oversight."
    - name: "protocol_amendment_required_count"
      expr: COUNT(CASE WHEN protocol_amendment_required = TRUE THEN 1 END)
      comment: "Count of DSMB reviews recommending a protocol amendment. Measures the operational impact of DSMB safety findings on study conduct."
    - name: "quorum_not_achieved_count"
      expr: COUNT(CASE WHEN quorum_achieved = FALSE THEN 1 END)
      comment: "Count of DSMB meetings where quorum was not achieved. Measures governance risk from incomplete independent oversight."
    - name: "regulatory_notification_overdue_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE AND regulatory_notification_due_date < CURRENT_DATE AND regulatory_notification_date IS NULL THEN 1 END)
      comment: "Count of DSMB reviews where regulatory notification is required, overdue, and not yet sent. Measures critical regulatory compliance risk from DSMB outcomes."
    - name: "independent_review_count"
      expr: COUNT(CASE WHEN is_independent = TRUE THEN 1 END)
      comment: "Count of DSMB reviews conducted by an independent committee. Measures compliance with independence requirements for safety oversight."
    - name: "distinct_studies_with_dsmb_reviews"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with DSMB reviews. Measures the breadth of independent safety oversight across the study portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_dsur`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for Development Safety Update Reports (DSURs). Tracks submission timeliness, cumulative safety exposure, SUSAR and SAE counts, new signal identification, and regulatory acknowledgement — the primary periodic safety reporting metric view for regulatory affairs."
  source: "`clinical_trials_ecm`.`safety`.`dsur`"
  dimensions:
    - name: "study_id"
      expr: study_id
      comment: "Foreign key to the study; enables per-study DSUR performance tracking."
    - name: "health_authority_id"
      expr: health_authority_id
      comment: "Foreign key to the health authority; enables per-agency DSUR submission compliance analysis."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the DSUR (e.g., Draft, Submitted, Approved)."
    - name: "development_phase"
      expr: development_phase
      comment: "Development phase covered by the DSUR (e.g., Phase I, Phase II, Phase III)."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the investigational product; enables portfolio-level safety reporting analysis."
    - name: "reporting_period_end_date_month"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Month of the DSUR reporting period end date; enables temporal trend analysis."
    - name: "submission_format"
      expr: submission_format
      comment: "Format of the DSUR submission (e.g., eCTD, Paper); enables submission method analysis."
  measures:
    - name: "total_dsurs"
      expr: COUNT(1)
      comment: "Total number of DSURs. Baseline KPI for periodic safety reporting volume."
    - name: "on_time_dsur_submission_count"
      expr: COUNT(CASE WHEN submission_date <= submission_due_date THEN 1 END)
      comment: "Count of DSURs submitted on or before the due date. Primary regulatory compliance KPI for periodic safety reporting."
    - name: "late_dsur_submission_count"
      expr: COUNT(CASE WHEN submission_date > submission_due_date THEN 1 END)
      comment: "Count of DSURs submitted after the due date. Measures regulatory compliance failures in periodic safety reporting."
    - name: "new_safety_signal_dsur_count"
      expr: COUNT(CASE WHEN new_safety_signal_identified = TRUE THEN 1 END)
      comment: "Count of DSURs identifying a new safety signal. Measures the frequency of emerging safety concerns identified through periodic review."
    - name: "dsmb_review_conducted_dsur_count"
      expr: COUNT(CASE WHEN dsmb_review_conducted = TRUE THEN 1 END)
      comment: "Count of DSURs where a DSMB review was conducted during the reporting period. Measures independent safety oversight engagement."
    - name: "total_cumulative_subject_exposure_days"
      expr: SUM(CAST(cumulative_subject_exposure_days AS DOUBLE))
      comment: "Total cumulative subject exposure days across all DSURs. Measures the overall safety exposure denominator for incidence rate calculations."
    - name: "health_authority_query_received_count"
      expr: COUNT(CASE WHEN health_authority_query_received = TRUE THEN 1 END)
      comment: "Count of DSURs that generated a health authority query. Measures regulatory scrutiny of periodic safety reports."
    - name: "pending_dsur_submission_count"
      expr: COUNT(CASE WHEN submission_due_date < CURRENT_DATE AND submission_date IS NULL THEN 1 END)
      comment: "Count of DSURs currently overdue for submission. Real-time compliance risk indicator for regulatory affairs teams."
$$;