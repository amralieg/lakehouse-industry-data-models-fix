-- Metric views for domain: vendor | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic vendor spend analytics tracking total expenditure, payment efficiency, and budget compliance across vendors, cost centers, and time periods. Enables procurement optimization and vendor portfolio management decisions."
  source: "`vibe_health_insurance_v1`.`vendor`.`spend`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend transaction for year-over-year trend analysis"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly spend tracking and budget cycle alignment"
    - name: "spend_category"
      expr: spend_category
      comment: "Spend category classification for category management and sourcing strategy"
    - name: "spend_status"
      expr: spend_status
      comment: "Current status of the spend transaction (approved, pending, disputed, paid)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for cash flow and payment optimization analysis"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether spend transaction meets compliance requirements"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for monthly spend trending and forecasting"
    - name: "approval_status"
      expr: CASE WHEN is_approved = TRUE THEN 'Approved' WHEN is_approved = FALSE THEN 'Not Approved' ELSE 'Pending' END
      comment: "Approval status for spend governance and control monitoring"
  measures:
    - name: "total_spend_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total vendor spend in USD - primary KPI for procurement budget management and vendor portfolio value"
    - name: "total_spend_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net spend amount after discounts and adjustments in original currency"
    - name: "total_spend_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross spend amount before discounts in original currency"
    - name: "total_discount_amount"
      expr: SUM(CAST(amount_discount AS DOUBLE))
      comment: "Total discount amount captured - measures procurement negotiation effectiveness"
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax amount for tax planning and compliance reporting"
    - name: "avg_spend_per_transaction"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average spend per transaction - indicates transaction size patterns and procurement efficiency"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of spend transactions for volume analysis and process efficiency"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with spend - measures vendor portfolio concentration and diversification"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_discount AS DOUBLE)) / NULLIF(SUM(CAST(amount_gross AS DOUBLE)), 0), 2)
      comment: "Percentage of gross spend captured as discounts - key procurement performance indicator"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliant spend transactions - critical for regulatory and policy adherence"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_approved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approved spend transactions - measures spend governance effectiveness"
    - name: "avg_payment_cycle_days"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average days from invoice to payment - measures payment efficiency and working capital management"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract portfolio analytics tracking contract value, renewal risk, compliance status, and lifecycle management. Supports strategic vendor relationship management and contract optimization decisions."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_contract`"
  dimensions:
    - name: "vendor_contract_status"
      expr: vendor_contract_status
      comment: "Current contract status for active contract portfolio management"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract for category-specific contract management"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates if contract auto-renews - critical for renewal risk management"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year of contract expiration for multi-year renewal planning"
    - name: "expiration_quarter"
      expr: CONCAT('Q', QUARTER(expiration_date), '-', YEAR(expiration_date))
      comment: "Quarter of contract expiration for quarterly renewal pipeline management"
    - name: "contract_age_bucket"
      expr: CASE WHEN DATEDIFF(CURRENT_DATE(), effective_date) < 365 THEN '0-1 Year' WHEN DATEDIFF(CURRENT_DATE(), effective_date) < 1095 THEN '1-3 Years' WHEN DATEDIFF(CURRENT_DATE(), effective_date) < 1825 THEN '3-5 Years' ELSE '5+ Years' END
      comment: "Contract age bucket for portfolio maturity analysis and refresh planning"
    - name: "renewal_risk_flag"
      expr: CASE WHEN DATEDIFF(expiration_date, CURRENT_DATE()) <= 90 AND auto_renewal_flag = FALSE THEN TRUE ELSE FALSE END
      comment: "High-priority renewal risk indicator for contracts expiring within 90 days without auto-renewal"
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Contract confidentiality level for information security and access control"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all vendor contracts - primary KPI for contract portfolio financial exposure"
    - name: "annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Total annual contract value - measures recurring annual vendor commitment"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value - indicates typical contract size and vendor relationship scale"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of vendor contracts for portfolio complexity and management workload"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors under contract - measures vendor relationship breadth"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with auto-renewal - measures renewal automation and risk exposure"
    - name: "contracts_expiring_90_days"
      expr: SUM(CASE WHEN DATEDIFF(expiration_date, CURRENT_DATE()) <= 90 AND DATEDIFF(expiration_date, CURRENT_DATE()) >= 0 THEN 1 ELSE 0 END)
      comment: "Count of contracts expiring in next 90 days - critical for proactive renewal management"
    - name: "value_expiring_90_days"
      expr: SUM(CASE WHEN DATEDIFF(expiration_date, CURRENT_DATE()) <= 90 AND DATEDIFF(expiration_date, CURRENT_DATE()) >= 0 THEN CAST(total_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value expiring in next 90 days - measures near-term renewal financial risk"
    - name: "avg_contract_duration_days"
      expr: AVG(CAST(DATEDIFF(expiration_date, effective_date) AS DOUBLE))
      comment: "Average contract duration in days - indicates typical contract term length and commitment horizon"
    - name: "amendment_intensity"
      expr: AVG(CAST(amendment_count AS DOUBLE))
      comment: "Average number of amendments per contract - measures contract stability and change frequency"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance evaluation analytics tracking quality, delivery, SLA compliance, and overall vendor effectiveness. Enables data-driven vendor selection, tier management, and relationship optimization."
  source: "`vibe_health_insurance_v1`.`vendor`.`performance`"
  dimensions:
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "Evaluation period (monthly, quarterly, annual) for time-based performance trending"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of performance evaluation (completed, in-progress, pending)"
    - name: "performance_status"
      expr: performance_status
      comment: "Overall performance status classification for vendor tier management"
    - name: "tier_decision"
      expr: tier_decision
      comment: "Vendor tier assignment based on performance for strategic vendor segmentation"
    - name: "evaluation_year"
      expr: YEAR(evaluation_start_date)
      comment: "Year of evaluation for year-over-year performance comparison"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', QUARTER(evaluation_start_date), '-', YEAR(evaluation_start_date))
      comment: "Quarter of evaluation for quarterly performance tracking"
    - name: "performance_tier"
      expr: CASE WHEN overall_score >= 90 THEN 'Excellent' WHEN overall_score >= 75 THEN 'Good' WHEN overall_score >= 60 THEN 'Acceptable' ELSE 'Poor' END
      comment: "Performance tier based on overall score for vendor classification and action planning"
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall vendor performance score - primary KPI for vendor quality and effectiveness"
    - name: "avg_sla_compliance_rate"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate - measures vendor reliability and contract adherence"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate - critical operational performance indicator"
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate - measures product/service quality and vendor capability"
    - name: "avg_customer_satisfaction"
      expr: AVG(CAST(customer_satisfaction_rating AS DOUBLE))
      comment: "Average customer satisfaction rating - measures stakeholder experience with vendor"
    - name: "avg_financial_stability"
      expr: AVG(CAST(financial_stability_rating AS DOUBLE))
      comment: "Average financial stability rating - assesses vendor business continuity risk"
    - name: "avg_issue_resolution_time"
      expr: AVG(CAST(issue_resolution_time_days AS DOUBLE))
      comment: "Average issue resolution time in days - measures vendor responsiveness and support quality"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average vendor risk assessment score - indicates portfolio risk exposure"
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of performance evaluations for evaluation coverage and frequency analysis"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated - measures performance management program reach"
    - name: "high_performer_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_score >= 90 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations with excellent performance (90+) - measures vendor portfolio quality"
    - name: "poor_performer_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_score < 60 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations with poor performance (<60) - identifies vendor improvement or exit candidates"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment analytics tracking cybersecurity, financial stability, compliance, and overall vendor risk exposure. Supports enterprise risk management and vendor due diligence decisions."
  source: "`vibe_health_insurance_v1`.`vendor`.`risk_assessment`"
  dimensions:
    - name: "risk_tier"
      expr: risk_tier
      comment: "Vendor risk tier classification (high, medium, low) for risk-based vendor management"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (initial, periodic, event-driven) for assessment program management"
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Current status of risk assessment for assessment pipeline tracking"
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls - measures effectiveness of risk mitigation"
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls - measures baseline vendor risk exposure"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of risk assessment for multi-year risk trend analysis"
    - name: "assessment_quarter"
      expr: CONCAT('Q', QUARTER(assessment_date), '-', YEAR(assessment_date))
      comment: "Quarter of risk assessment for quarterly risk reporting"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates regulatory compliance status - critical for regulated industry vendor management"
    - name: "concentration_risk_flag"
      expr: concentration_risk_flag
      comment: "Indicates vendor concentration risk - identifies single points of failure"
    - name: "reputational_risk_flag"
      expr: reputational_risk_flag
      comment: "Indicates reputational risk exposure - measures brand and reputation impact"
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average overall vendor risk score - primary KPI for enterprise vendor risk exposure"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(overall_residual_score AS DOUBLE))
      comment: "Average residual risk score after controls - measures risk mitigation effectiveness"
    - name: "avg_cybersecurity_score"
      expr: AVG(CAST(cybersecurity_score AS DOUBLE))
      comment: "Average cybersecurity risk score - critical for data security and breach prevention"
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score - measures vendor business continuity risk"
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score - measures compliance risk exposure"
    - name: "avg_business_continuity_score"
      expr: AVG(CAST(business_continuity_score AS DOUBLE))
      comment: "Average business continuity score - assesses vendor operational resilience"
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Total number of risk assessments for assessment program coverage and activity"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors assessed - measures risk assessment program reach"
    - name: "high_risk_vendor_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_tier = 'High' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of high-risk vendors - measures portfolio risk concentration requiring mitigation"
    - name: "regulatory_noncompliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors with regulatory compliance issues - critical compliance risk indicator"
    - name: "concentration_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN concentration_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors with concentration risk - identifies vendor diversification needs"
    - name: "reputational_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reputational_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors with reputational risk - measures brand protection exposure"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice processing analytics tracking invoice volume, payment efficiency, dispute rates, and accounts payable performance. Enables working capital optimization and AP process improvement."
  source: "`vibe_health_insurance_v1`.`vendor`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current invoice status for invoice pipeline and aging analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval status for approval workflow efficiency tracking"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for cash flow and payment tracking"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates disputed invoices - critical for vendor relationship and payment issue management"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice for monthly AP volume and trend analysis"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice for year-over-year AP comparison"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for payment channel optimization"
    - name: "early_payment_discount_flag"
      expr: is_early_payment_discount
      comment: "Indicates early payment discount availability - measures discount capture opportunity"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates tax-exempt invoices for tax compliance and reporting"
    - name: "compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates regulatory compliance status for compliant AP processing"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoice amount - primary KPI for accounts payable financial exposure"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts - measures actual payment obligation"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured - measures early payment and negotiation savings"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax liability tracking and compliance"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount - indicates typical invoice size and payment patterns"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices for AP volume and processing workload analysis"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors invoicing - measures vendor payment portfolio breadth"
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputed invoices - measures invoice quality and vendor relationship issues"
    - name: "early_payment_discount_capture_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_early_payment_discount = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices with early payment discount captured - measures working capital optimization"
    - name: "avg_payment_cycle_days"
      expr: AVG(CAST(DATEDIFF(payment_date, invoice_date) AS DOUBLE))
      comment: "Average days from invoice to payment - key working capital and vendor relationship metric"
    - name: "avg_approval_cycle_days"
      expr: AVG(CAST(DATEDIFF(approved_timestamp, created_timestamp) AS DOUBLE))
      comment: "Average days from invoice receipt to approval - measures AP process efficiency"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliant invoices - critical for regulatory adherence and audit readiness"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master data analytics tracking vendor portfolio composition, diversity, risk profile, and relationship status. Supports strategic vendor portfolio management and supplier diversity initiatives."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current vendor status for active vendor portfolio management"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor for category-specific vendor management"
    - name: "tier"
      expr: tier
      comment: "Vendor tier classification for strategic vendor segmentation"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Vendor onboarding status for new vendor pipeline tracking"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Vendor compliance status for regulatory and policy adherence"
    - name: "minority_owned_flag"
      expr: minority_owned_flag
      comment: "Indicates minority-owned business - critical for supplier diversity programs"
    - name: "women_owned_flag"
      expr: women_owned_flag
      comment: "Indicates women-owned business - supports supplier diversity and inclusion goals"
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Indicates small business - enables small business procurement tracking"
    - name: "business_category"
      expr: business_category
      comment: "Business category classification for industry-specific vendor analysis"
    - name: "relationship_tenure_bucket"
      expr: CASE WHEN DATEDIFF(CURRENT_DATE(), relationship_start_date) < 365 THEN '0-1 Year' WHEN DATEDIFF(CURRENT_DATE(), relationship_start_date) < 1095 THEN '1-3 Years' WHEN DATEDIFF(CURRENT_DATE(), relationship_start_date) < 1825 THEN '3-5 Years' ELSE '5+ Years' END
      comment: "Vendor relationship tenure bucket for relationship maturity analysis"
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors - primary KPI for vendor portfolio size and complexity"
    - name: "active_vendor_count"
      expr: SUM(CASE WHEN vendor_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active vendors - measures current vendor portfolio scale"
    - name: "minority_owned_count"
      expr: SUM(CASE WHEN minority_owned_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of minority-owned vendors - tracks supplier diversity program progress"
    - name: "women_owned_count"
      expr: SUM(CASE WHEN women_owned_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of women-owned vendors - measures women-owned business engagement"
    - name: "small_business_count"
      expr: SUM(CASE WHEN small_business_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of small business vendors - tracks small business procurement participation"
    - name: "diversity_vendor_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN minority_owned_flag = TRUE OR women_owned_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diverse vendors (minority or women-owned) - key supplier diversity metric"
    - name: "small_business_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN small_business_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of small business vendors - measures small business procurement commitment"
    - name: "compliant_vendor_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliant vendors - critical for regulatory and policy adherence"
    - name: "avg_relationship_tenure_days"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), relationship_start_date) AS DOUBLE))
      comment: "Average vendor relationship tenure in days - measures relationship stability and maturity"
    - name: "strategic_vendor_count"
      expr: SUM(CASE WHEN tier = 'Strategic' THEN 1 ELSE 0 END)
      comment: "Number of strategic tier vendors - identifies key vendor relationships requiring executive attention"
    - name: "strategic_vendor_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tier = 'Strategic' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of strategic vendors - measures portfolio concentration on high-value relationships"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_baa_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business Associate Agreement (BAA) analytics critical for HIPAA compliance in health insurance. Tracks BAA execution, compliance status, breach notification obligations, and risk assessment across the vendor portfolio."
  source: "`vibe_health_insurance_v1`.`vendor`.`baa_agreement`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor incident and breach analytics tracking PHI breaches, severity, member impact, and resolution. Critical for HIPAA breach notification compliance, regulatory reporting, and vendor risk management in health insurance."
  source: "`vibe_health_insurance_v1`.`vendor`.`incident`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor onboarding analytics tracking onboarding volume, cost, compliance checklist completion, and risk assessment. Critical for vendor intake efficiency, due diligence completeness, and time-to-value optimization."
  source: "`vibe_health_insurance_v1`.`vendor`.`onboarding`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order analytics covering order volumes, amounts, payment performance, and procurement efficiency. Supports procurement operations, budget management, and vendor payment optimization for health insurance operations."
  source: "`vibe_health_insurance_v1`.`vendor`.`purchase_order`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_rfp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP (Request for Proposal) analytics tracking solicitation volumes, award amounts, competitive participation, and procurement cycle management for strategic sourcing in health insurance."
  source: "`vibe_health_insurance_v1`.`vendor`.`rfp`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment analytics covering cybersecurity, financial stability, business continuity, and regulatory compliance scores. Critical for HIPAA compliance, PHI protection, and enterprise risk management in health insurance."
  source: "`vibe_health_insurance_v1`.`vendor`.`risk_assessment`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_sla_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA event analytics tracking vendor service level compliance, breaches, penalties, and variance from targets. Essential for vendor accountability, contract enforcement, and service quality management in health insurance operations."
  source: "`vibe_health_insurance_v1`.`vendor`.`sla_event`"
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

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor audit analytics tracking audit completion, findings, costs, and compliance framework adherence. Essential for HIPAA compliance oversight, vendor governance, and regulatory audit readiness in health insurance."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (HIPAA, SOC2, financial, operational) for compliance program tracking"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating (satisfactory, needs improvement, unsatisfactory) for vendor compliance scoring"
    - name: "corrective_action_required"
      expr: CAST(corrective_action_required AS STRING)
      comment: "Whether corrective actions are required — triggers remediation tracking"
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total vendor audits conducted for governance program completeness"
    - name: "corrective_action_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring corrective action — measures vendor compliance gap severity"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors audited for audit coverage analysis"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor dispute analytics tracking dispute volumes, amounts, resolution, and escalation patterns. Critical for vendor relationship management, financial exposure control, and operational risk mitigation."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_dispute`"
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