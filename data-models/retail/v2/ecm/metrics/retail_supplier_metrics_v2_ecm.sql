-- Metric views for domain: supplier | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic vendor master KPIs tracking supplier performance, compliance, and financial health across the active vendor base. Used by procurement leadership and category managers to evaluate and tier vendors."
  source: "`vibe_retail_v1`.`supplier`.`vendor`"
  filter: vendor_status = 'active'
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Operational status of the vendor (active, inactive, suspended, etc.) for cohort filtering."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of the vendor (e.g. direct, drop-ship, distributor) for segmentation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Current risk tier assigned to the vendor (low, medium, high, critical) for risk-based analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transactional currency of the vendor for multi-currency reporting."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code (e.g. Net30, Net60) for cash-flow and working-capital analysis."
    - name: "sustainability_certified"
      expr: sustainability_certified_flag
      comment: "Whether the vendor holds a sustainability certification, used for ESG reporting."
    - name: "edi_capable"
      expr: edi_capable_flag
      comment: "Whether the vendor supports EDI transactions, used for digital-readiness segmentation."
    - name: "vmi_enabled"
      expr: vmi_enabled_flag
      comment: "Whether vendor-managed inventory is enabled for this vendor."
  measures:
    - name: "total_active_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Total count of distinct active vendors. Baseline headcount KPI for procurement portfolio sizing."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across vendors. Measures how reliably vendors fulfill ordered quantities; directly impacts in-stock rates and customer satisfaction."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate across vendors. Core supply chain reliability KPI used in vendor scorecards and contract negotiations."
    - name: "avg_quality_acceptance_rate_pct"
      expr: AVG(CAST(quality_acceptance_rate_pct AS DOUBLE))
      comment: "Average quality acceptance rate across vendors. Measures the proportion of received goods that pass quality inspection; drives returns and chargeback costs."
    - name: "avg_moq_units"
      expr: AVG(CAST(moq_units AS DOUBLE))
      comment: "Average minimum order quantity across vendors. Informs working-capital requirements and inventory planning constraints."
    - name: "vendors_with_expiring_contracts"
      expr: COUNT(CASE WHEN contract_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_id END)
      comment: "Number of vendors whose contracts expire within the next 90 days. Triggers procurement renewal actions to avoid supply disruption."
    - name: "vendors_with_expiring_insurance"
      expr: COUNT(CASE WHEN insurance_certificate_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN vendor_id END)
      comment: "Number of vendors with insurance certificates expiring within 30 days. Compliance risk indicator requiring immediate follow-up."
    - name: "high_risk_vendor_count"
      expr: COUNT(CASE WHEN risk_rating IN ('high', 'critical') THEN vendor_id END)
      comment: "Count of vendors rated high or critical risk. Used by supply chain risk management to prioritize mitigation actions."
    - name: "edi_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edi_capable_flag = TRUE THEN vendor_id END) / NULLIF(COUNT(vendor_id), 0), 2)
      comment: "Percentage of vendors that are EDI-capable. Measures digital integration maturity of the vendor base; higher rates reduce manual processing costs."
    - name: "sustainability_certified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sustainability_certified_flag = TRUE THEN vendor_id END) / NULLIF(COUNT(vendor_id), 0), 2)
      comment: "Percentage of vendors holding sustainability certifications. ESG portfolio KPI reported to executive leadership and investors."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard KPIs aggregating composite scores, fill rates, on-time delivery, invoice accuracy, and chargeback exposure. Primary tool for procurement and category management to evaluate and tier suppliers."
  source: "`vibe_retail_v1`.`supplier`.`vendor_scorecard`"
  dimensions:
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Vendor performance tier (e.g. preferred, approved, probation) assigned based on scorecard results."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the scorecard record (draft, published, acknowledged) for workflow tracking."
    - name: "score_trend"
      expr: score_trend
      comment: "Direction of composite score movement (improving, declining, stable) for trend-based alerting."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action plan is required based on scorecard results."
    - name: "scoring_period_start_date"
      expr: DATE_TRUNC('month', scoring_period_start_date)
      comment: "Month bucket of the scoring period start date for time-series trend analysis."
    - name: "scoring_period_end_date"
      expr: DATE_TRUNC('quarter', scoring_period_end_date)
      comment: "Quarter bucket of the scoring period end date for quarterly business review reporting."
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite vendor performance score across all evaluated vendors. Primary KPI for vendor tier assignment and contract renewal decisions."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate from scorecards. Measures vendor ability to fulfill ordered quantities; directly impacts in-stock availability."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate from scorecards. Core logistics reliability KPI used in SLA compliance reviews."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate. Measures billing quality; low accuracy drives AP processing costs and dispute volumes."
    - name: "avg_edi_compliance_rate"
      expr: AVG(CAST(edi_compliance_rate AS DOUBLE))
      comment: "Average EDI compliance rate across vendors. Measures electronic transaction quality; non-compliance triggers chargebacks."
    - name: "avg_lead_time_adherence_rate"
      expr: AVG(CAST(lead_time_adherence_rate AS DOUBLE))
      comment: "Average lead time adherence rate. Measures how consistently vendors deliver within agreed lead times; impacts replenishment planning accuracy."
    - name: "avg_product_quality_score"
      expr: AVG(CAST(product_quality_score AS DOUBLE))
      comment: "Average product quality score from scorecards. Drives returns, chargebacks, and brand risk decisions."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed to vendors during the scoring period. Direct cost-recovery KPI for vendor compliance enforcement."
    - name: "total_return_to_vendor_amount"
      expr: SUM(CAST(return_to_vendor_amount AS DOUBLE))
      comment: "Total value of goods returned to vendors. Measures quality and compliance failures that result in physical returns."
    - name: "total_purchase_order_value"
      expr: SUM(CAST(total_purchase_order_value AS DOUBLE))
      comment: "Total purchase order value covered by scorecards. Provides spend context for normalizing performance metrics."
    - name: "avg_prior_period_composite_score"
      expr: AVG(CAST(prior_period_composite_score AS DOUBLE))
      comment: "Average composite score from the prior scoring period. Enables period-over-period performance comparison."
    - name: "vendors_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN vendor_scorecard_id END)
      comment: "Number of vendor scorecards requiring a corrective action plan. Operational risk indicator for procurement follow-up."
    - name: "avg_moq_compliance_rate"
      expr: AVG(CAST(minimum_order_quantity_compliance_rate AS DOUBLE))
      comment: "Average minimum order quantity compliance rate. Measures vendor adherence to contractual MOQ terms; non-compliance affects supply economics."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor chargeback KPIs tracking penalty amounts, violation patterns, dispute rates, and recovery performance. Used by accounts payable, procurement, and vendor compliance teams to enforce supplier standards and recover costs."
  source: "`vibe_retail_v1`.`supplier`.`chargeback`"
  dimensions:
    - name: "chargeback_type"
      expr: chargeback_type
      comment: "Category of chargeback (e.g. routing violation, labeling, ASN non-compliance) for root-cause analysis."
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback (open, disputed, resolved, written-off) for workflow tracking."
    - name: "violation_category"
      expr: violation_category
      comment: "Specific violation category driving the chargeback for compliance pattern analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any vendor dispute against the chargeback (pending, accepted, rejected)."
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Whether this chargeback is for a repeat violation, used to identify chronic non-compliant vendors."
    - name: "penalty_calculation_method"
      expr: penalty_calculation_method
      comment: "Method used to calculate the penalty (flat fee, percentage, tiered) for policy analysis."
    - name: "violation_date_month"
      expr: DATE_TRUNC('month', violation_date)
      comment: "Month of the violation date for time-series trend analysis of chargeback volumes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the chargeback penalty for multi-currency financial reporting."
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total chargeback penalty amount assessed to vendors. Primary financial recovery KPI for vendor compliance programs."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average chargeback penalty per violation. Benchmarks penalty severity and informs penalty schedule calibration."
    - name: "total_chargebacks"
      expr: COUNT(chargeback_id)
      comment: "Total number of chargebacks issued. Volume KPI for compliance enforcement activity."
    - name: "total_vendor_scorecard_impact"
      expr: SUM(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Total scorecard impact points deducted due to chargebacks. Quantifies how chargeback activity degrades vendor performance ratings."
    - name: "avg_vendor_scorecard_impact"
      expr: AVG(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Average scorecard impact per chargeback. Used to calibrate the relationship between violations and vendor tier changes."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN chargeback_id END) / NULLIF(COUNT(chargeback_id), 0), 2)
      comment: "Percentage of chargebacks that have been disputed by the vendor. High dispute rates signal unclear policies or aggressive enforcement."
    - name: "repeat_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_violation = TRUE THEN chargeback_id END) / NULLIF(COUNT(chargeback_id), 0), 2)
      comment: "Percentage of chargebacks that are repeat violations. Identifies vendors with systemic non-compliance requiring escalation."
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty percentage applied to violations. Used to assess whether penalty rates are aligned with policy targets."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor allowance and trade fund KPIs tracking accrued, claimed, settled, and disputed amounts. Used by finance, buying, and vendor management teams to optimize trade spend and ensure full allowance recovery."
  source: "`vibe_retail_v1`.`supplier`.`vendor_allowance`"
  dimensions:
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of vendor allowance (e.g. promotional, volume rebate, co-op advertising) for trade spend categorization."
    - name: "allowance_status"
      expr: allowance_status
      comment: "Current status of the allowance (active, expired, claimed, settled) for lifecycle tracking."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the allowance (pending, partial, complete) for cash-flow forecasting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the allowance for governance and audit trail purposes."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue the allowance (off-invoice, bill-back, scan) for accounting classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allowance for multi-currency trade fund reporting."
    - name: "product_category"
      expr: product_category
      comment: "Product category associated with the allowance for category-level trade spend analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the allowance became effective for time-series trade fund analysis."
  measures:
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total contracted allowance amount. Represents the full trade fund commitment from vendors."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total amount accrued against vendor allowances. Measures earned trade income recognized in the P&L."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed from vendors. Tracks cash recovery progress against accrued allowances."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount settled and received from vendors. Represents actual cash collected from trade programs."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute with vendors. Identifies at-risk trade income requiring resolution."
    - name: "allowance_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted allowance amount that has been settled. Core trade fund efficiency KPI; low recovery rates indicate leakage."
    - name: "claim_to_allowance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(claimed_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allowance amount that has been claimed. Measures how aggressively the organization is pursuing trade fund recovery."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed amount that is under dispute. High rates indicate vendor pushback or claim quality issues."
    - name: "avg_allowance_percentage"
      expr: AVG(CAST(allowance_percentage AS DOUBLE))
      comment: "Average allowance percentage across all vendor allowance agreements. Benchmarks trade fund generosity relative to purchase volume."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Total minimum purchase commitment required to qualify for allowances. Informs buying plan thresholds for allowance activation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor dispute KPIs tracking disputed amounts, resolution rates, aging, and SLA compliance. Used by accounts payable and vendor relations teams to manage financial disputes and enforce resolution timelines."
  source: "`vibe_retail_v1`.`supplier`.`vendor_dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g. invoice discrepancy, short shipment, quality deduction) for root-cause categorization."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, under review, resolved, escalated) for workflow management."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Business category of the dispute for pattern analysis and policy improvement."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the dispute has been escalated, used to identify high-priority resolution cases."
    - name: "dispute_submission_channel"
      expr: dispute_submission_channel
      comment: "Channel through which the dispute was submitted (portal, email, EDI) for process efficiency analysis."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit associated with the dispute for organizational accountability reporting."
    - name: "dispute_submission_month"
      expr: DATE_TRUNC('month', dispute_submission_date)
      comment: "Month the dispute was submitted for time-series volume and aging trend analysis."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount under dispute with vendors. Primary financial exposure KPI for AP and vendor management."
    - name: "total_approved_credit_amount"
      expr: SUM(CAST(approved_credit_amount AS DOUBLE))
      comment: "Total credit amount approved in resolution of disputes. Measures actual financial recovery from dispute resolution."
    - name: "total_disputes"
      expr: COUNT(vendor_dispute_id)
      comment: "Total number of vendor disputes. Volume KPI for dispute management workload and vendor relationship health."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN vendor_dispute_id END)
      comment: "Number of disputes that have been escalated. Identifies high-severity disputes requiring senior intervention."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN vendor_dispute_id END) / NULLIF(COUNT(vendor_dispute_id), 0), 2)
      comment: "Percentage of disputes that escalate. High escalation rates signal systemic vendor relationship or process issues."
    - name: "credit_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount recovered as approved credit. Measures effectiveness of the dispute resolution process."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute. Benchmarks dispute materiality and informs triage prioritization thresholds."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_rtv_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return-to-vendor KPIs tracking return volumes, values, freight costs, and disposition outcomes. Used by buying, quality, and supply chain teams to manage vendor returns and recover costs from non-conforming goods."
  source: "`vibe_retail_v1`.`supplier`.`rtv_request`"
  dimensions:
    - name: "rtv_status"
      expr: rtv_status
      comment: "Current status of the RTV request (pending, authorized, shipped, credited) for lifecycle tracking."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return (e.g. quality failure, overstock, recall) for root-cause analysis."
    - name: "disposition_method"
      expr: disposition_method
      comment: "How returned goods are handled (return to vendor, destroy, donate) for cost and sustainability reporting."
    - name: "freight_responsibility"
      expr: freight_responsibility
      comment: "Party responsible for return freight costs (vendor, retailer, shared) for cost allocation."
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Whether the return is related to a product recall, used for compliance and risk reporting."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether a quality inspection is required before return authorization."
    - name: "request_date_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of the RTV request for time-series return volume trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the return value for multi-currency financial reporting."
  measures:
    - name: "total_return_value"
      expr: SUM(CAST(total_return_value AS DOUBLE))
      comment: "Total value of goods returned to vendors. Primary financial KPI for vendor return programs; high values indicate quality or compliance failures."
    - name: "total_return_quantity"
      expr: SUM(CAST(total_return_quantity AS DOUBLE))
      comment: "Total units returned to vendors. Volume KPI for supply chain quality and vendor performance management."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost incurred for vendor returns. Cost efficiency KPI; high freight costs relative to return value indicate process inefficiency."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount associated with RTV requests. Measures cost recovery from vendor-caused returns."
    - name: "total_rtv_requests"
      expr: COUNT(rtv_request_id)
      comment: "Total number of RTV requests. Volume KPI for vendor quality and compliance management workload."
    - name: "recall_related_return_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_recall_related = TRUE THEN rtv_request_id END) / NULLIF(COUNT(rtv_request_id), 0), 2)
      comment: "Percentage of RTV requests that are recall-related. Compliance and safety risk KPI requiring executive visibility."
    - name: "avg_return_value"
      expr: AVG(CAST(total_return_value AS DOUBLE))
      comment: "Average value per RTV request. Benchmarks return materiality and informs authorization threshold policies."
    - name: "freight_cost_to_return_value_ratio"
      expr: ROUND(SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_return_value AS DOUBLE)), 0), 4)
      comment: "Ratio of freight cost to total return value. Measures cost efficiency of the return process; high ratios indicate returns that may not be economically justified."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment KPIs tracking overall risk scores, risk tier distribution, and domain-specific risk dimensions (financial, compliance, ESG, cybersecurity, geopolitical). Used by procurement risk management and executive leadership to monitor supply chain vulnerability."
  source: "`vibe_retail_v1`.`supplier`.`risk_assessment`"
  dimensions:
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Overall risk tier assigned to the vendor (low, medium, high, critical) for risk-based portfolio management."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (initial, periodic, triggered, third-party) for methodology tracking."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (in-progress, complete, expired) for governance tracking."
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of required mitigation actions (not started, in-progress, complete) for risk remediation tracking."
    - name: "third_party_assessment_flag"
      expr: third_party_assessment_flag
      comment: "Whether the assessment was conducted by a third party, used for independence and credibility analysis."
    - name: "assessment_date_quarter"
      expr: DATE_TRUNC('quarter', assessment_date)
      comment: "Quarter of the assessment date for time-series risk trend analysis."
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessed vendors. Portfolio-level risk KPI used in executive risk dashboards."
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score. Measures vendor solvency risk; low scores indicate potential supply disruption from vendor financial distress."
    - name: "avg_compliance_risk_score"
      expr: AVG(CAST(compliance_risk_score AS DOUBLE))
      comment: "Average compliance risk score. Measures regulatory and contractual compliance exposure across the vendor base."
    - name: "avg_esg_risk_score"
      expr: AVG(CAST(esg_risk_score AS DOUBLE))
      comment: "Average ESG risk score. Measures environmental, social, and governance risk in the supply chain; increasingly material for investor and regulatory reporting."
    - name: "avg_cybersecurity_risk_score"
      expr: AVG(CAST(cybersecurity_risk_score AS DOUBLE))
      comment: "Average cybersecurity risk score. Measures data and system security risk from vendor integrations; critical for PCI and data privacy compliance."
    - name: "avg_supply_continuity_risk_score"
      expr: AVG(CAST(supply_continuity_risk_score AS DOUBLE))
      comment: "Average supply continuity risk score. Measures the risk of supply disruption; directly impacts inventory availability and customer service levels."
    - name: "avg_geopolitical_risk_score"
      expr: AVG(CAST(geopolitical_risk_score AS DOUBLE))
      comment: "Average geopolitical risk score. Measures country and trade-route risk; informs sourcing diversification strategy."
    - name: "avg_single_source_dependency_score"
      expr: AVG(CAST(single_source_dependency_score AS DOUBLE))
      comment: "Average single-source dependency score. Identifies categories or SKUs with dangerous supplier concentration; drives dual-sourcing decisions."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN overall_risk_tier IN ('high', 'critical') THEN risk_assessment_id END)
      comment: "Number of assessments resulting in high or critical risk tier. Operational risk KPI for prioritizing mitigation resources."
    - name: "avg_risk_appetite_threshold"
      expr: AVG(CAST(risk_appetite_threshold AS DOUBLE))
      comment: "Average risk appetite threshold set for vendor assessments. Benchmarks organizational risk tolerance for procurement policy calibration."
    - name: "assessments_exceeding_appetite"
      expr: COUNT(CASE WHEN overall_risk_score > risk_appetite_threshold THEN risk_assessment_id END)
      comment: "Number of assessments where the overall risk score exceeds the defined risk appetite threshold. Triggers mandatory escalation and mitigation planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract KPIs tracking contract values, terms, compliance requirements, and lifecycle status. Used by procurement, legal, and finance teams to manage contract portfolio health and renewal risk."
  source: "`vibe_retail_v1`.`supplier`.`vendor_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract (master supply agreement, purchase order, consignment, etc.) for portfolio categorization."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (active, expired, terminated, pending renewal) for lifecycle management."
    - name: "contract_currency_code"
      expr: contract_currency_code
      comment: "Currency of the contract value for multi-currency financial reporting."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for working-capital and cash-flow analysis."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Whether EDI is enabled under this contract for digital integration tracking."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract includes exclusivity provisions, relevant for competitive sourcing strategy."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Whether vendor-managed inventory is enabled under this contract."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, used to identify contracts requiring active renewal decisions."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the contract became effective for cohort and vintage analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total contracted value across all vendor contracts. Primary spend commitment KPI for procurement portfolio management."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average contract value. Benchmarks deal size and informs negotiation strategy for new contracts."
    - name: "total_active_contracts"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN vendor_contract_id END)
      comment: "Total number of active vendor contracts. Portfolio size KPI for procurement resource planning."
    - name: "contracts_expiring_90_days"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_contract_id END)
      comment: "Number of contracts expiring within 90 days. Renewal risk KPI requiring immediate procurement action to avoid supply disruption."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated across contracts. Measures procurement effectiveness in securing favorable pricing terms."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts. Informs inventory planning and working-capital requirements."
    - name: "exclusivity_contract_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN vendor_contract_id END) / NULLIF(COUNT(vendor_contract_id), 0), 2)
      comment: "Percentage of contracts with exclusivity provisions. Measures supply chain lock-in risk and competitive sourcing flexibility."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_edi_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDI transaction KPIs tracking transmission volumes, processing success rates, error rates, chargeback exposure, and acknowledgment compliance. Used by supply chain operations and vendor compliance teams to monitor electronic trading partner health."
  source: "`vibe_retail_v1`.`supplier`.`supplier_edi_transaction`"
  dimensions:
    - name: "transaction_set_type"
      expr: transaction_set_type
      comment: "EDI transaction set type (e.g. 850 PO, 856 ASN, 810 Invoice) for transaction-type performance analysis."
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status of the EDI transaction (received, processed, failed, rejected) for operational monitoring."
    - name: "direction"
      expr: direction
      comment: "Direction of the EDI transaction (inbound, outbound) for bilateral flow analysis."
    - name: "functional_acknowledgment_status"
      expr: functional_acknowledgment_status
      comment: "Status of the functional acknowledgment (accepted, rejected, pending) for compliance tracking."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Whether the transaction is eligible for a chargeback due to non-compliance."
    - name: "test_indicator"
      expr: test_indicator
      comment: "Whether the transaction is a test transmission, used to exclude test data from production metrics."
    - name: "transmission_month"
      expr: DATE_TRUNC('month', transmission_timestamp)
      comment: "Month of transmission for time-series EDI volume and error rate trend analysis."
  measures:
    - name: "total_transactions"
      expr: COUNT(supplier_edi_transaction_id)
      comment: "Total EDI transactions processed. Volume KPI for EDI infrastructure capacity and vendor activity monitoring."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount associated with EDI non-compliance transactions. Financial impact KPI for EDI compliance enforcement."
    - name: "error_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN processing_status = 'failed' OR processing_status = 'rejected' THEN supplier_edi_transaction_id END) / NULLIF(COUNT(supplier_edi_transaction_id), 0), 2)
      comment: "Percentage of EDI transactions that failed or were rejected. Core EDI quality KPI; high error rates drive manual intervention costs and chargeback exposure."
    - name: "chargeback_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chargeback_eligible = TRUE THEN supplier_edi_transaction_id END) / NULLIF(COUNT(supplier_edi_transaction_id), 0), 2)
      comment: "Percentage of transactions eligible for chargeback due to EDI non-compliance. Measures the financial risk exposure from EDI errors."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average EDI file size in bytes. Infrastructure capacity planning metric for EDI platform sizing."
    - name: "total_file_size_bytes"
      expr: SUM(CAST(file_size_bytes AS DOUBLE))
      comment: "Total EDI data volume in bytes. Used for EDI platform capacity planning and data transfer cost management."
    - name: "acknowledgment_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN functional_acknowledgment_status = 'accepted' THEN supplier_edi_transaction_id END) / NULLIF(COUNT(CASE WHEN functional_acknowledgment_status IS NOT NULL THEN supplier_edi_transaction_id END), 0), 2)
      comment: "Percentage of transactions with accepted functional acknowledgments. Measures EDI trading partner compliance with acknowledgment requirements."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vmi_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor-managed inventory configuration KPIs tracking inventory thresholds, replenishment performance, and penalty exposure. Used by supply chain and vendor management teams to optimize VMI program effectiveness."
  source: "`vibe_retail_v1`.`supplier`.`vmi_config`"
  dimensions:
    - name: "config_status"
      expr: config_status
      comment: "Status of the VMI configuration (active, inactive, suspended) for program management."
    - name: "replenishment_model"
      expr: replenishment_model
      comment: "Replenishment model used (min-max, continuous review, periodic review) for methodology analysis."
    - name: "replenishment_frequency"
      expr: replenishment_frequency
      comment: "Frequency of replenishment (daily, weekly, bi-weekly) for supply cadence analysis."
    - name: "auto_replenishment_enabled"
      expr: auto_replenishment_enabled
      comment: "Whether automatic replenishment is enabled, used to measure VMI automation adoption."
    - name: "consignment_flag"
      expr: consignment_flag
      comment: "Whether inventory is held on consignment, affecting ownership and financial reporting."
    - name: "ownership_transfer_point"
      expr: ownership_transfer_point
      comment: "Point at which inventory ownership transfers from vendor to retailer (e.g. at receipt, at scan) for financial accounting."
    - name: "data_sharing_frequency"
      expr: data_sharing_frequency
      comment: "Frequency at which inventory data is shared with the vendor for replenishment decisions."
  measures:
    - name: "total_vmi_configs"
      expr: COUNT(vmi_config_id)
      comment: "Total number of active VMI configurations. Measures the scale of the VMI program across vendors and locations."
    - name: "avg_target_inventory_level"
      expr: AVG(CAST(target_inventory_level AS DOUBLE))
      comment: "Average target inventory level across VMI configurations. Benchmarks planned inventory investment in VMI programs."
    - name: "avg_safety_stock_level"
      expr: AVG(CAST(safety_stock_level AS DOUBLE))
      comment: "Average safety stock level across VMI configurations. Measures buffer inventory investment to protect against stockouts."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across VMI configurations. Informs when replenishment signals are triggered."
    - name: "avg_performance_sla_target"
      expr: AVG(CAST(performance_sla_target AS DOUBLE))
      comment: "Average performance SLA target across VMI configurations. Benchmarks the service level commitments in VMI agreements."
    - name: "total_stockout_penalty_exposure"
      expr: SUM(CAST(stockout_penalty_amount AS DOUBLE))
      comment: "Total potential stockout penalty amount across VMI configurations. Financial risk KPI for VMI program governance."
    - name: "total_excess_inventory_penalty_exposure"
      expr: SUM(CAST(excess_inventory_penalty_amount AS DOUBLE))
      comment: "Total potential excess inventory penalty amount. Measures financial risk from over-stocking under VMI agreements."
    - name: "auto_replenishment_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_replenishment_enabled = TRUE THEN vmi_config_id END) / NULLIF(COUNT(vmi_config_id), 0), 2)
      comment: "Percentage of VMI configurations with automatic replenishment enabled. Measures VMI program automation maturity."
    - name: "avg_max_inventory_threshold"
      expr: AVG(CAST(max_inventory_threshold AS DOUBLE))
      comment: "Average maximum inventory threshold across VMI configurations. Used to assess inventory ceiling constraints in VMI programs."
    - name: "avg_min_inventory_threshold"
      expr: AVG(CAST(min_inventory_threshold AS DOUBLE))
      comment: "Average minimum inventory threshold across VMI configurations. Used to assess stockout risk floors in VMI programs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_lead_time_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead time agreement KPIs tracking SLA commitments, fill rate targets, and on-time delivery performance thresholds. Used by supply chain planning and procurement teams to validate and enforce vendor lead time commitments."
  source: "`vibe_retail_v1`.`supplier`.`lead_time_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the lead time agreement (active, expired, pending) for portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of lead time agreement (standard, expedited, seasonal) for SLA categorization."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation (truck, rail, air, ocean) for logistics cost and lead time analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms code governing ownership and risk transfer for trade compliance analysis."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Whether VMI is enabled under this agreement for program coverage analysis."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Whether EDI is enabled under this agreement for digital integration tracking."
    - name: "effective_start_year"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the agreement became effective for cohort analysis."
  measures:
    - name: "total_agreements"
      expr: COUNT(lead_time_agreement_id)
      comment: "Total number of lead time agreements. Portfolio size KPI for supply chain planning coverage."
    - name: "avg_fill_rate_sla_percent"
      expr: AVG(CAST(fill_rate_sla_percent AS DOUBLE))
      comment: "Average fill rate SLA commitment across agreements. Benchmarks the service level the organization has negotiated with vendors."
    - name: "avg_on_time_delivery_sla_percent"
      expr: AVG(CAST(on_time_delivery_sla_percent AS DOUBLE))
      comment: "Average on-time delivery SLA commitment across agreements. Measures the delivery reliability standard negotiated with vendors."
    - name: "avg_compliance_penalty_rate"
      expr: AVG(CAST(compliance_penalty_rate AS DOUBLE))
      comment: "Average compliance penalty rate across agreements. Measures the financial consequence of SLA breaches; informs vendor negotiation leverage."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across lead time agreements. Informs inventory planning and working-capital requirements."
    - name: "avg_order_increment_quantity"
      expr: AVG(CAST(order_increment_quantity AS DOUBLE))
      comment: "Average order increment quantity. Measures ordering granularity constraints that affect replenishment efficiency."
    - name: "agreements_expiring_60_days"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 60) THEN lead_time_agreement_id END)
      comment: "Number of lead time agreements expiring within 60 days. Renewal risk KPI requiring procurement action to maintain supply chain SLAs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor certification KPIs tracking compliance coverage, audit frequency, corrective action rates, and certification renewal risk. Used by compliance and procurement teams to ensure vendor regulatory and quality standards are maintained."
  source: "`vibe_retail_v1`.`supplier`.`vendor_certification`"
  dimensions:
    - name: "compliance_level"
      expr: compliance_level
      comment: "Level of compliance achieved (full, partial, non-compliant) for risk stratification."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify certification (self-declaration, third-party audit, lab test) for credibility assessment."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the certification is mandatory for doing business with the vendor."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action is required based on certification audit results."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin covered by the certification for trade compliance and sourcing analysis."
    - name: "product_category_covered"
      expr: product_category_covered
      comment: "Product category covered by the certification for category-level compliance reporting."
    - name: "renewal_date_quarter"
      expr: DATE_TRUNC('quarter', renewal_date)
      comment: "Quarter of certification renewal date for renewal pipeline management."
  measures:
    - name: "total_certifications"
      expr: COUNT(vendor_certification_id)
      comment: "Total number of vendor certifications tracked. Portfolio size KPI for compliance program coverage."
    - name: "certifications_expiring_90_days"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_certification_id END)
      comment: "Number of certifications expiring within 90 days. Compliance risk KPI requiring renewal action to avoid supply disruption."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN vendor_certification_id END) / NULLIF(COUNT(vendor_certification_id), 0), 2)
      comment: "Percentage of certifications requiring corrective action. Measures the prevalence of compliance gaps in the vendor base."
    - name: "mandatory_certification_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mandatory = TRUE THEN vendor_certification_id END) / NULLIF(COUNT(vendor_certification_id), 0), 2)
      comment: "Percentage of certifications that are mandatory. Measures the proportion of compliance obligations that are non-negotiable."
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE AND corrective_action_due_date < CURRENT_DATE THEN vendor_certification_id END)
      comment: "Number of certifications with overdue corrective actions. Critical compliance risk KPI requiring immediate escalation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_onboarding_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor onboarding pipeline metrics tracking application volume, approval rates, cycle time, and readiness for supplier network expansion"
  source: "`vibe_retail_v1`.`supplier`.`onboarding_request`"
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