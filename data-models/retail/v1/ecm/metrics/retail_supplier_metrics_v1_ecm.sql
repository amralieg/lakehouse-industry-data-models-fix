-- Metric views for domain: supplier | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vendor performance and operational metrics tracking vendor health, compliance, and relationship quality"
  source: "`retail_ecm`.`supplier`.`vendor`"
  dimensions:
    - name: "vendor_name"
      expr: vendor_name
      comment: "Legal or trade name of the vendor"
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current operational status of the vendor (active, inactive, suspended)"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of vendor (manufacturer, distributor, service provider)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Current risk tier assigned to vendor (low, medium, high, critical)"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Standard payment terms negotiated with vendor"
    - name: "currency_code"
      expr: currency_code
      comment: "Primary currency for vendor transactions"
    - name: "diversity_certification"
      expr: diversity_certification
      comment: "Diversity supplier certification status (MBE, WBE, SDVOSB, etc.)"
    - name: "sustainability_certified"
      expr: CASE WHEN sustainability_certified_flag = TRUE THEN 'Certified' ELSE 'Not Certified' END
      comment: "Whether vendor holds sustainability certifications"
    - name: "edi_capable"
      expr: CASE WHEN edi_capable_flag = TRUE THEN 'EDI Enabled' ELSE 'Manual' END
      comment: "Whether vendor supports EDI transactions"
    - name: "vmi_enabled"
      expr: CASE WHEN vmi_enabled_flag = TRUE THEN 'VMI' ELSE 'Standard' END
      comment: "Whether vendor participates in vendor-managed inventory program"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year vendor was onboarded"
    - name: "onboarding_quarter"
      expr: CONCAT('Q', QUARTER(onboarding_date), '-', YEAR(onboarding_date))
      comment: "Quarter and year vendor was onboarded"
    - name: "contract_expiry_year"
      expr: YEAR(contract_expiry_date)
      comment: "Year current contract expires"
  measures:
    - name: "total_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Total unique vendor count for portfolio sizing and concentration analysis"
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across vendors measuring order fulfillment completeness"
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate percentage measuring schedule adherence"
    - name: "avg_quality_acceptance_rate_pct"
      expr: AVG(CAST(quality_acceptance_rate_pct AS DOUBLE))
      comment: "Average quality acceptance rate percentage measuring defect-free delivery performance"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days from order to delivery across vendor base"
    - name: "avg_moq_units"
      expr: AVG(CAST(moq_units AS DOUBLE))
      comment: "Average minimum order quantity in units indicating vendor flexibility"
    - name: "edi_capable_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN vendor_id END)
      comment: "Count of vendors with EDI capability for automation readiness assessment"
    - name: "vmi_enabled_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN vendor_id END)
      comment: "Count of vendors participating in VMI programs for inventory optimization"
    - name: "sustainability_certified_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certified_flag = TRUE THEN vendor_id END)
      comment: "Count of sustainability-certified vendors for ESG reporting"
    - name: "high_risk_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('High', 'Critical') THEN vendor_id END)
      comment: "Count of vendors in high or critical risk tiers requiring mitigation action"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard metrics tracking composite scores, KPI trends, and corrective actions for supplier relationship management"
  source: "`retail_ecm`.`supplier`.`vendor_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Current status of the scorecard evaluation (draft, published, acknowledged)"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Performance tier assigned to vendor (platinum, gold, silver, bronze, probation)"
    - name: "score_trend"
      expr: score_trend
      comment: "Trend direction of vendor performance (improving, stable, declining)"
    - name: "corrective_action_required"
      expr: CASE WHEN corrective_action_required = TRUE THEN 'Action Required' ELSE 'No Action' END
      comment: "Whether vendor requires corrective action plan"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year of scorecard evaluation"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', QUARTER(evaluation_date), '-', YEAR(evaluation_date))
      comment: "Quarter and year of scorecard evaluation"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of scorecard evaluation for trending"
    - name: "scoring_period_year"
      expr: YEAR(scoring_period_start_date)
      comment: "Year of the scoring period being evaluated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial metrics in scorecard"
  measures:
    - name: "total_scorecards"
      expr: COUNT(DISTINCT vendor_scorecard_id)
      comment: "Total scorecard evaluations for volume and coverage tracking"
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite performance score across all evaluated vendors"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate from scorecard evaluations"
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate from scorecard evaluations measuring order completeness"
    - name: "avg_product_quality_score"
      expr: AVG(CAST(product_quality_score AS DOUBLE))
      comment: "Average product quality score measuring defect rates and acceptance"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate measuring billing quality"
    - name: "avg_edi_compliance_rate"
      expr: AVG(CAST(edi_compliance_rate AS DOUBLE))
      comment: "Average EDI compliance rate measuring transaction automation quality"
    - name: "avg_lead_time_adherence_rate"
      expr: AVG(CAST(lead_time_adherence_rate AS DOUBLE))
      comment: "Average lead time adherence rate measuring schedule predictability"
    - name: "avg_moq_compliance_rate"
      expr: AVG(CAST(minimum_order_quantity_compliance_rate AS DOUBLE))
      comment: "Average MOQ compliance rate measuring adherence to minimum order requirements"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback penalties assessed for non-compliance and quality issues"
    - name: "total_chargeback_count"
      expr: SUM(CAST(chargeback_count AS DOUBLE))
      comment: "Total count of chargeback incidents across all scorecards"
    - name: "total_rtv_amount"
      expr: SUM(CAST(return_to_vendor_amount AS DOUBLE))
      comment: "Total value of goods returned to vendors due to quality or compliance issues"
    - name: "total_rtv_count"
      expr: SUM(CAST(return_to_vendor_count AS DOUBLE))
      comment: "Total count of return-to-vendor incidents"
    - name: "total_purchase_order_value"
      expr: SUM(CAST(total_purchase_order_value AS DOUBLE))
      comment: "Total purchase order value during scoring period for spend analysis"
    - name: "total_purchase_order_count"
      expr: SUM(CAST(total_purchase_order_count AS DOUBLE))
      comment: "Total purchase order count during scoring period for transaction volume"
    - name: "corrective_action_required_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN vendor_scorecard_id END)
      comment: "Count of scorecards requiring corrective action plans"
    - name: "avg_prior_period_composite_score"
      expr: AVG(CAST(prior_period_composite_score AS DOUBLE))
      comment: "Average prior period composite score for trend comparison"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor chargeback and penalty metrics tracking compliance violations, financial impact, and dispute resolution for supplier accountability"
  source: "`retail_ecm`.`supplier`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of chargeback (pending, approved, disputed, resolved, cancelled)"
    - name: "chargeback_type"
      expr: chargeback_type
      comment: "Type of chargeback (quality, delivery, compliance, documentation)"
    - name: "violation_category"
      expr: violation_category
      comment: "Category of violation triggering chargeback (routing, labeling, ASN, quality)"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of vendor dispute if chargeback is contested"
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover chargeback amount (debit memo, offset, credit)"
    - name: "penalty_calculation_method"
      expr: penalty_calculation_method
      comment: "Method used to calculate penalty (flat fee, percentage, tiered)"
    - name: "is_repeat_violation"
      expr: CASE WHEN is_repeat_violation = TRUE THEN 'Repeat' ELSE 'First Time' END
      comment: "Whether this is a repeat violation by the vendor"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for chargeback amounts"
    - name: "violation_year"
      expr: YEAR(violation_date)
      comment: "Year violation occurred"
    - name: "violation_quarter"
      expr: CONCAT('Q', QUARTER(violation_date), '-', YEAR(violation_date))
      comment: "Quarter and year violation occurred"
    - name: "violation_month"
      expr: DATE_TRUNC('MONTH', violation_date)
      comment: "Month violation occurred for trending"
    - name: "detection_year"
      expr: YEAR(detection_date)
      comment: "Year violation was detected"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year chargeback was approved"
  measures:
    - name: "total_chargebacks"
      expr: COUNT(DISTINCT chargeback_id)
      comment: "Total count of chargeback incidents for compliance monitoring"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties assessed against vendors for violations"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per chargeback incident"
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty percentage applied to transaction value"
    - name: "total_vendor_scorecard_impact"
      expr: SUM(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Total scorecard points deducted due to chargebacks"
    - name: "avg_vendor_scorecard_impact"
      expr: AVG(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Average scorecard impact per chargeback for performance tracking"
    - name: "disputed_chargeback_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'None' THEN chargeback_id END)
      comment: "Count of chargebacks disputed by vendors"
    - name: "repeat_violation_count"
      expr: COUNT(DISTINCT CASE WHEN is_repeat_violation = TRUE THEN chargeback_id END)
      comment: "Count of repeat violations indicating systemic vendor issues"
    - name: "resolved_chargeback_count"
      expr: COUNT(DISTINCT CASE WHEN chargeback_status = 'Resolved' THEN chargeback_id END)
      comment: "Count of resolved chargebacks for closure rate tracking"
    - name: "approved_chargeback_count"
      expr: COUNT(DISTINCT CASE WHEN chargeback_status = 'Approved' THEN chargeback_id END)
      comment: "Count of approved chargebacks ready for recovery"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor dispute resolution metrics tracking dispute volume, aging, financial impact, and resolution effectiveness for vendor relationship management"
  source: "`retail_ecm`.`supplier`.`vendor_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of dispute (open, under review, resolved, escalated, closed)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (pricing, quality, delivery, invoice, chargeback)"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of dispute for root cause analysis"
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Standardized reason code for dispute"
    - name: "resolution_decision"
      expr: resolution_decision
      comment: "Final decision on dispute (vendor favor, retailer favor, split, withdrawn)"
    - name: "escalation_flag"
      expr: CASE WHEN escalation_flag = TRUE THEN 'Escalated' ELSE 'Standard' END
      comment: "Whether dispute was escalated to senior management"
    - name: "dispute_submission_channel"
      expr: dispute_submission_channel
      comment: "Channel through which dispute was submitted (portal, email, phone, EDI)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for disputed amounts"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for dispute resolution"
    - name: "submission_year"
      expr: YEAR(dispute_submission_date)
      comment: "Year dispute was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(dispute_submission_date), '-', YEAR(dispute_submission_date))
      comment: "Quarter and year dispute was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', dispute_submission_date)
      comment: "Month dispute was submitted for trending"
    - name: "closure_year"
      expr: YEAR(dispute_closure_date)
      comment: "Year dispute was closed"
  measures:
    - name: "total_disputes"
      expr: COUNT(DISTINCT vendor_dispute_id)
      comment: "Total count of vendor disputes for volume tracking and trend analysis"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute impacting cash flow and working capital"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case for materiality assessment"
    - name: "total_approved_credit_amount"
      expr: SUM(CAST(approved_credit_amount AS DOUBLE))
      comment: "Total credit amount approved in vendor favor impacting P&L"
    - name: "avg_approved_credit_amount"
      expr: AVG(CAST(approved_credit_amount AS DOUBLE))
      comment: "Average approved credit per dispute for resolution cost analysis"
    - name: "avg_aging_days"
      expr: AVG(CAST(aging_days AS DOUBLE))
      comment: "Average days disputes remain open measuring resolution efficiency"
    - name: "escalated_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN vendor_dispute_id END)
      comment: "Count of escalated disputes requiring senior management intervention"
    - name: "resolved_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status = 'Resolved' THEN vendor_dispute_id END)
      comment: "Count of resolved disputes for closure rate calculation"
    - name: "open_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IN ('Open', 'Under Review') THEN vendor_dispute_id END)
      comment: "Count of open disputes requiring action"
    - name: "vendor_favor_resolution_count"
      expr: COUNT(DISTINCT CASE WHEN resolution_decision = 'Vendor Favor' THEN vendor_dispute_id END)
      comment: "Count of disputes resolved in vendor favor for fairness assessment"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract management metrics tracking contract value, terms, compliance features, and renewal status for procurement governance"
  source: "`retail_ecm`.`supplier`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of contract (active, expired, pending, terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (master, spot, blanket, framework)"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms negotiated in contract"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified in contract (ACH, wire, check, card)"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms defining delivery responsibility"
    - name: "contract_currency_code"
      expr: contract_currency_code
      comment: "Currency for contract financial terms"
    - name: "auto_renewal"
      expr: CASE WHEN auto_renewal_flag = TRUE THEN 'Auto-Renew' ELSE 'Manual Renewal' END
      comment: "Whether contract automatically renews"
    - name: "exclusivity"
      expr: CASE WHEN exclusivity_flag = TRUE THEN 'Exclusive' ELSE 'Non-Exclusive' END
      comment: "Whether contract grants exclusivity to vendor"
    - name: "edi_enabled"
      expr: CASE WHEN edi_enabled_flag = TRUE THEN 'EDI' ELSE 'Manual' END
      comment: "Whether contract includes EDI transaction capability"
    - name: "vmi_enabled"
      expr: CASE WHEN vmi_enabled_flag = TRUE THEN 'VMI' ELSE 'Standard' END
      comment: "Whether contract includes vendor-managed inventory terms"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year contract became effective"
    - name: "expiry_year"
      expr: YEAR(effective_end_date)
      comment: "Year contract expires"
    - name: "signature_year"
      expr: YEAR(signature_date)
      comment: "Year contract was signed"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Total count of vendor contracts for portfolio management"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total committed contract value across vendor portfolio"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average contract value for spend concentration analysis"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated across contracts"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time days specified in contracts"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts"
    - name: "avg_renewal_term_months"
      expr: AVG(CAST(renewal_term_months AS DOUBLE))
      comment: "Average renewal term length in months"
    - name: "avg_termination_notice_days"
      expr: AVG(CAST(termination_notice_days AS DOUBLE))
      comment: "Average termination notice period in days"
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN vendor_contract_id END)
      comment: "Count of active contracts for current portfolio size"
    - name: "auto_renewal_contract_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN vendor_contract_id END)
      comment: "Count of contracts with auto-renewal for renewal planning"
    - name: "edi_enabled_contract_count"
      expr: COUNT(DISTINCT CASE WHEN edi_enabled_flag = TRUE THEN vendor_contract_id END)
      comment: "Count of EDI-enabled contracts for automation coverage"
    - name: "vmi_enabled_contract_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN vendor_contract_id END)
      comment: "Count of VMI-enabled contracts for inventory optimization"
    - name: "exclusive_contract_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN vendor_contract_id END)
      comment: "Count of exclusive contracts for sourcing risk assessment"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment metrics tracking multi-dimensional risk scores, mitigation status, and assessment coverage for supply chain resilience"
  source: "`retail_ecm`.`supplier`.`risk_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of risk assessment (draft, completed, approved, expired)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (initial, periodic, event-driven, renewal)"
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Overall risk tier assigned to vendor (low, medium, high, critical)"
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of risk mitigation actions (not started, in progress, completed)"
    - name: "third_party_assessment"
      expr: CASE WHEN third_party_assessment_flag = TRUE THEN 'Third Party' ELSE 'Internal' END
      comment: "Whether assessment was conducted by third party"
    - name: "risk_scoring_methodology"
      expr: risk_scoring_methodology
      comment: "Methodology used for risk scoring"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year assessment was conducted"
    - name: "assessment_quarter"
      expr: CONCAT('Q', QUARTER(assessment_date), '-', YEAR(assessment_date))
      comment: "Quarter and year assessment was conducted"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month assessment was conducted for trending"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year assessment was approved"
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT risk_assessment_id)
      comment: "Total count of risk assessments for coverage tracking"
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across vendor portfolio"
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score measuring vendor solvency risk"
    - name: "avg_compliance_risk_score"
      expr: AVG(CAST(compliance_risk_score AS DOUBLE))
      comment: "Average compliance risk score measuring regulatory and policy adherence"
    - name: "avg_quality_risk_score"
      expr: AVG(CAST(quality_risk_score AS DOUBLE))
      comment: "Average quality risk score measuring product defect and recall risk"
    - name: "avg_supply_continuity_risk_score"
      expr: AVG(CAST(supply_continuity_risk_score AS DOUBLE))
      comment: "Average supply continuity risk score measuring disruption likelihood"
    - name: "avg_cybersecurity_risk_score"
      expr: AVG(CAST(cybersecurity_risk_score AS DOUBLE))
      comment: "Average cybersecurity risk score measuring data breach and system vulnerability"
    - name: "avg_esg_risk_score"
      expr: AVG(CAST(esg_risk_score AS DOUBLE))
      comment: "Average ESG risk score measuring environmental, social, governance risk"
    - name: "avg_geopolitical_risk_score"
      expr: AVG(CAST(geopolitical_risk_score AS DOUBLE))
      comment: "Average geopolitical risk score measuring country and regional instability"
    - name: "avg_single_source_dependency_score"
      expr: AVG(CAST(single_source_dependency_score AS DOUBLE))
      comment: "Average single-source dependency score measuring concentration risk"
    - name: "avg_risk_appetite_threshold"
      expr: AVG(CAST(risk_appetite_threshold AS DOUBLE))
      comment: "Average risk appetite threshold for risk tolerance benchmarking"
    - name: "high_risk_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN overall_risk_tier IN ('High', 'Critical') THEN risk_assessment_id END)
      comment: "Count of high or critical risk assessments requiring mitigation"
    - name: "mitigation_required_count"
      expr: COUNT(DISTINCT CASE WHEN mitigation_actions_required IS NOT NULL AND mitigation_actions_required != '' THEN risk_assessment_id END)
      comment: "Count of assessments requiring mitigation actions"
    - name: "third_party_assessment_count"
      expr: COUNT(DISTINCT CASE WHEN third_party_assessment_flag = TRUE THEN risk_assessment_id END)
      comment: "Count of third-party assessments for independent validation coverage"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_vendor_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor allowance and trade promotion metrics tracking accruals, claims, settlements, and promotional funding for margin management"
  source: "`retail_ecm`.`supplier`.`vendor_allowance`"
  dimensions:
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of allowance (promotional, volume, markdown, slotting, advertising)"
    - name: "allowance_status"
      expr: allowance_status
      comment: "Current status of allowance (active, expired, suspended, cancelled)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of allowance (pending, approved, rejected)"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of allowance (open, partially settled, fully settled)"
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue allowance (scan-based, invoice-based, lump sum)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of allowance payment (check-back, credit memo, offset)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for allowance amounts"
    - name: "product_category"
      expr: product_category
      comment: "Product category covered by allowance"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year allowance became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter and year allowance became effective"
    - name: "redemption_year"
      expr: YEAR(redemption_start_date)
      comment: "Year allowance redemption period started"
  measures:
    - name: "total_allowances"
      expr: COUNT(DISTINCT vendor_allowance_id)
      comment: "Total count of vendor allowances for program coverage tracking"
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total allowance amount committed by vendors for margin funding"
    - name: "avg_allowance_amount"
      expr: AVG(CAST(allowance_amount AS DOUBLE))
      comment: "Average allowance amount per program"
    - name: "avg_allowance_percentage"
      expr: AVG(CAST(allowance_percentage AS DOUBLE))
      comment: "Average allowance percentage of transaction value"
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total accrued allowance amount for balance sheet liability tracking"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total claimed allowance amount for cash flow forecasting"
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total settled allowance amount for actual margin realization"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed allowance amount requiring resolution"
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount to qualify for allowance"
    - name: "avg_minimum_purchase_quantity"
      expr: AVG(CAST(minimum_purchase_quantity AS DOUBLE))
      comment: "Average minimum purchase quantity to qualify for allowance"
    - name: "approved_allowance_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN vendor_allowance_id END)
      comment: "Count of approved allowances ready for accrual"
    - name: "fully_settled_allowance_count"
      expr: COUNT(DISTINCT CASE WHEN settlement_status = 'Fully Settled' THEN vendor_allowance_id END)
      comment: "Count of fully settled allowances for closure rate"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_rtv_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return-to-vendor request metrics tracking return volume, value, reasons, and financial recovery for quality and compliance management"
  source: "`retail_ecm`.`supplier`.`rtv_request`"
  dimensions:
    - name: "rtv_status"
      expr: rtv_status
      comment: "Current status of RTV request (pending, approved, shipped, received, credited, rejected)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for return"
    - name: "return_reason_description"
      expr: return_reason_description
      comment: "Detailed description of return reason"
    - name: "disposition_method"
      expr: disposition_method
      comment: "Method of product disposition (return, destroy, donate, rework)"
    - name: "freight_responsibility"
      expr: freight_responsibility
      comment: "Party responsible for freight cost (vendor, retailer, shared)"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of quality inspection (pass, fail, conditional)"
    - name: "is_recall_related"
      expr: CASE WHEN is_recall_related = TRUE THEN 'Recall' ELSE 'Standard' END
      comment: "Whether return is related to product recall"
    - name: "quality_inspection_required"
      expr: CASE WHEN quality_inspection_required = TRUE THEN 'Inspection Required' ELSE 'No Inspection' END
      comment: "Whether quality inspection is required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for return financial values"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Carrier handling return shipment"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year RTV request was created"
    - name: "request_quarter"
      expr: CONCAT('Q', QUARTER(request_date), '-', YEAR(request_date))
      comment: "Quarter and year RTV request was created"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month RTV request was created for trending"
    - name: "authorization_year"
      expr: YEAR(authorization_date)
      comment: "Year RTV was authorized"
  measures:
    - name: "total_rtv_requests"
      expr: COUNT(DISTINCT rtv_request_id)
      comment: "Total count of return-to-vendor requests for quality issue tracking"
    - name: "total_return_quantity"
      expr: SUM(CAST(total_return_quantity AS DOUBLE))
      comment: "Total quantity of units returned to vendors"
    - name: "total_return_value"
      expr: SUM(CAST(total_return_value AS DOUBLE))
      comment: "Total financial value of goods returned to vendors impacting cost of goods"
    - name: "avg_return_value"
      expr: AVG(CAST(total_return_value AS DOUBLE))
      comment: "Average return value per RTV request"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for return shipments"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per RTV request"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed for quality failures"
    - name: "avg_chargeback_amount"
      expr: AVG(CAST(chargeback_amount AS DOUBLE))
      comment: "Average chargeback amount per RTV request"
    - name: "recall_related_rtv_count"
      expr: COUNT(DISTINCT CASE WHEN is_recall_related = TRUE THEN rtv_request_id END)
      comment: "Count of recall-related returns for safety and compliance tracking"
    - name: "inspection_required_rtv_count"
      expr: COUNT(DISTINCT CASE WHEN quality_inspection_required = TRUE THEN rtv_request_id END)
      comment: "Count of RTVs requiring quality inspection"
    - name: "approved_rtv_count"
      expr: COUNT(DISTINCT CASE WHEN rtv_status = 'Approved' THEN rtv_request_id END)
      comment: "Count of approved RTV requests ready for shipment"
    - name: "credited_rtv_count"
      expr: COUNT(DISTINCT CASE WHEN rtv_status = 'Credited' THEN rtv_request_id END)
      comment: "Count of credited RTVs for financial recovery tracking"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplier_onboarding_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor onboarding pipeline metrics tracking application volume, approval rates, cycle time, and readiness for supplier network expansion"
  source: "`retail_ecm`.`supplier`.`onboarding_request`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of onboarding request (pending, approved, rejected, in progress, completed)"
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current stage in onboarding process (application, review, setup, testing, activation)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned during onboarding (low, medium, high)"
    - name: "diversity_certification"
      expr: diversity_certification
      comment: "Diversity certification status of applicant vendor"
    - name: "edi_capable"
      expr: CASE WHEN edi_capable_flag = TRUE THEN 'EDI Capable' ELSE 'Not EDI Capable' END
      comment: "Whether applicant vendor has EDI capability"
    - name: "edi_setup_completed"
      expr: CASE WHEN edi_setup_completed_flag = TRUE THEN 'EDI Setup Complete' ELSE 'EDI Setup Pending' END
      comment: "Whether EDI setup has been completed"
    - name: "vmi_enabled"
      expr: CASE WHEN vmi_enabled_flag = TRUE THEN 'VMI Enabled' ELSE 'Standard' END
      comment: "Whether vendor will participate in VMI program"
    - name: "sustainability_certified"
      expr: CASE WHEN sustainability_certified_flag = TRUE THEN 'Certified' ELSE 'Not Certified' END
      comment: "Whether vendor has sustainability certifications"
    - name: "insurance_certificate_required"
      expr: CASE WHEN insurance_certificate_required_flag = TRUE THEN 'Required' ELSE 'Not Required' END
      comment: "Whether insurance certificate is required"
    - name: "insurance_certificate_received"
      expr: CASE WHEN insurance_certificate_received_flag = TRUE THEN 'Received' ELSE 'Pending' END
      comment: "Whether insurance certificate has been received"
    - name: "w9_form_received"
      expr: CASE WHEN w9_form_received_flag = TRUE THEN 'Received' ELSE 'Pending' END
      comment: "Whether W9 tax form has been received"
    - name: "application_year"
      expr: YEAR(application_submitted_date)
      comment: "Year onboarding application was submitted"
    - name: "application_quarter"
      expr: CONCAT('Q', QUARTER(application_submitted_date), '-', YEAR(application_submitted_date))
      comment: "Quarter and year application was submitted"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year onboarding was approved"
    - name: "completion_year"
      expr: YEAR(onboarding_completion_date)
      comment: "Year onboarding was completed"
  measures:
    - name: "total_onboarding_requests"
      expr: COUNT(DISTINCT onboarding_request_id)
      comment: "Total count of vendor onboarding requests for pipeline volume tracking"
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score for onboarding applicants"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time days proposed by onboarding vendors"
    - name: "avg_moq_units"
      expr: AVG(CAST(moq_units AS DOUBLE))
      comment: "Average minimum order quantity proposed by onboarding vendors"
    - name: "approved_request_count"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Approved' THEN onboarding_request_id END)
      comment: "Count of approved onboarding requests for approval rate calculation"
    - name: "rejected_request_count"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Rejected' THEN onboarding_request_id END)
      comment: "Count of rejected onboarding requests for rejection rate analysis"
    - name: "completed_onboarding_count"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN onboarding_request_id END)
      comment: "Count of completed onboardings for conversion rate tracking"
    - name: "edi_capable_applicant_count"
      expr: COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN onboarding_request_id END)
      comment: "Count of EDI-capable applicants for automation readiness"
    - name: "vmi_enabled_applicant_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN onboarding_request_id END)
      comment: "Count of VMI-enabled applicants for inventory optimization potential"
    - name: "sustainability_certified_applicant_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certified_flag = TRUE THEN onboarding_request_id END)
      comment: "Count of sustainability-certified applicants for ESG goals"
    - name: "high_risk_applicant_count"
      expr: COUNT(DISTINCT CASE WHEN risk_tier = 'High' THEN onboarding_request_id END)
      comment: "Count of high-risk applicants requiring enhanced due diligence"
    - name: "diversity_certified_applicant_count"
      expr: COUNT(DISTINCT CASE WHEN diversity_certification IS NOT NULL AND diversity_certification != '' THEN onboarding_request_id END)
      comment: "Count of diversity-certified applicants for supplier diversity programs"
$$;