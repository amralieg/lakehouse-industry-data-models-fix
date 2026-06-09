-- Metric views for domain: data | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_discrepancy_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for data discrepancy and query management — tracks query volume, resolution velocity, escalation rates, and safety-related query burden to steer data cleaning efficiency and site performance."
  source: "`clinical_trials_ecm`.`data`.`discrepancy_query`"
  dimensions:
    - name: "query_status"
      expr: query_status
      comment: "Current lifecycle status of the discrepancy query (e.g. Open, Answered, Closed, Cancelled) — primary grouping for workload analysis."
    - name: "query_type"
      expr: query_type
      comment: "Classification of the query type (e.g. Manual, Automatic, SDV) — used to distinguish programmatic vs. manual query burden."
    - name: "query_category"
      expr: query_category
      comment: "Business category of the discrepancy (e.g. Missing Data, Out of Range, Coding) — drives root-cause analysis of data quality issues."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the query — enables triage and escalation prioritisation."
    - name: "raised_by_role"
      expr: raised_by_role
      comment: "Role that raised the query (e.g. DM, CRA, Sponsor) — identifies accountability and workload distribution."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Boolean flag indicating whether the query is linked to a safety event — critical for regulatory risk stratification."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Boolean flag indicating whether the query has been escalated — signals unresolved high-risk data issues."
    - name: "is_dbl_blocking"
      expr: is_dbl_blocking
      comment: "Boolean flag indicating whether the query is blocking database lock — directly impacts study timeline."
    - name: "protocol_version"
      expr: protocol_version
      comment: "Protocol version under which the query was raised — enables version-stratified quality analysis."
    - name: "source_system"
      expr: source_system
      comment: "EDC or source system that generated the query — supports multi-system data quality benchmarking."
    - name: "raised_month"
      expr: DATE_TRUNC('MONTH', raised_timestamp)
      comment: "Month the query was raised — enables trend analysis of query volume over time."
    - name: "closed_month"
      expr: DATE_TRUNC('MONTH', closed_timestamp)
      comment: "Month the query was closed — used to track resolution throughput over time."
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total number of discrepancy queries raised — baseline volume KPI for data cleaning workload assessment."
    - name: "open_queries"
      expr: COUNT(CASE WHEN query_status = 'Open' THEN 1 END)
      comment: "Number of currently open queries — directly measures outstanding data cleaning burden and site responsiveness."
    - name: "safety_related_queries"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Count of queries flagged as safety-related — a critical regulatory risk indicator monitored by medical monitors and sponsors."
    - name: "dbl_blocking_queries"
      expr: COUNT(CASE WHEN is_dbl_blocking = TRUE THEN 1 END)
      comment: "Number of queries blocking database lock — directly impacts study close-out timeline and submission readiness."
    - name: "escalated_queries"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN 1 END)
      comment: "Count of escalated queries — signals chronic unresolved data issues requiring management intervention."
    - name: "cancelled_queries"
      expr: COUNT(CASE WHEN query_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled queries — high cancellation rates may indicate poor query generation quality or over-querying."
    - name: "query_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_escalated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries that required escalation — a compound quality KPI indicating systemic data management failures."
    - name: "safety_query_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proportion of all queries that are safety-related — a regulatory risk ratio monitored at steering committee level."
    - name: "dbl_blocking_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_dbl_blocking = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries blocking database lock — a critical timeline risk KPI for study close-out management."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_coding_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical coding quality and throughput KPIs — tracks autocoding confidence, coding status distribution, primary SOC assignment rates, and serious AE coding burden to govern coding accuracy and regulatory compliance."
  source: "`clinical_trials_ecm`.`data`.`coding_assignment`"
  dimensions:
    - name: "coding_status"
      expr: coding_status
      comment: "Current status of the coding assignment (e.g. Coded, Pending, Rejected) — primary dimension for coding workload management."
    - name: "coding_method"
      expr: coding_method
      comment: "Method used for coding (e.g. Autocoding, Manual) — enables comparison of automated vs. manual coding efficiency."
    - name: "coding_dictionary"
      expr: coding_dictionary
      comment: "Medical coding dictionary used (e.g. MedDRA, WHODrug) — required for regulatory submission traceability."
    - name: "coding_domain"
      expr: coding_domain
      comment: "Clinical domain being coded (e.g. AE, CM, MH) — enables domain-specific coding quality analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the coding assignment — tracks governance sign-off on coded terms."
    - name: "is_primary_soc"
      expr: is_primary_soc
      comment: "Boolean indicating whether the assigned SOC is the primary system organ class — critical for MedDRA hierarchy accuracy."
    - name: "is_serious_ae"
      expr: is_serious_ae
      comment: "Boolean flag for serious adverse event coding — highest-priority coding category for patient safety and regulatory reporting."
    - name: "dbl_included"
      expr: dbl_included
      comment: "Boolean indicating whether this coding record is included in the database lock scope — impacts lock readiness."
    - name: "system_organ_class"
      expr: system_organ_class
      comment: "MedDRA System Organ Class of the coded term — enables safety signal analysis by organ system."
    - name: "dictionary_version"
      expr: dictionary_version
      comment: "Version of the coding dictionary applied — ensures version-consistent regulatory submissions."
    - name: "coding_month"
      expr: DATE_TRUNC('MONTH', coding_timestamp)
      comment: "Month the coding was performed — enables throughput trend analysis over time."
    - name: "source_system"
      expr: source_system
      comment: "Source EDC or data system for the verbatim term — supports multi-system coding quality benchmarking."
  measures:
    - name: "total_coding_assignments"
      expr: COUNT(1)
      comment: "Total number of coding assignments — baseline volume KPI for coding workload and dictionary coverage."
    - name: "pending_coding_assignments"
      expr: COUNT(CASE WHEN coding_status = 'Pending' THEN 1 END)
      comment: "Number of coding assignments still pending — measures outstanding coding backlog impacting database lock readiness."
    - name: "serious_ae_coded_count"
      expr: COUNT(CASE WHEN is_serious_ae = TRUE THEN 1 END)
      comment: "Count of serious adverse event coding assignments — a patient safety KPI requiring priority monitoring and expedited review."
    - name: "autocoded_count"
      expr: COUNT(CASE WHEN coding_method = 'Autocoding' THEN 1 END)
      comment: "Number of terms coded via autocoding — measures automation adoption and efficiency in the coding workflow."
    - name: "approved_coding_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of coding assignments with approved status — measures governance completion rate for regulatory readiness."
    - name: "avg_autocoding_confidence_score"
      expr: AVG(CAST(autocoding_confidence_score AS DOUBLE))
      comment: "Average autocoding confidence score across all assignments — a compound quality KPI; low scores indicate high manual review burden."
    - name: "autocoding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coding_method = 'Autocoding' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terms coded via autocoding — measures automation efficiency; low rates signal manual coding bottlenecks."
    - name: "coding_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of coding assignments that have been approved — a regulatory readiness ratio for database lock planning."
    - name: "serious_ae_coding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_serious_ae = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proportion of all coding assignments that are serious AEs — a safety signal density KPI for medical monitor oversight."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_subject_visit_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject-level data completeness, quality, and SDV KPIs — tracks eCRF completion rates, open query burden, protocol deviation flags, lock status, and visit window compliance to steer data quality and site performance."
  source: "`clinical_trials_ecm`.`data`.`subject_visit_data`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "eCRF completion status for the visit data record — primary dimension for data completeness monitoring."
    - name: "data_review_status"
      expr: data_review_status
      comment: "Data review status (e.g. Reviewed, Pending Review) — tracks DM review progress across visit records."
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source data verification status — a critical GCP compliance dimension for site monitoring oversight."
    - name: "lock_status"
      expr: lock_status
      comment: "Lock status of the visit data record — tracks database lock readiness at the visit level."
    - name: "medical_coding_status"
      expr: medical_coding_status
      comment: "Medical coding status for the visit record — enables coding backlog analysis at the visit level."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g. Screening, Treatment, Follow-up) — enables visit-stratified data quality analysis."
    - name: "visit_name"
      expr: visit_name
      comment: "Name of the clinical visit — enables per-visit data quality benchmarking."
    - name: "alcoa_compliant"
      expr: alcoa_compliant
      comment: "Boolean indicating ALCOA+ compliance of the visit data — a regulatory data integrity KPI."
    - name: "missing_data_flag"
      expr: missing_data_flag
      comment: "Boolean flag indicating presence of missing data in the visit record — drives targeted data cleaning prioritisation."
    - name: "protocol_deviation_flag"
      expr: protocol_deviation_flag
      comment: "Boolean flag indicating a protocol deviation was recorded at this visit — a compliance risk indicator."
    - name: "visit_within_window"
      expr: visit_within_window
      comment: "Boolean indicating whether the visit occurred within the protocol-defined window — a protocol adherence KPI."
    - name: "investigator_signature_status"
      expr: investigator_signature_status
      comment: "Status of investigator e-signature on the visit record — required for regulatory submission readiness."
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the clinical visit — enables longitudinal data quality trend analysis."
    - name: "cdisc_sdtm_domain"
      expr: cdisc_sdtm_domain
      comment: "CDISC SDTM domain associated with the visit data — enables domain-level data quality analysis for submission."
  measures:
    - name: "total_visit_records"
      expr: COUNT(1)
      comment: "Total number of subject visit data records — baseline volume KPI for data collection progress tracking."
    - name: "locked_visit_records"
      expr: COUNT(CASE WHEN lock_status = 'Locked' THEN 1 END)
      comment: "Number of visit records that are locked — measures database lock progress, a critical study close-out KPI."
    - name: "missing_data_records"
      expr: COUNT(CASE WHEN missing_data_flag = TRUE THEN 1 END)
      comment: "Count of visit records with missing data — directly measures data completeness gaps requiring DM intervention."
    - name: "protocol_deviation_records"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of visit records flagged with a protocol deviation — a compliance risk KPI monitored by QA and sponsors."
    - name: "out_of_window_visits"
      expr: COUNT(CASE WHEN visit_within_window = FALSE THEN 1 END)
      comment: "Count of visits occurring outside the protocol-defined window — a protocol adherence KPI impacting data integrity."
    - name: "alcoa_non_compliant_records"
      expr: COUNT(CASE WHEN alcoa_compliant = FALSE THEN 1 END)
      comment: "Number of visit records failing ALCOA+ compliance — a regulatory data integrity risk KPI requiring immediate remediation."
    - name: "avg_data_completeness_pct"
      expr: AVG(CAST(data_completeness_pct AS DOUBLE))
      comment: "Average data completeness percentage across visit records — a compound quality KPI for site and study-level data readiness."
    - name: "sdv_completed_records"
      expr: COUNT(CASE WHEN sdv_status = 'SDV Complete' THEN 1 END)
      comment: "Number of visit records with completed source data verification — a GCP compliance KPI for monitoring oversight."
    - name: "lock_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lock_status = 'Locked' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visit records that are locked — a database lock readiness ratio critical for study close-out planning."
    - name: "missing_data_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN missing_data_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proportion of visit records with missing data — a compound data quality ratio used to benchmark site performance."
    - name: "protocol_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visit records with protocol deviations — a compliance risk ratio monitored at steering committee level."
    - name: "out_of_window_visit_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN visit_within_window = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits occurring outside the protocol window — a protocol adherence ratio impacting data usability for analysis."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_field_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "eCRF field-level data entry quality KPIs — tracks ALCOA+ compliance, SDV completion, open query burden, lock status, and missing data rates at the granular field level to govern data integrity and GCP compliance."
  source: "`clinical_trials_ecm`.`data`.`field_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the field entry (e.g. Entered, Missing, Incomplete) — primary dimension for data entry completeness analysis."
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source data verification status of the field entry — a GCP compliance dimension for monitoring oversight."
    - name: "medical_coding_status"
      expr: medical_coding_status
      comment: "Medical coding status for the field entry — enables coding backlog analysis at the field level."
    - name: "data_entry_type"
      expr: data_entry_type
      comment: "Type of data entry (e.g. Manual, Imported, Derived) — enables quality stratification by entry method."
    - name: "field_data_type"
      expr: field_data_type
      comment: "Data type of the field (e.g. Numeric, Text, Date) — supports type-specific data quality analysis."
    - name: "sdtm_domain"
      expr: sdtm_domain
      comment: "SDTM domain associated with the field entry — enables submission-domain-level data quality analysis."
    - name: "sdtm_variable"
      expr: sdtm_variable
      comment: "SDTM variable mapped to the field — enables variable-level data quality and completeness analysis."
    - name: "is_frozen"
      expr: is_frozen
      comment: "Boolean indicating whether the field entry is frozen — tracks data freeze progress for database lock."
    - name: "is_locked"
      expr: is_locked
      comment: "Boolean indicating whether the field entry is locked — measures lock completeness at the field level."
    - name: "is_missing"
      expr: is_missing
      comment: "Boolean flag for missing field entries — drives targeted data cleaning and missing data management."
    - name: "has_open_query"
      expr: has_open_query
      comment: "Boolean indicating whether the field has an open discrepancy query — measures outstanding data cleaning burden."
    - name: "alcoa_attributable"
      expr: alcoa_attributable
      comment: "Boolean for ALCOA Attributable compliance — a regulatory data integrity dimension."
    - name: "alcoa_original"
      expr: alcoa_original
      comment: "Boolean for ALCOA Original compliance — ensures data has not been improperly altered."
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_timestamp)
      comment: "Month the field entry was recorded — enables longitudinal data entry throughput analysis."
  measures:
    - name: "total_field_entries"
      expr: COUNT(1)
      comment: "Total number of field entries — baseline volume KPI for eCRF data collection progress."
    - name: "missing_field_entries"
      expr: COUNT(CASE WHEN is_missing = TRUE THEN 1 END)
      comment: "Count of missing field entries — a critical data completeness KPI driving data cleaning prioritisation."
    - name: "open_query_field_entries"
      expr: COUNT(CASE WHEN has_open_query = TRUE THEN 1 END)
      comment: "Number of field entries with open discrepancy queries — measures outstanding data cleaning burden at the field level."
    - name: "locked_field_entries"
      expr: COUNT(CASE WHEN is_locked = TRUE THEN 1 END)
      comment: "Count of locked field entries — measures database lock progress at the most granular level."
    - name: "sdv_completed_entries"
      expr: COUNT(CASE WHEN sdv_status = 'SDV Complete' THEN 1 END)
      comment: "Number of field entries with completed SDV — a GCP compliance KPI for monitoring plan execution."
    - name: "alcoa_non_attributable_entries"
      expr: COUNT(CASE WHEN alcoa_attributable = FALSE THEN 1 END)
      comment: "Count of field entries failing ALCOA Attributable requirement — a regulatory data integrity risk KPI."
    - name: "missing_field_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_missing = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of field entries that are missing — a compound data completeness ratio for site and study benchmarking."
    - name: "open_query_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_open_query = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Proportion of field entries with open queries — a compound data quality ratio indicating unresolved data issues."
    - name: "lock_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_locked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of field entries that are locked — a database lock readiness ratio for study close-out management."
    - name: "sdv_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sdv_status = 'SDV Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of field entries with completed SDV — a GCP compliance ratio monitored by clinical operations leadership."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_sdtm_dataset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDTM submission dataset quality and readiness KPIs — tracks validation error rates, QC completion, submission readiness, and dataset size metrics to govern regulatory submission package quality."
  source: "`clinical_trials_ecm`.`data`.`sdtm_dataset`"
  dimensions:
    - name: "dataset_status"
      expr: dataset_status
      comment: "Current status of the SDTM dataset (e.g. In Progress, QC Complete, Submitted) — primary dimension for submission readiness tracking."
    - name: "qc_status"
      expr: qc_status
      comment: "QC review status of the dataset — tracks quality control completion for regulatory submission."
    - name: "pinnacle21_validation_status"
      expr: pinnacle21_validation_status
      comment: "Pinnacle21 validation status — the industry-standard conformance check result for FDA/EMA submission packages."
    - name: "domain_class"
      expr: domain_class
      comment: "SDTM domain class (e.g. Events, Findings, Interventions) — enables class-level submission quality analysis."
    - name: "sdtm_ig_version"
      expr: sdtm_ig_version
      comment: "SDTM Implementation Guide version — ensures version-consistent regulatory submissions."
    - name: "is_submission_ready"
      expr: is_submission_ready
      comment: "Boolean indicating whether the dataset is ready for regulatory submission — the ultimate submission readiness flag."
    - name: "is_split_dataset"
      expr: is_split_dataset
      comment: "Boolean indicating whether the dataset is split — relevant for large dataset handling in submissions."
    - name: "suppqual_included"
      expr: suppqual_included
      comment: "Boolean indicating whether supplemental qualifiers are included — impacts SDTM package completeness."
    - name: "source_system"
      expr: source_system
      comment: "Source system from which the SDTM dataset was generated — enables multi-system submission quality benchmarking."
    - name: "generation_month"
      expr: DATE_TRUNC('MONTH', generation_date)
      comment: "Month the dataset was generated — enables submission timeline and throughput trend analysis."
    - name: "dataset_name"
      expr: dataset_name
      comment: "Name of the SDTM dataset (e.g. AE, CM, LB) — enables per-domain submission quality analysis."
  measures:
    - name: "total_datasets"
      expr: COUNT(1)
      comment: "Total number of SDTM datasets — baseline volume KPI for submission package completeness."
    - name: "submission_ready_datasets"
      expr: COUNT(CASE WHEN is_submission_ready = TRUE THEN 1 END)
      comment: "Number of datasets flagged as submission-ready — a critical regulatory milestone KPI for submission planning."
    - name: "qc_complete_datasets"
      expr: COUNT(CASE WHEN qc_status = 'Complete' THEN 1 END)
      comment: "Count of datasets with completed QC — measures quality assurance throughput for submission readiness."
    - name: "total_subject_records"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Total number of subject records across all SDTM datasets — measures data volume in the submission package."
    - name: "avg_pinnacle21_errors"
      expr: AVG(CAST(pinnacle21_error_count AS DOUBLE))
      comment: "Average number of Pinnacle21 validation errors per dataset — a compound submission quality KPI; high values risk FDA rejection."
    - name: "total_xpt_file_size_kb"
      expr: SUM(CAST(xpt_file_size_kb AS DOUBLE))
      comment: "Total XPT file size in kilobytes across all datasets — a submission package size KPI relevant for FDA electronic submission gateway limits."
    - name: "submission_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_submission_ready = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SDTM datasets that are submission-ready — a compound regulatory readiness ratio for executive reporting."
    - name: "pinnacle21_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pinnacle21_validation_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of datasets passing Pinnacle21 validation — a compound submission quality ratio; low rates signal regulatory submission risk."
    - name: "qc_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qc_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SDTM datasets with completed QC — a submission readiness ratio monitored by data management leadership."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data reconciliation quality and completeness KPIs — tracks discrepancy rates, resolution progress, escalation burden, and signoff status across external data sources to govern cross-system data integrity."
  source: "`clinical_trials_ecm`.`data`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation activity (e.g. In Progress, Complete, Overdue) — primary dimension for reconciliation workload management."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (e.g. Lab, IRT, Safety) — enables type-stratified discrepancy analysis."
    - name: "reconciliation_scope"
      expr: reconciliation_scope
      comment: "Scope of the reconciliation activity — defines the data boundary being reconciled."
    - name: "reconciliation_method"
      expr: reconciliation_method
      comment: "Method used for reconciliation (e.g. Manual, Automated) — enables efficiency comparison across reconciliation approaches."
    - name: "signoff_status"
      expr: signoff_status
      comment: "Sign-off status of the reconciliation — tracks governance approval completion for regulatory compliance."
    - name: "escalation_required"
      expr: escalation_required
      comment: "Boolean indicating whether escalation is required — signals high-risk reconciliation issues needing management attention."
    - name: "dbl_required"
      expr: dbl_required
      comment: "Boolean indicating whether this reconciliation is required for database lock — directly impacts study close-out timeline."
    - name: "source_system"
      expr: source_system
      comment: "Source system being reconciled — enables per-system data quality benchmarking."
    - name: "target_system"
      expr: target_system
      comment: "Target system in the reconciliation — identifies the receiving system for cross-system data integrity analysis."
    - name: "frequency"
      expr: frequency
      comment: "Frequency of the reconciliation activity (e.g. Weekly, Monthly) — enables scheduling and compliance monitoring."
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', reconciliation_date)
      comment: "Month the reconciliation was performed — enables trend analysis of reconciliation throughput."
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of reconciliation activities — baseline volume KPI for cross-system data integrity governance."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of reconciliations requiring escalation — signals systemic cross-system data integrity failures needing management intervention."
    - name: "dbl_blocking_reconciliations"
      expr: COUNT(CASE WHEN dbl_required = TRUE AND reconciliation_status != 'Complete' THEN 1 END)
      comment: "Count of incomplete reconciliations required for database lock — a critical study close-out risk KPI."
    - name: "avg_discrepancy_rate_pct"
      expr: AVG(CAST(discrepancy_rate_pct AS DOUBLE))
      comment: "Average discrepancy rate percentage across reconciliation activities — a compound cross-system data quality KPI for executive reporting."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations requiring escalation — a compound risk ratio indicating systemic data integrity issues."
    - name: "reconciliation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliation activities completed — a governance readiness ratio for database lock and submission planning."
    - name: "signoff_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signoff_status = 'Signed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations with completed sign-off — a regulatory compliance ratio for data governance oversight."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_edc_study_build`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDC study build quality and delivery KPIs — tracks UAT pass rates, build approval status, CDISC compliance, and go-live readiness to govern study setup quality and timeline adherence."
  source: "`clinical_trials_ecm`.`data`.`edc_study_build`"
  dimensions:
    - name: "build_status"
      expr: build_status
      comment: "Current status of the EDC study build (e.g. In Development, UAT, Approved, Live) — primary dimension for build lifecycle management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the EDC build — tracks governance sign-off required before go-live."
    - name: "build_type"
      expr: build_type
      comment: "Type of build (e.g. Initial, Amendment, Patch) — enables build complexity and change management analysis."
    - name: "build_environment"
      expr: build_environment
      comment: "Environment of the build (e.g. Development, UAT, Production) — tracks build progression through environments."
    - name: "uat_passed"
      expr: uat_passed
      comment: "Boolean indicating whether UAT was passed — a critical quality gate KPI for EDC go-live readiness."
    - name: "part11_compliant"
      expr: part11_compliant
      comment: "Boolean indicating 21 CFR Part 11 compliance — a mandatory regulatory compliance dimension for EDC systems."
    - name: "randomization_integrated"
      expr: randomization_integrated
      comment: "Boolean indicating IRT/randomization integration — tracks system integration completeness for study readiness."
    - name: "lab_integration_enabled"
      expr: lab_integration_enabled
      comment: "Boolean indicating lab data integration — tracks external data feed readiness for the EDC build."
    - name: "econsent_integrated"
      expr: econsent_integrated
      comment: "Boolean indicating eConsent integration — tracks digital consent system readiness."
    - name: "sponsor_approval_required"
      expr: sponsor_approval_required
      comment: "Boolean indicating whether sponsor approval is required — tracks governance requirements for build deployment."
    - name: "build_start_month"
      expr: DATE_TRUNC('MONTH', build_start_date)
      comment: "Month the build was started — enables build cycle time trend analysis."
    - name: "go_live_month"
      expr: DATE_TRUNC('MONTH', go_live_date)
      comment: "Month the build went live — enables study activation timeline analysis."
  measures:
    - name: "total_builds"
      expr: COUNT(1)
      comment: "Total number of EDC study builds — baseline volume KPI for study setup activity."
    - name: "approved_builds"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved EDC builds — measures governance completion rate for study activation readiness."
    - name: "uat_passed_builds"
      expr: COUNT(CASE WHEN uat_passed = TRUE THEN 1 END)
      comment: "Number of builds that passed UAT — a quality gate KPI for EDC deployment readiness."
    - name: "part11_non_compliant_builds"
      expr: COUNT(CASE WHEN part11_compliant = FALSE THEN 1 END)
      comment: "Count of builds not meeting 21 CFR Part 11 compliance — a critical regulatory risk KPI requiring immediate remediation."
    - name: "avg_uat_defect_count"
      expr: AVG(CAST(uat_defect_count AS DOUBLE))
      comment: "Average number of UAT defects per build — a compound build quality KPI; high values indicate poor build quality and rework risk."
    - name: "avg_edit_check_count"
      expr: AVG(CAST(edit_check_count AS DOUBLE))
      comment: "Average number of edit checks per build — measures validation rule coverage and build complexity."
    - name: "uat_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN uat_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EDC builds passing UAT — a compound quality ratio for build delivery performance benchmarking."
    - name: "part11_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN part11_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds meeting 21 CFR Part 11 compliance — a regulatory compliance ratio monitored by QA leadership."
    - name: "build_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EDC builds that have received approval — a governance readiness ratio for study activation planning."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_external_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "External data transfer reliability and compliance KPIs — tracks transfer success rates, validation failures, discrepancy volumes, and regulatory submission relevance to govern external data integration quality."
  source: "`clinical_trials_ecm`.`data`.`external_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the external data transfer (e.g. Success, Failed, Pending) — primary dimension for transfer reliability monitoring."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of external transfer (e.g. Lab, IRT, Safety, PK) — enables type-stratified transfer quality analysis."
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of the transfer (e.g. Inbound, Outbound) — distinguishes data receipt from data delivery."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the transferred data — tracks data conformance upon receipt."
    - name: "file_format"
      expr: file_format
      comment: "File format of the transfer (e.g. SAS XPT, CSV, XML) — enables format-specific transfer quality analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system of the external transfer — enables per-vendor/system transfer reliability benchmarking."
    - name: "target_system"
      expr: target_system
      comment: "Target system receiving the transfer — identifies the destination for cross-system data flow analysis."
    - name: "acknowledgement_received"
      expr: acknowledgement_received
      comment: "Boolean indicating whether transfer acknowledgement was received — a data receipt confirmation KPI."
    - name: "regulatory_submission_relevant"
      expr: regulatory_submission_relevant
      comment: "Boolean indicating regulatory submission relevance — prioritises monitoring of submission-critical data transfers."
    - name: "dbl_impacted"
      expr: dbl_impacted
      comment: "Boolean indicating whether the transfer impacts database lock — tracks external data readiness for study close-out."
    - name: "transfer_frequency"
      expr: transfer_frequency
      comment: "Frequency of the transfer schedule (e.g. Daily, Weekly) — enables scheduling compliance monitoring."
    - name: "transfer_month"
      expr: DATE_TRUNC('MONTH', transfer_timestamp)
      comment: "Month the transfer occurred — enables longitudinal transfer volume and reliability trend analysis."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of external data transfers — baseline volume KPI for external data integration activity."
    - name: "failed_transfers"
      expr: COUNT(CASE WHEN transfer_status = 'Failed' THEN 1 END)
      comment: "Number of failed external data transfers — a critical data integration reliability KPI requiring immediate investigation."
    - name: "submission_relevant_transfers"
      expr: COUNT(CASE WHEN regulatory_submission_relevant = TRUE THEN 1 END)
      comment: "Count of transfers relevant to regulatory submission — prioritises monitoring of submission-critical data flows."
    - name: "dbl_impacted_transfers"
      expr: COUNT(CASE WHEN dbl_impacted = TRUE THEN 1 END)
      comment: "Number of transfers impacting database lock — measures external data readiness for study close-out."
    - name: "total_file_size_kb"
      expr: SUM(CAST(file_size_kb AS DOUBLE))
      comment: "Total file size in kilobytes across all transfers — a data volume KPI for infrastructure and bandwidth planning."
    - name: "transfer_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transfer_status = 'Success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of external transfers completing successfully — a compound reliability ratio for vendor and system performance management."
    - name: "validation_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers passing data validation — a compound data quality ratio for external data integration governance."
    - name: "acknowledgement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgement_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers with received acknowledgements — a data receipt confirmation ratio for transfer completeness governance."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_validation_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Validation rule governance and coverage KPIs — tracks rule activation rates, CDISC compliance, UAT completion, and query generation coverage to govern edit check quality and regulatory data validation standards."
  source: "`clinical_trials_ecm`.`data`.`validation_rule`"
  dimensions:
    - name: "rule_status"
      expr: rule_status
      comment: "Current status of the validation rule (e.g. Active, Inactive, Draft) — primary dimension for rule lifecycle management."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of validation rule (e.g. Range Check, Consistency, Completeness) — enables type-stratified rule quality analysis."
    - name: "rule_category"
      expr: rule_category
      comment: "Business category of the rule — enables category-level coverage analysis for data quality governance."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the rule (e.g. Error, Warning, Info) — enables risk-stratified rule management."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Boolean indicating whether the rule is mandatory — distinguishes critical from optional validation checks."
    - name: "is_cdisc_compliant"
      expr: is_cdisc_compliant
      comment: "Boolean indicating CDISC compliance of the rule — a regulatory standards adherence dimension."
    - name: "generates_query"
      expr: generates_query
      comment: "Boolean indicating whether the rule auto-generates a discrepancy query — measures automated query generation coverage."
    - name: "uat_status"
      expr: uat_status
      comment: "UAT status of the validation rule — tracks quality assurance completion for rule deployment."
    - name: "cdisc_domain"
      expr: cdisc_domain
      comment: "CDISC domain the rule applies to — enables domain-level validation coverage analysis."
    - name: "scope"
      expr: scope
      comment: "Scope of the validation rule (e.g. Field, Form, Cross-Form) — enables scope-stratified rule complexity analysis."
    - name: "applies_to_all_sites"
      expr: applies_to_all_sites
      comment: "Boolean indicating whether the rule applies globally to all sites — tracks rule universality vs. site-specific exceptions."
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month the rule was activated — enables rule deployment timeline analysis."
  measures:
    - name: "total_validation_rules"
      expr: COUNT(1)
      comment: "Total number of validation rules — baseline volume KPI for edit check coverage assessment."
    - name: "active_rules"
      expr: COUNT(CASE WHEN rule_status = 'Active' THEN 1 END)
      comment: "Number of currently active validation rules — measures live edit check coverage in the EDC system."
    - name: "query_generating_rules"
      expr: COUNT(CASE WHEN generates_query = TRUE THEN 1 END)
      comment: "Count of rules configured to auto-generate queries — measures automated data cleaning coverage."
    - name: "cdisc_non_compliant_rules"
      expr: COUNT(CASE WHEN is_cdisc_compliant = FALSE THEN 1 END)
      comment: "Number of validation rules not meeting CDISC compliance standards — a regulatory risk KPI requiring remediation before submission."
    - name: "uat_incomplete_rules"
      expr: COUNT(CASE WHEN uat_status != 'Complete' THEN 1 END)
      comment: "Count of rules with incomplete UAT — measures validation rule deployment risk and quality gate gaps."
    - name: "rule_activation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rule_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of validation rules that are active — a compound edit check coverage ratio for data quality governance."
    - name: "cdisc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cdisc_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of validation rules meeting CDISC compliance — a regulatory standards adherence ratio for submission readiness."
    - name: "query_generation_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN generates_query = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rules configured to auto-generate queries — measures automated data cleaning coverage as a compound efficiency KPI."
    - name: "uat_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN uat_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of validation rules with completed UAT — a quality gate completion ratio for rule deployment governance."
$$;