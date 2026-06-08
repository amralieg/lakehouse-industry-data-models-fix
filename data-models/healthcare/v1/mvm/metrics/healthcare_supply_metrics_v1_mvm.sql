-- Metric views for domain: supply | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 18:58:55

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management covering spend, cycle times, compliance, and fulfillment performance. Used by Supply Chain VPs and CFOs to govern procurement spend and vendor performance."
  source: "`healthcare_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., Open, Closed, Cancelled) for pipeline and backlog analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Emergency) to segment procurement patterns."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO, used to identify bottlenecks in the procurement approval process."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Delivery fulfillment status of the PO to track open vs. fulfilled orders."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice processing status to monitor accounts payable exposure and three-way match readiness."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO / receipt / invoice three-way match, critical for payment release and audit compliance."
    - name: "is_emergency_order"
      expr: is_emergency_order
      comment: "Flag indicating emergency purchase orders, which typically carry premium costs and supply risk."
    - name: "is_contract_compliant"
      expr: is_contract_compliant
      comment: "Whether the PO was placed against an approved contract, used to measure contract compliance rate."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order for multi-currency spend analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center responsible for the purchase order, enabling departmental spend attribution."
    - name: "purchasing_org_code"
      expr: purchasing_org_code
      comment: "Purchasing organization code for enterprise-level procurement governance and spend consolidation."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the purchase order was placed, used for trend analysis and budget period comparisons."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month the order was actually delivered, used to analyze delivery timing vs. requested dates."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement throughput analysis."
    - name: "total_gross_spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross procurement spend across all purchase orders. Primary spend KPI for budget governance and vendor spend analysis."
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net procurement spend after discounts. Used to measure realized savings vs. gross spend."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured across purchase orders. Measures negotiated savings and contract leverage effectiveness."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs incurred. Used to identify logistics cost reduction opportunities and freight term optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders for financial reporting and tax compliance."
    - name: "avg_po_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per purchase order. Indicates procurement transaction size and helps identify consolidation opportunities."
    - name: "emergency_order_count"
      expr: COUNT(CASE WHEN is_emergency_order = TRUE THEN 1 END)
      comment: "Number of emergency purchase orders. High emergency order rates signal supply chain fragility and drive premium cost exposure."
    - name: "contract_compliant_po_count"
      expr: COUNT(CASE WHEN is_contract_compliant = TRUE THEN 1 END)
      comment: "Number of POs placed against approved contracts. Used to compute contract compliance rate and GPO utilization."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, order_date) AS DOUBLE))
      comment: "Average number of days from PO creation to actual delivery. Key vendor performance and supply chain responsiveness metric."
    - name: "avg_delivery_delay_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, requested_delivery_date) AS DOUBLE))
      comment: "Average days late vs. requested delivery date. Positive values indicate late deliveries; used to hold vendors accountable to SLAs."
    - name: "on_time_delivery_po_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= requested_delivery_date THEN 1 END)
      comment: "Number of POs delivered on or before the requested delivery date. Numerator for on-time delivery rate calculation."
    - name: "three_way_match_passed_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'PASSED' THEN 1 END)
      comment: "Number of POs that passed three-way match (PO / receipt / invoice). Numerator for match compliance rate; drives payment release efficiency."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs covering ordered vs. received quantities, pricing, backorders, and contract compliance. Used by procurement analysts and supply chain managers to manage item-level fulfillment and cost control."
  source: "`healthcare_ecm`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (e.g., Open, Received, Cancelled) for line-level fulfillment tracking."
    - name: "line_type"
      expr: line_type
      comment: "Type of PO line (e.g., Material, Service) to segment spend by procurement category."
    - name: "item_category"
      expr: item_category
      comment: "Category of the item ordered, enabling spend analysis by supply category (e.g., Pharmaceuticals, Surgical Supplies, Capital Equipment)."
    - name: "expense_type"
      expr: expense_type
      comment: "Expense classification of the line item for GL coding and budget allocation."
    - name: "is_contract_item"
      expr: is_contract_item
      comment: "Whether the line item is sourced from an approved contract, used to measure contract utilization at the item level."
    - name: "is_formulary_item"
      expr: is_formulary_item
      comment: "Whether the item is on the formulary, critical for pharmacy and clinical supply compliance."
    - name: "is_recall_active"
      expr: is_recall_active
      comment: "Flag indicating an active recall on the ordered item. Used for patient safety monitoring and recall response tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the PO line to identify unapproved spend and approval workflow bottlenecks."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item for multi-currency spend normalization."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for the line item, enabling departmental supply cost attribution."
    - name: "promised_delivery_month"
      expr: DATE_TRUNC('MONTH', promised_delivery_date)
      comment: "Month the vendor promised delivery, used to track vendor commitment reliability over time."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines. Baseline volume metric for procurement activity."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line amount (unit price × quantity). Primary line-level spend KPI for category and item cost management."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines. Used to measure procurement volume and demand fulfillment."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received. Compared against ordered quantity to compute receipt fill rate."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total quantity on backorder. High backorder volumes signal supply disruption risk and potential care delivery impact."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total quantity cancelled. Used to measure demand volatility and procurement planning accuracy."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced by the vendor. Compared against received quantity to identify invoice discrepancies."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid per line item. Used to benchmark pricing against contract rates and market benchmarks."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges at the line level. Used to identify high-freight items and optimize shipping terms."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges at the line level for financial reporting and tax compliance."
    - name: "recall_active_line_count"
      expr: COUNT(CASE WHEN is_recall_active = TRUE THEN 1 END)
      comment: "Number of PO lines with an active recall. Critical patient safety KPI requiring immediate procurement and clinical response."
    - name: "contract_item_line_count"
      expr: COUNT(CASE WHEN is_contract_item = TRUE THEN 1 END)
      comment: "Number of PO lines sourced from approved contracts. Numerator for contract compliance rate at the line level."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage achieved on PO lines. Measures negotiation effectiveness and contract leverage."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving dock KPIs covering receipt accuracy, discrepancy rates, temperature excursions, and recall exposure. Used by supply chain managers and quality teams to govern inbound supply quality and compliance."
  source: "`healthcare_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g., Posted, Pending, Rejected) for inbound supply pipeline management."
    - name: "movement_type"
      expr: movement_type
      comment: "Type of inventory movement associated with the receipt (e.g., Standard Receipt, Return) for transaction classification."
    - name: "condition_on_receipt"
      expr: condition_on_receipt
      comment: "Physical condition of goods upon receipt (e.g., Good, Damaged) to track inbound quality issues."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of discrepancy identified at receipt (e.g., Quantity, Quality, Damage) for root cause analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status at the receipt level to support payment release and audit compliance."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for received goods (e.g., Refrigerated, Ambient) for compliance and handling routing."
    - name: "implantable_device_flag"
      expr: implantable_device_flag
      comment: "Whether the received item is an implantable device, requiring UDI tracking and heightened quality controls."
    - name: "sterile_processing_required"
      expr: sterile_processing_required
      comment: "Whether the item requires sterile processing before use, impacting clinical readiness timelines."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of receipt for trend analysis of inbound supply volume and quality over time."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or facility code where goods were received, enabling site-level receiving performance comparison."
  measures:
    - name: "total_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts. Baseline inbound supply volume metric."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of goods received. Used to measure inbound supply throughput and compare against ordered quantities."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered per receipt. Denominator for receipt fill rate calculation."
    - name: "total_receipt_value"
      expr: SUM(CAST(total_receipt_value AS DOUBLE))
      comment: "Total value of goods received. Primary financial KPI for inbound supply spend and inventory capitalization."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods. Used to benchmark against PO unit prices and detect cost variances."
    - name: "discrepancy_receipt_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with a discrepancy. High discrepancy rates indicate vendor quality issues or receiving process failures."
    - name: "temperature_excursion_receipt_count"
      expr: COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END)
      comment: "Number of receipts with a temperature excursion. Critical for cold-chain pharmaceuticals and biologics; excursions may render product unusable."
    - name: "recall_flagged_receipt_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of receipts flagged for an active recall. Patient safety KPI requiring immediate quarantine and vendor notification."
    - name: "implantable_device_receipt_count"
      expr: COUNT(CASE WHEN implantable_device_flag = TRUE THEN 1 END)
      comment: "Number of receipts for implantable devices. Used to ensure UDI compliance and traceability for regulatory reporting."
    - name: "inventory_updated_receipt_count"
      expr: COUNT(CASE WHEN inventory_update_flag = TRUE THEN 1 END)
      comment: "Number of receipts that triggered an inventory update. Measures receiving-to-inventory posting efficiency."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory position KPIs covering stock levels, stockout risk, expiration exposure, and carrying value. Used by supply chain directors and clinical operations to ensure supply availability and minimize waste."
  source: "`healthcare_ecm`.`supply`.`inventory_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory record (e.g., Available, Quarantine, Expired) for stock availability analysis."
    - name: "item_category"
      expr: item_category
      comment: "Category of the inventory item (e.g., Pharmaceutical, Surgical, Capital) for category-level stock management."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the item (A=high value/velocity, B=medium, C=low) for inventory prioritization and cycle count planning."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Method used to replenish the item (e.g., PAR, Min/Max, Kanban) for supply chain process analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of inventory (e.g., Owned, Consignment) to distinguish capital exposure from vendor-managed stock."
    - name: "formulary_flag"
      expr: formulary_flag
      comment: "Whether the item is on the formulary, critical for pharmacy compliance and substitution management."
    - name: "below_reorder_flag"
      expr: below_reorder_flag
      comment: "Whether current stock is below the reorder point. Used to trigger replenishment and prevent stockouts."
    - name: "stockout_flag"
      expr: stockout_flag
      comment: "Whether the item is currently stocked out. Direct patient care risk indicator requiring immediate action."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether the inventory item is subject to an active recall. Patient safety KPI requiring quarantine and disposition."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the inventory valuation for multi-currency financial reporting."
    - name: "balance_snapshot_month"
      expr: DATE_TRUNC('MONTH', balance_snapshot_timestamp)
      comment: "Month of the inventory balance snapshot for trend analysis of stock levels over time."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month items are set to expire, used to identify near-term expiration risk and prioritize consumption or return."
  measures:
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all inventory locations. Primary stock availability KPI for supply continuity."
    - name: "total_qty_on_order"
      expr: SUM(CAST(qty_on_order AS DOUBLE))
      comment: "Total quantity on open purchase orders. Used to project future inventory availability and avoid over-ordering."
    - name: "total_qty_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity currently in transit. Included in available-to-promise calculations for clinical supply planning."
    - name: "total_qty_quarantine"
      expr: SUM(CAST(qty_quarantine AS DOUBLE))
      comment: "Total quantity in quarantine (e.g., recall hold, quality hold). High quarantine volumes signal supply risk and potential care disruption."
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved for pending orders or procedures. Used to compute true available-to-use inventory."
    - name: "total_inventory_value"
      expr: SUM(CAST(qty_on_hand AS DOUBLE) * CAST(unit_cost AS DOUBLE))
      comment: "Total carrying value of on-hand inventory (qty × unit cost). Primary financial KPI for working capital management and balance sheet reporting."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across inventory items. Used to benchmark pricing and identify cost outliers."
    - name: "stockout_item_count"
      expr: COUNT(CASE WHEN stockout_flag = TRUE THEN 1 END)
      comment: "Number of inventory items currently stocked out. Direct patient care risk metric; high counts require immediate supply chain intervention."
    - name: "below_reorder_item_count"
      expr: COUNT(CASE WHEN below_reorder_flag = TRUE THEN 1 END)
      comment: "Number of items below their reorder point. Leading indicator of impending stockouts; drives replenishment prioritization."
    - name: "recall_flagged_item_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of inventory items under an active recall. Patient safety KPI requiring quarantine, disposition, and regulatory reporting."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity maintained. Used to assess buffer adequacy against demand variability and supply disruption risk."
    - name: "avg_par_level"
      expr: AVG(CAST(par_level AS DOUBLE))
      comment: "Average PAR level across inventory items. Benchmarked against on-hand quantities to assess PAR compliance and replenishment trigger accuracy."
    - name: "total_last_physical_count_qty"
      expr: SUM(CAST(last_physical_count_qty AS DOUBLE))
      comment: "Total quantity from the last physical inventory count. Compared against system on-hand to compute inventory accuracy and shrinkage."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_inventory_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement KPIs covering consumption, cost, variance, and recall activity. Used by supply chain and finance teams to govern inventory accuracy, cost of goods used, and clinical supply utilization."
  source: "`healthcare_ecm`.`supply`.`inventory_transaction`"
  dimensions:
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP/ERP movement type code (e.g., 101=GR, 261=Goods Issue to Order) for transaction classification and audit."
    - name: "movement_category"
      expr: movement_category
      comment: "Business category of the inventory movement (e.g., Receipt, Issue, Transfer, Return) for supply flow analysis."
    - name: "movement_type_description"
      expr: movement_type_description
      comment: "Human-readable description of the movement type for business reporting and operational dashboards."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the inventory transaction (e.g., Posted, Reversed, Pending) for ledger accuracy monitoring."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the transaction (e.g., Waste, Expired, Damaged) to identify loss drivers and cost reduction opportunities."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the transaction is a reversal of a prior posting. High reversal rates indicate data quality or process issues."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether the transaction is associated with a recalled item. Patient safety and regulatory compliance dimension."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center charged for the inventory movement, enabling departmental cost of goods used reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction for multi-currency cost reporting."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the transaction was posted to the ledger for period-over-period cost and volume trend analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or facility where the inventory movement occurred for site-level supply utilization analysis."
  measures:
    - name: "total_transaction_count"
      expr: COUNT(1)
      comment: "Total number of inventory transactions. Baseline volume metric for supply chain activity and system load."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all inventory transactions. Measures supply throughput and clinical consumption volume."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of inventory movements (quantity × unit cost). Primary cost of goods used KPI for financial reporting and departmental charge-back."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per transaction. Used to detect cost drift and benchmark against contract prices."
    - name: "total_count_variance_quantity"
      expr: SUM(CAST(count_variance_quantity AS DOUBLE))
      comment: "Total quantity variance identified during cycle counts. High variance indicates inventory shrinkage, theft, or process failures."
    - name: "total_count_variance_value"
      expr: SUM(CAST(count_variance_value AS DOUBLE))
      comment: "Total financial value of inventory count variances. Used to quantify shrinkage exposure and prioritize cycle count frequency."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of reversal transactions. Elevated reversal rates signal data entry errors, process breakdowns, or fraud risk."
    - name: "recall_transaction_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of transactions involving recalled items. Used to track recall remediation progress and regulatory compliance."
    - name: "distinct_items_transacted"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct items with inventory movement. Measures supply breadth and identifies slow-moving or dormant items."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Requisition lifecycle KPIs covering demand volume, cost accuracy, approval cycle times, and urgency patterns. Used by supply chain managers and clinical operations to optimize procurement demand management."
  source: "`healthcare_ecm`.`supply`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (e.g., Submitted, Approved, Fulfilled, Rejected) for pipeline and backlog management."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (e.g., Stock, Non-Stock, Capital, Pharmacy) for demand segmentation and process routing."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status to identify bottlenecks and unapproved spend exposure."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the requisition (e.g., Routine, Urgent, STAT) to prioritize fulfillment and assess emergency demand patterns."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfill the requisition (e.g., Stock Pull, Purchase Order, Consignment) for supply chain process analysis."
    - name: "is_par_triggered"
      expr: is_par_triggered
      comment: "Whether the requisition was automatically triggered by a PAR level breach, indicating automated vs. manual demand generation."
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Whether the requisition was created in response to a product recall, used to track recall-driven demand and cost impact."
    - name: "is_capital_expense"
      expr: is_capital_expense
      comment: "Whether the requisition is for a capital expenditure, requiring separate budget approval and asset tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition for multi-currency spend analysis."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the requisition was submitted for trend analysis of demand volume and cost over time."
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period associated with the requisition for budget vs. actual spend analysis."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of requisitions submitted. Baseline demand volume metric for procurement workload and capacity planning."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of requisitions. Used for budget forecasting and pre-approval spend visibility."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual cost of fulfilled requisitions. Primary realized spend KPI for budget vs. actual analysis."
    - name: "avg_actual_cost_per_requisition"
      expr: AVG(CAST(actual_total_cost AS DOUBLE))
      comment: "Average actual cost per requisition. Used to benchmark transaction size and identify high-cost demand patterns."
    - name: "urgent_requisition_count"
      expr: COUNT(CASE WHEN urgency_level IN ('Urgent', 'STAT') THEN 1 END)
      comment: "Number of urgent or STAT requisitions. High urgent demand rates signal supply planning failures and drive premium procurement costs."
    - name: "par_triggered_requisition_count"
      expr: COUNT(CASE WHEN is_par_triggered = TRUE THEN 1 END)
      comment: "Number of requisitions automatically triggered by PAR level breaches. Measures PAR system effectiveness and automation coverage."
    - name: "recall_related_requisition_count"
      expr: COUNT(CASE WHEN is_recall_related = TRUE THEN 1 END)
      comment: "Number of requisitions driven by product recalls. Used to quantify recall-driven supply disruption and incremental cost."
    - name: "avg_approval_cycle_time_hours"
      expr: AVG(CAST(DATEDIFF(HOUR, submitted_timestamp, approved_timestamp) AS DOUBLE))
      comment: "Average hours from requisition submission to approval. Measures procurement approval efficiency; long cycle times delay care delivery."
    - name: "avg_fulfillment_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(fulfilled_date, needed_by_date) AS DOUBLE))
      comment: "Average days between needed-by date and actual fulfillment date. Negative values indicate early fulfillment; positive values indicate late delivery impacting care."
    - name: "cost_estimation_variance"
      expr: SUM(CAST(actual_total_cost AS DOUBLE) - CAST(estimated_total_cost AS DOUBLE))
      comment: "Total variance between actual and estimated requisition cost. Measures procurement cost estimation accuracy and budget risk."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs covering performance ratings, compliance status, contract coverage, and diversity spend. Used by supply chain leadership and compliance teams to govern vendor relationships and regulatory obligations."
  source: "`healthcare_ecm`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g., Active, Inactive, Suspended) for vendor base management."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g., Distributor, Manufacturer, GPO) for supply chain segmentation and sourcing strategy."
    - name: "contract_tier"
      expr: contract_tier
      comment: "Contract tier of the vendor (e.g., Preferred, Approved, Spot) for spend governance and tier compliance analysis."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Diversity classification of the vendor (e.g., MBE, WBE, SDVOB) for diversity spend reporting and compliance."
    - name: "gpo_affiliation"
      expr: gpo_affiliation
      comment: "Group Purchasing Organization affiliation for GPO contract utilization and compliance analysis."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether the vendor is designated as preferred, used to measure preferred vendor utilization rate."
    - name: "oig_excluded_flag"
      expr: oig_excluded_flag
      comment: "Whether the vendor is excluded by the OIG. Active OIG-excluded vendors represent a critical compliance and reimbursement risk."
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Whether the vendor supports EDI transactions, used to measure supply chain automation coverage."
    - name: "country_code"
      expr: country_code
      comment: "Country of the vendor for geographic supply chain risk analysis and domestic vs. international sourcing."
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month the vendor contract became effective for contract lifecycle and renewal pipeline management."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the master file. Baseline metric for vendor base size and rationalization opportunities."
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END)
      comment: "Number of active vendors. Used to track vendor base size and identify rationalization opportunities to consolidate spend."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of preferred vendors. Used to measure preferred vendor program coverage and compliance."
    - name: "oig_excluded_vendor_count"
      expr: COUNT(CASE WHEN oig_excluded_flag = TRUE THEN 1 END)
      comment: "Number of vendors flagged as OIG-excluded. Any active OIG-excluded vendor represents a critical compliance violation requiring immediate action."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average vendor performance rating. Used to identify underperforming vendors and drive contract renewal or termination decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across vendors. Key supply chain reliability KPI; low rates signal supply continuity risk."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average order fill rate across vendors. Measures vendor ability to fulfill orders completely; low fill rates drive stockouts and care disruption."
    - name: "diversity_vendor_count"
      expr: COUNT(CASE WHEN diversity_classification IS NOT NULL AND diversity_classification <> '' THEN 1 END)
      comment: "Number of diversity-classified vendors. Used to measure diversity spend program coverage and meet regulatory diversity reporting requirements."
    - name: "edi_capable_vendor_count"
      expr: COUNT(CASE WHEN edi_capable_flag = TRUE THEN 1 END)
      comment: "Number of EDI-capable vendors. Measures supply chain automation coverage; higher EDI adoption reduces manual processing costs."
    - name: "recall_notification_enabled_count"
      expr: COUNT(CASE WHEN recall_notification_flag = TRUE THEN 1 END)
      comment: "Number of vendors enrolled in recall notification programs. Measures recall response readiness across the vendor base."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract KPIs covering contract value, compliance thresholds, rebate exposure, and diversity spend. Used by supply chain leadership and legal/compliance teams to govern contract portfolio performance and obligations."
  source: "`healthcare_ecm`.`supply`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the vendor contract (e.g., Active, Expired, Terminated) for contract lifecycle management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., GPO, Direct, Sole Source) for sourcing strategy and compliance analysis."
    - name: "product_category"
      expr: product_category
      comment: "Product category covered by the contract for category management and spend consolidation analysis."
    - name: "gpo_affiliation"
      expr: gpo_affiliation
      comment: "GPO affiliation of the contract for GPO utilization and compliance reporting."
    - name: "is_diversity_spend"
      expr: is_diversity_spend
      comment: "Whether the contract is classified as diversity spend for regulatory diversity reporting."
    - name: "is_sole_source_justified"
      expr: is_sole_source_justified
      comment: "Whether the contract has a documented sole-source justification, required for compliance and audit."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract for multi-currency financial reporting."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective for contract portfolio timeline analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the contract expires for renewal pipeline management and supply continuity risk assessment."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of vendor contracts. Baseline metric for contract portfolio size and management workload."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active vendor contracts. Used to measure active contract coverage and identify sourcing gaps."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total committed contract value across the portfolio. Primary financial KPI for contract spend governance and budget planning."
    - name: "total_annual_commitment"
      expr: SUM(CAST(annual_commitment_amount AS DOUBLE))
      comment: "Total annual commitment amount across contracts. Used to assess annual spend obligations and budget exposure."
    - name: "avg_rebate_pct"
      expr: AVG(CAST(rebate_pct AS DOUBLE))
      comment: "Average rebate percentage across contracts. Measures rebate program effectiveness and potential savings recovery."
    - name: "avg_compliance_threshold_pct"
      expr: AVG(CAST(compliance_threshold_pct AS DOUBLE))
      comment: "Average compliance threshold percentage required by contracts. Used to set organizational compliance targets and monitor adherence."
    - name: "avg_admin_fee_pct"
      expr: AVG(CAST(administrative_fee_pct AS DOUBLE))
      comment: "Average administrative fee percentage charged on contracts. Used to assess GPO and contract administration cost burden."
    - name: "diversity_contract_count"
      expr: COUNT(CASE WHEN is_diversity_spend = TRUE THEN 1 END)
      comment: "Number of contracts classified as diversity spend. Used to measure diversity procurement program coverage and meet regulatory reporting requirements."
    - name: "sole_source_contract_count"
      expr: COUNT(CASE WHEN is_sole_source_justified = TRUE THEN 1 END)
      comment: "Number of sole-source justified contracts. High sole-source counts indicate limited competition and potential cost risk; requires compliance documentation."
    - name: "avg_price_escalation_cap_pct"
      expr: AVG(CAST(price_escalation_cap_pct AS DOUBLE))
      comment: "Average price escalation cap percentage across contracts. Measures inflation protection built into the contract portfolio."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`supply_udi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "UDI (Unique Device Identifier) tracking KPIs covering implantable device utilization, recall exposure, MDR reportability, and explant activity. Used by clinical supply, quality, and regulatory teams to meet FDA UDI compliance and patient safety obligations."
  source: "`healthcare_ecm`.`supply`.`udi_record`"
  dimensions:
    - name: "implant_status"
      expr: implant_status
      comment: "Current status of the implanted device (e.g., Implanted, Explanted, Removed) for device lifecycle tracking."
    - name: "implantable_flag"
      expr: implantable_flag
      comment: "Whether the device is classified as implantable, used to filter and segment UDI records requiring heightened tracking."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether the device is subject to an active recall. Critical patient safety dimension requiring immediate clinical and regulatory response."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall class (I, II, III) indicating severity of the recall. Class I recalls represent the highest patient risk."
    - name: "recall_remediation_status"
      expr: recall_remediation_status
      comment: "Status of recall remediation actions (e.g., Notified, Removed, Replaced) for recall response tracking."
    - name: "mdr_reportable_flag"
      expr: mdr_reportable_flag
      comment: "Whether the device event is reportable under FDA Medical Device Reporting (MDR) regulations. Drives regulatory submission obligations."
    - name: "single_use_flag"
      expr: single_use_flag
      comment: "Whether the device is designated for single use only. Reuse of single-use devices is a patient safety and regulatory violation."
    - name: "sterile_flag"
      expr: sterile_flag
      comment: "Whether the device is sterile, used to ensure proper handling and storage compliance."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "Agency that issued the UDI (e.g., GS1, HIBCC, ICCBBA) for UDI system compliance analysis."
    - name: "implant_month"
      expr: DATE_TRUNC('MONTH', implant_date)
      comment: "Month of device implantation for trend analysis of implantable device utilization over time."
    - name: "implant_site"
      expr: implant_site
      comment: "Anatomical site of implantation for clinical analysis of device utilization by procedure type."
  measures:
    - name: "total_udi_record_count"
      expr: COUNT(1)
      comment: "Total number of UDI records. Baseline metric for device tracking volume and FDA UDI compliance coverage."
    - name: "implanted_device_count"
      expr: COUNT(CASE WHEN implantable_flag = TRUE AND implant_status = 'Implanted' THEN 1 END)
      comment: "Number of currently implanted devices. Used to maintain the active implant registry for patient safety and recall response."
    - name: "recall_flagged_device_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of UDI records with an active recall. Critical patient safety KPI; each recalled implanted device requires patient notification and clinical follow-up."
    - name: "class_one_recall_device_count"
      expr: COUNT(CASE WHEN recall_class = 'I' THEN 1 END)
      comment: "Number of devices under a Class I (highest severity) FDA recall. Requires immediate clinical response and regulatory reporting."
    - name: "mdr_reportable_event_count"
      expr: COUNT(CASE WHEN mdr_reportable_flag = TRUE THEN 1 END)
      comment: "Number of MDR-reportable device events. Drives FDA submission obligations; under-reporting is a regulatory violation."
    - name: "explanted_device_count"
      expr: COUNT(CASE WHEN explant_date IS NOT NULL THEN 1 END)
      comment: "Number of devices that have been explanted. Used to track device failure rates and inform procurement and clinical decisions."
    - name: "avg_implant_duration_days"
      expr: AVG(CAST(DATEDIFF(explant_date, implant_date) AS DOUBLE))
      comment: "Average number of days a device remained implanted before explantation. Used to assess device longevity and compare against manufacturer specifications."
    - name: "distinct_device_identifiers"
      expr: COUNT(DISTINCT device_identifier)
      comment: "Number of distinct device identifiers tracked. Measures UDI catalog breadth and ensures comprehensive device traceability."
    - name: "recall_remediation_pending_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE AND recall_remediation_status NOT IN ('Completed', 'Resolved') THEN 1 END)
      comment: "Number of recalled devices with pending remediation. Measures open recall response backlog; high counts indicate patient safety risk and regulatory exposure."
$$;