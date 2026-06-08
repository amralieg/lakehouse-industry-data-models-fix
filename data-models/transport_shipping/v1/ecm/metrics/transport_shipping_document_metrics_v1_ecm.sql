-- Metric views for domain: document | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_compliance_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance check metrics tracking document validation outcomes, pass/fail rates, and SLA performance for regulatory and operational compliance monitoring."
  source: "`transport_shipping_ecm`.`document`.`compliance_check`"
  dimensions:
    - name: "check_type"
      expr: check_type
      comment: "Type of compliance check performed (e.g., regulatory, format, content validation)"
    - name: "check_outcome"
      expr: check_outcome
      comment: "Result of the compliance check (pass, fail, warning)"
    - name: "check_status"
      expr: check_status
      comment: "Current processing status of the compliance check"
    - name: "check_method"
      expr: check_method
      comment: "Method used to perform the check (automated, manual, hybrid)"
    - name: "checker_type"
      expr: checker_type
      comment: "Whether the check was performed by system or human"
    - name: "document_type"
      expr: document_type
      comment: "Type of document being checked for compliance"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body whose rules are being validated against"
    - name: "error_severity"
      expr: error_severity
      comment: "Severity level of compliance errors found"
    - name: "check_priority"
      expr: check_priority
      comment: "Priority level assigned to the compliance check"
    - name: "check_execution_month"
      expr: DATE_TRUNC('month', check_execution_timestamp)
      comment: "Month when the compliance check was executed"
  measures:
    - name: "total_compliance_checks"
      expr: COUNT(1)
      comment: "Total number of compliance checks performed"
    - name: "failed_checks"
      expr: SUM(CASE WHEN check_outcome = 'fail' THEN 1 ELSE 0 END)
      comment: "Number of compliance checks that resulted in failure"
    - name: "passed_checks"
      expr: SUM(CASE WHEN check_outcome = 'pass' THEN 1 ELSE 0 END)
      comment: "Number of compliance checks that passed successfully"
    - name: "compliance_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN check_outcome = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance checks that passed — key quality indicator for document operations"
    - name: "remediation_required_count"
      expr: SUM(CASE WHEN remediation_required_flag = true THEN 1 ELSE 0 END)
      comment: "Number of checks requiring remediation action — indicates operational burden"
    - name: "approval_required_count"
      expr: SUM(CASE WHEN approval_required_flag = true THEN 1 ELSE 0 END)
      comment: "Number of checks requiring manual approval — indicates process bottleneck potential"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document exception metrics tracking quality issues, resolution performance, and financial impact of document discrepancies across the shipping document lifecycle."
  source: "`transport_shipping_ecm`.`document`.`document_exception`"
  dimensions:
    - name: "exception_type"
      expr: exception_type
      comment: "Category of document exception (missing, incorrect, expired, etc.)"
    - name: "exception_status"
      expr: exception_status
      comment: "Current status of the exception (open, in-progress, resolved, escalated)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the exception"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for trend analysis and prevention"
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for the exception (carrier, shipper, broker, etc.)"
    - name: "detection_point"
      expr: detection_point
      comment: "Stage in the process where the exception was detected"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the exception"
    - name: "financial_impact_currency"
      expr: financial_impact_currency
      comment: "Currency of the financial impact amount"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month when the exception was detected"
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of document exceptions raised"
    - name: "open_exceptions"
      expr: SUM(CASE WHEN exception_status = 'open' THEN 1 ELSE 0 END)
      comment: "Number of currently unresolved exceptions requiring attention"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of document exceptions in local currency"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Number of exceptions that breached SLA — indicates service quality degradation"
    - name: "escalated_exception_count"
      expr: SUM(CASE WHEN escalation_required_flag = true THEN 1 ELSE 0 END)
      comment: "Number of exceptions requiring escalation — indicates systemic issues"
    - name: "regulatory_impact_count"
      expr: SUM(CASE WHEN regulatory_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Number of exceptions with regulatory implications — critical risk indicator"
    - name: "avg_financial_impact_per_exception"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per exception — helps prioritize prevention efforts"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required_flag = true THEN 1 ELSE 0 END)
      comment: "Number of exceptions requiring corrective action"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document amendment metrics tracking change volume, financial impact, and processing efficiency for transport document modifications."
  source: "`transport_shipping_ecm`.`document`.`amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (correction, addition, deletion, modification)"
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current processing status of the amendment"
    - name: "document_type"
      expr: document_type
      comment: "Type of document being amended"
    - name: "priority"
      expr: priority
      comment: "Priority level of the amendment request"
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the amendment"
    - name: "requesting_party_role"
      expr: requesting_party_role
      comment: "Role of the party requesting the amendment (shipper, carrier, broker)"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority involved if amendment has regulatory implications"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month when the amendment was requested"
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of document amendments processed"
    - name: "amendments_with_financial_impact"
      expr: SUM(CASE WHEN financial_impact_flag = true THEN 1 ELSE 0 END)
      comment: "Number of amendments with financial consequences"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all amendments in local currency"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per amendment — indicates cost of document errors"
    - name: "regulatory_filing_required_count"
      expr: SUM(CASE WHEN regulatory_filing_required = true THEN 1 ELSE 0 END)
      comment: "Number of amendments requiring regulatory filing — compliance workload indicator"
    - name: "pending_amendments"
      expr: SUM(CASE WHEN amendment_status = 'pending' THEN 1 ELSE 0 END)
      comment: "Number of amendments awaiting processing — backlog indicator"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document package completeness and readiness metrics tracking how well shipment documentation is assembled for customs clearance and regulatory submission."
  source: "`transport_shipping_ecm`.`document`.`document_package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of document package (export, import, transit, etc.)"
    - name: "package_status"
      expr: package_status
      comment: "Current status of the document package"
    - name: "completeness_status"
      expr: completeness_status
      comment: "Whether the package has all required documents"
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Status of compliance review for the package"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the shipment"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the shipment"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm governing the shipment documentation requirements"
    - name: "source_system"
      expr: source_system
      comment: "System that originated the document package"
    - name: "creation_month"
      expr: DATE_TRUNC('month', creation_date)
      comment: "Month when the document package was created"
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of document packages created"
    - name: "submission_ready_packages"
      expr: SUM(CASE WHEN submission_ready_flag = true THEN 1 ELSE 0 END)
      comment: "Number of packages ready for regulatory submission"
    - name: "submission_readiness_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_ready_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages ready for submission — operational readiness KPI"
    - name: "compliance_review_required_count"
      expr: SUM(CASE WHEN compliance_review_required_flag = true THEN 1 ELSE 0 END)
      comment: "Number of packages requiring compliance review"
    - name: "incomplete_packages"
      expr: SUM(CASE WHEN completeness_status != 'complete' THEN 1 ELSE 0 END)
      comment: "Number of packages with missing documents — risk of shipment delays"
    - name: "archived_packages"
      expr: SUM(CASE WHEN archive_flag = true THEN 1 ELSE 0 END)
      comment: "Number of packages moved to archive storage"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document request metrics tracking demand patterns, fulfillment performance, and SLA compliance for document services."
  source: "`transport_shipping_ecm`.`document`.`request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of document request (original, copy, certified copy, etc.)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request"
    - name: "requested_document_type"
      expr: requested_document_type
      comment: "Type of document being requested"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request"
    - name: "requesting_party_type"
      expr: requesting_party_type
      comment: "Type of party making the request (customer, partner, regulatory)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the document will be delivered (digital, physical, both)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the request was submitted"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for chargeable document requests"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month when the request was submitted"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of document requests received"
    - name: "sla_breached_requests"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Number of requests that breached SLA targets — service quality indicator"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = false THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests fulfilled within SLA — key service performance metric"
    - name: "total_charge_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from chargeable document requests"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across requests — indicates service commitment level"
    - name: "regulatory_requests"
      expr: SUM(CASE WHEN regulatory_requirement_flag = true THEN 1 ELSE 0 END)
      comment: "Number of requests driven by regulatory requirements — compliance demand indicator"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_workflow_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workflow task metrics tracking document approval and processing efficiency, SLA performance, and bottleneck identification in document workflows."
  source: "`transport_shipping_ecm`.`document`.`workflow_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of workflow task (review, approve, sign, verify)"
    - name: "task_status"
      expr: task_status
      comment: "Current status of the workflow task"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the task"
    - name: "outcome_decision"
      expr: outcome_decision
      comment: "Decision outcome of the task (approved, rejected, returned)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level if task has been escalated"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification required for the task"
    - name: "assigned_month"
      expr: DATE_TRUNC('month', assigned_timestamp)
      comment: "Month when the task was assigned"
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total number of workflow tasks created"
    - name: "sla_breached_tasks"
      expr: SUM(CASE WHEN sla_breach_flag = true THEN 1 ELSE 0 END)
      comment: "Number of tasks that breached their SLA — indicates process bottlenecks"
    - name: "task_sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = false THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks completed within SLA — workflow efficiency KPI"
    - name: "avg_sla_elapsed_hours"
      expr: AVG(CAST(sla_elapsed_hours AS DOUBLE))
      comment: "Average hours elapsed on tasks — indicates processing speed"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours — baseline for performance comparison"
    - name: "delegated_tasks"
      expr: SUM(CASE WHEN delegation_allowed_flag = true AND delegation_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of tasks that were delegated — indicates workload distribution patterns"
    - name: "digital_signature_required_tasks"
      expr: SUM(CASE WHEN digital_signature_required_flag = true THEN 1 ELSE 0 END)
      comment: "Number of tasks requiring digital signature — indicates high-value document processing volume"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document issuance metrics tracking document production volume, delivery performance, and transmission success rates across channels."
  source: "`transport_shipping_ecm`.`document`.`issuance`"
  dimensions:
    - name: "issuance_status"
      expr: issuance_status
      comment: "Current status of the document issuance"
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used for document delivery (email, EDI, portal, physical)"
    - name: "file_format"
      expr: file_format
      comment: "Format of the issued document (PDF, XML, EDI, etc.)"
    - name: "transmission_status"
      expr: transmission_status
      comment: "Status of document transmission to recipient"
    - name: "purpose"
      expr: purpose
      comment: "Purpose of the document issuance"
    - name: "recipient_party_type"
      expr: recipient_party_type
      comment: "Type of party receiving the document"
    - name: "language_code"
      expr: language_code
      comment: "Language of the issued document"
    - name: "issuance_month"
      expr: DATE_TRUNC('month', issuance_timestamp)
      comment: "Month when the document was issued"
  measures:
    - name: "total_issuances"
      expr: COUNT(1)
      comment: "Total number of document issuances"
    - name: "successful_transmissions"
      expr: SUM(CASE WHEN transmission_status = 'success' THEN 1 ELSE 0 END)
      comment: "Number of successfully transmitted documents"
    - name: "transmission_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transmission_status = 'success' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents successfully transmitted — delivery reliability KPI"
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total file size of all issued documents in bytes — storage capacity planning metric"
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average file size per issuance — helps identify document complexity trends"
    - name: "digitally_signed_issuances"
      expr: SUM(CASE WHEN digital_signature_applied = true THEN 1 ELSE 0 END)
      comment: "Number of issuances with digital signatures applied — security compliance indicator"
    - name: "cancelled_issuances"
      expr: SUM(CASE WHEN issuance_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled issuances — indicates process waste or errors"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_storage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document storage metrics tracking capacity utilization, cost management, and data governance compliance for document repositories."
  source: "`transport_shipping_ecm`.`document`.`storage`"
  dimensions:
    - name: "storage_tier"
      expr: storage_tier
      comment: "Storage tier classification (hot, warm, cold, archive)"
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (cloud, on-premise, hybrid)"
    - name: "provider"
      expr: provider
      comment: "Storage service provider"
    - name: "region"
      expr: region
      comment: "Geographic region of storage"
    - name: "encryption_status"
      expr: encryption_status
      comment: "Encryption status of stored documents"
    - name: "retention_class"
      expr: retention_class
      comment: "Retention classification of stored documents"
    - name: "storage_status"
      expr: storage_status
      comment: "Current status of the storage record"
    - name: "replication_status"
      expr: replication_status
      comment: "Status of data replication for disaster recovery"
  measures:
    - name: "total_stored_documents"
      expr: COUNT(1)
      comment: "Total number of documents in storage"
    - name: "total_storage_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total storage consumed in bytes across all documents"
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average document file size — capacity planning metric"
    - name: "total_storage_cost_usd"
      expr: SUM(CAST(cost_per_gb_usd AS DOUBLE) * CAST(file_size_bytes AS DOUBLE) / 1073741824.0)
      comment: "Estimated total storage cost in USD based on per-GB rates and file sizes"
    - name: "legal_hold_documents"
      expr: SUM(CASE WHEN legal_hold_flag = true THEN 1 ELSE 0 END)
      comment: "Number of documents under legal hold — cannot be destroyed"
    - name: "encrypted_documents"
      expr: SUM(CASE WHEN encryption_status = 'encrypted' THEN 1 ELSE 0 END)
      comment: "Number of encrypted documents — security compliance indicator"
    - name: "data_residency_compliant_count"
      expr: SUM(CASE WHEN data_residency_compliant = true THEN 1 ELSE 0 END)
      comment: "Number of documents compliant with data residency requirements"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`document_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document distribution metrics tracking delivery performance, channel utilization, and SLA compliance for document dissemination to stakeholders."
  source: "`transport_shipping_ecm`.`document`.`distribution`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution"
    - name: "priority"
      expr: priority
      comment: "Priority level of the distribution"
    - name: "initiated_by_system"
      expr: initiated_by_system
      comment: "System that initiated the distribution"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework governing the distribution"
    - name: "distribution_month"
      expr: DATE_TRUNC('month', distribution_date)
      comment: "Month when the distribution was initiated"
  measures:
    - name: "total_distributions"
      expr: COUNT(1)
      comment: "Total number of document distributions initiated"
    - name: "sla_compliant_distributions"
      expr: SUM(CASE WHEN sla_compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Number of distributions meeting SLA targets"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distributions meeting SLA — delivery performance KPI"
    - name: "encrypted_distributions"
      expr: SUM(CASE WHEN encryption_applied_flag = true THEN 1 ELSE 0 END)
      comment: "Number of distributions with encryption — security compliance metric"
    - name: "regulatory_compliant_distributions"
      expr: SUM(CASE WHEN regulatory_compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Number of distributions meeting regulatory compliance requirements"
    - name: "digital_signature_applied_count"
      expr: SUM(CASE WHEN digital_signature_applied_flag = true THEN 1 ELSE 0 END)
      comment: "Number of distributions with digital signatures — authenticity assurance metric"
$$;