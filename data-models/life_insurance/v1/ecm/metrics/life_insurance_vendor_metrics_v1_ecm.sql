-- Metric views for domain: vendor | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`vendor_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic vendor spend analytics tracking total expenditure, budget variance, and payment efficiency across service categories and fiscal periods"
  source: "`life_insurance_ecm`.`vendor`.`spend`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend record"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the spend record"
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month of the spend record"
    - name: "service_category"
      expr: service_category
      comment: "Primary service category for spend classification"
    - name: "service_subcategory"
      expr: service_subcategory
      comment: "Detailed service subcategory for granular spend analysis"
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit responsible for the spend"
    - name: "spend_type"
      expr: spend_type
      comment: "Type of spend (e.g., operational, capital, project-based)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the spend"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the spend record"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status indicating financial close state"
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the spend period"
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the spend period"
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total vendor spend amount across all records"
    - name: "budget_allocation_amount"
      expr: SUM(CAST(budget_allocation_amount AS DOUBLE))
      comment: "Total budget allocated for vendor spend"
    - name: "budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs allocated)"
    - name: "avg_budget_variance_pct"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across spend records"
    - name: "accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total accrued spend not yet invoiced"
    - name: "actual_invoiced_amount"
      expr: SUM(CAST(actual_invoiced_amount AS DOUBLE))
      comment: "Total actual invoiced amount"
    - name: "spend_record_count"
      expr: COUNT(1)
      comment: "Number of spend records"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with spend activity"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Number of distinct vendor contracts with spend"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice processing and payment efficiency metrics tracking gross amounts, discounts, payment timeliness, and dispute rates"
  source: "`life_insurance_ecm`.`vendor`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit, debit)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with vendor"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, receipt, invoice)"
    - name: "service_category"
      expr: service_category
      comment: "Service category for the invoice"
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit responsible for the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "due_date"
      expr: due_date
      comment: "Payment due date"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance"
  measures:
    - name: "gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before adjustments"
    - name: "discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices"
    - name: "adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount (positive or negative)"
    - name: "tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after all adjustments"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of invoices that have been disputed"
    - name: "avg_line_items_per_invoice"
      expr: AVG(CAST(line_item_count AS DOUBLE))
      comment: "Average number of line items per invoice"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors invoicing"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`vendor_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor payment execution and cash management metrics tracking payment amounts, timing, reconciliation, and exception rates"
  source: "`life_insurance_ecm`.`vendor`.`vendor_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., regular, advance, final)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment execution"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for the payment"
    - name: "reconciled_flag"
      expr: reconciled_flag
      comment: "Whether the payment has been reconciled"
    - name: "void_flag"
      expr: void_flag
      comment: "Whether the payment has been voided"
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was executed"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment execution"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount in transaction currency"
    - name: "net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts"
    - name: "discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured on payments"
    - name: "withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount deducted"
    - name: "functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional currency"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments executed"
    - name: "voided_payment_count"
      expr: SUM(CASE WHEN void_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of payments that were voided"
    - name: "returned_payment_count"
      expr: SUM(CASE WHEN return_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of payments that were returned"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors paid"
    - name: "distinct_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of distinct invoices paid"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract portfolio management metrics tracking contract value, renewal rates, compliance flags, and lifecycle status"
  source: "`life_insurance_ecm`.`vendor`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the vendor contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract"
    - name: "service_category"
      expr: service_category
      comment: "Service category covered by the contract"
    - name: "procurement_method"
      expr: procurement_method
      comment: "Method used to procure the contract"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of payments under the contract"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the contract has regulatory compliance requirements"
    - name: "performance_sla_included_flag"
      expr: performance_sla_included_flag
      comment: "Whether the contract includes performance SLAs"
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the contract"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the contract became effective"
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date the contract expires"
    - name: "contract_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total value of all vendor contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average contract value"
    - name: "total_liability_cap"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total liability cap amount across contracts"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of vendor contracts"
    - name: "active_contract_count"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active vendor contracts"
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts with auto-renewal enabled"
    - name: "sla_contract_count"
      expr: SUM(CASE WHEN performance_sla_included_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts with performance SLAs"
    - name: "avg_amendment_count"
      expr: AVG(CAST(amendment_count AS DOUBLE))
      comment: "Average number of amendments per contract"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors under contract"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`vendor_sla_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA performance and compliance metrics tracking breach rates, variance, penalty amounts, and remediation effectiveness"
  source: "`life_insurance_ecm`.`vendor`.`sla_measurement`"
  dimensions:
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the SLA metric being measured"
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the SLA metric"
    - name: "sla_measurement_status"
      expr: sla_measurement_status
      comment: "Status of the SLA measurement"
    - name: "is_breach"
      expr: is_breach
      comment: "Whether the measurement represents an SLA breach"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the breach if applicable"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for breaches"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the measurement is disputed"
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Whether the breach is reportable to regulators"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for the measurement"
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start date of the measurement period"
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End date of the measurement period"
  measures:
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Total number of SLA measurements"
    - name: "breach_count"
      expr: SUM(CASE WHEN is_breach = TRUE THEN 1 ELSE 0 END)
      comment: "Number of SLA breaches"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value measured"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value for SLAs"
    - name: "avg_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average variance between actual and target"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed for breaches"
    - name: "disputed_measurement_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of disputed measurements"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN regulatory_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of measurements requiring regulatory reporting"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors measured"
    - name: "distinct_sla_agreement_count"
      expr: COUNT(DISTINCT sla_agreement_id)
      comment: "Number of distinct SLA agreements measured"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`vendor_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment and monitoring metrics tracking risk scores, tier distribution, remediation requirements, and assessment frequency"
  source: "`life_insurance_ecm`.`vendor`.`vendor_risk_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment conducted"
    - name: "inherent_risk_tier"
      expr: inherent_risk_tier
      comment: "Inherent risk tier before controls"
    - name: "residual_risk_tier"
      expr: residual_risk_tier
      comment: "Residual risk tier after controls"
    - name: "service_criticality"
      expr: service_criticality
      comment: "Criticality of the service provided by vendor"
    - name: "financial_risk_rating"
      expr: financial_risk_rating
      comment: "Financial risk rating of the vendor"
    - name: "cybersecurity_risk_rating"
      expr: cybersecurity_risk_rating
      comment: "Cybersecurity risk rating"
    - name: "operational_risk_rating"
      expr: operational_risk_rating
      comment: "Operational risk rating"
    - name: "regulatory_compliance_risk_rating"
      expr: regulatory_compliance_risk_rating
      comment: "Regulatory compliance risk rating"
    - name: "concentration_risk_rating"
      expr: concentration_risk_rating
      comment: "Concentration risk rating"
    - name: "remediation_required"
      expr: remediation_required
      comment: "Whether remediation is required"
    - name: "soc2_report_reviewed"
      expr: soc2_report_reviewed
      comment: "Whether SOC2 report has been reviewed"
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date the assessment was conducted"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of the assessment"
  measures:
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Total number of risk assessments"
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessments"
    - name: "high_risk_vendor_count"
      expr: SUM(CASE WHEN residual_risk_tier = 'High' THEN 1 ELSE 0 END)
      comment: "Number of vendors assessed as high residual risk"
    - name: "remediation_required_count"
      expr: SUM(CASE WHEN remediation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments requiring remediation"
    - name: "critical_service_vendor_count"
      expr: SUM(CASE WHEN service_criticality = 'Critical' THEN 1 ELSE 0 END)
      comment: "Number of vendors providing critical services"
    - name: "soc2_reviewed_count"
      expr: SUM(CASE WHEN soc2_report_reviewed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of assessments with SOC2 report reviewed"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors assessed"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`vendor_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor incident management and impact metrics tracking incident frequency, severity, financial impact, SLA breaches, and resolution time"
  source: "`life_insurance_ecm`.`vendor`.`incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the incident"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the incident caused an SLA breach"
    - name: "phi_exposed_flag"
      expr: phi_exposed_flag
      comment: "Whether PHI was exposed in the incident"
    - name: "pii_exposed_flag"
      expr: pii_exposed_flag
      comment: "Whether PII was exposed in the incident"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "contract_penalty_applicable_flag"
      expr: contract_penalty_applicable_flag
      comment: "Whether contract penalties apply"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring incident"
    - name: "incident_date"
      expr: incident_date
      comment: "Date the incident occurred"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the incident"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of vendor incidents"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of incidents"
    - name: "total_contract_penalty"
      expr: SUM(CAST(contract_penalty_amount AS DOUBLE))
      comment: "Total contract penalty amount assessed"
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average time to resolve incidents in hours"
    - name: "avg_vendor_response_time_hours"
      expr: AVG(CAST(vendor_response_time_hours AS DOUBLE))
      comment: "Average vendor response time in hours"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents causing SLA breaches"
    - name: "phi_exposure_count"
      expr: SUM(CASE WHEN phi_exposed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents with PHI exposure"
    - name: "pii_exposure_count"
      expr: SUM(CASE WHEN pii_exposed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents with PII exposure"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of incidents requiring regulatory reporting"
    - name: "recurring_incident_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recurring incidents"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with incidents"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`vendor_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance evaluation metrics tracking overall scores, compliance, quality, timeliness, and improvement action effectiveness"
  source: "`life_insurance_ecm`.`vendor`.`vendor_performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Current status of the performance review"
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review"
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall performance rating category"
    - name: "review_outcome"
      expr: review_outcome
      comment: "Outcome of the review"
    - name: "escalation_required"
      expr: escalation_required
      comment: "Whether escalation is required"
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Whether the review is reportable to regulators"
    - name: "reviewer_department"
      expr: reviewer_department
      comment: "Department conducting the review"
    - name: "review_date"
      expr: review_date
      comment: "Date the review was conducted"
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year of the review"
    - name: "review_period_start_date"
      expr: review_period_start_date
      comment: "Start date of the review period"
    - name: "review_period_end_date"
      expr: review_period_end_date
      comment: "End date of the review period"
  measures:
    - name: "review_count"
      expr: COUNT(1)
      comment: "Total number of performance reviews"
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall performance score"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score"
    - name: "avg_timeliness_score"
      expr: AVG(CAST(timeliness_score AS DOUBLE))
      comment: "Average timeliness score"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score"
    - name: "avg_cost_effectiveness_score"
      expr: AVG(CAST(cost_effectiveness_score AS DOUBLE))
      comment: "Average cost effectiveness score"
    - name: "avg_innovation_score"
      expr: AVG(CAST(innovation_score AS DOUBLE))
      comment: "Average innovation score"
    - name: "avg_risk_management_score"
      expr: AVG(CAST(risk_management_score AS DOUBLE))
      comment: "Average risk management score"
    - name: "avg_sla_compliance_pct"
      expr: AVG(CAST(sla_compliance_percentage AS DOUBLE))
      comment: "Average SLA compliance percentage"
    - name: "escalation_required_count"
      expr: SUM(CASE WHEN escalation_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews requiring escalation"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN is_regulatory_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews requiring regulatory reporting"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors reviewed"
$$;