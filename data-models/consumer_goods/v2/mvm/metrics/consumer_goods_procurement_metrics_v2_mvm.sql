-- Metric views for domain: procurement | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, spend, and status distribution. Enables procurement leadership to monitor total committed spend, order activity by supplier and currency, and payment terms compliance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled). Used to filter active vs. completed spend."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated. Enables multi-currency spend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms on the purchase order (e.g. Net30, Net60). Used to assess cash flow exposure and compliance with preferred terms."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery responsibility. Used to segment logistics cost and risk exposure."
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Calendar month the purchase order was raised. Enables trend analysis of procurement activity over time."
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Calendar year the purchase order was raised. Supports annual spend benchmarking."
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Core procurement spend KPI used in budget vs. actuals and supplier spend analysis."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order. Indicates order consolidation efficiency — low averages may signal maverick buying or fragmented procurement."
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders raised. Measures procurement transaction volume and workload."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers receiving purchase orders. Tracks supplier base breadth and concentration risk."
    - name: "max_single_po_value"
      expr: MAX(CAST(total_amount AS DOUBLE))
      comment: "Largest single purchase order value. Flags high-value commitments requiring executive visibility or additional approval scrutiny."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement spend and delivery performance KPIs. Enables granular analysis of what is being purchased, at what price, and whether delivery commitments are being met."
  source: "`vibe_consumer_goods_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (e.g. Open, Received, Cancelled). Used to track fulfilment progress at line level."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity. Enables volume analysis across comparable units."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Scheduled delivery month for the PO line. Used to project inbound supply and identify delivery bottlenecks."
    - name: "delivery_year"
      expr: YEAR(delivery_date)
      comment: "Scheduled delivery year for the PO line. Supports annual supply planning analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the PO line was created. Used to track procurement activity trends over time."
  measures:
    - name: "total_line_spend"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total spend committed at PO line level. Granular spend KPI enabling category and material-level cost analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines. Used to benchmark pricing trends and identify price variance against contracts."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity ordered across PO lines. Measures procurement volume for supply planning and demand fulfilment tracking."
    - name: "po_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines. Measures procurement complexity and workload at line level."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of distinct materials being procured. Tracks portfolio breadth and supports category management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt KPIs tracking volume, quality inspection requirements, and receipt status. Enables supply chain and quality teams to monitor inbound fulfilment performance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g. Posted, Pending, Reversed). Used to identify unresolved receipts and fulfilment gaps."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether a quality inspection is required for this receipt. Used to track inspection workload and compliance."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month goods were received. Enables trend analysis of inbound supply volumes over time."
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year goods were received. Supports annual inbound volume benchmarking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantity. Enables volume comparisons across compatible units."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Core inbound supply KPI used to track fulfilment against purchase orders."
    - name: "avg_received_quantity_per_receipt"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average quantity received per goods receipt document. Indicates typical delivery batch size and logistics efficiency."
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents. Measures inbound transaction volume and warehouse processing workload."
    - name: "quality_inspection_receipt_count"
      expr: SUM(CASE WHEN quality_inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of receipts requiring quality inspection. Used to plan quality control resource allocation and track inspection compliance rates."
    - name: "distinct_po_count_received"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of distinct purchase orders that have received at least one goods receipt. Measures PO fulfilment breadth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice management KPIs. Enables finance and procurement to monitor invoice volumes, outstanding liabilities, payment terms compliance, and overdue exposure."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the supplier invoice (e.g. Approved, Pending, Disputed, Paid). Used to track payables pipeline and dispute resolution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the supplier invoice. Enables multi-currency payables exposure analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the invoice. Used to assess compliance with negotiated terms and cash flow planning."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued. Enables trend analysis of invoice volumes and payables accruals."
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued. Supports annual payables benchmarking."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice payment is due. Used for cash flow forecasting and overdue liability identification."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total value of supplier invoices. Core accounts payable KPI representing total financial liability to suppliers."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice value. Used to benchmark invoice size trends and identify anomalous invoices requiring review."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. Measures AP transaction volume and processing workload."
    - name: "distinct_supplier_invoice_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers submitting invoices. Tracks active supplier billing relationships."
    - name: "pending_invoice_amount"
      expr: SUM(CASE WHEN invoice_status = 'Pending' THEN CAST(invoice_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of invoices in Pending status. Measures unresolved payables exposure requiring processing action."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN invoice_status = 'Disputed' THEN CAST(invoice_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of disputed invoices. High disputed amounts signal supplier relationship or quality issues requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level invoice KPIs enabling granular analysis of billed amounts, tax exposure, and unit pricing accuracy. Supports three-way match analysis and cost control."
  source: "`vibe_consumer_goods_v1`.`procurement`.`invoice_line`"
  dimensions:
    - name: "invoice_line_number"
      expr: line_number
      comment: "Line number within the supplier invoice. Used for line-level reconciliation and audit tracing."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the invoice line was created. Enables trend analysis of billing activity."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total billed amount across invoice lines. Granular payables KPI enabling category and material-level cost analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across invoice lines. Used for tax liability reporting and compliance with regulatory requirements."
    - name: "avg_unit_price_invoiced"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price on invoiced lines. Used to detect price variance against PO unit prices, a key three-way match control."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity billed by suppliers. Compared against received quantity to identify overbilling or short-delivery situations."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines. Measures AP processing complexity and volume."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master KPIs for strategic supplier management, diversity tracking, and performance benchmarking. Enables procurement leadership to assess supplier base health, diversity compliance, and delivery performance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current status of the supplier (e.g. Active, Inactive, Blocked). Used to monitor active supplier base size."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classification of the supplier (e.g. Manufacturer, Distributor, Service Provider). Enables spend and performance analysis by supplier category."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating assigned to the supplier. Used to segment suppliers by quality tier for sourcing decisions."
    - name: "sustainability_rating"
      expr: sustainability_rating
      comment: "Sustainability rating of the supplier. Used for ESG compliance reporting and sustainable sourcing strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Primary currency of the supplier. Used for FX exposure analysis in the supplier base."
    - name: "is_strategic_supplier"
      expr: is_strategic_supplier
      comment: "Flag indicating whether the supplier is classified as strategic. Used to segment KPIs between strategic and non-strategic suppliers."
    - name: "is_minority_owned"
      expr: is_minority_owned
      comment: "Flag indicating minority-owned business status. Used for supplier diversity compliance reporting."
    - name: "is_woman_owned"
      expr: is_woman_owned
      comment: "Flag indicating woman-owned business status. Used for supplier diversity compliance reporting."
  measures:
    - name: "active_supplier_count"
      expr: SUM(CASE WHEN supplier_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active suppliers. Core supplier base KPI used to track supply market coverage and concentration risk."
    - name: "strategic_supplier_count"
      expr: SUM(CASE WHEN is_strategic_supplier = TRUE THEN 1 ELSE 0 END)
      comment: "Number of suppliers classified as strategic. Used to monitor strategic partnership portfolio size."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage across suppliers. Key supplier performance KPI directly linked to supply chain reliability and customer service levels."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit extended to suppliers. Used to assess financial exposure and credit risk concentration in the supplier base."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit across all suppliers. Measures aggregate financial exposure to the supplier base for risk management."
    - name: "diversity_supplier_count"
      expr: SUM(CASE WHEN is_minority_owned = TRUE OR is_woman_owned = TRUE THEN 1 ELSE 0 END)
      comment: "Number of diverse suppliers (minority-owned or woman-owned). Used for supplier diversity program compliance and ESG reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs for procurement governance. Enables leadership to monitor contracted spend coverage, contract expiry risk, auto-renewal exposure, and compliance with preferred contract types."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the supplier contract (e.g. Active, Expired, Draft). Used to monitor active contract coverage."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of supplier contract (e.g. Framework, Spot, Long-term). Used to analyse contract portfolio composition."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract. Enables multi-currency contracted spend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms in the contract. Used to assess compliance with preferred payment terms policy."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews. Used to identify contracts requiring proactive review before automatic commitment."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms specified in the contract. Used to analyse logistics risk and cost allocation across the contract portfolio."
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the contract became effective. Used to track contract portfolio growth over time."
    - name: "contract_end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the contract expires. Used for contract expiry risk management and renewal pipeline planning."
  measures:
    - name: "total_contracted_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of all supplier contracts. Measures the scale of contractually committed procurement spend — a key governance and budget KPI."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average value per supplier contract. Used to benchmark contract size and identify outliers requiring additional scrutiny."
    - name: "active_contract_count"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active supplier contracts. Measures active contractual coverage of the supply base."
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts set to auto-renew. Flags contracts requiring proactive review to avoid unintended commitment renewals."
    - name: "total_active_contracted_value"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN CAST(total_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of active contracts. Represents current contractually protected spend — used in spend-under-management reporting."
    - name: "distinct_supplier_contract_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with contracts. Measures contracted supplier base coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_approved_supplier_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Supplier List (ASL) KPIs for sourcing governance and compliance. Enables procurement and quality teams to monitor supplier approval coverage, preferred supplier utilisation, and ASL expiry risk."
  source: "`vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the supplier-material combination (e.g. Approved, Pending, Revoked). Used to track sourcing compliance."
    - name: "is_preferred_supplier"
      expr: is_preferred_supplier
      comment: "Flag indicating whether the supplier is the preferred source for this material. Used to measure preferred supplier utilisation rates."
    - name: "ranking"
      expr: ranking
      comment: "Ranking of the supplier for the material (e.g. Primary, Secondary, Tertiary). Used to analyse supply base tiering and backup source coverage."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the supplier was approved. Used to track ASL growth and approval activity trends."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the supplier approval expires. Used for proactive ASL renewal management and compliance risk monitoring."
  measures:
    - name: "approved_supplier_count"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Number of approved supplier-material combinations. Measures the breadth of qualified supply options available to procurement."
    - name: "preferred_supplier_count"
      expr: SUM(CASE WHEN is_preferred_supplier = TRUE THEN 1 ELSE 0 END)
      comment: "Number of preferred supplier designations on the ASL. Used to track preferred supplier programme coverage."
    - name: "asl_entry_count"
      expr: COUNT(1)
      comment: "Total number of ASL entries. Measures the overall size and coverage of the approved supplier programme."
    - name: "distinct_material_coverage"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of distinct materials with at least one approved supplier. Measures sourcing coverage — materials without approved suppliers represent procurement risk."
    - name: "distinct_approved_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers on the approved supplier list. Tracks the qualified supplier base size for governance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_contract_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract line KPIs for spend coverage and pricing governance. Enables category managers to analyse contracted unit prices, quantities, and line values to assess contract utilisation and pricing competitiveness."
  source: "`vibe_consumer_goods_v1`.`procurement`.`contract_line`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract line. Enables multi-currency contracted spend analysis at line level."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the contracted quantity. Used to compare contracted volumes across compatible units."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the contract line was created. Used to track contract line activity and amendment trends."
  measures:
    - name: "total_contract_line_value"
      expr: SUM(CAST(line_value AS DOUBLE))
      comment: "Total value of all contract lines. Measures the aggregate contracted spend commitment at line level for spend-under-management reporting."
    - name: "avg_contract_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price across contract lines. Used to benchmark pricing and detect price escalation trends across contract renewals."
    - name: "total_contracted_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity committed across contract lines. Used for supply planning and to assess volume commitment leverage with suppliers."
    - name: "contract_line_count"
      expr: COUNT(1)
      comment: "Total number of contract lines. Measures contract complexity and the breadth of contracted material coverage."
    - name: "distinct_material_contracted"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of distinct materials covered by contract lines. Measures contracted category coverage — a key spend-under-management governance metric."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier site KPIs for supply base geographic and quality certification analysis. Enables procurement and quality teams to monitor site certification compliance, geographic distribution, and primary site coverage."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of supplier site (e.g. Manufacturing, Warehouse, Office). Used to segment the supply base by operational capability."
    - name: "country_code"
      expr: country_code
      comment: "Country where the supplier site is located. Used for geographic supply risk analysis and trade compliance reporting."
    - name: "is_primary_site"
      expr: is_primary_site
      comment: "Flag indicating whether this is the primary site for the supplier. Used to ensure all active suppliers have a designated primary site."
    - name: "gmp_certified"
      expr: gmp_certified
      comment: "Flag indicating GMP (Good Manufacturing Practice) certification status. Critical for regulated consumer goods categories."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Flag indicating ISO 9001 quality management certification. Used to track quality certification compliance across the supply base."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the supplier site. Enables sub-national geographic supply risk analysis."
  measures:
    - name: "total_site_count"
      expr: COUNT(1)
      comment: "Total number of supplier sites. Measures the geographic footprint of the supply base."
    - name: "gmp_certified_site_count"
      expr: SUM(CASE WHEN gmp_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of GMP-certified supplier sites. Critical compliance KPI for consumer goods procurement — non-certified sites represent regulatory risk."
    - name: "iso_9001_certified_site_count"
      expr: SUM(CASE WHEN iso_9001_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ISO 9001 certified supplier sites. Measures quality management system coverage across the supply base."
    - name: "primary_site_count"
      expr: SUM(CASE WHEN is_primary_site = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sites designated as primary. Used to verify that each active supplier has a primary site configured for order routing."
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries where supplier sites are located. Measures geographic diversification and concentration risk in the supply base."
$$;