-- Metric views for domain: supplier | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the vendor master. Tracks vendor performance rates, financial exposure, and portfolio health to support sourcing decisions, vendor tiering, and risk management."
  source: "`vibe_retail_v1`.`supplier`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Operational status of the vendor (e.g. Active, Inactive, Suspended) — primary segmentation for portfolio health analysis."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of the vendor (e.g. Direct, Distributor, Drop-Ship) — drives sourcing strategy segmentation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk tier assigned to the vendor — used to prioritise mitigation actions and audit frequency."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms negotiated with the vendor — used for cash-flow and working-capital analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transactional currency of the vendor — required for multi-currency financial reporting."
    - name: "diversity_certification"
      expr: diversity_certification
      comment: "Diversity certification held by the vendor (e.g. MBE, WBE) — supports supplier-diversity programme tracking."
    - name: "sustainability_certified_flag"
      expr: sustainability_certified_flag
      comment: "Indicates whether the vendor holds a sustainability certification — used for ESG supplier reporting."
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Indicates whether the vendor supports EDI transactions — used to assess digital-integration readiness."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Indicates whether vendor-managed inventory is active — used to segment VMI vs. traditional replenishment vendors."
    - name: "onboarding_date"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Month the vendor was onboarded — enables cohort analysis of vendor performance over time."
    - name: "contract_expiry_date"
      expr: DATE_TRUNC('month', contract_expiry_date)
      comment: "Month the vendor contract expires — used to flag upcoming renewals and renegotiation windows."
  measures:
    - name: "active_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_status = 'Active' THEN vendor_id END)
      comment: "Number of currently active vendors in the portfolio — baseline KPI for sourcing breadth and single-source risk assessment."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate across vendors — directly measures supply-chain reliability and informs vendor tier decisions."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate across vendors — measures the proportion of ordered units actually supplied; low fill rates drive out-of-stock events."
    - name: "avg_quality_acceptance_rate_pct"
      expr: AVG(CAST(quality_acceptance_rate_pct AS DOUBLE))
      comment: "Average quality acceptance rate across vendors — tracks product quality compliance; declines trigger corrective-action programmes."
    - name: "avg_moq_units"
      expr: AVG(CAST(moq_units AS DOUBLE))
      comment: "Average minimum order quantity across vendors — informs inventory planning and working-capital requirements."
    - name: "vendors_with_expiring_contracts_count"
      expr: COUNT(DISTINCT CASE WHEN contract_expiry_date <= ADD_MONTHS(CURRENT_DATE(), 3) AND contract_expiry_date >= CURRENT_DATE() THEN vendor_id END)
      comment: "Number of vendors whose contracts expire within the next 90 days — critical for procurement teams to prioritise renegotiations and avoid supply disruptions."
    - name: "vendors_with_expiring_insurance_count"
      expr: COUNT(DISTINCT CASE WHEN insurance_certificate_expiry_date <= ADD_MONTHS(CURRENT_DATE(), 1) AND insurance_certificate_expiry_date >= CURRENT_DATE() THEN vendor_id END)
      comment: "Number of vendors with insurance certificates expiring within 30 days — compliance risk indicator requiring immediate follow-up."
    - name: "high_risk_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('High', 'Critical') THEN vendor_id END)
      comment: "Number of vendors rated High or Critical risk — used by procurement leadership to prioritise risk-mitigation and dual-sourcing strategies."
    - name: "edi_capable_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN vendor_id END)
      comment: "Number of vendors capable of EDI transactions — measures digital-integration coverage across the supplier base."
    - name: "sustainability_certified_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certified_flag = TRUE THEN vendor_id END)
      comment: "Number of vendors holding sustainability certifications — ESG KPI reported to board and external stakeholders."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and strategic KPI layer over vendor scorecards. Tracks composite performance scores, delivery, fill, quality, and financial exposure per vendor and scoring period to drive vendor management decisions."
  source: "`vibe_retail_v1`.`supplier`.`vendor_scorecard`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — primary grouping key for all vendor performance analysis."
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Tier classification of the vendor (e.g. Preferred, Standard, Probation) — used to segment performance expectations and review cadence."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the scorecard record (e.g. Final, Draft, Disputed) — filters for published vs. in-progress evaluations."
    - name: "score_trend"
      expr: score_trend
      comment: "Direction of composite score movement vs. prior period (e.g. Improving, Declining, Stable) — used to identify vendors requiring intervention."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action plan is required — used to track compliance remediation workload."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of financial amounts on the scorecard — required for multi-currency financial aggregation."
    - name: "scoring_period_start_date"
      expr: DATE_TRUNC('month', scoring_period_start_date)
      comment: "Start month of the scoring period — enables time-series trending of vendor performance."
    - name: "evaluation_date"
      expr: DATE_TRUNC('month', evaluation_date)
      comment: "Month the scorecard was evaluated — used for period-over-period performance comparison."
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite vendor performance score across all evaluated scorecards — the primary executive KPI for overall supplier health."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate from scorecards — measures supply-chain reliability and informs vendor tier decisions."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate from scorecards — measures the proportion of ordered units fulfilled; directly linked to in-stock performance."
    - name: "avg_product_quality_score"
      expr: AVG(CAST(product_quality_score AS DOUBLE))
      comment: "Average product quality score from scorecards — tracks merchandise quality compliance and drives returns/chargeback risk."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate — measures billing compliance; low accuracy increases accounts-payable processing costs."
    - name: "avg_edi_compliance_rate"
      expr: AVG(CAST(edi_compliance_rate AS DOUBLE))
      comment: "Average EDI compliance rate — measures electronic transaction accuracy; non-compliance drives manual processing costs and chargebacks."
    - name: "avg_lead_time_adherence_rate"
      expr: AVG(CAST(lead_time_adherence_rate AS DOUBLE))
      comment: "Average lead-time adherence rate — measures how consistently vendors deliver within agreed lead times; deviations disrupt replenishment planning."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed to vendors across all scorecards — financial KPI measuring cost of vendor non-compliance."
    - name: "total_return_to_vendor_amount"
      expr: SUM(CAST(return_to_vendor_amount AS DOUBLE))
      comment: "Total value of merchandise returned to vendors — measures product quality and receiving compliance failures with direct P&L impact."
    - name: "total_purchase_order_value"
      expr: SUM(CAST(total_purchase_order_value AS DOUBLE))
      comment: "Total purchase order value covered by scorecards — provides spend context for normalising performance metrics and prioritising vendor management effort."
    - name: "avg_score_vs_prior_period"
      expr: AVG(CAST(composite_score AS DOUBLE) - CAST(prior_period_composite_score AS DOUBLE))
      comment: "Average change in composite score versus the prior scoring period — measures whether the vendor portfolio is improving or deteriorating overall."
    - name: "vendors_requiring_corrective_action_count"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN vendor_id END)
      comment: "Number of distinct vendors with an active corrective action requirement — operational KPI for vendor management workload and compliance risk."
    - name: "avg_moq_compliance_rate"
      expr: AVG(CAST(minimum_order_quantity_compliance_rate AS DOUBLE))
      comment: "Average minimum order quantity compliance rate — measures vendor adherence to contractual MOQ terms; non-compliance affects inventory economics."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and compliance KPI layer over vendor chargebacks. Tracks penalty amounts, violation patterns, dispute rates, and recovery performance to manage vendor compliance costs and reduce repeat violations."
  source: "`vibe_retail_v1`.`supplier`.`chargeback`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — primary grouping key for chargeback analysis by supplier."
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback (e.g. Open, Approved, Disputed, Recovered) — used to track resolution pipeline."
    - name: "chargeback_type"
      expr: chargeback_type
      comment: "Type of chargeback (e.g. Routing, Labelling, EDI, Shortage) — identifies the most costly compliance failure categories."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of the underlying violation — used to prioritise corrective-action programmes by root cause."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any vendor dispute against the chargeback — tracks contested amounts and resolution outcomes."
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Flag indicating whether this is a repeat violation by the vendor — used to identify chronic non-compliance requiring escalation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the chargeback penalty — required for multi-currency financial aggregation."
    - name: "penalty_calculation_method"
      expr: penalty_calculation_method
      comment: "Method used to calculate the penalty (e.g. Flat Fee, Percentage) — used to analyse penalty structure effectiveness."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the vendor of the chargeback — used to assess communication channel effectiveness."
    - name: "violation_date"
      expr: DATE_TRUNC('month', violation_date)
      comment: "Month the violation occurred — enables time-series trending of chargeback incidence."
    - name: "detection_date"
      expr: DATE_TRUNC('month', detection_date)
      comment: "Month the violation was detected — used to measure detection lag and improve compliance monitoring."
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total chargeback penalty amount assessed — primary financial KPI for vendor compliance cost management."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per chargeback — used to benchmark penalty severity and assess whether penalty structures are deterring violations."
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty percentage applied — measures the contractual penalty rate being enforced across violation types."
    - name: "total_vendor_scorecard_impact"
      expr: SUM(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Total scorecard impact points deducted due to chargebacks — links compliance failures directly to vendor performance ratings."
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Total number of chargebacks issued — baseline volume KPI for compliance monitoring and trend analysis."
    - name: "repeat_violation_count"
      expr: COUNT(CASE WHEN is_repeat_violation = TRUE THEN 1 END)
      comment: "Number of chargebacks flagged as repeat violations — measures chronic non-compliance; high counts indicate corrective-action programmes are ineffective."
    - name: "disputed_chargeback_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN chargeback_id END)
      comment: "Number of chargebacks that have been disputed by the vendor — measures vendor pushback rate and potential over-assessment of penalties."
    - name: "distinct_vendor_count_with_chargebacks"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors that have received at least one chargeback — measures breadth of compliance issues across the supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI layer over vendor allowances and trade funds. Tracks allowance accruals, claims, settlements, and disputes to maximise trade fund recovery and manage vendor funding agreements."
  source: "`vibe_retail_v1`.`supplier`.`vendor_allowance`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — primary grouping key for allowance analysis by supplier."
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of allowance (e.g. Off-Invoice, Bill-Back, Scan, Co-op) — used to analyse trade fund mix and recovery rates by programme type."
    - name: "allowance_status"
      expr: allowance_status
      comment: "Current status of the allowance (e.g. Active, Expired, Settled) — used to track the allowance lifecycle pipeline."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the allowance (e.g. Pending, Settled, Disputed) — used to monitor outstanding trade fund recovery."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the allowance — used to track the internal authorisation pipeline for trade fund agreements."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue the allowance (e.g. Purchase-Based, Sales-Based) — used for financial reporting and audit compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allowance amounts — required for multi-currency financial aggregation."
    - name: "product_category"
      expr: product_category
      comment: "Product category covered by the allowance — used to analyse trade fund concentration by category."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the allowance became effective — enables cohort analysis of trade fund agreements."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the allowance expires — used to flag upcoming expirations and ensure timely claims submission."
  measures:
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total contracted allowance amount — the gross trade fund value negotiated with vendors; primary financial KPI for trade fund management."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total amount accrued against allowance agreements — measures the financial liability recognised on the books for trade funds."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed from vendors — measures actual trade fund recovery; gap vs. accrued amount indicates unclaimed funds."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount settled and received from vendors — the realised trade fund income; directly impacts gross margin."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount under dispute with vendors — measures at-risk trade fund recovery and vendor relationship friction."
    - name: "avg_allowance_percentage"
      expr: AVG(CAST(allowance_percentage AS DOUBLE))
      comment: "Average allowance percentage across agreements — benchmarks the trade fund rate being negotiated across the vendor portfolio."
    - name: "unclaimed_allowance_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE) - CAST(claimed_amount AS DOUBLE))
      comment: "Total accrued but unclaimed allowance amount — identifies unrealised trade fund recovery opportunity; high values indicate process gaps in claims management."
    - name: "unsettled_allowance_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE) - CAST(settled_amount AS DOUBLE))
      comment: "Total claimed but not yet settled allowance amount — measures outstanding vendor payment obligations and cash-flow timing risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPI layer over vendor contracts. Tracks contract values, discount rates, compliance requirements, and expiry risk to support procurement governance and renegotiation planning."
  source: "`vibe_retail_v1`.`supplier`.`vendor_contract`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — primary grouping key for contract analysis by supplier."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g. Active, Expired, Terminated, Pending) — used to monitor portfolio health and compliance."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Master, Addendum, Spot) — used to segment contract portfolio by agreement structure."
    - name: "contract_currency_code"
      expr: contract_currency_code
      comment: "Currency of the contract value — required for multi-currency financial aggregation."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code on the contract — used for working-capital and cash-flow analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing delivery responsibility — used to analyse logistics cost allocation across the contract portfolio."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews — used to identify contracts requiring active renegotiation before expiry."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Indicates whether EDI is enabled on the contract — used to track digital-integration coverage across the contract portfolio."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Indicates whether VMI is enabled on the contract — used to segment VMI vs. traditional replenishment contracts."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the contract became effective — enables cohort analysis of contract portfolio vintage."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the contract expires — used to flag upcoming expirations and prioritise renegotiation workload."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total contracted spend value across all vendor contracts — primary financial KPI for procurement portfolio sizing and spend governance."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average contract value per vendor agreement — used to benchmark deal size and identify outlier contracts requiring additional scrutiny."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated across contracts — measures procurement effectiveness in securing favourable pricing terms."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts — informs inventory planning and working-capital requirements at the contract level."
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN vendor_contract_id END)
      comment: "Number of currently active vendor contracts — baseline KPI for procurement portfolio scope and governance coverage."
    - name: "contracts_expiring_within_90_days_count"
      expr: COUNT(DISTINCT CASE WHEN effective_end_date <= ADD_MONTHS(CURRENT_DATE(), 3) AND effective_end_date >= CURRENT_DATE() THEN vendor_contract_id END)
      comment: "Number of contracts expiring within 90 days — critical procurement risk KPI used to prioritise renegotiation and avoid supply disruptions."
    - name: "total_active_contract_value"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN CAST(contract_value_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of currently active contracts — measures the financial scale of the live procurement portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level supplier KPI layer over vendor items. Tracks unit costs, preferred vendor coverage, private label penetration, and VMI/DSD eligibility to support category management and sourcing decisions."
  source: "`vibe_retail_v1`.`supplier`.`vendor_item`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — primary grouping key for item-level analysis by supplier."
    - name: "vendor_item_status"
      expr: vendor_item_status
      comment: "Status of the vendor item (e.g. Active, Discontinued, Pending) — used to monitor active assortment coverage."
    - name: "category"
      expr: category
      comment: "Product category of the vendor item — used for category-level cost and sourcing analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the item is manufactured — used for trade compliance, tariff analysis, and supply-chain risk assessment."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the unit cost — required for multi-currency cost aggregation."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether this vendor is the preferred source for the item — used to measure preferred-vendor programme coverage."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private-label product — used to track own-brand assortment penetration."
    - name: "dsd_eligible_flag"
      expr: dsd_eligible_flag
      comment: "Indicates whether the item is eligible for direct-store delivery — used to segment DSD vs. warehouse-routed assortment."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Indicates whether VMI is enabled for this item — used to track VMI assortment coverage."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Indicates whether EDI ordering is enabled for this item — used to measure digital-ordering coverage at the item level."
    - name: "cost_effective_date"
      expr: DATE_TRUNC('month', cost_effective_date)
      comment: "Month the current unit cost became effective — enables cost trend analysis over time."
  measures:
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across vendor items — primary cost KPI for category management and margin planning."
    - name: "total_active_item_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_item_status = 'Active' THEN vendor_item_id END)
      comment: "Number of active vendor items — measures the breadth of the active supplier assortment."
    - name: "preferred_vendor_item_count"
      expr: COUNT(DISTINCT CASE WHEN preferred_vendor_flag = TRUE THEN vendor_item_id END)
      comment: "Number of items sourced from preferred vendors — measures preferred-vendor programme penetration across the assortment."
    - name: "private_label_item_count"
      expr: COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN vendor_item_id END)
      comment: "Number of private-label items in the vendor assortment — tracks own-brand penetration, which is directly linked to margin improvement strategy."
    - name: "dsd_eligible_item_count"
      expr: COUNT(DISTINCT CASE WHEN dsd_eligible_flag = TRUE THEN vendor_item_id END)
      comment: "Number of items eligible for direct-store delivery — used to plan DSD programme scope and logistics cost allocation."
    - name: "items_with_cost_expiring_within_30_days_count"
      expr: COUNT(DISTINCT CASE WHEN cost_expiration_date <= ADD_MONTHS(CURRENT_DATE(), 1) AND cost_expiration_date >= CURRENT_DATE() THEN vendor_item_id END)
      comment: "Number of vendor items with cost agreements expiring within 30 days — operational KPI to trigger cost renegotiation and prevent pricing gaps."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_lead_time_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply-chain KPI layer over lead time agreements. Tracks SLA commitments, fill rate targets, on-time delivery targets, and MOQ terms to support replenishment planning and vendor compliance management."
  source: "`vibe_retail_v1`.`supplier`.`lead_time_agreement`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier — primary grouping key for lead time agreement analysis by supplier."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the lead time agreement (e.g. Active, Expired, Pending) — used to filter for operative agreements."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of lead time agreement (e.g. Standard, Seasonal, Expedited) — used to segment SLA analysis by agreement structure."
    - name: "scope_level"
      expr: scope_level
      comment: "Scope of the agreement (e.g. SKU, Category, Vendor) — used to understand the granularity of SLA commitments."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation specified in the agreement (e.g. Truck, Rail, Air) — used to analyse lead time by logistics mode."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms governing delivery responsibility — used to segment lead time analysis by delivery terms."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Indicates whether EDI is enabled for this agreement — used to assess digital-ordering coverage across lead time agreements."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Indicates whether VMI is enabled for this agreement — used to segment VMI vs. traditional replenishment agreements."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the agreement became effective — enables cohort analysis of lead time agreement portfolio."
    - name: "effective_end_date"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the agreement expires — used to flag upcoming expirations and ensure continuity of supply terms."
  measures:
    - name: "avg_fill_rate_sla_percent"
      expr: AVG(CAST(fill_rate_sla_percent AS DOUBLE))
      comment: "Average fill rate SLA commitment across lead time agreements — measures the contractual fill rate standard the vendor is held to."
    - name: "avg_on_time_delivery_sla_percent"
      expr: AVG(CAST(on_time_delivery_sla_percent AS DOUBLE))
      comment: "Average on-time delivery SLA commitment across agreements — measures the contractual delivery reliability standard."
    - name: "avg_compliance_penalty_rate"
      expr: AVG(CAST(compliance_penalty_rate AS DOUBLE))
      comment: "Average compliance penalty rate across lead time agreements — measures the financial deterrent built into SLA agreements."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across lead time agreements — informs replenishment planning and working-capital requirements."
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN lead_time_agreement_id END)
      comment: "Number of currently active lead time agreements — baseline KPI for supply-chain SLA coverage across the vendor base."
    - name: "agreements_expiring_within_90_days_count"
      expr: COUNT(DISTINCT CASE WHEN effective_end_date <= ADD_MONTHS(CURRENT_DATE(), 3) AND effective_end_date >= CURRENT_DATE() THEN lead_time_agreement_id END)
      comment: "Number of lead time agreements expiring within 90 days — supply-chain risk KPI used to prioritise SLA renegotiation and prevent replenishment disruptions."
    - name: "vmi_enabled_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN lead_time_agreement_id END)
      comment: "Number of lead time agreements with VMI enabled — measures VMI programme coverage across the supplier base."
$$;