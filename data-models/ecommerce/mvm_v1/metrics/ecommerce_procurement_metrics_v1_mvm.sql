-- Metric views for domain: procurement | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, spend, approval efficiency, and urgency profiling. Enables procurement leadership to monitor order pipeline health, spending commitments, and supplier engagement."
  source: "`ecommerce_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval state of the purchase order (e.g. Approved, Pending, Rejected). Used to segment orders by workflow stage."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. Standard, Blanket, Drop-Ship). Enables spend analysis by procurement strategy."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Operational lifecycle state of the PO (e.g. Open, Closed, Cancelled). Drives pipeline and backlog reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order. Supports multi-currency spend analysis."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against the PO. Indicates fulfilment progress and open delivery exposure."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice processing status for the PO. Supports accounts-payable and three-way-match monitoring."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether the PO was raised as urgent. Enables analysis of expedited procurement frequency and cost premium."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Flag indicating drop-ship fulfilment model. Supports channel-mix and inventory-bypass analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms governing delivery responsibility. Used to segment freight cost and risk exposure."
    - name: "purchasing_org"
      expr: purchasing_org
      comment: "Purchasing organisation responsible for the PO. Enables spend governance and budget allocation analysis."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group within the purchasing organisation. Supports team-level procurement performance tracking."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the supplier. Drives working-capital and cash-flow analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of PO creation. Enables trend analysis of procurement activity over time."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery. Supports demand-timing and lead-time planning."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement activity and workload assessment."
    - name: "total_gross_spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross procurement spend across all POs. Primary financial KPI for budget tracking and supplier spend concentration."
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net procurement spend after discounts. Reflects actual committed cost and is used for budget vs. actuals reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value captured across POs. Measures negotiation effectiveness and supplier discount yield."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders. Supports tax compliance and cost-of-goods analysis."
    - name: "avg_po_net_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per purchase order. Indicates typical transaction size and helps identify outlier or maverick spend."
    - name: "urgent_po_count"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Number of purchase orders flagged as urgent. High urgency rates signal supply-chain disruption or poor demand planning."
    - name: "drop_ship_po_count"
      expr: COUNT(CASE WHEN is_drop_ship = TRUE THEN 1 END)
      comment: "Number of drop-ship purchase orders. Tracks the scale of supplier-direct fulfilment bypassing warehouse inventory."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with active POs. Measures supplier base breadth and concentration risk."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to POs. Supports currency risk monitoring and hedging decisions."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_po_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular line-item KPIs covering ordered quantities, pricing accuracy, delivery performance, and invoice matching. Enables category managers and procurement analysts to identify price variance, delivery gaps, and invoicing discrepancies at the SKU level."
  source: "`ecommerce_ecm`.`procurement`.`po_line_item`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line item (e.g. Open, Closed, Cancelled). Drives open-order and backlog reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item transaction. Supports multi-currency cost analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Trade terms for the line item delivery. Used to segment freight responsibility and cost."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for ordered quantity. Ensures consistent quantity aggregation across SKUs."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax classification applied to the line item. Supports tax compliance and cost-of-goods breakdown."
    - name: "moq_compliance_flag"
      expr: moq_compliance_flag
      comment: "Indicates whether the ordered quantity meets the minimum order quantity. Tracks compliance with supplier MOQ terms."
    - name: "final_delivery_flag"
      expr: final_delivery_flag
      comment: "Indicates whether this line item represents the final delivery. Used to close open PO lines and reconcile receipts."
    - name: "goods_receipt_blocked_flag"
      expr: goods_receipt_blocked_flag
      comment: "Indicates whether goods receipt is blocked for this line. Highlights lines requiring intervention before receipt posting."
    - name: "invoice_verification_flag"
      expr: invoice_verification_flag
      comment: "Indicates whether invoice verification has been completed. Supports three-way match and AP closure tracking."
    - name: "confirmed_delivery_date_month"
      expr: DATE_TRUNC('MONTH', confirmed_delivery_date)
      comment: "Month of confirmed delivery date. Enables delivery schedule trend analysis."
    - name: "actual_delivery_date_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery. Used to compare planned vs. actual delivery timing at scale."
  measures:
    - name: "total_line_item_count"
      expr: COUNT(1)
      comment: "Total number of PO line items. Baseline volume metric for procurement workload and order complexity."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all line items. Core volume metric for demand fulfilment and inventory planning."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines. Measures actual inbound fulfilment volume."
    - name: "total_open_quantity"
      expr: SUM(CAST(open_quantity AS DOUBLE))
      comment: "Total outstanding quantity yet to be delivered. Quantifies open procurement exposure and supply risk."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced by suppliers. Supports three-way match reconciliation between order, receipt, and invoice."
    - name: "total_line_spend"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total spend value across all PO line items. Granular spend metric for category and SKU-level cost analysis."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total invoiced value across PO lines. Used to reconcile supplier billing against ordered amounts."
    - name: "total_goods_receipt_amount"
      expr: SUM(CAST(goods_receipt_amount AS DOUBLE))
      comment: "Total value of goods received. Supports accrual accounting and receipt-based payment processing."
    - name: "total_price_variance_amount"
      expr: SUM(CAST(price_variance_amount AS DOUBLE))
      comment: "Total price variance between PO price and invoice price. Key cost-control KPI — large variances indicate pricing discipline failures."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across PO line items. Supports tax liability reporting and cost-of-goods analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO line items. Benchmarks procurement pricing and identifies cost-reduction opportunities."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage achieved on PO lines. Measures negotiation effectiveness and supplier discount yield."
    - name: "moq_non_compliant_line_count"
      expr: COUNT(CASE WHEN moq_compliance_flag = FALSE THEN 1 END)
      comment: "Number of PO lines that do not meet minimum order quantity. Indicates contract compliance risk and potential penalty exposure."
    - name: "goods_receipt_blocked_line_count"
      expr: COUNT(CASE WHEN goods_receipt_blocked_flag = TRUE THEN 1 END)
      comment: "Number of PO lines with goods receipt blocked. Highlights operational bottlenecks preventing inventory inflow."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics and receiving quality KPIs covering delivery accuracy, discrepancy rates, freight costs, and quality inspection outcomes. Enables warehouse and procurement teams to monitor supplier delivery performance and receiving efficiency."
  source: "`ecommerce_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "gr_posting_status"
      expr: gr_posting_status
      comment: "Status of the goods receipt posting (e.g. Posted, Pending, Reversed). Tracks receiving workflow completion."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current shipment status (e.g. In Transit, Delivered, Delayed). Supports inbound logistics monitoring."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Outcome of quality inspection at receipt (e.g. Passed, Failed, Pending). Drives supplier quality management decisions."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match between PO, GR, and invoice. Critical for AP processing and fraud prevention."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Trade terms governing delivery responsibility. Used to segment freight cost and risk by delivery model."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the shipment. Supports trade compliance, tariff analysis, and supply-chain diversification."
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Flag for hazardous material shipments. Enables compliance monitoring and special handling cost tracking."
    - name: "is_over_delivery"
      expr: is_over_delivery
      comment: "Flag indicating quantity received exceeds ordered quantity. Tracks over-delivery frequency and inventory impact."
    - name: "is_under_delivery"
      expr: is_under_delivery
      comment: "Flag indicating quantity received is less than ordered. Tracks under-delivery frequency and supply shortfall risk."
    - name: "freight_currency_code"
      expr: freight_currency_code
      comment: "Currency of freight cost. Supports multi-currency logistics cost analysis."
    - name: "actual_arrival_date_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_date)
      comment: "Month of actual goods arrival. Enables trend analysis of inbound volume and delivery timing."
    - name: "gr_posting_date_month"
      expr: DATE_TRUNC('MONTH', gr_posting_date)
      comment: "Month of goods receipt posting. Supports accrual period alignment and receiving throughput analysis."
  measures:
    - name: "total_goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts. Baseline inbound volume metric for warehouse capacity and receiving workload planning."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total units received across all goods receipts. Core inbound fulfilment volume metric."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total units rejected at receipt. High rejection volumes signal supplier quality failures and drive corrective action."
    - name: "total_discrepancy_quantity"
      expr: SUM(CAST(discrepancy_quantity AS DOUBLE))
      comment: "Total quantity discrepancy between ordered and received. Measures fulfilment accuracy and supplier reliability."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total inbound freight cost across all receipts. Key logistics cost KPI for procurement cost-of-goods analysis."
    - name: "avg_freight_cost_per_receipt"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per goods receipt. Benchmarks inbound logistics efficiency and identifies cost outliers."
    - name: "over_delivery_count"
      expr: COUNT(CASE WHEN is_over_delivery = TRUE THEN 1 END)
      comment: "Number of receipts with over-delivery. Excess deliveries create inventory holding costs and supplier compliance issues."
    - name: "under_delivery_count"
      expr: COUNT(CASE WHEN is_under_delivery = TRUE THEN 1 END)
      comment: "Number of receipts with under-delivery. Under-deliveries cause stockouts and fulfilment failures downstream."
    - name: "quality_failed_receipt_count"
      expr: COUNT(CASE WHEN quality_inspection_status = 'Failed' THEN 1 END)
      comment: "Number of receipts that failed quality inspection. Directly linked to supplier quality performance and return costs."
    - name: "three_way_match_failed_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Failed' THEN 1 END)
      comment: "Number of receipts where three-way match failed. Indicates invoice discrepancies requiring AP intervention and fraud risk."
    - name: "distinct_supplier_receipt_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with goods receipts in the period. Measures active supplier delivery breadth."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-payable and invoice lifecycle KPIs covering invoice volumes, spend, discrepancy rates, payment compliance, and three-way match outcomes. Enables finance and procurement teams to manage payables, detect billing anomalies, and optimise payment terms."
  source: "`ecommerce_ecm`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. Approved, Pending, Rejected). Drives AP workflow and cash-flow forecasting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the invoice. Identifies invoices awaiting authorisation and potential payment delays."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of supplier invoice (e.g. Standard, Credit Note, Debit Note). Supports invoice mix and liability analysis."
    - name: "invoice_category"
      expr: invoice_category
      comment: "Business category of the invoice. Enables spend categorisation and cost-centre allocation analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match outcome between PO, GR, and invoice. Critical control point for AP accuracy and fraud prevention."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of invoice discrepancy identified (e.g. Price, Quantity, Tax). Guides root-cause analysis of billing errors."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the invoice (e.g. Wire, ACH, Cheque). Supports payment channel optimisation and cost analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code (e.g. Net30, Net60). Drives working-capital and early-payment discount analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency. Supports multi-currency payables and FX exposure analysis."
    - name: "payment_block_flag"
      expr: payment_block_flag
      comment: "Indicates whether payment is blocked for this invoice. Highlights invoices requiring resolution before payment release."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice. Enables year-over-year spend and liability comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice. Supports period-close accrual and spend reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date. Enables monthly AP volume and spend trend analysis."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month payment is due. Supports cash-flow forecasting and payment scheduling."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. Baseline AP volume metric for workload and process efficiency benchmarking."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value. Primary AP liability metric for cash-flow management and budget tracking."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice value after discounts. Reflects actual payment obligation and is used for accrual reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment or negotiated discount captured. Measures working-capital optimisation through payment terms management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across supplier invoices. Supports tax liability reporting and compliance."
    - name: "total_discrepancy_amount"
      expr: SUM(CAST(discrepancy_amount AS DOUBLE))
      comment: "Total financial value of invoice discrepancies. High discrepancy amounts indicate systemic billing errors or fraud risk."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total invoice value in functional (reporting) currency. Enables consolidated financial reporting across multi-currency payables."
    - name: "payment_blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_flag = TRUE THEN 1 END)
      comment: "Number of invoices with payment blocked. Indicates AP bottlenecks and potential supplier relationship risk."
    - name: "three_way_match_failed_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Failed' THEN 1 END)
      comment: "Number of invoices failing three-way match. Drives AP exception management and supplier billing accuracy improvement."
    - name: "distinct_supplier_invoice_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers invoiced in the period. Measures active supplier billing breadth and AP workload distribution."
    - name: "avg_net_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Benchmarks typical invoice size and helps identify outlier or split-invoice patterns."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier scorecard KPIs covering delivery reliability, quality, fill rates, invoice accuracy, cost variance, and sustainability compliance. The primary strategic view for procurement leadership to evaluate, tier, and manage the supplier base."
  source: "`ecommerce_ecm`.`procurement`.`supplier_performance`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Current supplier performance tier (e.g. Gold, Silver, Bronze). Drives supplier stratification and preferential treatment decisions."
    - name: "previous_performance_tier"
      expr: previous_performance_tier
      comment: "Prior period performance tier. Enables tier movement analysis and trend-based supplier development decisions."
    - name: "evaluation_period_type"
      expr: evaluation_period_type
      comment: "Type of evaluation period (e.g. Monthly, Quarterly, Annual). Supports consistent period-over-period benchmarking."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Publication status of the scorecard (e.g. Published, Draft, Acknowledged). Tracks scorecard governance completion."
    - name: "contract_renewal_recommendation"
      expr: contract_renewal_recommendation
      comment: "Recommended action for contract renewal (e.g. Renew, Terminate, Renegotiate). Directly informs sourcing strategy decisions."
    - name: "tier_reclassification_flag"
      expr: tier_reclassification_flag
      comment: "Indicates whether the supplier was reclassified this period. Highlights suppliers with significant performance changes."
    - name: "supplier_acknowledged_flag"
      expr: supplier_acknowledged_flag
      comment: "Indicates whether the supplier has acknowledged their scorecard. Tracks supplier engagement in performance management."
    - name: "development_program_enrolled_flag"
      expr: development_program_enrolled_flag
      comment: "Indicates supplier enrolment in a development programme. Supports supplier improvement initiative tracking."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Start month of the evaluation period. Enables time-series analysis of supplier performance trends."
    - name: "scorecard_published_date_month"
      expr: DATE_TRUNC('MONTH', scorecard_published_date)
      comment: "Month scorecard was published. Tracks scorecard cadence and governance timeliness."
  measures:
    - name: "total_supplier_evaluations"
      expr: COUNT(1)
      comment: "Total number of supplier performance evaluations. Baseline metric for scorecard coverage and governance completeness."
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall supplier performance score. Primary KPI for supplier base health and strategic sourcing decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across suppliers. Directly linked to inventory availability and customer fulfilment performance."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average order fill rate across suppliers. Measures supplier capacity to fulfil ordered quantities and prevent stockouts."
    - name: "avg_defect_rate_dppm"
      expr: AVG(CAST(defect_rate_dppm AS DOUBLE))
      comment: "Average defect rate in defects per million parts. Core quality KPI driving supplier qualification and corrective action."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate across suppliers. Measures billing quality and AP processing efficiency."
    - name: "avg_lead_time_adherence_rate"
      expr: AVG(CAST(lead_time_adherence_rate AS DOUBLE))
      comment: "Average lead time adherence rate. Indicates supplier reliability in meeting contracted delivery timelines."
    - name: "avg_procurement_cost_variance_pct"
      expr: AVG(CAST(procurement_cost_variance_pct AS DOUBLE))
      comment: "Average procurement cost variance percentage. Measures pricing discipline and contract compliance across the supplier base."
    - name: "avg_sustainability_compliance_score"
      expr: AVG(CAST(sustainability_compliance_score AS DOUBLE))
      comment: "Average sustainability compliance score. Supports ESG reporting and responsible sourcing programme management."
    - name: "avg_return_rate"
      expr: AVG(CAST(return_rate AS DOUBLE))
      comment: "Average product return rate per supplier. High return rates indicate quality or specification compliance failures."
    - name: "total_units_received"
      expr: SUM(CAST(total_units_received AS DOUBLE))
      comment: "Total units received from evaluated suppliers. Provides volume context for performance rate interpretation."
    - name: "avg_actual_lead_time_days"
      expr: AVG(CAST(avg_actual_lead_time_days AS DOUBLE))
      comment: "Average actual lead time in days across suppliers. Benchmarks delivery speed and informs safety stock calculations."
    - name: "tier_reclassified_supplier_count"
      expr: COUNT(CASE WHEN tier_reclassification_flag = TRUE THEN 1 END)
      comment: "Number of suppliers reclassified to a different performance tier. Indicates volatility in supplier base quality."
    - name: "unacknowledged_scorecard_count"
      expr: COUNT(CASE WHEN supplier_acknowledged_flag = FALSE THEN 1 END)
      comment: "Number of scorecards not yet acknowledged by the supplier. Tracks supplier engagement gaps in performance governance."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master KPIs covering risk profiling, compliance certifications, diversity, and onboarding status. Enables procurement leadership to govern the supplier base, manage risk concentration, and ensure regulatory compliance."
  source: "`ecommerce_ecm`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_tier"
      expr: supplier_tier
      comment: "Strategic tier classification of the supplier (e.g. Strategic, Preferred, Approved). Drives sourcing prioritisation and relationship investment."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (e.g. Manufacturer, Distributor, Broker). Supports supply-chain structure and risk analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification of the supplier (e.g. High, Medium, Low). Primary dimension for risk-based supplier management."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding state of the supplier (e.g. Active, Pending, Suspended). Tracks supplier lifecycle and activation pipeline."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the supplier is based. Supports geographic risk analysis and trade compliance monitoring."
    - name: "is_preferred_vendor"
      expr: is_preferred_vendor
      comment: "Flag indicating preferred vendor status. Enables spend concentration analysis on preferred vs. non-preferred suppliers."
    - name: "is_diversity_supplier"
      expr: is_diversity_supplier
      comment: "Flag indicating diversity supplier classification. Supports ESG and supplier diversity programme reporting."
    - name: "iso_certified"
      expr: iso_certified
      comment: "Flag indicating ISO certification status. Tracks quality management system compliance across the supplier base."
    - name: "cpsc_compliant"
      expr: cpsc_compliant
      comment: "Flag indicating CPSC product safety compliance. Critical for regulatory risk management in consumer goods procurement."
    - name: "gdpr_compliant"
      expr: gdpr_compliant
      comment: "Flag indicating GDPR data privacy compliance. Required for suppliers handling personal data in EU markets."
    - name: "pci_dss_compliant"
      expr: pci_dss_compliant
      comment: "Flag indicating PCI-DSS payment security compliance. Required for suppliers involved in payment data processing."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Standard payment terms for the supplier. Supports working-capital optimisation and cash-flow planning."
    - name: "onboarding_date_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month of supplier onboarding. Tracks supplier acquisition rate and pipeline growth over time."
  measures:
    - name: "total_supplier_count"
      expr: COUNT(1)
      comment: "Total number of suppliers in the master list. Baseline metric for supplier base size and management scope."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across the supplier base. Headline risk KPI for procurement leadership and board-level risk reporting."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN risk_category = 'High' THEN 1 END)
      comment: "Number of suppliers classified as high risk. Drives risk mitigation prioritisation and dual-sourcing decisions."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN is_preferred_vendor = TRUE THEN 1 END)
      comment: "Number of preferred vendors. Measures the size of the strategic supplier pool and preferred-vendor programme coverage."
    - name: "diversity_supplier_count"
      expr: COUNT(CASE WHEN is_diversity_supplier = TRUE THEN 1 END)
      comment: "Number of diversity-classified suppliers. Tracks progress against supplier diversity and ESG commitments."
    - name: "iso_certified_supplier_count"
      expr: COUNT(CASE WHEN iso_certified = TRUE THEN 1 END)
      comment: "Number of ISO-certified suppliers. Measures quality management system compliance across the supply base."
    - name: "gdpr_non_compliant_supplier_count"
      expr: COUNT(CASE WHEN gdpr_compliant = FALSE THEN 1 END)
      comment: "Number of suppliers not GDPR compliant. Identifies regulatory exposure in data-sharing supplier relationships."
    - name: "cpsc_non_compliant_supplier_count"
      expr: COUNT(CASE WHEN cpsc_compliant = FALSE THEN 1 END)
      comment: "Number of suppliers not CPSC compliant. Highlights product safety regulatory risk in the supply base."
    - name: "active_supplier_count"
      expr: COUNT(CASE WHEN onboarding_status = 'Active' THEN 1 END)
      comment: "Number of fully onboarded and active suppliers. Measures the operational supplier base available for procurement."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract lifecycle and financial KPIs covering contract values, SLA commitments, penalty exposure, and renewal pipeline. Enables legal, procurement, and finance teams to manage contract risk, compliance, and strategic sourcing obligations."
  source: "`ecommerce_ecm`.`procurement`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the vendor contract (e.g. Active, Expired, Terminated). Drives contract lifecycle management and renewal prioritisation."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract (e.g. Master, Blanket, Spot). Supports contract portfolio analysis and sourcing strategy review."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency. Supports multi-currency contract value and FX exposure analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews. Identifies contracts requiring proactive review before automatic commitment."
    - name: "penalty_clause_flag"
      expr: penalty_clause_flag
      comment: "Indicates whether the contract contains penalty clauses. Highlights contracts with financial risk exposure for SLA breaches."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether the contract grants supplier exclusivity. Tracks single-source dependency and competitive sourcing constraints."
    - name: "nda_flag"
      expr: nda_flag
      comment: "Indicates whether an NDA is in place. Supports confidentiality compliance and IP protection monitoring."
    - name: "gdpr_dpa_flag"
      expr: gdpr_dpa_flag
      comment: "Indicates whether a GDPR Data Processing Agreement is in place. Critical for regulatory compliance in data-sharing contracts."
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country whose law governs the contract. Supports legal jurisdiction analysis and cross-border contract risk management."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Trade terms in the contract. Used to segment delivery responsibility and freight cost obligations."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective. Enables contract cohort analysis and spend commitment timing."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the contract expires. Drives renewal pipeline management and sourcing calendar planning."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of vendor contracts. Baseline metric for contract portfolio size and legal obligation scope."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed value across all vendor contracts. Primary financial KPI for procurement commitment and budget exposure."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value. Benchmarks deal size and identifies strategic vs. transactional supplier relationships."
    - name: "total_penalty_cap_exposure"
      expr: SUM(CAST(penalty_cap_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across contracts with penalty clauses. Quantifies financial risk from SLA breach scenarios."
    - name: "avg_sla_on_time_delivery_pct"
      expr: AVG(CAST(sla_on_time_delivery_pct AS DOUBLE))
      comment: "Average contracted on-time delivery SLA percentage. Benchmarks delivery commitments and identifies contracts with weak SLA terms."
    - name: "avg_sla_fill_rate_pct"
      expr: AVG(CAST(sla_fill_rate_pct AS DOUBLE))
      comment: "Average contracted fill rate SLA percentage. Measures the supply availability commitments secured in vendor contracts."
    - name: "avg_sla_defect_rate_pct"
      expr: AVG(CAST(sla_defect_rate_pct AS DOUBLE))
      comment: "Average contracted defect rate SLA percentage. Tracks quality thresholds negotiated into vendor agreements."
    - name: "avg_penalty_rate_pct"
      expr: AVG(CAST(penalty_rate_pct AS DOUBLE))
      comment: "Average penalty rate percentage across contracts with penalty clauses. Indicates the financial leverage available for SLA enforcement."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts set to auto-renew. Highlights contracts requiring proactive review to avoid unintended commitment."
    - name: "exclusivity_contract_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of contracts with exclusivity clauses. Measures single-source dependency risk in the supplier portfolio."
    - name: "gdpr_dpa_missing_count"
      expr: COUNT(CASE WHEN gdpr_dpa_flag = FALSE THEN 1 END)
      comment: "Number of contracts without a GDPR Data Processing Agreement. Identifies regulatory compliance gaps in data-sharing supplier relationships."
    - name: "distinct_supplier_contract_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers under contract. Measures contracted supplier base coverage and sourcing formalisation."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Vendor List (AVL) governance KPIs covering vendor qualification scores, risk ratings, compliance certifications, and diversity status. Enables procurement governance teams to maintain a compliant, risk-managed, and strategically aligned approved supplier pool."
  source: "`ecommerce_ecm`.`procurement`.`approved_vendor_list`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the vendor list entry (e.g. Approved, Pending, Suspended). Drives AVL governance and vendor activation decisions."
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of the vendor on the AVL. Enables category-level vendor pool analysis and sourcing coverage assessment."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g. Manufacturer, Distributor). Supports supply-chain structure and risk diversification analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification of the AVL entry. Primary dimension for risk-based vendor management and mitigation prioritisation."
    - name: "is_preferred_vendor"
      expr: is_preferred_vendor
      comment: "Flag indicating preferred vendor status on the AVL. Supports preferred-vendor programme governance and spend channelling."
    - name: "is_diversity_supplier"
      expr: is_diversity_supplier
      comment: "Flag indicating diversity supplier classification. Tracks diversity programme coverage within the approved vendor pool."
    - name: "compliance_iso_certified"
      expr: compliance_iso_certified
      comment: "Flag indicating ISO certification compliance for the AVL entry. Measures quality management system coverage in the approved pool."
    - name: "cpsc_compliant"
      expr: cpsc_compliant
      comment: "Flag indicating CPSC product safety compliance. Tracks regulatory compliance within the approved vendor pool."
    - name: "gdpr_compliant"
      expr: gdpr_compliant
      comment: "Flag indicating GDPR compliance for the AVL entry. Supports data privacy regulatory governance."
    - name: "pci_dss_compliant"
      expr: pci_dss_compliant
      comment: "Flag indicating PCI-DSS compliance for the AVL entry. Required for vendors handling payment data."
    - name: "payment_currency"
      expr: payment_currency
      comment: "Payment currency for the vendor. Supports multi-currency procurement and FX risk analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the AVL entry became effective. Enables vendor pool growth and refresh trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the AVL entry expires. Drives proactive vendor re-qualification and AVL maintenance planning."
  measures:
    - name: "total_avl_entry_count"
      expr: COUNT(1)
      comment: "Total number of approved vendor list entries. Baseline metric for approved vendor pool size and governance scope."
    - name: "avg_qualification_score"
      expr: AVG(CAST(qualification_score AS DOUBLE))
      comment: "Average vendor qualification score on the AVL. Measures overall quality of the approved vendor pool and sourcing standards."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across AVL entries. Headline risk KPI for approved vendor pool health and risk concentration."
    - name: "high_risk_avl_count"
      expr: COUNT(CASE WHEN risk_category = 'High' THEN 1 END)
      comment: "Number of high-risk entries on the AVL. Drives risk mitigation actions such as dual-sourcing or vendor development."
    - name: "preferred_vendor_avl_count"
      expr: COUNT(CASE WHEN is_preferred_vendor = TRUE THEN 1 END)
      comment: "Number of preferred vendors on the AVL. Measures strategic vendor pool size and preferred-vendor programme coverage."
    - name: "diversity_supplier_avl_count"
      expr: COUNT(CASE WHEN is_diversity_supplier = TRUE THEN 1 END)
      comment: "Number of diversity suppliers on the AVL. Tracks supplier diversity programme penetration in the approved pool."
    - name: "iso_non_compliant_avl_count"
      expr: COUNT(CASE WHEN compliance_iso_certified = FALSE THEN 1 END)
      comment: "Number of AVL entries without ISO certification. Identifies quality compliance gaps in the approved vendor pool."
    - name: "cpsc_non_compliant_avl_count"
      expr: COUNT(CASE WHEN cpsc_compliant = FALSE THEN 1 END)
      comment: "Number of AVL entries not CPSC compliant. Highlights product safety regulatory risk in the approved vendor pool."
    - name: "pending_approval_avl_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of AVL entries awaiting approval. Tracks vendor onboarding pipeline and governance backlog."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`procurement_supplier_price_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier pricing governance KPIs covering unit prices, discount rates, MOQ compliance, and price list coverage. Enables category managers and procurement analysts to benchmark supplier pricing, manage price tolerance, and optimise sourcing decisions."
  source: "`ecommerce_ecm`.`procurement`.`supplier_price_list`"
  dimensions:
    - name: "supplier_price_list_status"
      expr: supplier_price_list_status
      comment: "Current status of the price list (e.g. Active, Expired, Superseded). Drives price list governance and sourcing validity."
    - name: "price_list_type"
      expr: price_list_type
      comment: "Type of price list (e.g. Standard, Promotional, Contract). Supports pricing strategy and sourcing channel analysis."
    - name: "price_list_category"
      expr: price_list_category
      comment: "Category of the price list. Enables category-level pricing benchmarking and cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price list. Supports multi-currency pricing and FX cost analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Trade terms associated with the price list. Used to segment landed cost and freight inclusion analysis."
    - name: "freight_included"
      expr: freight_included
      comment: "Flag indicating whether freight is included in the price. Enables true landed-cost comparison across price lists."
    - name: "has_volume_tiers"
      expr: has_volume_tiers
      comment: "Flag indicating whether the price list has volume-based pricing tiers. Identifies opportunities for volume consolidation savings."
    - name: "auto_po_pricing_enabled"
      expr: auto_po_pricing_enabled
      comment: "Flag indicating whether automatic PO pricing is enabled. Tracks automation coverage in procurement order processing."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the priced items. Supports trade compliance and tariff cost analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms associated with the price list. Supports working-capital and cash-flow optimisation analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the price list became effective. Enables price change trend analysis and inflation monitoring."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the price list expires. Drives proactive price renegotiation and sourcing calendar management."
  measures:
    - name: "total_price_list_count"
      expr: COUNT(1)
      comment: "Total number of supplier price list entries. Baseline metric for pricing catalogue coverage and supplier pricing governance scope."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across supplier price lists. Primary pricing benchmark for category cost analysis and negotiation targeting."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across price lists. Measures negotiated discount yield and supplier pricing competitiveness."
    - name: "avg_price_tolerance_percentage"
      expr: AVG(CAST(price_tolerance_percentage AS DOUBLE))
      comment: "Average price tolerance percentage. Indicates the acceptable price variance band negotiated with suppliers — tighter tolerances reduce invoice discrepancy risk."
    - name: "avg_moq"
      expr: AVG(CAST(moq AS DOUBLE))
      comment: "Average minimum order quantity across price lists. Benchmarks supplier MOQ requirements and their impact on inventory and cash flow."
    - name: "volume_tiered_price_list_count"
      expr: COUNT(CASE WHEN has_volume_tiers = TRUE THEN 1 END)
      comment: "Number of price lists with volume-based pricing tiers. Identifies consolidation opportunities to unlock volume discount savings."
    - name: "auto_po_enabled_price_list_count"
      expr: COUNT(CASE WHEN auto_po_pricing_enabled = TRUE THEN 1 END)
      comment: "Number of price lists with automatic PO pricing enabled. Measures procurement automation coverage and efficiency."
    - name: "distinct_supplier_price_list_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with active price lists. Measures pricing catalogue coverage across the supplier base."
    - name: "total_price_unit_quantity"
      expr: SUM(CAST(price_unit_quantity AS DOUBLE))
      comment: "Total price unit quantity across price list entries. Supports volume-weighted pricing analysis and MOQ aggregation."
$$;