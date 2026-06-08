-- Metric views for domain: pharmacovigilance | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_icsr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual Case Safety Report (ICSR) metrics tracking adverse event reporting volume, seriousness, regulatory compliance, and case quality across the pharmacovigilance lifecycle. Core KPI surface for PV operations and regulatory oversight."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`icsr`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of safety report (e.g., spontaneous, literature, clinical trial) used to segment case volumes by source."
    - name: "case_status"
      expr: case_status
      comment: "Current workflow status of the ICSR (e.g., new, in-review, closed) for pipeline and backlog analysis."
    - name: "primary_ae_meddra_soc"
      expr: primary_ae_meddra_soc
      comment: "MedDRA System Organ Class of the primary adverse event, enabling therapeutic area and organ-system level signal analysis."
    - name: "primary_ae_meddra_pt"
      expr: primary_ae_meddra_pt
      comment: "MedDRA Preferred Term of the primary adverse event for granular reaction-level reporting."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Assessed causal relationship between the suspect drug and the adverse event (e.g., probable, possible, unrelated)."
    - name: "listedness_assessment"
      expr: listedness_assessment
      comment: "Whether the adverse event is listed (expected) or unlisted (unexpected) per the current product label — critical for expedited reporting obligations."
    - name: "regulatory_submission_status"
      expr: regulatory_submission_status
      comment: "Status of regulatory submission for the ICSR, used to track compliance with reporting deadlines."
    - name: "ae_onset_year_month"
      expr: DATE_TRUNC('MONTH', ae_onset_date)
      comment: "Month of adverse event onset, enabling trend analysis of case volumes over time."
    - name: "receipt_year_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month the ICSR was received, used for intake volume trending and workload forecasting."
    - name: "source_country_code"
      expr: source_country_code
      comment: "Country of origin for the adverse event report, supporting geographic safety surveillance."
    - name: "patient_sex"
      expr: patient_sex
      comment: "Patient sex for demographic stratification of adverse event profiles."
    - name: "ae_outcome"
      expr: ae_outcome
      comment: "Clinical outcome of the adverse event (e.g., recovered, fatal, ongoing) for severity and risk assessment."
    - name: "seriousness_criteria"
      expr: seriousness_criteria
      comment: "Specific seriousness criteria met (e.g., hospitalization, life-threatening, fatal) per ICH E2A definitions."
    - name: "duplicate_assessment_outcome"
      expr: duplicate_assessment_outcome
      comment: "Outcome of duplicate case assessment, used to monitor data quality and deduplication effectiveness."
  measures:
    - name: "total_icsr_count"
      expr: COUNT(1)
      comment: "Total number of ICSRs received. Baseline volume KPI for PV operations capacity planning and regulatory reporting obligations."
    - name: "serious_case_count"
      expr: COUNT(CASE WHEN serious_flag = TRUE THEN 1 END)
      comment: "Number of ICSRs classified as serious per ICH E2A criteria. Drives expedited 7/15-day reporting obligations and signal prioritization."
    - name: "susar_case_count"
      expr: COUNT(CASE WHEN susar_flag = TRUE THEN 1 END)
      comment: "Number of ICSRs flagged as Suspected Unexpected Serious Adverse Reactions (SUSARs). Critical metric for clinical trial safety oversight and regulatory notification."
    - name: "seriousness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN serious_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all ICSRs classified as serious. Tracks product safety profile evolution and benchmarks against therapeutic area norms."
    - name: "susar_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN susar_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ICSRs that are SUSARs. Elevated rates trigger immediate regulatory escalation and trial safety reviews."
    - name: "unlisted_case_count"
      expr: COUNT(CASE WHEN listedness_assessment = 'Unlisted' THEN 1 END)
      comment: "Number of ICSRs with unlisted (unexpected) adverse events. Unlisted serious cases require expedited reporting and may trigger label updates."
    - name: "regulatory_overdue_count"
      expr: COUNT(CASE WHEN regulatory_submission_status NOT IN ('Submitted', 'Acknowledged') AND regulatory_submission_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of ICSRs past their regulatory submission deadline without confirmed submission. Direct compliance risk metric tracked by PV leadership."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_status IN ('Submitted', 'Acknowledged') AND most_recent_info_date <= regulatory_submission_deadline THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_submission_status IN ('Submitted', 'Acknowledged') THEN 1 END), 0), 2)
      comment: "Percentage of submitted ICSRs that met their regulatory deadline. Core compliance KPI reported to health authorities and internal audit."
    - name: "minimum_criteria_met_count"
      expr: COUNT(CASE WHEN minimum_criteria_met_flag = TRUE THEN 1 END)
      comment: "Number of ICSRs meeting minimum reportability criteria (identifiable patient, reporter, suspect drug, adverse event). Measures intake quality and completeness."
    - name: "avg_patient_age"
      expr: AVG(CAST(patient_age_value AS DOUBLE))
      comment: "Average patient age at time of adverse event. Supports demographic risk profiling and label population characterization."
    - name: "avg_patient_weight_kg"
      expr: AVG(CAST(patient_weight_kg AS DOUBLE))
      comment: "Average patient weight in kilograms. Used in dose-exposure analysis and pharmacokinetic safety assessments."
    - name: "unique_products_reported"
      expr: COUNT(DISTINCT pv_product_id)
      comment: "Number of distinct PV products with at least one ICSR. Measures breadth of safety surveillance portfolio coverage."
    - name: "nullified_case_count"
      expr: COUNT(CASE WHEN case_nullification_flag = TRUE THEN 1 END)
      comment: "Number of ICSRs that have been nullified. Tracks data quality issues and case retraction rates impacting regulatory submissions."
    - name: "fatal_outcome_count"
      expr: COUNT(CASE WHEN ae_outcome = 'Fatal' THEN 1 END)
      comment: "Number of ICSRs with a fatal adverse event outcome. Highest-priority safety signal requiring immediate medical and regulatory review."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_safety_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety signal detection and management metrics tracking signal volume, prioritization, disproportionality statistics, and regulatory action rates. Supports the signal management process from detection through closure."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`safety_signal`"
  dimensions:
    - name: "signal_status"
      expr: signal_status
      comment: "Current status of the safety signal (e.g., new, under evaluation, validated, closed) for pipeline management."
    - name: "signal_type"
      expr: signal_type
      comment: "Classification of the signal type (e.g., new signal, strengthened signal, refuted signal)."
    - name: "priority_level"
      expr: priority_level
      comment: "Assigned priority level of the signal (e.g., high, medium, low) for resource allocation and escalation decisions."
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code for the signal reaction, enabling organ-system level safety surveillance."
    - name: "meddra_pt_name"
      expr: meddra_pt_name
      comment: "MedDRA Preferred Term name for the signal reaction, providing granular reaction-level signal tracking."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the signal (e.g., disproportionality analysis, clinical review, literature) for methodology benchmarking."
    - name: "signal_source_type"
      expr: signal_source_type
      comment: "Source database or system where the signal was detected (e.g., spontaneous reports, EudraVigilance, FAERS)."
    - name: "benefit_risk_impact"
      expr: benefit_risk_impact
      comment: "Assessed impact of the signal on the product benefit-risk balance, driving label and RMP update decisions."
    - name: "regulatory_action_type"
      expr: regulatory_action_type
      comment: "Type of regulatory action triggered by the signal (e.g., label update, DHPC, market withdrawal)."
    - name: "triage_year_month"
      expr: DATE_TRUNC('MONTH', triage_date)
      comment: "Month of signal triage, used for workload trending and process cycle time analysis."
    - name: "detection_year_month"
      expr: DATE_TRUNC('MONTH', CAST(detection_timestamp AS DATE))
      comment: "Month of signal detection, enabling trend analysis of emerging safety signals over time."
  measures:
    - name: "total_signal_count"
      expr: COUNT(1)
      comment: "Total number of safety signals detected. Baseline KPI for signal management workload and portfolio safety surveillance intensity."
    - name: "open_signal_count"
      expr: COUNT(CASE WHEN signal_status NOT IN ('Closed', 'Refuted') THEN 1 END)
      comment: "Number of safety signals currently open (not closed or refuted). Tracks active safety surveillance workload and backlog."
    - name: "high_priority_signal_count"
      expr: COUNT(CASE WHEN priority_level = 'High' THEN 1 END)
      comment: "Number of high-priority safety signals requiring urgent evaluation. Drives resource escalation and executive safety committee agenda."
    - name: "regulatory_action_required_count"
      expr: COUNT(CASE WHEN regulatory_action_required = TRUE THEN 1 END)
      comment: "Number of signals requiring regulatory action. Direct measure of safety-driven regulatory workload and compliance obligations."
    - name: "label_change_recommended_count"
      expr: COUNT(CASE WHEN label_change_recommended = TRUE THEN 1 END)
      comment: "Number of signals where a label change has been recommended. Tracks product labeling evolution driven by post-market safety data."
    - name: "rmp_update_required_count"
      expr: COUNT(CASE WHEN rmp_update_required = TRUE THEN 1 END)
      comment: "Number of signals triggering a Risk Management Plan update. Measures risk minimization activity driven by emerging safety evidence."
    - name: "regulatory_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of detected signals requiring regulatory action. Benchmarks signal severity profile and regulatory engagement intensity."
    - name: "avg_prr_value"
      expr: AVG(CAST(prr_value AS DOUBLE))
      comment: "Average Proportional Reporting Ratio across signals. Key disproportionality statistic used to assess signal strength in spontaneous reporting databases."
    - name: "avg_ror_value"
      expr: AVG(CAST(ror_value AS DOUBLE))
      comment: "Average Reporting Odds Ratio across signals. Complementary disproportionality measure used alongside PRR for signal validation."
    - name: "avg_ebgm_value"
      expr: AVG(CAST(ebgm_value AS DOUBLE))
      comment: "Average Empirical Bayes Geometric Mean (EBGM) across signals. FDA FAERS standard disproportionality metric for signal strength quantification."
    - name: "avg_ic_value"
      expr: AVG(CAST(ic_value AS DOUBLE))
      comment: "Average Information Component (IC) value across signals. WHO VigiBase disproportionality metric used in EudraVigilance signal detection."
    - name: "psur_referral_count"
      expr: COUNT(CASE WHEN psur_referral_flag = TRUE THEN 1 END)
      comment: "Number of signals referred for inclusion in a Periodic Safety Update Report. Tracks signal-to-PSUR pipeline and cumulative safety reporting burden."
    - name: "prac_notification_overdue_count"
      expr: COUNT(CASE WHEN prac_notification_date IS NULL AND prac_notification_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of signals where PRAC notification is overdue. Critical EMA compliance metric tracked by the QPPV and regulatory affairs leadership."
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, triage_date))
      comment: "Average number of days from signal triage to closure. Measures signal management process efficiency and compliance with internal SLA targets."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_susar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Suspected Unexpected Serious Adverse Reaction (SUSAR) metrics for clinical trial safety oversight. Tracks SUSAR volume, fatality rates, regulatory submission timeliness across health authorities, and blinding status — critical for trial continuation decisions and IND/CTA safety reporting."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`susar`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current processing status of the SUSAR report (e.g., initial, follow-up, final) for workflow management."
    - name: "trial_phase"
      expr: trial_phase
      comment: "Clinical trial phase (Phase I, II, III, IV) in which the SUSAR occurred, enabling phase-stratified safety analysis."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Whether the trial treatment assignment was blinded or unblinded at time of SUSAR reporting, critical for causality assessment integrity."
    - name: "sponsor_causality"
      expr: sponsor_causality
      comment: "Sponsor's causality assessment of the SUSAR (e.g., related, unrelated) — determines regulatory reporting obligation."
    - name: "expectedness_determination"
      expr: expectedness_determination
      comment: "Whether the reaction was expected (listed) or unexpected per the Investigator Brochure — defines SUSAR classification."
    - name: "seriousness_criteria"
      expr: seriousness_criteria
      comment: "Specific ICH E2A seriousness criteria met (e.g., fatal, life-threatening, hospitalization)."
    - name: "reaction_meddra_soc_name"
      expr: reaction_meddra_soc_name
      comment: "MedDRA System Organ Class of the SUSAR reaction for organ-system level safety surveillance."
    - name: "reaction_meddra_pt_name"
      expr: reaction_meddra_pt_name
      comment: "MedDRA Preferred Term of the SUSAR reaction for granular reaction-level analysis."
    - name: "reporting_clock_type"
      expr: reporting_clock_type
      comment: "Type of reporting clock applied (7-day for fatal/life-threatening, 15-day for others) per ICH E2A requirements."
    - name: "initial_receipt_year_month"
      expr: DATE_TRUNC('MONTH', initial_receipt_date)
      comment: "Month of initial SUSAR receipt, used for volume trending and regulatory submission workload forecasting."
    - name: "subject_sex"
      expr: subject_sex
      comment: "Sex of the trial subject who experienced the SUSAR, for demographic safety profiling."
  measures:
    - name: "total_susar_count"
      expr: COUNT(1)
      comment: "Total number of SUSARs reported. Primary KPI for clinical trial safety oversight and IND/CTA annual safety reporting."
    - name: "fatal_susar_count"
      expr: COUNT(CASE WHEN is_fatal = TRUE THEN 1 END)
      comment: "Number of fatal SUSARs. Triggers immediate 7-day expedited reporting to all relevant health authorities and may prompt trial suspension."
    - name: "life_threatening_susar_count"
      expr: COUNT(CASE WHEN is_life_threatening = TRUE THEN 1 END)
      comment: "Number of life-threatening SUSARs. Requires 7-day expedited reporting and immediate Data Safety Monitoring Board notification."
    - name: "fatality_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fatal = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SUSARs with fatal outcome. Tracks product lethality profile in clinical development and informs trial risk-benefit assessment."
    - name: "ema_submission_overdue_count"
      expr: COUNT(CASE WHEN ema_eudravigilance_submission_date IS NULL AND reporting_deadline_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of SUSARs overdue for EMA EudraVigilance submission. Direct EMA compliance risk metric tracked by the QPPV."
    - name: "fda_submission_overdue_count"
      expr: COUNT(CASE WHEN fda_ind_submission_date IS NULL AND reporting_deadline_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of SUSARs overdue for FDA IND submission. Direct FDA compliance risk metric; late submissions risk clinical hold."
    - name: "unblinded_susar_count"
      expr: COUNT(CASE WHEN blinding_status = 'Unblinded' THEN 1 END)
      comment: "Number of SUSARs where treatment blinding has been broken. Tracks unblinding events that may compromise trial integrity and require protocol deviation reporting."
    - name: "related_causality_count"
      expr: COUNT(CASE WHEN sponsor_causality = 'Related' THEN 1 END)
      comment: "Number of SUSARs assessed as causally related by the sponsor. Directly drives regulatory reporting obligations and benefit-risk reassessment."
    - name: "related_causality_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sponsor_causality = 'Related' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SUSARs assessed as causally related. Tracks product safety profile evolution across trial phases and informs Investigator Brochure updates."
    - name: "avg_days_to_reporting_deadline"
      expr: AVG(DATEDIFF(reporting_deadline_date, initial_receipt_date))
      comment: "Average number of days between SUSAR receipt and reporting deadline. Measures regulatory clock pressure and operational capacity for timely submissions."
    - name: "unique_trials_with_susar"
      expr: COUNT(DISTINCT trial_id)
      comment: "Number of distinct clinical trials with at least one SUSAR. Measures breadth of safety concerns across the clinical development portfolio."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_pv_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacovigilance regulatory submission metrics tracking submission volume, on-time performance, expedited reporting compliance, and resubmission rates across health authorities. Core compliance KPI surface for PV regulatory affairs."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`pv_submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of PV submission (e.g., ICSR, PSUR, SUSAR, RMP) for workload segmentation and compliance tracking by submission category."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., submitted, acknowledged, rejected, pending) for pipeline management."
    - name: "report_type_qualifier"
      expr: report_type_qualifier
      comment: "Qualifier for the report type (e.g., initial, follow-up, nullification) enabling lifecycle stage analysis."
    - name: "gateway_portal"
      expr: gateway_portal
      comment: "Regulatory gateway or portal used for submission (e.g., EudraVigilance, FDA ESG, PMDA) for channel-level compliance analysis."
    - name: "message_format"
      expr: message_format
      comment: "Electronic message format used (e.g., E2B R2, E2B R3, FHIR) for technical compliance and format migration tracking."
    - name: "submission_year_month"
      expr: DATE_TRUNC('MONTH', CAST(submission_date AS DATE))
      comment: "Month of submission, used for volume trending and regulatory calendar planning."
    - name: "report_period_end_year_month"
      expr: DATE_TRUNC('MONTH', report_period_end)
      comment: "Month of report period end date, used for periodic reporting cycle analysis."
  measures:
    - name: "total_submission_count"
      expr: COUNT(1)
      comment: "Total number of PV regulatory submissions. Baseline volume KPI for regulatory affairs capacity planning and health authority relationship management."
    - name: "expedited_submission_count"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of expedited submissions (7-day or 15-day reports). Tracks high-urgency regulatory reporting workload driven by serious adverse events."
    - name: "on_time_submission_count"
      expr: COUNT(CASE WHEN is_on_time = TRUE THEN 1 END)
      comment: "Number of submissions made on or before the regulatory deadline. Core compliance metric reported to health authorities and internal audit."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_on_time = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PV submissions made on time. Primary regulatory compliance KPI; rates below threshold trigger health authority queries and potential enforcement action."
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Number of submissions rejected by health authorities. Tracks data quality and technical compliance issues requiring immediate remediation."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions rejected by health authorities. Elevated rejection rates indicate systemic data quality or technical issues requiring process improvement."
    - name: "susar_submission_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Number of SUSAR submissions. Tracks clinical trial safety reporting volume and associated regulatory compliance obligations."
    - name: "expedited_on_time_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expedited = TRUE AND is_on_time = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_expedited = TRUE THEN 1 END), 0), 2)
      comment: "On-time rate specifically for expedited submissions. Most stringent compliance metric — failure triggers immediate health authority notification and potential regulatory action."
    - name: "pending_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Pending' AND regulatory_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of submissions still pending past their regulatory deadline. Real-time compliance risk indicator for PV leadership escalation."
    - name: "unique_health_authorities_submitted"
      expr: COUNT(DISTINCT health_authority_id)
      comment: "Number of distinct health authorities receiving PV submissions. Measures global regulatory engagement breadth and submission infrastructure coverage."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_psur`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Periodic Safety Update Report (PSUR) metrics tracking report completion timeliness, cumulative safety exposure, benefit-risk conclusions, and label update obligations. Supports PSUR/PBRER lifecycle management and regulatory compliance."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`psur`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the PSUR (e.g., draft, under review, submitted, approved) for lifecycle pipeline management."
    - name: "report_type"
      expr: report_type
      comment: "Type of periodic safety report (e.g., PSUR, PBRER, DSUR) for regulatory framework segmentation."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of PSUR submission required (e.g., annual, 3-yearly, 6-monthly) for scheduling and resource planning."
    - name: "benefit_risk_conclusion"
      expr: benefit_risk_conclusion
      comment: "Overall benefit-risk conclusion of the PSUR (e.g., favorable, unfavorable, requires further evaluation) — key output for regulatory decision-making."
    - name: "ha_assessment_outcome"
      expr: ha_assessment_outcome
      comment: "Health authority assessment outcome of the PSUR (e.g., no action required, label update required, referral) for post-submission tracking."
    - name: "submission_format"
      expr: submission_format
      comment: "Format of PSUR submission (e.g., eCTD, NeeS, paper) for technical compliance tracking."
    - name: "interval_start_year"
      expr: DATE_TRUNC('YEAR', interval_start_date)
      comment: "Year of PSUR data lock interval start, enabling year-over-year safety data comparison."
    - name: "label_update_required"
      expr: label_update_required
      comment: "Whether the PSUR assessment concluded that a label update is required, driving regulatory variation submissions."
    - name: "rmp_update_required"
      expr: rmp_update_required
      comment: "Whether the PSUR assessment concluded that an RMP update is required, driving risk minimization measure revisions."
  measures:
    - name: "total_psur_count"
      expr: COUNT(1)
      comment: "Total number of PSURs in the portfolio. Baseline KPI for periodic safety reporting workload and regulatory calendar management."
    - name: "submitted_psur_count"
      expr: COUNT(CASE WHEN report_status = 'Submitted' THEN 1 END)
      comment: "Number of PSURs successfully submitted to health authorities. Tracks completion rate of periodic safety reporting obligations."
    - name: "overdue_psur_count"
      expr: COUNT(CASE WHEN report_status NOT IN ('Submitted', 'Approved') AND submission_deadline < CURRENT_DATE() THEN 1 END)
      comment: "Number of PSURs past their submission deadline without confirmed submission. Critical compliance risk metric escalated to QPPV and regulatory leadership."
    - name: "on_time_psur_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_date <= submission_deadline THEN 1 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of submitted PSURs meeting their regulatory deadline. Core periodic safety reporting compliance KPI."
    - name: "label_update_required_count"
      expr: COUNT(CASE WHEN label_update_required = TRUE THEN 1 END)
      comment: "Number of PSURs concluding a label update is required. Tracks safety-driven label change workload and product information evolution."
    - name: "rmp_update_required_count"
      expr: COUNT(CASE WHEN rmp_update_required = TRUE THEN 1 END)
      comment: "Number of PSURs concluding an RMP update is required. Measures risk minimization activity driven by cumulative safety data review."
    - name: "total_cumulative_exposure_patients"
      expr: SUM(CAST(cumulative_exposure_patients AS DOUBLE))
      comment: "Total cumulative patient exposure across all PSURs. Denominator for exposure-adjusted adverse event rate calculations and benefit-risk quantification."
    - name: "total_cumulative_exposure_patient_years"
      expr: SUM(CAST(cumulative_exposure_patient_years AS DOUBLE))
      comment: "Total cumulative patient-years of exposure across all PSURs. Standard epidemiological denominator for incidence rate calculations in periodic safety reports."
    - name: "avg_cumulative_exposure_patient_years"
      expr: AVG(CAST(cumulative_exposure_patient_years AS DOUBLE))
      comment: "Average cumulative patient-years of exposure per PSUR. Benchmarks exposure levels across products and reporting periods."
    - name: "unfavorable_benefit_risk_count"
      expr: COUNT(CASE WHEN benefit_risk_conclusion = 'Unfavorable' THEN 1 END)
      comment: "Number of PSURs with an unfavorable benefit-risk conclusion. Highest-severity PSUR outcome, potentially triggering market withdrawal or major label restrictions."
    - name: "avg_days_draft_to_submission"
      expr: AVG(DATEDIFF(submission_date, draft_completion_date))
      comment: "Average days from draft completion to regulatory submission. Measures internal review and QC process efficiency for PSUR lifecycle management."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_sae_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Serious Adverse Event (SAE) report metrics for clinical trial and post-market safety monitoring. Tracks SAE volume, fatality rates, causality profiles, regulatory submission timeliness, and EDC reconciliation status."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`sae_report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current processing status of the SAE report (e.g., initial, follow-up, final, closed) for workflow management."
    - name: "report_type"
      expr: report_type
      comment: "Type of SAE report (e.g., clinical trial, spontaneous, literature) for source-stratified safety analysis."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Assessed causal relationship between the investigational product and the SAE, driving regulatory reporting obligations."
    - name: "listedness"
      expr: listedness
      comment: "Whether the SAE is listed (expected) or unlisted (unexpected) per the Investigator Brochure or product label."
    - name: "outcome"
      expr: outcome
      comment: "Clinical outcome of the SAE (e.g., recovered, fatal, ongoing, sequelae) for severity profiling."
    - name: "seriousness_criteria"
      expr: seriousness_criteria
      comment: "Specific ICH E2A seriousness criteria met (e.g., fatal, life-threatening, hospitalization, disability)."
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code for the SAE reaction, enabling organ-system level safety surveillance."
    - name: "meddra_pt_name"
      expr: meddra_pt_name
      comment: "MedDRA Preferred Term name for the SAE reaction for granular reaction-level analysis."
    - name: "edc_reconciliation_status"
      expr: edc_reconciliation_status
      comment: "Status of EDC reconciliation for the SAE (e.g., reconciled, discrepant, pending) — critical for clinical trial data integrity."
    - name: "patient_sex"
      expr: patient_sex
      comment: "Sex of the patient who experienced the SAE for demographic safety profiling."
    - name: "receipt_year_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of SAE receipt for volume trending and regulatory submission workload forecasting."
    - name: "medical_review_status"
      expr: medical_review_status
      comment: "Status of medical review for the SAE report (e.g., pending, reviewed, approved) for quality oversight."
  measures:
    - name: "total_sae_count"
      expr: COUNT(1)
      comment: "Total number of SAE reports. Baseline safety volume KPI for clinical trial oversight and post-market surveillance."
    - name: "fatal_sae_count"
      expr: COUNT(CASE WHEN is_fatal = TRUE THEN 1 END)
      comment: "Number of fatal SAEs. Highest-priority safety metric triggering immediate medical review, DSMB notification, and expedited regulatory reporting."
    - name: "susar_sae_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Number of SAEs classified as SUSARs. Drives 7/15-day expedited reporting to all relevant health authorities."
    - name: "fatality_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fatal = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SAEs with fatal outcome. Tracks product lethality profile and informs trial continuation and benefit-risk decisions."
    - name: "susar_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_susar = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SAEs classified as SUSARs. Elevated rates trigger immediate regulatory escalation and potential trial suspension."
    - name: "regulatory_submission_overdue_count"
      expr: COUNT(CASE WHEN regulatory_submission_date IS NULL AND regulatory_submission_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of SAEs past their regulatory submission due date without confirmed submission. Direct compliance risk metric for PV operations."
    - name: "on_time_regulatory_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_submission_date IS NOT NULL AND regulatory_submission_date <= regulatory_submission_due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN regulatory_submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of SAE regulatory submissions made on time. Core clinical trial compliance KPI monitored by the QPPV and clinical operations leadership."
    - name: "edc_discrepant_count"
      expr: COUNT(CASE WHEN edc_reconciliation_status = 'Discrepant' THEN 1 END)
      comment: "Number of SAEs with EDC reconciliation discrepancies. Tracks clinical data integrity issues requiring resolution before database lock."
    - name: "edc_reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edc_reconciliation_status = 'Reconciled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SAEs successfully reconciled with EDC data. Measures clinical data quality and trial data management process effectiveness."
    - name: "unlisted_sae_count"
      expr: COUNT(CASE WHEN listedness = 'Unlisted' THEN 1 END)
      comment: "Number of SAEs classified as unlisted (unexpected). Unlisted serious SAEs are SUSARs requiring expedited reporting and Investigator Brochure review."
    - name: "unique_trials_with_sae"
      expr: COUNT(DISTINCT trial_id)
      comment: "Number of distinct clinical trials with at least one SAE. Measures breadth of safety concerns across the clinical development portfolio."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_rmp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Management Plan (RMP) metrics tracking risk profile complexity, approval status, effectiveness evaluation, and update obligations. Supports EMA and global RMP lifecycle management and risk minimization measure oversight."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`rmp`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the RMP (e.g., approved, pending, under review) for lifecycle pipeline management."
    - name: "rmp_type"
      expr: rmp_type
      comment: "Type of RMP (e.g., EU-RMP, US REMS equivalent, global) for regulatory framework segmentation."
    - name: "pv_plan_type"
      expr: pv_plan_type
      comment: "Type of pharmacovigilance plan within the RMP (e.g., routine, additional) for surveillance intensity classification."
    - name: "risk_minimization_type"
      expr: risk_minimization_type
      comment: "Type of risk minimization measures in place (e.g., routine, additional, educational) for risk management strategy analysis."
    - name: "rems_required"
      expr: rems_required
      comment: "Whether a Risk Evaluation and Mitigation Strategy (REMS) is required, indicating high-risk product classification."
    - name: "benefit_risk_conclusion"
      expr: benefit_risk_conclusion
      comment: "Overall benefit-risk conclusion documented in the RMP for product safety profile tracking."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year of RMP submission, used for annual RMP activity volume analysis."
  measures:
    - name: "total_rmp_count"
      expr: COUNT(1)
      comment: "Total number of RMPs in the portfolio. Baseline KPI for risk management workload and regulatory obligation coverage."
    - name: "approved_rmp_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of RMPs with current health authority approval. Tracks regulatory compliance status of the risk management portfolio."
    - name: "rems_required_count"
      expr: COUNT(CASE WHEN rems_required = TRUE THEN 1 END)
      comment: "Number of products requiring a REMS program. Indicates high-risk product portfolio size and associated regulatory compliance burden."
    - name: "overdue_review_count"
      expr: COUNT(CASE WHEN next_review_date < CURRENT_DATE() AND approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved RMPs past their scheduled review date. Tracks compliance with periodic RMP review obligations imposed by health authorities."
    - name: "avg_identified_risk_count"
      expr: AVG(CAST(identified_risk_count AS DOUBLE))
      comment: "Average number of identified risks per RMP. Benchmarks product risk profile complexity and informs risk minimization resource allocation."
    - name: "avg_potential_risk_count"
      expr: AVG(CAST(potential_risk_count AS DOUBLE))
      comment: "Average number of potential risks per RMP. Tracks uncertainty in product safety profiles and drives additional pharmacovigilance study requirements."
    - name: "avg_missing_information_count"
      expr: AVG(CAST(missing_information_count AS DOUBLE))
      comment: "Average number of missing information items per RMP. Quantifies knowledge gaps in product safety profiles requiring post-authorization studies."
    - name: "avg_pass_commitment_count"
      expr: AVG(CAST(pass_commitment_count AS DOUBLE))
      comment: "Average number of Post-Authorization Safety Study (PASS) commitments per RMP. Measures post-market safety study burden imposed by health authorities."
    - name: "total_identified_risks"
      expr: SUM(CAST(identified_risk_count AS DOUBLE))
      comment: "Total identified risks across all RMPs in the portfolio. Aggregate risk burden metric for executive safety committee reporting."
    - name: "total_pass_commitments"
      expr: SUM(CAST(pass_commitment_count AS DOUBLE))
      comment: "Total Post-Authorization Safety Study commitments across all RMPs. Tracks aggregate post-market study obligation and associated resource requirements."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_pv_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacovigilance action metrics tracking risk minimization and safety action execution, completion timeliness, escalation rates, and regulatory notification compliance. Supports PV action management and effectiveness oversight."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`pv_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of PV action (e.g., label update, DHPC, REMS, product recall, Dear Healthcare Professional letter) for action category analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the PV action (e.g., planned, in-progress, completed, overdue) for pipeline management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the action (e.g., critical, high, medium, low) for resource allocation and escalation decisions."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered the PV action (e.g., safety signal, PSUR finding, regulatory request) for root cause analysis."
    - name: "benefit_risk_impact"
      expr: benefit_risk_impact
      comment: "Assessed impact of the action on the product benefit-risk balance for strategic prioritization."
    - name: "effectiveness_assessment_status"
      expr: effectiveness_assessment_status
      comment: "Status of the risk minimization effectiveness assessment (e.g., planned, ongoing, completed) for regulatory compliance tracking."
    - name: "authority_notification_required"
      expr: authority_notification_required
      comment: "Whether health authority notification is required for this action, identifying regulatory reporting obligations."
    - name: "initiated_year_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the PV action was initiated, used for action volume trending and workload forecasting."
    - name: "labeling_document_type"
      expr: labeling_document_type
      comment: "Type of labeling document affected by the action (e.g., SmPC, PIL, USPI) for labeling change impact analysis."
  measures:
    - name: "total_action_count"
      expr: COUNT(1)
      comment: "Total number of PV actions initiated. Baseline KPI for risk minimization workload and safety action portfolio management."
    - name: "completed_action_count"
      expr: COUNT(CASE WHEN action_status = 'Completed' THEN 1 END)
      comment: "Number of PV actions successfully completed. Tracks execution effectiveness of the risk minimization program."
    - name: "overdue_action_count"
      expr: COUNT(CASE WHEN action_status != 'Completed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of PV actions past their target completion date. Tracks execution delays that may constitute regulatory compliance failures."
    - name: "action_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PV actions completed. Measures overall risk minimization program execution effectiveness."
    - name: "escalated_action_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of PV actions that have been escalated. Tracks execution failures and resource constraints requiring management intervention."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PV actions escalated. Elevated rates indicate systemic execution capacity issues or complexity in the risk minimization portfolio."
    - name: "authority_notification_overdue_count"
      expr: COUNT(CASE WHEN authority_notification_required = TRUE AND authority_notification_date IS NULL AND regulatory_deadline_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of actions requiring health authority notification that are overdue. Direct regulatory compliance risk metric requiring immediate escalation."
    - name: "effectiveness_assessed_count"
      expr: COUNT(CASE WHEN effectiveness_assessment_status = 'Completed' THEN 1 END)
      comment: "Number of PV actions with completed effectiveness assessments. Tracks compliance with health authority requirements to evaluate risk minimization measure effectiveness."
    - name: "effectiveness_assessment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_assessment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PV actions with completed effectiveness assessments. Measures compliance with EMA and FDA requirements for risk minimization measure evaluation."
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(actual_completion_date, initiated_date))
      comment: "Average days from action initiation to completion. Measures risk minimization execution speed and process efficiency against regulatory timelines."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_pv_adverse_reaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse reaction coding and classification metrics tracking reaction volume, seriousness profile, MedDRA coding quality, signal detection flags, and causality distribution. Supports medical review, signal detection, and label currency assessment."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`pv_adverse_reaction`"
  dimensions:
    - name: "meddra_soc_code"
      expr: meddra_soc_code
      comment: "MedDRA System Organ Class code for organ-system level adverse reaction surveillance and signal detection."
    - name: "meddra_pt_name"
      expr: meddra_pt_name
      comment: "MedDRA Preferred Term name for granular reaction-level analysis and signal detection."
    - name: "causality_assessment"
      expr: causality_assessment
      comment: "Assessed causal relationship between the suspect drug and the adverse reaction for regulatory reporting stratification."
    - name: "listedness_determination"
      expr: listedness_determination
      comment: "Whether the reaction is listed (expected) or unlisted (unexpected) per the current product label — drives expedited reporting obligations."
    - name: "outcome_code"
      expr: outcome_code
      comment: "Coded clinical outcome of the adverse reaction (e.g., recovered, fatal, ongoing) for severity profiling."
    - name: "ctcae_grade"
      expr: ctcae_grade
      comment: "CTCAE severity grade (1-5) for oncology adverse reactions, enabling grade-stratified safety analysis."
    - name: "reporting_source_type"
      expr: reporting_source_type
      comment: "Source type of the adverse reaction report (e.g., healthcare professional, patient, literature) for source-stratified analysis."
    - name: "regulatory_report_type"
      expr: regulatory_report_type
      comment: "Regulatory report type classification (e.g., expedited, periodic) for compliance tracking."
    - name: "coding_year_month"
      expr: DATE_TRUNC('MONTH', coding_date)
      comment: "Month of MedDRA coding completion, used for coding throughput trending and backlog management."
    - name: "reaction_status"
      expr: reaction_status
      comment: "Current status of the adverse reaction record (e.g., coded, under review, finalized) for workflow management."
  measures:
    - name: "total_adverse_reaction_count"
      expr: COUNT(1)
      comment: "Total number of coded adverse reactions. Baseline volume KPI for safety surveillance intensity and MedDRA coding workload."
    - name: "serious_reaction_count"
      expr: COUNT(CASE WHEN is_serious = TRUE THEN 1 END)
      comment: "Number of serious adverse reactions. Drives expedited reporting obligations and signal prioritization in safety surveillance."
    - name: "susar_reaction_count"
      expr: COUNT(CASE WHEN is_susar = TRUE THEN 1 END)
      comment: "Number of adverse reactions classified as SUSARs. Critical metric for clinical trial safety oversight and regulatory notification."
    - name: "seriousness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_serious = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse reactions classified as serious. Tracks product safety profile evolution and benchmarks against therapeutic area norms."
    - name: "signal_detected_count"
      expr: COUNT(CASE WHEN signal_detection_flag = TRUE THEN 1 END)
      comment: "Number of adverse reactions flagged for signal detection review. Measures signal detection algorithm sensitivity and emerging safety concern volume."
    - name: "signal_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signal_detection_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse reactions triggering signal detection flags. Tracks signal detection algorithm performance and safety surveillance sensitivity."
    - name: "medically_confirmed_count"
      expr: COUNT(CASE WHEN medical_confirmation = TRUE THEN 1 END)
      comment: "Number of adverse reactions with medical confirmation. Measures report quality and the proportion of cases with validated clinical information."
    - name: "medical_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN medical_confirmation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse reactions with medical confirmation. Higher rates indicate better data quality and more reliable safety signal assessment."
    - name: "unlisted_serious_reaction_count"
      expr: COUNT(CASE WHEN is_serious = TRUE AND listedness_determination = 'Unlisted' THEN 1 END)
      comment: "Number of serious unlisted adverse reactions — the definition of a SUSAR in post-market context. Drives expedited reporting and label update assessments."
    - name: "unique_meddra_pts_reported"
      expr: COUNT(DISTINCT meddra_pt_code)
      comment: "Number of distinct MedDRA Preferred Terms reported. Measures breadth of the adverse reaction profile and label currency coverage."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`pharmacovigilance_pv_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacovigilance Agreement (PVA) metrics tracking agreement compliance status, ICSR and SUSAR exchange timeliness obligations, GDPR data processing agreement coverage, and counterparty relationship management. Supports PVA portfolio governance and partner compliance oversight."
  source: "`pharmaceuticals_ecm`.`pharmacovigilance`.`pv_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of PV agreement (e.g., PVA, SDEA, license agreement PV annex) for agreement category analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the PV agreement (e.g., active, expired, terminated, under negotiation) for portfolio management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the agreement (e.g., compliant, non-compliant, under review) for partner oversight."
    - name: "counterparty_type"
      expr: counterparty_type
      comment: "Type of counterparty (e.g., licensee, licensor, co-marketing partner, CRO) for relationship segmentation."
    - name: "data_exchange_method"
      expr: data_exchange_method
      comment: "Method of safety data exchange (e.g., E2B, paper, portal) for technical compliance and modernization tracking."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic territory scope of the PV agreement for regional coverage analysis."
    - name: "is_gdpr_dpa_in_place"
      expr: is_gdpr_dpa_in_place
      comment: "Whether a GDPR Data Processing Agreement is in place with the counterparty — mandatory for EU data transfers."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the PV agreement became effective, used for portfolio vintage analysis and renewal planning."
  measures:
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of PV agreements in the portfolio. Baseline KPI for PVA governance workload and partner network coverage."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active PV agreements. Tracks the live partner safety data exchange network and associated compliance obligations."
    - name: "non_compliant_agreement_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of PV agreements with non-compliant status. Identifies partner relationships requiring immediate remediation to avoid regulatory exposure."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active PV agreements in compliant status. Core PVA governance KPI reported to the QPPV and regulatory leadership."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' AND expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active PV agreements expiring within 90 days. Drives renewal prioritization to prevent lapses in safety data exchange obligations."
    - name: "gdpr_dpa_missing_count"
      expr: COUNT(CASE WHEN is_gdpr_dpa_in_place = FALSE AND agreement_status = 'Active' THEN 1 END)
      comment: "Number of active PV agreements without a GDPR Data Processing Agreement. Represents direct GDPR compliance risk for EU safety data transfers."
    - name: "gdpr_dpa_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_gdpr_dpa_in_place = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active PV agreements with GDPR DPA in place. Measures GDPR compliance coverage across the partner safety data exchange network."
    - name: "overdue_compliance_review_count"
      expr: COUNT(CASE WHEN next_compliance_review_date < CURRENT_DATE() AND agreement_status = 'Active' THEN 1 END)
      comment: "Number of active PV agreements with overdue compliance reviews. Tracks adherence to periodic PVA audit and review obligations."
    - name: "terminated_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Terminated' THEN 1 END)
      comment: "Number of terminated PV agreements. Tracks partner relationship attrition and associated safety data exchange discontinuations requiring regulatory notification."
$$;