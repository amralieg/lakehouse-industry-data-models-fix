-- Metric views for domain: biostatistics | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_sap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Analysis Plan (SAP) governance metrics tracking plan maturity, amendment activity, significance thresholds, and power levels across studies. Used by biostatistics leadership to monitor SAP readiness and regulatory alignment."
  source: "`clinical_trials_ecm`.`biostatistics`.`sap`"
  dimensions:
    - name: "sap_version_status"
      expr: version_status
      comment: "Current lifecycle status of the SAP version (e.g., Draft, Approved, Superseded) — used to filter active vs. historical plans."
    - name: "sap_analysis_type"
      expr: analysis_type
      comment: "Type of analysis described in the SAP (e.g., Primary, Interim, Final) — key grouping dimension for plan governance."
    - name: "sap_blinding_status"
      expr: blinding_status
      comment: "Blinding state of the SAP (e.g., Blinded, Unblinded) — critical for regulatory compliance tracking."
    - name: "sap_is_current_version"
      expr: is_current_version
      comment: "Boolean flag indicating whether this SAP record is the current active version — used to isolate live plans."
    - name: "sap_missing_data_strategy"
      expr: missing_data_strategy
      comment: "Strategy used for handling missing data (e.g., LOCF, MMRM, Multiple Imputation) — important for regulatory scrutiny."
    - name: "sap_multiplicity_adjustment_method"
      expr: multiplicity_adjustment_method
      comment: "Method used for multiplicity adjustment (e.g., Bonferroni, Hochberg) — governs Type I error control strategy."
    - name: "sap_approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of SAP approval — used to track approval velocity over time."
    - name: "sap_regulatory_impact"
      expr: regulatory_impact
      comment: "Assessed regulatory impact level of the SAP — used to prioritize review and escalation."
  measures:
    - name: "total_saps"
      expr: COUNT(1)
      comment: "Total number of SAP records — baseline volume metric for plan governance tracking."
    - name: "current_version_sap_count"
      expr: COUNT(CASE WHEN is_current_version = TRUE THEN 1 END)
      comment: "Number of SAPs that are currently active/current versions — indicates active study plan footprint."
    - name: "avg_significance_level"
      expr: AVG(CAST(significance_level AS DOUBLE))
      comment: "Average alpha significance level across SAPs — monitors whether studies are using standard (0.05) or more stringent thresholds."
    - name: "avg_power_percent"
      expr: AVG(CAST(power_percent AS DOUBLE))
      comment: "Average statistical power (%) across SAPs — a key quality indicator; values below 80% signal underpowered study designs."
    - name: "dsmb_review_required_count"
      expr: COUNT(CASE WHEN dsmb_review_required = TRUE THEN 1 END)
      comment: "Number of SAPs requiring DSMB review — drives safety oversight scheduling and resource planning."
    - name: "approved_sap_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN version_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SAPs in Approved status — measures plan readiness and governance compliance across the portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_sap_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SAP amendment tracking metrics measuring amendment frequency, scope of changes, and regulatory impact. Used by biostatistics and regulatory leadership to monitor protocol stability and change management risk."
  source: "`clinical_trials_ecm`.`biostatistics`.`sap_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of SAP amendment (e.g., Substantial, Administrative, Urgent Safety) — used to classify change severity."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g., Draft, Approved, Rejected) — used to track amendment lifecycle."
    - name: "pre_dbl_flag"
      expr: pre_dbl_flag
      comment: "Boolean indicating whether the amendment occurred before database lock — pre-DBL amendments are lower risk than post-DBL."
    - name: "primary_endpoint_changed"
      expr: primary_endpoint_changed
      comment: "Boolean flag indicating whether the primary endpoint was changed — a high-risk amendment type requiring regulatory notification."
    - name: "sample_size_changed"
      expr: sample_size_changed
      comment: "Boolean flag indicating whether sample size was revised — signals potential study re-powering events."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Boolean flag indicating whether a regulatory body must be notified — drives compliance action tracking."
    - name: "amendment_effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the amendment became effective — used to trend amendment activity over time."
    - name: "amendment_blinding_impact"
      expr: blinding_impact
      comment: "Description of the amendment's impact on blinding integrity — critical for regulatory and safety review."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of SAP amendments — baseline volume metric for change management monitoring."
    - name: "primary_endpoint_change_count"
      expr: COUNT(CASE WHEN primary_endpoint_changed = TRUE THEN 1 END)
      comment: "Number of amendments that changed the primary endpoint — high-risk events requiring regulatory escalation."
    - name: "sample_size_change_count"
      expr: COUNT(CASE WHEN sample_size_changed = TRUE THEN 1 END)
      comment: "Number of amendments that revised sample size — indicates study re-powering frequency across the portfolio."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of amendments requiring regulatory notification — drives compliance workload forecasting."
    - name: "pre_dbl_amendment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pre_dbl_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments made before database lock — higher rates indicate better-controlled change management."
    - name: "high_risk_amendment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN primary_endpoint_changed = TRUE OR regulatory_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments classified as high-risk (primary endpoint change or regulatory notification required) — key portfolio risk indicator."
    - name: "distinct_studies_with_amendments"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies that have at least one SAP amendment — measures breadth of protocol instability across the portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_sample_size_calc`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample size calculation metrics tracking statistical power, effect sizes, dropout assumptions, and enrollment targets. Used by biostatistics and clinical operations leadership to validate study design adequacy and resource planning."
  source: "`clinical_trials_ecm`.`biostatistics`.`sample_size_calc`"
  dimensions:
    - name: "calc_status"
      expr: calc_status
      comment: "Status of the sample size calculation (e.g., Draft, Approved, Superseded) — used to isolate current approved calculations."
    - name: "hypothesis_type"
      expr: hypothesis_type
      comment: "Type of statistical hypothesis (e.g., Superiority, Non-Inferiority, Equivalence) — key design classification dimension."
    - name: "primary_endpoint_type"
      expr: primary_endpoint_type
      comment: "Type of primary endpoint (e.g., Binary, Continuous, Time-to-Event) — drives the statistical method and sample size formula used."
    - name: "study_design_type"
      expr: study_design_type
      comment: "Overall study design type (e.g., Parallel, Crossover, Adaptive) — important context for interpreting sample size requirements."
    - name: "study_phase"
      expr: study_phase
      comment: "Clinical development phase (e.g., Phase I, II, III) — used to benchmark sample sizes against industry norms."
    - name: "interim_analysis_planned"
      expr: interim_analysis_planned
      comment: "Boolean flag indicating whether an interim analysis is planned — affects alpha spending and total sample size."
    - name: "statistical_method"
      expr: statistical_method
      comment: "Statistical method used for the calculation (e.g., t-test, log-rank, chi-square) — used to audit methodological consistency."
    - name: "calc_approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the sample size calculation was approved — used to track approval cadence."
  measures:
    - name: "total_sample_size_calcs"
      expr: COUNT(1)
      comment: "Total number of sample size calculation records — baseline volume metric."
    - name: "avg_alpha_level"
      expr: AVG(CAST(alpha_level AS DOUBLE))
      comment: "Average alpha (Type I error) level across calculations — monitors adherence to standard significance thresholds (typically 0.05)."
    - name: "avg_power"
      expr: AVG(CAST(power AS DOUBLE))
      comment: "Average statistical power across sample size calculations — values below 0.80 indicate underpowered study designs requiring intervention."
    - name: "avg_effect_size"
      expr: AVG(CAST(effect_size AS DOUBLE))
      comment: "Average assumed effect size across calculations — used to benchmark assumptions against historical data and literature."
    - name: "avg_dropout_rate"
      expr: AVG(CAST(dropout_rate AS DOUBLE))
      comment: "Average assumed dropout rate across studies — informs enrollment buffer planning and operational risk assessment."
    - name: "avg_non_inferiority_margin"
      expr: AVG(CAST(non_inferiority_margin AS DOUBLE))
      comment: "Average non-inferiority margin across NI study calculations — used to assess regulatory acceptability of margin assumptions."
    - name: "underpowered_study_count"
      expr: COUNT(CASE WHEN power < 0.80 THEN 1 END)
      comment: "Number of sample size calculations with power below 80% — a critical quality flag requiring biostatistics review and potential redesign."
    - name: "interim_analysis_planned_count"
      expr: COUNT(CASE WHEN interim_analysis_planned = TRUE THEN 1 END)
      comment: "Number of studies with planned interim analyses — drives DSMB scheduling and alpha-spending resource planning."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_interim_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interim analysis execution metrics tracking stopping rules, alpha spending, information fractions, and outcome rates. Used by biostatistics, DSMB, and executive leadership to monitor adaptive trial performance and early stopping decisions."
  source: "`clinical_trials_ecm`.`biostatistics`.`interim_analysis`"
  dimensions:
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of interim analysis (e.g., Efficacy, Futility, Safety, Adaptive) — primary classification for analysis governance."
    - name: "analysis_status"
      expr: analysis_status
      comment: "Current status of the interim analysis (e.g., Planned, In Progress, Complete) — used to track execution progress."
    - name: "analysis_outcome"
      expr: analysis_outcome
      comment: "Outcome of the interim analysis (e.g., Continue, Stop for Efficacy, Stop for Futility) — the most critical decision output."
    - name: "stopping_rule_triggered"
      expr: stopping_rule_triggered
      comment: "Boolean flag indicating whether a pre-specified stopping rule was triggered — drives trial continuation/termination decisions."
    - name: "dsmb_involved"
      expr: dsmb_involved
      comment: "Boolean flag indicating DSMB involvement in the interim analysis — required for safety oversight governance."
    - name: "alpha_spending_function"
      expr: alpha_spending_function
      comment: "Alpha spending function used (e.g., O'Brien-Fleming, Pocock, Lan-DeMets) — governs Type I error allocation across looks."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the interim analysis results — critical for blinding integrity management."
    - name: "actual_analysis_date"
      expr: DATE_TRUNC('month', actual_analysis_date)
      comment: "Month the interim analysis was actually conducted — used to track execution timeliness."
  measures:
    - name: "total_interim_analyses"
      expr: COUNT(1)
      comment: "Total number of interim analyses conducted — baseline volume metric for adaptive trial monitoring."
    - name: "stopping_rule_triggered_count"
      expr: COUNT(CASE WHEN stopping_rule_triggered = TRUE THEN 1 END)
      comment: "Number of interim analyses where a stopping rule was triggered — a critical portfolio-level signal for trial termination events."
    - name: "stopping_rule_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN stopping_rule_triggered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interim analyses that triggered a stopping rule — measures adaptive trial responsiveness and portfolio risk."
    - name: "avg_information_fraction_actual"
      expr: AVG(CAST(information_fraction_actual AS DOUBLE))
      comment: "Average actual information fraction at interim analysis — measures how much of the planned data was available, informing analysis timing quality."
    - name: "avg_alpha_allocated"
      expr: AVG(CAST(alpha_allocated AS DOUBLE))
      comment: "Average alpha allocated at interim analyses — monitors Type I error spending patterns across the portfolio."
    - name: "avg_conditional_power"
      expr: AVG(CAST(conditional_power AS DOUBLE))
      comment: "Average conditional power at interim analyses — values below 20% typically trigger futility stopping; a key adaptive trial health indicator."
    - name: "avg_observed_p_value"
      expr: AVG(CAST(observed_p_value AS DOUBLE))
      comment: "Average observed p-value at interim analyses — provides a portfolio-level view of interim efficacy signal strength."
    - name: "sample_size_reestimated_count"
      expr: COUNT(CASE WHEN sample_size_reestimated = TRUE THEN 1 END)
      comment: "Number of interim analyses that triggered a sample size re-estimation — indicates adaptive design utilization and enrollment impact."
    - name: "results_disclosed_externally_count"
      expr: COUNT(CASE WHEN results_disclosed_externally = TRUE THEN 1 END)
      comment: "Number of interim analyses with externally disclosed results — tracks regulatory and public disclosure obligations."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_database_lock_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Database lock event metrics tracking lock timeliness, quality gate completion, and outstanding data issues at lock. Used by data management and biostatistics leadership to monitor data readiness and lock quality across studies."
  source: "`clinical_trials_ecm`.`biostatistics`.`database_lock_event`"
  dimensions:
    - name: "lock_status"
      expr: lock_status
      comment: "Current status of the database lock event (e.g., Planned, Locked, Unlocked) — primary lifecycle dimension."
    - name: "lock_type"
      expr: lock_type
      comment: "Type of database lock (e.g., Interim, Final, Partial) — used to distinguish lock scope and regulatory significance."
    - name: "lock_scope"
      expr: lock_scope
      comment: "Scope of the lock (e.g., Full Study, Subset, Site-Level) — used to assess completeness of locked data."
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of analysis the lock supports (e.g., Primary, Interim, Safety) — links lock events to analysis milestones."
    - name: "coding_complete"
      expr: coding_complete
      comment: "Boolean flag indicating whether medical coding was complete at lock — a key data quality gate."
    - name: "sae_reconciliation_complete"
      expr: sae_reconciliation_complete
      comment: "Boolean flag indicating whether SAE reconciliation was complete at lock — critical safety data quality indicator."
    - name: "sdv_complete"
      expr: sdv_complete
      comment: "Boolean flag indicating whether source data verification was complete at lock — regulatory compliance quality gate."
    - name: "actual_lock_date"
      expr: DATE_TRUNC('month', actual_lock_date)
      comment: "Month the database was actually locked — used to trend lock activity and compare against planned timelines."
  measures:
    - name: "total_lock_events"
      expr: COUNT(1)
      comment: "Total number of database lock events — baseline volume metric for data management throughput."
    - name: "locks_with_all_quality_gates_complete"
      expr: COUNT(CASE WHEN coding_complete = TRUE AND sae_reconciliation_complete = TRUE AND sdv_complete = TRUE AND pre_lock_qc_checklist_complete = TRUE THEN 1 END)
      comment: "Number of lock events where all quality gates (coding, SAE reconciliation, SDV, QC checklist) were complete — measures lock quality and data integrity."
    - name: "quality_gate_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN coding_complete = TRUE AND sae_reconciliation_complete = TRUE AND sdv_complete = TRUE AND pre_lock_qc_checklist_complete = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lock events with all quality gates complete — a key data quality KPI; low rates signal systemic data readiness issues."
    - name: "unblinding_required_count"
      expr: COUNT(CASE WHEN unblinding_required = TRUE THEN 1 END)
      comment: "Number of lock events requiring unblinding — tracks unblinding frequency as a portfolio-level risk and regulatory event indicator."
    - name: "dsmb_notification_required_count"
      expr: COUNT(CASE WHEN dsmb_notification_required = TRUE THEN 1 END)
      comment: "Number of lock events requiring DSMB notification — drives safety oversight scheduling and compliance tracking."
    - name: "sae_reconciliation_incomplete_count"
      expr: COUNT(CASE WHEN sae_reconciliation_complete = FALSE THEN 1 END)
      comment: "Number of lock events where SAE reconciliation was not complete — a critical safety data quality risk indicator requiring immediate attention."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_estimand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Estimand framework metrics tracking ICH E9(R1) compliance, confirmatory analysis coverage, and intercurrent event strategy adoption. Used by biostatistics and regulatory leadership to ensure estimand-aligned trial design and submission readiness."
  source: "`clinical_trials_ecm`.`biostatistics`.`estimand`"
  dimensions:
    - name: "estimand_type"
      expr: estimand_type
      comment: "Type of estimand (e.g., Primary, Sensitivity, Supplementary) — used to classify estimand hierarchy and regulatory priority."
    - name: "estimand_status"
      expr: estimand_status
      comment: "Current lifecycle status of the estimand (e.g., Draft, Approved, Superseded) — used to isolate active estimands."
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of endpoint the estimand addresses (e.g., Efficacy, Safety, PK) — key classification for regulatory review."
    - name: "intercurrent_event_strategy"
      expr: intercurrent_event_strategy
      comment: "ICH E9(R1) strategy for handling intercurrent events (e.g., Treatment Policy, Hypothetical, Composite) — measures estimand framework adoption."
    - name: "missing_data_strategy"
      expr: missing_data_strategy
      comment: "Strategy for handling missing data in the estimand (e.g., MMRM, Multiple Imputation) — regulatory scrutiny dimension."
    - name: "is_confirmatory"
      expr: is_confirmatory
      comment: "Boolean flag indicating whether the estimand is part of the confirmatory analysis — distinguishes regulatory-critical from exploratory estimands."
    - name: "is_primary_endpoint"
      expr: is_primary_endpoint
      comment: "Boolean flag indicating whether the estimand addresses the primary endpoint — highest regulatory priority classification."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the estimand (e.g., ICH E9(R1), FDA Guidance) — used to audit framework compliance."
  measures:
    - name: "total_estimands"
      expr: COUNT(1)
      comment: "Total number of estimands defined across the portfolio — baseline metric for ICH E9(R1) framework adoption."
    - name: "confirmatory_estimand_count"
      expr: COUNT(CASE WHEN is_confirmatory = TRUE THEN 1 END)
      comment: "Number of confirmatory estimands — measures the scope of regulatory-critical analysis commitments."
    - name: "primary_endpoint_estimand_count"
      expr: COUNT(CASE WHEN is_primary_endpoint = TRUE THEN 1 END)
      comment: "Number of estimands addressing primary endpoints — directly linked to regulatory approval decisions."
    - name: "avg_alpha_level"
      expr: AVG(CAST(alpha_level AS DOUBLE))
      comment: "Average alpha level across estimands — monitors Type I error control consistency across the portfolio."
    - name: "avg_non_inferiority_margin"
      expr: AVG(CAST(non_inferiority_margin AS DOUBLE))
      comment: "Average non-inferiority margin across NI estimands — used to benchmark margin assumptions against regulatory acceptability."
    - name: "approved_estimand_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN estimand_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of estimands in Approved status — measures estimand governance maturity and submission readiness."
    - name: "distinct_studies_with_estimands"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with at least one defined estimand — measures ICH E9(R1) framework adoption breadth across the portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_statistical_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical endpoint metrics tracking endpoint classification, multiplicity management, and analysis readiness. Used by biostatistics and regulatory teams to monitor endpoint governance and submission package completeness."
  source: "`clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`"
  dimensions:
    - name: "endpoint_status"
      expr: endpoint_status
      comment: "Current lifecycle status of the statistical endpoint (e.g., Draft, Approved, Locked) — used to track endpoint readiness."
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of endpoint (e.g., Primary, Secondary, Exploratory) — the most critical classification for regulatory prioritization."
    - name: "endpoint_classification"
      expr: endpoint_classification
      comment: "Clinical classification of the endpoint (e.g., Efficacy, Safety, PK/PD) — used to segment analysis workload."
    - name: "hypothesis_type"
      expr: hypothesis_type
      comment: "Statistical hypothesis type (e.g., Superiority, Non-Inferiority, Equivalence) — governs the statistical test and margin requirements."
    - name: "statistical_test_method"
      expr: statistical_test_method
      comment: "Statistical test method used (e.g., ANCOVA, Log-Rank, Mixed Model) — used to audit methodological consistency."
    - name: "multiplicity_adjustment_method"
      expr: multiplicity_adjustment_method
      comment: "Method used for multiplicity adjustment — critical for controlling family-wise error rate in confirmatory trials."
    - name: "sensitivity_analysis_flag"
      expr: sensitivity_analysis_flag
      comment: "Boolean flag indicating whether this is a sensitivity analysis endpoint — used to distinguish primary from supportive analyses."
    - name: "subgroup_analysis_flag"
      expr: subgroup_analysis_flag
      comment: "Boolean flag indicating whether this is a subgroup analysis — used to track exploratory analysis scope."
  measures:
    - name: "total_statistical_endpoints"
      expr: COUNT(1)
      comment: "Total number of statistical endpoints defined — baseline metric for analysis scope and workload planning."
    - name: "primary_endpoint_count"
      expr: COUNT(CASE WHEN endpoint_type = 'Primary' THEN 1 END)
      comment: "Number of primary statistical endpoints — directly linked to regulatory approval decisions and confirmatory analysis scope."
    - name: "approved_endpoint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN endpoint_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of statistical endpoints in Approved status — measures analysis governance maturity and submission readiness."
    - name: "avg_significance_level"
      expr: AVG(CAST(significance_level AS DOUBLE))
      comment: "Average significance level across statistical endpoints — monitors Type I error control consistency."
    - name: "avg_confidence_interval_level"
      expr: AVG(CAST(confidence_interval_level AS DOUBLE))
      comment: "Average confidence interval level across endpoints — ensures consistent CI reporting standards across the portfolio."
    - name: "avg_non_inferiority_margin"
      expr: AVG(CAST(non_inferiority_margin AS DOUBLE))
      comment: "Average non-inferiority margin across NI endpoints — used to benchmark margin assumptions for regulatory review."
    - name: "subgroup_analysis_count"
      expr: COUNT(CASE WHEN subgroup_analysis_flag = TRUE THEN 1 END)
      comment: "Number of subgroup analyses defined — tracks exploratory analysis scope and associated multiplicity risk."
    - name: "distinct_studies_with_endpoints"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with defined statistical endpoints — measures analysis planning coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_tlf_output`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TLF (Tables, Listings, Figures) output production and quality metrics tracking delivery status, QC completion rates, and submission readiness. Used by biostatistics and programming leadership to monitor output delivery performance and CSR/submission package completeness."
  source: "`clinical_trials_ecm`.`biostatistics`.`tlf_output`"
  dimensions:
    - name: "output_type"
      expr: output_type
      comment: "Type of TLF output (e.g., Table, Listing, Figure) — primary classification for output governance and workload tracking."
    - name: "output_category"
      expr: output_category
      comment: "Business category of the output (e.g., Efficacy, Safety, Demographics) — used to segment delivery performance by analysis area."
    - name: "qc_status"
      expr: qc_status
      comment: "QC status of the TLF output (e.g., Pending, Pass, Fail) — key quality gate for submission readiness."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the TLF output (e.g., Draft, Approved, Rejected) — final governance gate before submission inclusion."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the output (e.g., Blinded, Unblinded) — critical for regulatory compliance and data integrity."
    - name: "is_final_version"
      expr: is_final_version
      comment: "Boolean flag indicating whether this is the final approved version of the output — used to isolate submission-ready TLFs."
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of analysis the output supports (e.g., Primary, Interim, Safety) — used to prioritize delivery tracking."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of TLF delivery — used to track output delivery velocity and milestone adherence."
  measures:
    - name: "total_tlf_outputs"
      expr: COUNT(1)
      comment: "Total number of TLF outputs produced — baseline volume metric for programming delivery tracking."
    - name: "qc_passed_count"
      expr: COUNT(CASE WHEN qc_status = 'Pass' THEN 1 END)
      comment: "Number of TLF outputs that passed QC — measures quality throughput in the programming delivery pipeline."
    - name: "qc_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of TLF outputs passing QC — a critical quality KPI; low rates signal programming quality issues requiring intervention."
    - name: "approved_output_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of TLF outputs with final approval — measures submission package completeness."
    - name: "final_version_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_final_version = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of TLF outputs that are final versions — measures CSR/submission package finalization progress."
    - name: "distinct_studies_with_outputs"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with TLF outputs produced — measures programming delivery coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_tlf_shell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "TLF shell design and production readiness metrics tracking shell approval rates, delivery timelines, and regulatory submission scope. Used by biostatistics programming leads to monitor shell design completeness and prioritize production scheduling."
  source: "`clinical_trials_ecm`.`biostatistics`.`tlf_shell`"
  dimensions:
    - name: "output_type"
      expr: output_type
      comment: "Type of TLF shell (e.g., Table, Listing, Figure) — primary classification for shell governance."
    - name: "output_category"
      expr: output_category
      comment: "Business category of the shell (e.g., Efficacy, Safety, PK) — used to segment design workload by analysis area."
    - name: "production_status"
      expr: production_status
      comment: "Current production status of the shell (e.g., Draft, In Review, Approved, In Production) — tracks shell lifecycle."
    - name: "is_primary_endpoint"
      expr: is_primary_endpoint
      comment: "Boolean flag indicating whether the shell supports a primary endpoint — used to prioritize high-regulatory-value outputs."
    - name: "is_regulatory_submission"
      expr: is_regulatory_submission
      comment: "Boolean flag indicating whether the shell is destined for regulatory submission — drives submission package planning."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the shell (e.g., Blinded, Unblinded) — critical for data integrity governance."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the shell (e.g., Tier 1, Tier 2, Tier 3) — used to schedule production and QC resources."
    - name: "shell_created_date"
      expr: DATE_TRUNC('month', shell_created_date)
      comment: "Month the shell was created — used to track design activity and pipeline build-up over time."
  measures:
    - name: "total_tlf_shells"
      expr: COUNT(1)
      comment: "Total number of TLF shells designed — baseline metric for programming scope and workload planning."
    - name: "approved_shell_count"
      expr: COUNT(CASE WHEN production_status = 'Approved' THEN 1 END)
      comment: "Number of TLF shells with approved status — measures design governance completion and production readiness."
    - name: "shell_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN production_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of TLF shells in Approved status — key readiness KPI for CSR and submission package planning."
    - name: "regulatory_submission_shell_count"
      expr: COUNT(CASE WHEN is_regulatory_submission = TRUE THEN 1 END)
      comment: "Number of TLF shells designated for regulatory submission — defines the minimum submission package scope."
    - name: "primary_endpoint_shell_count"
      expr: COUNT(CASE WHEN is_primary_endpoint = TRUE THEN 1 END)
      comment: "Number of TLF shells supporting primary endpoints — highest-priority outputs for regulatory review and approval decisions."
    - name: "distinct_studies_with_shells"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with TLF shells designed — measures programming design coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_analysis_population`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analysis population definition metrics tracking population completeness, regulatory alignment, and sensitivity analysis coverage. Used by biostatistics and regulatory teams to ensure population definitions are complete, approved, and submission-ready."
  source: "`clinical_trials_ecm`.`biostatistics`.`analysis_population`"
  dimensions:
    - name: "population_type"
      expr: population_type
      comment: "Type of analysis population (e.g., ITT, PP, Safety, mITT) — the primary classification for regulatory and statistical analysis."
    - name: "population_status"
      expr: population_status
      comment: "Current lifecycle status of the population definition (e.g., Draft, Approved, Finalized) — tracks definition readiness."
    - name: "analysis_phase"
      expr: analysis_phase
      comment: "Analysis phase the population applies to (e.g., Interim, Final, Post-Hoc) — used to segment population governance by milestone."
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the population definition — critical for regulatory compliance."
    - name: "primary_population_flag"
      expr: primary_population_flag
      comment: "Boolean flag indicating whether this is the primary analysis population — highest regulatory priority classification."
    - name: "regulatory_primary_flag"
      expr: regulatory_primary_flag
      comment: "Boolean flag indicating whether this population is the regulatory primary population — directly linked to submission requirements."
    - name: "sensitivity_analysis_flag"
      expr: sensitivity_analysis_flag
      comment: "Boolean flag indicating whether this is a sensitivity analysis population — used to track robustness analysis coverage."
    - name: "population_finalized_date"
      expr: DATE_TRUNC('month', population_finalized_date)
      comment: "Month the population definition was finalized — used to track definition completion velocity."
  measures:
    - name: "total_analysis_populations"
      expr: COUNT(1)
      comment: "Total number of analysis population definitions — baseline metric for population governance scope."
    - name: "primary_population_count"
      expr: COUNT(CASE WHEN primary_population_flag = TRUE THEN 1 END)
      comment: "Number of primary analysis populations defined — ensures each study has a designated primary population for regulatory submission."
    - name: "regulatory_primary_population_count"
      expr: COUNT(CASE WHEN regulatory_primary_flag = TRUE THEN 1 END)
      comment: "Number of populations designated as regulatory primary — directly maps to submission package requirements."
    - name: "approved_population_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN population_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of analysis populations in Approved status — measures population definition governance maturity."
    - name: "sensitivity_analysis_population_count"
      expr: COUNT(CASE WHEN sensitivity_analysis_flag = TRUE THEN 1 END)
      comment: "Number of sensitivity analysis populations defined — measures robustness analysis coverage for regulatory submissions."
    - name: "distinct_studies_with_populations"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with defined analysis populations — measures population governance coverage across the portfolio."
$$;