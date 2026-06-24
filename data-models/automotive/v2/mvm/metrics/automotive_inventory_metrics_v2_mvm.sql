-- Metric views for domain: inventory | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory stock position metrics tracking on-hand, unrestricted, blocked, in-transit, and quality-hold quantities alongside valuation. Enables inventory health monitoring, working capital analysis, and stock availability decisions across plants, locations, and SKUs."
  source: "`vibe_automotive_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code for plant-level inventory segmentation and cross-plant comparison."
    - name: "stock_category"
      expr: stock_category
      comment: "Category of stock (e.g., raw material, WIP, finished goods) for inventory classification analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity normalization and cross-SKU comparability."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status of stock, used to segment usable vs. held inventory."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle stage of the stock record (active, obsolete, etc.) for aging and obsolescence analysis."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation method applied to the stock (e.g., standard cost, moving average) for financial reporting segmentation."
    - name: "is_serialized"
      expr: is_serialized
      comment: "Indicates whether the stock is serialized, relevant for traceability and recall readiness."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the stock batch, used for shelf-life and perishability analysis."
    - name: "manufacturing_date"
      expr: manufacturing_date
      comment: "Date the stock was manufactured, used for aging and FIFO compliance analysis."
    - name: "record_audit_created"
      expr: DATE_TRUNC('month', record_audit_created)
      comment: "Month the stock balance record was created, used for trend analysis over time."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical quantity on hand across all stock records. Core inventory availability KPI used in supply planning and order fulfillment decisions."
    - name: "total_unrestricted_stock_qty"
      expr: SUM(CAST(unrestricted_stock_qty AS DOUBLE))
      comment: "Total unrestricted (freely available) stock quantity. Directly drives available-to-promise calculations and production scheduling."
    - name: "total_blocked_stock_qty"
      expr: SUM(CAST(blocked_stock_qty AS DOUBLE))
      comment: "Total blocked stock quantity held for quality, compliance, or administrative reasons. High values signal supply risk and quality issues."
    - name: "total_in_transit_stock_qty"
      expr: SUM(CAST(in_transit_stock_qty AS DOUBLE))
      comment: "Total quantity currently in transit between locations. Key for supply chain visibility and inbound planning."
    - name: "total_quality_inspection_stock_qty"
      expr: SUM(CAST(quality_inspection_stock_qty AS DOUBLE))
      comment: "Total quantity under quality inspection. Elevated levels indicate quality bottlenecks impacting production availability."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity maintained as buffer. Used to assess buffer adequacy against demand volatility."
    - name: "total_inventory_valuation"
      expr: SUM(CAST(valuation_price AS DOUBLE))
      comment: "Total inventory valuation across all stock records. Core working capital and balance sheet metric for finance and supply chain leadership."
    - name: "avg_valuation_price_per_record"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average valuation price per stock balance record. Used to benchmark unit cost trends and detect valuation anomalies."
    - name: "blocked_stock_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(blocked_stock_qty AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is blocked. A rising ratio signals quality or compliance issues requiring executive intervention."
    - name: "in_transit_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(in_transit_stock_qty AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of total inventory currently in transit. High ratios indicate supply chain pipeline dependency and exposure to transit disruptions."
    - name: "quality_hold_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(quality_inspection_stock_qty AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory under quality inspection. Directly tied to production line risk and quality management effectiveness."
    - name: "consignment_stock_qty_total"
      expr: SUM(CAST(consignment_stock_qty AS DOUBLE))
      comment: "Total consignment stock quantity held on behalf of third parties. Important for liability, ownership, and cash flow management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods movement transaction metrics capturing inventory flow volumes, values, reversal rates, and automation levels. Enables throughput analysis, cost tracking, and operational efficiency measurement across warehouses and plants."
  source: "`vibe_automotive_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Status of the goods movement transaction (posted, reversed, pending) for pipeline and completion analysis."
    - name: "source_plant"
      expr: source_plant
      comment: "Source plant of the goods movement for origin-based flow analysis."
    - name: "destination_plant"
      expr: destination_plant
      comment: "Destination plant of the goods movement for inter-plant transfer analysis."
    - name: "movement_reason"
      expr: movement_reason
      comment: "Business reason for the goods movement (production issue, transfer, return) for root cause and demand pattern analysis."
    - name: "base_uom"
      expr: base_uom
      comment: "Base unit of measure for quantity normalization across movement records."
    - name: "currency"
      expr: currency
      comment: "Transaction currency for multi-currency financial analysis."
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates whether the movement was system-automated vs. manually triggered. Used to track automation adoption and error risk."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags movements that are reversals of prior transactions. High reversal rates signal process errors or quality issues."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome associated with the movement, used for quality-linked flow analysis."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation method applied to the movement for cost accounting segmentation."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for trend analysis of goods movement volumes and values over time."
    - name: "location_zone"
      expr: location_zone
      comment: "Warehouse zone where the movement originated, used for zone-level throughput and utilization analysis."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all goods movement transactions. Primary throughput KPI for warehouse and logistics operations."
    - name: "total_movement_value_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total USD value of all goods movements. Core financial flow metric for inventory cost management and P&L impact assessment."
    - name: "total_movement_value_local"
      expr: SUM(CAST(amount_local AS DOUBLE))
      comment: "Total local currency value of goods movements. Used for regional cost analysis and currency exposure reporting."
    - name: "avg_movement_value_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average USD value per goods movement transaction. Benchmarks transaction size and detects anomalous high-value movements."
    - name: "total_movement_transactions"
      expr: COUNT(1)
      comment: "Total number of goods movement transactions. Measures operational throughput volume and warehouse activity level."
    - name: "reversal_transaction_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of goods movement reversals. High counts indicate process errors, quality failures, or system issues requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods movements that are reversals. A key process quality KPI — elevated rates signal systemic operational problems."
    - name: "automated_movement_count"
      expr: COUNT(CASE WHEN is_automated = TRUE THEN 1 END)
      comment: "Number of goods movements processed automatically. Tracks automation adoption and its impact on throughput efficiency."
    - name: "automation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods movements that are automated. Higher automation rates correlate with lower error rates and processing costs."
    - name: "lot_tracked_movement_count"
      expr: COUNT(CASE WHEN is_lot_tracked = TRUE THEN 1 END)
      comment: "Number of movements with lot tracking enabled. Indicates traceability coverage for regulatory compliance and recall readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and compliance metrics measuring inventory variance, count frequency, and regulatory compliance. Enables inventory accuracy management, audit readiness, and IATF 16949 / NHTSA compliance tracking."
  source: "`vibe_automotive_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Current status of the cycle count (pending, completed, approved, recounted) for pipeline and completion tracking."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (full, sample, ABC-based) for methodology segmentation and accuracy benchmarking."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU being counted. Enables prioritized accuracy analysis by inventory value tier."
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory being counted for cross-category accuracy comparison."
    - name: "compliance_iatf16949_flag"
      expr: compliance_iatf16949_flag
      comment: "Indicates whether the count is subject to IATF 16949 quality management compliance requirements."
    - name: "compliance_nhtsa_flag"
      expr: compliance_nhtsa_flag
      comment: "Indicates whether the count is subject to NHTSA safety regulatory compliance requirements."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Flags counts that required a recount due to variance, indicating accuracy issues at first count."
    - name: "is_obsolete"
      expr: is_obsolete
      comment: "Indicates whether the counted item is obsolete, used for obsolescence-driven inventory write-off analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the count for year-over-year accuracy trend analysis."
    - name: "count_date"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of the count date for temporal accuracy trend analysis."
    - name: "variance_reason"
      expr: variance_reason
      comment: "Stated reason for inventory variance, used for root cause analysis and process improvement."
    - name: "method"
      expr: method
      comment: "Counting method used (manual, scanner, RFID) for methodology effectiveness comparison."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records. Measures counting activity volume and program coverage."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total absolute inventory variance quantity across all counts. Core inventory accuracy KPI — high values signal systemic stock discrepancies."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle counts. Primary inventory accuracy rate metric used in operational and executive dashboards."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted. Used to measure counting program scope and validate book-to-physical reconciliation."
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total system book quantity at time of count. Paired with counted quantity to compute overall inventory accuracy."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts requiring a recount. Elevated rates indicate first-count accuracy problems and process inefficiency."
    - name: "compliance_iatf16949_count"
      expr: COUNT(CASE WHEN compliance_iatf16949_flag = TRUE THEN 1 END)
      comment: "Number of cycle counts flagged for IATF 16949 compliance. Tracks regulatory coverage for quality management system audits."
    - name: "compliance_nhtsa_count"
      expr: COUNT(CASE WHEN compliance_nhtsa_flag = TRUE THEN 1 END)
      comment: "Number of cycle counts flagged for NHTSA compliance. Tracks safety-critical inventory regulatory coverage."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity recorded at time of count. Used to validate buffer adequacy against actual counted stock levels."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across counted SKUs. Enables assessment of replenishment trigger adequacy relative to actual stock."
    - name: "obsolete_sku_count"
      expr: COUNT(CASE WHEN is_obsolete = TRUE THEN 1 END)
      comment: "Number of cycle count records for obsolete SKUs. Drives obsolescence write-off decisions and inventory rationalization."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_finished_vehicle_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished vehicle inventory metrics tracking stock status, aging, MSRP value, recall exposure, and allocation pipeline. Enables dealer allocation optimization, revenue forecasting, and recall risk management for finished vehicle inventory."
  source: "`vibe_automotive_v1`.`inventory`.`finished_vehicle_stock`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the finished vehicle in inventory (available, allocated, in-transit, hold) for pipeline visibility."
    - name: "model_code"
      expr: model_code
      comment: "Vehicle model code for model-level inventory analysis and demand-supply balancing."
    - name: "plant_code"
      expr: plant_code
      comment: "Production plant code for plant-level finished goods inventory tracking."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates whether the vehicle is subject to an active recall. Critical for compliance, safety, and liability management."
    - name: "hold_code"
      expr: hold_code
      comment: "Code indicating the reason a vehicle is on hold, used for hold resolution prioritization."
    - name: "aging_days"
      expr: aging_days
      comment: "Number of days the vehicle has been in finished stock. Used for aging analysis and incentive/markdown decisions."
    - name: "production_date"
      expr: DATE_TRUNC('month', production_date)
      comment: "Month of vehicle production for production cohort and aging analysis."
    - name: "allocation_date"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of dealer allocation for allocation pipeline trend analysis."
    - name: "expected_delivery_date"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month of expected delivery for forward-looking delivery pipeline analysis."
  measures:
    - name: "total_vehicles_in_stock"
      expr: COUNT(1)
      comment: "Total number of finished vehicles in inventory. Primary finished goods inventory level KPI for production and sales planning."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of finished vehicle inventory. Represents potential revenue at list price — key for working capital and revenue forecasting."
    - name: "avg_msrp_per_vehicle"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per vehicle in stock. Used to track mix shift toward higher or lower value models in inventory."
    - name: "recall_exposed_vehicle_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of finished vehicles in stock subject to an active recall. Critical safety and compliance KPI requiring immediate executive attention."
    - name: "recall_exposure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of finished vehicle inventory affected by recalls. Measures recall risk concentration and urgency of remediation."
    - name: "on_hold_vehicle_count"
      expr: COUNT(CASE WHEN hold_code IS NOT NULL THEN 1 END)
      comment: "Number of vehicles currently on hold for any reason. Elevated counts signal fulfillment risk and potential revenue delay."
    - name: "on_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_code IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of finished vehicle inventory currently on hold. Tracks operational blockages impacting delivery and revenue recognition."
    - name: "total_recall_exposed_msrp"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN CAST(msrp AS DOUBLE) ELSE 0 END)
      comment: "Total MSRP value of recall-affected vehicles in stock. Quantifies financial exposure from recall-impacted inventory for risk management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_mrp_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Requirements Planning (MRP) demand and supply metrics tracking requirement quantities, safety stock adequacy, reorder points, and planning exceptions. Enables supply planning, procurement prioritization, and production scheduling decisions."
  source: "`vibe_automotive_v1`.`inventory`.`mrp_requirement`"
  dimensions:
    - name: "mrp_requirement_status"
      expr: mrp_requirement_status
      comment: "Status of the MRP requirement (open, planned, confirmed, closed) for demand pipeline visibility."
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of MRP requirement (planned order, purchase requisition, production order) for demand source analysis."
    - name: "demand_source"
      expr: demand_source
      comment: "Origin of the demand signal (sales order, forecast, safety stock replenishment) for demand decomposition."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for plant-level MRP demand and supply gap analysis."
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "Planning scenario (baseline, upside, downside) for scenario-based supply planning analysis."
    - name: "source_of_supply"
      expr: source_of_supply
      comment: "Designated supply source (internal production, external supplier) for make-vs-buy and supplier dependency analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code of the requirement for demand prioritization and critical path analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for requirement quantities, enabling cross-SKU demand normalization."
    - name: "requirement_date"
      expr: DATE_TRUNC('month', requirement_date)
      comment: "Month of the requirement date for demand timeline and planning horizon analysis."
    - name: "batch_flag"
      expr: batch_flag
      comment: "Indicates whether the requirement is batch-managed, relevant for lot-size optimization and batch planning."
  measures:
    - name: "total_quantity_required"
      expr: SUM(CAST(quantity_required AS DOUBLE))
      comment: "Total quantity required across all MRP demand records. Primary demand volume KPI for procurement and production planning."
    - name: "avg_quantity_required"
      expr: AVG(CAST(quantity_required AS DOUBLE))
      comment: "Average quantity required per MRP requirement. Used to benchmark demand lot sizes and identify outlier requirements."
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS DOUBLE))
      comment: "Total planned lot size across MRP requirements. Measures planned procurement and production batch volumes."
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock AS DOUBLE))
      comment: "Total safety stock quantity planned across all MRP requirements. Measures buffer investment and supply risk mitigation coverage."
    - name: "total_reorder_point"
      expr: SUM(CAST(reorder_point AS DOUBLE))
      comment: "Total reorder point quantity across MRP requirements. Used to assess replenishment trigger adequacy relative to demand levels."
    - name: "open_requirement_count"
      expr: COUNT(CASE WHEN mrp_requirement_status = 'open' THEN 1 END)
      comment: "Number of open (unfulfilled) MRP requirements. Tracks unresolved demand backlog requiring procurement or production action."
    - name: "exception_requirement_count"
      expr: COUNT(CASE WHEN exception_message IS NOT NULL THEN 1 END)
      comment: "Number of MRP requirements with exception messages. Exceptions signal planning conflicts, lead time violations, or capacity issues requiring planner intervention."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_message IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MRP requirements flagged with exceptions. A high exception rate indicates systemic planning instability or supply constraint issues."
    - name: "total_mrp_requirements"
      expr: COUNT(1)
      comment: "Total number of MRP requirement records. Measures planning workload volume and demand complexity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_stock_transfer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock transfer order metrics tracking inter-plant transfer volumes, costs, execution efficiency, and compliance. Enables supply chain network optimization, transfer cost management, and JIT/JIS delivery performance analysis."
  source: "`vibe_automotive_v1`.`inventory`.`stock_transfer_order`"
  dimensions:
    - name: "stock_transfer_order_status"
      expr: stock_transfer_order_status
      comment: "Current status of the stock transfer order (open, in-progress, completed, cancelled) for pipeline and fulfillment tracking."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (plant-to-plant, warehouse-to-warehouse, cross-dock) for network flow analysis."
    - name: "priority"
      expr: priority
      comment: "Transfer priority level for urgency-based workload analysis and SLA compliance."
    - name: "is_jit"
      expr: is_jit
      comment: "Indicates whether the transfer is part of a Just-In-Time delivery program. Used to track JIT coverage and on-time performance."
    - name: "is_jis"
      expr: is_jis
      comment: "Indicates whether the transfer is part of a Just-In-Sequence delivery program. Used to track JIS sequencing compliance."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flags transfers involving hazardous materials for compliance and safety routing analysis."
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Indicates whether temperature-controlled transport is required, used for specialized logistics cost analysis."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the transfer cost for multi-currency cost analysis."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the transfer order for goods receipt and completion tracking."
    - name: "transfer_created_timestamp"
      expr: DATE_TRUNC('month', transfer_created_timestamp)
      comment: "Month the transfer order was created for trend analysis of transfer volumes and costs over time."
  measures:
    - name: "total_transfer_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity transferred across all stock transfer orders. Primary inter-plant flow volume KPI for supply chain network analysis."
    - name: "total_transfer_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all stock transfer orders. Core logistics cost KPI for supply chain cost management and network optimization."
    - name: "avg_transfer_cost_per_order"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stock transfer order. Used to benchmark transfer efficiency and identify high-cost transfer lanes."
    - name: "total_transfer_orders"
      expr: COUNT(1)
      comment: "Total number of stock transfer orders. Measures inter-plant transfer activity volume and supply chain network utilization."
    - name: "jit_transfer_count"
      expr: COUNT(CASE WHEN is_jit = TRUE THEN 1 END)
      comment: "Number of JIT stock transfer orders. Tracks JIT program coverage and volume for lean manufacturing performance assessment."
    - name: "jit_transfer_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_jit = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfer orders under JIT program. Measures lean supply chain adoption and JIT dependency level."
    - name: "hazmat_transfer_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of transfers involving hazardous materials. Tracks regulatory compliance exposure and specialized logistics requirements."
    - name: "avg_transfer_quantity_per_order"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per transfer order. Used to assess transfer lot size efficiency and identify consolidation opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_service_parts_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service parts inventory metrics tracking availability, cost, obsolescence, and warranty status across dealer and service center networks. Enables aftersales parts availability optimization, obsolescence management, and service level performance."
  source: "`vibe_automotive_v1`.`inventory`.`service_parts_stock`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status of the service part (available, reserved, quarantine) for availability analysis."
    - name: "obsolescence_status"
      expr: obsolescence_status
      comment: "Obsolescence status of the part (active, superseded, obsolete) for lifecycle and write-off management."
    - name: "warranty_status"
      expr: warranty_status
      comment: "Warranty status of the service part for warranty claim and coverage analysis."
    - name: "cycle_count_status"
      expr: cycle_count_status
      comment: "Cycle count status of the service parts stock record for inventory accuracy tracking."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Valuation method applied to the service part (FIFO, LIFO, average cost) for financial reporting segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost analysis in multi-currency dealer and service center networks."
    - name: "serial_number_flag"
      expr: serial_number_flag
      comment: "Indicates whether the part is serialized for traceability and recall readiness analysis."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of part expiration for shelf-life management and write-off planning."
    - name: "obsolescence_date"
      expr: DATE_TRUNC('month', obsolescence_date)
      comment: "Month of planned obsolescence for proactive inventory rationalization planning."
    - name: "last_receipt_date"
      expr: DATE_TRUNC('month', last_receipt_date)
      comment: "Month of last receipt for slow-mover and dead-stock identification."
  measures:
    - name: "total_service_parts_records"
      expr: COUNT(1)
      comment: "Total number of service parts stock records. Measures parts catalog coverage across dealer and service center network."
    - name: "total_cost_value"
      expr: SUM(CAST(cost_per_unit AS DOUBLE))
      comment: "Total cost value of service parts inventory. Core working capital metric for aftersales parts inventory investment management."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per service part unit. Used to benchmark parts pricing, detect cost anomalies, and support margin analysis."
    - name: "obsolete_parts_count"
      expr: COUNT(CASE WHEN obsolescence_status = 'obsolete' THEN 1 END)
      comment: "Number of service parts records with obsolete status. Drives write-off decisions and inventory rationalization to reduce carrying costs."
    - name: "obsolete_parts_cost_value"
      expr: SUM(CASE WHEN obsolescence_status = 'obsolete' THEN CAST(cost_per_unit AS DOUBLE) ELSE 0 END)
      comment: "Total cost value of obsolete service parts. Quantifies financial exposure from obsolete inventory requiring write-off or disposal."
    - name: "obsolescence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN obsolescence_status = 'obsolete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service parts stock records that are obsolete. High rates signal poor parts lifecycle management and excess carrying cost."
    - name: "recall_exposed_parts_count"
      expr: COUNT(CASE WHEN recall_campaign_id IS NOT NULL THEN 1 END)
      comment: "Number of service parts stock records linked to an active recall campaign. Tracks recall parts availability for safety compliance and customer satisfaction."
    - name: "serialized_parts_count"
      expr: COUNT(CASE WHEN serial_number_flag = TRUE THEN 1 END)
      comment: "Number of serialized service parts in stock. Measures traceability coverage for warranty, recall, and regulatory compliance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse network capacity and operational metrics tracking footprint, utilization, and network composition. Enables warehouse network optimization, capacity planning, and real estate investment decisions."
  source: "`vibe_automotive_v1`.`inventory`.`warehouse`"
  dimensions:
    - name: "warehouse_status"
      expr: warehouse_status
      comment: "Operational status of the warehouse (active, inactive, under construction) for network availability analysis."
    - name: "warehouse_type"
      expr: warehouse_type
      comment: "Type of warehouse (distribution center, plant warehouse, dealer PDC) for network segmentation and benchmarking."
    - name: "region"
      expr: region
      comment: "Geographic region of the warehouse for regional network capacity and coverage analysis."
    - name: "country"
      expr: country
      comment: "Country of the warehouse for international network footprint and compliance analysis."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the warehouse has temperature-controlled storage, relevant for specialized parts and materials."
    - name: "security_level"
      expr: security_level
      comment: "Security classification of the warehouse for risk and compliance segmentation."
    - name: "open_date"
      expr: DATE_TRUNC('year', open_date)
      comment: "Year the warehouse opened for network age and investment vintage analysis."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouse records in the network. Measures network footprint size for capacity planning and real estate management."
    - name: "total_capacity_sqft"
      expr: SUM(CAST(capacity_sqft AS DOUBLE))
      comment: "Total warehouse capacity in square feet across the network. Core real estate and capacity planning KPI for network expansion decisions."
    - name: "total_capacity_cubic_m"
      expr: SUM(CAST(capacity_cubic_m AS DOUBLE))
      comment: "Total warehouse capacity in cubic meters. Used for volumetric capacity planning and storage density analysis."
    - name: "avg_capacity_sqft_per_warehouse"
      expr: AVG(CAST(capacity_sqft AS DOUBLE))
      comment: "Average warehouse size in square feet. Benchmarks warehouse scale and identifies undersized or oversized facilities."
    - name: "temperature_controlled_warehouse_count"
      expr: COUNT(CASE WHEN temperature_controlled = TRUE THEN 1 END)
      comment: "Number of temperature-controlled warehouses in the network. Tracks specialized storage capacity for temperature-sensitive parts and materials."
    - name: "active_warehouse_count"
      expr: COUNT(CASE WHEN warehouse_status = 'active' THEN 1 END)
      comment: "Number of currently active warehouses. Measures operational network size for capacity and throughput planning."
    - name: "active_warehouse_capacity_sqft"
      expr: SUM(CASE WHEN warehouse_status = 'active' THEN CAST(capacity_sqft AS DOUBLE) ELSE 0 END)
      comment: "Total square footage of active warehouses only. Represents currently available network capacity for operational planning."
$$;