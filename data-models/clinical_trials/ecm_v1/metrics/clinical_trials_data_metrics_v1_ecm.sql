-- Metric views for domain: data | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_discrepancy_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key metrics for data discrepancy query management — tracking query volumes, resolution efficiency, escalation rates, and safety-related query proportions to drive data quality and study timeline decisions."
  source: "`clinical_trials_ecm`.`data`.`discrepancy_query`"
  dimensions:
    - name: "query_status"
      expr: query_status
      comment: "Current status of the discrepancy query (open, answered, closed, cancelled)"
    - name: "query_type"
      expr: query_type
      comment: "Type of query (manual, system-generated, auto-query)"
    - name: "query_category"
      expr: query_category
      comment: "Category classification of the query (data entry error, protocol deviation, missing data, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the query (high, medium, low)"
    - name: "is_safety_related"
      expr: CAST(is_safety_related AS STRING)
      comment: "Whether the query is related to safety data"
    - name: "is_escalated"
      expr: CAST(is_escalated AS STRING)
      comment: "Whether the query has been escalated"
    - name: "is_dbl_blocking"
      expr: CAST(is_dbl_blocking AS STRING)
      comment: "Whether the query is blocking database lock"
    - name: "raised_by_role"
      expr: raised_by_role
      comment: "Role of the user who raised the query (CRA, DM, medical reviewer)"
    - name: "visit_name"
      expr: visit_name
      comment: "Study visit associated with the query"
    - name: "raised_month"
      expr: DATE_TRUNC('month', raised_timestamp)
      comment: "Month when the query was raised for trend analysis"
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total number of discrepancy queries raised — baseline volume indicator for data quality workload"
    - name: "open_query_count"
      expr: COUNT(CASE WHEN query_status = 'open' THEN 1 END)
      comment: "Number of currently open queries requiring resolution — key operational metric for data management teams"
    - name: "dbl_blocking_query_count"
      expr: COUNT(CASE WHEN is_dbl_blocking = TRUE THEN 1 END)
      comment: "Number of queries blocking database lock — critical for study timeline risk assessment"
    - name: "safety_related_query_count"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Number of safety-related queries — regulatory priority metric for patient safety oversight"
    - name: "escalated_query_count"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN 1 END)
      comment: "Number of escalated queries — indicator of site responsiveness issues or systemic data problems"
    - name: "closed_query_count"
      expr: COUNT(CASE WHEN query_status = 'closed' THEN 1 END)
      comment: "Number of closed/resolved queries — measures data cleaning throughput"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_field_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for eCRF field-level data entry quality — tracking ALCOA compliance, SDV status, query attachment rates, and data integrity indicators critical for regulatory inspection readiness."
  source: "`clinical_trials_ecm`.`data`.`field_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the field entry (complete, incomplete, missing)"
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source data verification status of the entry"
    - name: "data_entry_type"
      expr: data_entry_type
      comment: "Type of data entry (initial, correction, derived)"
    - name: "medical_coding_status"
      expr: medical_coding_status
      comment: "Medical coding status for coded fields"
    - name: "is_locked"
      expr: CAST(is_locked AS STRING)
      comment: "Whether the field entry is locked"
    - name: "is_frozen"
      expr: CAST(is_frozen AS STRING)
      comment: "Whether the field entry is frozen"
    - name: "has_open_query"
      expr: CAST(has_open_query AS STRING)
      comment: "Whether the field entry has an associated open query"
    - name: "sdtm_domain"
      expr: sdtm_domain
      comment: "SDTM domain classification for regulatory mapping context"
    - name: "form_name"
      expr: form_name
      comment: "Name of the eCRF form containing this field"
    - name: "entry_month"
      expr: DATE_TRUNC('month', entry_timestamp)
      comment: "Month of data entry for trend analysis"
  measures:
    - name: "total_field_entries"
      expr: COUNT(1)
      comment: "Total number of field entries — baseline data volume metric"
    - name: "alcoa_attributable_count"
      expr: COUNT(CASE WHEN alcoa_attributable = TRUE THEN 1 END)
      comment: "Count of entries meeting ALCOA attributability — regulatory compliance indicator"
    - name: "alcoa_contemporaneous_count"
      expr: COUNT(CASE WHEN alcoa_contemporaneous = TRUE THEN 1 END)
      comment: "Count of entries meeting ALCOA contemporaneousness — timeliness of data capture"
    - name: "alcoa_accurate_count"
      expr: COUNT(CASE WHEN alcoa_accurate = TRUE THEN 1 END)
      comment: "Count of entries meeting ALCOA accuracy — data accuracy compliance"
    - name: "entries_with_open_queries"
      expr: COUNT(CASE WHEN has_open_query = TRUE THEN 1 END)
      comment: "Number of field entries with unresolved queries — data cleaning backlog indicator"
    - name: "locked_entries_count"
      expr: COUNT(CASE WHEN is_locked = TRUE THEN 1 END)
      comment: "Number of locked field entries — database lock readiness indicator"
    - name: "missing_data_count"
      expr: COUNT(CASE WHEN is_missing = TRUE THEN 1 END)
      comment: "Number of entries flagged as missing — data completeness gap metric"
    - name: "sdv_completed_count"
      expr: COUNT(CASE WHEN sdv_status = 'verified' THEN 1 END)
      comment: "Number of entries with completed source data verification — monitoring quality metric"
    - name: "total_entry_value"
      expr: SUM(CAST(entry_value AS DOUBLE))
      comment: "Sum of numeric entry values — useful for lab/vital sign aggregate analysis"
    - name: "avg_entry_value"
      expr: AVG(CAST(entry_value AS DOUBLE))
      comment: "Average numeric entry value — useful for detecting data drift in numeric fields"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_subject_visit_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subject visit-level data completeness and quality metrics — tracking form completion rates, SDV progress, query burden per visit, and protocol adherence for site performance management."
  source: "`clinical_trials_ecm`.`data`.`subject_visit_data`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the visit data form"
    - name: "data_review_status"
      expr: data_review_status
      comment: "Data review status (not reviewed, reviewed, approved)"
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source data verification status at visit level"
    - name: "lock_status"
      expr: lock_status
      comment: "Lock status of the visit data record"
    - name: "visit_name"
      expr: visit_name
      comment: "Name of the study visit"
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (scheduled, unscheduled, early termination)"
    - name: "visit_within_window"
      expr: CAST(visit_within_window AS STRING)
      comment: "Whether the visit occurred within the protocol-defined window"
    - name: "protocol_deviation_flag"
      expr: CAST(protocol_deviation_flag AS STRING)
      comment: "Whether a protocol deviation was flagged for this visit"
    - name: "missing_data_flag"
      expr: CAST(missing_data_flag AS STRING)
      comment: "Whether missing data was flagged"
    - name: "alcoa_compliant"
      expr: CAST(alcoa_compliant AS STRING)
      comment: "Whether the visit data is ALCOA compliant"
    - name: "cdisc_sdtm_domain"
      expr: cdisc_sdtm_domain
      comment: "CDISC SDTM domain classification"
    - name: "visit_month"
      expr: DATE_TRUNC('month', visit_date)
      comment: "Month of the visit for trend analysis"
  measures:
    - name: "total_visit_data_records"
      expr: COUNT(1)
      comment: "Total number of subject visit data records — baseline volume metric"
    - name: "avg_data_completeness_pct"
      expr: AVG(CAST(data_completeness_pct AS DOUBLE))
      comment: "Average data completeness percentage across visit records — key quality KPI for study health"
    - name: "visits_with_protocol_deviations"
      expr: COUNT(CASE WHEN protocol_deviation_flag = TRUE THEN 1 END)
      comment: "Number of visits with protocol deviations — site compliance and training needs indicator"
    - name: "visits_within_window_count"
      expr: COUNT(CASE WHEN visit_within_window = TRUE THEN 1 END)
      comment: "Number of visits conducted within protocol window — protocol adherence metric"
    - name: "alcoa_compliant_count"
      expr: COUNT(CASE WHEN alcoa_compliant = TRUE THEN 1 END)
      comment: "Number of ALCOA-compliant visit records — regulatory inspection readiness metric"
    - name: "visits_with_missing_data"
      expr: COUNT(CASE WHEN missing_data_flag = TRUE THEN 1 END)
      comment: "Number of visits flagged with missing data — data completeness gap indicator"
    - name: "frozen_visit_count"
      expr: COUNT(CASE WHEN freeze_status = TRUE THEN 1 END)
      comment: "Number of frozen visit records — database lock progress indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_coding_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical coding metrics — tracking coding throughput, autocoding effectiveness, approval rates, and serious AE coding prioritization for pharmacovigilance and regulatory submission readiness."
  source: "`clinical_trials_ecm`.`data`.`coding_assignment`"
  dimensions:
    - name: "coding_status"
      expr: coding_status
      comment: "Current status of the coding assignment (pending, coded, approved, rejected)"
    - name: "coding_method"
      expr: coding_method
      comment: "Method used for coding (manual, autocoded, assisted)"
    - name: "coding_dictionary"
      expr: coding_dictionary
      comment: "Dictionary used for coding (MedDRA, WHODrug)"
    - name: "coding_domain"
      expr: coding_domain
      comment: "Coding domain (adverse events, concomitant medications, medical history)"
    - name: "system_organ_class"
      expr: system_organ_class
      comment: "System Organ Class from MedDRA hierarchy"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the coding assignment"
    - name: "is_serious_ae"
      expr: CAST(is_serious_ae AS STRING)
      comment: "Whether the coded term relates to a serious adverse event"
    - name: "dictionary_version"
      expr: dictionary_version
      comment: "Version of the coding dictionary used"
    - name: "visit_name"
      expr: visit_name
      comment: "Study visit associated with the verbatim term"
    - name: "coding_month"
      expr: DATE_TRUNC('month', coding_date)
      comment: "Month of coding for throughput trend analysis"
  measures:
    - name: "total_coding_assignments"
      expr: COUNT(1)
      comment: "Total number of coding assignments — coding workload volume"
    - name: "autocoded_count"
      expr: COUNT(CASE WHEN coding_method = 'autocoded' THEN 1 END)
      comment: "Number of terms successfully autocoded — automation efficiency metric"
    - name: "serious_ae_coding_count"
      expr: COUNT(CASE WHEN is_serious_ae = TRUE THEN 1 END)
      comment: "Number of serious AE coding assignments — safety prioritization metric"
    - name: "approved_coding_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Number of approved coding assignments — coding completion throughput"
    - name: "avg_autocoding_confidence"
      expr: AVG(CAST(autocoding_confidence_score AS DOUBLE))
      comment: "Average autocoding confidence score — algorithm effectiveness indicator"
    - name: "recoded_count"
      expr: COUNT(CASE WHEN prior_assigned_code IS NOT NULL THEN 1 END)
      comment: "Number of terms that required recoding — coding quality and dictionary upgrade impact metric"
    - name: "distinct_preferred_terms"
      expr: COUNT(DISTINCT preferred_term)
      comment: "Number of distinct preferred terms coded — diversity of reported terms indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_sdtm_dataset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SDTM dataset production metrics — tracking dataset readiness for regulatory submission, validation quality (Pinnacle 21), QC status, and data volume for CDISC compliance and submission planning."
  source: "`clinical_trials_ecm`.`data`.`sdtm_dataset`"
  dimensions:
    - name: "dataset_status"
      expr: dataset_status
      comment: "Current status of the SDTM dataset (draft, QC, final, submitted)"
    - name: "dataset_name"
      expr: dataset_name
      comment: "Name of the SDTM dataset (DM, AE, LB, VS, etc.)"
    - name: "domain_class"
      expr: domain_class
      comment: "SDTM domain class (Interventions, Events, Findings, Special Purpose)"
    - name: "sdtm_ig_version"
      expr: sdtm_ig_version
      comment: "SDTM Implementation Guide version used"
    - name: "pinnacle21_validation_status"
      expr: pinnacle21_validation_status
      comment: "Pinnacle 21 validation result status (pass, fail, warnings)"
    - name: "qc_status"
      expr: qc_status
      comment: "Quality control review status"
    - name: "is_submission_ready"
      expr: CAST(is_submission_ready AS STRING)
      comment: "Whether the dataset is ready for regulatory submission"
    - name: "generation_month"
      expr: DATE_TRUNC('month', generation_date)
      comment: "Month of dataset generation for production trend analysis"
  measures:
    - name: "total_datasets"
      expr: COUNT(1)
      comment: "Total number of SDTM datasets — submission package completeness indicator"
    - name: "submission_ready_count"
      expr: COUNT(CASE WHEN is_submission_ready = TRUE THEN 1 END)
      comment: "Number of datasets ready for submission — regulatory readiness metric"
    - name: "total_record_count"
      expr: SUM(CAST(record_count AS DOUBLE))
      comment: "Total records across all SDTM datasets — data volume for submission planning"
    - name: "avg_record_count"
      expr: AVG(CAST(record_count AS DOUBLE))
      comment: "Average records per dataset — dataset sizing metric"
    - name: "total_xpt_file_size_kb"
      expr: SUM(CAST(xpt_file_size_kb AS DOUBLE))
      comment: "Total XPT file size in KB — submission package size for FDA gateway planning"
    - name: "datasets_with_suppqual"
      expr: COUNT(CASE WHEN suppqual_included = TRUE THEN 1 END)
      comment: "Number of datasets with supplemental qualifiers — CDISC compliance complexity indicator"
    - name: "qc_completed_count"
      expr: COUNT(CASE WHEN qc_status = 'completed' THEN 1 END)
      comment: "Number of datasets with completed QC — production pipeline throughput"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_alcoa_audit_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ALCOA+ compliance audit metrics — tracking data integrity principles adherence (Attributable, Legible, Contemporaneous, Original, Accurate) for regulatory inspection readiness and 21 CFR Part 11 compliance."
  source: "`clinical_trials_ecm`.`data`.`alcoa_audit_entry`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of audit action (create, update, delete, sign)"
    - name: "alcoa_overall_status"
      expr: alcoa_overall_status
      comment: "Overall ALCOA compliance status of the audit entry"
    - name: "sdv_status"
      expr: sdv_status
      comment: "Source data verification status"
    - name: "user_role"
      expr: user_role
      comment: "Role of the user performing the audited action"
    - name: "dbl_flag"
      expr: CAST(dbl_flag AS STRING)
      comment: "Whether the entry is relevant to database lock"
    - name: "edc_system_name"
      expr: edc_system_name
      comment: "EDC system where the action was performed"
    - name: "visit_name"
      expr: visit_name
      comment: "Study visit associated with the audit entry"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the audited event for trend analysis"
  measures:
    - name: "total_audit_entries"
      expr: COUNT(1)
      comment: "Total number of ALCOA audit entries — audit trail volume metric"
    - name: "attributable_compliant_count"
      expr: COUNT(CASE WHEN is_attributable = TRUE THEN 1 END)
      comment: "Entries meeting attributability requirement — who performed the action is documented"
    - name: "contemporaneous_compliant_count"
      expr: COUNT(CASE WHEN is_contemporaneous = TRUE THEN 1 END)
      comment: "Entries meeting contemporaneousness — data recorded at time of activity"
    - name: "accurate_compliant_count"
      expr: COUNT(CASE WHEN is_accurate = TRUE THEN 1 END)
      comment: "Entries meeting accuracy requirement — data is correct and error-free"
    - name: "original_compliant_count"
      expr: COUNT(CASE WHEN is_original = TRUE THEN 1 END)
      comment: "Entries meeting originality requirement — first recording of data"
    - name: "legible_compliant_count"
      expr: COUNT(CASE WHEN is_legible = TRUE THEN 1 END)
      comment: "Entries meeting legibility requirement — data is readable and permanent"
    - name: "complete_compliant_count"
      expr: COUNT(CASE WHEN is_complete = TRUE THEN 1 END)
      comment: "Entries meeting completeness requirement — all required data present"
    - name: "fully_alcoa_compliant_count"
      expr: COUNT(CASE WHEN is_attributable = TRUE AND is_legible = TRUE AND is_contemporaneous = TRUE AND is_original = TRUE AND is_accurate = TRUE THEN 1 END)
      comment: "Entries meeting ALL core ALCOA principles — gold standard regulatory compliance metric"
    - name: "avg_data_entry_lag_value_change"
      expr: AVG(CAST(new_value - original_value AS DOUBLE))
      comment: "Average magnitude of value changes in audit trail — data correction impact metric"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_external_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "External data transfer metrics — tracking transfer volumes, success rates, validation outcomes, and file sizes for vendor data integration management and SLA compliance."
  source: "`clinical_trials_ecm`.`data`.`external_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Status of the data transfer (pending, in-progress, completed, failed)"
    - name: "transfer_direction"
      expr: transfer_direction
      comment: "Direction of data transfer (inbound, outbound)"
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (scheduled, ad-hoc, rerun)"
    - name: "source_system"
      expr: source_system
      comment: "Source system of the data transfer"
    - name: "target_system"
      expr: target_system
      comment: "Target system of the data transfer"
    - name: "file_format"
      expr: file_format
      comment: "File format of the transferred data (SAS, CSV, XML)"
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the transferred data"
    - name: "transfer_frequency"
      expr: transfer_frequency
      comment: "Frequency of the transfer (daily, weekly, monthly, ad-hoc)"
    - name: "cdisc_domain"
      expr: cdisc_domain
      comment: "CDISC domain of the transferred data"
    - name: "transfer_month"
      expr: DATE_TRUNC('month', transfer_date)
      comment: "Month of transfer for trend analysis"
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of external data transfers — integration workload volume"
    - name: "successful_transfers"
      expr: COUNT(CASE WHEN transfer_status = 'completed' THEN 1 END)
      comment: "Number of successfully completed transfers — reliability metric"
    - name: "failed_transfers"
      expr: COUNT(CASE WHEN transfer_status = 'failed' THEN 1 END)
      comment: "Number of failed transfers — system integration health indicator"
    - name: "total_file_size_kb"
      expr: SUM(CAST(file_size_kb AS DOUBLE))
      comment: "Total file size transferred in KB — data volume throughput metric"
    - name: "avg_file_size_kb"
      expr: AVG(CAST(file_size_kb AS DOUBLE))
      comment: "Average file size per transfer — transfer sizing metric"
    - name: "acknowledged_transfers"
      expr: COUNT(CASE WHEN acknowledgement_received = TRUE THEN 1 END)
      comment: "Number of transfers with acknowledgement received — end-to-end delivery confirmation"
    - name: "dbl_impacted_transfers"
      expr: COUNT(CASE WHEN dbl_impacted = TRUE THEN 1 END)
      comment: "Number of transfers impacting database lock — critical path transfer identification"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`data_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data reconciliation metrics — tracking discrepancy rates, resolution progress, and reconciliation completeness across systems for data integrity assurance and database lock readiness."
  source: "`clinical_trials_ecm`.`data`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation (planned, in-progress, completed, escalated)"
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation (SAE, lab, IRT, ePRO)"
    - name: "reconciliation_method"
      expr: reconciliation_method
      comment: "Method used for reconciliation (automated, manual, hybrid)"
    - name: "source_system"
      expr: source_system
      comment: "Source system being reconciled"
    - name: "target_system"
      expr: target_system
      comment: "Target system being reconciled against"
    - name: "frequency"
      expr: frequency
      comment: "Frequency of reconciliation (weekly, monthly, ad-hoc)"
    - name: "escalation_required"
      expr: CAST(escalation_required AS STRING)
      comment: "Whether escalation was required for discrepancies"
    - name: "dbl_required"
      expr: CAST(dbl_required AS STRING)
      comment: "Whether reconciliation is required for database lock"
    - name: "reconciliation_month"
      expr: DATE_TRUNC('month', reconciliation_date)
      comment: "Month of reconciliation for trend analysis"
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Total number of reconciliation activities — data integrity workload volume"
    - name: "avg_discrepancy_rate_pct"
      expr: AVG(CAST(discrepancy_rate_pct AS DOUBLE))
      comment: "Average discrepancy rate percentage — cross-system data consistency indicator"
    - name: "escalated_reconciliations"
      expr: COUNT(CASE WHEN escalation_required = TRUE THEN 1 END)
      comment: "Number of reconciliations requiring escalation — systemic data issue indicator"
    - name: "dbl_required_reconciliations"
      expr: COUNT(CASE WHEN dbl_required = TRUE THEN 1 END)
      comment: "Number of reconciliations required for database lock — critical path metric"
    - name: "completed_reconciliations"
      expr: COUNT(CASE WHEN reconciliation_status = 'completed' THEN 1 END)
      comment: "Number of completed reconciliations — progress toward database lock readiness"
$$;