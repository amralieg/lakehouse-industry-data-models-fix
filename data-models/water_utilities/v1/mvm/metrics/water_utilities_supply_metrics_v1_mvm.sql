-- Metric views for domain: supply | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order activity in the water utilities supply domain. Tracks procurement spend, order volumes, tax burden, freight costs, and approval cycle efficiency to support executive oversight of capital and operational purchasing."
  source: "`water_utilities_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g., Open, Closed, Cancelled) — used to segment active vs. completed spend."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g., Standard, Blanket, Emergency) — drives procurement strategy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — identifies bottlenecks in the procurement approval pipeline."
    - name: "is_capital_purchase"
      expr: is_capital_purchase
      comment: "Flag indicating whether the PO is a capital expenditure — enables CapEx vs. OpEx spend segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the PO is denominated — supports multi-currency spend analysis."
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was issued — enables trend analysis of procurement activity over time."
    - name: "delivery_state"
      expr: delivery_state
      comment: "State/province of the delivery address — supports geographic distribution of procurement spend."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the vendor — informs cash flow planning and vendor negotiation strategy."
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed procurement spend across all purchase orders (excluding tax). Core CapEx/OpEx budget consumption metric for executive review."
    - name: "total_po_spend_with_tax"
      expr: SUM(CAST(total_amount_with_tax AS DOUBLE))
      comment: "Total procurement spend inclusive of tax. Used for full cash-outflow forecasting and budget reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Aggregate tax burden on purchase orders. Supports tax liability reporting and compliance monitoring."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight and logistics costs embedded in purchase orders. Identifies opportunities to reduce supply chain overhead."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order. Benchmarks procurement transaction size and flags anomalous high-value orders."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Measures procurement activity volume and workload on the purchasing team."
    - name: "capital_po_count"
      expr: COUNT(CASE WHEN is_capital_purchase = TRUE THEN 1 END)
      comment: "Number of purchase orders classified as capital expenditures. Tracks CapEx procurement pipeline for infrastructure investment oversight."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for goods receipt activity. Tracks received quantities, receipt values, three-way match compliance, quality inspection requirements, and reversal rates — critical for supply chain integrity and invoice accuracy in water utilities operations."
  source: "`water_utilities_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Current status of the goods receipt document (e.g., Posted, Reversed, Pending) — segments receipts by processing state."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type code indicating the nature of the goods movement (e.g., 101=GR for PO) — essential for inventory accounting classification."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO / GR / Invoice) — identifies invoices at risk of payment disputes or compliance failures."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates whether a quality inspection lot was triggered for this receipt — supports quality compliance tracking for treatment chemicals and critical materials."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags goods receipts that have been reversed — used to identify erroneous receipts and measure reversal rate."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g., Unrestricted, Quality Inspection, Blocked) — drives inventory availability analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation — supports multi-currency inventory cost analysis."
    - name: "gr_posting_month"
      expr: DATE_TRUNC('MONTH', gr_posting_date)
      comment: "Month the goods receipt was posted — enables trend analysis of inbound supply activity."
    - name: "delivery_condition"
      expr: delivery_condition
      comment: "Condition of goods upon delivery — supports vendor quality and logistics performance assessment."
  measures:
    - name: "total_received_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total monetary value of goods received. Primary measure of inbound supply spend and inventory asset creation."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Tracks inbound supply volume for inventory replenishment monitoring."
    - name: "avg_unit_price_received"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price at which goods were received. Benchmarks procurement pricing and detects price variance from PO terms."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of goods receipts that were reversed. High reversal counts signal receiving errors, vendor disputes, or quality rejections."
    - name: "quality_inspection_receipt_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of receipts requiring quality inspection. Tracks compliance with quality assurance protocols for treatment chemicals and critical spare parts."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status NOT IN ('Matched', 'Cleared') THEN 1 END)
      comment: "Number of goods receipts where the three-way match (PO/GR/Invoice) has not been resolved. Directly impacts accounts payable cycle time and audit risk."
    - name: "gr_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents. Measures inbound supply transaction volume and receiving team workload."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`supply_inventory_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic inventory health KPIs for water utilities supply management. Monitors stock value, availability, safety stock compliance, days of supply, and turnover efficiency — enabling proactive replenishment decisions and prevention of treatment chemical or critical spare shortages."
  source: "`water_utilities_ecm`.`supply`.`inventory_stock`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the inventory stock record (e.g., Active, Obsolete, Blocked) — segments usable vs. non-usable inventory."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g., Unrestricted, Quality Inspection, Blocked) — critical for determining available-to-use inventory."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of the material (A=high value/critical, B=medium, C=low) — drives prioritization of inventory management effort."
    - name: "mrp_type"
      expr: mrp_type
      comment: "Material Requirements Planning type — indicates how replenishment is triggered (e.g., reorder point, MRP, manual)."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Whether the material is externally procured or internally produced — informs make-vs-buy strategy."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flags hazardous materials in inventory — required for regulatory compliance and safety reporting."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant/facility code where the stock is held — enables facility-level inventory performance comparison."
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location within the plant — supports granular warehouse space utilization analysis."
    - name: "valuation_currency_code"
      expr: valuation_currency_code
      comment: "Currency used for stock valuation — supports multi-currency inventory reporting."
    - name: "expiration_controlled_flag"
      expr: expiration_controlled_flag
      comment: "Indicates whether the material has an expiration date — critical for treatment chemicals with shelf-life constraints."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(stock_value_amount AS DOUBLE))
      comment: "Total monetary value of inventory on hand. Primary balance-sheet metric for working capital management and inventory investment oversight."
    - name: "total_unrestricted_quantity"
      expr: SUM(CAST(unrestricted_stock_quantity AS DOUBLE))
      comment: "Total quantity of unrestricted (available-to-use) stock. Directly measures supply availability for treatment operations and maintenance."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity after reservations. Reflects net usable inventory for operational planning."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for planned consumption. Indicates committed supply that cannot be reallocated."
    - name: "total_blocked_stock_quantity"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total quantity of blocked stock (e.g., quality hold, damaged). High blocked stock signals quality or receiving issues requiring resolution."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity maintained across all locations. Benchmarks buffer inventory levels against operational risk tolerance."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply remaining across inventory items. A leading indicator of stockout risk — low values trigger urgent replenishment action."
    - name: "avg_stock_turnover_ratio"
      expr: AVG(CAST(stock_turnover_ratio AS DOUBLE))
      comment: "Average inventory turnover ratio. Measures how efficiently inventory is consumed — low turnover indicates excess stock and working capital inefficiency."
    - name: "avg_daily_consumption"
      expr: AVG(CAST(average_daily_consumption AS DOUBLE))
      comment: "Average daily consumption rate across stocked materials. Drives replenishment frequency planning and safety stock calibration."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN available_quantity < reorder_point THEN 1 END)
      comment: "Number of inventory items where available quantity has fallen below the reorder point. A critical operational alert metric — each item below reorder point is a potential stockout risk."
    - name: "quality_inspection_stock_quantity"
      expr: SUM(CAST(quality_inspection_stock_quantity AS DOUBLE))
      comment: "Total quantity currently in quality inspection hold. Tracks supply tied up in QC processes that is not yet available for operations."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`supply_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs for the supply domain. Tracks invoice values, payment cycle performance, discount capture, tax liabilities, and exception rates — enabling finance and procurement leadership to manage cash flow, vendor relationships, and compliance."
  source: "`water_utilities_ecm`.`supply`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the vendor invoice (e.g., Open, Paid, Blocked, Cancelled) — segments invoices by payment lifecycle stage."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice — supports multi-currency payables analysis."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Code indicating why payment is blocked — identifies systemic payment hold reasons for resolution prioritization."
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Method used for payment (e.g., ACH, Check, Wire) — supports payment method optimization and fraud risk analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice — enables year-over-year payables trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — supports period-close accrual and payables aging analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant/facility associated with the invoice — enables facility-level spend and payables analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued — enables monthly payables volume and spend trend analysis."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code assigned to invoices with processing issues — drives root-cause analysis of invoice exceptions."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all vendor invoices. Primary measure of accounts payable liability and vendor spend."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts. Reflects actual cash outflow obligation to vendors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on vendor invoices. Supports tax liability reporting and compliance with tax jurisdiction requirements."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures effectiveness of the AP team in leveraging vendor discount terms to reduce costs."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for regulatory tax compliance reporting."
    - name: "avg_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross value per vendor invoice. Benchmarks transaction size and identifies unusually large invoices for review."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of invoices currently blocked from payment. High blocked invoice counts indicate AP processing bottlenecks and vendor relationship risk."
    - name: "exception_invoice_count"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN 1 END)
      comment: "Number of invoices flagged with processing exceptions. Drives AP exception resolution workload and three-way match compliance monitoring."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices processed. Measures AP transaction volume and team throughput."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`supply_procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs for water utilities supply procurement. Monitors contract values, release utilization, remaining value, and diversity spend — enabling procurement leadership to manage vendor commitments, contract compliance, and strategic sourcing objectives."
  source: "`water_utilities_ecm`.`supply`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the procurement contract (e.g., Active, Expired, Terminated) — segments the active contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of procurement contract (e.g., Blanket Purchase Agreement, Fixed Price, Time & Materials) — drives contract strategy analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity or spend category covered by the contract — enables category management and strategic sourcing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — supports multi-currency contract portfolio analysis."
    - name: "minority_business_enterprise"
      expr: minority_business_enterprise
      comment: "Flags contracts with minority business enterprise vendors — tracks diversity spend compliance with regulatory and policy targets."
    - name: "small_business_enterprise"
      expr: small_business_enterprise
      comment: "Flags contracts with small business enterprise vendors — supports small business utilization reporting."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the contract — enables organizational spend accountability."
    - name: "contract_effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective — supports contract vintage analysis and renewal pipeline planning."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms stipulated in the contract — informs cash flow planning and vendor negotiation benchmarking."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed value across all procurement contracts. Primary measure of vendor spend commitment and procurement portfolio size."
    - name: "total_released_value"
      expr: SUM(CAST(total_released_value AS DOUBLE))
      comment: "Total value released (called off) against contracts. Measures actual spend drawdown against contracted commitments."
    - name: "total_remaining_contract_value"
      expr: SUM(CAST(remaining_contract_value AS DOUBLE))
      comment: "Total remaining unspent value across active contracts. Tracks available procurement capacity and identifies underutilized contracts."
    - name: "total_released_quantity"
      expr: SUM(CAST(total_released_quantity AS DOUBLE))
      comment: "Total quantity released against contract line items. Measures physical supply drawdown against contracted volumes."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average value per procurement contract. Benchmarks contract size and identifies outlier high-value contracts requiring enhanced oversight."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts in the portfolio. Measures contract management workload and vendor relationship breadth."
    - name: "diversity_contract_count"
      expr: COUNT(CASE WHEN minority_business_enterprise = TRUE OR small_business_enterprise = TRUE THEN 1 END)
      comment: "Number of contracts awarded to minority or small business enterprises. Tracks diversity spend compliance with utility regulatory and policy requirements."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active procurement contracts. Measures the live vendor commitment portfolio requiring active management."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`supply_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement demand and requisition pipeline KPIs. Tracks requisition volumes, estimated spend, approval cycle performance, and requisition status distribution — enabling procurement teams to manage demand intake, prioritize approvals, and forecast purchasing workload."
  source: "`water_utilities_ecm`.`supply`.`purchase_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the purchase requisition (e.g., Pending, Approved, Rejected, Converted to PO) — tracks demand pipeline progression."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (e.g., Standard, Emergency, Blanket) — identifies urgent vs. planned procurement demand."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the requisition — enables triage of high-priority supply needs for treatment operations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition estimate — supports multi-currency demand planning."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group responsible for processing the requisition — enables workload distribution analysis across procurement teams."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization associated with the requisition — supports organizational demand accountability."
    - name: "requisition_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the requisition was created — enables trend analysis of procurement demand over time."
    - name: "account_assignment_category"
      expr: account_assignment_category
      comment: "Account assignment category (e.g., Cost Center, Project, Asset) — classifies demand by financial accounting purpose."
  measures:
    - name: "total_estimated_requisition_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of all purchase requisitions. Measures the forward procurement demand pipeline and anticipated spend commitment."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions. Benchmarks price expectations and identifies requisitions with anomalous pricing for review."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all requisitions. Measures aggregate supply demand volume entering the procurement pipeline."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN requisition_status = 'Pending' THEN 1 END)
      comment: "Number of requisitions awaiting approval. A key operational metric — high pending counts indicate approval bottlenecks that delay supply delivery."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected purchase requisitions. Tracks demand that failed approval — high rejection rates signal misaligned procurement requests or budget issues."
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions submitted. Measures procurement demand intake volume and team processing workload."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master and supplier portfolio KPIs. Tracks vendor diversity, insurance compliance, performance ratings, and active vendor counts — enabling procurement leadership to manage supplier risk, diversity spend compliance, and vendor qualification standards."
  source: "`water_utilities_ecm`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g., Active, Inactive, Blocked) — segments the qualified supplier base."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of the vendor type (e.g., Supplier, Contractor, Consultant) — enables spend analysis by vendor category."
    - name: "classification"
      expr: classification
      comment: "Vendor classification tier — supports strategic sourcing segmentation (e.g., preferred, approved, conditional)."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Vendor performance rating — enables supplier scorecard analysis and identification of underperforming vendors."
    - name: "minority_owned_flag"
      expr: minority_owned_flag
      comment: "Flags minority-owned vendors — tracks diversity supplier representation in the vendor base."
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Flags small business vendors — supports small business utilization compliance reporting."
    - name: "woman_owned_flag"
      expr: woman_owned_flag
      comment: "Flags woman-owned business vendors — tracks gender diversity in the supplier portfolio."
    - name: "country_code"
      expr: country_code
      comment: "Country of the vendor — enables geographic supply chain risk and domestic vs. international sourcing analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms for the vendor — informs cash flow planning and early payment discount opportunity analysis."
  measures:
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END)
      comment: "Number of active vendors in the qualified supplier base. Measures supply market breadth and single-source concentration risk."
    - name: "diversity_vendor_count"
      expr: COUNT(CASE WHEN minority_owned_flag = TRUE OR woman_owned_flag = TRUE OR small_business_flag = TRUE THEN 1 END)
      comment: "Number of vendors meeting diversity criteria (minority-owned, woman-owned, or small business). Tracks compliance with utility diversity procurement mandates."
    - name: "insurance_compliant_vendor_count"
      expr: COUNT(CASE WHEN insurance_certificate_on_file_flag = TRUE AND insurance_expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of vendors with valid, non-expired insurance certificates on file. Measures vendor compliance with insurance requirements — non-compliant vendors pose contractual and liability risk."
    - name: "insurance_expired_vendor_count"
      expr: COUNT(CASE WHEN insurance_certificate_on_file_flag = TRUE AND insurance_expiration_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of vendors whose insurance certificates have expired. A risk management alert metric — expired insurance creates liability exposure for the utility."
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the master data. Measures the overall size of the vendor portfolio under management."
    - name: "w9_compliant_vendor_count"
      expr: COUNT(CASE WHEN w9_on_file_flag = TRUE THEN 1 END)
      comment: "Number of vendors with a W-9 tax form on file. Tracks tax compliance documentation — missing W-9s create IRS reporting risk and can block payments."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`supply_approved_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved vendor-material sourcing KPIs. Tracks preferred vendor coverage, pricing benchmarks, minimum order quantities, and approval status distribution — enabling strategic sourcing teams to manage qualified supply sources and optimize vendor selection for critical water treatment materials."
  source: "`water_utilities_ecm`.`supply`.`approved_source`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the vendor-material source record (e.g., Approved, Pending, Rejected) — segments qualified vs. unqualified supply sources."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether this vendor is the preferred source for the material — drives vendor selection in automated procurement."
    - name: "lead_time_days"
      expr: lead_time_days
      comment: "Lead time category for the approved source — enables sourcing decisions based on delivery speed requirements."
  measures:
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across approved vendor-material source records. Benchmarks market pricing for materials and identifies price outliers in the approved source list."
    - name: "total_minimum_order_value"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Sum of minimum order quantities across approved sources. Informs procurement planning for minimum commitment levels required by vendors."
    - name: "preferred_source_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of approved sources designated as preferred vendors. Measures the concentration of preferred sourcing relationships."
    - name: "approved_source_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of fully approved vendor-material source records. Measures the breadth of qualified supply options available for procurement."
    - name: "distinct_vendors_approved"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with at least one approved source record. Measures supplier diversity in the qualified vendor base."
    - name: "distinct_materials_sourced"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with at least one approved source. Measures the coverage of the approved sourcing program across the material catalog."
$$;