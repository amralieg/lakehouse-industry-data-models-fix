-- Metric views for domain: procurement | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order portfolio management — tracks committed spend, amendment activity, retention exposure, and delivery performance across the construction procurement lifecycle."
  source: "`construction_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Draft, Approved, Closed) — used to filter active vs. closed commitments."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Framework, Subcontract) — drives spend category analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — identifies orders pending approval that may be blocking procurement progress."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — essential for multi-currency spend consolidation."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (e.g. DDP, FOB, CIF) — affects landed cost and delivery risk allocation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms — used to model cash flow obligations and working capital exposure."
    - name: "gmp_flag"
      expr: gmp_flag
      comment: "Indicates whether the PO is subject to a Guaranteed Maximum Price — flags cost-ceiling contracts for budget risk monitoring."
    - name: "issued_date_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the PO was issued — enables trend analysis of procurement commitment volumes over time."
    - name: "promised_delivery_date_month"
      expr: DATE_TRUNC('MONTH', promised_delivery_date)
      comment: "Month of promised delivery — used to project material arrival timelines against project schedules."
    - name: "last_amendment_type"
      expr: last_amendment_type
      comment: "Type of the most recent PO amendment (e.g. Scope Change, Price Adjustment) — identifies drivers of contract variation."
  measures:
    - name: "total_po_committed_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed procurement spend across all purchase orders — the primary spend commitment KPI for budget vs. actual tracking."
    - name: "total_original_po_value"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Sum of original PO values before amendments — baseline for measuring scope creep and cost growth."
    - name: "total_cumulative_amendment_value"
      expr: SUM(CAST(cumulative_amendment_value AS DOUBLE))
      comment: "Total value of all amendments across the PO portfolio — quantifies procurement scope change exposure."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across all POs — represents cash flow liability to vendors upon project completion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across the PO portfolio — required for financial reporting and tax compliance."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value — benchmarks typical contract size and flags outliers requiring additional scrutiny."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across POs — monitors vendor cash flow impact and contractual retention policy compliance."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement workload and portfolio size."
    - name: "gmp_po_count"
      expr: COUNT(CASE WHEN gmp_flag = TRUE THEN 1 END)
      comment: "Number of POs under Guaranteed Maximum Price — tracks cost-ceiling contract exposure in the portfolio."
    - name: "amended_po_count"
      expr: COUNT(CASE WHEN cumulative_amendment_value > 0 THEN 1 END)
      comment: "Number of POs that have been amended — measures procurement instability and scope change frequency."
    - name: "avg_gmp_amount"
      expr: AVG(CASE WHEN gmp_flag = TRUE THEN CAST(gmp_amount AS DOUBLE) END)
      comment: "Average GMP ceiling value for GMP-type POs — used to assess cost-ceiling adequacy against project budgets."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs tracking ordered vs. received vs. invoiced quantities, outstanding obligations, and unit economics — essential for goods receipt reconciliation and invoice matching."
  source: "`construction_ecm`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line (e.g. Open, Partially Delivered, Closed) — drives outstanding obligation reporting."
    - name: "item_category"
      expr: item_category
      comment: "SAP item category (e.g. Standard, Service, Consignment) — classifies procurement line type for spend analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification — enables spend analysis by commodity or material category."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the PO line — required for multi-currency spend consolidation."
    - name: "account_assignment_category"
      expr: account_assignment_category
      comment: "Account assignment category (e.g. Cost Center, WBS, Asset) — links procurement spend to financial cost objects."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating whether a goods receipt is required for this line — identifies lines subject to three-way matching."
    - name: "invoice_receipt_indicator"
      expr: invoice_receipt_indicator
      comment: "Flag indicating whether invoice receipt is required — used to identify lines in the invoice verification workflow."
    - name: "deletion_indicator"
      expr: deletion_indicator
      comment: "Indicates whether the PO line has been logically deleted — used to exclude cancelled lines from active obligation reporting."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of scheduled delivery for the PO line — used to project material arrival timelines."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms for the PO line — affects landed cost and delivery risk allocation at line level."
  measures:
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net committed value across all PO lines — primary line-level spend commitment KPI."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across PO lines — baseline for delivery completeness tracking."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity confirmed received via goods receipt — measures physical delivery progress against orders."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced by vendors — used for three-way match reconciliation against ordered and received quantities."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total quantity still outstanding for delivery — critical for expediting and supply chain risk management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across PO lines — required for tax liability reporting and financial close."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines — benchmarks procurement pricing and identifies price outliers."
    - name: "delivery_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(goods_receipt_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity confirmed received — measures vendor delivery fulfilment rate; below 100% signals open obligations."
    - name: "invoice_match_rate"
      expr: ROUND(100.0 * SUM(CAST(invoiced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been invoiced — identifies billing gaps and potential over-invoicing risks."
    - name: "po_line_count"
      expr: COUNT(1)
      comment: "Total number of active PO lines — measures procurement transaction volume and workload."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs measuring material delivery performance, quality acceptance, quantity variances, and receipt valuation — core to supply chain and site material management."
  source: "`construction_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome for the goods receipt (e.g. Passed, Failed, Pending) — drives material release decisions."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Physical condition of goods upon receipt (e.g. Good, Damaged, Partial) — flags quality and logistics issues."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for the goods receipt (e.g. 101 GR for PO, 122 Return) — classifies the nature of the inventory movement."
    - name: "invoice_verification_status"
      expr: invoice_verification_status
      comment: "Status of invoice verification for this receipt — identifies receipts pending financial matching."
    - name: "delivery_completed_flag"
      expr: delivery_completed_flag
      comment: "Indicates whether the delivery is fully complete — used to close open PO lines and release retention."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether this goods receipt has been reversed — reversed receipts must be excluded from net receipt calculations."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transport used for delivery (e.g. Road, Rail, Air, Sea) — used for logistics cost and lead time analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation — required for multi-currency spend reporting."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of goods receipt — enables trend analysis of material delivery volumes over time."
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location where materials were received — used for warehouse utilisation and inventory placement analysis."
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of goods received — primary financial KPI for material inflow and accrual reporting."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of materials received — measures physical delivery volume for supply chain tracking."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt — high rejection volumes signal vendor quality or logistics failures."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered per goods receipt document — baseline for delivery completeness calculation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received goods — used to benchmark procurement pricing and detect price variances."
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was rejected — key vendor quality KPI; high rates trigger vendor corrective action."
    - name: "delivery_fulfilment_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received — measures vendor delivery completeness; below 100% indicates open shortfalls."
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions — measures inbound material activity volume."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts — high reversal counts indicate data quality, logistics, or vendor issues."
    - name: "completed_delivery_count"
      expr: COUNT(CASE WHEN delivery_completed_flag = TRUE THEN 1 END)
      comment: "Number of fully completed deliveries — used to track PO line closure progress and vendor fulfilment."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice management KPIs — tracks invoice processing efficiency, payment obligations, dispute exposure, retention liabilities, and three-way match compliance."
  source: "`construction_ecm`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. Received, Approved, Paid, Blocked) — drives AP workflow and cash flow forecasting."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of vendor invoice (e.g. Standard, Credit Note, Advance) — classifies invoice flows for financial reporting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO / GR / Invoice) — identifies invoices that cannot be automatically cleared due to discrepancies."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification status — distinguishes verified invoices ready for payment from those requiring review."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute — disputed invoices represent payment risk and vendor relationship issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — required for multi-currency AP reporting and FX exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g. Bank Transfer, Cheque) — used for treasury and cash management planning."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms on the invoice — used to calculate due dates and early payment discount opportunities."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date — enables trend analysis of AP volumes and accrual timing."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — aligns AP reporting to financial close periods."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice — enables year-over-year AP spend comparison."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice value — primary AP spend KPI representing total vendor billing obligations."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice value after discounts — represents actual payment obligation excluding tax and withholding."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices — required for tax liability reporting and VAT/GST reconciliation."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld on invoices — represents deferred payment liability to vendors upon project completion."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted — required for statutory tax compliance and vendor remittance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment or commercial discounts captured — measures procurement savings from payment term optimisation."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(invoice_gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of invoices under dispute — quantifies financial exposure from unresolved vendor billing disputes."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices — measures AP transaction volume and processing workload."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under dispute — high counts signal systemic vendor billing or contract compliance issues."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute — key AP quality KPI; high rates indicate vendor or contract management failures."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(invoice_net_amount AS DOUBLE))
      comment: "Average net invoice value — benchmarks typical vendor billing size and identifies unusually large invoices for review."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage applied across invoices — monitors retention policy consistency and vendor cash flow impact."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_vendor_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance KPIs aggregating quality, HSE, financial health, and delivery scores — drives vendor prequalification, award decisions, and corrective action management."
  source: "`construction_ecm`.`procurement`.`vendor_evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of vendor evaluation (e.g. Annual Review, Post-Project, Prequalification) — classifies the evaluation context."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (e.g. In Progress, Completed, Approved) — tracks evaluation workflow completion."
    - name: "performance_grade"
      expr: performance_grade
      comment: "Overall performance grade assigned to the vendor (e.g. A, B, C, D) — primary vendor tiering KPI for award eligibility."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Vendor qualification status at time of evaluation — determines bid invitation eligibility."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether a corrective action plan is required — flags underperforming vendors needing intervention."
    - name: "bid_invitation_eligible_flag"
      expr: bid_invitation_eligible_flag
      comment: "Indicates whether the vendor is eligible for bid invitations — directly controls which vendors can be awarded new work."
    - name: "insurance_verified_flag"
      expr: insurance_verified_flag
      comment: "Indicates whether vendor insurance has been verified — compliance gate for vendor engagement."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of vendor evaluation — enables trend analysis of vendor performance over time."
    - name: "evaluation_period_start_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Start month of the evaluation period — used to align performance scores to project phases."
  measures:
    - name: "avg_overall_kpi_rating"
      expr: AVG(CAST(overall_kpi_rating AS DOUBLE))
      comment: "Average overall KPI rating across vendor evaluations — primary composite vendor performance score for portfolio benchmarking."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate across evaluations — measures vendor material and workmanship quality performance."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across vendor evaluations — key supply chain reliability KPI for vendor selection."
    - name: "avg_hse_rating_score"
      expr: AVG(CAST(hse_rating_score AS DOUBLE))
      comment: "Average HSE rating score — measures vendor health, safety, and environmental performance; critical for construction site safety."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score — assesses vendor engineering and execution competency for complex construction scopes."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score — monitors vendor financial stability to mitigate supply chain insolvency risk."
    - name: "avg_commercial_compliance_score"
      expr: AVG(CAST(commercial_compliance_score AS DOUBLE))
      comment: "Average commercial compliance score — measures vendor adherence to contractual commercial obligations."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score — measures vendor communication and issue resolution speed."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations requiring corrective action — measures the proportion of underperforming vendor engagements."
    - name: "bid_eligible_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN bid_invitation_eligible_flag = TRUE THEN vendor_id END)
      comment: "Number of distinct vendors currently eligible for bid invitations — measures the depth of the qualified vendor pool."
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of vendor evaluations conducted — measures vendor management activity and governance coverage."
    - name: "avg_bonding_limit_amount"
      expr: AVG(CAST(bonding_limit_amount AS DOUBLE))
      comment: "Average bonding capacity limit across evaluated vendors — assesses the financial surety capacity of the vendor pool for large contracts."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement demand management KPIs tracking requisition volumes, budget availability, conversion to PO, cost estimation accuracy, and urgency classification — drives procurement planning and budget control."
  source: "`construction_ecm`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g. Draft, Approved, Converted, Rejected) — tracks demand pipeline through the procurement funnel."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of purchase requisition (e.g. Material, Service, Capital) — classifies procurement demand by category."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency level of the requisition (e.g. Routine, Urgent, Emergency) — prioritises procurement processing and flags expediting needs."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of PR-to-PO conversion — identifies requisitions that have been converted, pending conversion, or cancelled."
    - name: "budget_available_flag"
      expr: budget_available_flag
      comment: "Indicates whether budget is available for the requisition — flags unfunded demand that may delay procurement."
    - name: "procurement_strategy"
      expr: procurement_strategy
      comment: "Procurement strategy applied (e.g. Open Market, Framework, Sole Source) — used for spend governance and compliance reporting."
    - name: "material_group"
      expr: material_group
      comment: "Material group of the requisitioned item — enables spend category analysis and category management."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department originating the requisition — used for demand attribution and budget accountability."
    - name: "technical_specification_attached"
      expr: technical_specification_attached
      comment: "Indicates whether a technical specification is attached — requisitions without specs are at risk of procurement delays."
    - name: "requisition_date_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the requisition was raised — enables trend analysis of procurement demand over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition cost estimate — required for multi-currency budget reporting."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all purchase requisitions — primary demand-side spend forecast KPI for budget planning."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance across requisitions — measures the gap between requisitioned cost and available budget; negative values signal budget overruns."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across requisitions — benchmarks unit pricing for category management and cost control."
    - name: "total_quantity_requisitioned"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity requisitioned — measures material demand volume for supply planning and vendor capacity assessment."
    - name: "pr_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions — measures procurement demand volume and workload."
    - name: "urgent_pr_count"
      expr: COUNT(CASE WHEN urgency_classification IN ('Urgent', 'Emergency') THEN 1 END)
      comment: "Number of urgent or emergency requisitions — high counts signal planning failures and expose the project to premium procurement costs."
    - name: "budget_unavailable_pr_count"
      expr: COUNT(CASE WHEN budget_available_flag = FALSE THEN 1 END)
      comment: "Number of requisitions without available budget — identifies unfunded demand that may delay procurement and impact project schedule."
    - name: "converted_pr_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END)
      comment: "Number of requisitions successfully converted to purchase orders — measures procurement pipeline throughput."
    - name: "pr_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions converted to POs — measures procurement funnel efficiency; low rates indicate approval or sourcing bottlenecks."
    - name: "spec_attachment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN technical_specification_attached = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions with technical specifications attached — low rates increase procurement risk and vendor query volumes."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing and tendering KPIs measuring RFQ competitiveness, award values, vendor participation, and procurement lead times — drives sourcing strategy and competitive bidding governance."
  source: "`construction_ecm`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g. Draft, Issued, Closed, Awarded, Cancelled) — tracks the tendering pipeline."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g. Open, Selective, Single Source) — classifies the sourcing approach for governance and compliance reporting."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type being tendered (e.g. Lump Sum, Unit Rate, Cost Plus) — affects risk allocation and bid evaluation criteria."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RFQ — required for multi-currency sourcing spend analysis."
    - name: "issuing_department"
      expr: issuing_department
      comment: "Department issuing the RFQ — used for procurement workload attribution and category management."
    - name: "vendor_prequalification_required"
      expr: vendor_prequalification_required
      comment: "Indicates whether vendor prequalification is required — flags high-risk or complex scopes requiring additional vendor vetting."
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Indicates whether a bid bond is required — used for high-value tender governance and vendor commitment assurance."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued — enables trend analysis of tendering activity over time."
    - name: "award_date_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month of RFQ award — used to track procurement cycle completion and award velocity."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms specified in the RFQ — affects landed cost and delivery risk in bid evaluation."
  measures:
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ processes — primary sourcing spend KPI measuring procurement commitment from competitive tendering."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value across RFQs — measures financial surety coverage in the tendering portfolio."
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average award value per RFQ — benchmarks typical contract size from competitive tendering."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage specified in RFQs — monitors retention policy consistency across the tendering portfolio."
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued — measures sourcing activity volume and procurement team workload."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END)
      comment: "Number of RFQs that have been awarded — measures sourcing pipeline conversion to contract."
    - name: "rfq_award_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs that result in an award — low rates indicate sourcing inefficiency, scope issues, or market availability problems."
    - name: "prequalification_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vendor_prequalification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs requiring vendor prequalification — measures the proportion of complex or high-risk scopes in the tendering portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_vendor_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid evaluation KPIs measuring quotation competitiveness, pricing, technical compliance, and evaluation scores — supports vendor selection and commercial negotiation decisions."
  source: "`construction_ecm`.`procurement`.`vendor_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the vendor quotation (e.g. Submitted, Under Evaluation, Awarded, Rejected) — tracks bid pipeline."
    - name: "technical_compliance_status"
      expr: technical_compliance_status
      comment: "Technical compliance outcome of the quotation (e.g. Compliant, Non-Compliant, Conditional) — gates commercial evaluation."
    - name: "award_recommendation"
      expr: award_recommendation
      comment: "Evaluator recommendation for award (e.g. Recommended, Not Recommended) — drives award decision documentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the vendor quotation — required for multi-currency bid comparison and normalisation."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms offered by the vendor — affects total landed cost and delivery risk in bid evaluation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the quoted goods — used for local content compliance and import duty assessment."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of quotation evaluation — enables trend analysis of bid evaluation activity."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', CAST(submission_timestamp AS DATE))
      comment: "Month of quotation submission — used to track bid receipt timelines against RFQ deadlines."
  measures:
    - name: "total_quoted_price"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total quoted price across all vendor quotations — measures total bid value received for budget benchmarking."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost quoted by vendors — measures logistics cost component of bids for landed cost analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across quotations — required for total cost of ownership calculation in bid evaluation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across vendor quotations — benchmarks market pricing for category management and negotiation."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score across quotations — measures overall bid quality and vendor competitiveness."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered by vendors — measures commercial negotiation outcomes and vendor pricing flexibility."
    - name: "quotation_count"
      expr: COUNT(1)
      comment: "Total number of vendor quotations received — measures market competition and vendor engagement in the tendering process."
    - name: "technically_compliant_count"
      expr: COUNT(CASE WHEN technical_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of technically compliant quotations — measures the depth of the technically qualified vendor pool for each tender."
    - name: "technical_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN technical_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotations that are technically compliant — low rates indicate specification clarity issues or vendor capability gaps."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_vendor_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor prequalification and compliance KPIs tracking qualification status, certification coverage, financial capacity, HSE performance, and delivery reliability — governs vendor pool quality and risk."
  source: "`construction_ecm`.`procurement`.`vendor_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the vendor (e.g. Qualified, Suspended, Expired, Pending) — primary gate for vendor engagement eligibility."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g. Material Supplier, Subcontractor, Consultant) — classifies vendor capability category."
    - name: "qualification_category"
      expr: qualification_category
      comment: "Procurement category for which the vendor is qualified — enables category-level vendor pool analysis."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Indicates whether the vendor holds ISO 9001 quality management certification — quality compliance gate for vendor selection."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Indicates whether the vendor holds ISO 14001 environmental management certification — environmental compliance gate."
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "Indicates whether the vendor holds ISO 45001 occupational health and safety certification — HSE compliance gate for construction vendors."
    - name: "insurance_workers_comp_verified"
      expr: insurance_workers_comp_verified
      comment: "Indicates whether workers compensation insurance has been verified — mandatory compliance check for construction site vendors."
    - name: "hse_performance_rating"
      expr: hse_performance_rating
      comment: "HSE performance rating of the vendor — used to tier vendors by safety performance for high-risk scope assignments."
    - name: "qualification_assessment_date_month"
      expr: DATE_TRUNC('MONTH', qualification_assessment_date)
      comment: "Month of qualification assessment — enables trend analysis of vendor qualification activity."
    - name: "qualification_expiry_date_month"
      expr: DATE_TRUNC('MONTH', qualification_expiry_date)
      comment: "Month of qualification expiry — used to proactively identify vendors requiring requalification before expiry."
  measures:
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score across qualified vendors — measures the overall technical competency of the vendor pool."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score — monitors vendor financial stability across the qualified pool to mitigate insolvency risk."
    - name: "avg_past_performance_score"
      expr: AVG(CAST(past_performance_score AS DOUBLE))
      comment: "Average past performance score — measures historical delivery and quality track record of the vendor pool."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across qualified vendors — key supply chain reliability KPI for vendor selection."
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate across vendors — measures material and workmanship quality performance of the vendor pool."
    - name: "avg_lti_frequency_rate"
      expr: AVG(CAST(lti_frequency_rate AS DOUBLE))
      comment: "Average Lost Time Injury frequency rate — critical HSE KPI for construction vendor safety performance benchmarking."
    - name: "avg_trir_rate"
      expr: AVG(CAST(trir_rate AS DOUBLE))
      comment: "Average Total Recordable Incident Rate — industry-standard HSE KPI measuring vendor safety performance."
    - name: "avg_bonding_capacity_limit"
      expr: AVG(CAST(bonding_capacity_limit AS DOUBLE))
      comment: "Average bonding capacity limit across qualified vendors — assesses the financial surety capacity of the vendor pool for large contract awards."
    - name: "avg_insurance_general_liability_limit"
      expr: AVG(CAST(insurance_general_liability_limit AS DOUBLE))
      comment: "Average general liability insurance limit — measures insurance coverage adequacy across the vendor pool."
    - name: "qualified_vendor_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of currently qualified vendors — measures the depth of the active vendor pool available for procurement."
    - name: "iso_9001_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_9001_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualified vendors with ISO 9001 certification — measures quality management system coverage across the vendor pool."
    - name: "iso_45001_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_45001_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualified vendors with ISO 45001 HSE certification — measures safety management system coverage; critical for construction site compliance."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_sourcing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement planning KPIs tracking sourcing strategy coverage, estimated spend, long-lead item management, critical path procurement, and plan execution status — drives procurement schedule alignment."
  source: "`construction_ecm`.`procurement`.`sourcing_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the sourcing plan (e.g. Draft, Approved, In Execution, Closed) — tracks procurement planning pipeline."
    - name: "sourcing_method"
      expr: sourcing_method
      comment: "Sourcing method applied (e.g. Open Tender, Selective Tender, Direct Award) — used for procurement governance and compliance reporting."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category of the sourcing plan — enables spend category analysis and category management."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type planned (e.g. Lump Sum, Unit Rate, Reimbursable) — affects risk allocation and commercial strategy."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether the procurement item is on the project critical path — critical path items require priority expediting."
    - name: "is_long_lead_item"
      expr: is_long_lead_item
      comment: "Indicates whether the item has a long procurement lead time — long-lead items require early sourcing to avoid schedule delays."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification of the procurement item (e.g. High, Medium, Low) — drives expediting frequency and management attention."
    - name: "expediting_required"
      expr: expediting_required
      comment: "Indicates whether expediting is required for this sourcing plan — flags items needing active vendor follow-up."
    - name: "supplier_prequalification_required"
      expr: supplier_prequalification_required
      comment: "Indicates whether supplier prequalification is required — flags complex or high-risk scopes needing additional vendor vetting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sourcing plan estimate — required for multi-currency procurement budget reporting."
    - name: "planned_award_date_month"
      expr: DATE_TRUNC('MONTH', planned_award_date)
      comment: "Month of planned award — used to project procurement commitment timelines against project schedules."
    - name: "planned_delivery_date_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month of planned delivery — used to align material arrival with construction activity schedules."
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated procurement value across all sourcing plans — primary procurement budget forecast KPI."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per sourcing plan — benchmarks typical procurement package size for resource planning."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage planned across sourcing plans — monitors retention policy consistency in procurement strategy."
    - name: "sourcing_plan_count"
      expr: COUNT(1)
      comment: "Total number of sourcing plans — measures procurement planning coverage and workload."
    - name: "critical_path_plan_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of sourcing plans on the project critical path — measures the volume of procurement items that directly drive project schedule."
    - name: "long_lead_item_count"
      expr: COUNT(CASE WHEN is_long_lead_item = TRUE THEN 1 END)
      comment: "Number of long-lead procurement items — measures schedule risk exposure from items requiring extended procurement lead times."
    - name: "critical_path_estimated_value"
      expr: SUM(CASE WHEN is_critical_path = TRUE THEN CAST(estimated_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated value of critical path procurement items — quantifies the financial exposure of schedule-critical procurement."
    - name: "expediting_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN expediting_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sourcing plans requiring expediting — high rates indicate procurement schedule pressure and vendor delivery risk."
    - name: "long_lead_value_concentration"
      expr: ROUND(100.0 * SUM(CASE WHEN is_long_lead_item = TRUE THEN CAST(estimated_value AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(estimated_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total estimated procurement value attributable to long-lead items — measures schedule risk concentration in the procurement portfolio."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`procurement_inspection_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material inspection and release KPIs tracking inspection outcomes, NCR volumes, document review compliance, and release certificate issuance — governs material quality gate performance."
  source: "`construction_ecm`.`procurement`.`inspection_release`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g. Pending, In Progress, Passed, Failed) — primary quality gate status for material release."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (e.g. Accepted, Rejected, Conditional Release) — drives material release or rejection decisions."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g. Dimensional, Visual, NDT, Factory Acceptance Test) — classifies inspection scope."
    - name: "document_review_status"
      expr: document_review_status
      comment: "Status of document review (e.g. Approved, Rejected, Pending) — tracks documentation compliance for material release."
    - name: "inspection_witness_required"
      expr: inspection_witness_required
      comment: "Indicates whether a third-party witness is required for the inspection — flags high-criticality inspections requiring client or authority presence."
    - name: "inspector_organization"
      expr: inspector_organization
      comment: "Organisation performing the inspection (e.g. Third-Party Inspector, Client, Internal QC) — used for inspection resource and cost analysis."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection — enables trend analysis of inspection activity and quality outcomes over time."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month of material release — used to track material release velocity against project delivery schedules."
  measures:
    - name: "inspection_release_count"
      expr: COUNT(1)
      comment: "Total number of inspection release records — measures material inspection activity volume and quality gate throughput."
    - name: "passed_inspection_count"
      expr: COUNT(CASE WHEN inspection_result = 'Accepted' THEN 1 END)
      comment: "Number of inspections with accepted outcome — measures successful material quality gate clearances."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_result = 'Rejected' THEN 1 END)
      comment: "Number of inspections with rejected outcome — high counts signal systemic vendor quality failures requiring corrective action."
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in acceptance — primary material quality KPI; low rates indicate vendor quality or specification compliance issues."
    - name: "witness_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_witness_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring third-party witness — measures the proportion of high-criticality material inspections in the portfolio."
    - name: "document_review_approved_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN document_review_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with approved document review — measures documentation compliance rate for material release."
    - name: "distinct_vendor_inspected_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with inspection release records — measures the breadth of vendor quality oversight coverage."
$$;