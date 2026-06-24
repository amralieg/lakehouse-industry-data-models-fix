-- Metric views for domain: inventory | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking on-hand stock levels, availability, valuation, and safety stock coverage across materials, plants, and locations. Used by supply chain and finance leadership to steer replenishment, working capital, and service-level decisions."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier for grouping stock balances by manufacturing or distribution site."
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location identifier for granular location-level inventory analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material identifier enabling per-SKU inventory performance analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (unrestricted, blocked, quality inspection) for segmenting usable vs. restricted inventory."
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock record (active, obsolete, slow-moving) for inventory health segmentation."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material for prioritized inventory management analysis."
    - name: "stock_category"
      expr: stock_category
      comment: "Category of stock (raw material, finished goods, semi-finished) for portfolio-level analysis."
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency in which stock is valued, enabling multi-currency reporting."
    - name: "period_end_snapshot_date"
      expr: period_end_snapshot_date
      comment: "Period-end snapshot date for trending inventory positions over time."
    - name: "special_stock_type"
      expr: special_stock_type
      comment: "Special stock category (consignment, project stock, customer stock) for ownership-based segmentation."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock quantity on hand across all selected dimensions. Core inventory position KPI used to assess supply availability and prevent stockouts."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for use or sale (on-hand minus reservations and blocks). Directly drives order fulfillment capability assessments."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for open orders or projects. Indicates committed inventory that cannot be reallocated."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held as buffer against demand variability. Used to assess working capital tied up in safety buffers."
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total monetary value of inventory on hand. Key working capital metric reviewed by CFO and supply chain leadership."
    - name: "avg_valuation_price"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average valuation price per unit across stock records. Used to monitor price drift and cost accuracy."
    - name: "total_last_count_variance_quantity"
      expr: SUM(CAST(last_count_variance_quantity AS DOUBLE))
      comment: "Total quantity variance identified at last physical count. Signals inventory accuracy issues requiring investigation."
    - name: "stock_coverage_ratio"
      expr: ROUND(SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(safety_stock_quantity AS DOUBLE)), 0), 2)
      comment: "Ratio of available quantity to safety stock quantity. Values below 1.0 indicate safety stock breach risk, triggering urgent replenishment action."
    - name: "available_to_on_hand_ratio"
      expr: ROUND(100.0 * SUM(CAST(available_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock that is freely available (not reserved or blocked). Low values indicate high reservation or quality-hold burden."
    - name: "maximum_stock_level"
      expr: SUM(CAST(maximum_stock_level AS DOUBLE))
      comment: "Total maximum stock level across selected scope. Used to assess overstock risk and storage capacity utilization."
    - name: "reorder_point_total"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Aggregate reorder point quantity across materials and locations. Compared against available quantity to identify materials requiring replenishment."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN available_quantity < reorder_point THEN 1 END)
      comment: "Number of stock balance records where available quantity has fallen below the reorder point. Directly triggers procurement or production action."
    - name: "obsolete_stock_record_count"
      expr: COUNT(CASE WHEN obsolete_indicator = TRUE THEN 1 END)
      comment: "Count of stock records flagged as obsolete. Drives write-off decisions and working capital release initiatives."
    - name: "slow_moving_stock_record_count"
      expr: COUNT(CASE WHEN slow_moving_indicator = TRUE THEN 1 END)
      comment: "Count of stock records flagged as slow-moving. Used to identify excess inventory and drive markdown or disposal decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory flow and transaction metrics tracking goods receipts, goods issues, transfers, and reversals. Used by operations and supply chain leadership to monitor throughput, accuracy, and material flow efficiency."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_movement`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the stock movement occurred, enabling site-level throughput analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material involved in the movement for per-SKU flow analysis."
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP-style movement type code (e.g. 101=GR, 261=GI to production) for transaction-type segmentation."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type affected by the movement (unrestricted, quality inspection, blocked)."
    - name: "posting_date"
      expr: posting_date
      comment: "Accounting posting date for time-series analysis of inventory flows."
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the movement (posted, reversed, pending) for transaction quality monitoring."
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of source document driving the movement (purchase order, production order, delivery) for cross-process traceability."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions in scope. Core throughput metric for warehouse and production operations."
    - name: "goods_receipt_quantity"
      expr: SUM(CASE WHEN goods_receipt_indicator = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity received into inventory. Measures inbound supply flow and receiving throughput."
    - name: "goods_issue_quantity"
      expr: SUM(CASE WHEN goods_issue_indicator = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity issued from inventory (to production, customers, or disposal). Measures outbound consumption and fulfillment throughput."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed stock movements. High reversal rates indicate data entry errors or process failures requiring investigation."
    - name: "total_movement_transactions"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions. Baseline volume metric for warehouse activity and process load."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stock movements that were reversed. A leading indicator of inventory transaction quality and process discipline."
    - name: "distinct_materials_moved"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials with stock movements in the period. Indicates breadth of inventory activity and material portfolio velocity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle count performance metrics. Used by warehouse management and quality leadership to assess counting program effectiveness, variance rates, and accuracy trends."
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the cycle count was performed for site-level accuracy benchmarking."
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location counted, enabling location-level accuracy analysis."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (full, partial, ABC-driven) for program-type performance comparison."
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (planned, in-progress, completed, cancelled) for pipeline monitoring."
    - name: "count_method"
      expr: count_method
      comment: "Counting method used (manual, scanner, RFID) for method-effectiveness analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the count results for governance and audit trail monitoring."
    - name: "count_date"
      expr: count_date
      comment: "Date the count was performed for time-series accuracy trending."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the count for annual accuracy reporting."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "Whether the count was ABC-classified, enabling high-value item accuracy focus."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count events. Baseline metric for counting program activity and coverage."
    - name: "avg_inventory_accuracy_pct"
      expr: AVG(CAST(accuracy_percentage AS DOUBLE))
      comment: "Average inventory accuracy percentage across cycle counts. Core KPI for warehouse quality — target typically 98%+. Drives decisions on counting frequency and process improvement."
    - name: "total_variance_quantity"
      expr: SUM(CAST(total_variance_quantity AS DOUBLE))
      comment: "Total absolute quantity variance identified across all cycle counts. Measures the scale of inventory discrepancies requiring investigation and correction."
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances. Key metric for finance leadership assessing inventory write-off exposure."
    - name: "total_items_counted"
      expr: SUM(CAST(total_items_counted AS DOUBLE))
      comment: "Total number of line items counted across all cycle count events. Measures counting program throughput and coverage."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END)
      comment: "Number of cycle counts requiring a recount due to variance or discrepancy. High recount rates signal counting quality or process issues."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts requiring a recount. Measures first-time counting accuracy and process reliability."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance percentage applied across cycle counts. Used to assess whether tolerance thresholds are appropriately calibrated."
    - name: "avg_variance_value_per_count"
      expr: AVG(CAST(total_variance_value AS DOUBLE))
      comment: "Average financial variance per cycle count event. Normalizes variance exposure by counting activity for trend comparison."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_cycle_count_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level inventory accuracy metrics from cycle count results. Provides granular material-level accuracy, variance, and recount analysis used by warehouse supervisors and inventory controllers."
  source: "`vibe_manufacturing_v1`.`inventory`.`cycle_count_line`"
  dimensions:
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material counted, enabling per-SKU accuracy analysis to identify chronically inaccurate items."
    - name: "stock_location_id"
      expr: stock_location_id
      comment: "Storage location of the counted item for location-level accuracy benchmarking."
    - name: "count_status"
      expr: count_status
      comment: "Status of the count line (counted, recounted, posted) for pipeline and completion monitoring."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type of the counted item for segmenting accuracy by stock category."
    - name: "count_date"
      expr: count_date
      comment: "Date the line item was counted for time-series accuracy trending."
    - name: "recount_indicator"
      expr: recount_indicator
      comment: "Whether this line required a recount, enabling first-count vs. recount accuracy comparison."
    - name: "posting_indicator"
      expr: posting_indicator
      comment: "Whether the variance was posted to the ledger, indicating financial impact realization."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the counted material, enabling quantity normalization."
  measures:
    - name: "total_count_lines"
      expr: COUNT(1)
      comment: "Total number of cycle count lines processed. Baseline metric for counting program scope and throughput."
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total system book quantity across all counted lines. Reference baseline for accuracy measurement."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physically counted quantity. Compared against book quantity to determine overall inventory accuracy."
    - name: "total_difference_quantity"
      expr: SUM(CAST(difference_quantity AS DOUBLE))
      comment: "Total absolute quantity difference between physical count and book inventory. Core accuracy gap metric."
    - name: "line_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN difference_quantity = 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of count lines with zero variance (perfect accuracy). Industry benchmark is 98%+; drives counting frequency and process improvement decisions."
    - name: "recount_line_count"
      expr: COUNT(CASE WHEN recount_indicator = TRUE THEN 1 END)
      comment: "Number of lines requiring a recount. Identifies materials and locations with persistent counting challenges."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance percentage applied at line level. Used to assess tolerance calibration consistency."
    - name: "distinct_materials_counted"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials counted. Measures breadth of counting program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation and financial metrics tracking stock value, price variances, obsolescence provisions, and cost accuracy. Used by finance and supply chain leadership for working capital management and cost control."
  source: "`vibe_manufacturing_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material identifier for per-SKU valuation analysis."
    - name: "plant_id"
      expr: plant_id
      comment: "Plant for site-level inventory valuation reporting."
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class grouping materials by accounting treatment for financial reporting segmentation."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type (standard price, moving average) for cost method analysis."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record for data quality monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual inventory valuation trending."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly valuation reporting aligned to financial close."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of valuation for multi-currency inventory reporting."
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of valuation snapshot for point-in-time financial analysis."
    - name: "inventory_accounting_method"
      expr: inventory_accounting_method
      comment: "Accounting method (FIFO, LIFO, WAC) applied for compliance and comparability analysis."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total inventory value across all valuation records. Primary working capital metric reviewed by CFO and treasury."
    - name: "total_stock_quantity"
      expr: SUM(CAST(total_stock_quantity AS DOUBLE))
      comment: "Total stock quantity across valuation records. Used to cross-validate physical inventory against financial records."
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across materials. Tracks cost trend and identifies price drift requiring investigation."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across materials. Baseline for price variance analysis and cost accuracy assessment."
    - name: "total_price_variance_amount"
      expr: SUM(CAST(price_variance_amount AS DOUBLE))
      comment: "Total price variance between actual and standard cost. Key cost control metric — large variances trigger standard cost review."
    - name: "total_provision_for_obsolescence"
      expr: SUM(CAST(provision_for_obsolescence AS DOUBLE))
      comment: "Total provision held for obsolete inventory. Measures write-off exposure and drives disposal decisions."
    - name: "total_inventory_write_down_amount"
      expr: SUM(CAST(inventory_write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount recognized. Directly impacts P&L and is a key metric for finance leadership."
    - name: "total_net_realizable_value"
      expr: SUM(CAST(net_realizable_value AS DOUBLE))
      comment: "Total net realizable value of inventory. Used for lower-of-cost-or-NRV assessment required under IFRS/GAAP."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold amount from inventory. Core P&L input metric for gross margin analysis."
    - name: "total_material_overhead_amount"
      expr: SUM(CAST(material_overhead_amount AS DOUBLE))
      comment: "Total material overhead absorbed into inventory value. Used to assess overhead absorption accuracy."
    - name: "price_variance_to_value_pct"
      expr: ROUND(100.0 * SUM(CAST(price_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Price variance as a percentage of total stock value. Measures cost accuracy — high percentages indicate standard cost refresh is needed."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics tracking order fulfillment, lead times, costs, and on-time delivery. Used by supply chain and procurement leadership to optimize replenishment processes and supplier performance."
  source: "`vibe_manufacturing_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant receiving the replenishment for site-level supply performance analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material being replenished for per-SKU supply performance tracking."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Type of replenishment (purchase, production, transfer) for channel-level performance comparison."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (open, in-transit, received, cancelled) for pipeline monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the replenishment order for urgency-based performance analysis."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier fulfilling the replenishment for vendor performance benchmarking."
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Requested delivery date for on-time delivery analysis."
    - name: "source_type"
      expr: source_type
      comment: "Source type of the replenishment (external supplier, internal transfer, production) for supply channel analysis."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders. Baseline metric for replenishment program activity and demand on supply chain."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total quantity requested across replenishment orders. Measures aggregate demand placed on supply chain."
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity actually fulfilled. Compared against required quantity to measure supply fulfillment rate."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of replenishment orders. Key procurement spend metric for budget management."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required quantity that was fulfilled. Core supply reliability KPI — low rates indicate supply risk or supplier performance issues."
    - name: "avg_lot_size_quantity"
      expr: AVG(CAST(lot_size_quantity AS DOUBLE))
      comment: "Average lot size per replenishment order. Used to assess ordering efficiency and alignment with MOQ constraints."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE THEN 1 END)
      comment: "Number of replenishment orders requiring quality inspection. Measures quality control burden on receiving operations."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across replenishment orders. Used to validate reorder point calibration against actual ordering patterns."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity associated with replenishment orders. Measures working capital committed to safety buffers."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy effectiveness metrics tracking coverage levels, service targets, holding costs, and policy compliance. Used by supply chain planners and operations leadership to optimize inventory investment vs. service level trade-offs."
  source: "`vibe_manufacturing_v1`.`inventory`.`inventory_safety_stock_policy`"
  dimensions:
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material covered by the policy for per-SKU safety stock analysis."
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the policy applies for site-level safety stock management."
    - name: "policy_type"
      expr: policy_type
      comment: "Type of safety stock policy (fixed, dynamic, seasonal) for method-effectiveness comparison."
    - name: "policy_status"
      expr: policy_status
      comment: "Status of the policy (active, expired, under review) for governance monitoring."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the material for prioritized policy management."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (statistical, fixed, coverage-based) for methodology analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the policy for governance and compliance monitoring."
    - name: "jit_enabled_flag"
      expr: jit_enabled_flag
      comment: "Whether JIT replenishment is enabled, enabling JIT vs. traditional policy performance comparison."
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Whether seasonal adjustment is applied, for seasonal vs. non-seasonal policy analysis."
  measures:
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity mandated by active policies. Core working capital metric — directly tied to inventory investment decisions."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target across policies. Measures the ambition of the safety stock program and its customer service commitment."
    - name: "total_holding_cost_per_year"
      expr: SUM(CAST(holding_cost_per_unit_per_year AS DOUBLE))
      comment: "Total annual holding cost across all safety stock policies. Quantifies the financial cost of the safety stock program for ROI analysis."
    - name: "total_stockout_cost"
      expr: SUM(CAST(stockout_cost_per_unit AS DOUBLE))
      comment: "Total estimated stockout cost per unit across policies. Used to justify safety stock investment levels against stockout risk."
    - name: "avg_demand_variability_factor"
      expr: AVG(CAST(demand_variability_factor AS DOUBLE))
      comment: "Average demand variability factor across policies. Higher values indicate more volatile demand requiring larger safety buffers."
    - name: "avg_maximum_stock_level"
      expr: AVG(CAST(maximum_stock_level AS DOUBLE))
      comment: "Average maximum stock level across policies. Used to assess overstock risk and storage capacity requirements."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across policies. Baseline for replenishment trigger calibration analysis."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across policies. Used to assess MOQ impact on inventory investment and ordering efficiency."
    - name: "total_target_coverage_value"
      expr: SUM(CAST(target_coverage_value AS DOUBLE))
      comment: "Total target coverage value (days of supply) across policies. Measures the aggregate supply buffer the organization is targeting."
    - name: "active_policy_count"
      expr: COUNT(CASE WHEN policy_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active safety stock policies. Measures policy coverage breadth across the material portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability metrics tracking batch quality, expiry, availability, and compliance. Used by quality, supply chain, and regulatory teams to manage batch lifecycle, expiry risk, and traceability obligations."
  source: "`vibe_manufacturing_v1`.`inventory`.`lot_batch`"
  dimensions:
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material associated with the batch for per-SKU batch quality and expiry analysis."
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the batch was produced or received for site-level batch management."
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (unrestricted, blocked, restricted, expired) for availability segmentation."
    - name: "batch_classification"
      expr: batch_classification
      comment: "Classification of the batch for quality and regulatory segmentation."
    - name: "quality_decision"
      expr: quality_decision
      comment: "Quality disposition decision (accepted, rejected, rework) for quality performance analysis."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier of the batch for vendor quality performance tracking."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether the batch contains hazardous material for compliance and safety segmentation."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for trade compliance and supply chain risk analysis."
    - name: "goods_receipt_date"
      expr: goods_receipt_date
      comment: "Date the batch was received for aging and lead time analysis."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of lot/batch records. Baseline metric for batch management program scope."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available across all batches. Core supply availability metric for production planning and order fulfillment."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked across batches. Measures supply at risk due to quality holds or compliance issues."
    - name: "total_restricted_quantity"
      expr: SUM(CAST(restricted_quantity AS DOUBLE))
      comment: "Total quantity under restricted use. Indicates supply with conditional availability requiring management attention."
    - name: "total_quantity_produced"
      expr: SUM(CAST(quantity_produced AS DOUBLE))
      comment: "Total quantity produced across batches. Measures production output volume for capacity and yield analysis."
    - name: "total_batch_cost"
      expr: SUM(CAST(batch_cost_amount AS DOUBLE))
      comment: "Total cost of all batches. Used for inventory valuation and cost-of-quality analysis."
    - name: "blocked_to_available_ratio"
      expr: ROUND(100.0 * SUM(CAST(blocked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(available_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of available stock that is blocked. High ratios indicate quality or compliance issues constraining supply."
    - name: "hazardous_batch_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of batches containing hazardous materials. Drives compliance monitoring and special handling resource planning."
    - name: "distinct_suppliers_with_batches"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with active batches. Measures supply base breadth and single-source risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_quarantine_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quarantine stock management metrics tracking financial exposure, disposition rates, and resolution cycle times for non-conforming inventory. Used by quality and supply chain leadership to manage quality-hold risk and minimize financial impact."
  source: "`vibe_manufacturing_v1`.`inventory`.`quarantine_stock`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where quarantine stock is held for site-level quality risk monitoring."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material under quarantine for per-SKU quality issue tracking."
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Current status of the quarantine (open, under review, released, scrapped) for pipeline management."
    - name: "quarantine_reason_code"
      expr: quarantine_reason_code
      comment: "Reason for quarantine (incoming inspection failure, customer complaint, NCR) for root cause analysis."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision (use-as-is, rework, scrap, return to supplier) for outcome analysis."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the quarantine for vendor quality performance tracking."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Whether the quarantine is driven by a regulatory hold, for compliance risk segmentation."
    - name: "initiating_document_type"
      expr: initiating_document_type
      comment: "Type of document that triggered the quarantine (NCR, customer complaint, inspection lot) for process traceability."
    - name: "quarantine_start_date"
      expr: quarantine_start_date
      comment: "Date quarantine was initiated for aging and cycle time analysis."
  measures:
    - name: "total_quarantine_records"
      expr: COUNT(1)
      comment: "Total number of quarantine stock records. Baseline metric for quality-hold volume and quality system load."
    - name: "total_quarantine_quantity"
      expr: SUM(CAST(quarantine_quantity AS DOUBLE))
      comment: "Total quantity under quarantine. Measures the scale of supply at risk due to quality or compliance issues."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of quarantine stock. Key risk metric for finance and quality leadership — drives prioritization of disposition decisions."
    - name: "regulatory_hold_count"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of quarantine records with regulatory holds. Measures compliance risk exposure requiring immediate management attention."
    - name: "open_quarantine_count"
      expr: COUNT(CASE WHEN quarantine_status = 'OPEN' THEN 1 END)
      comment: "Number of open (unresolved) quarantine records. Measures backlog of quality decisions pending resolution."
    - name: "avg_financial_impact_per_record"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per quarantine record. Used to prioritize disposition resources on highest-value quality holds."
    - name: "distinct_suppliers_with_quarantine"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with active quarantine stock. Identifies suppliers with systemic quality issues requiring development action."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_wip_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-in-process inventory metrics tracking WIP value, yield, scrap, and production progress. Used by production and finance leadership to monitor manufacturing efficiency, cost absorption, and WIP exposure."
  source: "`vibe_manufacturing_v1`.`inventory`.`wip_stock`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where WIP is held for site-level production efficiency analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center holding the WIP for operation-level bottleneck and efficiency analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material being processed for per-SKU WIP analysis."
    - name: "wip_status"
      expr: wip_status
      comment: "Current status of the WIP (in-process, on-hold, completed, scrapped) for pipeline monitoring."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the WIP order for urgency-based production management."
    - name: "rework_required"
      expr: rework_required
      comment: "Whether rework is required, enabling rework rate and cost analysis."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether quality inspection is required before completion, for quality gate monitoring."
    - name: "production_start_date"
      expr: production_start_date
      comment: "Production start date for WIP aging and cycle time analysis."
  measures:
    - name: "total_wip_valuation_amount"
      expr: SUM(CAST(wip_valuation_amount AS DOUBLE))
      comment: "Total monetary value of work-in-process inventory. Key working capital metric — high WIP values indicate production bottlenecks or long cycle times."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost absorbed into WIP. Used for cost-of-production analysis and standard cost validation."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost absorbed into WIP. Measures labor efficiency and cost absorption accuracy."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost absorbed into WIP. Used to assess overhead absorption rates and cost accuracy."
    - name: "total_quantity_in_process"
      expr: SUM(CAST(quantity_in_process AS DOUBLE))
      comment: "Total quantity currently in production process. Measures production pipeline volume and capacity utilization."
    - name: "total_quantity_completed"
      expr: SUM(CAST(quantity_completed AS DOUBLE))
      comment: "Total quantity completed from WIP. Measures production output and throughput."
    - name: "total_quantity_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity scrapped during production. Core quality and efficiency KPI — high scrap drives cost and yield investigations."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average production yield percentage across WIP records. Key manufacturing efficiency KPI — low yields trigger process improvement initiatives."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_scrapped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_in_process AS DOUBLE)), 0), 2)
      comment: "Percentage of in-process quantity that was scrapped. Directly measures production quality and drives cost-of-poor-quality analysis."
    - name: "rework_required_count"
      expr: COUNT(CASE WHEN rework_required = TRUE THEN 1 END)
      comment: "Number of WIP records requiring rework. Measures quality failure rate in production and associated rework cost burden."
    - name: "total_wip_records"
      expr: COUNT(1)
      comment: "Total number of active WIP records. Baseline metric for production pipeline depth and manufacturing complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity and operational metrics tracking utilization, capability, and compliance status. Used by operations and real estate leadership to optimize warehouse network, capacity investments, and compliance posture."
  source: "`vibe_manufacturing_v1`.`inventory`.`warehouse`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant associated with the warehouse for network-level capacity analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (distribution center, manufacturing warehouse, cross-dock) for capability segmentation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned, leased, 3PL) for cost structure and flexibility analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the warehouse for geographic network analysis."
    - name: "climate_controlled_flag"
      expr: climate_controlled_flag
      comment: "Whether the warehouse is climate-controlled for specialized storage capability analysis."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Whether the warehouse is certified for hazardous materials storage for compliance capability mapping."
    - name: "customs_bonded_flag"
      expr: customs_bonded_flag
      comment: "Whether the warehouse is customs-bonded for trade compliance capability analysis."
    - name: "automated_storage_flag"
      expr: automated_storage_flag
      comment: "Whether the warehouse uses automated storage for technology investment and efficiency analysis."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouses in the network. Baseline metric for network footprint and capacity planning."
    - name: "total_storage_area_sqm"
      expr: SUM(CAST(storage_area_square_meters AS DOUBLE))
      comment: "Total storage area in square meters across the warehouse network. Core capacity metric for network planning and real estate decisions."
    - name: "total_capacity_cubic_meters"
      expr: SUM(CAST(total_capacity_cubic_meters AS DOUBLE))
      comment: "Total volumetric capacity across all warehouses. Used for network capacity planning and utilization benchmarking."
    - name: "total_usable_capacity_cubic_meters"
      expr: SUM(CAST(usable_capacity_cubic_meters AS DOUBLE))
      comment: "Total usable volumetric capacity. Compared against total capacity to assess space efficiency and layout optimization opportunities."
    - name: "usable_to_total_capacity_ratio"
      expr: ROUND(100.0 * SUM(CAST(usable_capacity_cubic_meters AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_cubic_meters AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity that is usable. Low ratios indicate inefficient warehouse layouts or excessive non-storage space."
    - name: "hazmat_certified_warehouse_count"
      expr: COUNT(CASE WHEN hazmat_certified_flag = TRUE THEN 1 END)
      comment: "Number of warehouses certified for hazardous materials. Measures network capability for regulated product storage."
    - name: "climate_controlled_warehouse_count"
      expr: COUNT(CASE WHEN climate_controlled_flag = TRUE THEN 1 END)
      comment: "Number of climate-controlled warehouses. Measures network capability for temperature-sensitive product storage."
    - name: "avg_temperature_range_max"
      expr: AVG(CAST(temperature_range_max_celsius AS DOUBLE))
      comment: "Average maximum temperature capability across warehouses. Used for cold chain network planning."
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_square_meters AS DOUBLE))
      comment: "Total floor area across all warehouses. Used for real estate portfolio management and cost-per-sqm analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_kanban_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kanban replenishment performance metrics tracking signal efficiency, lead times, and lot sizing. Used by lean manufacturing and supply chain teams to optimize pull-based replenishment and reduce WIP."
  source: "`vibe_manufacturing_v1`.`inventory`.`kanban_card`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the kanban system operates for site-level lean performance analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material managed by the kanban card for per-SKU pull system analysis."
    - name: "kanban_card_status"
      expr: kanban_card_status
      comment: "Current status of the kanban card (empty, full, in-transit, blocked) for signal flow monitoring."
    - name: "signal_type"
      expr: signal_type
      comment: "Type of kanban signal (card, electronic, bin) for system-type performance comparison."
    - name: "replenishment_strategy"
      expr: replenishment_strategy
      comment: "Replenishment strategy associated with the kanban for strategy effectiveness analysis."
    - name: "container_type"
      expr: container_type
      comment: "Type of container used in the kanban loop for standardization analysis."
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the kanban card is active, for active vs. inactive card portfolio analysis."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier fulfilling the kanban replenishment for vendor-level pull system performance."
  measures:
    - name: "total_kanban_cards"
      expr: COUNT(1)
      comment: "Total number of kanban cards in the system. Baseline metric for pull system scope and WIP cap management."
    - name: "active_kanban_card_count"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Number of active kanban cards. Measures the live pull system footprint and active WIP control points."
    - name: "total_container_quantity"
      expr: SUM(CAST(container_quantity AS DOUBLE))
      comment: "Total container quantity across all kanban cards. Measures total WIP authorized by the kanban system."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity held within kanban loops. Measures buffer inventory investment in the pull system."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average replenishment lead time across kanban cards. Key lean metric — shorter lead times enable smaller kanban quantities and lower WIP."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across kanban cards. Used to assess lot size optimization opportunities and MOQ constraints."
    - name: "avg_maximum_lot_size"
      expr: AVG(CAST(maximum_lot_size AS DOUBLE))
      comment: "Average maximum lot size across kanban cards. Used to assess overproduction risk and WIP cap effectiveness."
    - name: "blocked_card_count"
      expr: COUNT(CASE WHEN kanban_card_status = 'BLOCKED' THEN 1 END)
      comment: "Number of blocked kanban cards. Blocked cards indicate supply disruptions or process failures requiring immediate intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`inventory_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material master data quality and portfolio metrics tracking material classification, valuation, and physical characteristics. Used by supply chain and data governance teams to ensure master data completeness and support portfolio decisions."
  source: "`vibe_manufacturing_v1`.`inventory`.`material_master`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material (raw material, finished good, semi-finished, trading good) for portfolio segmentation."
    - name: "material_group"
      expr: material_group
      comment: "Material group for category-level analysis and procurement commodity management."
    - name: "material_status"
      expr: material_status
      comment: "Current status of the material (active, blocked, discontinued) for lifecycle management."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (external, in-house, both) for make-vs-buy portfolio analysis."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type for planning strategy analysis and optimization."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification indicator for prioritized inventory management."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Whether the material is hazardous for compliance and safety portfolio analysis."
    - name: "batch_management_indicator"
      expr: batch_management_indicator
      comment: "Whether batch management is active for traceability capability analysis."
  measures:
    - name: "total_materials"
      expr: COUNT(1)
      comment: "Total number of material master records. Baseline metric for portfolio size and master data management scope."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price across materials. Used for cost benchmarking and standard cost review prioritization."
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across materials. Compared against standard price to identify cost drift."
    - name: "avg_safety_stock"
      expr: AVG(CAST(safety_stock AS DOUBLE))
      comment: "Average safety stock quantity across materials. Used to assess aggregate safety stock investment and policy calibration."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across materials. Baseline for replenishment trigger analysis."
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN 1 END)
      comment: "Number of hazardous materials in the portfolio. Drives compliance resource planning and regulatory reporting."
    - name: "batch_managed_material_count"
      expr: COUNT(CASE WHEN batch_management_indicator = TRUE THEN 1 END)
      comment: "Number of materials with batch management active. Measures traceability program scope and associated system overhead."
    - name: "avg_gross_weight"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight across materials. Used for logistics planning, freight cost estimation, and packaging design."
    - name: "avg_shelf_life_expiration_days"
      expr: AVG(CAST(shelf_life_expiration_days AS DOUBLE))
      comment: "Average shelf life in days across materials. Used to assess expiry risk exposure and FEFO inventory management requirements."
$$;