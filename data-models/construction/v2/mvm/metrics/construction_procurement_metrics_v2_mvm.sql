-- Metric views for domain: procurement | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order portfolio management — tracks committed spend, amendment activity, retention exposure, and tax liability across the active PO book. Used by procurement leadership to govern spend, monitor contract changes, and assess vendor commitments."
  source: "`vibe_construction_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) — primary filter for active spend analysis."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Framework) — used to segment spend by procurement strategy."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — identifies orders pending approval vs. fully authorised, critical for spend governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — required for multi-currency spend normalisation."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms agreed with the vendor — affects logistics cost allocation and risk transfer point."
    - name: "gmp_flag"
      expr: gmp_flag
      comment: "Indicates whether the PO is subject to a Guaranteed Maximum Price clause — key for cost-ceiling risk management."
    - name: "issued_date_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the PO was issued — enables trend analysis of procurement activity over time."
    - name: "promised_delivery_date_month"
      expr: DATE_TRUNC('MONTH', promised_delivery_date)
      comment: "Month the vendor promised delivery — used to forecast material availability and schedule risk."
    - name: "last_amendment_type"
      expr: last_amendment_type
      comment: "Type of the most recent amendment applied to the PO — helps categorise change-order drivers (scope, price, schedule)."
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed spend across all purchase orders in scope. Core procurement spend KPI used in budget vs. commitment reporting."
    - name: "original_po_value"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Sum of original PO values before any amendments. Baseline for measuring scope creep and change-order impact."
    - name: "cumulative_amendment_value"
      expr: SUM(CAST(cumulative_amendment_value AS DOUBLE))
      comment: "Total value added or removed through amendments across all POs. Directly measures change-order cost exposure."
    - name: "avg_amendment_value_per_po"
      expr: AVG(CAST(cumulative_amendment_value AS DOUBLE))
      comment: "Average amendment value per purchase order. Elevated values signal systemic scope instability or poor initial scoping."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across all POs. Represents cash flow liability to vendors upon project completion milestones."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Aggregate tax liability across the PO portfolio. Used for tax reporting and cash flow forecasting."
    - name: "total_gmp_amount"
      expr: SUM(CAST(gmp_amount AS DOUBLE))
      comment: "Total Guaranteed Maximum Price exposure across GMP-flagged POs. Critical for cost-ceiling risk management on lump-sum contracts."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement workload and vendor engagement tracking."
    - name: "amended_po_count"
      expr: COUNT(CASE WHEN cumulative_amendment_value <> 0 THEN purchase_order_id END)
      comment: "Number of POs that have been amended at least once. High counts indicate scope instability or vendor negotiation activity."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage held across POs. Benchmarks retention policy consistency and vendor cash flow impact."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs tracking ordered vs. received vs. invoiced quantities and values, delivery performance, and outstanding commitments. Used by procurement and finance teams to manage open commitments, identify delivery shortfalls, and reconcile three-way match."
  source: "`vibe_construction_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line (e.g. Open, Partially Delivered, Closed) — primary filter for open commitment analysis."
    - name: "item_category"
      expr: item_category
      comment: "SAP item category of the PO line (e.g. Standard, Service, Subcontracting) — drives procurement and goods receipt behaviour."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification of the line item — enables spend analysis by commodity category."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the PO line — required for multi-currency spend analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the PO line — used for tax liability analysis and compliance reporting."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms for the PO line — affects logistics cost allocation."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month the PO line is scheduled for delivery — used for delivery schedule analysis and material planning."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating whether a goods receipt is required for this line — distinguishes service lines from material lines."
    - name: "deletion_indicator"
      expr: deletion_indicator
      comment: "Flag indicating the PO line has been logically deleted — used to exclude cancelled lines from active commitment reporting."
  measures:
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net committed value across all PO lines. Primary spend commitment KPI for open order book management."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across PO lines. Baseline for delivery fulfilment and inventory planning."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity confirmed received via goods receipt. Measures physical delivery progress against orders."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total quantity still outstanding for delivery. Directly measures open delivery exposure and supply chain risk."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced by vendors. Used in three-way match reconciliation against ordered and received quantities."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across PO lines. Used for tax liability reporting and cash flow forecasting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines. Benchmarks pricing consistency and identifies outliers for vendor negotiation."
    - name: "avg_over_delivery_tolerance"
      expr: AVG(CAST(over_delivery_tolerance_percent AS DOUBLE))
      comment: "Average over-delivery tolerance percentage. High tolerances increase risk of excess inventory and unplanned spend."
    - name: "avg_under_delivery_tolerance"
      expr: AVG(CAST(under_delivery_tolerance_percent AS DOUBLE))
      comment: "Average under-delivery tolerance percentage. Low tolerances signal strict delivery requirements on critical materials."
    - name: "active_line_count"
      expr: COUNT(CASE WHEN deletion_indicator = FALSE THEN po_line_id END)
      comment: "Count of active (non-deleted) PO lines. Measures the live open order book size for workload and commitment tracking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs measuring delivery fulfilment, quality acceptance, variance, and inspection outcomes. Used by procurement, warehouse, and quality teams to track vendor delivery performance, identify shortfalls, and manage rejected materials."
  source: "`vibe_construction_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome for the goods receipt (e.g. Passed, Failed, Pending) — primary dimension for quality performance analysis."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Physical condition of goods upon receipt (e.g. Good, Damaged, Partial) — used to track delivery quality issues."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for the goods receipt transaction — distinguishes standard receipts, returns, and reversals."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the goods receipt — required for multi-currency value analysis."
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location where goods were received — used for inventory placement and warehouse capacity analysis."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transport used for delivery — used to analyse logistics cost and delivery reliability by carrier type."
    - name: "delivery_completed_flag"
      expr: delivery_completed_flag
      comment: "Indicates whether the delivery is fully complete — used to identify partially fulfilled orders."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the goods receipt has been reversed — used to exclude reversed transactions from fulfilment metrics."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of goods receipt — enables trend analysis of delivery volumes and vendor performance over time."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the goods receipt was posted in the system — used for period-based inventory and spend reporting."
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of goods received. Core KPI for tracking actual material spend and goods-in flow against PO commitments."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Measures physical delivery volume for inventory and fulfilment tracking."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered as recorded on the goods receipt. Baseline for computing delivery fill rates."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt. High rejection volumes signal vendor quality issues requiring corrective action."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price at goods receipt. Used to detect price variances against PO unit prices and standard costs."
    - name: "receipt_count"
      expr: COUNT(CASE WHEN reversal_flag = FALSE THEN goods_receipt_id END)
      comment: "Count of non-reversed goods receipts. Measures actual delivery transaction volume for vendor activity tracking."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN goods_receipt_id END)
      comment: "Count of reversed goods receipts. Elevated reversals indicate data quality issues, disputes, or delivery errors."
    - name: "rejected_receipt_count"
      expr: COUNT(CASE WHEN rejected_quantity > 0 THEN goods_receipt_id END)
      comment: "Number of receipts with at least one unit rejected. Used to measure vendor quality failure frequency."
    - name: "avg_invoice_verification_status"
      expr: AVG(CAST(invoice_verification_status AS DOUBLE))
      comment: "Average invoice verification status value across receipts. Used to monitor three-way match completion rates at the receipt level."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice KPIs tracking payables volume, dispute exposure, retention liability, tax obligations, and three-way match compliance. Used by finance and procurement leadership to manage cash flow, resolve disputes, and ensure invoice processing governance."
  source: "`vibe_construction_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO / GR / Invoice) — primary governance dimension for invoice approval and payment release."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification status in the system — used to track invoices pending review vs. cleared for payment."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute — critical for payables risk and vendor relationship management."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — required for multi-currency payables analysis and FX exposure reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice — used for period-based financial reporting and year-over-year payables analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — enables monthly accrual and payables aging analysis within a fiscal year."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice — used for tax liability analysis and compliance reporting."
    - name: "blocked_reason"
      expr: blocked_reason
      comment: "Reason the invoice is blocked from payment — used to categorise and resolve payment holds systematically."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross payables value across all vendor invoices. Primary KPI for accounts payable volume and cash flow forecasting."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net payables after discounts and deductions. Used for actual cash outflow forecasting and budget reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across vendor invoices. Required for tax reporting, VAT reclaim, and compliance obligations."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from vendor invoices. Represents deferred payment liability released upon project milestones."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured across invoices. Measures the financial benefit of prompt payment programmes."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for statutory tax compliance and vendor remittance reporting."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN vendor_invoice_id END)
      comment: "Number of invoices currently under dispute. High counts signal vendor relationship issues or systemic process failures."
    - name: "disputed_invoice_gross_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(invoice_gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross value of disputed invoices. Quantifies financial exposure from unresolved invoice disputes."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(invoice_net_amount AS DOUBLE))
      comment: "Average net invoice value. Benchmarks typical invoice size for vendor segmentation and processing cost analysis."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices processed. Baseline volume metric for AP workload and vendor billing activity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs for supplier base governance — tracks prequalification scores, bonding capacity, insurance compliance, and vendor segmentation. Used by procurement leadership to manage the approved vendor list, assess financial health, and enforce compliance."
  source: "`vibe_construction_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g. Active, Suspended, Blacklisted) — primary filter for approved vendor list management."
    - name: "classification"
      expr: classification
      comment: "Vendor classification tier (e.g. Preferred, Approved, Conditional) — used to segment vendor base by strategic importance."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Diversity classification of the vendor (e.g. MBE, WBE, SBE) — required for diversity spend reporting and compliance targets."
    - name: "credit_rating"
      expr: credit_rating
      comment: "External credit rating of the vendor — used to assess financial stability and payment risk."
    - name: "country_code"
      expr: country_code
      comment: "Country of the vendor — used for geographic spend analysis, import compliance, and supply chain risk assessment."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether the vendor is on the preferred vendor list — used to track preferred vendor utilisation rates."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic regions the vendor can service — used for project-to-vendor matching and supply chain resilience planning."
  measures:
    - name: "total_bonding_capacity"
      expr: SUM(CAST(bonding_capacity_amount AS DOUBLE))
      comment: "Total bonding capacity across the vendor base. Measures the aggregate financial guarantee available for project risk coverage."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(prequalification_score AS DOUBLE))
      comment: "Average vendor prequalification score. Benchmarks overall vendor base quality and identifies segments needing development."
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Average annual revenue of vendors. Used to assess vendor financial capacity relative to contract values being awarded."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Total annual revenue across the vendor base. Indicates the aggregate financial scale of the supply chain ecosystem."
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN vendor_id END)
      comment: "Number of active vendors. Measures the size of the approved vendor pool available for procurement activities."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN vendor_id END)
      comment: "Number of preferred vendors. Used to track preferred vendor list size and concentration risk."
    - name: "suspended_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Suspended' THEN vendor_id END)
      comment: "Number of currently suspended vendors. Elevated counts signal supply chain risk and procurement compliance issues."
    - name: "insurance_expired_vendor_count"
      expr: COUNT(CASE WHEN insurance_expiry_date < CURRENT_DATE() THEN vendor_id END)
      comment: "Number of vendors with expired insurance certificates. Directly measures compliance exposure and contract award risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor qualification KPIs measuring HSE performance, quality certification compliance, financial health, and delivery reliability across the supply chain. Used by procurement and HSE leadership to enforce prequalification standards and manage vendor risk."
  source: "`vibe_construction_v1`.`procurement`.`vendor_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status of the vendor (e.g. Qualified, Expired, Suspended) — primary filter for approved vendor compliance."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification assessment (e.g. Full, Conditional, Expedited) — used to segment qualification rigour."
    - name: "qualification_category"
      expr: qualification_category
      comment: "Category of work the vendor is qualified for (e.g. Civil, Electrical, Mechanical) — used for trade-specific vendor pool analysis."
    - name: "hse_performance_rating"
      expr: hse_performance_rating
      comment: "HSE performance rating assigned during qualification — primary dimension for safety-based vendor segmentation."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Indicates ISO 9001 quality management certification — used to filter vendors meeting quality system requirements."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Indicates ISO 14001 environmental management certification — used for green procurement and environmental compliance reporting."
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "Indicates ISO 45001 occupational health and safety certification — critical for HSE-gated vendor approval processes."
    - name: "insurance_workers_comp_verified"
      expr: insurance_workers_comp_verified
      comment: "Indicates whether workers compensation insurance has been verified — mandatory compliance check for site access."
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic regions covered by the qualification — used for project-to-vendor matching by location."
  measures:
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score across qualified vendors. Low scores signal supply chain financial risk and potential vendor failure."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score. Benchmarks the technical competence of the qualified vendor pool for complex project delivery."
    - name: "avg_past_performance_score"
      expr: AVG(CAST(past_performance_score AS DOUBLE))
      comment: "Average past performance score. Directly measures historical delivery quality and is a leading indicator of future performance."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across qualified vendors. Key supply chain reliability KPI used in vendor scorecards."
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate across vendors. Elevated rates trigger quality audits and potential disqualification actions."
    - name: "avg_trir_rate"
      expr: AVG(CAST(trir_rate AS DOUBLE))
      comment: "Average Total Recordable Incident Rate (TRIR) across vendors. Primary HSE KPI for vendor safety performance benchmarking."
    - name: "avg_lti_frequency_rate"
      expr: AVG(CAST(lti_frequency_rate AS DOUBLE))
      comment: "Average Lost Time Injury Frequency Rate across vendors. Critical safety metric used to enforce HSE prequalification thresholds."
    - name: "total_bonding_capacity"
      expr: SUM(CAST(bonding_capacity_limit AS DOUBLE))
      comment: "Total bonding capacity limit across all qualified vendors. Measures aggregate financial guarantee available for project risk coverage."
    - name: "avg_insurance_general_liability_limit"
      expr: AVG(CAST(insurance_general_liability_limit AS DOUBLE))
      comment: "Average general liability insurance limit across qualified vendors. Used to verify adequate coverage relative to contract values."
    - name: "qualified_vendor_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN vendor_qualification_id END)
      comment: "Number of currently qualified vendors. Measures the size of the compliant vendor pool available for contract award."
    - name: "iso_9001_certified_count"
      expr: COUNT(CASE WHEN iso_9001_certified = TRUE THEN vendor_qualification_id END)
      comment: "Number of vendors with active ISO 9001 certification. Used to track quality system compliance across the supply chain."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs tracking demand origination, budget availability, conversion to PO, and procurement cycle efficiency. Used by procurement and project management to govern demand planning, enforce budget controls, and measure requisition-to-order cycle performance."
  source: "`vibe_construction_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g. Open, Approved, Converted, Rejected) — primary filter for demand pipeline analysis."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of purchase requisition (e.g. Standard, Emergency, Blanket) — used to segment demand by procurement strategy."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency level of the requisition (e.g. Routine, Urgent, Critical) — used to prioritise procurement actions and measure emergency demand frequency."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department that originated the requisition — used for demand analysis by organisational unit and budget accountability."
    - name: "material_group"
      expr: material_group
      comment: "Material group of the requisitioned item — enables spend category analysis at the demand origination stage."
    - name: "procurement_strategy"
      expr: procurement_strategy
      comment: "Procurement strategy assigned to the requisition (e.g. Competitive Bid, Single Source) — used to track sourcing strategy compliance."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of conversion from PR to PO — used to track requisition-to-order pipeline progress."
    - name: "technical_specification_attached"
      expr: technical_specification_attached
      comment: "Indicates whether a technical specification is attached — used to measure requisition quality and completeness."
    - name: "requisition_date_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the requisition was raised — enables trend analysis of procurement demand over time."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all purchase requisitions. Measures the aggregate demand value entering the procurement pipeline."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across requisitions. Used to benchmark pricing expectations before vendor sourcing."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance across requisitions. Positive variance indicates demand exceeding budget — triggers budget review actions."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity requested across all requisitions. Baseline for material demand planning and inventory replenishment analysis."
    - name: "converted_pr_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN purchase_requisition_id END)
      comment: "Number of requisitions successfully converted to purchase orders. Measures procurement pipeline throughput and conversion efficiency."
    - name: "rejected_pr_count"
      expr: COUNT(CASE WHEN pr_status = 'Rejected' THEN purchase_requisition_id END)
      comment: "Number of rejected requisitions. High rejection rates signal poor demand planning quality or budget non-compliance."
    - name: "urgent_pr_count"
      expr: COUNT(CASE WHEN urgency_classification = 'Urgent' OR urgency_classification = 'Critical' THEN purchase_requisition_id END)
      comment: "Number of urgent or critical requisitions. Elevated counts indicate reactive procurement behaviour and planning failures."
    - name: "pr_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions. Baseline volume metric for procurement demand pipeline sizing."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) KPIs measuring sourcing competitiveness, bid bond exposure, vendor engagement, and award values. Used by procurement leadership to evaluate sourcing strategy effectiveness, vendor market engagement, and competitive bidding compliance."
  source: "`vibe_construction_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g. Open, Closed, Awarded, Cancelled) — primary filter for active sourcing pipeline analysis."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g. Open Tender, Selective Tender, Direct Award) — used to track sourcing strategy compliance and competitive bidding rates."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type associated with the RFQ (e.g. Lump Sum, Unit Rate, Cost Plus) — used to segment sourcing by commercial model."
    - name: "issuing_department"
      expr: issuing_department
      comment: "Department that issued the RFQ — used for procurement activity analysis by organisational unit."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RFQ — required for multi-currency award value analysis."
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Indicates whether a bid bond is required — used to track financial security requirements across the sourcing portfolio."
    - name: "vendor_prequalification_required"
      expr: vendor_prequalification_required
      comment: "Indicates whether vendor prequalification is mandatory for this RFQ — used to enforce supply chain governance standards."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued — enables trend analysis of sourcing activity over time."
    - name: "award_date_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month the RFQ was awarded — used to measure sourcing cycle duration and award activity trends."
  measures:
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ processes. Primary KPI for measuring sourcing output and spend under management."
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average award value per RFQ. Used to benchmark contract sizes and identify outliers requiring additional governance."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value across RFQs. Measures aggregate financial security held during the tender evaluation period."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across RFQs. Benchmarks retention policy consistency across the sourcing portfolio."
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline metric for sourcing activity volume and procurement team workload."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN rfq_id END)
      comment: "Number of RFQs that have been awarded. Measures sourcing pipeline conversion and procurement cycle completion."
    - name: "cancelled_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Cancelled' THEN rfq_id END)
      comment: "Number of cancelled RFQs. High cancellation rates signal scope instability, budget issues, or poor demand planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_sourcing_info_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing information record KPIs tracking vendor pricing, lead times, minimum order quantities, and preferred supplier status. Used by procurement to benchmark vendor pricing, manage approved source lists, and optimise material sourcing decisions."
  source: "`vibe_construction_v1`.`procurement`.`sourcing_info_record`"
  dimensions:
    - name: "sourcing_info_record_status"
      expr: sourcing_info_record_status
      comment: "Status of the sourcing info record (e.g. Active, Expired, Blocked) — primary filter for valid pricing and sourcing data."
    - name: "preferred_flag"
      expr: preferred_flag
      comment: "Indicates whether this vendor-material combination is the preferred source — used to track preferred source utilisation."
    - name: "price_currency_code"
      expr: price_currency_code
      comment: "Currency of the sourcing price — required for multi-currency price benchmarking."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the sourcing record became effective — used to track price change history and sourcing agreement renewals."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the sourcing record expires — used to proactively identify records requiring renewal before expiry."
  measures:
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average vendor unit price across sourcing records. Core price benchmarking KPI for vendor comparison and negotiation."
    - name: "min_unit_price"
      expr: MIN(CAST(unit_price AS DOUBLE))
      comment: "Minimum unit price available across sourcing records. Identifies the best available price for procurement optimisation."
    - name: "max_unit_price"
      expr: MAX(CAST(unit_price AS DOUBLE))
      comment: "Maximum unit price across sourcing records. Used to identify price outliers and negotiate reductions with high-cost vendors."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average vendor lead time in days. Critical for material planning and schedule risk assessment on construction projects."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across sourcing records. Used to optimise order sizing and reduce excess inventory risk."
    - name: "active_sourcing_record_count"
      expr: COUNT(CASE WHEN sourcing_info_record_status = 'Active' THEN sourcing_info_record_id END)
      comment: "Number of active sourcing info records. Measures the breadth of the approved source list for material procurement."
    - name: "preferred_source_count"
      expr: COUNT(CASE WHEN preferred_flag = TRUE THEN sourcing_info_record_id END)
      comment: "Number of preferred vendor-material sourcing records. Used to track preferred source coverage across the material catalogue."
$$;