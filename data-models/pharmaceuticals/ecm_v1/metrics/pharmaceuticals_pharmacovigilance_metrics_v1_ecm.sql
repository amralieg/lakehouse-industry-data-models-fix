-- Metric views for domain: pharmacovigilance | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_icsr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual Case Safety Report (ICSR) metrics tracking adverse event reporting, regulatory compliance, and case processing performance"
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of safety report (spontaneous, solicited, literature, etc.)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (open, closed, pending review)"
    - name: "serious_flag"
      expr: serious_flag
      comment: "Whether the adverse event meets seriousness criteria"
    - name: "susar_flag"
      expr: susar_flag
      comment: "Suspected Unexpected Serious Adverse Reaction flag for expedited reporting"
    - name: "ae_outcome"
      expr: ae_outcome
      comment: "Outcome of the adverse event (recovered, fatal, ongoing, etc.)"
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Assessment of causal relationship between product and adverse event"
    - name: "listedness_assessment"
      expr: listedness_assessment
      comment: "Whether the reaction is listed in product labeling"
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Status of regulatory submission to health authorities"
    - name: "patient_sex"
      expr: patient_sex
      comment: "Sex of the patient experiencing the adverse event"
    - name: "primary_ae_meddra_soc"
      expr: primary_ae_meddra_soc
      comment: "MedDRA System Organ Class of primary adverse event"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year the case was received"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month the case was received"
    - name: "ae_onset_year"
      expr: YEAR(ae_onset_date)
      comment: "Year the adverse event started"
  measures:
    - name: "total_icsr_count"
      expr: COUNT(1)
      comment: "Total number of Individual Case Safety Reports"
    - name: "serious_case_count"
      expr: SUM(CASE WHEN serious_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases meeting seriousness criteria - critical for regulatory reporting"
    - name: "susar_case_count"
      expr: SUM(CASE WHEN susar_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of Suspected Unexpected Serious Adverse Reactions requiring expedited reporting"
    - name: "serious_case_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN serious_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that are serious - key safety signal indicator"
    - name: "susar_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN susar_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that are SUSARs - critical for regulatory compliance"
    - name: "fatal_outcome_count"
      expr: SUM(CASE WHEN ae_outcome = 'Fatal' THEN 1 ELSE 0 END)
      comment: "Number of cases with fatal outcome - highest priority safety metric"
    - name: "avg_patient_age"
      expr: AVG(CAST(patient_age_value AS DOUBLE))
      comment: "Average patient age across cases - demographic risk profiling"
    - name: "avg_patient_weight_kg"
      expr: AVG(CAST(patient_weight_kg AS DOUBLE))
      comment: "Average patient weight in kilograms - dosing and risk assessment"
    - name: "unique_patients"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients with adverse events"
    - name: "unique_products"
      expr: COUNT(DISTINCT pv_product_id)
      comment: "Number of unique products associated with adverse events"
    - name: "regulatory_submission_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_submission_status = 'Submitted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with completed regulatory submissions - compliance KPI"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_safety_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety signal detection and assessment metrics for proactive risk identification and regulatory action"
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`"
  dimensions:
    - name: "signal_status"
      expr: signal_status
      comment: "Current status of the safety signal (detected, validated, closed, etc.)"
    - name: "signal_type"
      expr: signal_type
      comment: "Type of safety signal (product-event, product-product interaction, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for signal assessment and action"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the signal (statistical, clinical review, literature)"
    - name: "regulatory_action_required"
      expr: regulatory_action_required
      comment: "Whether regulatory action is required for this signal"
    - name: "label_change_recommended"
      expr: label_change_recommended
      comment: "Whether product label change is recommended"
    - name: "rmp_update_required"
      expr: rmp_update_required
      comment: "Whether Risk Management Plan update is required"
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code for the signal"
    - name: "detection_year"
      expr: YEAR(detection_timestamp)
      comment: "Year the signal was detected"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the signal was detected"
  measures:
    - name: "total_signal_count"
      expr: COUNT(1)
      comment: "Total number of safety signals detected"
    - name: "validated_signal_count"
      expr: SUM(CASE WHEN signal_status = 'Validated' THEN 1 ELSE 0 END)
      comment: "Number of signals that have been validated - confirmed safety concerns"
    - name: "high_priority_signal_count"
      expr: SUM(CASE WHEN priority_level = 'High' THEN 1 ELSE 0 END)
      comment: "Number of high-priority signals requiring immediate attention"
    - name: "regulatory_action_required_count"
      expr: SUM(CASE WHEN regulatory_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of signals requiring regulatory action - critical compliance metric"
    - name: "label_change_required_count"
      expr: SUM(CASE WHEN label_change_recommended = TRUE THEN 1 ELSE 0 END)
      comment: "Number of signals requiring product label changes - market impact indicator"
    - name: "avg_ebgm_value"
      expr: AVG(CAST(ebgm_value AS DOUBLE))
      comment: "Average Empirical Bayes Geometric Mean - statistical signal strength indicator"
    - name: "avg_prr_value"
      expr: AVG(CAST(prr_value AS DOUBLE))
      comment: "Average Proportional Reporting Ratio - disproportionality measure"
    - name: "avg_ror_value"
      expr: AVG(CAST(ror_value AS DOUBLE))
      comment: "Average Reporting Odds Ratio - association strength measure"
    - name: "signal_validation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN signal_status = 'Validated' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of signals that are validated - signal detection quality metric"
    - name: "regulatory_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of signals requiring regulatory action - risk severity indicator"
    - name: "unique_products_with_signals"
      expr: COUNT(DISTINCT pv_product_id)
      comment: "Number of unique products with detected safety signals"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_psur`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Periodic Safety Update Report (PSUR) metrics tracking regulatory reporting compliance and benefit-risk assessment"
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`psur`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the PSUR (draft, submitted, approved, etc.)"
    - name: "report_type"
      expr: report_type
      comment: "Type of periodic safety report"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of PSUR reporting (annual, biannual, etc.)"
    - name: "label_update_required"
      expr: label_update_required
      comment: "Whether product label update is required based on PSUR findings"
    - name: "rmp_update_required"
      expr: rmp_update_required
      comment: "Whether Risk Management Plan update is required"
    - name: "ha_assessment_outcome"
      expr: ha_assessment_outcome
      comment: "Health authority assessment outcome of the PSUR"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the PSUR was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the PSUR was submitted"
  measures:
    - name: "total_psur_count"
      expr: COUNT(1)
      comment: "Total number of Periodic Safety Update Reports"
    - name: "submitted_psur_count"
      expr: SUM(CASE WHEN report_status = 'Submitted' THEN 1 ELSE 0 END)
      comment: "Number of PSURs submitted to health authorities"
    - name: "on_time_submission_count"
      expr: SUM(CASE WHEN submission_date <= submission_deadline THEN 1 ELSE 0 END)
      comment: "Number of PSURs submitted on or before deadline - compliance metric"
    - name: "total_cumulative_exposure_patients"
      expr: SUM(CAST(cumulative_exposure_patients AS DOUBLE))
      comment: "Total cumulative patient exposure across all PSURs - safety denominator"
    - name: "total_cumulative_exposure_patient_years"
      expr: SUM(CAST(cumulative_exposure_patient_years AS DOUBLE))
      comment: "Total cumulative patient-years of exposure - epidemiological denominator"
    - name: "avg_cumulative_exposure_patients"
      expr: AVG(CAST(cumulative_exposure_patients AS DOUBLE))
      comment: "Average cumulative patient exposure per PSUR"
    - name: "label_update_required_count"
      expr: SUM(CASE WHEN label_update_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of PSURs requiring label updates - market impact indicator"
    - name: "rmp_update_required_count"
      expr: SUM(CASE WHEN rmp_update_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of PSURs requiring RMP updates - risk management workload"
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_date <= submission_deadline THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PSURs submitted on time - regulatory compliance KPI"
    - name: "label_update_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN label_update_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PSURs requiring label updates - safety profile evolution indicator"
    - name: "unique_products_reported"
      expr: COUNT(DISTINCT pv_product_id)
      comment: "Number of unique products with PSUR submissions"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_susar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspected Unexpected Serious Adverse Reaction (SUSAR) metrics for clinical trial safety and expedited reporting compliance"
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`susar`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the SUSAR report"
    - name: "trial_phase"
      expr: trial_phase
      comment: "Clinical trial phase where SUSAR occurred"
    - name: "expectedness_determination"
      expr: expectedness_determination
      comment: "Whether the reaction was expected or unexpected"
    - name: "is_fatal"
      expr: is_fatal
      comment: "Whether the SUSAR resulted in death"
    - name: "is_life_threatening"
      expr: is_life_threatening
      comment: "Whether the SUSAR was life-threatening"
    - name: "seriousness_criteria"
      expr: seriousness_criteria
      comment: "Criteria met for seriousness classification"
    - name: "sponsor_causality"
      expr: sponsor_causality
      comment: "Sponsor assessment of causality"
    - name: "investigator_causality"
      expr: investigator_causality
      comment: "Investigator assessment of causality"
    - name: "reaction_outcome"
      expr: reaction_outcome
      comment: "Outcome of the adverse reaction"
    - name: "subject_sex"
      expr: subject_sex
      comment: "Sex of the trial subject"
    - name: "receipt_year"
      expr: YEAR(initial_receipt_date)
      comment: "Year the SUSAR was initially received"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', initial_receipt_date)
      comment: "Month the SUSAR was initially received"
  measures:
    - name: "total_susar_count"
      expr: COUNT(1)
      comment: "Total number of Suspected Unexpected Serious Adverse Reactions"
    - name: "fatal_susar_count"
      expr: SUM(CASE WHEN is_fatal = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fatal SUSARs - highest severity safety events"
    - name: "life_threatening_susar_count"
      expr: SUM(CASE WHEN is_life_threatening = TRUE THEN 1 ELSE 0 END)
      comment: "Number of life-threatening SUSARs - critical safety events"
    - name: "ema_submitted_count"
      expr: SUM(CASE WHEN ema_eudravigilance_submission_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of SUSARs submitted to EMA EudraVigilance"
    - name: "fda_submitted_count"
      expr: SUM(CASE WHEN fda_ind_submission_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of SUSARs submitted to FDA under IND"
    - name: "on_time_submission_count"
      expr: SUM(CASE WHEN ema_eudravigilance_submission_date <= reporting_deadline_date OR fda_ind_submission_date <= reporting_deadline_date THEN 1 ELSE 0 END)
      comment: "Number of SUSARs submitted within regulatory deadline - compliance metric"
    - name: "fatal_susar_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_fatal = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SUSARs that are fatal - trial safety severity indicator"
    - name: "life_threatening_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_life_threatening = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SUSARs that are life-threatening - risk profile metric"
    - name: "regulatory_submission_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ema_eudravigilance_submission_date <= reporting_deadline_date OR fda_ind_submission_date <= reporting_deadline_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SUSARs submitted on time - critical compliance KPI"
    - name: "unique_trials_with_susars"
      expr: COUNT(DISTINCT trial_id)
      comment: "Number of unique clinical trials with SUSARs - trial safety profile"
    - name: "unique_patients_with_susars"
      expr: COUNT(DISTINCT patient_id)
      comment: "Number of unique patients experiencing SUSARs"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_pv_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacovigilance action metrics tracking risk mitigation activities, regulatory responses, and safety intervention effectiveness"
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of pharmacovigilance action (label change, DHPC, market withdrawal, etc.)"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the action (planned, in progress, completed, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the action"
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered the action (signal, inspection, PSUR, etc.)"
    - name: "authority_notification_required"
      expr: authority_notification_required
      comment: "Whether health authority notification is required"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the action has been escalated"
    - name: "benefit_risk_impact"
      expr: benefit_risk_impact
      comment: "Impact on product benefit-risk profile"
    - name: "market_scope"
      expr: market_scope
      comment: "Geographic scope of the action (global, regional, country-specific)"
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year the action was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the action was initiated"
  measures:
    - name: "total_action_count"
      expr: COUNT(1)
      comment: "Total number of pharmacovigilance actions"
    - name: "completed_action_count"
      expr: SUM(CASE WHEN action_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of completed actions - risk mitigation execution metric"
    - name: "high_priority_action_count"
      expr: SUM(CASE WHEN priority_level = 'High' THEN 1 ELSE 0 END)
      comment: "Number of high-priority actions requiring immediate attention"
    - name: "escalated_action_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of escalated actions - issue severity indicator"
    - name: "authority_notification_required_count"
      expr: SUM(CASE WHEN authority_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of actions requiring health authority notification - regulatory impact"
    - name: "on_time_completion_count"
      expr: SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END)
      comment: "Number of actions completed on or before target date - execution efficiency"
    - name: "overdue_action_count"
      expr: SUM(CASE WHEN action_status != 'Completed' AND target_completion_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of overdue actions - risk management gap indicator"
    - name: "action_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN action_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of actions completed - risk mitigation effectiveness KPI"
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_completion_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed actions finished on time - execution quality metric"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of actions requiring escalation - issue complexity indicator"
    - name: "unique_products_with_actions"
      expr: COUNT(DISTINCT pv_product_id)
      comment: "Number of unique products with pharmacovigilance actions"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_rmp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Management Plan (RMP) metrics tracking proactive risk identification, minimization strategies, and regulatory compliance"
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`"
  dimensions:
    - name: "rmp_type"
      expr: rmp_type
      comment: "Type of Risk Management Plan (EU RMP, US REMS, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RMP by health authority"
    - name: "rems_required"
      expr: rems_required
      comment: "Whether Risk Evaluation and Mitigation Strategy is required (US)"
    - name: "pv_plan_type"
      expr: pv_plan_type
      comment: "Type of pharmacovigilance plan within RMP"
    - name: "risk_minimization_type"
      expr: risk_minimization_type
      comment: "Type of risk minimization measures (routine, additional)"
    - name: "health_authority_code"
      expr: health_authority_code
      comment: "Health authority code for RMP submission"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the RMP was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the RMP was submitted"
  measures:
    - name: "total_rmp_count"
      expr: COUNT(1)
      comment: "Total number of Risk Management Plans"
    - name: "approved_rmp_count"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of approved RMPs - regulatory acceptance metric"
    - name: "rems_required_count"
      expr: SUM(CASE WHEN rems_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of products requiring REMS - high-risk product indicator"
    - name: "rmp_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMPs approved by health authorities - submission quality metric"
    - name: "rems_requirement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rems_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of products requiring REMS - portfolio risk profile"
    - name: "unique_products_with_rmp"
      expr: COUNT(DISTINCT pv_product_id)
      comment: "Number of unique products with Risk Management Plans"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_pv_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacovigilance submission metrics tracking regulatory reporting timeliness, quality, and health authority interactions"
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of pharmacovigilance submission (ICSR, PSUR, RMP, etc.)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (submitted, acknowledged, rejected, etc.)"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Whether the submission is expedited (7/15 day reporting)"
    - name: "is_susar"
      expr: is_susar
      comment: "Whether the submission is for a SUSAR"
    - name: "is_on_time"
      expr: is_on_time
      comment: "Whether the submission was made on time"
    - name: "health_authority_code"
      expr: health_authority_code
      comment: "Health authority receiving the submission"
    - name: "message_format"
      expr: message_format
      comment: "Format of the submission message (E2B R3, E2B R2, etc.)"
    - name: "gateway_portal"
      expr: gateway_portal
      comment: "Gateway or portal used for submission"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the submission was made"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the submission was made"
  measures:
    - name: "total_submission_count"
      expr: COUNT(1)
      comment: "Total number of pharmacovigilance submissions"
    - name: "expedited_submission_count"
      expr: SUM(CASE WHEN is_expedited = TRUE THEN 1 ELSE 0 END)
      comment: "Number of expedited submissions - urgent safety reporting volume"
    - name: "on_time_submission_count"
      expr: SUM(CASE WHEN is_on_time = TRUE THEN 1 ELSE 0 END)
      comment: "Number of submissions made on time - compliance metric"
    - name: "rejected_submission_count"
      expr: SUM(CASE WHEN submission_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Number of rejected submissions - quality issue indicator"
    - name: "acknowledged_submission_count"
      expr: SUM(CASE WHEN acknowledgement_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of submissions acknowledged by health authority"
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_on_time = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions made on time - critical regulatory compliance KPI"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_status = 'Rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions rejected - submission quality metric"
    - name: "acknowledgement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN acknowledgement_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions acknowledged - transmission success rate"
    - name: "expedited_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_expedited = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that are expedited - urgent safety event proportion"
    - name: "unique_health_authorities"
      expr: COUNT(DISTINCT health_authority_code)
      comment: "Number of unique health authorities receiving submissions - regulatory footprint"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_pass_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-Authorization Safety Study (PASS) metrics tracking regulatory commitments, study execution, and safety evidence generation"
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`pass_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the PASS study"
    - name: "study_type"
      expr: study_type
      comment: "Type of post-authorization safety study"
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory category (imposed, non-imposed, voluntary)"
    - name: "is_interventional"
      expr: is_interventional
      comment: "Whether the study is interventional or observational"
    - name: "is_paediatric_study"
      expr: is_paediatric_study
      comment: "Whether the study includes paediatric population"
    - name: "authority_approval_status"
      expr: authority_approval_status
      comment: "Health authority approval status of the study protocol"
    - name: "commitment_source"
      expr: commitment_source
      comment: "Source of the study commitment (RMP, PSUR, approval condition, etc.)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the study"
    - name: "study_start_year"
      expr: YEAR(study_start_date)
      comment: "Year the study started"
  measures:
    - name: "total_pass_study_count"
      expr: COUNT(1)
      comment: "Total number of Post-Authorization Safety Studies"
    - name: "active_study_count"
      expr: SUM(CASE WHEN study_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active PASS studies - ongoing safety evidence generation"
    - name: "completed_study_count"
      expr: SUM(CASE WHEN study_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of completed PASS studies - fulfilled regulatory commitments"
    - name: "imposed_study_count"
      expr: SUM(CASE WHEN regulatory_category = 'Imposed' THEN 1 ELSE 0 END)
      comment: "Number of imposed PASS studies - mandatory regulatory commitments"
    - name: "paediatric_study_count"
      expr: SUM(CASE WHEN is_paediatric_study = TRUE THEN 1 ELSE 0 END)
      comment: "Number of paediatric PASS studies - special population safety focus"
    - name: "on_time_final_report_count"
      expr: SUM(CASE WHEN final_report_submission_date <= final_report_due_date THEN 1 ELSE 0 END)
      comment: "Number of studies with final reports submitted on time - commitment compliance"
    - name: "study_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN study_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PASS studies completed - regulatory commitment fulfillment rate"
    - name: "on_time_report_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN final_report_submission_date <= final_report_due_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN final_report_submission_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of final reports submitted on time - regulatory compliance metric"
    - name: "unique_products_with_pass"
      expr: COUNT(DISTINCT pv_product_id)
      comment: "Number of unique products with PASS commitments"
$$;