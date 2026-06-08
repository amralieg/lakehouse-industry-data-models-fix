-- Metric views for domain: vendor | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vendor spend analytics covering gross, net, tax, and discount amounts across spend categories, expense types, fiscal periods, and payment methods. Essential for procurement cost management, budget adherence, and vendor financial performance tracking."
  source: "`health_insurance_ecm`.`vendor`.`spend`"
  dimensions:
    - name: "spend_category"
      expr: spend_category
      comment: "Category of vendor spend (e.g., IT services, clinical, administrative) for cost allocation analysis"
    - name: "expense_type"
      expr: expense_type
      comment: "Type of expense for GL classification and budget tracking"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend transaction for annual budget analysis"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly spend trending and variance analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the spend transaction"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, ACH, wire) for treasury and cash flow analysis"
    - name: "spend_status"
      expr: spend_status
      comment: "Current status of the spend record (approved, pending, rejected)"
    - name: "is_approved"
      expr: CAST(is_approved AS STRING)
      comment: "Whether the spend has been approved, for compliance and control monitoring"
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether the spend meets compliance requirements"
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period for spend-to-budget variance analysis"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of transaction for monthly spend trending"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for cash flow analysis"
    - name: "vendor_rating"
      expr: vendor_rating
      comment: "Vendor performance rating associated with the spend for value-for-money analysis"
  measures:
    - name: "total_gross_spend"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross spend amount before discounts and taxes — primary procurement volume indicator"
    - name: "total_net_spend"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net spend after discounts — represents actual cost to the organization"
    - name: "total_spend_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total spend normalized to USD for cross-currency consolidated reporting"
    - name: "total_discount_amount"
      expr: SUM(CAST(amount_discount AS DOUBLE))
      comment: "Total discounts captured from vendors — measures procurement negotiation effectiveness"
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax paid on vendor spend for tax planning and compliance"
    - name: "avg_spend_per_transaction"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net spend per transaction — indicator of transaction size and procurement efficiency"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across spend transactions — flags concentration or compliance risk in spending patterns"
    - name: "spend_transaction_count"
      expr: COUNT(1)
      comment: "Total number of spend transactions for volume and processing efficiency analysis"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with spend — measures vendor diversification and concentration risk"
    - name: "approved_spend_count"
      expr: SUM(CASE WHEN is_approved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of approved spend transactions for approval rate and control effectiveness monitoring"
    - name: "compliant_spend_count"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of compliant spend transactions for regulatory adherence tracking"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice processing and payment analytics for accounts payable management, early payment discount capture, dispute tracking, and vendor payment performance in health insurance operations."
  source: "`health_insurance_ecm`.`vendor`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (open, paid, disputed, cancelled)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for cash management and aging analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for control and bottleneck analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP reporting"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for treasury optimization"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Negotiated payment terms (Net 30, Net 60, etc.) for working capital analysis"
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category for cost allocation and budget tracking"
    - name: "dispute_flag"
      expr: CAST(dispute_flag AS STRING)
      comment: "Whether the invoice is disputed — critical for vendor relationship and AP quality monitoring"
    - name: "is_early_payment_discount"
      expr: CAST(is_early_payment_discount AS STRING)
      comment: "Whether early payment discount was available for working capital optimization analysis"
    - name: "tax_exempt_flag"
      expr: CAST(tax_exempt_flag AS STRING)
      comment: "Tax exemption status for tax compliance reporting"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month for AP volume trending"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Due date month for cash flow forecasting"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Payment month for cash outflow analysis"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount — primary accounts payable liability indicator"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after adjustments for actual AP obligation tracking"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on invoices for tax liability management"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts captured on invoices — measures procurement savings effectiveness"
    - name: "total_early_payment_discount"
      expr: SUM(CAST(early_payment_discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured — measures working capital optimization"
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts held — measures contractual holdback for performance assurance"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total invoice volume for AP processing capacity and efficiency analysis"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed invoices — indicator of invoice quality and vendor billing accuracy"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount for transaction size analysis and anomaly detection"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors submitting invoices for vendor base analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract portfolio analytics covering contract values, renewal management, compliance, and risk exposure. Critical for health insurance vendor governance, regulatory compliance, and strategic sourcing decisions."
  source: "`health_insurance_ecm`.`vendor`.`vendor_contract`"
  dimensions:
    - name: "vendor_contract_status"
      expr: vendor_contract_status
      comment: "Current contract status (active, expired, terminated, pending) for portfolio management"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (services, licensing, consulting) for strategic sourcing analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for financial reporting"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Data confidentiality classification for PHI/PII risk management in health insurance"
    - name: "auto_renewal_flag"
      expr: CAST(auto_renewal_flag AS STRING)
      comment: "Whether contract auto-renews — critical for renewal management and cost control"
    - name: "is_exclusive"
      expr: CAST(is_exclusive AS STRING)
      comment: "Whether vendor has exclusive arrangement — measures concentration risk"
    - name: "is_mandatory"
      expr: CAST(is_mandatory AS STRING)
      comment: "Whether contract is mandatory (regulatory/operational) vs discretionary"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for working capital and cash flow planning"
    - name: "governing_law"
      expr: governing_law
      comment: "Governing jurisdiction for legal and regulatory compliance tracking"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year contract became effective for vintage analysis"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Contract expiration month for renewal pipeline management"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed contract value across the vendor portfolio — primary procurement commitment indicator"
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Total annualized contract value for budget planning and annual spend forecasting"
    - name: "avg_annual_contract_value"
      expr: AVG(CAST(annual_contract_value AS DOUBLE))
      comment: "Average annual contract value — indicator of contract size distribution and vendor dependency"
    - name: "active_contract_count"
      expr: SUM(CASE WHEN vendor_contract_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active contracts for portfolio size and management capacity planning"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total contract count across all statuses for portfolio overview"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors under contract for vendor base and concentration analysis"
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of auto-renewing contracts — flags contracts requiring proactive renewal management"
    - name: "exclusive_contract_count"
      expr: SUM(CASE WHEN is_exclusive = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive vendor arrangements — measures single-source dependency risk"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance evaluation analytics measuring SLA compliance, quality, delivery, customer satisfaction, and financial stability. Essential for vendor tiering, scorecarding, and strategic relationship decisions in health insurance operations."
  source: "`health_insurance_ecm`.`vendor`.`performance`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the performance evaluation (completed, in-progress, draft)"
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "Evaluation period (monthly, quarterly, annual) for trending analysis"
    - name: "tier_decision"
      expr: tier_decision
      comment: "Tiering decision outcome (promote, maintain, demote, terminate) for vendor lifecycle management"
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status for regulatory adherence tracking"
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_start_date)
      comment: "Evaluation start month for performance trending"
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall vendor performance score — primary vendor health indicator for scorecarding"
    - name: "avg_sla_compliance_rate"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate — measures vendor contractual obligation adherence"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate — measures vendor reliability and operational impact"
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate — measures vendor output quality and rework risk"
    - name: "avg_customer_satisfaction_rating"
      expr: AVG(CAST(customer_satisfaction_rating AS DOUBLE))
      comment: "Average customer satisfaction rating — measures end-user experience with vendor services"
    - name: "avg_financial_stability_rating"
      expr: AVG(CAST(financial_stability_rating AS DOUBLE))
      comment: "Average financial stability rating — measures vendor viability and continuity risk"
    - name: "avg_issue_resolution_time_days"
      expr: AVG(CAST(issue_resolution_time_days AS DOUBLE))
      comment: "Average issue resolution time in days — measures vendor responsiveness and support quality"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score from performance evaluations for risk-adjusted vendor management"
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of performance evaluations conducted for governance completeness tracking"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated for coverage analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment analytics covering cybersecurity, financial stability, business continuity, and regulatory compliance scores. Critical for HIPAA compliance, PHI protection, and enterprise risk management in health insurance."
  source: "`health_insurance_ecm`.`vendor`.`risk_assessment`"
  dimensions:
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Current status of the risk assessment (completed, in-progress, overdue)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (initial, periodic, triggered) for assessment program management"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification (critical, high, medium, low) for risk-based vendor oversight"
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls for baseline risk profiling"
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls for effective risk posture assessment"
    - name: "risk_domain"
      expr: risk_domain
      comment: "Risk domain (cybersecurity, financial, operational, compliance) for risk category analysis"
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Rating of control effectiveness for remediation prioritization"
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for assessment consistency and comparability analysis"
    - name: "concentration_risk_flag"
      expr: CAST(concentration_risk_flag AS STRING)
      comment: "Whether vendor poses concentration risk — critical for business continuity planning"
    - name: "regulatory_compliance_flag"
      expr: CAST(regulatory_compliance_flag AS STRING)
      comment: "Whether vendor meets regulatory compliance requirements (HIPAA, state regulations)"
    - name: "reputational_risk_flag"
      expr: CAST(reputational_risk_flag AS STRING)
      comment: "Whether vendor poses reputational risk to the health plan"
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment for trending and cadence analysis"
  measures:
    - name: "avg_overall_residual_score"
      expr: AVG(CAST(overall_residual_score AS DOUBLE))
      comment: "Average overall residual risk score — primary enterprise risk indicator for vendor portfolio"
    - name: "avg_cybersecurity_score"
      expr: AVG(CAST(cybersecurity_score AS DOUBLE))
      comment: "Average cybersecurity score — critical for PHI/ePHI protection in health insurance"
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score — measures vendor viability and continuity risk"
    - name: "avg_business_continuity_score"
      expr: AVG(CAST(business_continuity_score AS DOUBLE))
      comment: "Average business continuity score — measures vendor disaster recovery and resilience capability"
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score — measures HIPAA and state regulatory adherence"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average composite risk score for overall vendor risk trending"
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Total risk assessments conducted for program completeness and cadence monitoring"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors assessed for risk assessment coverage analysis"
    - name: "high_risk_vendor_count"
      expr: SUM(CASE WHEN risk_tier IN ('critical', 'high') THEN 1 ELSE 0 END)
      comment: "Count of critical/high risk tier vendors requiring enhanced oversight"
    - name: "concentration_risk_count"
      expr: SUM(CASE WHEN concentration_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendors flagged for concentration risk — business continuity planning trigger"
    - name: "regulatory_noncompliant_count"
      expr: SUM(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of vendors failing regulatory compliance — immediate remediation trigger for HIPAA"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor incident and breach analytics tracking PHI breaches, severity, member impact, and resolution. Critical for HIPAA breach notification compliance, regulatory reporting, and vendor risk management in health insurance."
  source: "`health_insurance_ecm`.`vendor`.`incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current incident status (open, investigating, resolved, closed) for incident management"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (data breach, service outage, compliance violation) for root cause analysis"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, high, medium, low) for prioritization and escalation"
    - name: "is_phi_involved"
      expr: CAST(is_phi_involved AS STRING)
      comment: "Whether Protected Health Information was involved — triggers HIPAA breach notification requirements"
    - name: "breach_notification_sent"
      expr: CAST(breach_notification_sent AS STRING)
      comment: "Whether breach notification was sent — HIPAA compliance tracking"
    - name: "regulatory_notification_required"
      expr: CAST(regulatory_notification_required AS STRING)
      comment: "Whether regulatory notification is required (HHS, state AG) for compliance tracking"
    - name: "reporting_channel"
      expr: reporting_channel
      comment: "Channel through which incident was reported for detection capability analysis"
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status at time of incident"
    - name: "incident_month"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month of incident occurrence for trending and pattern analysis"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total vendor incidents — primary indicator of vendor operational risk and reliability"
    - name: "total_affected_members"
      expr: SUM(CAST(affected_member_count AS DOUBLE))
      comment: "Total members affected by vendor incidents — measures member impact and breach notification scope"
    - name: "avg_affected_members_per_incident"
      expr: AVG(CAST(affected_member_count AS DOUBLE))
      comment: "Average members affected per incident — measures incident severity and blast radius"
    - name: "phi_incident_count"
      expr: SUM(CASE WHEN is_phi_involved = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents involving PHI — HIPAA breach reporting and compliance critical metric"
    - name: "critical_high_severity_count"
      expr: SUM(CASE WHEN severity_level IN ('critical', 'high') THEN 1 ELSE 0 END)
      comment: "Count of critical/high severity incidents requiring executive attention and rapid response"
    - name: "open_incident_count"
      expr: SUM(CASE WHEN incident_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of currently open incidents for workload and response capacity management"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with incidents for vendor risk concentration analysis"
    - name: "regulatory_notification_required_count"
      expr: SUM(CASE WHEN regulatory_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring regulatory notification — compliance and legal exposure indicator"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order analytics covering order volumes, amounts, payment performance, and procurement efficiency. Supports procurement operations, budget management, and vendor payment optimization for health insurance operations."
  source: "`health_insurance_ecm`.`vendor`.`purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current PO status (open, approved, received, closed, cancelled) for procurement pipeline management"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, contract) for procurement strategy analysis"
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category for spend classification and strategic sourcing"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for cash flow and AP management"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for working capital optimization"
    - name: "currency_code"
      expr: currency_code
      comment: "PO currency for multi-currency procurement reporting"
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department requesting the purchase for cost center and demand analysis"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for budget allocation and variance tracking"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_timestamp)
      comment: "Month of PO creation for procurement volume trending"
  measures:
    - name: "total_po_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total purchase order amount — primary procurement commitment indicator"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net PO amount after discounts for actual procurement cost tracking"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payments made against POs for cash outflow tracking"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts on purchase orders — measures procurement negotiation effectiveness"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on purchase orders for tax planning"
    - name: "avg_po_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average PO amount for transaction size analysis and approval threshold optimization"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average PO risk score for procurement risk monitoring"
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total purchase order count for procurement volume and processing capacity analysis"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with POs for vendor base and concentration analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_sla_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA event analytics tracking vendor service level compliance, breaches, penalties, and variance from targets. Essential for vendor accountability, contract enforcement, and service quality management in health insurance operations."
  source: "`health_insurance_ecm`.`vendor`.`sla_event`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "SLA compliance status (met, breached, at-risk) for vendor accountability tracking"
    - name: "sla_metric_name"
      expr: sla_metric_name
      comment: "Name of the SLA metric being measured for service-level analysis"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of SLA breach for escalation and penalty determination"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of SLA events for remediation tracking"
    - name: "penalty_triggered"
      expr: CAST(penalty_triggered AS STRING)
      comment: "Whether a financial penalty was triggered by the SLA breach"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure SLA compliance for consistency analysis"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the SLA metric (hours, percentage, count)"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of SLA event for compliance trending"
  measures:
    - name: "sla_event_count"
      expr: COUNT(1)
      comment: "Total SLA events measured for vendor oversight completeness"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_status = 'breached' THEN 1 ELSE 0 END)
      comment: "Count of SLA breaches — primary vendor accountability and contract enforcement metric"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties from SLA breaches — measures contract enforcement and vendor cost of non-compliance"
    - name: "penalty_triggered_count"
      expr: SUM(CASE WHEN penalty_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events where penalties were triggered for financial impact tracking"
    - name: "avg_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average variance from SLA targets — measures overall vendor service delivery gap"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual SLA performance value for benchmarking against targets"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value for baseline and threshold analysis"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Number of unique contracts with SLA events for coverage analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor dispute analytics tracking dispute volumes, amounts, resolution, and escalation patterns. Critical for vendor relationship management, financial exposure control, and operational risk mitigation."
  source: "`health_insurance_ecm`.`vendor`.`vendor_dispute`"
  dimensions:
    - name: "vendor_dispute_status"
      expr: vendor_dispute_status
      comment: "Current dispute status (open, under review, resolved, escalated) for dispute management"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (billing, service, contract, quality) for root cause analysis"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of dispute for classification and trending"
    - name: "priority"
      expr: priority
      comment: "Dispute priority level for workload management and escalation"
    - name: "escalation_flag"
      expr: CAST(escalation_flag AS STRING)
      comment: "Whether dispute has been escalated for management attention tracking"
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether dispute has compliance implications"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of disputed amount for financial reporting"
    - name: "open_month"
      expr: DATE_TRUNC('month', open_timestamp)
      comment: "Month dispute was opened for volume trending"
  measures:
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total vendor disputes — primary indicator of vendor relationship health and billing quality"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed dollar amount — measures financial exposure from vendor disagreements"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts — measures actual financial resolution cost"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute for severity and materiality analysis"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of disputes for risk-weighted dispute management"
    - name: "escalated_dispute_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated disputes requiring management intervention"
    - name: "open_dispute_count"
      expr: SUM(CASE WHEN vendor_dispute_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of currently open disputes for workload and aging management"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with disputes for vendor relationship risk analysis"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor audit analytics tracking audit completion, findings, costs, and compliance framework adherence. Essential for HIPAA compliance oversight, vendor governance, and regulatory audit readiness in health insurance."
  source: "`health_insurance_ecm`.`vendor`.`vendor_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current audit status (planned, in-progress, completed, cancelled) for audit program management"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (HIPAA, SOC2, financial, operational) for compliance program tracking"
    - name: "auditor_type"
      expr: auditor_type
      comment: "Type of auditor (internal, external, regulatory) for audit independence analysis"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating (satisfactory, needs improvement, unsatisfactory) for vendor compliance scoring"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework assessed (HIPAA, HITRUST, SOC2) for framework coverage analysis"
    - name: "corrective_action_required"
      expr: CAST(corrective_action_required AS STRING)
      comment: "Whether corrective actions are required — triggers remediation tracking"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the audit for regulatory relationship tracking"
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start)
      comment: "Audit period start month for coverage and cadence analysis"
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total vendor audits conducted for governance program completeness"
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of vendor audits for audit program budget management"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score from audits for vendor risk trending"
    - name: "corrective_action_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring corrective action — measures vendor compliance gap severity"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors audited for audit coverage analysis"
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per audit for audit program efficiency and budgeting"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor onboarding analytics tracking onboarding volume, cost, compliance checklist completion, and risk assessment. Critical for vendor intake efficiency, due diligence completeness, and time-to-value optimization."
  source: "`health_insurance_ecm`.`vendor`.`onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status (in-progress, completed, rejected, on-hold) for pipeline management"
    - name: "stage"
      expr: stage
      comment: "Current onboarding stage for process bottleneck identification"
    - name: "outcome"
      expr: outcome
      comment: "Onboarding outcome (approved, rejected, withdrawn) for conversion analysis"
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status during onboarding for due diligence tracking"
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department requesting vendor onboarding for demand analysis"
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of onboarding request for volume trending"
  measures:
    - name: "onboarding_count"
      expr: COUNT(1)
      comment: "Total vendor onboarding requests for intake volume and capacity planning"
    - name: "total_onboarding_cost"
      expr: SUM(CAST(total_onboarding_cost AS DOUBLE))
      comment: "Total cost of vendor onboarding activities for program budget management"
    - name: "avg_onboarding_cost"
      expr: AVG(CAST(total_onboarding_cost AS DOUBLE))
      comment: "Average onboarding cost per vendor for efficiency benchmarking"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score during onboarding for intake risk profiling"
    - name: "completed_onboarding_count"
      expr: SUM(CASE WHEN onboarding_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed onboardings for throughput and conversion tracking"
    - name: "baa_executed_count"
      expr: SUM(CASE WHEN checklist_baa_executed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of onboardings with BAA executed — HIPAA compliance critical for health insurance"
    - name: "security_questionnaire_count"
      expr: SUM(CASE WHEN checklist_security_questionnaire = TRUE THEN 1 ELSE 0 END)
      comment: "Count of onboardings with security questionnaire completed for cybersecurity due diligence"
    - name: "insurance_verified_count"
      expr: SUM(CASE WHEN checklist_insurance_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of onboardings with insurance verified for liability protection assurance"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors in onboarding pipeline"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_baa_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business Associate Agreement (BAA) analytics critical for HIPAA compliance in health insurance. Tracks BAA execution, compliance status, breach notification obligations, and risk assessment across the vendor portfolio."
  source: "`health_insurance_ecm`.`vendor`.`baa_agreement`"
  dimensions:
    - name: "baa_agreement_status"
      expr: baa_agreement_status
      comment: "Current BAA status (active, expired, terminated, pending) for HIPAA compliance management"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of BAA (standard, subcontractor, downstream) for agreement hierarchy tracking"
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status for regulatory readiness assessment"
    - name: "breach_notification_obligation"
      expr: CAST(breach_notification_obligation AS STRING)
      comment: "Whether vendor has breach notification obligation under the BAA"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year BAA became effective for vintage and renewal analysis"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', effective_until)
      comment: "BAA expiration month for renewal pipeline management"
  measures:
    - name: "baa_count"
      expr: COUNT(1)
      comment: "Total BAA agreements — measures HIPAA compliance program scope"
    - name: "active_baa_count"
      expr: SUM(CASE WHEN baa_agreement_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active BAAs for current HIPAA compliance coverage"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across BAAs for PHI protection risk monitoring"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with BAAs for HIPAA coverage analysis"
    - name: "breach_notification_obligated_count"
      expr: SUM(CASE WHEN breach_notification_obligation = TRUE THEN 1 ELSE 0 END)
      comment: "Count of BAAs with breach notification obligations for HIPAA breach response readiness"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`vendor_rfp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP (Request for Proposal) analytics tracking solicitation volumes, award amounts, competitive participation, and procurement cycle management for strategic sourcing in health insurance."
  source: "`health_insurance_ecm`.`vendor`.`rfp`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current RFP status (draft, issued, evaluation, awarded, cancelled) for pipeline management"
    - name: "award_status"
      expr: award_status
      comment: "Award status for procurement outcome tracking"
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (RFP, RFI, RFQ) for procurement method analysis"
    - name: "spend_category"
      expr: spend_category
      comment: "Spend category for strategic sourcing alignment"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance and authorization tracking"
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month RFP was issued for procurement activity trending"
  measures:
    - name: "rfp_count"
      expr: COUNT(1)
      comment: "Total RFPs issued for procurement activity and strategic sourcing volume"
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of RFPs — measures procurement pipeline value"
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total awarded amounts — measures actual procurement commitment from competitive sourcing"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated RFP value for procurement sizing and resource planning"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of RFPs for procurement risk management"
    - name: "awarded_rfp_count"
      expr: SUM(CASE WHEN award_status = 'awarded' THEN 1 ELSE 0 END)
      comment: "Count of awarded RFPs for procurement conversion and cycle time analysis"
$$;