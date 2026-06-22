-- Metric views for domain: procurement | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order portfolio management — tracks committed spend, amendment activity, retention exposure, and approval cycle health across the procurement pipeline."
  source: "`vibe_construction_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Draft, Approved, Closed) for pipeline segmentation."
    - name: "po_type"
      expr: po_type
      comment: "Category of purchase order (e.g. Material, Service, Equipment) for spend category analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend reporting."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms governing risk transfer and logistics cost allocation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state to monitor bottlenecks in the PO authorization process."
    - name: "gmp_flag"
      expr: gmp_flag
      comment: "Indicates whether the PO is under a Guaranteed Maximum Price contract, affecting cost-ceiling exposure."
    - name: "issued_date"
      expr: DATE_TRUNC('month', issued_date)
      comment: "Month of PO issuance for trend analysis of procurement activity."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of PO approval for cycle-time benchmarking."
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed procurement spend across all purchase orders — primary spend exposure KPI for CFO and procurement leadership."
    - name: "total_original_po_value"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Baseline contracted value before amendments, used to quantify scope creep and change order impact."
    - name: "total_cumulative_amendment_value"
      expr: SUM(CAST(cumulative_amendment_value AS DOUBLE))
      comment: "Aggregate value of all amendments applied to POs — signals contract instability and budget overrun risk."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total cash withheld as retention across all POs — critical for cash-flow forecasting and vendor relationship management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability embedded in purchase orders for tax compliance and cost reporting."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value — benchmarks procurement deal size and identifies outlier transactions."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied across POs — informs vendor negotiation strategy and cash-flow planning."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement workload and pipeline sizing."
    - name: "gmp_po_count"
      expr: SUM(CASE WHEN gmp_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of POs under Guaranteed Maximum Price — quantifies cost-ceiling exposure in the portfolio."
    - name: "amendment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN amendment_count IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs that have been amended — high rates signal scope instability or poor initial specification quality."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-payable and invoice-processing KPIs — tracks invoice volumes, payment liability, dispute rates, retention deductions, and three-way match compliance for financial control."
  source: "`vibe_construction_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: CAST(invoice_status AS STRING)
      comment: "Current processing status of the invoice (e.g. Pending, Approved, Paid, Disputed) for AP pipeline monitoring."
    - name: "invoice_type"
      expr: CAST(invoice_type AS STRING)
      comment: "Classification of invoice (e.g. Standard, Credit Note, Advance) for financial categorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency payables reporting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO-GR-Invoice three-way match — key internal control indicator for payment authorization."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification outcome for audit and compliance tracking."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flags invoices under dispute — drives dispute resolution workload and cash-flow risk assessment."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-based financial reporting and budget reconciliation."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year for monthly accrual and payment cycle analysis."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of invoice approval for payment cycle benchmarking."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross payables across all vendor invoices — primary AP liability KPI for treasury and finance leadership."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net payables after discounts — actual cash outflow obligation for cash-flow forecasting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of vendor invoices for tax compliance and cost reporting."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from vendor invoices — tracks deferred payment obligations and vendor cash-flow impact."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted at source — regulatory compliance KPI for tax authorities."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment or negotiated discounts captured — measures procurement savings from payment terms optimization."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices — baseline AP workload volume metric."
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of invoices under active dispute — high counts signal vendor relationship or quality issues requiring intervention."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices in dispute — executive KPI for procurement quality and vendor compliance health."
    - name: "three_way_match_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN three_way_match_status = 'Matched' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices passing three-way match — critical internal control metric; low rates indicate process breakdown or fraud risk."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Average gross invoice value — benchmarks transaction size and identifies anomalous invoices for audit focus."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard KPIs — aggregates quality, HSE, delivery, financial health, and overall ratings to drive approved vendor list decisions and strategic sourcing."
  source: "`vibe_construction_v1`.`procurement`.`vendor_evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (e.g. Annual, Post-Project, Incident-Triggered) for performance trend segmentation."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation record for pipeline completeness monitoring."
    - name: "performance_grade"
      expr: performance_grade
      comment: "Overall performance grade assigned to the vendor — primary AVL classification driver."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Vendor qualification standing resulting from evaluation — determines bid eligibility."
    - name: "bid_invitation_eligible_flag"
      expr: bid_invitation_eligible_flag
      comment: "Whether the vendor is eligible for bid invitations based on evaluation outcome."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flags vendors requiring corrective action — drives supplier development intervention."
    - name: "evaluation_date"
      expr: DATE_TRUNC('quarter', evaluation_date)
      comment: "Quarter of evaluation for periodic performance trend analysis."
    - name: "evaluation_period_start_date"
      expr: DATE_TRUNC('year', evaluation_period_start_date)
      comment: "Evaluation period year for annual performance benchmarking."
  measures:
    - name: "avg_overall_kpi_rating"
      expr: AVG(CAST(overall_kpi_rating AS DOUBLE))
      comment: "Average overall KPI rating across evaluated vendors — headline vendor performance score for procurement leadership."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score — informs sourcing decisions for technically complex scopes."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate across vendors — directly linked to project quality outcomes and rework costs."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate — critical schedule performance indicator for supply chain reliability."
    - name: "avg_hse_rating_score"
      expr: AVG(CAST(hse_rating_score AS DOUBLE))
      comment: "Average HSE rating score — mandatory safety compliance KPI for vendor prequalification and site access decisions."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score — assesses vendor solvency risk and ability to sustain contract performance."
    - name: "avg_commercial_compliance_score"
      expr: AVG(CAST(commercial_compliance_score AS DOUBLE))
      comment: "Average commercial compliance score — measures adherence to contractual terms and payment obligations."
    - name: "vendor_evaluation_count"
      expr: COUNT(1)
      comment: "Total number of vendor evaluations completed — measures vendor management program activity."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vendors requiring corrective action — drives supplier development resource allocation."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations triggering corrective action — high rates signal systemic vendor quality issues."
    - name: "avg_bonding_limit_amount"
      expr: AVG(CAST(bonding_limit_amount AS DOUBLE))
      comment: "Average bonding capacity limit across evaluated vendors — informs maximum contract value that can be safely awarded."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor qualification and compliance KPIs — tracks certification status, financial capacity, HSE performance, and qualification pipeline health for approved vendor list governance."
  source: "`vibe_construction_v1`.`procurement`.`vendor_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification standing (e.g. Approved, Suspended, Expired) — primary AVL governance dimension."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g. Material Supplier, Subcontractor, Consultant) for category-specific compliance tracking."
    - name: "qualification_category"
      expr: qualification_category
      comment: "Commodity or service category for which the vendor is qualified — drives sourcing strategy by category."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 quality management certification status — mandatory for many project scopes."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "ISO 14001 environmental management certification status — required for environmentally sensitive scopes."
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "ISO 45001 occupational health and safety certification status — critical for site-based vendor selection."
    - name: "insurance_workers_comp_verified"
      expr: insurance_workers_comp_verified
      comment: "Workers compensation insurance verification status — legal compliance requirement for site access."
    - name: "qualification_assessment_date"
      expr: DATE_TRUNC('year', qualification_assessment_date)
      comment: "Year of qualification assessment for cohort-based compliance trend analysis."
    - name: "qualification_expiry_date"
      expr: DATE_TRUNC('quarter', qualification_expiry_date)
      comment: "Quarter of qualification expiry for proactive renewal pipeline management."
  measures:
    - name: "qualified_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendor qualification records — measures breadth of the approved vendor pool."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score across qualified vendors — benchmarks supply chain technical depth."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score — assesses aggregate solvency risk in the approved vendor pool."
    - name: "avg_past_performance_score"
      expr: AVG(CAST(past_performance_score AS DOUBLE))
      comment: "Average past performance score — primary predictor of future delivery reliability for sourcing decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across qualified vendors — supply chain schedule reliability benchmark."
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate — directly linked to project quality costs and rework exposure."
    - name: "avg_lti_frequency_rate"
      expr: AVG(CAST(lti_frequency_rate AS DOUBLE))
      comment: "Average Lost Time Injury frequency rate — mandatory HSE KPI for vendor safety performance governance."
    - name: "avg_trir_rate"
      expr: AVG(CAST(trir_rate AS DOUBLE))
      comment: "Average Total Recordable Incident Rate — industry-standard safety metric for vendor HSE compliance."
    - name: "avg_bonding_capacity_limit"
      expr: AVG(CAST(bonding_capacity_limit AS DOUBLE))
      comment: "Average bonding capacity across qualified vendors — determines maximum contract values that can be safely awarded."
    - name: "iso_9001_certified_count"
      expr: SUM(CASE WHEN iso_9001_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ISO 9001 certified vendors — measures quality management compliance depth in the vendor pool."
    - name: "iso_9001_certification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN iso_9001_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualified vendors holding ISO 9001 certification — quality compliance KPI for procurement governance."
    - name: "avg_insurance_general_liability_limit"
      expr: AVG(CAST(insurance_general_liability_limit AS DOUBLE))
      comment: "Average general liability insurance limit across qualified vendors — risk management KPI for contract award decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt and delivery performance KPIs — tracks received quantities, rejection rates, inspection outcomes, and delivery completeness to manage supply chain quality and schedule adherence."
  source: "`vibe_construction_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection outcome for received goods (e.g. Passed, Failed, Pending) — quality gate performance dimension."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Physical condition of goods on receipt (e.g. Good, Damaged, Partial) — supply chain quality indicator."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP/ERP movement type code for goods receipt classification and inventory accounting."
    - name: "delivery_completed_flag"
      expr: delivery_completed_flag
      comment: "Indicates whether the full PO delivery has been completed — tracks open delivery obligations."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed goods receipts — high reversal rates indicate receiving process or vendor quality issues."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transport used for delivery — informs logistics cost and lead-time analysis."
    - name: "receipt_date"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt for delivery volume trend analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of inventory posting for financial period reconciliation."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received — primary supply chain throughput KPI for material availability tracking."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all GR records — baseline for delivery completeness calculation."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt — directly measures supplier quality and incoming inspection effectiveness."
    - name: "total_goods_receipt_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of goods received — inventory asset recognition KPI for financial reporting."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received goods rejected — critical quality KPI; high rates trigger vendor corrective action and supply chain review."
    - name: "delivery_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PO lines with completed delivery — measures supply chain fulfillment reliability."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts reversed — high rates signal receiving errors or vendor disputes requiring process intervention."
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions — baseline receiving activity volume metric."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received goods — benchmarks procurement pricing against market rates and budget estimates."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ and competitive tendering KPIs — tracks bid activity, award values, vendor participation, and sourcing cycle performance to optimize the competitive procurement process."
  source: "`vibe_construction_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g. Draft, Issued, Closed, Awarded, Cancelled) for pipeline stage analysis."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g. Open, Selective, Single Source) for sourcing strategy compliance monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type associated with the RFQ (e.g. Lump Sum, Unit Rate, Cost Plus) for commercial strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "RFQ currency for multi-currency sourcing analysis."
    - name: "issuing_department"
      expr: issuing_department
      comment: "Department issuing the RFQ for procurement workload distribution analysis."
    - name: "vendor_prequalification_required"
      expr: vendor_prequalification_required
      comment: "Whether vendor prequalification is required — tracks compliance with procurement governance policy."
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Whether a bid bond is required — indicates high-value or high-risk procurement events."
    - name: "issue_date"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of RFQ issuance for procurement activity trend analysis."
    - name: "award_date"
      expr: DATE_TRUNC('quarter', award_date)
      comment: "Quarter of award for sourcing cycle time benchmarking."
  measures:
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ processes — primary competitive sourcing spend KPI for procurement leadership."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value required across RFQs — measures financial security exposure in the tendering pipeline."
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued — baseline competitive procurement activity volume metric."
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average award value per RFQ — benchmarks deal size and identifies outlier procurements for governance review."
    - name: "avg_invited_vendor_count"
      expr: AVG(CAST(invited_vendor_count AS DOUBLE))
      comment: "Average number of vendors invited per RFQ — measures market competition level in sourcing events."
    - name: "avg_response_count"
      expr: AVG(CAST(response_count AS DOUBLE))
      comment: "Average number of vendor responses per RFQ — low response rates signal market access or specification quality issues."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage applied in RFQ awards — informs cash-flow planning for awarded contracts."
    - name: "awarded_rfq_count"
      expr: SUM(CASE WHEN rfq_status = 'Awarded' THEN 1 ELSE 0 END)
      comment: "Number of RFQs successfully awarded — measures sourcing pipeline conversion effectiveness."
    - name: "cancelled_rfq_count"
      expr: SUM(CASE WHEN rfq_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled RFQs — high cancellation rates signal poor scope definition or budget instability."
    - name: "award_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN rfq_status = 'Awarded' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs resulting in award — measures sourcing process efficiency and pipeline conversion."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor quotation evaluation KPIs — tracks pricing competitiveness, technical compliance, evaluation scores, and discount capture to optimize vendor selection and commercial outcomes."
  source: "`vibe_construction_v1`.`procurement`.`vendor_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the vendor quotation (e.g. Submitted, Under Evaluation, Awarded, Rejected) for evaluation pipeline tracking."
    - name: "technical_compliance_status"
      expr: technical_compliance_status
      comment: "Technical compliance outcome — filters non-compliant bids from commercial evaluation."
    - name: "currency_code"
      expr: currency_code
      comment: "Quotation currency for multi-currency price comparison."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms offered by vendor — affects total landed cost comparison."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for materials — relevant for import duty, local content, and supply chain risk analysis."
    - name: "submission_timestamp"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of quotation submission for bid activity trend analysis."
    - name: "evaluation_date"
      expr: DATE_TRUNC('quarter', evaluation_date)
      comment: "Quarter of evaluation completion for sourcing cycle time benchmarking."
  measures:
    - name: "total_quoted_price"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total quoted price across all vendor quotations — measures aggregate market pricing for budget validation."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost component across quotations — identifies logistics cost as a proportion of total procurement spend."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component across vendor quotations for tax liability forecasting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across quotations — primary price benchmarking KPI for competitive sourcing analysis."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score across quotations — measures overall vendor response quality for sourcing decisions."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount offered by vendors — measures commercial negotiation leverage and savings capture."
    - name: "quotation_count"
      expr: COUNT(1)
      comment: "Total number of vendor quotations received — measures market competition and sourcing event participation."
    - name: "technically_compliant_count"
      expr: SUM(CASE WHEN technical_compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Number of technically compliant quotations — measures vendor capability to meet specification requirements."
    - name: "technical_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN technical_compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotations meeting technical requirements — low rates signal specification clarity issues or vendor capability gaps."
    - name: "avg_quoted_quantity"
      expr: AVG(CAST(quoted_quantity AS DOUBLE))
      comment: "Average quantity quoted per submission — identifies partial-bid patterns that affect supply security."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline KPIs — tracks demand origination, budget availability, conversion rates, and urgency classification to manage procurement demand and budget compliance."
  source: "`vibe_construction_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g. Draft, Approved, Converted, Rejected) for demand pipeline monitoring."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of requisition (e.g. Material, Service, Capital) for spend category demand analysis."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency level of the requisition — drives prioritization of procurement processing and expediting decisions."
    - name: "material_group"
      expr: material_group
      comment: "Material or service category for commodity-level demand analysis."
    - name: "procurement_strategy"
      expr: procurement_strategy
      comment: "Sourcing strategy assigned to the requisition (e.g. Competitive Bid, Single Source, Framework) for compliance monitoring."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department originating the requisition for demand attribution and budget accountability."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Whether the PR has been converted to a PO — measures procurement pipeline conversion efficiency."
    - name: "requisition_date"
      expr: DATE_TRUNC('month', requisition_date)
      comment: "Month of requisition creation for demand trend analysis."
    - name: "required_delivery_date"
      expr: DATE_TRUNC('month', required_delivery_date)
      comment: "Month of required delivery for procurement lead-time planning."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all purchase requisitions — primary demand-side spend forecast KPI for budget management."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance across requisitions — measures aggregate over/under-budget demand for financial control."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost — benchmarks demand-side pricing against approved budgets and market rates."
    - name: "pr_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions — baseline procurement demand volume metric."
    - name: "converted_pr_count"
      expr: SUM(CASE WHEN conversion_status = 'Converted' THEN 1 ELSE 0 END)
      comment: "Number of PRs successfully converted to purchase orders — measures procurement pipeline throughput."
    - name: "pr_conversion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN conversion_status = 'Converted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PRs converted to POs — low conversion rates signal approval bottlenecks or budget constraints."
    - name: "urgent_pr_count"
      expr: SUM(CASE WHEN urgency_classification = 'Urgent' THEN 1 ELSE 0 END)
      comment: "Number of urgent requisitions — high counts indicate poor procurement planning and drive premium sourcing costs."
    - name: "urgent_pr_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN urgency_classification = 'Urgent' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions classified as urgent — executive KPI for procurement planning maturity; high rates increase cost and risk."
    - name: "rejected_pr_count"
      expr: SUM(CASE WHEN pr_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Number of rejected requisitions — measures demand quality and approval process friction."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_po_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order amendment KPIs — tracks scope change frequency, value impact, schedule effects, and approval cycle for change management governance and cost control."
  source: "`vibe_construction_v1`.`procurement`.`po_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected) for change pipeline monitoring."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Quantity Change, Price Change, Delivery Date Change) for root-cause analysis of contract instability."
    - name: "amendment_reason"
      expr: amendment_reason
      comment: "Business reason for the amendment — drives root-cause analysis of scope creep and change drivers."
    - name: "currency_code"
      expr: currency_code
      comment: "Amendment currency for multi-currency change value reporting."
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Whether client approval is required — identifies high-governance amendments with external stakeholder impact."
    - name: "initiated_date"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month of amendment initiation for change activity trend analysis."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of amendment effectiveness for financial period impact analysis."
  measures:
    - name: "total_value_delta"
      expr: SUM(CAST(value_delta AS DOUBLE))
      comment: "Total net value change from all amendments — primary cost overrun KPI measuring cumulative scope creep impact."
    - name: "total_amended_po_value"
      expr: SUM(CAST(amended_po_value AS DOUBLE))
      comment: "Total revised PO value after amendments — measures current committed spend including all changes."
    - name: "total_original_po_value"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Total original PO value before amendments — baseline for calculating amendment-driven cost growth."
    - name: "amendment_count"
      expr: COUNT(1)
      comment: "Total number of PO amendments — measures contract instability and change management workload."
    - name: "avg_value_delta"
      expr: AVG(CAST(value_delta AS DOUBLE))
      comment: "Average value change per amendment — benchmarks amendment materiality for approval threshold calibration."
    - name: "avg_amended_quantity"
      expr: AVG(CAST(amended_quantity AS DOUBLE))
      comment: "Average quantity change per amendment — measures scope volatility in material and service procurement."
    - name: "client_approval_required_count"
      expr: SUM(CASE WHEN client_approval_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of amendments requiring client approval — measures external governance burden and approval cycle risk."
    - name: "client_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN client_approval_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments requiring client approval — high rates signal contract scope instability with client-facing impact."
    - name: "value_growth_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(value_delta AS DOUBLE)) / NULLIF(SUM(CAST(original_po_value AS DOUBLE)), 0), 2)
      comment: "Percentage increase in PO value due to amendments — executive KPI for procurement cost discipline and change order management effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_sourcing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing plan pipeline KPIs — tracks planned procurement value, critical path items, long-lead management, and sourcing strategy compliance to ensure on-time material and service availability."
  source: "`vibe_construction_v1`.`procurement`.`sourcing_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the sourcing plan (e.g. Draft, Approved, In Progress, Closed) for pipeline stage monitoring."
    - name: "sourcing_method"
      expr: sourcing_method
      comment: "Sourcing approach (e.g. Competitive Bid, Single Source, Framework Call-Off) for strategy compliance analysis."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Commodity or service category for category-level sourcing performance analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type planned for the sourcing event — informs commercial risk and pricing strategy."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flags sourcing plans on the project critical path — drives expediting priority and executive attention."
    - name: "is_long_lead_item"
      expr: is_long_lead_item
      comment: "Flags long-lead items requiring early procurement action — critical for schedule risk management."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk level of the sourcing plan — drives mitigation strategy and management escalation."
    - name: "currency_code"
      expr: currency_code
      comment: "Sourcing plan currency for multi-currency budget planning."
    - name: "planned_rfq_date"
      expr: DATE_TRUNC('month', planned_rfq_date)
      comment: "Month of planned RFQ issuance for procurement schedule adherence tracking."
    - name: "planned_award_date"
      expr: DATE_TRUNC('quarter', planned_award_date)
      comment: "Quarter of planned award for procurement pipeline forecasting."
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all sourcing plans — primary procurement pipeline value KPI for budget commitment forecasting."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per sourcing plan — benchmarks deal size for resource allocation and approval threshold calibration."
    - name: "sourcing_plan_count"
      expr: COUNT(1)
      comment: "Total number of sourcing plans — measures procurement pipeline volume and planning activity."
    - name: "critical_path_plan_count"
      expr: SUM(CASE WHEN is_critical_path = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sourcing plans on the project critical path — executive KPI for schedule-critical procurement risk exposure."
    - name: "long_lead_item_count"
      expr: SUM(CASE WHEN is_long_lead_item = TRUE THEN 1 ELSE 0 END)
      comment: "Number of long-lead item sourcing plans — drives early procurement action to prevent schedule delays."
    - name: "critical_path_value"
      expr: SUM(CASE WHEN is_critical_path = TRUE THEN estimated_value ELSE 0 END)
      comment: "Total estimated value of critical-path sourcing plans — quantifies financial exposure from schedule-critical procurement."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average planned retention percentage across sourcing plans — informs cash-flow planning for upcoming contract awards."
    - name: "expediting_required_count"
      expr: SUM(CASE WHEN expediting_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sourcing plans requiring active expediting — measures supply chain risk management workload."
    - name: "expediting_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN expediting_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sourcing plans requiring expediting — high rates signal procurement planning gaps or vendor delivery risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_bid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement bid evaluation KPIs — tracks bid competitiveness, award rates, technical and commercial scoring, and compliance to optimize vendor selection and sourcing outcomes."
  source: "`vibe_construction_v1`.`procurement`.`procurement_bid`"
  dimensions:
    - name: "bid_status"
      expr: bid_status
      comment: "Current status of the bid (e.g. Submitted, Under Evaluation, Awarded, Rejected) for evaluation pipeline tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Bid currency for multi-currency price comparison."
    - name: "is_awarded"
      expr: is_awarded
      comment: "Whether the bid was awarded — primary bid outcome dimension for win/loss analysis."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Whether the bid meets compliance requirements — filters non-compliant submissions from commercial evaluation."
    - name: "bid_submission_date"
      expr: DATE_TRUNC('month', bid_submission_date)
      comment: "Month of bid submission for procurement activity trend analysis."
    - name: "bid_validity_date"
      expr: DATE_TRUNC('quarter', bid_validity_date)
      comment: "Quarter of bid validity expiry for award timeline management."
  measures:
    - name: "total_bid_amount"
      expr: SUM(CAST(bid_amount AS DOUBLE))
      comment: "Total value of all bids received — measures aggregate market pricing for budget validation and competitive benchmarking."
    - name: "avg_bid_amount"
      expr: AVG(CAST(bid_amount AS DOUBLE))
      comment: "Average bid amount — primary price benchmarking KPI for competitive sourcing analysis."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average overall evaluation score across bids — measures vendor response quality for sourcing decisions."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical score — measures vendor technical capability relative to specification requirements."
    - name: "avg_commercial_score"
      expr: AVG(CAST(commercial_score AS DOUBLE))
      comment: "Average commercial score — measures pricing competitiveness and commercial terms quality."
    - name: "bid_count"
      expr: COUNT(1)
      comment: "Total number of bids received — measures market competition level in procurement events."
    - name: "awarded_bid_count"
      expr: SUM(CASE WHEN is_awarded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bids awarded — baseline award activity metric."
    - name: "compliant_bid_count"
      expr: SUM(CASE WHEN is_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Number of compliant bids — measures vendor ability to meet procurement requirements."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bids meeting compliance requirements — low rates signal specification clarity issues or vendor capability gaps."
    - name: "total_awarded_amount"
      expr: SUM(CASE WHEN is_awarded = TRUE THEN bid_amount ELSE 0 END)
      comment: "Total value of awarded bids — measures procurement commitment value from competitive bid events."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs — tracks vendor pool composition, financial capacity, prequalification scores, and diversity classification to govern the approved vendor list and strategic sourcing."
  source: "`vibe_construction_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current vendor status (e.g. Active, Suspended, Blocked, Inactive) — primary AVL governance dimension."
    - name: "classification"
      expr: classification
      comment: "Vendor classification (e.g. Tier 1, Tier 2, Preferred) for strategic sourcing segmentation."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Diversity category (e.g. Minority-Owned, Women-Owned, Small Business) for supplier diversity program tracking."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Vendor credit rating for financial risk assessment in contract award decisions."
    - name: "country_code"
      expr: country_code
      comment: "Vendor country for geographic supply chain risk and local content analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Flags preferred vendors — measures concentration of spend in preferred supplier relationships."
    - name: "currency_code"
      expr: currency_code
      comment: "Vendor default currency for multi-currency procurement planning."
    - name: "approval_date"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year of vendor approval for cohort-based vendor pool growth analysis."
  measures:
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the master list — measures breadth of the supply base."
    - name: "active_vendor_count"
      expr: SUM(CASE WHEN vendor_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active vendors — measures available supply base for sourcing events."
    - name: "preferred_vendor_count"
      expr: SUM(CASE WHEN preferred_vendor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of preferred vendors — measures strategic supplier relationship concentration."
    - name: "suspended_vendor_count"
      expr: SUM(CASE WHEN vendor_status = 'Suspended' THEN 1 ELSE 0 END)
      comment: "Number of suspended vendors — tracks supply base risk from vendor compliance failures."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(prequalification_score AS DOUBLE))
      comment: "Average prequalification score across vendors — measures overall supply base quality and capability."
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Average vendor annual revenue — assesses financial capacity of the supply base for large contract awards."
    - name: "avg_bonding_capacity"
      expr: AVG(CAST(bonding_capacity_amount AS DOUBLE))
      comment: "Average bonding capacity across vendors — determines maximum contract values that can be safely awarded to the supply base."
    - name: "preferred_vendor_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN preferred_vendor_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors classified as preferred — measures strategic sourcing concentration and supply base optimization."
    - name: "suspension_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vendor_status = 'Suspended' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors currently suspended — executive KPI for supply base compliance health and risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_inspection_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection and release KPIs — tracks inspection outcomes, NCR rates, document review compliance, and release cycle performance to ensure material and equipment quality before site delivery."
  source: "`vibe_construction_v1`.`procurement`.`inspection_release`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status (e.g. Pending, In Progress, Released, Rejected) for quality gate pipeline monitoring."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (e.g. Pass, Fail, Conditional Release) — primary quality decision dimension."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g. Factory Acceptance Test, Site Inspection, Document Review) for quality program coverage analysis."
    - name: "document_review_status"
      expr: document_review_status
      comment: "Status of associated document review — tracks documentation compliance alongside physical inspection."
    - name: "inspection_witness_required"
      expr: inspection_witness_required
      comment: "Whether third-party witness is required — identifies high-criticality inspections requiring external oversight."
    - name: "inspection_date"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of inspection for quality activity trend analysis."
    - name: "release_date"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month of material/equipment release for supply chain throughput analysis."
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of inspection and release records — baseline quality assurance activity volume metric."
    - name: "passed_inspection_count"
      expr: SUM(CASE WHEN inspection_result = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of inspections with passing results — measures quality gate effectiveness."
    - name: "failed_inspection_count"
      expr: SUM(CASE WHEN inspection_result = 'Fail' THEN 1 ELSE 0 END)
      comment: "Number of failed inspections — directly measures vendor quality non-conformance requiring corrective action."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passing — executive quality KPI; low rates trigger vendor corrective action and supply chain review."
    - name: "total_ncr_count"
      expr: SUM(CAST(ncr_count AS DOUBLE))
      comment: "Total number of non-conformance reports raised during inspections — measures cumulative quality defect volume in the supply chain."
    - name: "avg_ncr_count_per_inspection"
      expr: AVG(CAST(ncr_count AS DOUBLE))
      comment: "Average NCRs per inspection — benchmarks vendor quality performance and identifies systemic non-conformance patterns."
    - name: "witness_required_count"
      expr: SUM(CASE WHEN inspection_witness_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of inspections requiring third-party witness — measures high-criticality quality oversight workload."
    - name: "witness_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_witness_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring witness — tracks compliance with quality plan witness point requirements."
$$;