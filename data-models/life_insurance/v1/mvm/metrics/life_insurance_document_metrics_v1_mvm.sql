-- Metric views for domain: document | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core document inventory and quality metrics tracking lifecycle status, regulatory compliance posture, NIGO rates, e-delivery adoption, and legal hold exposure across the document repository."
  source: "`life_insurance_ecm`.`document`.`document`"
  dimensions:
    - name: "document_category"
      expr: document_category
      comment: "High-level category of the document (e.g., Policy, Claims, Underwriting) used to segment document volumes and quality metrics by business area."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the document (e.g., Active, Archived, Destroyed) enabling operational monitoring of document state distribution."
    - name: "origination_channel"
      expr: origination_channel
      comment: "Channel through which the document was originated (e.g., Agent Portal, Web, Paper) to analyze channel mix and digital adoption trends."
    - name: "file_format"
      expr: file_format
      comment: "File format of the document (e.g., PDF, TIFF, DOCX) for storage and processing optimization analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "State or regulatory jurisdiction associated with the document, enabling compliance reporting by jurisdiction."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Data sensitivity classification of the document (e.g., Public, Confidential, Restricted) for information governance reporting."
    - name: "signature_status"
      expr: signature_status
      comment: "Current signature collection status (e.g., Pending, Completed, Waived) to track execution completeness across document inventory."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of document effective date for trend analysis of document issuance volumes over time."
    - name: "received_date_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the document was received, enabling intake volume trending and SLA monitoring."
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of documents in the repository. Baseline volume metric for capacity planning and operational throughput monitoring."
    - name: "nigo_document_count"
      expr: COUNT(CASE WHEN nigo_flag = TRUE THEN document_id END)
      comment: "Count of documents flagged as Not In Good Order (NIGO). Directly impacts new business issuance speed and regulatory compliance — a key quality KPI for operations leadership."
    - name: "nigo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nigo_flag = TRUE THEN document_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents flagged as NIGO. Tracks document quality and operational efficiency; high NIGO rates signal process breakdowns that delay policy issuance and increase cost."
    - name: "e_delivery_consent_count"
      expr: COUNT(CASE WHEN e_delivery_consent_flag = TRUE THEN document_id END)
      comment: "Count of documents where the customer has consented to electronic delivery. Measures digital adoption progress, which reduces print/mail costs and improves customer experience."
    - name: "e_delivery_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN e_delivery_consent_flag = TRUE THEN document_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents with e-delivery consent. Strategic KPI for digital transformation initiatives — directly tied to operational cost reduction and customer satisfaction."
    - name: "legal_hold_document_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN document_id END)
      comment: "Count of documents currently under legal hold. Critical risk and compliance metric — elevated counts signal active litigation exposure requiring legal and compliance leadership attention."
    - name: "regulatory_filing_document_count"
      expr: COUNT(CASE WHEN regulatory_filing_flag = TRUE THEN document_id END)
      comment: "Count of documents flagged for regulatory filing. Tracks regulatory submission workload and ensures compliance obligations are being met across jurisdictions."
    - name: "signature_required_pending_count"
      expr: COUNT(CASE WHEN signature_required_flag = TRUE AND signature_status != 'Completed' THEN document_id END)
      comment: "Count of documents requiring a signature that have not yet been completed. Operational bottleneck metric — pending signatures delay policy issuance and claims processing."
    - name: "total_file_size_gb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / NULLIF(1073741824.0, 0), 4)
      comment: "Total storage consumed by documents in gigabytes. Infrastructure cost and capacity planning metric — directly informs storage budget and archival strategy decisions."
    - name: "avg_file_size_mb"
      expr: ROUND(AVG(CAST(file_size_bytes AS DOUBLE)) / NULLIF(1048576.0, 0), 4)
      comment: "Average document file size in megabytes. Informs storage optimization and imaging quality standards — outliers may indicate scanning or format compliance issues."
    - name: "latest_version_document_count"
      expr: COUNT(CASE WHEN is_latest_version = TRUE THEN document_id END)
      comment: "Count of documents that are the current/latest version. Ensures version governance health — a low ratio vs. total documents may indicate stale or superseded documents not being properly managed."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_nigo_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NIGO (Not In Good Order) deficiency tracking metrics measuring resolution efficiency, escalation rates, aging, and operational throughput for new business and in-force document quality management."
  source: "`life_insurance_ecm`.`document`.`nigo_record`"
  dimensions:
    - name: "nigo_status"
      expr: nigo_status
      comment: "Current status of the NIGO record (e.g., Open, Resolved, Escalated) for operational pipeline monitoring."
    - name: "nigo_reason_code"
      expr: nigo_reason_code
      comment: "Coded reason for the NIGO deficiency, enabling root-cause analysis and targeted process improvement."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the NIGO (e.g., Critical, High, Medium, Low) for prioritization and SLA management."
    - name: "product_type"
      expr: product_type
      comment: "Insurance product type associated with the NIGO (e.g., Term Life, Whole Life, Annuity) to identify product lines with elevated deficiency rates."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel through which the deficient document was submitted (e.g., Agent, Direct, Broker) for channel quality benchmarking."
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for resolving the NIGO (e.g., Agent, Customer, Home Office) to drive accountability and targeted training."
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction of the NIGO record for regulatory compliance monitoring and state-level quality benchmarking."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the NIGO was identified, enabling trend analysis of deficiency volumes over time."
    - name: "resolved_date_month"
      expr: DATE_TRUNC('MONTH', resolved_date)
      comment: "Month the NIGO was resolved, used to track resolution throughput and backlog clearance trends."
  measures:
    - name: "total_nigo_records"
      expr: COUNT(1)
      comment: "Total number of NIGO records. Baseline volume metric for operational workload and quality trend monitoring."
    - name: "open_nigo_count"
      expr: COUNT(CASE WHEN nigo_status = 'Open' THEN nigo_record_id END)
      comment: "Count of currently open NIGO records. Directly measures the active deficiency backlog — a key operational KPI for new business throughput and issuance speed."
    - name: "resolved_nigo_count"
      expr: COUNT(CASE WHEN resolved_date IS NOT NULL THEN nigo_record_id END)
      comment: "Count of NIGO records that have been resolved. Measures resolution throughput and operational team effectiveness."
    - name: "nigo_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolved_date IS NOT NULL THEN nigo_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NIGO records that have been resolved. Strategic quality KPI — low resolution rates indicate operational bottlenecks that delay policy issuance and increase customer friction."
    - name: "escalated_nigo_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN nigo_record_id END)
      comment: "Count of NIGO records that have been escalated. Elevated escalation counts signal systemic quality issues or agent training gaps requiring management intervention."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN nigo_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NIGO records that escalated. A rising escalation rate is an early warning indicator of deteriorating document quality or process breakdown."
    - name: "impact_on_issue_date_count"
      expr: COUNT(CASE WHEN impact_on_issue_date = TRUE THEN nigo_record_id END)
      comment: "Count of NIGO records that impacted the policy issue date. Directly measures the business cost of document deficiencies in terms of delayed revenue recognition and customer experience."
    - name: "issue_date_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN impact_on_issue_date = TRUE THEN nigo_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NIGOs that caused a delay to the policy issue date. Critical KPI for new business operations — directly tied to premium revenue timing and customer satisfaction scores."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document delivery performance metrics tracking channel effectiveness, SLA compliance, failure rates, fallback-to-paper rates, and e-delivery throughput across all delivery channels."
  source: "`life_insurance_ecm`.`document`.`delivery_event`"
  dimensions:
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used for document delivery (e.g., Email, Portal, Paper Mail) for channel performance benchmarking and digital adoption tracking."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Outcome status of the delivery attempt (e.g., Delivered, Failed, Bounced, Pending) for operational monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Type of document delivered (e.g., Policy Contract, Disclosure, Statement) to analyze delivery performance by document category."
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Priority level assigned to the delivery (e.g., Standard, Expedited, Regulatory) for SLA segmentation and prioritization analysis."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the delivery, enabling compliance reporting by state or territory."
    - name: "failure_code"
      expr: failure_code
      comment: "Coded reason for delivery failure, enabling root-cause analysis and targeted remediation of delivery failures."
    - name: "delivery_timestamp_month"
      expr: DATE_TRUNC('MONTH', delivery_timestamp)
      comment: "Month of delivery attempt for trend analysis of delivery volumes and performance over time."
  measures:
    - name: "total_delivery_events"
      expr: COUNT(1)
      comment: "Total number of delivery events. Baseline throughput metric for delivery operations capacity planning."
    - name: "successful_delivery_count"
      expr: COUNT(CASE WHEN delivery_status = 'Delivered' THEN delivery_event_id END)
      comment: "Count of successfully delivered documents. Core operational KPI measuring delivery effectiveness and customer communication reliability."
    - name: "delivery_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'Delivered' THEN delivery_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery attempts that succeeded. Strategic KPI for customer experience and regulatory compliance — failed deliveries can trigger regulatory penalties and customer complaints."
    - name: "failed_delivery_count"
      expr: COUNT(CASE WHEN failure_code IS NOT NULL AND failure_code != '' THEN delivery_event_id END)
      comment: "Count of delivery events with a recorded failure code. Operational quality metric — high failure counts increase cost through retries and paper fallback."
    - name: "paper_fallback_count"
      expr: COUNT(CASE WHEN fallback_to_paper_flag = TRUE THEN delivery_event_id END)
      comment: "Count of deliveries that fell back to paper after electronic delivery failure. Directly measures the cost impact of e-delivery failures — paper delivery is significantly more expensive than electronic."
    - name: "paper_fallback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fallback_to_paper_flag = TRUE THEN delivery_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries that fell back to paper. A rising paper fallback rate signals e-delivery infrastructure issues and directly increases operational costs."
    - name: "sla_met_count"
      expr: COUNT(CASE WHEN sla_met_flag = TRUE THEN delivery_event_id END)
      comment: "Count of deliveries that met their SLA target. Regulatory and contractual compliance metric — SLA breaches can trigger regulatory penalties and policyholder complaints."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_met_flag = TRUE THEN delivery_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries meeting SLA targets. Critical compliance and customer experience KPI — SLA compliance is often a regulatory requirement for policy document delivery."
    - name: "avg_sla_target_hours"
      expr: ROUND(AVG(CAST(sla_target_hours AS DOUBLE)), 2)
      comment: "Average SLA target hours across delivery events. Benchmarking metric for SLA standard-setting and operational planning."
    - name: "encrypted_delivery_count"
      expr: COUNT(CASE WHEN encryption_flag = TRUE THEN delivery_event_id END)
      comment: "Count of deliveries transmitted with encryption. Information security compliance metric — unencrypted delivery of sensitive policy documents creates regulatory and reputational risk."
    - name: "encryption_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN encryption_flag = TRUE THEN delivery_event_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries that used encryption. Security governance KPI — low encryption rates on sensitive document deliveries represent a material compliance and data privacy risk."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_delivery_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic delivery consent management metrics tracking consent adoption, active consent rates, revocation trends, state compliance, and renewal obligations across the policyholder base."
  source: "`life_insurance_ecm`.`document`.`delivery_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the delivery consent record (e.g., Active, Revoked, Expired) for consent portfolio monitoring."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (e.g., Online, Phone, Paper) for channel analysis and regulatory audit support."
    - name: "preferred_delivery_channel"
      expr: preferred_delivery_channel
      comment: "Customer's preferred delivery channel (e.g., Email, Portal, SMS) for digital adoption and channel preference analysis."
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction governing the consent record for state-level compliance monitoring and regulatory reporting."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (e.g., All Documents, Policy Only, Statements) to understand breadth of e-delivery authorization."
    - name: "data_classification"
      expr: data_classification
      comment: "Data sensitivity classification of the consent record for information governance and privacy compliance reporting."
    - name: "consent_date_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was obtained, enabling trend analysis of e-delivery adoption over time."
    - name: "revocation_date_month"
      expr: DATE_TRUNC('MONTH', revocation_date)
      comment: "Month consent was revoked, enabling trend analysis of consent attrition and opt-out patterns."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of delivery consent records. Baseline metric for e-delivery program scale and consent portfolio size."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN delivery_consent_id END)
      comment: "Count of currently active e-delivery consent records. Core digital adoption KPI — directly measures the addressable population for electronic document delivery, impacting operational cost."
    - name: "active_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN delivery_consent_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that are currently active. Strategic KPI for digital transformation — higher active consent rates reduce print/mail costs and improve delivery speed."
    - name: "revoked_consent_count"
      expr: COUNT(CASE WHEN revocation_date IS NOT NULL THEN delivery_consent_id END)
      comment: "Count of consent records that have been revoked. Tracks opt-out volume — rising revocations may signal customer experience issues or communication problems requiring intervention."
    - name: "revocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN revocation_date IS NOT NULL THEN delivery_consent_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that have been revoked. A rising revocation rate is an early warning indicator of customer dissatisfaction with e-delivery experience."
    - name: "state_compliant_consent_count"
      expr: COUNT(CASE WHEN state_compliance_flag = TRUE THEN delivery_consent_id END)
      comment: "Count of consent records meeting state-specific compliance requirements. Regulatory compliance metric — non-compliant consents expose the company to state regulatory penalties."
    - name: "state_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN state_compliance_flag = TRUE THEN delivery_consent_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that are state-compliant. Critical regulatory KPI — state e-delivery laws (e.g., UETA, E-SIGN) require specific consent standards; non-compliance creates legal exposure."
    - name: "renewal_required_count"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN delivery_consent_id END)
      comment: "Count of consent records requiring renewal. Operational workload metric — identifies the population needing re-consent outreach to maintain e-delivery eligibility."
    - name: "opt_in_marketing_count"
      expr: COUNT(CASE WHEN opt_in_marketing_flag = TRUE THEN delivery_consent_id END)
      comment: "Count of customers who have opted into marketing communications. Revenue enablement metric — the marketing-consented population is the addressable audience for cross-sell and upsell campaigns."
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_in_marketing_flag = TRUE THEN delivery_consent_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with marketing opt-in. Strategic revenue metric — higher opt-in rates expand the addressable market for retention and growth campaigns."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document package completeness, NIGO, SLA, and e-delivery metrics tracking the end-to-end assembly and submission quality of document packages for new business, claims, and in-force policy management."
  source: "`life_insurance_ecm`.`document`.`package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the document package (e.g., Pending, Complete, NIGO, Submitted) for pipeline and backlog monitoring."
    - name: "package_type"
      expr: package_type
      comment: "Type of document package (e.g., New Business, Claims, In-Force Change) to segment quality and throughput metrics by business process."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the package (e.g., Electronic, Paper, Hybrid) for digital adoption and cost analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the package (e.g., Standard, Rush, Regulatory) for SLA segmentation and workload prioritization."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the package for state-level compliance and quality reporting."
    - name: "source_system"
      expr: source_system
      comment: "Originating system that created the package (e.g., Agency Portal, Direct Web, Legacy) for system quality benchmarking."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the package was submitted for trend analysis of new business and in-force activity volumes."
    - name: "assembly_date_month"
      expr: DATE_TRUNC('MONTH', assembly_date)
      comment: "Month the package was assembled for operational throughput trending."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of document packages. Baseline throughput metric for new business and in-force operations capacity planning."
    - name: "nigo_package_count"
      expr: COUNT(CASE WHEN nigo_flag = TRUE THEN package_id END)
      comment: "Count of packages flagged as NIGO. Directly measures document quality failures that delay policy issuance and increase operational cost."
    - name: "nigo_package_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nigo_flag = TRUE THEN package_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages flagged as NIGO. Strategic quality KPI — high NIGO rates delay revenue recognition, increase operational cost, and degrade agent and customer experience."
    - name: "e_delivery_consent_package_count"
      expr: COUNT(CASE WHEN e_delivery_consent_flag = TRUE THEN package_id END)
      comment: "Count of packages where e-delivery consent has been obtained. Measures digital delivery eligibility across the package pipeline, directly impacting delivery cost."
    - name: "e_delivery_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN e_delivery_consent_flag = TRUE THEN package_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages with e-delivery consent. Digital transformation KPI — higher rates reduce print/mail costs and accelerate delivery timelines."
    - name: "avg_completeness_pct"
      expr: ROUND(AVG(CAST(completeness_percentage AS DOUBLE)), 2)
      comment: "Average document completeness percentage across packages. Operational quality metric — low average completeness indicates systemic gaps in document collection that delay processing."
    - name: "complete_package_count"
      expr: COUNT(CASE WHEN completeness_percentage = 100.0 THEN package_id END)
      comment: "Count of packages with 100% document completeness. Measures the volume of packages ready for straight-through processing without manual intervention."
    - name: "package_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completeness_percentage = 100.0 THEN package_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages that are fully complete. Straight-through processing rate — a key efficiency KPI that directly correlates with issuance speed and operational cost per policy."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_signature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic and wet signature execution metrics tracking completion rates, authentication methods, e-signature adoption, legal validity, and consent compliance across the signature workflow."
  source: "`life_insurance_ecm`.`document`.`signature`"
  dimensions:
    - name: "signature_status"
      expr: signature_status
      comment: "Current status of the signature request (e.g., Pending, Completed, Declined, Voided) for pipeline monitoring and SLA management."
    - name: "signature_method"
      expr: signature_method
      comment: "Method used for signing (e.g., Electronic, Wet Ink, Notarized) to track e-signature adoption and compliance with state requirements."
    - name: "signer_role"
      expr: signer_role
      comment: "Role of the signer (e.g., Policyholder, Beneficiary, Agent, Witness) for signature workflow completeness analysis."
    - name: "authentication_method"
      expr: authentication_method
      comment: "Method used to authenticate the signer (e.g., Knowledge-Based, SMS OTP, Email Link) for security and compliance analysis."
    - name: "esignature_platform"
      expr: esignature_platform
      comment: "E-signature platform used (e.g., DocuSign, Adobe Sign) for vendor performance benchmarking and platform consolidation analysis."
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction governing the signature for state-specific e-signature law compliance monitoring."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for signing (e.g., Desktop, Mobile, Tablet) for UX optimization and digital channel analysis."
    - name: "signature_timestamp_month"
      expr: DATE_TRUNC('MONTH', signature_timestamp)
      comment: "Month the signature was executed for trend analysis of signature volumes and completion rates over time."
  measures:
    - name: "total_signature_requests"
      expr: COUNT(1)
      comment: "Total number of signature requests. Baseline volume metric for signature workflow capacity planning."
    - name: "completed_signature_count"
      expr: COUNT(CASE WHEN signature_status = 'Completed' THEN signature_id END)
      comment: "Count of successfully completed signatures. Core operational KPI — incomplete signatures block policy issuance, claims payment, and in-force changes."
    - name: "signature_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN signature_status = 'Completed' THEN signature_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of signature requests that have been completed. Strategic KPI for new business and in-force operations — low completion rates directly delay revenue and increase operational cost."
    - name: "declined_signature_count"
      expr: COUNT(CASE WHEN signature_status = 'Declined' THEN signature_id END)
      comment: "Count of signature requests that were declined by the signer. Elevated decline rates may indicate customer experience issues, unclear instructions, or product concerns requiring intervention."
    - name: "voided_signature_count"
      expr: COUNT(CASE WHEN voided_timestamp IS NOT NULL THEN signature_id END)
      comment: "Count of signature requests that were voided. Tracks rework volume — voided signatures require re-initiation, adding cost and delay to the document execution process."
    - name: "e_signature_consent_count"
      expr: COUNT(CASE WHEN consent_to_electronic_signature = TRUE THEN signature_id END)
      comment: "Count of signers who consented to electronic signature. Measures e-signature adoption — a prerequisite for digital straight-through processing and cost reduction."
    - name: "e_signature_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_to_electronic_signature = TRUE THEN signature_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of signature requests with e-signature consent. Digital transformation KPI — higher e-signature adoption reduces cycle time and eliminates paper handling costs."
    - name: "legally_valid_signature_count"
      expr: COUNT(CASE WHEN legal_validity_flag = TRUE THEN signature_id END)
      comment: "Count of signatures confirmed as legally valid. Compliance and risk metric — legally invalid signatures on policy documents create contract enforceability risk and regulatory exposure."
    - name: "legal_validity_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN legal_validity_flag = TRUE THEN signature_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of signatures confirmed as legally valid. Critical risk KPI — a declining legal validity rate signals authentication or process failures that could invalidate policy contracts."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document workflow operational metrics tracking processing throughput, NIGO rates, SLA breach rates, escalation patterns, and quality control outcomes across imaging and document management workflows."
  source: "`life_insurance_ecm`.`document`.`workflow`"
  dimensions:
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the workflow (e.g., In Progress, Completed, On Hold, Cancelled) for pipeline and backlog monitoring."
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of workflow (e.g., New Business, Claims, In-Force Change, Imaging) to segment performance metrics by business process."
    - name: "current_stage"
      expr: current_stage
      comment: "Current processing stage of the workflow for bottleneck identification and stage-level throughput analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the workflow (e.g., Standard, Rush, Regulatory) for SLA segmentation."
    - name: "assigned_queue"
      expr: assigned_queue
      comment: "Processing queue to which the workflow is assigned for workload distribution and queue performance analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel from which the workflow originated (e.g., Agent Portal, Mail Room, Fax) for channel quality benchmarking."
    - name: "quality_control_status"
      expr: quality_control_status
      comment: "Quality control review outcome (e.g., Passed, Failed, Pending) for QC throughput and defect rate monitoring."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the workflow for management visibility into elevated-risk items."
    - name: "created_timestamp_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the workflow was created for trend analysis of intake volumes and processing throughput over time."
  measures:
    - name: "total_workflows"
      expr: COUNT(1)
      comment: "Total number of document workflows. Baseline throughput metric for operations capacity planning and staffing decisions."
    - name: "nigo_workflow_count"
      expr: COUNT(CASE WHEN nigo_flag = TRUE THEN workflow_id END)
      comment: "Count of workflows flagged as NIGO. Measures document quality failures entering the processing pipeline — directly impacts issuance speed and operational cost."
    - name: "nigo_workflow_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nigo_flag = TRUE THEN workflow_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows flagged as NIGO. Operational quality KPI — high NIGO rates in the workflow pipeline signal upstream document quality issues requiring agent or process intervention."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN workflow_id END)
      comment: "Count of workflows that breached their SLA. Regulatory and contractual compliance metric — SLA breaches on policy documents can trigger regulatory penalties and customer complaints."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN workflow_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows that breached SLA. Critical operational KPI — a rising SLA breach rate signals capacity constraints or quality issues requiring immediate management action."
    - name: "completed_workflow_count"
      expr: COUNT(CASE WHEN completed_timestamp IS NOT NULL THEN workflow_id END)
      comment: "Count of workflows that have been completed. Measures processing throughput and operational team productivity."
    - name: "workflow_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completed_timestamp IS NOT NULL THEN workflow_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows that have been completed. Throughput efficiency KPI — low completion rates indicate backlog buildup that delays policy issuance and customer service."
    - name: "avg_imaging_batch_size"
      expr: ROUND(AVG(CAST(imaging_batch_number AS DOUBLE)), 2)
      comment: "Average imaging batch number across workflows. Operational efficiency metric for imaging center capacity planning and batch processing optimization."
    - name: "qc_failed_workflow_count"
      expr: COUNT(CASE WHEN quality_control_status = 'Failed' THEN workflow_id END)
      comment: "Count of workflows that failed quality control review. Quality assurance metric — QC failures require rework, increasing cost and delaying document processing throughput."
    - name: "qc_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_control_status = 'Failed' THEN workflow_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows failing quality control. Operational quality KPI — a rising QC failure rate signals imaging, indexing, or data entry quality degradation requiring process intervention."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document version governance metrics tracking version proliferation, litigation hold exposure, OCR processing quality, encryption compliance, and purge eligibility across the document version repository."
  source: "`life_insurance_ecm`.`document`.`version`"
  dimensions:
    - name: "version_status"
      expr: version_status
      comment: "Current status of the document version (e.g., Active, Superseded, Archived, Purged) for version lifecycle governance."
    - name: "version_type"
      expr: version_type
      comment: "Type of version (e.g., Original, Amendment, Correction, Restatement) to analyze version change patterns and document stability."
    - name: "file_format"
      expr: file_format
      comment: "File format of the version (e.g., PDF, TIFF, DOCX) for storage optimization and format standardization analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the document version for multilingual compliance and customer communication analysis."
    - name: "source_system"
      expr: source_system
      comment: "System that originated the version for data lineage and system quality benchmarking."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the version became effective for trend analysis of document change activity over time."
    - name: "eligible_for_purge_date_month"
      expr: DATE_TRUNC('MONTH', eligible_for_purge_date)
      comment: "Month versions become eligible for purge, enabling proactive retention management and storage cost reduction planning."
  measures:
    - name: "total_versions"
      expr: COUNT(1)
      comment: "Total number of document versions. Baseline metric for version repository size and governance scope."
    - name: "litigation_hold_version_count"
      expr: COUNT(CASE WHEN is_under_litigation_hold = TRUE THEN version_id END)
      comment: "Count of document versions currently under litigation hold. Critical legal risk metric — litigation hold volumes directly inform legal department resource needs and e-discovery cost exposure."
    - name: "litigation_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_under_litigation_hold = TRUE THEN version_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of document versions under litigation hold. Risk exposure metric — a rising litigation hold rate signals increasing legal activity that may impact storage costs and document destruction schedules."
    - name: "encrypted_version_count"
      expr: COUNT(CASE WHEN is_encrypted = TRUE THEN version_id END)
      comment: "Count of document versions stored with encryption. Information security compliance metric — unencrypted storage of sensitive policy documents creates regulatory and data breach risk."
    - name: "encryption_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_encrypted = TRUE THEN version_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of document versions stored with encryption. Security governance KPI — regulators and auditors expect near-100% encryption rates for PII/PHI-containing documents."
    - name: "digitally_signed_version_count"
      expr: COUNT(CASE WHEN is_digitally_signed = TRUE THEN version_id END)
      comment: "Count of document versions with a digital signature. Document integrity and non-repudiation metric — digitally signed versions provide stronger legal and audit trail protection."
    - name: "ocr_processed_version_count"
      expr: COUNT(CASE WHEN ocr_processed_flag = TRUE THEN version_id END)
      comment: "Count of document versions that have been OCR processed. Operational efficiency metric — OCR-processed documents are searchable and indexable, enabling straight-through processing and reducing manual review."
    - name: "ocr_processing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ocr_processed_flag = TRUE THEN version_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of document versions that have been OCR processed. Digital operations KPI — low OCR rates indicate imaging backlog or quality issues that impede automated document processing."
    - name: "avg_ocr_confidence_score"
      expr: ROUND(AVG(CAST(ocr_confidence_score AS DOUBLE)), 2)
      comment: "Average OCR confidence score across processed document versions. Quality metric for imaging operations — low confidence scores indicate poor scan quality that increases manual review cost and error rates."
    - name: "total_version_storage_gb"
      expr: ROUND(SUM(CAST(file_size_bytes AS DOUBLE)) / NULLIF(1073741824.0, 0), 4)
      comment: "Total storage consumed by document versions in gigabytes. Infrastructure cost metric — directly informs storage budget, archival strategy, and cloud storage optimization decisions."
    - name: "purge_eligible_version_count"
      expr: COUNT(CASE WHEN eligible_for_purge_date <= CURRENT_DATE() AND is_under_litigation_hold = FALSE THEN version_id END)
      comment: "Count of document versions eligible for purge that are not under litigation hold. Storage cost reduction opportunity metric — actionable KPI for records management teams to execute destruction and reduce storage costs."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`document_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document template governance metrics tracking regulatory approval status, e-delivery eligibility, NIGO tracking coverage, template utilization, and DOI approval compliance across the template library."
  source: "`life_insurance_ecm`.`document`.`template`"
  dimensions:
    - name: "template_status"
      expr: template_status
      comment: "Current status of the template (e.g., Active, Retired, Pending Approval) for template library governance."
    - name: "template_category"
      expr: template_category
      comment: "Category of the template (e.g., Policy Contract, Disclosure, Application) for template portfolio analysis by document type."
    - name: "template_type"
      expr: template_type
      comment: "Type classification of the template for segmentation of regulatory and operational metrics."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business the template serves (e.g., Term Life, Whole Life, Annuity) for LOB-level template governance."
    - name: "doi_approval_status"
      expr: doi_approval_status
      comment: "Department of Insurance approval status for the template (e.g., Approved, Pending, Rejected) for regulatory compliance monitoring."
    - name: "language_code"
      expr: language_code
      comment: "Language of the template for multilingual compliance and customer communication coverage analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the template became effective for trend analysis of template library changes over time."
  measures:
    - name: "total_templates"
      expr: COUNT(1)
      comment: "Total number of document templates in the library. Baseline metric for template portfolio size and governance scope."
    - name: "active_template_count"
      expr: COUNT(CASE WHEN template_status = 'Active' THEN template_id END)
      comment: "Count of currently active templates. Operational readiness metric — ensures sufficient active templates are available to support all product lines and jurisdictions."
    - name: "doi_approved_template_count"
      expr: COUNT(CASE WHEN doi_approval_status = 'Approved' THEN template_id END)
      comment: "Count of templates with Department of Insurance approval. Regulatory compliance metric — using non-DOI-approved templates in regulated states creates significant regulatory and legal exposure."
    - name: "doi_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN doi_approval_status = 'Approved' THEN template_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of templates with DOI approval. Critical regulatory compliance KPI — low approval rates indicate a backlog of unapproved templates that cannot be legally used in regulated states."
    - name: "e_delivery_eligible_template_count"
      expr: COUNT(CASE WHEN e_delivery_eligible_flag = TRUE THEN template_id END)
      comment: "Count of templates eligible for electronic delivery. Digital transformation metric — e-delivery eligible templates enable cost-effective electronic document distribution."
    - name: "e_delivery_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN e_delivery_eligible_flag = TRUE THEN template_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of templates eligible for e-delivery. Digital adoption KPI — low eligibility rates constrain the company's ability to reduce print/mail costs and accelerate delivery."
    - name: "regulatory_approval_required_count"
      expr: COUNT(CASE WHEN regulatory_approval_required_flag = TRUE THEN template_id END)
      comment: "Count of templates requiring regulatory approval. Compliance workload metric — identifies the scope of templates subject to regulatory review cycles."
    - name: "total_template_usage_count"
      expr: SUM(CAST(usage_count AS BIGINT))
      comment: "Total usage count across all templates. Utilization metric — identifies high-usage templates requiring priority maintenance and low-usage templates that may be candidates for retirement."
    - name: "avg_template_usage_count"
      expr: ROUND(AVG(CAST(usage_count AS DOUBLE)), 2)
      comment: "Average usage count per template. Benchmarking metric for template utilization — templates significantly below average may indicate redundancy or accessibility issues."
$$;