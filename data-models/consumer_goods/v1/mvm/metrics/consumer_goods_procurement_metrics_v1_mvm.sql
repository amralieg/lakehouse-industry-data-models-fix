-- Metric views for domain: procurement | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, value, cycle time, and compliance. Enables procurement leadership to monitor spend commitments, supplier concentration, and order execution efficiency."
  source: "`consumer_goods_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) — used to segment active vs. completed spend."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Consignment) — drives sourcing strategy analysis."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of purchase order creation — enables trend analysis of procurement activity over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — supports multi-currency spend analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Procurement organizational unit responsible for the order — enables spend governance by org unit."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group responsible for the purchase order — supports workload and spend distribution analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery responsibility — used for logistics cost and risk analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the order (e.g. Air, Sea, Road) — supports freight cost and sustainability analysis."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification associated with the purchase order — tracks green procurement compliance."
    - name: "priority"
      expr: priority
      comment: "Business priority level of the purchase order — used to triage urgent procurement needs."
    - name: "vmi_indicator"
      expr: vmi_indicator
      comment: "Flag indicating whether the order is under Vendor Managed Inventory — supports VMI program performance tracking."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume KPI for procurement activity and buyer workload."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net value of all purchase orders. Core spend commitment KPI used in budget vs. actuals and supplier spend analysis."
    - name: "total_gross_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total gross order value including tax and freight. Reflects full financial exposure of procurement commitments."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across all purchase orders. Enables logistics cost management and incoterms optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges on purchase orders. Supports tax liability reporting and compliance monitoring."
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net value per purchase order. Indicates typical order size and helps identify outliers or maverick spend."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN po_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled purchase orders. High cancellation rates signal planning inefficiencies or supplier issues."
    - name: "vmi_order_count"
      expr: COUNT(CASE WHEN vmi_indicator = TRUE THEN 1 END)
      comment: "Number of purchase orders under Vendor Managed Inventory. Tracks adoption and scale of VMI programs."
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers receiving purchase orders. Measures supplier base breadth and concentration risk."
    - name: "goods_receipt_required_count"
      expr: COUNT(CASE WHEN goods_receipt_required = TRUE THEN 1 END)
      comment: "Number of purchase orders requiring goods receipt confirmation. Supports three-way match compliance tracking."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs covering ordered quantities, net values, delivery performance, and invoice matching. Enables granular spend analysis by material, plant, and purchasing group."
  source: "`consumer_goods_ecm`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line (e.g. Open, Closed, Blocked) — used to filter active vs. completed procurement lines."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing or distribution plant receiving the ordered material — enables plant-level spend and supply analysis."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group responsible for the PO line — supports workload distribution and category management."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the PO line — supports multi-currency spend reporting."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterm governing delivery responsibility for this line — used in logistics cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for ordered quantity — required for volume-based procurement analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the PO line — supports tax compliance and cost analysis."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Scheduled delivery month for the PO line — enables delivery timeline and lead time trend analysis."
    - name: "confirmed_delivery_date"
      expr: DATE_TRUNC('month', confirmed_delivery_date)
      comment: "Supplier-confirmed delivery month — used to compare planned vs. confirmed delivery schedules."
    - name: "deletion_indicator"
      expr: deletion_indicator
      comment: "Flag indicating the PO line is marked for deletion — used to exclude logically deleted lines from active spend."
  measures:
    - name: "total_po_lines"
      expr: COUNT(1)
      comment: "Total number of PO lines. Baseline volume metric for procurement line activity."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value across all PO lines. Primary spend commitment KPI at line level."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines. Supports volume-based procurement and inventory planning."
    - name: "total_goods_received_quantity"
      expr: SUM(CAST(goods_received_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines. Measures fulfillment progress and identifies open delivery obligations."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced against PO lines. Supports three-way match and invoice accuracy analysis."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total quantity still outstanding (ordered but not yet received). Tracks open procurement obligations and supply risk."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net unit price across PO lines. Enables price benchmarking and cost trend analysis by material or supplier."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Sum of minimum order quantities across lines. Supports MOQ compliance and inventory optimization analysis."
    - name: "receipt_fill_rate"
      expr: SUM(CAST(goods_received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0)
      comment: "Ratio of goods received to ordered quantity. Measures supplier delivery completeness — a key OTIF input metric."
    - name: "invoice_fill_rate"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0)
      comment: "Ratio of invoiced quantity to ordered quantity. Identifies billing gaps and supports accounts payable reconciliation."
    - name: "active_po_line_count"
      expr: COUNT(CASE WHEN deletion_indicator = FALSE AND line_status != 'Closed' THEN 1 END)
      comment: "Number of active, non-deleted PO lines. Represents current open procurement workload."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt KPIs covering received quantities, valuation, OTIF compliance, quality inspection, and reversal rates. Critical for supply chain reliability and inventory accuracy."
  source: "`consumer_goods_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt document (e.g. Posted, Reversed, Pending) — used to filter valid receipts."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code (e.g. 101 GR for PO, 122 Return) — classifies the nature of the goods movement."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month goods receipt was posted to inventory — enables trend analysis of inbound supply flow."
    - name: "document_date"
      expr: DATE_TRUNC('month', document_date)
      comment: "Month of the goods receipt document date — used for period-based receipt volume analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation — supports multi-currency inventory valuation reporting."
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location where goods were received — enables location-level inventory receipt analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantity — required for volume-based receipt analysis."
    - name: "otif_compliance_flag"
      expr: otif_compliance_flag
      comment: "Flag indicating whether the receipt met On-Time In-Full criteria — primary supplier delivery performance indicator."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Flag indicating whether a quality inspection was required for this receipt — supports quality gate compliance tracking."
    - name: "sustainable_sourcing_certification"
      expr: sustainable_sourcing_certification
      comment: "Sustainability certification associated with the received goods — tracks sustainable sourcing compliance at receipt level."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents. Baseline inbound supply activity volume metric."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Core inbound supply volume KPI for inventory and supply planning."
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total inventory value of goods received. Measures financial impact of inbound supply and supports COGS analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received goods. Enables price variance analysis against PO price and market benchmarks."
    - name: "otif_compliant_receipt_count"
      expr: COUNT(CASE WHEN otif_compliance_flag = TRUE THEN 1 END)
      comment: "Number of goods receipts meeting On-Time In-Full criteria. Numerator for OTIF rate calculation."
    - name: "otif_compliance_rate"
      expr: COUNT(CASE WHEN otif_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of goods receipts that were OTIF compliant. Key supplier delivery performance KPI used in scorecards and SLA reviews."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN gr_reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts. High reversal rates indicate receiving errors, quality rejections, or supplier disputes."
    - name: "reversal_rate"
      expr: COUNT(CASE WHEN gr_reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of goods receipts that were reversed. Measures receiving process quality and supplier delivery accuracy."
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of receipts requiring quality inspection. Supports quality gate workload planning and compliance monitoring."
    - name: "coa_received_rate"
      expr: COUNT(CASE WHEN certificate_of_analysis_received_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of receipts where Certificate of Analysis was received. Critical compliance KPI for regulated consumer goods materials."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs covering invoice accuracy, payment timeliness, three-way match compliance, and cash discount capture. Drives working capital and P2P efficiency decisions."
  source: "`consumer_goods_ecm`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the supplier invoice (e.g. Posted, Blocked, Paid) — used to segment invoice pipeline."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of supplier invoice (e.g. Standard, Credit Memo, Debit Memo) — supports invoice mix and dispute analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Result of three-way match between PO, GR, and invoice — key P2P compliance and payment release indicator."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice issuance — enables trend analysis of invoice volumes and amounts over time."
    - name: "payment_due_date"
      expr: DATE_TRUNC('month', payment_due_date)
      comment: "Month payment is due — supports cash flow forecasting and DPO analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency — supports multi-currency AP reporting and FX exposure analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code governing due dates and discounts — used to analyze payment terms compliance and optimization."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code — enables entity-level AP and spend reporting."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the invoice — supports plant-level procurement cost analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice — enables year-over-year spend and AP performance comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — supports period-close AP reconciliation and accrual analysis."
    - name: "blocking_reason_code"
      expr: blocking_reason_code
      comment: "Reason code for invoice payment block — identifies root causes of payment delays and process bottlenecks."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of supplier invoices processed. Baseline AP volume metric for workload and process capacity planning."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value. Primary AP spend KPI representing total supplier billing exposure."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice value after discounts. Represents actual payment obligation to suppliers."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on supplier invoices. Supports tax liability reporting and VAT reclaim analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization through discount capture programs."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments. Supports tax compliance and supplier remittance reporting."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Blocked' THEN 1 END)
      comment: "Number of invoices currently blocked from payment. High blocked counts indicate P2P process failures or supplier disputes."
    - name: "three_way_match_pass_rate"
      expr: COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of invoices passing three-way match. Key P2P quality KPI — low rates drive manual intervention costs and payment delays."
    - name: "avg_net_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Helps identify invoice size patterns and supports AP automation ROI analysis."
    - name: "distinct_suppliers_invoiced"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers submitting invoices. Measures active supplier base and AP workload distribution."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance KPIs aggregated from scorecards covering OTIF, quality, cost competitiveness, sustainability, and overall weighted scores. Drives supplier development, rationalization, and contract renewal decisions."
  source: "`consumer_goods_ecm`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Supplier performance tier classification (e.g. Strategic, Preferred, Approved, Conditional) — primary segmentation for supplier development strategy."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the scorecard (e.g. Draft, Approved, Closed) — used to filter finalized evaluations."
    - name: "evaluation_period_start_date"
      expr: DATE_TRUNC('quarter', evaluation_period_start_date)
      comment: "Quarter of the scorecard evaluation period start — enables quarterly supplier performance trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of purchase value reported in the scorecard — supports multi-currency spend analysis."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended action from the scorecard evaluation (e.g. Develop, Maintain, Exit) — drives supplier relationship management decisions."
    - name: "action_plan_required_flag"
      expr: action_plan_required_flag
      comment: "Flag indicating whether a corrective action plan is required — identifies at-risk suppliers needing intervention."
    - name: "trend_vs_prior_period"
      expr: trend_vs_prior_period
      comment: "Performance trend direction vs. prior period (e.g. Improving, Declining, Stable) — supports proactive supplier management."
  measures:
    - name: "total_scorecards"
      expr: COUNT(1)
      comment: "Total number of supplier scorecards evaluated. Measures coverage and cadence of supplier performance reviews."
    - name: "avg_overall_weighted_score"
      expr: AVG(CAST(overall_weighted_score AS DOUBLE))
      comment: "Average overall weighted supplier performance score. Primary KPI for supplier base health — used in QBRs and contract renewal decisions."
    - name: "avg_otif_delivery_rate_pct"
      expr: AVG(CAST(otif_delivery_rate_pct AS DOUBLE))
      comment: "Average On-Time In-Full delivery rate across evaluated suppliers. Key supply chain reliability KPI."
    - name: "avg_quality_rejection_rate_ppm"
      expr: AVG(CAST(quality_rejection_rate_ppm AS DOUBLE))
      comment: "Average quality rejection rate in parts per million. Measures incoming material quality — directly impacts production efficiency and consumer safety."
    - name: "avg_invoice_accuracy_rate_pct"
      expr: AVG(CAST(invoice_accuracy_rate_pct AS DOUBLE))
      comment: "Average invoice accuracy rate across suppliers. Measures billing quality — low accuracy drives AP processing costs and payment delays."
    - name: "avg_cost_competitiveness_score"
      expr: AVG(CAST(cost_competitiveness_score AS DOUBLE))
      comment: "Average cost competitiveness score. Measures whether suppliers are pricing competitively relative to market benchmarks."
    - name: "avg_sustainability_compliance_score"
      expr: AVG(CAST(sustainability_compliance_score AS DOUBLE))
      comment: "Average sustainability compliance score. Tracks supplier ESG performance — critical for regulatory reporting and brand reputation."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across supplier scorecards. Composite quality KPI used in supplier tiering and development programs."
    - name: "total_purchase_value_evaluated"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase value covered by scorecards. Measures financial coverage of supplier performance management program."
    - name: "action_plan_required_count"
      expr: COUNT(CASE WHEN action_plan_required_flag = TRUE THEN 1 END)
      comment: "Number of suppliers requiring corrective action plans. Measures scale of at-risk supplier relationships needing intervention."
    - name: "score_improvement_rate"
      expr: COUNT(CASE WHEN trend_vs_prior_period = 'Improving' THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of suppliers showing score improvement vs. prior period. Measures effectiveness of supplier development programs."
    - name: "avg_prior_period_overall_score"
      expr: AVG(CAST(prior_period_overall_score AS DOUBLE))
      comment: "Average overall score from the prior evaluation period. Provides baseline for period-over-period supplier performance comparison."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master KPIs covering supplier base composition, certification coverage, risk profile, and performance scores. Enables strategic sourcing decisions, risk management, and supplier diversity reporting."
  source: "`consumer_goods_ecm`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Lifecycle status of the supplier (e.g. Active, Blocked, Inactive) — primary filter for active supplier base analysis."
    - name: "supplier_tier"
      expr: supplier_tier
      comment: "Strategic tier classification of the supplier (e.g. Tier 1, Tier 2, Tier 3) — drives sourcing strategy and relationship investment."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (e.g. Manufacturer, Distributor, Service Provider) — supports category and sourcing strategy analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the supplier — enables geographic concentration and geopolitical risk analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the supplier (e.g. Low, Medium, High, Critical) — primary input for supply chain risk management."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Supplier diversity classification (e.g. Minority-Owned, Women-Owned, Small Business) — supports diversity spend reporting and ESG goals."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status of the supplier — tracks supplier qualification pipeline."
    - name: "onboarding_date"
      expr: DATE_TRUNC('year', onboarding_date)
      comment: "Year the supplier was onboarded — enables cohort analysis of supplier base growth and attrition."
    - name: "iso_9001_certified_flag"
      expr: iso_9001_certified_flag
      comment: "Flag indicating ISO 9001 quality management certification — key quality compliance dimension for supplier selection."
    - name: "gmp_certified_flag"
      expr: gmp_certified_flag
      comment: "Flag indicating Good Manufacturing Practice certification — critical for health, hygiene, and personal care product suppliers."
    - name: "rspo_certified_flag"
      expr: rspo_certified_flag
      comment: "Flag indicating RSPO (Roundtable on Sustainable Palm Oil) certification — tracks sustainable sourcing compliance."
    - name: "fsc_certified_flag"
      expr: fsc_certified_flag
      comment: "Flag indicating FSC (Forest Stewardship Council) certification — supports sustainable packaging and materials sourcing."
  measures:
    - name: "total_suppliers"
      expr: COUNT(1)
      comment: "Total number of suppliers in the master data. Baseline metric for supplier base size and management scope."
    - name: "active_supplier_count"
      expr: COUNT(CASE WHEN supplier_status = 'Active' THEN 1 END)
      comment: "Number of active suppliers. Measures the effective supplier base available for sourcing decisions."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of suppliers rated High or Critical risk. Drives supply chain risk mitigation prioritization and contingency planning."
    - name: "high_risk_supplier_rate"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of suppliers with High or Critical risk rating. Measures overall supply chain risk exposure — a key procurement governance KPI."
    - name: "iso_9001_certification_rate"
      expr: COUNT(CASE WHEN iso_9001_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of suppliers with ISO 9001 certification. Measures quality management standard coverage across the supplier base."
    - name: "gmp_certification_rate"
      expr: COUNT(CASE WHEN gmp_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of suppliers with GMP certification. Critical compliance KPI for consumer goods manufacturers in regulated categories."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average supplier performance score across the supplier base. Measures overall health of supplier relationships."
    - name: "vmi_eligible_supplier_count"
      expr: COUNT(CASE WHEN vmi_eligible_flag = TRUE THEN 1 END)
      comment: "Number of suppliers eligible for Vendor Managed Inventory. Measures VMI program expansion potential and supply chain collaboration maturity."
    - name: "edi_capable_supplier_count"
      expr: COUNT(CASE WHEN edi_capable_flag = TRUE THEN 1 END)
      comment: "Number of suppliers capable of EDI transactions. Measures digital procurement integration coverage and P2P automation potential."
    - name: "diversity_supplier_count"
      expr: COUNT(CASE WHEN diversity_classification IS NOT NULL AND diversity_classification != '' THEN 1 END)
      comment: "Number of suppliers with a diversity classification. Tracks diverse supplier base size for ESG and regulatory reporting."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs covering contract value, coverage, expiry risk, and compliance. Enables procurement leadership to manage contract lifecycle, reduce maverick spend, and optimize sourcing agreements."
  source: "`consumer_goods_ecm`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the supplier contract (e.g. Active, Expired, Terminated, Draft) — primary filter for active contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Framework, Blanket, Fixed Price, Time & Material) — supports contract mix and strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency — supports multi-currency contract value reporting."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Procurement organization owning the contract — enables org-level contract portfolio management."
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism used in the contract (e.g. Fixed, Index-Linked, Cost-Plus) — supports price risk and inflation exposure analysis."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification required by the contract — tracks sustainable sourcing commitments in contract portfolio."
    - name: "effective_date"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the contract became effective — enables contract vintage and renewal cycle analysis."
    - name: "expiry_date"
      expr: DATE_TRUNC('quarter', expiry_date)
      comment: "Quarter the contract expires — critical for contract renewal pipeline management and supply continuity risk."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the contract auto-renews — supports contract management workload planning."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of supplier contracts. Baseline metric for contract portfolio size and management scope."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active supplier contracts. Measures effective contract coverage of the supply base."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total committed value across all supplier contracts. Primary contract portfolio value KPI for spend under management reporting."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_total AS DOUBLE))
      comment: "Average contract value. Indicates typical contract size and supports contract consolidation opportunity analysis."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity_total AS DOUBLE))
      comment: "Total contracted target quantity across all contracts. Supports volume commitment tracking and supplier capacity planning."
    - name: "expiring_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' AND expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active contracts expiring within 90 days. Critical supply continuity risk KPI — drives contract renewal prioritization."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts set to auto-renew. Supports contract management workload planning and renewal risk assessment."
    - name: "distinct_suppliers_under_contract"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with active contracts. Measures contracted supplier base coverage vs. total active supplier base."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts. Supports inventory planning and MOQ compliance analysis."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs covering requisition volume, estimated spend, approval cycle efficiency, and sustainability compliance. Enables procurement to manage demand intake, reduce cycle times, and enforce sourcing policies."
  source: "`consumer_goods_ecm`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "purchase_requisition_status"
      expr: purchase_requisition_status
      comment: "Current status of the purchase requisition (e.g. Pending, Approved, Rejected, Converted) — tracks P2P pipeline health."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (e.g. Standard, Blanket, Service) — supports demand categorization and sourcing strategy alignment."
    - name: "priority"
      expr: priority
      comment: "Business priority of the requisition (e.g. Urgent, Normal, Low) — used to triage procurement workload."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the requisition — supports governance and delegation of authority analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition estimated value — supports multi-currency demand analysis."
    - name: "purchasing_organization_code"
      expr: purchasing_organization_code
      comment: "Procurement organization responsible for fulfilling the requisition — enables org-level demand and workload analysis."
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Buyer group assigned to the requisition — supports workload distribution and category management."
    - name: "requested_date"
      expr: DATE_TRUNC('month', requested_date)
      comment: "Month the requisition was submitted — enables demand trend and seasonality analysis."
    - name: "required_delivery_date"
      expr: DATE_TRUNC('month', required_delivery_date)
      comment: "Month the requester needs delivery — supports lead time feasibility and supply planning."
    - name: "sustainability_flag"
      expr: sustainability_flag
      comment: "Flag indicating the requisition has sustainability requirements — tracks green procurement demand."
    - name: "source_of_supply"
      expr: source_of_supply
      comment: "Intended source of supply for the requisition (e.g. Contract, Spot Buy, Preferred Supplier) — measures contract compliance and maverick spend risk."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions submitted. Baseline demand intake volume metric."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of all purchase requisitions. Measures demand pipeline value and supports budget commitment forecasting."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions. Supports price benchmarking and early identification of cost outliers."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all requisitions. Measures demand volume for supply planning and capacity alignment."
    - name: "approved_requisition_count"
      expr: COUNT(CASE WHEN purchase_requisition_status = 'Approved' THEN 1 END)
      comment: "Number of approved purchase requisitions. Measures throughput of the requisition approval process."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN purchase_requisition_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected purchase requisitions. High rejection rates indicate poor demand planning or policy non-compliance."
    - name: "approval_rate"
      expr: COUNT(CASE WHEN purchase_requisition_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of requisitions approved. Measures demand quality and alignment with procurement policies."
    - name: "sustainability_requisition_rate"
      expr: COUNT(CASE WHEN sustainability_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of requisitions with sustainability requirements. Tracks green procurement adoption across the organization."
    - name: "distinct_requesters"
      expr: COUNT(DISTINCT requester_name)
      comment: "Number of unique requisition requesters. Measures breadth of procurement demand across the organization."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_approved_supplier_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Supplier List (ASL) KPIs covering supplier approval coverage, compliance status, risk profile, and audit readiness. Enables quality and procurement teams to manage supplier qualification and regulatory compliance."
  source: "`consumer_goods_ecm`.`procurement`.`approved_supplier_list`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the supplier-material combination (e.g. Approved, Conditional, Blocked, Expired) — primary ASL compliance dimension."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory and quality compliance status of the approved supplier entry — drives compliance risk management."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the supplier-material combination — supports risk-based sourcing decisions."
    - name: "approval_basis"
      expr: approval_basis
      comment: "Basis on which the supplier was approved (e.g. Audit, Certification, Waiver) — supports approval quality analysis."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority that granted the approval — supports governance and delegation of authority compliance."
    - name: "approval_date"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year of supplier approval — enables cohort analysis of ASL entries and approval cycle trends."
    - name: "approval_expiration_date"
      expr: DATE_TRUNC('quarter', approval_expiration_date)
      comment: "Quarter of approval expiration — critical for proactive re-qualification planning and supply continuity."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Flag indicating preferred supplier status — used to measure preferred supplier utilization in sourcing."
    - name: "sole_source_flag"
      expr: sole_source_flag
      comment: "Flag indicating sole source supply — identifies single-source supply risk concentration."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification held by the approved supplier — tracks sustainable sourcing compliance at ASL level."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Flag indicating incoming inspection is required — supports quality gate planning and resource allocation."
  measures:
    - name: "total_asl_entries"
      expr: COUNT(1)
      comment: "Total number of Approved Supplier List entries. Measures the scope of qualified supplier-material combinations."
    - name: "approved_entry_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of fully approved ASL entries. Measures active qualified supply base coverage."
    - name: "blocked_entry_count"
      expr: COUNT(CASE WHEN approval_status = 'Blocked' THEN 1 END)
      comment: "Number of blocked ASL entries. Blocked entries represent supply risk — requires immediate procurement and quality action."
    - name: "expiring_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' AND approval_expiration_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of approved ASL entries expiring within 90 days. Critical supply continuity KPI — drives re-qualification prioritization."
    - name: "sole_source_entry_count"
      expr: COUNT(CASE WHEN sole_source_flag = TRUE THEN 1 END)
      comment: "Number of sole-source ASL entries. Measures single-source supply concentration risk — a key supply chain resilience KPI."
    - name: "preferred_supplier_rate"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of ASL entries designated as preferred suppliers. Measures preferred supplier program coverage and sourcing compliance."
    - name: "inspection_required_rate"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of ASL entries requiring incoming inspection. Supports quality resource planning and risk-based inspection strategy."
    - name: "distinct_approved_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers on the Approved Supplier List. Measures qualified supplier base breadth."
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity across ASL entries. Supports inventory planning and MOQ compliance analysis."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`procurement_spend_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend category portfolio KPIs covering budget allocation, savings targets, contract coverage, and strategic importance. Enables category managers to prioritize investment, track savings programs, and manage category risk."
  source: "`consumer_goods_ecm`.`procurement`.`spend_category`"
  dimensions:
    - name: "category_status"
      expr: category_status
      comment: "Current status of the spend category (e.g. Active, Inactive, Under Review) — filters active category portfolio."
    - name: "category_level"
      expr: category_level
      comment: "Hierarchical level of the spend category (e.g. L1, L2, L3) — enables category tree analysis and roll-up reporting."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type classification — supports market-based pricing and supply risk analysis."
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance rating of the category (e.g. Critical, Important, Tactical) — drives category management investment prioritization."
    - name: "risk_profile"
      expr: risk_profile
      comment: "Risk profile of the spend category (e.g. High, Medium, Low) — supports supply risk management and mitigation planning."
    - name: "preferred_sourcing_strategy"
      expr: preferred_sourcing_strategy
      comment: "Preferred sourcing strategy for the category (e.g. Single Source, Dual Source, Competitive Bid) — tracks strategy execution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the category budget — supports multi-currency category spend reporting."
    - name: "sustainable_sourcing_flag"
      expr: sustainable_sourcing_flag
      comment: "Flag indicating the category has sustainable sourcing requirements — tracks ESG-aligned category management."
    - name: "procurement_organization"
      expr: procurement_organization
      comment: "Procurement organization responsible for the category — enables org-level category portfolio management."
  measures:
    - name: "total_spend_categories"
      expr: COUNT(1)
      comment: "Total number of spend categories defined. Measures category taxonomy breadth and management scope."
    - name: "total_annual_spend_budget"
      expr: SUM(CAST(annual_spend_budget_amount AS DOUBLE))
      comment: "Total annual spend budget across all categories. Primary category portfolio financial planning KPI."
    - name: "avg_contract_coverage_percentage"
      expr: AVG(CAST(contract_coverage_percentage AS DOUBLE))
      comment: "Average contract coverage percentage across spend categories. Measures spend under management — a core procurement maturity KPI."
    - name: "avg_cost_savings_target_percentage"
      expr: AVG(CAST(cost_savings_target_percentage AS DOUBLE))
      comment: "Average cost savings target percentage across categories. Measures ambition of procurement savings programs."
    - name: "high_risk_category_count"
      expr: COUNT(CASE WHEN risk_profile = 'High' THEN 1 END)
      comment: "Number of spend categories with high risk profiles. Drives supply risk mitigation investment and contingency planning."
    - name: "strategic_category_count"
      expr: COUNT(CASE WHEN strategic_importance = 'Critical' THEN 1 END)
      comment: "Number of categories classified as critically strategic. Measures scope of strategic category management program."
    - name: "sustainable_category_rate"
      expr: COUNT(CASE WHEN sustainable_sourcing_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0)
      comment: "Proportion of spend categories with sustainable sourcing requirements. Tracks ESG integration into category management."
    - name: "moq_applicable_category_count"
      expr: COUNT(CASE WHEN moq_applicable_flag = TRUE THEN 1 END)
      comment: "Number of categories where MOQ constraints apply. Supports inventory optimization and working capital management."
$$;