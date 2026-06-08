-- Metric views for domain: document | Business: Legal | Version: 1 | Generated on: 2026-05-07 14:29:57

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_legal_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPI layer over the legal_document entity. Tracks document portfolio health, privilege exposure, PII risk, retention posture, and processing completeness across the firm's document management lifecycle."
  source: "`legal_ecm`.`document`.`legal_document`"
  dimensions:
    - name: "document_status"
      expr: document_status
      comment: "Current lifecycle status of the legal document (e.g. Draft, Executed, Archived). Primary grouping for pipeline and backlog analysis."
    - name: "document_category"
      expr: document_category
      comment: "High-level category of the document (e.g. Contract, Pleading, Correspondence). Enables portfolio composition analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification assigned to the document. Used for information governance and access-control reporting."
    - name: "privilege_status"
      expr: privilege_status
      comment: "Privilege designation of the document (e.g. Privileged, Non-Privileged, Redacted). Critical for eDiscovery and litigation risk management."
    - name: "review_status"
      expr: review_status
      comment: "Current review state of the document. Drives workload management and quality-control dashboards."
    - name: "language_code"
      expr: language_code
      comment: "Language of the document. Supports multi-jurisdictional and cross-border matter analysis."
    - name: "dms_system"
      expr: dms_system
      comment: "Source document management system (e.g. iManage, NetDocuments). Enables system-level adoption and migration tracking."
    - name: "created_year_month"
      expr: DATE_TRUNC('MONTH', created_date)
      comment: "Month the document was created. Enables trend analysis of document intake volume over time."
    - name: "executed_year_month"
      expr: DATE_TRUNC('MONTH', executed_date)
      comment: "Month the document was executed. Supports contract execution velocity and pipeline reporting."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Flag indicating whether this record represents the current version of the document. Used to filter active document counts."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the document is subject to a legal hold. Critical for litigation readiness and spoliation risk management."
    - name: "contains_pii"
      expr: contains_pii
      comment: "Indicates whether the document contains personally identifiable information. Drives privacy compliance and GDPR/CCPA reporting."
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of legal document records. Baseline measure for portfolio size and intake volume tracking."
    - name: "current_version_documents"
      expr: COUNT(CASE WHEN is_current_version = TRUE THEN 1 END)
      comment: "Count of documents that are the current active version. Reflects the live document portfolio excluding superseded versions."
    - name: "documents_on_legal_hold"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of documents currently subject to a legal hold. Directly informs litigation readiness and preservation compliance."
    - name: "pii_document_count"
      expr: COUNT(CASE WHEN contains_pii = TRUE THEN 1 END)
      comment: "Count of documents flagged as containing PII. Drives privacy risk exposure reporting and regulatory compliance posture."
    - name: "privileged_document_count"
      expr: COUNT(CASE WHEN privilege_status = 'Privileged' THEN 1 END)
      comment: "Number of documents designated as legally privileged. Key metric for eDiscovery privilege log completeness and challenge risk."
    - name: "ocr_processed_document_count"
      expr: COUNT(CASE WHEN ocr_processed = TRUE THEN 1 END)
      comment: "Count of documents that have been OCR-processed. Measures text extraction coverage for search and NLP readiness."
    - name: "nlp_processed_document_count"
      expr: COUNT(CASE WHEN nlp_processed = TRUE THEN 1 END)
      comment: "Count of documents processed through NLP pipelines. Indicates AI/ML enrichment coverage across the document corpus."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage footprint of all legal documents in bytes. Drives infrastructure capacity planning and DMS cost management."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size per document in bytes. Benchmarks document complexity and informs storage tier decisions."
    - name: "distinct_matters_with_documents"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters that have at least one legal document. Measures document coverage across the active matter portfolio."
    - name: "legal_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents currently under legal hold. Tracks litigation exposure concentration relative to total document volume."
    - name: "pii_exposure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contains_pii = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents containing PII. Quantifies privacy risk surface area for regulatory compliance reporting."
    - name: "ocr_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ocr_processed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents that have been OCR-processed. Measures search and AI readiness of the document corpus."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_review_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over document review assignments. Tracks reviewer throughput, quality, privilege designation rates, TAR model performance, and second-level review escalation — core metrics for eDiscovery project management and cost control."
  source: "`legal_ecm`.`document`.`doc_review_assignment`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review assignment (e.g. Pending, In Progress, Complete). Primary dimension for workload pipeline management."
    - name: "review_decision"
      expr: review_decision
      comment: "Reviewer's responsiveness decision (e.g. Responsive, Non-Responsive, Privileged). Drives production eligibility and privilege log population."
    - name: "review_type"
      expr: review_type
      comment: "Type of review performed (e.g. First-Level, QC, TAR). Enables cost and throughput analysis by review phase."
    - name: "review_priority"
      expr: review_priority
      comment: "Priority tier assigned to the review task. Supports SLA compliance and resource allocation decisions."
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of privilege claimed (e.g. Attorney-Client, Work Product). Informs privilege log composition and challenge risk."
    - name: "confidentiality_designation"
      expr: confidentiality_designation
      comment: "Confidentiality tier applied during review (e.g. Confidential, Highly Confidential). Drives protective order compliance tracking."
    - name: "second_level_review_required_flag"
      expr: second_level_review_required_flag
      comment: "Indicates whether a second-level review was required. Used to measure QC escalation rates and associated cost uplift."
    - name: "assignment_year_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month the review assignment was created. Enables trend analysis of review volume and throughput over time."
    - name: "cal_feedback_flag"
      expr: cal_feedback_flag
      comment: "Indicates whether the document was used as CAL (Continuous Active Learning) training feedback. Tracks TAR model training data contribution."
    - name: "tar_model_round"
      expr: tar_model_round
      comment: "TAR model training round associated with this assignment. Enables model iteration performance comparison."
    - name: "source_system"
      expr: source_system
      comment: "Source system from which the document originated (e.g. Relativity, Nuix). Supports platform-level throughput benchmarking."
  measures:
    - name: "total_review_assignments"
      expr: COUNT(1)
      comment: "Total number of document review assignments. Baseline measure for eDiscovery review volume and project scale."
    - name: "completed_reviews"
      expr: COUNT(CASE WHEN review_status = 'Complete' THEN 1 END)
      comment: "Number of review assignments that have been completed. Measures throughput and progress against review project milestones."
    - name: "privileged_designations"
      expr: COUNT(CASE WHEN review_decision = 'Privileged' THEN 1 END)
      comment: "Count of documents designated as privileged during review. Drives privilege log population and challenge exposure assessment."
    - name: "second_level_review_escalations"
      expr: COUNT(CASE WHEN second_level_review_required_flag = TRUE THEN 1 END)
      comment: "Number of assignments escalated to second-level review. Quantifies QC overhead and first-pass review quality."
    - name: "total_review_duration_minutes"
      expr: SUM(CAST(review_duration_minutes AS DOUBLE))
      comment: "Total reviewer time spent across all assignments in minutes. Core input for eDiscovery cost modelling and billing reconciliation."
    - name: "avg_review_duration_minutes"
      expr: AVG(CAST(review_duration_minutes AS DOUBLE))
      comment: "Average time spent per document review in minutes. Benchmarks reviewer efficiency and informs project timeline forecasting."
    - name: "avg_relevance_score"
      expr: AVG(CAST(relevance_score AS DOUBLE))
      comment: "Average TAR/predictive coding relevance score across reviewed documents. Measures model confidence and corpus responsiveness rate."
    - name: "max_relevance_score"
      expr: MAX(CAST(relevance_score AS DOUBLE))
      comment: "Maximum relevance score in the review population. Used to calibrate TAR model cutoff thresholds."
    - name: "distinct_matters_reviewed"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with active document review assignments. Measures eDiscovery workload spread across the matter portfolio."
    - name: "second_level_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN second_level_review_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of review assignments requiring second-level QC review. Key quality indicator — high rates signal first-pass reviewer inconsistency."
    - name: "privilege_designation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_decision = 'Privileged' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviewed documents designated as privileged. Informs privilege log scope and opposing counsel challenge risk."
    - name: "review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of review assignments completed. Primary SLA and project progress KPI for eDiscovery project managers."
    - name: "cal_training_contribution_count"
      expr: COUNT(CASE WHEN cal_feedback_flag = TRUE THEN 1 END)
      comment: "Number of documents contributed as CAL training feedback. Measures TAR model training data volume and active learning velocity."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_esi_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over ESI (Electronically Stored Information) collections. Tracks collection volume, cost, data source coverage, preservation compliance, and production readiness — essential for eDiscovery project governance and cost management."
  source: "`legal_ecm`.`document`.`esi_collection`"
  dimensions:
    - name: "collection_status"
      expr: collection_status
      comment: "Current status of the ESI collection (e.g. In Progress, Complete, On Hold). Primary dimension for collection pipeline management."
    - name: "collection_type"
      expr: collection_type
      comment: "Type of ESI collection (e.g. Targeted, Broad, Forensic). Enables cost and scope analysis by collection methodology."
    - name: "collection_method"
      expr: collection_method
      comment: "Technical method used to collect ESI (e.g. Remote, On-Site, Cloud API). Supports methodology benchmarking and cost modelling."
    - name: "data_source_type"
      expr: data_source_type
      comment: "Type of data source collected from (e.g. Email, File Share, Cloud Storage). Drives data source coverage and risk analysis."
    - name: "collection_cost_currency"
      expr: collection_cost_currency
      comment: "Currency of the collection cost amount. Required for multi-currency cost normalisation."
    - name: "deduplication_applied"
      expr: deduplication_applied
      comment: "Indicates whether deduplication was applied to the collection. Measures data reduction efficiency and downstream review cost savings."
    - name: "preservation_notice_issued"
      expr: preservation_notice_issued
      comment: "Indicates whether a preservation notice was issued prior to collection. Tracks legal hold compliance and spoliation risk mitigation."
    - name: "production_eligible"
      expr: production_eligible
      comment: "Indicates whether the collection is eligible for production. Drives production readiness pipeline reporting."
    - name: "privilege_review_required"
      expr: privilege_review_required
      comment: "Indicates whether privilege review is required for this collection. Informs review project scoping and resource allocation."
    - name: "collection_start_year_month"
      expr: DATE_TRUNC('MONTH', collection_start_date)
      comment: "Month the ESI collection commenced. Enables trend analysis of collection activity and eDiscovery project intake."
    - name: "collection_tool_name"
      expr: collection_tool_name
      comment: "Name of the forensic collection tool used (e.g. Nuix, Relativity Collect). Supports tool performance and cost benchmarking."
  measures:
    - name: "total_collections"
      expr: COUNT(1)
      comment: "Total number of ESI collection records. Baseline measure for eDiscovery collection activity volume."
    - name: "total_items_collected"
      expr: SUM(CAST(total_items_collected AS DOUBLE))
      comment: "Total number of ESI items collected across all collections. Primary volume metric for eDiscovery project scale and review cost forecasting."
    - name: "total_size_gb"
      expr: SUM(CAST(total_size_gb AS DOUBLE))
      comment: "Total data volume collected in gigabytes. Drives storage cost allocation and processing capacity planning."
    - name: "avg_size_gb_per_collection"
      expr: AVG(CAST(total_size_gb AS DOUBLE))
      comment: "Average data volume per ESI collection in GB. Benchmarks collection scope and informs per-matter cost modelling."
    - name: "total_collection_cost"
      expr: SUM(CAST(collection_cost_amount AS DOUBLE))
      comment: "Total monetary cost of ESI collections. Core financial KPI for eDiscovery budget management and client cost recovery."
    - name: "avg_collection_cost"
      expr: AVG(CAST(collection_cost_amount AS DOUBLE))
      comment: "Average cost per ESI collection. Benchmarks collection efficiency and supports matter-level cost forecasting."
    - name: "total_password_protected_items"
      expr: SUM(CAST(password_protected_items_count AS DOUBLE))
      comment: "Total count of password-protected items encountered during collection. Quantifies decryption workload and associated processing risk."
    - name: "distinct_matters_with_collections"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with ESI collections. Measures eDiscovery activity breadth across the matter portfolio."
    - name: "collections_with_preservation_notice_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN preservation_notice_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collections preceded by a preservation notice. Measures legal hold compliance and spoliation risk mitigation effectiveness."
    - name: "production_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN production_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collections cleared as production-eligible. Tracks eDiscovery pipeline throughput from collection to production readiness."
    - name: "deduplication_applied_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deduplication_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of collections where deduplication was applied. Measures data reduction discipline and downstream review cost efficiency."
    - name: "cost_per_gb"
      expr: ROUND(SUM(CAST(collection_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_size_gb AS DOUBLE)), 0), 2)
      comment: "Average collection cost per gigabyte of ESI collected. Key efficiency ratio for benchmarking collection vendor performance and methodology cost."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over document execution events. Tracks execution completion rates, notarization compliance, witness and seal requirements, counterpart management, and execution method mix — critical for contract operations and regulatory compliance."
  source: "`legal_ecm`.`document`.`doc_execution`"
  dimensions:
    - name: "execution_status"
      expr: execution_status
      comment: "Current status of the document execution (e.g. Pending, Executed, Voided). Primary dimension for execution pipeline management."
    - name: "execution_type"
      expr: execution_type
      comment: "Type of execution event (e.g. Original, Counterpart, Electronic). Enables execution method mix analysis."
    - name: "execution_method"
      expr: execution_method
      comment: "Method used to execute the document (e.g. Wet Ink, Electronic, DocuSign). Tracks digital transformation adoption in contract execution."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Jurisdiction whose law governs the executed document. Enables jurisdictional compliance and risk concentration analysis."
    - name: "execution_language"
      expr: execution_language
      comment: "Language in which the document was executed. Supports multi-jurisdictional execution portfolio analysis."
    - name: "notarization_required_flag"
      expr: notarization_required_flag
      comment: "Indicates whether notarization was required for this execution. Used to track notarization compliance obligations."
    - name: "notarization_completed_flag"
      expr: notarization_completed_flag
      comment: "Indicates whether notarization was completed. Paired with required flag to measure notarization compliance gaps."
    - name: "witness_required_flag"
      expr: witness_required_flag
      comment: "Indicates whether a witness was required for execution. Tracks witness compliance obligations across the execution portfolio."
    - name: "board_resolution_required_flag"
      expr: board_resolution_required_flag
      comment: "Indicates whether a board resolution was required. Tracks corporate governance compliance for executed documents."
    - name: "execution_year_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month the document was executed. Enables trend analysis of execution velocity and contract operations throughput."
    - name: "power_of_attorney_used_flag"
      expr: power_of_attorney_used_flag
      comment: "Indicates whether a power of attorney was used in execution. Tracks POA usage patterns and associated authority risk."
    - name: "compliance_review_completed_flag"
      expr: compliance_review_completed_flag
      comment: "Indicates whether compliance review was completed prior to execution. Measures pre-execution compliance gate adherence."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of document execution records. Baseline measure for contract execution activity volume."
    - name: "executed_documents"
      expr: COUNT(CASE WHEN execution_status = 'Executed' THEN 1 END)
      comment: "Count of fully executed documents. Primary throughput KPI for contract operations and deal closing velocity."
    - name: "notarization_compliance_gap"
      expr: COUNT(CASE WHEN notarization_required_flag = TRUE AND notarization_completed_flag = FALSE THEN 1 END)
      comment: "Number of executions where notarization was required but not completed. Directly flags regulatory and legal validity risk."
    - name: "witness_compliance_gap"
      expr: COUNT(CASE WHEN witness_required_flag = TRUE AND counterpart_indicator = FALSE THEN 1 END)
      comment: "Number of executions where a witness was required but counterpart indicator suggests incomplete witnessing. Flags execution validity risk."
    - name: "board_resolution_compliance_gap"
      expr: COUNT(CASE WHEN board_resolution_required_flag = TRUE AND compliance_review_completed_flag = FALSE THEN 1 END)
      comment: "Executions requiring a board resolution where compliance review was not completed. Tracks corporate governance deficiency exposure."
    - name: "poa_used_executions"
      expr: COUNT(CASE WHEN power_of_attorney_used_flag = TRUE THEN 1 END)
      comment: "Number of executions conducted under a power of attorney. Tracks POA reliance and associated authority delegation risk."
    - name: "seal_applied_executions"
      expr: COUNT(CASE WHEN seal_applied_flag = TRUE THEN 1 END)
      comment: "Count of executions where a corporate seal was applied. Monitors formal execution requirements compliance."
    - name: "distinct_matters_with_executions"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with at least one document execution. Measures execution activity breadth across the matter portfolio."
    - name: "execution_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN execution_status = 'Executed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of execution records that reached fully executed status. Measures contract operations throughput efficiency."
    - name: "notarization_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notarization_required_flag = TRUE AND notarization_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN notarization_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of executions requiring notarization where notarization was completed. Measures notarization compliance rate — failures create legal validity risk."
    - name: "compliance_review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_review_completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of executions where compliance review was completed. Tracks pre-execution compliance gate adherence across the portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_legal_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over legal hold records. Tracks hold issuance, custodian acknowledgment rates, spoliation risk levels, preservation compliance, and hold lifecycle management — essential for litigation readiness and regulatory defensibility."
  source: "`legal_ecm`.`document`.`legal_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the legal hold (e.g. Active, Released, Suspended). Primary dimension for hold portfolio management."
    - name: "spoliation_risk_level"
      expr: spoliation_risk_level
      comment: "Assessed risk level of spoliation (e.g. Low, Medium, High, Critical). Drives escalation and remediation prioritisation."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction under which the legal hold was issued. Enables jurisdictional compliance and regulatory authority analysis."
    - name: "trigger_event"
      expr: trigger_event
      comment: "Event that triggered the legal hold (e.g. Litigation Filed, Regulatory Investigation). Supports hold cause analysis and proactive risk management."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the hold. Informs information governance and access control for sensitive holds."
    - name: "compliance_monitoring_flag"
      expr: compliance_monitoring_flag
      comment: "Indicates whether active compliance monitoring is enabled for this hold. Tracks governance oversight coverage."
    - name: "ediscovery_collection_initiated_flag"
      expr: ediscovery_collection_initiated_flag
      comment: "Indicates whether eDiscovery collection has been initiated under this hold. Measures hold-to-collection conversion and litigation readiness."
    - name: "suspension_of_destruction_flag"
      expr: suspension_of_destruction_flag
      comment: "Indicates whether document destruction has been suspended under this hold. Critical for spoliation prevention compliance."
    - name: "issued_year_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the legal hold was issued. Enables trend analysis of hold issuance volume and litigation activity."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority that triggered or oversees the hold. Supports regulatory investigation portfolio management."
  measures:
    - name: "total_legal_holds"
      expr: COUNT(1)
      comment: "Total number of legal hold records. Baseline measure for litigation and regulatory investigation exposure volume."
    - name: "active_legal_holds"
      expr: COUNT(CASE WHEN hold_status = 'Active' THEN 1 END)
      comment: "Number of currently active legal holds. Primary KPI for live litigation and regulatory exposure management."
    - name: "high_spoliation_risk_holds"
      expr: COUNT(CASE WHEN spoliation_risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of holds with high or critical spoliation risk. Directly informs escalation priorities and remediation resource allocation."
    - name: "holds_without_destruction_suspension"
      expr: COUNT(CASE WHEN hold_status = 'Active' AND suspension_of_destruction_flag = FALSE THEN 1 END)
      comment: "Active holds where document destruction has not been suspended. Flags critical spoliation risk requiring immediate remediation."
    - name: "ediscovery_initiated_holds"
      expr: COUNT(CASE WHEN ediscovery_collection_initiated_flag = TRUE THEN 1 END)
      comment: "Number of holds where eDiscovery collection has been initiated. Measures litigation readiness and hold-to-collection conversion rate."
    - name: "distinct_matters_on_hold"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with at least one active legal hold. Measures litigation exposure breadth across the matter portfolio."
    - name: "high_spoliation_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN spoliation_risk_level IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of legal holds carrying high or critical spoliation risk. Executive-level risk concentration metric for litigation governance."
    - name: "ediscovery_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ediscovery_collection_initiated_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN hold_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active holds that have progressed to eDiscovery collection. Measures litigation readiness pipeline conversion."
    - name: "compliance_monitoring_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_monitoring_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN hold_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active holds with compliance monitoring enabled. Measures governance oversight coverage — gaps indicate unmonitored litigation risk."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over document production records. Tracks production volume, redaction compliance, clawback events, dispute rates, and delivery method mix — core metrics for eDiscovery production management and opposing counsel obligations."
  source: "`legal_ecm`.`document`.`doc_production`"
  dimensions:
    - name: "production_status"
      expr: production_status
      comment: "Current status of the document production (e.g. Pending, Produced, Disputed). Primary dimension for production pipeline management."
    - name: "production_type"
      expr: production_type
      comment: "Type of production (e.g. Initial, Supplemental, Rolling). Enables production phase and obligation tracking."
    - name: "production_format"
      expr: production_format
      comment: "Format in which documents were produced (e.g. TIFF, PDF, Native). Tracks format compliance with production protocols."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the production (e.g. FTP, Physical Media, Secure Portal). Supports delivery compliance and chain-of-custody tracking."
    - name: "confidentiality_designation"
      expr: confidentiality_designation
      comment: "Confidentiality tier applied to the production (e.g. Confidential, AEO). Tracks protective order compliance in productions."
    - name: "redaction_applied"
      expr: redaction_applied
      comment: "Indicates whether redactions were applied to the production. Measures redaction compliance and privilege protection in productions."
    - name: "clawback_invoked"
      expr: clawback_invoked
      comment: "Indicates whether a clawback was invoked for inadvertent privilege disclosure. Tracks privilege protection failures and remediation activity."
    - name: "dispute_raised"
      expr: dispute_raised
      comment: "Indicates whether a dispute was raised regarding this production. Measures production quality and opposing counsel challenge rate."
    - name: "privilege_log_included"
      expr: privilege_log_included
      comment: "Indicates whether a privilege log was included with the production. Tracks privilege log compliance obligations."
    - name: "production_year_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month the production was made. Enables trend analysis of production activity and deadline compliance."
    - name: "acknowledgment_received"
      expr: acknowledgment_received
      comment: "Indicates whether acknowledgment of receipt was received from the receiving party. Tracks delivery confirmation compliance."
  measures:
    - name: "total_productions"
      expr: COUNT(1)
      comment: "Total number of document production records. Baseline measure for eDiscovery production activity volume."
    - name: "clawback_events"
      expr: COUNT(CASE WHEN clawback_invoked = TRUE THEN 1 END)
      comment: "Number of productions where a clawback was invoked. Measures inadvertent privilege disclosure incidents — a key quality and risk metric."
    - name: "disputed_productions"
      expr: COUNT(CASE WHEN dispute_raised = TRUE THEN 1 END)
      comment: "Number of productions where a dispute was raised. Tracks production quality failures and opposing counsel challenge exposure."
    - name: "productions_with_redactions"
      expr: COUNT(CASE WHEN redaction_applied = TRUE THEN 1 END)
      comment: "Count of productions where redactions were applied. Measures redaction compliance and privilege protection activity."
    - name: "productions_without_privilege_log"
      expr: COUNT(CASE WHEN privilege_log_included = FALSE THEN 1 END)
      comment: "Productions where a privilege log was not included. Flags potential privilege log obligation gaps and opposing counsel challenge risk."
    - name: "distinct_matters_with_productions"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with at least one document production. Measures eDiscovery production activity breadth."
    - name: "clawback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clawback_invoked = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of productions resulting in a clawback. Measures inadvertent disclosure rate — a critical quality KPI for eDiscovery operations."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of productions that generated a dispute. Tracks production quality and protocol compliance — high rates signal systemic issues."
    - name: "acknowledgment_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgment_received = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of productions for which delivery acknowledgment was received. Measures delivery confirmation compliance and chain-of-custody integrity."
    - name: "privilege_log_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN privilege_log_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of productions that included a privilege log. Tracks privilege log obligation compliance across the production portfolio."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_privilege_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over privilege log entries. Tracks privilege designation composition, challenge rates, clawback activity, waiver risk, and log completeness — essential for eDiscovery privilege management and litigation risk governance."
  source: "`legal_ecm`.`document`.`privilege_log`"
  dimensions:
    - name: "privilege_type"
      expr: privilege_type
      comment: "Type of privilege claimed (e.g. Attorney-Client, Work Product, Common Interest). Drives privilege composition and challenge risk analysis."
    - name: "lpp_classification"
      expr: lpp_classification
      comment: "Legal professional privilege classification. Enables jurisdiction-specific privilege analysis and cross-border production risk assessment."
    - name: "challenge_status"
      expr: challenge_status
      comment: "Status of any privilege challenge (e.g. Pending, Upheld, Overruled). Tracks privilege challenge outcomes and associated risk."
    - name: "clawback_status"
      expr: clawback_status
      comment: "Status of any clawback request (e.g. Requested, Granted, Denied). Measures inadvertent disclosure remediation outcomes."
    - name: "waiver_status"
      expr: waiver_status
      comment: "Status of any privilege waiver (e.g. Waived, Not Waived). Tracks privilege waiver events and associated risk exposure."
    - name: "production_status"
      expr: production_status
      comment: "Production status of the privileged document (e.g. Withheld, Redacted, Produced). Drives production compliance and log completeness analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the privileged document. Informs information governance and access control."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction relevant to the privilege claim. Enables jurisdictional privilege law compliance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the privilege log entry is currently active. Used to filter live privilege log population."
    - name: "designation_year_month"
      expr: DATE_TRUNC('MONTH', designation_date)
      comment: "Month the privilege was designated. Enables trend analysis of privilege designation activity over time."
    - name: "retention_hold"
      expr: retention_hold
      comment: "Indicates whether a retention hold is applied to this privileged document. Tracks preservation obligations for privileged materials."
  measures:
    - name: "total_privilege_log_entries"
      expr: COUNT(1)
      comment: "Total number of privilege log entries. Baseline measure for privilege log volume and eDiscovery privilege exposure scope."
    - name: "active_privilege_entries"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active privilege log entries. Represents the live privilege claim portfolio subject to challenge."
    - name: "challenged_privilege_entries"
      expr: COUNT(CASE WHEN challenge_status IS NOT NULL AND challenge_status != '' THEN 1 END)
      comment: "Number of privilege entries that have been challenged. Measures privilege challenge exposure and litigation risk from opposing counsel."
    - name: "clawback_requested_entries"
      expr: COUNT(CASE WHEN clawback_requested = TRUE THEN 1 END)
      comment: "Number of privilege log entries where a clawback was requested. Tracks inadvertent disclosure incidents requiring remediation."
    - name: "waived_privilege_entries"
      expr: COUNT(CASE WHEN waiver_status = 'Waived' THEN 1 END)
      comment: "Number of privilege entries where privilege has been waived. Measures privilege waiver events and associated loss of protection."
    - name: "withheld_documents"
      expr: COUNT(CASE WHEN production_status = 'Withheld' THEN 1 END)
      comment: "Number of documents withheld from production on privilege grounds. Core metric for privilege log completeness and production compliance."
    - name: "distinct_matters_with_privilege_entries"
      expr: COUNT(DISTINCT matter_id)
      comment: "Number of distinct matters with privilege log entries. Measures privilege exposure breadth across the matter portfolio."
    - name: "challenge_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN challenge_status IS NOT NULL AND challenge_status != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privilege log entries that have been challenged. Key risk metric — high rates indicate privilege claim quality issues."
    - name: "clawback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clawback_requested = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privilege entries requiring clawback. Measures inadvertent disclosure rate — a critical quality KPI for privilege review."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waiver_status = 'Waived' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of privilege entries where privilege has been waived. Tracks privilege erosion rate and associated litigation risk."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over document version records. Tracks version proliferation, OCR and NLP processing coverage, redaction rates, TAR relevance scoring, legal hold compliance, and storage footprint — supports document quality and governance management."
  source: "`legal_ecm`.`document`.`doc_version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Current status of the document version (e.g. Draft, Final, Superseded). Primary dimension for version lifecycle management."
    - name: "review_status"
      expr: review_status
      comment: "Review state of this document version. Drives review workload and quality-control pipeline reporting."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of this version. Informs information governance and access control."
    - name: "privilege_designation"
      expr: privilege_designation
      comment: "Privilege designation applied to this version. Tracks privilege coverage across the version corpus."
    - name: "file_format"
      expr: file_format
      comment: "File format of the document version (e.g. DOCX, PDF, TIFF). Supports format normalisation and processing pipeline planning."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Indicates whether this is the current active version. Used to filter live document corpus from historical versions."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether this version is subject to a legal hold. Critical for preservation compliance and spoliation risk management."
    - name: "ocr_processed_flag"
      expr: ocr_processed_flag
      comment: "Indicates whether OCR processing has been completed. Measures text extraction coverage for search and NLP readiness."
    - name: "redacted_flag"
      expr: redacted_flag
      comment: "Indicates whether this version has been redacted. Tracks redaction activity and privilege protection coverage."
    - name: "production_flag"
      expr: production_flag
      comment: "Indicates whether this version has been produced in discovery. Tracks production coverage across the version corpus."
    - name: "production_year_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month this version was produced. Enables trend analysis of production activity over time."
    - name: "language_code"
      expr: language_code
      comment: "Language of the document version. Supports multi-lingual corpus analysis and translation workload planning."
  measures:
    - name: "total_document_versions"
      expr: COUNT(1)
      comment: "Total number of document version records. Baseline measure for version corpus size and version proliferation tracking."
    - name: "current_versions"
      expr: COUNT(CASE WHEN is_current_version = TRUE THEN 1 END)
      comment: "Count of current active document versions. Represents the live document corpus excluding superseded versions."
    - name: "versions_on_legal_hold"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of document versions subject to a legal hold. Measures preservation compliance at the version level."
    - name: "ocr_processed_versions"
      expr: COUNT(CASE WHEN ocr_processed_flag = TRUE THEN 1 END)
      comment: "Count of versions that have been OCR-processed. Measures text extraction coverage for search and AI readiness."
    - name: "redacted_versions"
      expr: COUNT(CASE WHEN redacted_flag = TRUE THEN 1 END)
      comment: "Count of versions that have been redacted. Tracks redaction activity volume and privilege protection coverage."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage footprint of all document versions in bytes. Drives DMS storage capacity planning and cost management."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size per document version in bytes. Benchmarks document complexity and informs storage tier decisions."
    - name: "avg_ocr_confidence_score"
      expr: AVG(CAST(ocr_confidence_score AS DOUBLE))
      comment: "Average OCR confidence score across processed versions. Measures OCR quality — low scores indicate documents requiring manual review or re-processing."
    - name: "avg_tar_relevance_score"
      expr: AVG(CAST(tar_relevance_score AS DOUBLE))
      comment: "Average TAR predictive coding relevance score across versions. Measures corpus responsiveness and TAR model performance."
    - name: "ocr_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ocr_processed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of document versions that have been OCR-processed. Measures search and AI readiness of the version corpus."
    - name: "legal_hold_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of document versions under legal hold. Tracks preservation compliance concentration across the version corpus."
    - name: "redaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN redacted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of document versions that have been redacted. Measures redaction activity intensity and privilege protection coverage."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_retention_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over retention schedules. Tracks retention period configuration, compliance coverage, destruction authorisation requirements, cross-border transfer restrictions, and schedule review currency — essential for records management and regulatory compliance."
  source: "`legal_ecm`.`document`.`retention_schedule`"
  dimensions:
    - name: "retention_schedule_status"
      expr: retention_schedule_status
      comment: "Current status of the retention schedule (e.g. Active, Superseded, Under Review). Primary dimension for schedule portfolio management."
    - name: "retention_basis"
      expr: retention_basis
      comment: "Legal or regulatory basis for the retention period (e.g. Statutory, Contractual, Business Need). Drives compliance justification analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the retention requirement (e.g. GDPR, SOX, HIPAA). Enables framework-level compliance coverage analysis."
    - name: "lpp_classification"
      expr: lpp_classification
      comment: "Legal professional privilege classification for retained documents. Informs privilege-aware retention management."
    - name: "matter_type"
      expr: matter_type
      comment: "Type of matter to which the retention schedule applies. Enables matter-type-level retention policy coverage analysis."
    - name: "destruction_authorization_required"
      expr: destruction_authorization_required
      comment: "Indicates whether formal authorisation is required before destruction. Tracks governance controls over document destruction."
    - name: "certificate_of_destruction_required"
      expr: certificate_of_destruction_required
      comment: "Indicates whether a certificate of destruction is required. Measures compliance with formal destruction documentation obligations."
    - name: "cross_border_transfer_restriction"
      expr: cross_border_transfer_restriction
      comment: "Indicates whether cross-border transfer restrictions apply. Tracks data sovereignty and international transfer compliance."
    - name: "legal_hold_exemption"
      expr: legal_hold_exemption
      comment: "Indicates whether this schedule is exempt from legal hold suspension. Critical for understanding preservation override risk."
    - name: "ediscovery_relevance_flag"
      expr: ediscovery_relevance_flag
      comment: "Indicates whether documents under this schedule are relevant to eDiscovery. Drives eDiscovery scope and preservation planning."
    - name: "client_specific_override"
      expr: client_specific_override
      comment: "Indicates whether this schedule is a client-specific override of the standard policy. Tracks bespoke retention arrangements."
  measures:
    - name: "total_retention_schedules"
      expr: COUNT(1)
      comment: "Total number of retention schedule records. Baseline measure for records management policy coverage."
    - name: "active_retention_schedules"
      expr: COUNT(CASE WHEN retention_schedule_status = 'Active' THEN 1 END)
      comment: "Number of currently active retention schedules. Measures live records management policy coverage."
    - name: "schedules_requiring_destruction_auth"
      expr: COUNT(CASE WHEN destruction_authorization_required = TRUE THEN 1 END)
      comment: "Number of schedules requiring formal destruction authorisation. Tracks governance control coverage over document destruction."
    - name: "schedules_with_cross_border_restrictions"
      expr: COUNT(CASE WHEN cross_border_transfer_restriction = TRUE THEN 1 END)
      comment: "Number of schedules with cross-border transfer restrictions. Measures data sovereignty compliance obligations across the records portfolio."
    - name: "avg_minimum_retention_years"
      expr: AVG(CAST(minimum_retention_period_years AS DOUBLE))
      comment: "Average minimum retention period in years across all schedules. Benchmarks retention policy stringency and compliance burden."
    - name: "avg_maximum_retention_years"
      expr: AVG(CAST(maximum_retention_period_years AS DOUBLE))
      comment: "Average maximum retention period in years. Informs storage cost forecasting and long-term records management planning."
    - name: "max_retention_period_years"
      expr: MAX(CAST(maximum_retention_period_years AS DOUBLE))
      comment: "Longest maximum retention period across all schedules. Identifies the most stringent retention obligations driving long-term storage costs."
    - name: "avg_audit_trail_retention_years"
      expr: AVG(CAST(audit_trail_retention_years AS DOUBLE))
      comment: "Average audit trail retention period in years. Measures audit log preservation obligations for regulatory accountability."
    - name: "ediscovery_relevant_schedule_count"
      expr: COUNT(CASE WHEN ediscovery_relevance_flag = TRUE THEN 1 END)
      comment: "Number of retention schedules flagged as eDiscovery-relevant. Informs preservation scope and litigation readiness planning."
    - name: "client_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_specific_override = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retention schedules that are client-specific overrides. Measures bespoke retention arrangement prevalence and associated compliance complexity."
    - name: "legal_hold_exemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_hold_exemption = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of retention schedules exempt from legal hold suspension. Tracks preservation override risk concentration in the records management framework."
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`document_doc_folder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over document folders. Tracks folder portfolio health, security classification, legal hold coverage, encryption and access control adoption, collaboration enablement, and storage footprint — supports information governance and DMS management."
  source: "`legal_ecm`.`document`.`doc_folder`"
  dimensions:
    - name: "folder_status"
      expr: folder_status
      comment: "Current status of the document folder (e.g. Active, Archived, Closed). Primary dimension for folder lifecycle management."
    - name: "folder_type"
      expr: folder_type
      comment: "Type of document folder (e.g. Matter, Client, Template). Enables folder portfolio composition analysis."
    - name: "security_classification"
      expr: security_classification
      comment: "Security classification of the folder (e.g. Public, Internal, Confidential, Restricted). Drives information governance and access control reporting."
    - name: "privilege_designation"
      expr: privilege_designation
      comment: "Privilege designation applied to the folder. Tracks privilege-protected folder coverage."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code associated with the folder. Enables jurisdictional data residency and compliance analysis."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the folder is subject to a legal hold. Critical for preservation compliance and spoliation risk management."
    - name: "ethical_wall_flag"
      expr: ethical_wall_flag
      comment: "Indicates whether an ethical wall is applied to this folder. Tracks conflict-of-interest information barrier compliance."
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Indicates whether encryption is enabled for this folder. Measures data security control adoption across the folder portfolio."
    - name: "external_sharing_allowed"
      expr: external_sharing_allowed
      comment: "Indicates whether external sharing is permitted for this folder. Tracks information security risk from external access permissions."
    - name: "collaboration_enabled"
      expr: collaboration_enabled
      comment: "Indicates whether collaboration features are enabled. Measures collaborative working adoption and associated access risk."
    - name: "dms_source_system"
      expr: dms_source_system
      comment: "Source DMS system for this folder (e.g. iManage, NetDocuments). Supports system migration and adoption tracking."
  measures:
    - name: "total_folders"
      expr: COUNT(1)
      comment: "Total number of document folders. Baseline measure for DMS folder portfolio size."
    - name: "folders_on_legal_hold"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of folders currently subject to a legal hold. Measures preservation compliance coverage at the folder level."
    - name: "folders_with_ethical_wall"
      expr: COUNT(CASE WHEN ethical_wall_flag = TRUE THEN 1 END)
      comment: "Number of folders protected by an ethical wall. Tracks conflict-of-interest information barrier coverage."
    - name: "unencrypted_folders"
      expr: COUNT(CASE WHEN encryption_enabled = FALSE THEN 1 END)
      comment: "Number of folders without encryption enabled. Flags data security risk — unencrypted folders containing sensitive content require remediation."
    - name: "externally_shared_folders"
      expr: COUNT(CASE WHEN external_sharing_allowed = TRUE THEN 1 END)
      comment: "Number of folders where external sharing is permitted. Quantifies information security risk surface from external access."
    - name: "total_storage_bytes"
      expr: SUM(CAST(total_storage_bytes AS DOUBLE))
      comment: "Total storage consumed by all document folders in bytes. Core metric for DMS infrastructure capacity planning and cost management."
    - name: "avg_storage_bytes_per_folder"
      expr: AVG(CAST(total_storage_bytes AS DOUBLE))
      comment: "Average storage per folder in bytes. Benchmarks folder size and informs storage tier allocation decisions."
    - name: "parent_hierarchy_depth_avg"
      expr: AVG(CAST(parent_hierarchy AS DOUBLE))
      comment: "Average folder hierarchy depth. Measures DMS structural complexity — deep hierarchies increase navigation friction and governance risk."
    - name: "encryption_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN encryption_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of folders with encryption enabled. Measures data security control adoption — low rates indicate information security risk."
    - name: "legal_hold_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of folders under legal hold. Tracks preservation compliance concentration across the folder portfolio."
    - name: "external_sharing_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN external_sharing_allowed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of folders with external sharing enabled. Quantifies information security risk exposure from permissive sharing configurations."
$$;