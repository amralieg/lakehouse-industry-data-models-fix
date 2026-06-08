-- Metric views for domain: safety | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core adverse event metrics for clinical trial safety monitoring, tracking AE volumes, seriousness rates, and treatment-emergent patterns."
  source: "`clinical_trials_ecm`.`safety`.`adverse_event`"
  dimensions:
    - name: "severity"
      expr: severity
      comment: "Severity classification of the adverse event (mild, moderate, severe)"
    - name: "is_serious"
      expr: is_serious
      comment: "Whether the adverse event meets ICH seriousness criteria"
    - name: "is_susar"
      expr: is_susar
      comment: "Whether the event is a Suspected Unexpected Serious Adverse Reaction"
    - name: "is_teae"
      expr: is_teae
      comment: "Whether the event is a Treatment-Emergent Adverse Event"
    - name: "is_expected"
      expr: is_expected
      comment: "Whether the event is listed/expected per reference safety information"
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Investigator causality assessment (related, not related, possibly related)"
    - name: "ae_status"
      expr: ae_status
      comment: "Current status of the adverse event record"
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the adverse event (resolved, ongoing, fatal, etc.)"
    - name: "ctcae_grade"
      expr: ctcae_grade
      comment: "CTCAE toxicity grade (1-5)"
    - name: "meddra_soc_name"
      expr: meddra_soc_name
      comment: "MedDRA System Organ Class for event classification"
    - name: "meddra_pt_name"
      expr: meddra_pt_name
      comment: "MedDRA Preferred Term for the adverse event"
    - name: "action_taken"
      expr: action_taken
      comment: "Action taken with study drug in response to the AE"
    - name: "seriousness_criteria"
      expr: seriousness_criteria
      comment: "Specific seriousness criteria met (death, hospitalization, etc.)"
    - name: "report_type"
      expr: report_type
      comment: "Type of safety report (initial, follow-up)"
    - name: "onset_year_month"
      expr: DATE_TRUNC('month', onset_date)
      comment: "Month of AE onset for temporal trend analysis"
    - name: "awareness_year_month"
      expr: DATE_TRUNC('month', awareness_date)
      comment: "Month sponsor became aware of the AE"
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse event records"
    - name: "serious_adverse_event_count"
      expr: COUNT(CASE WHEN is_serious = TRUE THEN 1 END)
      comment: "Count of serious adverse events (SAEs) requiring expedited reporting"
    - name: "susar_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Count of Suspected Unexpected Serious Adverse Reactions requiring urgent regulatory notification"
    - name: "teae_count"
      expr: COUNT(CASE WHEN is_teae = TRUE THEN 1 END)
      comment: "Count of Treatment-Emergent Adverse Events attributable to study drug exposure"
    - name: "sae_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_serious = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all AEs that are serious — key safety signal indicator"
    - name: "susar_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_susar = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AEs classified as SUSARs — triggers regulatory escalation review"
    - name: "teae_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_teae = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AEs that are treatment-emergent — core efficacy-safety balance metric"
    - name: "drug_related_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN causality_assessment IN ('Related', 'Possibly Related', 'Probably Related') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AEs assessed as drug-related — informs benefit-risk assessment"
    - name: "fatal_outcome_count"
      expr: COUNT(CASE WHEN outcome = 'Fatal' THEN 1 END)
      comment: "Count of adverse events with fatal outcome — highest severity safety signal"
    - name: "unresolved_ae_count"
      expr: COUNT(CASE WHEN outcome IN ('Not Recovered', 'Ongoing', 'Unknown') THEN 1 END)
      comment: "Count of AEs without resolution — indicates ongoing patient safety concerns"
    - name: "high_grade_ae_count"
      expr: COUNT(CASE WHEN ctcae_grade IN ('4', '5') THEN 1 END)
      comment: "Count of Grade 4-5 (life-threatening/fatal) AEs per CTCAE grading"
    - name: "dsmb_reported_count"
      expr: COUNT(CASE WHEN dsmb_reported = TRUE THEN 1 END)
      comment: "Count of AEs reported to Data Safety Monitoring Board — indicates escalation volume"
    - name: "distinct_subjects_with_ae"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects experiencing adverse events — incidence denominator"
    - name: "distinct_meddra_pt_terms"
      expr: COUNT(DISTINCT meddra_pt_name)
      comment: "Number of distinct MedDRA preferred terms reported — breadth of safety profile"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_serious_adverse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Serious Adverse Event (SAE) metrics tracking seriousness criteria distribution, reporting timeliness, and SUSAR classification for regulatory compliance."
  source: "`clinical_trials_ecm`.`safety`.`adverse_event`"
  dimensions:
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Investigator/sponsor causality determination"
    - name: "is_susar"
      expr: is_susar
      comment: "Whether the SAE qualifies as a SUSAR"
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the SAE"
    - name: "ctcae_grade"
      expr: ctcae_grade
      comment: "CTCAE severity grade of the SAE"
    - name: "action_taken"
      expr: action_taken
      comment: "Action taken with investigational product"
    - name: "report_type"
      expr: report_type
      comment: "Report type (initial, follow-up)"
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code for SAE classification"
    - name: "onset_month"
      expr: DATE_TRUNC('month', onset_date)
      comment: "Month of SAE onset for trend analysis"
  measures:
    - name: "total_saes"
      expr: COUNT(1)
      comment: "Total serious adverse event records"
    - name: "susar_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Count of SUSARs among SAEs — triggers expedited regulatory reporting"
    - name: "susar_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_susar = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SAEs that are SUSARs — key regulatory escalation metric"
    - name: "distinct_subjects_with_sae"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with SAEs — subject-level incidence"
    - name: "dsmb_reported_count"
      expr: COUNT(CASE WHEN dsmb_reported = TRUE THEN 1 END)
      comment: "SAEs escalated to DSMB for safety oversight review"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_susar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SUSAR (Suspected Unexpected Serious Adverse Reaction) metrics for regulatory reporting compliance, tracking reporting timelines and blinding status."
  source: "`clinical_trials_ecm`.`safety`.`susar`"
  dimensions:
    - name: "reporting_status"
      expr: reporting_status
      comment: "Current regulatory reporting status of the SUSAR"
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Causality assessment for the SUSAR"
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the SUSAR"
    - name: "ctcae_grade"
      expr: ctcae_grade
      comment: "CTCAE toxicity grade"
    - name: "blind_status"
      expr: blind_status
      comment: "Blinding status at time of reporting"
    - name: "blind_broken"
      expr: blind_broken
      comment: "Whether the blind was broken for this case"
    - name: "seriousness_criteria"
      expr: seriousness_criteria
      comment: "Specific seriousness criteria met"
    - name: "expectedness_assessment"
      expr: expectedness_assessment
      comment: "Assessment of whether the reaction was unexpected"
    - name: "submission_report_type"
      expr: submission_report_type
      comment: "Type of regulatory submission (initial, follow-up)"
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code"
    - name: "meddra_pt_code"
      expr: meddra_pt_code
      comment: "MedDRA Preferred Term code"
    - name: "dsmb_notified"
      expr: dsmb_notified
      comment: "Whether DSMB was notified of this SUSAR"
    - name: "irb_iec_notified"
      expr: irb_iec_notified
      comment: "Whether IRB/IEC was notified"
    - name: "awareness_month"
      expr: DATE_TRUNC('month', awareness_date)
      comment: "Month of SUSAR awareness for trend analysis"
    - name: "onset_month"
      expr: DATE_TRUNC('month', onset_date)
      comment: "Month of SUSAR onset"
  measures:
    - name: "total_susars"
      expr: COUNT(1)
      comment: "Total SUSAR count — primary regulatory safety volume metric"
    - name: "fatal_susar_count"
      expr: COUNT(CASE WHEN outcome = 'Fatal' THEN 1 END)
      comment: "Fatal SUSARs requiring 7-day expedited reporting"
    - name: "blind_broken_count"
      expr: COUNT(CASE WHEN blind_broken = TRUE THEN 1 END)
      comment: "SUSARs where treatment blind was broken — impacts study integrity"
    - name: "blind_break_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN blind_broken = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SUSARs requiring unblinding — study integrity risk indicator"
    - name: "dsmb_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dsmb_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SUSARs with DSMB notification — oversight compliance metric"
    - name: "irb_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN irb_iec_notified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SUSARs with IRB/IEC notification — ethics committee compliance"
    - name: "distinct_subjects_with_susar"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Unique subjects experiencing SUSARs — subject-level SUSAR incidence"
    - name: "distinct_studies_with_susar"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of studies with SUSAR occurrences — cross-study safety signal breadth"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_expedited_report_deadline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expedited safety reporting compliance metrics tracking on-time submission rates and deadline adherence for regulatory obligations."
  source: "`clinical_trials_ecm`.`safety`.`expedited_report_deadline`"
  dimensions:
    - name: "deadline_status"
      expr: deadline_status
      comment: "Current status of the reporting deadline (met, overdue, pending)"
    - name: "is_on_time"
      expr: is_on_time
      comment: "Whether the report was submitted within regulatory deadline"
    - name: "report_type"
      expr: report_type
      comment: "Type of expedited report"
    - name: "report_category"
      expr: report_category
      comment: "Category of the expedited report"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Target regulatory agency for the submission"
    - name: "reporting_country_code"
      expr: reporting_country_code
      comment: "Country code for the reporting obligation"
    - name: "is_fatal_or_life_threatening"
      expr: is_fatal_or_life_threatening
      comment: "Whether the case is fatal/life-threatening (7-day deadline)"
    - name: "is_unexpected"
      expr: is_unexpected
      comment: "Whether the event is unexpected per RSI"
    - name: "submission_method"
      expr: submission_method
      comment: "Method of regulatory submission (e.g., EudraVigilance, FAERS)"
    - name: "waiver_granted"
      expr: waiver_granted
      comment: "Whether a reporting waiver was granted"
    - name: "awareness_month"
      expr: DATE_TRUNC('month', awareness_date)
      comment: "Month of case awareness for trend analysis"
  measures:
    - name: "total_expedited_deadlines"
      expr: COUNT(1)
      comment: "Total expedited reporting deadlines tracked"
    - name: "on_time_submissions"
      expr: COUNT(CASE WHEN is_on_time = TRUE THEN 1 END)
      comment: "Count of reports submitted within regulatory deadline"
    - name: "overdue_submissions"
      expr: COUNT(CASE WHEN is_on_time = FALSE THEN 1 END)
      comment: "Count of reports that missed regulatory deadline — compliance risk"
    - name: "on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_on_time = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of expedited reports submitted on time — primary regulatory compliance KPI"
    - name: "seven_day_deadline_count"
      expr: COUNT(CASE WHEN is_fatal_or_life_threatening = TRUE THEN 1 END)
      comment: "Count of cases subject to 7-day fatal/life-threatening deadline"
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted = TRUE THEN 1 END)
      comment: "Count of cases where reporting waiver was granted"
    - name: "avg_days_to_submission"
      expr: AVG(CAST(days_to_submission AS DOUBLE))
      comment: "Average days from awareness to submission — reporting efficiency metric"
    - name: "avg_days_overdue"
      expr: AVG(CAST(days_overdue AS DOUBLE))
      comment: "Average days overdue for late submissions — severity of compliance gaps"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_icsr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual Case Safety Report (ICSR) metrics tracking submission volumes, timeliness, and regulatory acceptance rates."
  source: "`clinical_trials_ecm`.`safety`.`icsr`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current submission status of the ICSR"
    - name: "report_type"
      expr: report_type
      comment: "Type of ICSR (initial, follow-up, nullification)"
    - name: "is_on_time"
      expr: is_on_time
      comment: "Whether the ICSR was submitted within regulatory deadline"
    - name: "is_susar"
      expr: is_susar
      comment: "Whether the ICSR relates to a SUSAR"
    - name: "is_fatal"
      expr: is_fatal
      comment: "Whether the case involves a fatal outcome"
    - name: "is_life_threatening"
      expr: is_life_threatening
      comment: "Whether the case is life-threatening"
    - name: "submission_method"
      expr: submission_method
      comment: "Electronic submission method (E2B, MedWatch, etc.)"
    - name: "is_current_version"
      expr: is_current_version
      comment: "Whether this is the current version of the ICSR"
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class for the reported event"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of ICSR submission for volume trending"
  measures:
    - name: "total_icsrs"
      expr: COUNT(1)
      comment: "Total ICSR submissions — regulatory reporting volume"
    - name: "on_time_icsr_count"
      expr: COUNT(CASE WHEN is_on_time = TRUE THEN 1 END)
      comment: "ICSRs submitted within regulatory deadline"
    - name: "late_icsr_count"
      expr: COUNT(CASE WHEN is_on_time = FALSE THEN 1 END)
      comment: "ICSRs submitted after regulatory deadline — compliance risk"
    - name: "on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_on_time = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "ICSR on-time submission rate — key pharmacovigilance compliance KPI"
    - name: "susar_icsr_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "ICSRs classified as SUSARs — highest priority regulatory submissions"
    - name: "fatal_case_count"
      expr: COUNT(CASE WHEN is_fatal = TRUE THEN 1 END)
      comment: "ICSRs with fatal outcome — 7-day reporting obligation"
    - name: "avg_days_to_submission"
      expr: AVG(CAST(days_to_submission AS DOUBLE))
      comment: "Average days from awareness to ICSR submission — process efficiency"
    - name: "distinct_studies_reported"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with ICSR submissions"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety signal detection and management metrics tracking signal volumes, priorities, and disposition outcomes for pharmacovigilance oversight."
  source: "`clinical_trials_ecm`.`safety`.`signal`"
  dimensions:
    - name: "signal_status"
      expr: signal_status
      comment: "Current status of the safety signal (open, under evaluation, closed)"
    - name: "priority"
      expr: priority
      comment: "Priority classification of the signal"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the signal (disproportionality, clinical review, etc.)"
    - name: "final_disposition"
      expr: final_disposition
      comment: "Final disposition of the signal after evaluation"
    - name: "is_susar_related"
      expr: is_susar_related
      comment: "Whether the signal is related to SUSAR cases"
    - name: "is_dsmb_referred"
      expr: is_dsmb_referred
      comment: "Whether the signal was referred to DSMB"
    - name: "is_expedited_reporting_required"
      expr: is_expedited_reporting_required
      comment: "Whether the signal triggers expedited reporting obligations"
    - name: "regulatory_action_status"
      expr: regulatory_action_status
      comment: "Status of any regulatory action taken"
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA SOC code for the signal event"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_date)
      comment: "Month of signal detection for trend analysis"
  measures:
    - name: "total_signals"
      expr: COUNT(1)
      comment: "Total safety signals detected — pharmacovigilance workload indicator"
    - name: "open_signals"
      expr: COUNT(CASE WHEN signal_status = 'Open' THEN 1 END)
      comment: "Currently open signals requiring evaluation"
    - name: "susar_related_signals"
      expr: COUNT(CASE WHEN is_susar_related = TRUE THEN 1 END)
      comment: "Signals linked to SUSAR cases — highest regulatory concern"
    - name: "dsmb_referred_count"
      expr: COUNT(CASE WHEN is_dsmb_referred = TRUE THEN 1 END)
      comment: "Signals escalated to DSMB — indicates severity of safety concern"
    - name: "expedited_reporting_required_count"
      expr: COUNT(CASE WHEN is_expedited_reporting_required = TRUE THEN 1 END)
      comment: "Signals triggering expedited regulatory reporting"
    - name: "avg_signal_strength"
      expr: AVG(CAST(strength_value AS DOUBLE))
      comment: "Average signal strength value — statistical significance of detected signals"
    - name: "distinct_studies_with_signals"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of studies with detected safety signals — cross-study risk breadth"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_dsur`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Development Safety Update Report (DSUR) metrics tracking periodic safety reporting compliance, submission timeliness, and cumulative safety exposure."
  source: "`clinical_trials_ecm`.`safety`.`dsur`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the DSUR (draft, approved, submitted)"
    - name: "development_phase"
      expr: development_phase
      comment: "Clinical development phase covered by the DSUR"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the investigational product"
    - name: "new_safety_signal_identified"
      expr: new_safety_signal_identified
      comment: "Whether new safety signals were identified in the reporting period"
    - name: "dsmb_review_conducted"
      expr: dsmb_review_conducted
      comment: "Whether DSMB review was conducted during the period"
    - name: "submission_format"
      expr: submission_format
      comment: "Format of DSUR submission"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of DSUR submission"
  measures:
    - name: "total_dsurs"
      expr: COUNT(1)
      comment: "Total DSUR reports — periodic safety reporting volume"
    - name: "dsurs_with_new_signals"
      expr: COUNT(CASE WHEN new_safety_signal_identified = TRUE THEN 1 END)
      comment: "DSURs identifying new safety signals — triggers benefit-risk reassessment"
    - name: "total_cumulative_exposure_days"
      expr: SUM(CAST(cumulative_subject_exposure_days AS DOUBLE))
      comment: "Total cumulative subject exposure days across all DSURs — safety denominator"
    - name: "new_signal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN new_safety_signal_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSURs identifying new signals — emerging risk indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_causality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Causality assessment metrics tracking investigator and sponsor determinations of drug-event relationships for benefit-risk evaluation."
  source: "`clinical_trials_ecm`.`safety`.`causality_assessment`"
  dimensions:
    - name: "causality_category"
      expr: causality_category
      comment: "Causality determination category (related, possibly related, unrelated, etc.)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the causality assessment"
    - name: "assessor_role"
      expr: assessor_role
      comment: "Role of the person performing the assessment (investigator, sponsor, etc.)"
    - name: "sponsor_causality_category"
      expr: sponsor_causality_category
      comment: "Sponsor-level causality determination"
    - name: "sponsor_causality_override"
      expr: sponsor_causality_override
      comment: "Whether sponsor overrode investigator causality assessment"
    - name: "expectedness"
      expr: expectedness
      comment: "Expectedness classification of the event"
    - name: "dechallenge_result"
      expr: dechallenge_result
      comment: "Result of dechallenge (positive, negative, not applicable)"
    - name: "rechallenge_result"
      expr: rechallenge_result
      comment: "Result of rechallenge (positive, negative, not applicable)"
    - name: "susar_flag"
      expr: susar_flag
      comment: "Whether the assessment resulted in SUSAR classification"
    - name: "expedited_report_required"
      expr: expedited_report_required
      comment: "Whether expedited reporting is required based on assessment"
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of causality assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total causality assessments performed"
    - name: "drug_related_count"
      expr: COUNT(CASE WHEN causality_category IN ('Related', 'Probably Related', 'Possibly Related') THEN 1 END)
      comment: "Assessments concluding drug-relatedness — informs labeling decisions"
    - name: "sponsor_override_count"
      expr: COUNT(CASE WHEN sponsor_causality_override = TRUE THEN 1 END)
      comment: "Cases where sponsor overrode investigator causality — regulatory scrutiny area"
    - name: "sponsor_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sponsor_causality_override = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Rate of sponsor causality overrides — high rates may trigger regulatory concern"
    - name: "susar_classification_count"
      expr: COUNT(CASE WHEN susar_flag = TRUE THEN 1 END)
      comment: "Assessments resulting in SUSAR classification"
    - name: "expedited_report_required_count"
      expr: COUNT(CASE WHEN expedited_report_required = TRUE THEN 1 END)
      comment: "Assessments triggering expedited reporting obligations"
    - name: "positive_dechallenge_count"
      expr: COUNT(CASE WHEN dechallenge_result = 'Positive' THEN 1 END)
      comment: "Positive dechallenge results — strong evidence of drug causation"
    - name: "distinct_subjects_assessed"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Unique subjects with causality assessments"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_dsmb_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data Safety Monitoring Board review metrics tracking oversight activities, recommendations, and study continuation decisions."
  source: "`clinical_trials_ecm`.`safety`.`dsmb_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the DSMB review"
    - name: "recommendation"
      expr: recommendation
      comment: "DSMB recommendation (continue, modify, stop)"
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of DSMB meeting (scheduled, ad hoc, emergency)"
    - name: "safety_signal_identified"
      expr: safety_signal_identified
      comment: "Whether a safety signal was identified during review"
    - name: "stopping_rule_triggered"
      expr: stopping_rule_triggered
      comment: "Whether pre-defined stopping rules were triggered"
    - name: "quorum_achieved"
      expr: quorum_achieved
      comment: "Whether meeting quorum was achieved"
    - name: "protocol_amendment_required"
      expr: protocol_amendment_required
      comment: "Whether protocol amendment was recommended"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification was required"
    - name: "study_phase_reviewed"
      expr: study_phase_reviewed
      comment: "Clinical phase under DSMB review"
    - name: "meeting_month"
      expr: DATE_TRUNC('month', meeting_date)
      comment: "Month of DSMB meeting"
  measures:
    - name: "total_dsmb_reviews"
      expr: COUNT(1)
      comment: "Total DSMB reviews conducted — safety oversight activity volume"
    - name: "signal_identified_count"
      expr: COUNT(CASE WHEN safety_signal_identified = TRUE THEN 1 END)
      comment: "Reviews where safety signals were identified — triggers escalation"
    - name: "stopping_rule_triggered_count"
      expr: COUNT(CASE WHEN stopping_rule_triggered = TRUE THEN 1 END)
      comment: "Reviews where stopping rules were triggered — potential study termination"
    - name: "protocol_amendment_required_count"
      expr: COUNT(CASE WHEN protocol_amendment_required = TRUE THEN 1 END)
      comment: "Reviews recommending protocol amendments — study design impact"
    - name: "signal_identification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_signal_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSMB reviews identifying signals — safety concern frequency"
    - name: "regulatory_notification_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Reviews requiring regulatory authority notification"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`safety_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety communication metrics tracking distribution of safety information to investigators, IRBs, and regulatory authorities."
  source: "`clinical_trials_ecm`.`safety`.`safety_communication`"
  dimensions:
    - name: "communication_type"
      expr: communication_type
      comment: "Type of safety communication (SUSAR notification, safety letter, urgent safety measure)"
    - name: "communication_status"
      expr: communication_status
      comment: "Current status of the communication"
    - name: "recipient_type"
      expr: recipient_type
      comment: "Target recipient type (investigator, IRB, regulatory authority)"
    - name: "is_expedited_report"
      expr: is_expedited_report
      comment: "Whether this is an expedited safety report"
    - name: "urgent_safety_measure_flag"
      expr: urgent_safety_measure_flag
      comment: "Whether an urgent safety measure was communicated"
    - name: "acknowledgement_status"
      expr: acknowledgement_status
      comment: "Status of recipient acknowledgement"
    - name: "icf_update_required"
      expr: icf_update_required
      comment: "Whether informed consent form update is required"
    - name: "protocol_amendment_required"
      expr: protocol_amendment_required
      comment: "Whether protocol amendment is required"
    - name: "trigger_event_type"
      expr: trigger_event_type
      comment: "Type of event that triggered the communication"
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the communication was issued"
  measures:
    - name: "total_communications"
      expr: COUNT(1)
      comment: "Total safety communications issued"
    - name: "expedited_report_count"
      expr: COUNT(CASE WHEN is_expedited_report = TRUE THEN 1 END)
      comment: "Expedited safety reports distributed"
    - name: "urgent_safety_measure_count"
      expr: COUNT(CASE WHEN urgent_safety_measure_flag = TRUE THEN 1 END)
      comment: "Urgent safety measures communicated — highest priority safety actions"
    - name: "icf_update_required_count"
      expr: COUNT(CASE WHEN icf_update_required = TRUE THEN 1 END)
      comment: "Communications requiring ICF updates — patient consent impact"
    - name: "protocol_amendment_triggered_count"
      expr: COUNT(CASE WHEN protocol_amendment_required = TRUE THEN 1 END)
      comment: "Communications triggering protocol amendments — study design changes"
    - name: "acknowledgement_pending_count"
      expr: COUNT(CASE WHEN acknowledgement_required = TRUE AND acknowledgement_status != 'Received' THEN 1 END)
      comment: "Communications awaiting recipient acknowledgement — follow-up needed"
$$;