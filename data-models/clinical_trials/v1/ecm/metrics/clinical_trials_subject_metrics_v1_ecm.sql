-- Metric views for domain: subject | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment metrics tracking subject recruitment, randomization, and study completion rates across clinical trials."
  source: "`clinical_trials_ecm`.`subject`.`enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the subject (e.g., Enrolled, Screened, Randomized, Completed, Withdrawn)."
    - name: "enrollment_type"
      expr: enrollment_type
      comment: "Type of enrollment (e.g., standard, re-screening, rollover)."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the subject (e.g., blinded, unblinded)."
    - name: "cohort_code"
      expr: cohort_code
      comment: "Cohort or group assignment code for stratified analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for time-series recruitment tracking."
    - name: "screening_month"
      expr: DATE_TRUNC('month', screening_date)
      comment: "Month of screening for recruitment funnel analysis."
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason for screen failure, used to identify eligibility barriers."
    - name: "withdrawal_reason"
      expr: withdrawal_reason
      comment: "Reason for subject withdrawal from the study."
    - name: "source_system"
      expr: source_system
      comment: "Source system of record for the enrollment data."
    - name: "stratification_factor_1"
      expr: stratification_factor_1
      comment: "Primary stratification factor used in randomization."
    - name: "stratification_factor_2"
      expr: stratification_factor_2
      comment: "Secondary stratification factor used in randomization."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of enrollment records, representing subjects who entered the enrollment process."
    - name: "randomized_subjects"
      expr: COUNT(CASE WHEN randomization_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects successfully randomized into the study."
    - name: "screen_failures"
      expr: COUNT(CASE WHEN screen_failure_reason IS NOT NULL THEN 1 END)
      comment: "Number of subjects who failed screening, indicating recruitment quality issues."
    - name: "screen_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN screen_failure_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of screened subjects who failed screening — key indicator of protocol feasibility and site quality."
    - name: "withdrawn_subjects"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who withdrew from the study."
    - name: "withdrawal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled subjects who withdrew — critical retention metric for study viability."
    - name: "completed_subjects"
      expr: COUNT(CASE WHEN completion_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who completed the study per protocol."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled subjects who completed the study — primary measure of study execution success."
    - name: "itt_population_count"
      expr: COUNT(CASE WHEN itt_flag = TRUE THEN 1 END)
      comment: "Number of subjects in the Intent-to-Treat population for primary efficacy analysis."
    - name: "safety_population_count"
      expr: COUNT(CASE WHEN safety_population_flag = TRUE THEN 1 END)
      comment: "Number of subjects in the safety analysis population."
    - name: "per_protocol_population_count"
      expr: COUNT(CASE WHEN pp_flag = TRUE THEN 1 END)
      comment: "Number of subjects in the Per-Protocol population for sensitivity analysis."
    - name: "avg_visit_compliance_pct"
      expr: ROUND(AVG(CAST(visit_compliance_pct AS DOUBLE)), 2)
      comment: "Average visit compliance percentage across enrolled subjects — measures protocol adherence."
    - name: "randomization_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN randomization_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN screening_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of screened subjects who were successfully randomized — key recruitment funnel metric."
    - name: "eligibility_confirmed_count"
      expr: COUNT(CASE WHEN eligibility_confirmed = TRUE THEN 1 END)
      comment: "Number of subjects with confirmed eligibility for study participation."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_trial_subject`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master subject-level metrics providing a holistic view of the trial population demographics, status, and safety signals."
  source: "`clinical_trials_ecm`.`subject`.`trial_subject`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status of the trial subject."
    - name: "sex"
      expr: sex
      comment: "Biological sex of the subject for demographic stratification."
    - name: "race"
      expr: race
      comment: "Race of the subject for diversity and demographic analysis."
    - name: "ethnicity"
      expr: ethnicity
      comment: "Ethnicity of the subject for diversity reporting."
    - name: "country"
      expr: country
      comment: "Country where the subject is enrolled for geographic analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for recruitment trend analysis."
    - name: "screening_month"
      expr: DATE_TRUNC('month', screening_date)
      comment: "Month of screening for pipeline tracking."
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Reason for screen failure to identify systemic eligibility issues."
    - name: "withdrawal_reason"
      expr: withdrawal_reason
      comment: "Reason for subject withdrawal for retention analysis."
  measures:
    - name: "total_subjects"
      expr: COUNT(1)
      comment: "Total number of trial subjects across all statuses."
    - name: "enrolled_subjects"
      expr: COUNT(CASE WHEN enrollment_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who have been enrolled in the trial."
    - name: "randomized_subjects"
      expr: COUNT(CASE WHEN randomization_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects randomized into treatment arms."
    - name: "subjects_with_sae"
      expr: COUNT(CASE WHEN serious_adverse_event_flag = TRUE THEN 1 END)
      comment: "Number of subjects who experienced at least one serious adverse event — critical safety signal."
    - name: "sae_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN serious_adverse_event_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN enrollment_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of enrolled subjects with serious adverse events — key safety monitoring metric for DSMB review."
    - name: "protocol_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN enrollment_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of enrolled subjects with protocol deviations — indicator of site compliance and data quality."
    - name: "eligible_subjects"
      expr: COUNT(CASE WHEN eligible_flag = TRUE THEN 1 END)
      comment: "Number of subjects confirmed eligible for study participation."
    - name: "withdrawn_subjects"
      expr: COUNT(CASE WHEN withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Number of subjects who withdrew from the study."
    - name: "retention_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_date IS NULL AND enrollment_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN enrollment_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of enrolled subjects still active (not withdrawn) — critical for study power and timeline."
    - name: "itt_population_count"
      expr: COUNT(CASE WHEN itt_flag = TRUE THEN 1 END)
      comment: "Number of subjects in the Intent-to-Treat analysis population."
    - name: "diversity_race_distinct"
      expr: COUNT(DISTINCT race)
      comment: "Number of distinct racial categories represented — diversity and regulatory compliance indicator."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit-level metrics tracking protocol adherence, visit completion, and scheduling compliance across the study."
  source: "`clinical_trials_ecm`.`subject`.`subject_visit`"
  dimensions:
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (e.g., Completed, Missed, Scheduled, In Progress)."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g., Screening, Treatment, Follow-up, Unscheduled)."
    - name: "visit_code"
      expr: visit_code
      comment: "Protocol-defined visit code for visit identification."
    - name: "window_compliance_status"
      expr: window_compliance_status
      comment: "Whether the visit occurred within the protocol-defined visit window."
    - name: "data_entry_status"
      expr: data_entry_status
      comment: "Status of data entry for the visit eCRF forms."
    - name: "visit_month"
      expr: DATE_TRUNC('month', actual_visit_date)
      comment: "Month of actual visit for temporal analysis."
    - name: "is_scheduled"
      expr: CASE WHEN is_scheduled = TRUE THEN 'Scheduled' ELSE 'Unscheduled' END
      comment: "Whether the visit was a scheduled protocol visit or unscheduled."
    - name: "protocol_deviation_flag"
      expr: CASE WHEN protocol_deviation_flag = TRUE THEN 'Yes' ELSE 'No' END
      comment: "Whether the visit had an associated protocol deviation."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of subject visit records."
    - name: "completed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Completed' THEN 1 END)
      comment: "Number of visits marked as completed."
    - name: "missed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Missed' THEN 1 END)
      comment: "Number of missed visits — impacts data completeness and study power."
    - name: "missed_visit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN visit_status = 'Missed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits that were missed — key indicator of subject engagement and site performance."
    - name: "window_compliant_visits"
      expr: COUNT(CASE WHEN window_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of visits conducted within the protocol-defined visit window."
    - name: "visit_window_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN window_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_visit_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of conducted visits within protocol window — measures scheduling discipline and protocol adherence."
    - name: "visits_with_protocol_deviation"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of visits associated with protocol deviations."
    - name: "unscheduled_visit_count"
      expr: COUNT(CASE WHEN is_scheduled = FALSE THEN 1 END)
      comment: "Number of unscheduled visits — may indicate safety concerns or protocol complexity."
    - name: "distinct_subjects_with_visits"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with at least one visit record."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject disposition metrics tracking study completion, discontinuation reasons, and CONSORT flow for regulatory submissions."
  source: "`clinical_trials_ecm`.`subject`.`disposition`"
  dimensions:
    - name: "disposition_status"
      expr: disposition_status
      comment: "Disposition status (e.g., Completed, Discontinued, Screen Failure, Death)."
    - name: "coded_reason"
      expr: coded_reason
      comment: "Standardized coded reason for disposition event."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of the disposition milestone (e.g., Screening, Treatment, Follow-up)."
    - name: "milestone_subcategory"
      expr: milestone_subcategory
      comment: "Subcategory of the disposition milestone for granular tracking."
    - name: "disposition_month"
      expr: DATE_TRUNC('month', disposition_date)
      comment: "Month of disposition event for temporal trend analysis."
    - name: "screen_failure_reason"
      expr: screen_failure_reason
      comment: "Specific reason for screen failure."
    - name: "death_cause"
      expr: death_cause
      comment: "Cause of death for mortality analysis."
  measures:
    - name: "total_disposition_events"
      expr: COUNT(1)
      comment: "Total number of disposition events recorded."
    - name: "study_completers"
      expr: COUNT(CASE WHEN study_completion_flag = TRUE THEN 1 END)
      comment: "Number of subjects who completed the study per protocol."
    - name: "early_terminations"
      expr: COUNT(CASE WHEN early_termination_flag = TRUE THEN 1 END)
      comment: "Number of subjects who terminated the study early — impacts study power and timelines."
    - name: "early_termination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN early_termination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subjects with early termination — critical for assessing study feasibility and protocol burden."
    - name: "ae_related_discontinuations"
      expr: COUNT(CASE WHEN ae_related_discontinuation = TRUE THEN 1 END)
      comment: "Number of discontinuations due to adverse events — key safety and tolerability signal."
    - name: "ae_discontinuation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ae_related_discontinuation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dispositions due to adverse events — informs benefit-risk assessment."
    - name: "itt_population_count"
      expr: COUNT(CASE WHEN analysis_population_itt = TRUE THEN 1 END)
      comment: "Number of subjects assigned to Intent-to-Treat population."
    - name: "safety_population_count"
      expr: COUNT(CASE WHEN analysis_population_safety = TRUE THEN 1 END)
      comment: "Number of subjects in the safety analysis population."
    - name: "deaths_count"
      expr: COUNT(CASE WHEN death_date IS NOT NULL THEN 1 END)
      comment: "Number of subject deaths — critical safety metric requiring immediate DSMB review."
    - name: "distinct_subjects"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with disposition records."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protocol deviation metrics measuring compliance, data integrity impact, and regulatory reporting requirements across the study."
  source: "`clinical_trials_ecm`.`subject`.`subject_deviation`"
  dimensions:
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of protocol deviation (e.g., Eligibility, Informed Consent, Procedure, Visit Window)."
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current status of the deviation (e.g., Open, Closed, Under Review)."
    - name: "type_code"
      expr: type_code
      comment: "Standardized type code for the deviation."
    - name: "data_integrity_impact"
      expr: data_integrity_impact
      comment: "Assessment of impact on data integrity (e.g., None, Minor, Major)."
    - name: "subject_safety_impact"
      expr: subject_safety_impact
      comment: "Assessment of impact on subject safety."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic issue identification."
    - name: "subject_continuation_decision"
      expr: subject_continuation_decision
      comment: "Decision on whether subject continues in study after deviation."
    - name: "occurrence_month"
      expr: DATE_TRUNC('month', occurrence_date)
      comment: "Month of deviation occurrence for trend analysis."
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of protocol deviations recorded."
    - name: "open_deviations"
      expr: COUNT(CASE WHEN deviation_status = 'Open' THEN 1 END)
      comment: "Number of deviations still open and requiring resolution."
    - name: "regulatory_reportable_deviations"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of deviations requiring regulatory authority notification — compliance risk indicator."
    - name: "irb_reportable_deviations"
      expr: COUNT(CASE WHEN irb_iec_reportable_flag = TRUE THEN 1 END)
      comment: "Number of deviations requiring IRB/IEC reporting."
    - name: "major_data_integrity_deviations"
      expr: COUNT(CASE WHEN data_integrity_impact = 'Major' THEN 1 END)
      comment: "Number of deviations with major data integrity impact — may affect primary endpoint analysis."
    - name: "safety_impacting_deviations"
      expr: COUNT(CASE WHEN subject_safety_impact IS NOT NULL AND subject_safety_impact != 'None' THEN 1 END)
      comment: "Number of deviations with potential subject safety impact — requires immediate attention."
    - name: "distinct_subjects_with_deviations"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects with at least one protocol deviation."
    - name: "sponsor_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sponsor_notified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations where sponsor was notified — measures communication compliance."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_stipend_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject stipend and reimbursement payment metrics tracking financial compliance, payment timeliness, and IRB threshold adherence."
  source: "`clinical_trials_ecm`.`subject`.`stipend_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Pending, Processed, Cleared, Voided)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., Visit Stipend, Travel Reimbursement, Completion Bonus)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment delivery (e.g., ClinCard, Check, Bank Transfer)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment for multi-country studies."
    - name: "subject_country_code"
      expr: subject_country_code
      comment: "Country of the subject for regional payment analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for financial reporting."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual reporting compliance."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of stipend payment transactions."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid to subjects across all payments."
    - name: "avg_payment_amount"
      expr: ROUND(AVG(CAST(payment_amount AS DOUBLE)), 2)
      comment: "Average payment amount per transaction — monitors payment consistency."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved payment amount for budget tracking."
    - name: "over_irb_threshold_payments"
      expr: COUNT(CASE WHEN over_irb_threshold_flag = TRUE THEN 1 END)
      comment: "Number of payments exceeding IRB-approved threshold — compliance risk requiring review."
    - name: "over_irb_threshold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN over_irb_threshold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments exceeding IRB threshold — undue inducement risk indicator."
    - name: "voided_payments"
      expr: COUNT(CASE WHEN void_date IS NOT NULL THEN 1 END)
      comment: "Number of voided payments requiring reprocessing."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total tax withholding amount for regulatory tax reporting."
    - name: "distinct_subjects_paid"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects who received at least one payment."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`subject_concomitant_medication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concomitant medication metrics tracking medication use patterns, prohibited medication compliance, and potential drug interactions across the study population."
  source: "`clinical_trials_ecm`.`subject`.`concomitant_medication`"
  dimensions:
    - name: "concomitant_medication_category"
      expr: concomitant_medication_category
      comment: "Therapeutic category of the concomitant medication."
    - name: "dose_route"
      expr: dose_route
      comment: "Route of administration (e.g., Oral, IV, Topical)."
    - name: "dose_form"
      expr: dose_form
      comment: "Dosage form (e.g., Tablet, Capsule, Injection)."
    - name: "record_status"
      expr: record_status
      comment: "Status of the medication record for data quality tracking."
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source data verification status."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month medication was started for temporal analysis."
  measures:
    - name: "total_concomitant_medications"
      expr: COUNT(1)
      comment: "Total number of concomitant medication records."
    - name: "prohibited_medication_count"
      expr: COUNT(CASE WHEN prohibited_medication_flag = TRUE THEN 1 END)
      comment: "Number of prohibited medications taken — protocol violation and safety concern."
    - name: "prohibited_medication_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prohibited_medication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of concomitant medications that are prohibited — measures protocol compliance."
    - name: "rescue_medication_count"
      expr: COUNT(CASE WHEN rescue_medication_flag = TRUE THEN 1 END)
      comment: "Number of rescue medications used — may indicate inadequate efficacy of study treatment."
    - name: "rescue_medication_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rescue_medication_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of medications that are rescue medications — efficacy signal for study treatment."
    - name: "ae_related_medications"
      expr: COUNT(CASE WHEN ae_related_flag = TRUE THEN 1 END)
      comment: "Number of medications taken due to adverse events — safety burden indicator."
    - name: "ongoing_medications"
      expr: COUNT(CASE WHEN ongoing_flag = TRUE THEN 1 END)
      comment: "Number of medications still ongoing at data cut."
    - name: "distinct_subjects_on_conmeds"
      expr: COUNT(DISTINCT trial_subject_id)
      comment: "Number of unique subjects taking at least one concomitant medication."
    - name: "avg_dose"
      expr: ROUND(AVG(CAST(dose AS DOUBLE)), 2)
      comment: "Average medication dose across all records."
$$;