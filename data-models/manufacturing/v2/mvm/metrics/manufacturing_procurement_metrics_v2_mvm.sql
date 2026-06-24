-- Metric views for domain: procurement | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management covering spend value, order cycle efficiency, approval performance, and compliance status. Used by procurement leadership to steer sourcing strategy and supplier negotiations."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) for pipeline and backlog analysis."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Consignment) to segment spend by procurement strategy."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Organizational unit responsible for the purchase order, enabling spend analysis by procurement entity."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group responsible for the purchase order, supporting workload and spend distribution analysis."
    - name: "material_category"
      expr: material_category
      comment: "Category of material being procured, enabling category management and spend analytics."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order for multi-currency spend reporting."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity / company code associated with the purchase order for entity-level spend reporting."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms agreed with the supplier, relevant for logistics cost and risk allocation analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the purchase order, used to monitor governance compliance and bottlenecks."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against the purchase order, indicating fulfilment progress."
    - name: "invoice_receipt_status"
      expr: invoice_receipt_status
      comment: "Status of invoice receipt against the purchase order, used for AP matching and cash flow forecasting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance classification of the purchase order, used for regulatory and policy adherence monitoring."
    - name: "po_date_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of purchase order creation date, used for trend and seasonality analysis of procurement spend."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of the requested delivery date, used for demand timing and supplier scheduling analysis."
    - name: "priority"
      expr: priority
      comment: "Priority classification of the purchase order (e.g. High, Medium, Low) for expediting and escalation analysis."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Mode of shipment for the purchase order, relevant for logistics cost and lead time analysis."
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed procurement spend across all purchase orders. Core KPI for spend management, budget tracking, and supplier negotiation leverage."
    - name: "total_net_po_spend"
      expr: SUM(CAST(net_po_value AS DOUBLE))
      comment: "Total net procurement spend (excluding tax) across purchase orders. Used for clean spend analytics and category management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders. Used for tax accrual, compliance reporting, and cash flow planning."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average value per purchase order. Indicates procurement transaction size and helps identify consolidation opportunities."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Used as a volume baseline for workload, throughput, and process efficiency analysis."
    - name: "approved_po_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of purchase orders that have been approved. Used to monitor approval throughput and governance compliance."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders that have been approved. Measures procurement governance effectiveness and approval bottleneck risk."
    - name: "open_po_spend"
      expr: SUM(CASE WHEN po_status = 'Open' THEN CAST(total_po_value AS DOUBLE) ELSE 0 END)
      comment: "Total spend committed in open (unfulfilled) purchase orders. Critical for cash flow forecasting and outstanding commitment tracking."
    - name: "closed_po_count"
      expr: COUNT(CASE WHEN po_status = 'Closed' THEN 1 END)
      comment: "Number of fully closed purchase orders. Indicates procurement cycle completion rate and backlog clearance."
    - name: "avg_days_to_approval"
      expr: AVG(CAST(DATEDIFF(approval_date, po_date) AS DOUBLE))
      comment: "Average number of days from PO creation to approval. Measures procurement cycle efficiency and identifies approval bottlenecks."
    - name: "avg_days_to_confirmed_delivery"
      expr: AVG(CAST(DATEDIFF(confirmed_delivery_date, po_date) AS DOUBLE))
      comment: "Average days from PO creation to confirmed delivery date. Proxy for supplier lead time and procurement planning accuracy."
    - name: "on_time_delivery_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN confirmed_delivery_date <= requested_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN confirmed_delivery_date IS NOT NULL AND requested_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of POs where the supplier confirmed delivery on or before the requested date. Key supplier performance and supply reliability KPI."
    - name: "non_compliant_po_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of purchase orders flagged as non-compliant. Used for procurement risk management and policy enforcement monitoring."
    - name: "non_compliant_po_spend"
      expr: SUM(CASE WHEN compliance_status != 'Compliant' THEN CAST(total_po_value AS DOUBLE) ELSE 0 END)
      comment: "Total spend value in non-compliant purchase orders. Quantifies financial exposure from procurement policy violations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_po_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs covering ordered quantities, pricing, receipt performance, and delivery compliance. Used by category managers and buyers to manage supplier performance and cost control at the item level."
  source: "`vibe_manufacturing_v1`.`procurement`.`po_line_item`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line item (e.g. Open, Closed, Cancelled) for line-level fulfilment tracking."
    - name: "item_category"
      expr: item_category
      comment: "Category classification of the PO line item (e.g. Standard, Subcontracting, Consignment) for spend segmentation."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant or receiving location for the PO line, enabling plant-level procurement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the PO line item for multi-currency spend reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity, used for volume and quantity analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms for the PO line, relevant for logistics cost and risk allocation."
    - name: "account_assignment_category"
      expr: account_assignment_category
      comment: "Account assignment category (e.g. Cost Center, Project, Asset) for spend allocation and cost accounting."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating whether goods receipt is required for this line, used for GR-based payment control analysis."
    - name: "invoice_receipt_indicator"
      expr: invoice_receipt_indicator
      comment: "Flag indicating whether invoice receipt is required for this line, used for AP matching analysis."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether quality inspection is required for this line, used for quality gate compliance monitoring."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the scheduled delivery date for the PO line, used for demand timing and supplier scheduling analysis."
    - name: "buyer_name"
      expr: buyer_name
      comment: "Name of the buyer responsible for the PO line, used for workload and performance analysis by buyer."
    - name: "deletion_indicator"
      expr: deletion_indicator
      comment: "Flag indicating whether the PO line has been marked for deletion, used to filter active vs. cancelled lines."
    - name: "final_invoice_indicator"
      expr: final_invoice_indicator
      comment: "Flag indicating the final invoice has been received for this line, used for AP closure and accrual management."
  measures:
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value across all PO line items. Core spend KPI for category management and supplier spend analysis."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across PO lines. Used for volume analysis, supplier capacity planning, and demand fulfilment tracking."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received against PO lines. Measures supplier delivery fulfilment and goods receipt performance."
    - name: "total_open_quantity"
      expr: SUM(CAST(open_quantity AS DOUBLE))
      comment: "Total outstanding (unfulfilled) quantity across PO lines. Indicates procurement backlog and supply risk exposure."
    - name: "total_quantity_invoiced"
      expr: SUM(CAST(quantity_invoiced AS DOUBLE))
      comment: "Total quantity invoiced by suppliers. Used for three-way match analysis and AP liability tracking."
    - name: "goods_receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_received AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been received. Key supplier delivery performance KPI — low fill rate signals supply risk."
    - name: "invoice_to_order_quantity_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_invoiced AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been invoiced. Used for AP accrual accuracy and three-way match compliance."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net unit price across PO line items. Used for price benchmarking, inflation tracking, and supplier negotiation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across PO line items. Used for tax accrual and compliance reporting."
    - name: "po_line_count"
      expr: COUNT(1)
      comment: "Total number of PO line items. Used as a volume baseline for buyer workload and procurement throughput analysis."
    - name: "lines_with_quality_inspection_count"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN 1 END)
      comment: "Number of PO lines requiring quality inspection. Used to plan inspection resource capacity and monitor quality gate coverage."
    - name: "over_delivery_tolerance_avg_pct"
      expr: AVG(CAST(over_delivery_tolerance_percent AS DOUBLE))
      comment: "Average over-delivery tolerance percentage across PO lines. Used to assess supplier flexibility terms and inventory buffer risk."
    - name: "under_delivery_tolerance_avg_pct"
      expr: AVG(CAST(under_delivery_tolerance_percent AS DOUBLE))
      comment: "Average under-delivery tolerance percentage across PO lines. Used to assess supply risk exposure from partial deliveries."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs measuring inbound supply performance, quality outcomes, quantity accuracy, and receiving efficiency. Used by supply chain and operations leadership to monitor supplier delivery quality and inbound logistics performance."
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt document (e.g. Posted, Reversed, Pending) for inbound fulfilment tracking."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type for the goods receipt (e.g. 101 GR for PO, 122 Return), used for inventory movement classification."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Outcome of quality inspection for the goods receipt (e.g. Passed, Failed, Pending), used for supplier quality monitoring."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection, Blocked), used for inventory availability analysis."
    - name: "receiving_plant_code"
      expr: receiving_plant_code
      comment: "Plant code where goods were received, enabling plant-level inbound performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation for multi-currency inventory reporting."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Flag indicating whether received goods were damaged, used for supplier claims and quality management."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating whether the goods receipt was reversed, used for correction and error rate analysis."
    - name: "return_authorization_flag"
      expr: return_authorization_flag
      comment: "Flag indicating whether a return authorization was issued, used for supplier return and claims management."
    - name: "gr_ir_clearing_status"
      expr: gr_ir_clearing_status
      comment: "GR/IR clearing status indicating whether the goods receipt has been matched to an invoice, used for AP reconciliation."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods receipt posting date, used for inbound volume trend analysis."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of actual delivery date, used for supplier on-time delivery trend analysis."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Flag indicating whether quality inspection was required for this receipt, used for quality gate coverage analysis."
    - name: "invoice_verification_flag"
      expr: invoice_verification_flag
      comment: "Flag indicating whether invoice verification has been completed for this receipt, used for AP matching status."
  measures:
    - name: "total_goods_receipt_value"
      expr: SUM(CAST(goods_receipt_value AS DOUBLE))
      comment: "Total value of goods received. Core KPI for inbound spend actuals, inventory valuation, and AP accrual."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Used for inbound volume tracking and supplier fulfilment analysis."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered as recorded on goods receipt documents. Used as denominator for fill rate and quantity variance analysis."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (received vs. ordered) across goods receipts. Measures supplier delivery accuracy and inventory discrepancy risk."
    - name: "avg_quantity_variance"
      expr: AVG(CAST(quantity_variance AS DOUBLE))
      comment: "Average quantity variance per goods receipt. Used to benchmark supplier delivery accuracy and set tolerance thresholds."
    - name: "gr_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received. Primary supplier delivery fulfilment KPI — directly impacts production continuity."
    - name: "gr_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents. Used as a volume baseline for inbound throughput and receiving workload analysis."
    - name: "damaged_receipt_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Number of goods receipts with damage reported. Used for supplier quality claims, insurance, and quality management."
    - name: "damaged_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts with damage. Key supplier quality KPI — high rates trigger supplier corrective action."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts that were reversed. Measures receiving process error rate and data quality in inbound logistics."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_inspection_status = 'Passed' THEN 1 END) / NULLIF(COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of inspected goods receipts that passed quality inspection. Core supplier quality KPI used in supplier scorecards."
    - name: "gr_ir_uncleared_count"
      expr: COUNT(CASE WHEN gr_ir_clearing_status != 'Cleared' THEN 1 END)
      comment: "Number of goods receipts not yet matched to an invoice (GR/IR uncleared). Used for AP reconciliation and period-end accrual management."
    - name: "gr_ir_uncleared_value"
      expr: SUM(CASE WHEN gr_ir_clearing_status != 'Cleared' THEN CAST(goods_receipt_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of uncleared GR/IR items. Quantifies AP accrual exposure and period-end liability for finance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier invoice KPIs covering AP liability, payment performance, invoice matching accuracy, and tolerance compliance. Used by finance and procurement leadership to manage cash flow, payment risk, and three-way match effectiveness."
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the supplier invoice (e.g. Open, Paid, Blocked, Cancelled) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of supplier invoice (e.g. Standard, Credit Memo, Debit Memo) for AP transaction classification."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO / GR / Invoice) for the invoice. Core AP control KPI for payment authorization."
    - name: "tolerance_check_status"
      expr: tolerance_check_status
      comment: "Result of tolerance check on the invoice (e.g. Within Tolerance, Exceeded). Used for exception management and payment blocking."
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason the invoice is blocked for payment, used for AP exception analysis and resolution prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the supplier invoice for multi-currency AP reporting."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity associated with the invoice for entity-level AP liability reporting."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization associated with the invoice for organizational spend reporting."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group associated with the invoice for workload and spend distribution analysis."
    - name: "material_category"
      expr: material_category
      comment: "Material category on the invoice for category-level AP spend analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the invoice for plant-level AP liability analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for annual AP spend and accrual reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for period-level AP reporting and accrual management."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for AP volume and spend trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of invoice posting date for period-level AP accrual and liability reporting."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of supplier invoices. Core AP liability KPI for cash flow forecasting and payment planning."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount (excluding tax and freight). Used for clean spend analytics and budget vs. actuals reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on supplier invoices. Used for tax accrual, VAT reporting, and compliance."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges on supplier invoices. Used for logistics cost analysis and freight spend management."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured on supplier invoices. Measures working capital optimization from discount capture."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted on supplier invoices. Used for tax compliance and statutory reporting."
    - name: "total_tolerance_variance_amount"
      expr: SUM(CAST(tolerance_variance_amount AS DOUBLE))
      comment: "Total monetary variance from tolerance checks across invoices. Quantifies pricing discrepancy exposure requiring resolution."
    - name: "avg_tolerance_variance_pct"
      expr: AVG(CAST(tolerance_variance_percentage AS DOUBLE))
      comment: "Average tolerance variance percentage across invoices. Used to benchmark invoice accuracy and set supplier pricing controls."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. Used as a volume baseline for AP workload, throughput, and processing efficiency."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN blocking_reason IS NOT NULL AND blocking_reason != '' THEN 1 END)
      comment: "Number of invoices currently blocked for payment. High blocked invoice count signals AP processing bottlenecks and supplier relationship risk."
    - name: "blocked_invoice_value"
      expr: SUM(CASE WHEN blocking_reason IS NOT NULL AND blocking_reason != '' THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of invoices blocked for payment. Quantifies cash flow risk and supplier payment exposure from AP exceptions."
    - name: "three_way_match_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that passed three-way match (PO/GR/Invoice). Core AP control effectiveness KPI — low rates indicate pricing or quantity discrepancies."
    - name: "tolerance_exceeded_invoice_count"
      expr: COUNT(CASE WHEN tolerance_check_status = 'Exceeded' THEN 1 END)
      comment: "Number of invoices where price or quantity variance exceeded tolerance limits. Used for exception management and supplier corrective action."
    - name: "avg_gross_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount per supplier invoice. Used to benchmark transaction size and identify outlier invoices."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across supplier invoices. Used for FX exposure monitoring and multi-currency AP analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_invoice_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level KPIs for three-way match accuracy, price variance, quantity variance, and tax compliance. Used by AP and procurement teams to manage invoice accuracy, resolve discrepancies, and control payment risk at the line level."
  source: "`vibe_manufacturing_v1`.`procurement`.`invoice_line_item`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status at the invoice line level (e.g. Matched, Price Variance, Quantity Variance) for exception management."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification status for the line (e.g. Verified, Pending, Blocked) for AP processing workflow tracking."
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (e.g. Material, Service, Freight) for spend classification and AP analysis."
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason the invoice line is blocked, used for AP exception root cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice line for multi-currency AP reporting."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the invoice line for plant-level AP spend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the invoiced quantity, used for quantity-based AP analysis."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for the invoice line (e.g. Standard Price, Moving Average) for inventory cost analysis."
    - name: "tolerance_group"
      expr: tolerance_group
      comment: "Tolerance group assigned to the invoice line, used for tolerance check configuration and exception analysis."
    - name: "verification_date_month"
      expr: DATE_TRUNC('MONTH', verification_date)
      comment: "Month of invoice line verification date for AP processing trend analysis."
    - name: "baseline_date_month"
      expr: DATE_TRUNC('MONTH', baseline_date)
      comment: "Month of baseline date (payment due date basis) for cash flow and payment timing analysis."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total invoice line amount. Core AP line-level spend KPI for detailed spend analysis and budget reconciliation."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount across invoice lines (excluding tax and discounts). Used for clean spend analytics."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across invoice lines. Used for tax accrual and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured at invoice line level. Measures early payment discount capture effectiveness."
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Total price variance (invoiced price vs. PO price) across invoice lines. Key AP control KPI — large variances indicate pricing discrepancies requiring resolution."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (invoiced quantity vs. GR quantity) across invoice lines. Used for three-way match exception management."
    - name: "avg_price_variance"
      expr: AVG(CAST(price_variance AS DOUBLE))
      comment: "Average price variance per invoice line. Used to benchmark invoice pricing accuracy and set supplier pricing controls."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced across all invoice lines. Used for volume-based AP analysis and three-way match quantity reconciliation."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total goods receipt quantity recorded on invoice lines. Used as denominator for invoice-to-GR quantity match rate."
    - name: "invoice_to_gr_quantity_match_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(invoiced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(goods_receipt_quantity AS DOUBLE)), 0), 2)
      comment: "Ratio of invoiced quantity to goods receipt quantity. Measures invoice accuracy against physical receipts — deviations trigger AP holds."
    - name: "price_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(price_variance AS DOUBLE)) / NULLIF(SUM(CAST(line_amount AS DOUBLE)), 0), 2)
      comment: "Price variance as a percentage of total invoice line amount. Measures overall invoice pricing accuracy and supplier contract compliance."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across invoice lines. Used to monitor discount terms compliance and early payment incentive utilization."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across invoice lines. Used for tax compliance monitoring and tax rate accuracy validation."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice line items. Used as a volume baseline for AP processing workload and throughput analysis."
    - name: "blocked_line_count"
      expr: COUNT(CASE WHEN blocking_reason IS NOT NULL AND blocking_reason != '' THEN 1 END)
      comment: "Number of invoice lines blocked for payment. Used for AP exception management and resolution prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract management KPIs covering contract value, utilization, compliance, and renewal risk. Used by procurement leadership and legal to manage supplier contract portfolio, spend under contract, and contract lifecycle risk."
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the procurement contract (e.g. Active, Expired, Terminated) for portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of procurement contract (e.g. Framework, Blanket, Fixed Price) for contract strategy analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract (e.g. Compliant, Non-Compliant) for regulatory and policy adherence monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency contract value reporting."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the contract for organizational contract portfolio analysis."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group managing the contract for workload and portfolio distribution analysis."
    - name: "material_category"
      expr: material_category
      comment: "Material category covered by the contract for category management and spend-under-contract analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the contract auto-renews, used for contract renewal risk and obligation management."
    - name: "confidentiality_clause_flag"
      expr: confidentiality_clause_flag
      comment: "Flag indicating whether the contract contains a confidentiality clause, used for legal risk and compliance tracking."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms in the contract for logistics cost and risk allocation analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of contract approval date for contract award trend analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of contract effective date for contract portfolio timeline analysis."
    - name: "last_amendment_date_month"
      expr: DATE_TRUNC('MONTH', last_amendment_date)
      comment: "Month of last contract amendment for contract change frequency analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all procurement contracts. Core KPI for spend-under-contract management and supplier commitment tracking."
    - name: "total_release_value"
      expr: SUM(CAST(release_value AS DOUBLE))
      comment: "Total value released (called off) against procurement contracts. Measures contract utilization and spend drawdown."
    - name: "total_remaining_value"
      expr: SUM(CAST(remaining_value AS DOUBLE))
      comment: "Total remaining uncommitted value across contracts. Used for contract capacity planning and budget forecasting."
    - name: "contract_value_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(release_value AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value that has been released/utilized. Measures contract consumption rate — low utilization may indicate over-contracting or demand shortfall."
    - name: "total_release_quantity"
      expr: SUM(CAST(release_quantity AS DOUBLE))
      comment: "Total quantity released against procurement contracts. Used for volume-based contract utilization analysis."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining quantity available under procurement contracts. Used for supply capacity and contract coverage planning."
    - name: "quantity_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(release_quantity AS DOUBLE)) / NULLIF(SUM(CAST(target_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of target contract quantity that has been released. Measures volume-based contract utilization against committed targets."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average value per procurement contract. Used to benchmark contract size and identify consolidation opportunities."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts. Used as a portfolio size baseline for contract management workload analysis."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active procurement contracts. Used for active supplier relationship and obligation management."
    - name: "non_compliant_contract_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of contracts flagged as non-compliant. Used for regulatory risk management and supplier governance."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts. Used for procurement planning and inventory policy alignment with contract terms."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total target quantity committed across all contracts. Used for supply capacity planning and demand coverage analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs covering demand-to-PO conversion, approval cycle time, spend estimation, and requisition compliance. Used by procurement and finance leadership to monitor demand management efficiency and procurement pipeline health."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g. Open, Approved, Rejected, Converted to PO) for pipeline tracking."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of purchase requisition (e.g. Standard, Subcontracting, Stock Transfer) for demand classification."
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department that raised the requisition, used for demand analysis by business unit and budget holder."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the requisition for plant-level demand and procurement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition for multi-currency spend estimation reporting."
    - name: "purchasing_organization_code"
      expr: purchasing_organization_code
      comment: "Purchasing organization responsible for fulfilling the requisition for organizational workload analysis."
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Buyer group assigned to the requisition for workload distribution analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the requisition (e.g. High, Medium, Low) for expediting and escalation analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating whether the requisition is compliant with procurement policy, used for governance monitoring."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Flag indicating whether multi-level approval is required, used for approval workflow complexity analysis."
    - name: "source_determination_indicator"
      expr: source_determination_indicator
      comment: "Flag indicating whether automatic source determination was applied, used for procurement automation analysis."
    - name: "pr_date_month"
      expr: DATE_TRUNC('MONTH', pr_date)
      comment: "Month of requisition creation date for demand trend and seasonality analysis."
    - name: "required_delivery_month"
      expr: DATE_TRUNC('MONTH', required_delivery_date)
      comment: "Month of required delivery date for demand timing and supply planning analysis."
    - name: "mrp_controller"
      expr: mrp_controller
      comment: "MRP controller responsible for the requisition, used for MRP-driven demand analysis and workload distribution."
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated spend value across purchase requisitions. Used for budget forecasting, spend pipeline management, and procurement planning."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions. Used for price benchmarking and budget accuracy assessment."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across purchase requisitions. Used for demand volume analysis and supply planning."
    - name: "pr_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions. Used as a demand volume baseline for procurement workload and pipeline analysis."
    - name: "approved_pr_count"
      expr: COUNT(CASE WHEN pr_status = 'Approved' THEN 1 END)
      comment: "Number of approved purchase requisitions. Used to monitor approval throughput and procurement pipeline readiness."
    - name: "rejected_pr_count"
      expr: COUNT(CASE WHEN pr_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected purchase requisitions. High rejection rates indicate demand quality issues or budget constraint signals."
    - name: "pr_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pr_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase requisitions that were approved. Measures demand management effectiveness and procurement governance quality."
    - name: "pr_to_po_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN po_number IS NOT NULL AND po_number != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase requisitions converted to purchase orders. Measures procurement pipeline conversion efficiency and demand fulfilment rate."
    - name: "avg_days_pr_to_po"
      expr: AVG(CAST(DATEDIFF(po_created_date, pr_date) AS DOUBLE))
      comment: "Average number of days from requisition creation to PO creation. Measures procurement cycle time efficiency — a key operational KPI for procurement speed."
    - name: "avg_days_pr_to_approval"
      expr: AVG(CAST(DATEDIFF(approved_date, pr_date) AS DOUBLE))
      comment: "Average number of days from requisition creation to approval. Measures approval cycle time and identifies governance bottlenecks."
    - name: "non_compliant_pr_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of non-compliant purchase requisitions. Used for procurement policy enforcement and risk management."
    - name: "non_compliant_pr_value"
      expr: SUM(CASE WHEN compliance_flag = FALSE THEN CAST(estimated_total_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated spend value in non-compliant requisitions. Quantifies financial exposure from procurement policy violations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_info_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier pricing and sourcing intelligence KPIs derived from purchase info records. Used by category managers and buyers to monitor price competitiveness, approved source coverage, and sourcing policy compliance."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_info_record`"
  dimensions:
    - name: "purchase_info_record_status"
      expr: purchase_info_record_status
      comment: "Status of the purchase info record (e.g. Active, Blocked, Archived) for sourcing master data quality management."
    - name: "info_record_type"
      expr: info_record_type
      comment: "Type of purchase info record (e.g. Standard, Subcontracting, Pipeline) for sourcing strategy classification."
    - name: "source_of_supply_category"
      expr: source_of_supply_category
      comment: "Category of supply source (e.g. Preferred, Approved, Spot) for supplier tiering and sourcing policy analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the info record for plant-level sourcing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the info record pricing for multi-currency price benchmarking."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization associated with the info record for organizational sourcing analysis."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group associated with the info record for workload and sourcing distribution analysis."
    - name: "approved_source_flag"
      expr: approved_source_flag
      comment: "Flag indicating whether this is an approved source of supply, used for sourcing compliance and preferred supplier analysis."
    - name: "fixed_source_flag"
      expr: fixed_source_flag
      comment: "Flag indicating whether this is a fixed (mandatory) source of supply, used for single-source risk analysis."
    - name: "mrp_relevant_flag"
      expr: mrp_relevant_flag
      comment: "Flag indicating whether this info record is used in MRP sourcing, used for automated procurement coverage analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms in the info record for logistics cost and risk allocation analysis."
    - name: "validity_start_date_month"
      expr: DATE_TRUNC('MONTH', validity_start_date)
      comment: "Month of info record validity start date for pricing timeline and contract coverage analysis."
    - name: "validity_end_date_month"
      expr: DATE_TRUNC('MONTH', validity_end_date)
      comment: "Month of info record validity end date for sourcing expiry risk monitoring."
    - name: "source_priority"
      expr: source_priority
      comment: "Priority ranking of the supply source, used for multi-source strategy and preferred supplier analysis."
  measures:
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net unit price across purchase info records. Core price benchmarking KPI for category management and supplier negotiation."
    - name: "min_net_price"
      expr: MIN(CAST(net_price AS DOUBLE))
      comment: "Minimum net unit price across info records. Used to identify best available price and benchmark supplier competitiveness."
    - name: "max_net_price"
      expr: MAX(CAST(net_price AS DOUBLE))
      comment: "Maximum net unit price across info records. Used to identify price outliers and high-cost sourcing relationships."
    - name: "avg_vendor_price_list"
      expr: AVG(CAST(vendor_price_list AS DOUBLE))
      comment: "Average vendor list price across info records. Used to calculate negotiated discount vs. list price and measure procurement savings."
    - name: "avg_price_discount_vs_list_pct"
      expr: ROUND(100.0 * (AVG(CAST(vendor_price_list AS DOUBLE)) - AVG(CAST(net_price AS DOUBLE))) / NULLIF(AVG(CAST(vendor_price_list AS DOUBLE)), 0), 2)
      comment: "Average percentage discount achieved vs. vendor list price. Measures procurement negotiation effectiveness and savings realization."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across info records. Used for inventory policy alignment and order consolidation analysis."
    - name: "avg_tolerance_limit_pct"
      expr: AVG(CAST(tolerance_limit_percent AS DOUBLE))
      comment: "Average price tolerance limit percentage across info records. Used to assess AP invoice tolerance configuration and exception risk."
    - name: "info_record_count"
      expr: COUNT(1)
      comment: "Total number of purchase info records. Used as a sourcing master data coverage baseline."
    - name: "approved_source_count"
      expr: COUNT(CASE WHEN approved_source_flag = TRUE THEN 1 END)
      comment: "Number of approved source info records. Used to measure approved supplier coverage and sourcing compliance."
    - name: "approved_source_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approved_source_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of info records from approved sources. Measures sourcing policy compliance — low coverage indicates maverick spend risk."
    - name: "fixed_source_count"
      expr: COUNT(CASE WHEN fixed_source_flag = TRUE THEN 1 END)
      comment: "Number of fixed (single-source) supply relationships. Used for single-source dependency risk assessment and supply chain resilience planning."
    - name: "mrp_relevant_record_count"
      expr: COUNT(CASE WHEN mrp_relevant_flag = TRUE THEN 1 END)
      comment: "Number of info records used in MRP automated sourcing. Measures automated procurement coverage and MRP sourcing data quality."
$$;