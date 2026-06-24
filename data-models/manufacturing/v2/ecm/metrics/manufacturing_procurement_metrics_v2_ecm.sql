-- Metric views for domain: procurement | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management: spend volume, approval cycle efficiency, delivery performance, and compliance posture. Used by CPO and procurement leadership to steer sourcing decisions and supplier performance."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g., Open, Closed, Cancelled) — primary filter for active spend analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Consignment) — drives sourcing strategy segmentation."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the PO — enables spend analysis by organizational unit."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group within the purchasing organization — supports buyer-level performance tracking."
    - name: "material_category"
      expr: material_category
      comment: "Category of material or service being procured — enables category-level spend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the PO — identifies bottlenecks in the approval pipeline."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against the PO — tracks fulfillment and open liability."
    - name: "invoice_receipt_status"
      expr: invoice_receipt_status
      comment: "Status of invoice receipt — identifies POs pending invoice matching."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance check result for the PO — flags policy or regulatory violations."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms governing delivery responsibility — relevant for logistics cost allocation."
    - name: "po_date_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Month of PO creation — enables trend analysis of procurement activity over time."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery — supports demand timing and capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the PO — required for multi-currency spend normalization."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method selected for the PO — informs freight cost and lead time analysis."
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Core procurement spend KPI used in budget vs. actuals and category spend reviews."
    - name: "total_net_po_value"
      expr: SUM(CAST(net_po_value AS DOUBLE))
      comment: "Net value of purchase orders excluding tax. Used for clean spend analysis and contract coverage calculations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders. Supports tax accrual and compliance reporting."
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume metric for procurement activity and buyer workload analysis."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average value per purchase order. Indicates procurement transaction size; large swings signal consolidation or fragmentation opportunities."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with active POs. Tracks supplier base concentration and diversification risk."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of POs awaiting approval. Identifies approval bottlenecks that delay procurement and impact supply continuity."
    - name: "open_po_count"
      expr: COUNT(CASE WHEN po_status = 'Open' THEN 1 END)
      comment: "Number of open (unfulfilled) purchase orders. Tracks outstanding procurement commitments and open liability."
    - name: "compliance_violation_po_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of POs flagged as non-compliant. Drives procurement policy enforcement and audit risk management."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms (days) across purchase orders. Informs working capital and cash flow planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs: invoice volume, payment performance, three-way match rates, and tolerance variance. Used by Finance and Procurement leadership to manage payables efficiency and supplier payment compliance."
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the supplier invoice (e.g., Posted, Blocked, Paid) — primary filter for AP pipeline analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Standard, Credit Memo, Debit Memo) — required for accurate AP aging and dispute analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Result of PO/GR/Invoice three-way match — key quality gate for invoice approval and payment release."
    - name: "tolerance_check_status"
      expr: tolerance_check_status
      comment: "Whether the invoice passed tolerance checks — identifies invoices requiring manual review."
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason an invoice is blocked from payment — drives root-cause analysis for AP bottlenecks."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization associated with the invoice — enables org-level AP performance tracking."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group associated with the invoice — supports buyer accountability for invoice quality."
    - name: "material_category"
      expr: material_category
      comment: "Category of goods or services invoiced — enables category-level AP analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date — supports AP aging and payment trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month invoice was posted to the ledger — aligns AP data with financial period close."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — required for multi-currency AP reporting and FX exposure analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity associated with the invoice — enables entity-level AP reporting."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all supplier invoices. Primary AP spend KPI used in period-close and cash flow forecasting."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice value excluding tax. Used for clean spend reporting and budget reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across supplier invoices. Supports tax accrual and VAT/GST compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures effectiveness of dynamic discounting and payment term optimization."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges invoiced by suppliers. Informs logistics cost management and incoterms negotiation."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices processed. Baseline AP volume metric for workload and automation opportunity analysis."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN blocking_reason IS NOT NULL THEN 1 END)
      comment: "Number of invoices currently blocked from payment. Tracks AP processing bottlenecks and supplier payment risk."
    - name: "three_way_match_pass_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END)
      comment: "Number of invoices that passed three-way match. Measures invoice quality and procurement process discipline."
    - name: "tolerance_variance_total"
      expr: SUM(CAST(tolerance_variance_amount AS DOUBLE))
      comment: "Total monetary variance between invoiced and PO amounts. Identifies systemic pricing discrepancies requiring supplier negotiation."
    - name: "avg_tolerance_variance_pct"
      expr: AVG(CAST(tolerance_variance_percentage AS DOUBLE))
      comment: "Average percentage variance between invoice and PO price. Benchmarks invoice accuracy and supplier billing discipline."
    - name: "withholding_tax_total"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments. Required for tax compliance and supplier remittance reporting."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to invoices. Supports FX exposure monitoring and hedging decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Requisition-to-order cycle KPIs: requisition volume, approval lead times, spend authorization, and conversion rates. Used by procurement managers to identify bottlenecks in the PR-to-PO pipeline and enforce spend controls."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g., Pending, Approved, Rejected, Converted) — primary filter for pipeline analysis."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of requisition (e.g., Standard, Service, Asset) — enables category-specific cycle time benchmarking."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level of the requisition — identifies urgent procurement needs requiring expedited processing."
    - name: "purchasing_organization_code"
      expr: purchasing_organization_code
      comment: "Purchasing organization responsible for the requisition — enables org-level pipeline analysis."
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Buyer group assigned to the requisition — supports buyer workload and performance tracking."
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department that raised the requisition — enables demand analysis by business unit."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the requisition has a compliance requirement — flags regulated spend categories."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Whether multi-level approval is required — identifies high-value or policy-sensitive requisitions."
    - name: "pr_date_month"
      expr: DATE_TRUNC('month', pr_date)
      comment: "Month the requisition was raised — supports demand trend and seasonality analysis."
    - name: "required_delivery_month"
      expr: DATE_TRUNC('month', required_delivery_date)
      comment: "Month of required delivery — aligns procurement planning with operational demand timelines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition — required for multi-currency spend authorization analysis."
  measures:
    - name: "total_estimated_requisition_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated spend value of all purchase requisitions. Measures authorized demand pipeline and budget exposure before PO creation."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions. Benchmarks price expectations against actual PO prices to identify negotiation opportunities."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all requisitions. Supports demand aggregation for volume-based supplier negotiations."
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions raised. Baseline demand volume metric for procurement capacity planning."
    - name: "approved_requisition_count"
      expr: COUNT(CASE WHEN pr_status = 'Approved' THEN 1 END)
      comment: "Number of approved requisitions. Measures throughput of the approval pipeline and authorized procurement demand."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN pr_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected requisitions. High rejection rates signal poor demand planning or policy non-compliance."
    - name: "converted_to_po_count"
      expr: COUNT(CASE WHEN po_number IS NOT NULL THEN 1 END)
      comment: "Number of requisitions converted to purchase orders. Measures PR-to-PO conversion rate and procurement pipeline efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_spend_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend analytics KPIs: actual spend by category, supplier, and organizational unit. Used by CPO and category managers for spend visibility, savings tracking, and strategic sourcing prioritization."
  source: "`vibe_manufacturing_v1`.`procurement`.`spend_record`"
  dimensions:
    - name: "commodity_code_l1"
      expr: commodity_code_l1
      comment: "Top-level commodity classification — enables enterprise-wide spend category analysis."
    - name: "commodity_code_l2"
      expr: commodity_code_l2
      comment: "Second-level commodity classification — supports category management and sourcing strategy alignment."
    - name: "commodity_code_l3"
      expr: commodity_code_l3
      comment: "Third-level commodity classification — enables granular spend segmentation for category managers."
    - name: "commodity_code_l4"
      expr: commodity_code_l4
      comment: "Most granular commodity classification — supports detailed spend cube analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the spend — enables org-level spend accountability."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group associated with the spend — supports buyer-level spend performance tracking."
    - name: "procurement_channel"
      expr: procurement_channel
      comment: "Channel through which spend was executed (e.g., Catalog, PO, P-Card) — measures channel compliance and maverick spend."
    - name: "supplier_segment"
      expr: supplier_segment
      comment: "Supplier segmentation tier — enables strategic vs. tactical supplier spend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend record — required for year-over-year spend comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the spend record — supports period-close spend reconciliation."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month spend was posted — enables monthly spend trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency spend normalization."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms for the spend transaction — informs logistics cost allocation."
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total actual spend in transaction currency. Primary spend KPI for category management, budget tracking, and sourcing ROI measurement."
    - name: "total_spend_amount_usd"
      expr: SUM(CAST(spend_amount_usd AS DOUBLE))
      comment: "Total spend normalized to USD. Enables cross-currency spend comparison and global category analysis."
    - name: "total_savings_amount"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total procurement savings realized. Core KPI for measuring sourcing strategy effectiveness and CPO performance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax paid on procurement spend. Supports tax compliance reporting and total cost of ownership analysis."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity procured across spend records. Supports volume-based supplier negotiation and demand aggregation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid across spend records. Benchmarks pricing performance and identifies price drift over time."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers in the spend base. Tracks supplier base size and concentration risk."
    - name: "spend_record_count"
      expr: COUNT(1)
      comment: "Total number of spend transactions. Measures procurement transaction volume and process automation opportunity."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX rate applied to spend records. Supports FX impact analysis on procurement costs."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs: contract value, coverage, compliance, and lifecycle management. Used by category managers and legal/procurement leadership to manage contract risk, renewal exposure, and savings delivery."
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g., Active, Expired, Draft) — primary filter for contract portfolio analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of procurement contract (e.g., Framework, Blanket, Fixed Price) — enables contract structure analysis."
    - name: "material_category"
      expr: material_category
      comment: "Category of goods or services covered by the contract — supports category-level contract coverage analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization owning the contract — enables org-level contract portfolio management."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group managing the contract — supports buyer accountability for contract performance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance state of the contract — flags contracts with regulatory or policy violations."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews — identifies contracts requiring proactive renewal management."
    - name: "confidentiality_clause_flag"
      expr: confidentiality_clause_flag
      comment: "Whether the contract contains a confidentiality clause — relevant for data governance and legal risk."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the contract became effective — supports contract portfolio vintage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency — required for multi-currency contract value reporting."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms in the contract — informs logistics and risk allocation analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed value across all procurement contracts. Primary contract portfolio KPI for spend under management and budget exposure."
    - name: "total_remaining_value"
      expr: SUM(CAST(remaining_value AS DOUBLE))
      comment: "Total remaining uncommitted value across contracts. Measures available contract capacity and identifies under-utilized agreements."
    - name: "total_release_value"
      expr: SUM(CAST(release_value AS DOUBLE))
      comment: "Total value released (called off) against contracts. Measures contract utilization and spend under management effectiveness."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining quantity available under contracts. Supports supply planning and contract call-off scheduling."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts. Baseline portfolio size metric for contract management workload analysis."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active contracts. Measures live contract coverage and spend under management scope."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average value per procurement contract. Benchmarks contract size and identifies consolidation opportunities."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers under contract. Tracks contracted supplier base and preferred supplier coverage."
    - name: "minimum_order_quantity_avg"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts. Informs inventory planning and order consolidation strategy."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms (days) across contracts. Supports working capital optimization and cash flow planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing KPIs: event outcomes, savings realization, supplier participation, and award efficiency. Used by category managers and CPO to evaluate sourcing strategy effectiveness and competitive bidding performance."
  source: "`vibe_manufacturing_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the sourcing event (e.g., Draft, Published, Awarded, Cancelled) — primary filter for active sourcing pipeline."
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g., RFQ, RFP, Auction, RFI) — enables sourcing method effectiveness comparison."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category being sourced — supports category-level sourcing performance analysis."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Specific commodity code for the sourcing event — enables granular category savings tracking."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization running the event — enables org-level sourcing performance benchmarking."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group managing the event — supports buyer-level sourcing productivity analysis."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit sponsoring the sourcing event — enables demand-side accountability for sourcing outcomes."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract resulting from the event — informs post-award contract management strategy."
    - name: "is_multi_round"
      expr: is_multi_round
      comment: "Whether the event involved multiple bidding rounds — indicates negotiation complexity and competitive intensity."
    - name: "is_sealed_bid"
      expr: is_sealed_bid
      comment: "Whether the event used sealed bidding — relevant for procurement integrity and competitive fairness analysis."
    - name: "publish_date_month"
      expr: DATE_TRUNC('month', publish_date)
      comment: "Month the sourcing event was published — supports sourcing activity trend analysis."
    - name: "award_date_month"
      expr: DATE_TRUNC('month', award_date)
      comment: "Month the event was awarded — enables sourcing cycle time and award velocity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sourcing event — required for multi-currency savings normalization."
  measures:
    - name: "total_baseline_spend"
      expr: SUM(CAST(baseline_spend_amount AS DOUBLE))
      comment: "Total baseline spend across sourcing events. Denominator for savings rate calculation and sourcing ROI measurement."
    - name: "total_estimated_spend"
      expr: SUM(CAST(estimated_spend_amount AS DOUBLE))
      comment: "Total estimated spend value of sourcing events in pipeline. Measures active sourcing opportunity value."
    - name: "total_awarded_spend"
      expr: SUM(CAST(awarded_spend_amount AS DOUBLE))
      comment: "Total spend awarded through sourcing events. Measures spend under management placed through competitive sourcing."
    - name: "total_actual_savings"
      expr: SUM(CAST(actual_savings_amount AS DOUBLE))
      comment: "Total realized savings from sourcing events. Primary CPO performance KPI for procurement value delivery."
    - name: "total_savings_target"
      expr: SUM(CAST(savings_target_amount AS DOUBLE))
      comment: "Total savings target across sourcing events. Used to measure savings attainment rate against plan."
    - name: "avg_actual_savings_pct"
      expr: AVG(CAST(actual_savings_percentage AS DOUBLE))
      comment: "Average savings percentage achieved across sourcing events. Benchmarks sourcing effectiveness and negotiation performance."
    - name: "sourcing_event_count"
      expr: COUNT(1)
      comment: "Total number of sourcing events executed. Measures sourcing team productivity and competitive bidding activity."
    - name: "avg_contract_duration_months"
      expr: AVG(CAST(contract_duration_months AS DOUBLE))
      comment: "Average contract duration resulting from sourcing events. Informs contract portfolio planning and renewal scheduling."
    - name: "avg_price_weight_pct"
      expr: AVG(CAST(price_weight_percentage AS DOUBLE))
      comment: "Average weight given to price in sourcing evaluation criteria. Indicates whether sourcing strategy prioritizes cost vs. quality/service."
    - name: "avg_quality_weight_pct"
      expr: AVG(CAST(quality_weight_percentage AS DOUBLE))
      comment: "Average weight given to quality in sourcing evaluation. Measures strategic emphasis on supplier quality vs. pure cost."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier bidding and quotation KPIs: competitive pricing, evaluation scores, compliance rates, and award outcomes. Used by category managers to assess supplier competitiveness and sourcing event quality."
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the supplier quotation (e.g., Submitted, Evaluated, Awarded, Rejected) — primary filter for bid pipeline analysis."
    - name: "award_flag"
      expr: award_flag
      comment: "Whether this quotation was awarded — enables winner vs. loser bid analysis."
    - name: "technical_compliance_flag"
      expr: technical_compliance_flag
      comment: "Whether the quotation met technical requirements — measures supplier technical capability."
    - name: "commercial_compliance_flag"
      expr: commercial_compliance_flag
      comment: "Whether the quotation met commercial requirements — measures supplier commercial compliance rate."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether the quotation met environmental requirements — tracks sustainability compliance in sourcing."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the quoted goods — supports supply chain risk and trade compliance analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group of the quoted item — enables category-level bid analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms in the quotation — informs total landed cost comparison across bids."
    - name: "currency_code"
      expr: currency_code
      comment: "Quotation currency — required for cross-currency bid price normalization."
    - name: "submission_month"
      expr: DATE_TRUNC('month', CAST(submission_timestamp AS TIMESTAMP))
      comment: "Month the quotation was submitted — supports sourcing event timeline analysis."
    - name: "valid_from_date_month"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Month the quotation validity begins — tracks bid validity windows for procurement planning."
  measures:
    - name: "total_quoted_amount"
      expr: SUM(CAST(total_quoted_amount AS DOUBLE))
      comment: "Total value of all supplier quotations received. Measures competitive bid pool value and sourcing market depth."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax included in supplier quotations. Supports total cost of ownership comparison across bids."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight costs quoted by suppliers. Enables landed cost analysis and incoterms optimization."
    - name: "total_tco"
      expr: SUM(CAST(total_cost_of_ownership AS DOUBLE))
      comment: "Total cost of ownership across all quotations. Preferred KPI for strategic sourcing decisions beyond unit price."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average unit price quoted across all bids. Benchmarks market pricing and identifies outlier bids."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average supplier evaluation score across quotations. Measures overall supplier pool quality for a sourcing event."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount offered by suppliers. Measures competitive pricing pressure and negotiation leverage."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across quotations. Informs order consolidation and inventory planning decisions."
    - name: "quotation_count"
      expr: COUNT(1)
      comment: "Total number of supplier quotations received. Measures competitive bidding participation and market engagement."
    - name: "awarded_quotation_count"
      expr: COUNT(CASE WHEN award_flag = TRUE THEN 1 END)
      comment: "Number of quotations that were awarded. Tracks sourcing event award outcomes and supplier win rates."
    - name: "technically_compliant_count"
      expr: COUNT(CASE WHEN technical_compliance_flag = TRUE THEN 1 END)
      comment: "Number of technically compliant quotations. Measures supplier technical capability and bid quality in the market."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt and inbound quality KPIs: receipt volumes, quality inspection outcomes, delivery performance, and GR/IR clearing status. Used by procurement and operations to manage supplier delivery performance and inventory accuracy."
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Current status of the goods receipt (e.g., Posted, Reversed, Partial) — primary filter for inbound pipeline analysis."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection result for the received goods — tracks supplier quality at point of receipt."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for the goods receipt — distinguishes standard receipts, returns, and reversals."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g., Unrestricted, Quality Inspection, Blocked) — informs inventory availability."
    - name: "gr_ir_clearing_status"
      expr: gr_ir_clearing_status
      comment: "GR/IR account clearing status — identifies unmatched receipts creating AP reconciliation risk."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Whether goods were received damaged — tracks supplier packaging and logistics quality."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the goods receipt was reversed — identifies receipt corrections and their frequency."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Whether quality inspection was required for this receipt — segments receipts by quality control regime."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month goods were posted to inventory — supports inbound volume trend analysis."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of actual delivery — enables on-time delivery performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation — required for multi-currency inventory value reporting."
  measures:
    - name: "total_goods_receipt_value"
      expr: SUM(CAST(goods_receipt_value AS DOUBLE))
      comment: "Total value of goods received. Measures inbound inventory value and supplier delivery fulfillment in monetary terms."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Baseline inbound volume KPI for supply chain throughput analysis."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across goods receipts. Used with received quantity to calculate fill rate and delivery completeness."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total variance between ordered and received quantities. Measures supplier delivery accuracy and identifies chronic short-shipment suppliers."
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts posted. Measures inbound transaction volume and receiving dock throughput."
    - name: "damaged_receipt_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Number of receipts with damage reported. Tracks supplier packaging quality and logistics damage rates."
    - name: "reversed_receipt_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts. High reversal rates indicate receiving errors or supplier delivery disputes."
    - name: "quality_failed_receipt_count"
      expr: COUNT(CASE WHEN quality_inspection_status = 'Failed' THEN 1 END)
      comment: "Number of receipts that failed quality inspection. Measures incoming quality rejection rate and supplier quality performance."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with goods receipts in the period. Tracks active supplier delivery base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ process KPIs: bid solicitation efficiency, supplier participation, award cycle times, and sourcing pipeline value. Used by procurement managers to optimize competitive bidding processes and supplier engagement."
  source: "`vibe_manufacturing_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g., Draft, Issued, Closed, Awarded, Cancelled) — primary filter for active bid pipeline."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the RFQ — identifies RFQs pending authorization before supplier issuance."
    - name: "sourcing_event_type"
      expr: sourcing_event_type
      comment: "Type of sourcing event (e.g., RFQ, RFP, RFI) — enables sourcing method performance comparison."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category for the RFQ — supports category-level bid activity analysis."
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Buyer group managing the RFQ — supports buyer productivity and workload analysis."
    - name: "quality_certification_required"
      expr: quality_certification_required
      comment: "Whether quality certification is required from bidders — segments RFQs by quality compliance requirements."
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Whether a bid bond is required — identifies high-value or high-risk procurement events."
    - name: "confidentiality_agreement_required"
      expr: confidentiality_agreement_required
      comment: "Whether an NDA is required — flags sensitive or proprietary procurement events."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the RFQ was issued — supports sourcing activity trend analysis."
    - name: "award_date_month"
      expr: DATE_TRUNC('month', award_date)
      comment: "Month the RFQ was awarded — enables sourcing cycle time analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RFQ — required for multi-currency bid value analysis."
  measures:
    - name: "total_estimated_rfq_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of all RFQs issued. Measures active competitive sourcing pipeline value."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value required across RFQs. Measures financial commitment required from bidders in high-value events."
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline sourcing activity metric for procurement team productivity."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END)
      comment: "Number of RFQs successfully awarded. Measures sourcing event completion rate and procurement pipeline throughput."
    - name: "avg_estimated_rfq_value"
      expr: AVG(CAST(estimated_total_value AS DOUBLE))
      comment: "Average estimated value per RFQ. Benchmarks sourcing event size and identifies consolidation opportunities."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms negotiated in RFQs. Informs working capital planning and supplier payment strategy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement approval process KPIs: approval cycle times, escalation rates, policy compliance, and bottleneck identification. Used by procurement operations and compliance teams to optimize approval workflows and enforce spend controls."
  source: "`vibe_manufacturing_v1`.`procurement`.`approval_workflow`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (e.g., Pending, Approved, Rejected, Escalated) — primary filter for approval pipeline analysis."
    - name: "approval_action"
      expr: approval_action
      comment: "Action taken on the approval (e.g., Approve, Reject, Delegate, Escalate) — enables action-level workflow analysis."
    - name: "approval_document_type"
      expr: approval_document_type
      comment: "Type of document being approved (e.g., PO, PR, Contract) — enables document-type-specific approval performance analysis."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval hierarchy level — identifies which approval tiers create the most bottlenecks."
    - name: "approver_role"
      expr: approver_role
      comment: "Role of the approver — enables role-level approval performance benchmarking."
    - name: "policy_violation_flag"
      expr: policy_violation_flag
      comment: "Whether the document has a policy violation — tracks compliance exceptions requiring escalation."
    - name: "mandatory_approval_flag"
      expr: mandatory_approval_flag
      comment: "Whether approval is mandatory — distinguishes required vs. discretionary approval steps."
    - name: "parallel_approval_flag"
      expr: parallel_approval_flag
      comment: "Whether approvals run in parallel — identifies workflow design patterns affecting cycle time."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Result of automated compliance check — measures policy enforcement effectiveness."
    - name: "material_category"
      expr: material_category
      comment: "Category of material in the approval document — enables category-level approval analysis."
    - name: "approval_request_month"
      expr: DATE_TRUNC('month', approval_request_timestamp)
      comment: "Month the approval was requested — supports approval volume trend analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization associated with the approval — enables org-level approval performance tracking."
  measures:
    - name: "total_document_amount"
      expr: SUM(CAST(document_total_amount AS DOUBLE))
      comment: "Total monetary value of documents in the approval workflow. Measures financial exposure under approval control."
    - name: "total_approval_threshold_amount"
      expr: SUM(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Total approval threshold value across workflow records. Benchmarks spend authorization limits and delegation of authority."
    - name: "avg_approval_duration_hours"
      expr: AVG(CAST(approval_duration_hours AS DOUBLE))
      comment: "Average time to complete an approval in hours. Primary cycle time KPI for procurement approval process efficiency."
    - name: "approval_workflow_count"
      expr: COUNT(1)
      comment: "Total number of approval workflow records. Measures approval transaction volume and process workload."
    - name: "policy_violation_count"
      expr: COUNT(CASE WHEN policy_violation_flag = TRUE THEN 1 END)
      comment: "Number of approvals with policy violations. Tracks procurement compliance risk and maverick spend patterns."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_invoice_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level KPIs: price variance, quantity variance, match quality, and line-level spend analysis. Used by AP and procurement teams to identify invoice discrepancies, manage three-way match exceptions, and control invoice processing costs."
  source: "`vibe_manufacturing_v1`.`procurement`.`invoice_line_item`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status at line level (e.g., Matched, Price Variance, Quantity Variance) — primary filter for exception management."
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (e.g., Material, Service, Freight) — enables line-type-specific variance analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification status at line level — tracks line-level AP processing completion."
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason the invoice line is blocked — drives root-cause analysis for AP exception resolution."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Inventory valuation type for the line — relevant for split valuation and cost accounting analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the invoiced quantity — required for quantity variance analysis."
    - name: "verification_date_month"
      expr: DATE_TRUNC('month', verification_date)
      comment: "Month invoice line was verified — supports AP processing throughput trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Line currency — required for multi-currency invoice line analysis."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total invoiced amount at line level. Granular spend KPI for category and material-level cost analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount across invoice lines. Used for clean spend reporting excluding tax and discounts."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at invoice line level. Supports line-level tax compliance and accrual reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at invoice line level. Measures early payment discount capture and negotiated rebates."
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Total price variance between invoiced and PO unit price. Identifies systemic supplier overbilling and pricing discipline issues."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between invoiced and received quantities. Measures invoice accuracy and supplier billing integrity."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice line items processed. Measures AP processing volume and automation opportunity at line level."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across invoice lines. Benchmarks actual invoice pricing against PO and market rates."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied at line level. Measures effectiveness of negotiated pricing terms."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_sourcing_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category sourcing strategy KPIs: savings targets, risk ratings, contract coverage, and strategy execution. Used by category managers and CPO to govern strategic sourcing plans and measure strategy effectiveness."
  source: "`vibe_manufacturing_v1`.`procurement`.`sourcing_strategy`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the sourcing strategy — identifies strategies pending authorization."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance state of the sourcing strategy — flags strategies with regulatory or policy gaps."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk classification of the sourcing strategy — enables risk-tiered portfolio management."
    - name: "make_vs_buy"
      expr: make_vs_buy
      comment: "Make vs. buy decision for the category — tracks insourcing vs. outsourcing strategy mix."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for savings targets — required for multi-currency strategy comparison."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the strategy became effective — supports strategy vintage and lifecycle analysis."
    - name: "last_review_date_month"
      expr: DATE_TRUNC('month', last_review_date)
      comment: "Month of last strategy review — identifies strategies overdue for refresh."
  measures:
    - name: "total_savings_target_amount"
      expr: SUM(CAST(savings_target_amount AS DOUBLE))
      comment: "Total savings target across all sourcing strategies. Measures the aggregate savings ambition in the procurement strategy portfolio."
    - name: "total_spend_last_year"
      expr: SUM(CAST(total_spend_last_year AS DOUBLE))
      comment: "Total spend in scope across all sourcing strategies. Measures the spend base under active strategic management."
    - name: "total_contract_coverage_target"
      expr: SUM(CAST(contract_coverage_target_amount AS DOUBLE))
      comment: "Total contract coverage target value across strategies. Measures the ambition to place spend under contracted agreements."
    - name: "avg_target_savings_pct"
      expr: AVG(CAST(target_savings_percent AS DOUBLE))
      comment: "Average savings target percentage across sourcing strategies. Benchmarks the ambition level of the procurement strategy portfolio."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk score across sourcing strategies. Measures overall supply chain risk exposure in the category portfolio."
    - name: "avg_contract_coverage_target_pct"
      expr: AVG(CAST(contract_coverage_target_percent AS DOUBLE))
      comment: "Average contract coverage target percentage. Measures the strategic intent to place spend under managed contracts."
    - name: "sourcing_strategy_count"
      expr: COUNT(1)
      comment: "Total number of sourcing strategies defined. Measures breadth of strategic category management coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_contract_release_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract utilization and exposure metrics"
  source: "`vibe_manufacturing_v1`.`procurement`.`contract_release_order`"
  dimensions:
    - name: "contract_status"
      expr: release_status
      comment: "Current status of the contract release order"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier linked to the contract"
  measures:
    - name: "total_released_value"
      expr: SUM(CAST(release_value AS DOUBLE))
      comment: "Total value of released contract quantities"
    - name: "total_remaining_value"
      expr: SUM(CAST(contract_remaining_value AS DOUBLE))
      comment: "Remaining contract value not yet released"
    - name: "cro_count"
      expr: COUNT(1)
      comment: "Number of contract release orders"
$$;