-- Metric views for domain: biostatistics | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_sap`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for Statistical Analysis Plans (SAPs) tracking version currency, approval status, and regulatory alignment across clinical studies."
  source: "`clinical_trials_ecm`.`biostatistics`.`sap`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Current lifecycle status of the SAP version (e.g., Draft, Approved, Superseded)"
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the SAP (e.g., Blinded, Unblinded)"
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of analysis specified in the SAP (e.g., Primary, Interim, Final)"
    - name: "is_current_version"
      expr: is_current_version
      comment: "Whether this SAP is the current active version"
    - name: "dsmb_review_required"
      expr: dsmb_review_required
      comment: "Whether DSMB review is required for this SAP"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the SAP was approved"
    - name: "primary_statistical_method"
      expr: primary_statistical_method
      comment: "Primary statistical methodology specified in the SAP"
  measures:
    - name: "total_saps"
      expr: COUNT(1)
      comment: "Total number of Statistical Analysis Plans"
    - name: "current_version_saps"
      expr: COUNT(CASE WHEN is_current_version = TRUE THEN 1 END)
      comment: "Number of SAPs that are the current active version"
    - name: "avg_significance_level"
      expr: AVG(CAST(significance_level AS DOUBLE))
      comment: "Average significance level (alpha) across SAPs, indicating statistical rigor standards"
    - name: "avg_power_percent"
      expr: AVG(CAST(power_percent AS DOUBLE))
      comment: "Average statistical power percentage across SAPs, indicating study design adequacy"
    - name: "dsmb_required_saps"
      expr: COUNT(CASE WHEN dsmb_review_required = TRUE THEN 1 END)
      comment: "Number of SAPs requiring DSMB review, indicating safety oversight burden"
    - name: "distinct_studies_with_saps"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with Statistical Analysis Plans"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_interim_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for interim analyses tracking stopping rule triggers, alpha spending, conditional power, and DSMB involvement to monitor study progression and early termination decisions."
  source: "`clinical_trials_ecm`.`biostatistics`.`interim_analysis`"
  dimensions:
    - name: "analysis_status"
      expr: analysis_status
      comment: "Current status of the interim analysis (e.g., Planned, Completed, Cancelled)"
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of interim analysis (e.g., Efficacy, Futility, Safety)"
    - name: "analysis_outcome"
      expr: analysis_outcome
      comment: "Outcome/result of the interim analysis"
    - name: "stopping_rule_triggered"
      expr: stopping_rule_triggered
      comment: "Whether a stopping rule was triggered at this interim analysis"
    - name: "dsmb_involved"
      expr: dsmb_involved
      comment: "Whether the DSMB was involved in this interim analysis"
    - name: "unblinding_scope"
      expr: unblinding_scope
      comment: "Scope of unblinding performed during the interim analysis"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the interim analysis results"
    - name: "analysis_year"
      expr: YEAR(actual_analysis_date)
      comment: "Year the interim analysis was actually conducted"
  measures:
    - name: "total_interim_analyses"
      expr: COUNT(1)
      comment: "Total number of interim analyses conducted or planned"
    - name: "stopping_rule_triggered_count"
      expr: COUNT(CASE WHEN stopping_rule_triggered = TRUE THEN 1 END)
      comment: "Number of interim analyses where a stopping rule was triggered, indicating potential early study termination"
    - name: "avg_conditional_power"
      expr: AVG(CAST(conditional_power AS DOUBLE))
      comment: "Average conditional power across interim analyses, indicating likelihood of achieving significance at final analysis"
    - name: "avg_information_fraction_actual"
      expr: AVG(CAST(information_fraction_actual AS DOUBLE))
      comment: "Average actual information fraction at interim, indicating data maturity at time of analysis"
    - name: "avg_alpha_allocated"
      expr: AVG(CAST(alpha_allocated AS DOUBLE))
      comment: "Average alpha allocated at interim analyses, tracking type I error spending"
    - name: "dsmb_involved_count"
      expr: COUNT(CASE WHEN dsmb_involved = TRUE THEN 1 END)
      comment: "Number of interim analyses with DSMB involvement"
    - name: "sample_size_reestimated_count"
      expr: COUNT(CASE WHEN sample_size_reestimated = TRUE THEN 1 END)
      comment: "Number of interim analyses where sample size was re-estimated, indicating adaptive design execution"
    - name: "distinct_studies_with_interim"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with interim analyses planned or conducted"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_database_lock_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for database lock events tracking lock timeliness, quality readiness, and operational efficiency critical to study completion milestones."
  source: "`clinical_trials_ecm`.`biostatistics`.`database_lock_event`"
  dimensions:
    - name: "lock_status"
      expr: lock_status
      comment: "Current status of the database lock (e.g., Planned, Locked, Unlocked)"
    - name: "lock_type"
      expr: lock_type
      comment: "Type of database lock (e.g., Interim, Final, Partial)"
    - name: "lock_scope"
      expr: lock_scope
      comment: "Scope of the database lock (e.g., Full, Partial, Site-level)"
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of analysis associated with this lock event"
    - name: "lock_year"
      expr: YEAR(actual_lock_date)
      comment: "Year the database was actually locked"
    - name: "study_part"
      expr: study_part
      comment: "Part of the study associated with this lock event"
  measures:
    - name: "total_lock_events"
      expr: COUNT(1)
      comment: "Total number of database lock events"
    - name: "completed_locks"
      expr: COUNT(CASE WHEN lock_status = 'Locked' THEN 1 END)
      comment: "Number of database locks that have been completed"
    - name: "pre_lock_qc_complete_count"
      expr: COUNT(CASE WHEN pre_lock_qc_checklist_complete = TRUE THEN 1 END)
      comment: "Number of lock events with pre-lock QC checklist completed, indicating quality readiness"
    - name: "sae_reconciliation_complete_count"
      expr: COUNT(CASE WHEN sae_reconciliation_complete = TRUE THEN 1 END)
      comment: "Number of lock events with SAE reconciliation completed, critical for patient safety data integrity"
    - name: "sdv_complete_count"
      expr: COUNT(CASE WHEN sdv_complete = TRUE THEN 1 END)
      comment: "Number of lock events with source data verification completed"
    - name: "coding_complete_count"
      expr: COUNT(CASE WHEN coding_complete = TRUE THEN 1 END)
      comment: "Number of lock events with medical coding completed"
    - name: "distinct_studies_locked"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with database lock events"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_tlf_output`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for Tables, Listings, and Figures (TLF) output production tracking delivery performance, QC status, and regulatory submission readiness."
  source: "`clinical_trials_ecm`.`biostatistics`.`tlf_output`"
  dimensions:
    - name: "output_type"
      expr: output_type
      comment: "Type of TLF output (Table, Listing, or Figure)"
    - name: "output_category"
      expr: output_category
      comment: "Category of the TLF output (e.g., Efficacy, Safety, Disposition)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control status of the TLF output"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the TLF output"
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status of the TLF output"
    - name: "is_final_version"
      expr: is_final_version
      comment: "Whether this is the final version of the TLF output"
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of analysis for this TLF output (e.g., Primary, Sensitivity)"
    - name: "output_file_format"
      expr: output_file_format
      comment: "File format of the TLF output (e.g., RTF, PDF)"
    - name: "delivery_year_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of TLF delivery for trend analysis"
  measures:
    - name: "total_tlf_outputs"
      expr: COUNT(1)
      comment: "Total number of TLF outputs produced"
    - name: "final_version_outputs"
      expr: COUNT(CASE WHEN is_final_version = TRUE THEN 1 END)
      comment: "Number of TLF outputs in final version, indicating production completion"
    - name: "qc_passed_outputs"
      expr: COUNT(CASE WHEN qc_status = 'Passed' THEN 1 END)
      comment: "Number of TLF outputs that passed QC, indicating quality throughput"
    - name: "distinct_studies_with_outputs"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with TLF outputs produced"
    - name: "distinct_saps_with_outputs"
      expr: COUNT(DISTINCT sap_id)
      comment: "Number of distinct SAPs with TLF outputs, indicating SAP execution coverage"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_sample_size_calc`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for sample size calculations tracking statistical design parameters, power adequacy, and study design characteristics critical to protocol feasibility."
  source: "`clinical_trials_ecm`.`biostatistics`.`sample_size_calc`"
  dimensions:
    - name: "calc_status"
      expr: calc_status
      comment: "Status of the sample size calculation (e.g., Draft, Approved, Superseded)"
    - name: "study_phase"
      expr: study_phase
      comment: "Clinical trial phase (e.g., Phase I, II, III, IV)"
    - name: "study_design_type"
      expr: study_design_type
      comment: "Type of study design (e.g., Parallel, Crossover, Factorial)"
    - name: "hypothesis_type"
      expr: hypothesis_type
      comment: "Type of hypothesis being tested (e.g., Superiority, Non-inferiority, Equivalence)"
    - name: "primary_endpoint_type"
      expr: primary_endpoint_type
      comment: "Type of primary endpoint (e.g., Continuous, Binary, Time-to-event)"
    - name: "statistical_method"
      expr: statistical_method
      comment: "Statistical method used for sample size calculation"
    - name: "interim_analysis_planned"
      expr: interim_analysis_planned
      comment: "Whether interim analysis is planned for this study"
    - name: "test_sidedness"
      expr: test_sidedness
      comment: "Sidedness of the statistical test (One-sided, Two-sided)"
  measures:
    - name: "total_calculations"
      expr: COUNT(1)
      comment: "Total number of sample size calculations performed"
    - name: "avg_power"
      expr: AVG(CAST(power AS DOUBLE))
      comment: "Average statistical power across calculations, indicating study design adequacy (target typically 80-90%)"
    - name: "avg_alpha_level"
      expr: AVG(CAST(alpha_level AS DOUBLE))
      comment: "Average alpha (significance) level across calculations"
    - name: "avg_effect_size"
      expr: AVG(CAST(effect_size AS DOUBLE))
      comment: "Average expected effect size across calculations, indicating anticipated treatment benefit magnitude"
    - name: "avg_dropout_rate"
      expr: AVG(CAST(dropout_rate AS DOUBLE))
      comment: "Average anticipated dropout rate, critical for enrollment planning and study feasibility"
    - name: "distinct_studies_calculated"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with sample size calculations"
    - name: "interim_planned_count"
      expr: COUNT(CASE WHEN interim_analysis_planned = TRUE THEN 1 END)
      comment: "Number of calculations with interim analysis planned, indicating adaptive/group-sequential designs"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_statistical_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for statistical endpoints tracking endpoint classification, multiplicity management, and analysis readiness across clinical studies."
  source: "`clinical_trials_ecm`.`biostatistics`.`statistical_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Classification of endpoint (Primary, Secondary, Exploratory)"
    - name: "endpoint_status"
      expr: endpoint_status
      comment: "Current status of the statistical endpoint"
    - name: "endpoint_classification"
      expr: endpoint_classification
      comment: "Regulatory classification of the endpoint"
    - name: "hypothesis_type"
      expr: hypothesis_type
      comment: "Type of hypothesis (Superiority, Non-inferiority, Equivalence)"
    - name: "statistical_test_method"
      expr: statistical_test_method
      comment: "Statistical test method used for the endpoint analysis"
    - name: "multiplicity_adjustment_method"
      expr: multiplicity_adjustment_method
      comment: "Method used for multiplicity adjustment (e.g., Bonferroni, Hochberg, Gatekeeping)"
    - name: "sensitivity_analysis_flag"
      expr: sensitivity_analysis_flag
      comment: "Whether this endpoint has sensitivity analyses defined"
    - name: "regulatory_designation"
      expr: regulatory_designation
      comment: "Regulatory designation of the endpoint"
    - name: "measurement_scale"
      expr: measurement_scale
      comment: "Measurement scale of the endpoint (e.g., Continuous, Ordinal, Binary)"
  measures:
    - name: "total_statistical_endpoints"
      expr: COUNT(1)
      comment: "Total number of statistical endpoints defined"
    - name: "primary_endpoints"
      expr: COUNT(CASE WHEN endpoint_type = 'Primary' THEN 1 END)
      comment: "Number of primary endpoints, the key efficacy measures for regulatory decision-making"
    - name: "avg_significance_level"
      expr: AVG(CAST(significance_level AS DOUBLE))
      comment: "Average significance level across endpoints, reflecting alpha allocation strategy"
    - name: "avg_confidence_interval_level"
      expr: AVG(CAST(confidence_interval_level AS DOUBLE))
      comment: "Average confidence interval level across endpoints"
    - name: "sensitivity_analysis_endpoints"
      expr: COUNT(CASE WHEN sensitivity_analysis_flag = TRUE THEN 1 END)
      comment: "Number of endpoints with sensitivity analyses, indicating robustness of analysis strategy"
    - name: "subgroup_analysis_endpoints"
      expr: COUNT(CASE WHEN subgroup_analysis_flag = TRUE THEN 1 END)
      comment: "Number of endpoints with subgroup analyses planned"
    - name: "distinct_studies_with_endpoints"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with statistical endpoints defined"
    - name: "interim_analysis_endpoints"
      expr: COUNT(CASE WHEN interim_analysis_flag = TRUE THEN 1 END)
      comment: "Number of endpoints included in interim analyses"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_sap_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for SAP amendments tracking change frequency, regulatory impact, and pre-DBL timing to assess statistical planning stability and compliance risk."
  source: "`clinical_trials_ecm`.`biostatistics`.`sap_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the SAP amendment (e.g., Draft, Approved, Superseded)"
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of SAP amendment (e.g., Major, Minor, Administrative)"
    - name: "pre_dbl_flag"
      expr: pre_dbl_flag
      comment: "Whether the amendment was made before database lock (critical for regulatory credibility)"
    - name: "blinding_impact"
      expr: blinding_impact
      comment: "Impact of the amendment on study blinding"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required for this amendment"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the SAP amendment was approved"
  measures:
    - name: "total_sap_amendments"
      expr: COUNT(1)
      comment: "Total number of SAP amendments, indicating statistical planning stability"
    - name: "pre_dbl_amendments"
      expr: COUNT(CASE WHEN pre_dbl_flag = TRUE THEN 1 END)
      comment: "Number of amendments made before database lock, which are regulatorily acceptable"
    - name: "post_dbl_amendments"
      expr: COUNT(CASE WHEN pre_dbl_flag = FALSE THEN 1 END)
      comment: "Number of amendments made after database lock, which carry high regulatory scrutiny risk"
    - name: "primary_endpoint_changes"
      expr: COUNT(CASE WHEN primary_endpoint_changed = TRUE THEN 1 END)
      comment: "Number of amendments changing the primary endpoint, a critical regulatory concern"
    - name: "sample_size_changes"
      expr: COUNT(CASE WHEN sample_size_changed = TRUE THEN 1 END)
      comment: "Number of amendments changing sample size, indicating study design instability"
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of amendments requiring regulatory notification, indicating compliance burden"
    - name: "distinct_studies_amended"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with SAP amendments"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`biostatistics_estimand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for estimands (ICH E9 R1 framework) tracking intercurrent event strategies, multiplicity management, and regulatory alignment of treatment effect definitions."
  source: "`clinical_trials_ecm`.`biostatistics`.`estimand`"
  dimensions:
    - name: "estimand_type"
      expr: estimand_type
      comment: "Type of estimand (e.g., Treatment Policy, Hypothetical, Composite)"
    - name: "estimand_status"
      expr: estimand_status
      comment: "Current status of the estimand definition"
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of endpoint associated with this estimand (Primary, Secondary, Exploratory)"
    - name: "intercurrent_event_strategy"
      expr: intercurrent_event_strategy
      comment: "Strategy for handling intercurrent events (e.g., Treatment Policy, Hypothetical, Composite)"
    - name: "missing_data_strategy"
      expr: missing_data_strategy
      comment: "Strategy for handling missing data"
    - name: "is_confirmatory"
      expr: is_confirmatory
      comment: "Whether this estimand is part of confirmatory testing"
    - name: "is_primary_endpoint"
      expr: is_primary_endpoint
      comment: "Whether this estimand relates to the primary endpoint"
    - name: "blinding_status"
      expr: blinding_status
      comment: "Blinding status context for the estimand"
  measures:
    - name: "total_estimands"
      expr: COUNT(1)
      comment: "Total number of estimands defined across studies"
    - name: "confirmatory_estimands"
      expr: COUNT(CASE WHEN is_confirmatory = TRUE THEN 1 END)
      comment: "Number of confirmatory estimands, directly tied to regulatory approval decisions"
    - name: "primary_endpoint_estimands"
      expr: COUNT(CASE WHEN is_primary_endpoint = TRUE THEN 1 END)
      comment: "Number of estimands for primary endpoints"
    - name: "avg_alpha_level"
      expr: AVG(CAST(alpha_level AS DOUBLE))
      comment: "Average alpha level allocated to estimands, reflecting type I error control strategy"
    - name: "distinct_studies_with_estimands"
      expr: COUNT(DISTINCT study_id)
      comment: "Number of distinct studies with estimands defined (ICH E9 R1 adoption)"
$$;