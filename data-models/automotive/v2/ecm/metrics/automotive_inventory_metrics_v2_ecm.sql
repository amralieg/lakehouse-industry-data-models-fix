-- Metric views for domain: inventory | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory position metrics tracking unrestricted, blocked, in-transit, and quality-inspection stock quantities and values by SKU, plant, and storage location. Drives replenishment decisions, working capital management, and supply chain risk visibility."
  source: "`vibe_automotive_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant or distribution center code where stock is held — primary grouping for plant-level inventory analysis."
    - name: "stock_category"
      expr: stock_category
      comment: "Category of stock (raw material, WIP, finished goods, spare parts) for segmented inventory reporting."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type (standard price, moving average) used to classify how inventory value is calculated."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status of the stock batch — used to separate unrestricted from quality-hold inventory."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the SKU (active, phase-out, obsolete) for obsolescence risk segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which stock value is expressed — required for multi-currency inventory valuation reporting."
    - name: "goods_movement_type"
      expr: goods_movement_type
      comment: "Last goods movement type recorded against this stock balance — useful for movement pattern analysis."
  measures:
    - name: "total_unrestricted_stock_qty"
      expr: SUM(CAST(unrestricted_stock_qty AS DOUBLE))
      comment: "Total unrestricted (available-to-use) stock quantity across all SKUs and locations. Primary availability KPI for production planning and order fulfillment."
    - name: "total_blocked_stock_qty"
      expr: SUM(CAST(blocked_stock_qty AS DOUBLE))
      comment: "Total blocked stock quantity held due to quality issues, holds, or disputes. Elevated values signal supply risk and quality problems requiring immediate action."
    - name: "total_in_transit_stock_qty"
      expr: SUM(CAST(in_transit_stock_qty AS DOUBLE))
      comment: "Total stock quantity currently in transit between plants or from suppliers. Critical for supply chain visibility and accurate available-stock calculations."
    - name: "total_quality_inspection_stock_qty"
      expr: SUM(CAST(quality_inspection_stock_qty AS DOUBLE))
      comment: "Total stock quantity under quality inspection and not yet released. High values indicate quality bottlenecks slowing production throughput."
    - name: "total_stock_value"
      expr: SUM(CAST(valuation_price AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE))
      comment: "Total inventory value (unit valuation price × quantity on hand) representing working capital tied up in stock. Key financial KPI for CFO and supply chain leadership."
    - name: "avg_valuation_price_per_sku"
      expr: AVG(CAST(valuation_price AS DOUBLE))
      comment: "Average unit valuation price across all stock balance records. Tracks price drift and supports standard cost vs. moving average price variance analysis."
    - name: "blocked_stock_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(blocked_stock_qty AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of total on-hand stock that is blocked. A rising ratio signals systemic quality or compliance issues requiring executive intervention."
    - name: "quality_hold_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(quality_inspection_stock_qty AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock currently under quality inspection. Directly impacts production schedule adherence and customer delivery performance."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with active stock balances. Tracks portfolio breadth and supports SKU rationalization decisions."
    - name: "safety_stock_coverage_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity maintained across all SKUs and locations. Represents the buffer investment against demand and supply variability."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial inventory valuation metrics tracking total stock value, standard vs. moving average price variances, write-downs, and obsolescence flags by plant, cost center, and fiscal period. Directly feeds balance sheet reporting and working capital management."
  source: "`vibe_automotive_v1`.`inventory`.`inventory_valuation`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or valuation area where inventory is held — primary dimension for plant-level financial reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation record — enables year-over-year inventory value trend analysis."
    - name: "period"
      expr: period
      comment: "Fiscal period (month) within the fiscal year — supports monthly closing and period-over-period variance tracking."
    - name: "valuation_class"
      expr: valuation_class
      comment: "SAP valuation class grouping materials by type (raw material, semi-finished, finished) for balance sheet account assignment."
    - name: "price_control"
      expr: price_control
      comment: "Price control method (S=standard price, V=moving average price) — critical for understanding valuation methodology applied."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (active, closed, under review) for filtering current vs. historical valuations."
    - name: "obsolescence_flag"
      expr: obsolescence_flag
      comment: "Indicates whether the SKU has been flagged as obsolete — used to segment at-risk inventory value for write-down planning."
    - name: "area"
      expr: area
      comment: "Valuation area (typically plant or company code level) for organizational segmentation of inventory value."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total inventory value across all SKUs and plants for the period. Primary balance sheet KPI representing working capital invested in inventory."
    - name: "total_stock_quantity"
      expr: SUM(CAST(total_stock_quantity AS DOUBLE))
      comment: "Total physical stock quantity across all valuation records. Used alongside total value to compute average unit cost and detect quantity-value mismatches."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price per unit across all valuated SKUs. Benchmark for cost variance analysis and annual standard cost review."
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price per unit. Compared against standard price to quantify price variance exposure in the inventory portfolio."
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Total price variance (actual vs. standard cost) across all inventory positions. A key P&L impact metric — large variances trigger cost accounting investigations."
    - name: "total_write_down_amount"
      expr: SUM(CAST(write_down_amount AS DOUBLE))
      comment: "Total inventory write-down amount for the period. Directly impacts gross margin and is a key indicator of obsolescence and demand forecast accuracy."
    - name: "obsolete_inventory_count"
      expr: COUNT(CASE WHEN obsolescence_flag = TRUE THEN 1 END)
      comment: "Number of SKU-plant combinations flagged as obsolete. Drives write-down provisioning and SKU rationalization decisions."
    - name: "price_variance_to_value_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(price_variance AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Price variance as a percentage of total stock value. Measures the magnitude of cost deviation relative to inventory investment — a key cost control KPI."
    - name: "write_down_to_value_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(write_down_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Write-down amount as a percentage of total stock value. Tracks the financial impact of obsolescence and quality issues on inventory asset quality."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational inventory flow metrics tracking goods receipts, issues, transfers, and reversals by movement type, plant, and posting date. Drives throughput analysis, reversal rate monitoring, and inventory accuracy assessment."
  source: "`vibe_automotive_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Status of the goods movement (posted, reversed, pending) — used to filter active vs. cancelled movements."
    - name: "movement_reason"
      expr: movement_reason
      comment: "Business reason for the goods movement (production issue, return, transfer) — key dimension for root cause analysis of inventory changes."
    - name: "source_plant"
      expr: source_plant
      comment: "Source plant of the goods movement — enables plant-level throughput and transfer analysis."
    - name: "destination_plant"
      expr: destination_plant
      comment: "Destination plant for transfer movements — used to map inter-plant material flows."
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of the originating document (purchase order, production order, sales order) — links movements to upstream business processes."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection status at time of goods movement — identifies movements blocked or released by quality decisions."
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates whether the movement was triggered automatically (e.g., by AGV or MES) vs. manually — tracks automation adoption in warehouse operations."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the goods movement was posted to inventory — primary time dimension for trend and period analysis."
  measures:
    - name: "total_movement_count"
      expr: COUNT(1)
      comment: "Total number of goods movements posted. Baseline throughput KPI for warehouse and inventory operations — tracks operational volume."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of materials moved across all movement types. Measures physical throughput of the inventory operation."
    - name: "total_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total USD value of all goods movements. Tracks the financial magnitude of inventory flows — key for working capital and cost-of-goods-sold analysis."
    - name: "total_amount_local"
      expr: SUM(CAST(amount_local AS DOUBLE))
      comment: "Total local currency value of goods movements. Used for local statutory reporting and plant-level cost accounting."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed goods movements. High reversal counts indicate data entry errors, process failures, or systemic issues in goods receipt/issue workflows."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods movements that were reversed. A key inventory accuracy and process quality KPI — target is below 2% in best-in-class operations."
    - name: "automated_movement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_automated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods movements executed automatically (AGV, MES integration). Tracks Industry 4.0 automation adoption and its impact on throughput and accuracy."
    - name: "avg_movement_value_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average USD value per goods movement transaction. Useful for detecting anomalous high-value movements and benchmarking transaction size trends."
    - name: "distinct_sku_moved_count"
      expr: COUNT(DISTINCT part_master_id)
      comment: "Number of distinct parts/SKUs involved in goods movements. Measures breadth of inventory activity and supports demand-driven replenishment analysis."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy metrics derived from cycle count results, tracking variance rates, count completion, and recount frequency by plant, ABC class, and storage location. Drives inventory accuracy improvement programs and audit compliance."
  source: "`vibe_automotive_v1`.`inventory`.`cycle_count`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the counted SKU (A=high value, B=medium, C=low) — enables risk-based cycle count frequency analysis."
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (completed, pending, in-progress, cancelled) — used to filter completed counts for accuracy analysis."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (cycle count, annual physical inventory, spot check) — segments accuracy results by count methodology."
    - name: "inventory_category"
      expr: inventory_category
      comment: "Inventory category (raw material, WIP, finished goods) — enables category-level accuracy benchmarking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the count — supports year-over-year inventory accuracy trend analysis."
    - name: "count_date"
      expr: count_date
      comment: "Date the physical count was performed — primary time dimension for cycle count scheduling and completion tracking."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Indicates whether this count was a recount triggered by a variance — used to measure first-count accuracy rates."
  measures:
    - name: "total_counts_performed"
      expr: COUNT(1)
      comment: "Total number of cycle count records. Tracks count program execution volume against the planned count schedule."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total absolute quantity variance between book and physical counts. Measures the magnitude of inventory discrepancies requiring investigation and correction."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all cycle counts. Primary inventory accuracy KPI — best-in-class operations target below 0.5% average variance."
    - name: "inventory_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ABS(variance_percentage) <= 0.5 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts with variance within ±0.5% tolerance. The headline inventory accuracy KPI used in IATF 16949 compliance and operational scorecards."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring a recount due to variance. High recount rates signal systemic inventory management issues or counting process failures."
    - name: "avg_book_quantity"
      expr: AVG(CAST(book_quantity AS DOUBLE))
      comment: "Average book (system) quantity per count record. Baseline for understanding the scale of inventory positions being counted."
    - name: "avg_counted_quantity"
      expr: AVG(CAST(counted_quantity AS DOUBLE))
      comment: "Average physically counted quantity per count record. Compared against book quantity to assess systematic over/under-recording patterns."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all counted SKUs. Tracks the buffer investment and supports safety stock optimization decisions."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_finished_vehicle_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished vehicle inventory metrics tracking stock aging, MSRP value, recall exposure, and allocation status by plant, model, body style, and powertrain. Critical for sales operations, dealer allocation, and working capital management."
  source: "`vibe_automotive_v1`.`inventory`.`finished_vehicle_stock`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the finished vehicle (available, allocated, in-transit, hold, sold) — primary dimension for pipeline management."
    - name: "plant_code"
      expr: plant_code
      comment: "Production plant where the vehicle was built — enables plant-level finished goods inventory analysis."
    - name: "body_style"
      expr: body_style
      comment: "Vehicle body style (SUV, sedan, truck, etc.) — key commercial dimension for demand mix analysis."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, BEV, PHEV, HEV) — critical for electrification mix reporting and regulatory compliance tracking."
    - name: "trim_level"
      expr: trim_level
      comment: "Vehicle trim level — used to analyze inventory mix vs. demand mix and identify over/under-stocked configurations."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emission standard the vehicle is certified to (Euro 6, EPA Tier 3) — required for regulatory compliance and market eligibility reporting."
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (plant yard, port, dealer lot, compound) — tracks vehicle position in the distribution pipeline."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Indicates whether the vehicle is subject to an active recall — used to quarantine and prioritize recall remedy actions."
  measures:
    - name: "total_vehicles_in_stock"
      expr: COUNT(1)
      comment: "Total number of finished vehicles in inventory. Primary pipeline KPI for sales operations and production planning — tracks days of supply."
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value of finished vehicle inventory. Represents the retail value of the vehicle pipeline — key working capital and revenue potential KPI."
    - name: "avg_msrp_per_vehicle"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per vehicle in stock. Tracks the average selling price mix of the inventory pipeline — rising values indicate favorable mix shift."
    - name: "avg_aging_days"
      expr: AVG(CAST(aging_days AS DOUBLE))
      comment: "Average number of days vehicles have been in finished goods inventory. Vehicles aging beyond 60 days represent increasing carrying cost and discount risk."
    - name: "vehicles_on_recall_hold"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of finished vehicles subject to an active recall hold. Directly impacts deliverable inventory and revenue recognition — requires urgent executive attention."
    - name: "recall_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of finished vehicle inventory affected by recall holds. A critical quality and compliance KPI — any significant percentage triggers immediate escalation."
    - name: "allocated_vehicle_count"
      expr: COUNT(CASE WHEN stock_status = 'allocated' THEN 1 END)
      comment: "Number of vehicles already allocated to dealers or customers. Measures the committed portion of the pipeline and supports delivery scheduling."
    - name: "allocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stock_status = 'allocated' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of finished vehicle inventory that has been allocated. High allocation rates indicate strong demand relative to supply — low rates signal overproduction risk."
    - name: "distinct_model_count"
      expr: COUNT(DISTINCT model_code)
      comment: "Number of distinct vehicle models represented in finished goods inventory. Tracks portfolio breadth and supports mix management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_mrp_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Requirements Planning metrics tracking open requirements, lot sizes, safety stock coverage, and planning exceptions by plant, material, and demand source. Drives procurement and production scheduling decisions."
  source: "`vibe_automotive_v1`.`inventory`.`mrp_requirement`"
  dimensions:
    - name: "mrp_requirement_status"
      expr: mrp_requirement_status
      comment: "Status of the MRP requirement (open, planned, converted, cancelled) — used to filter actionable vs. historical requirements."
    - name: "requirement_type"
      expr: requirement_type
      comment: "Type of MRP requirement (planned order, purchase requisition, production order) — segments requirements by fulfillment method."
    - name: "demand_source"
      expr: demand_source
      comment: "Source of the demand driving the requirement (sales order, forecast, safety stock) — enables demand-type analysis for planning accuracy."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for which the MRP requirement was generated — primary dimension for plant-level supply planning."
    - name: "source_of_supply"
      expr: source_of_supply
      comment: "Planned source of supply (internal production, external supplier, stock transfer) — used to analyze make vs. buy decisions."
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "MRP planning scenario (current plan, simulation, what-if) — enables scenario comparison for supply planning decisions."
    - name: "requirement_date"
      expr: requirement_date
      comment: "Date by which the material is required — primary time dimension for demand timeline analysis and supply gap identification."
  measures:
    - name: "total_open_requirements"
      expr: COUNT(1)
      comment: "Total number of open MRP requirements. Baseline planning workload KPI — high volumes indicate active production and procurement demand."
    - name: "total_quantity_required"
      expr: SUM(CAST(quantity_required AS DOUBLE))
      comment: "Total quantity required across all open MRP requirements. Measures the aggregate demand signal driving procurement and production scheduling."
    - name: "total_safety_stock"
      expr: SUM(CAST(safety_stock AS DOUBLE))
      comment: "Total safety stock quantity maintained across all MRP-planned materials. Represents the buffer investment against supply and demand variability."
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS DOUBLE))
      comment: "Total planned lot size across all MRP requirements. Used to assess batch sizing efficiency and its impact on inventory carrying costs."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average planned lead time in days across all MRP requirements. A key supply chain responsiveness KPI — longer lead times increase safety stock requirements and supply risk."
    - name: "requirements_with_exceptions"
      expr: COUNT(CASE WHEN exception_message IS NOT NULL AND exception_message <> '' THEN 1 END)
      comment: "Number of MRP requirements with planning exception messages (e.g., reschedule in/out, excess stock). Exceptions require planner action to prevent supply disruptions or excess inventory."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_message IS NOT NULL AND exception_message <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MRP requirements flagged with planning exceptions. High exception rates indicate planning instability and demand forecast inaccuracy — a key S&OP health metric."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across all MRP-planned materials. Benchmarks the trigger levels for replenishment and supports safety stock policy optimization."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order performance metrics tracking fulfillment rates, lead times, cost per unit, and on-time delivery by supplier, replenishment method, and priority. Drives supplier performance management and inventory replenishment efficiency."
  source: "`vibe_automotive_v1`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (open, in-transit, received, cancelled) — primary filter for active vs. completed orders."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (purchase order, stock transfer, production order) — segments replenishment by fulfillment channel."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment strategy (kanban, MRP, min-max, JIT) — enables method-level performance comparison."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the order (on-time, late, partial, cancelled) — key dimension for supplier delivery performance analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order (critical, high, normal) — used to track escalation rates and emergency replenishment frequency."
    - name: "trigger_source"
      expr: trigger_source
      comment: "Source that triggered the replenishment (MRP, kanban signal, manual, min-max) — tracks automation vs. manual intervention rates."
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Promised delivery date from the supplier — primary time dimension for on-time delivery performance tracking."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders placed. Baseline operational volume KPI for procurement and inventory planning teams."
    - name: "total_cost_per_unit"
      expr: SUM(CAST(cost_per_unit AS DOUBLE))
      comment: "Sum of unit costs across all replenishment orders. Used to track total replenishment cost exposure and support cost reduction initiatives."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average unit cost across replenishment orders. Tracks cost trends by supplier and material — rising averages trigger renegotiation or sourcing review."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average replenishment lead time in days. A critical supply chain responsiveness KPI — directly impacts safety stock requirements and production schedule risk."
    - name: "critical_order_count"
      expr: COUNT(CASE WHEN priority_level = 'critical' THEN 1 END)
      comment: "Number of replenishment orders flagged as critical priority. High counts indicate systemic supply planning failures or demand volatility requiring structural intervention."
    - name: "critical_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN priority_level = 'critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders classified as critical. A key supply chain health KPI — best-in-class operations target below 5% critical order rate."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'on-time' THEN 1 END)
      comment: "Number of replenishment orders delivered on time. Numerator for on-time delivery rate — tracks supplier reliability."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fulfillment_status = 'on-time' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders fulfilled on time. Primary supplier delivery performance KPI — target is 95%+ for critical parts in automotive supply chains."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_abc_xyz_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory segmentation metrics based on ABC (value) and XYZ (demand variability) classification, tracking safety stock investment, consumption frequency, and obsolescence risk by segment. Drives differentiated inventory management strategies."
  source: "`vibe_automotive_v1`.`inventory`.`abc_xyz_classification`"
  dimensions:
    - name: "abc_class"
      expr: abc_class
      comment: "ABC value classification (A=top 80% of value, B=next 15%, C=bottom 5%) — primary segmentation for inventory investment prioritization."
    - name: "xyz_class"
      expr: xyz_class
      comment: "XYZ demand variability classification (X=stable, Y=variable, Z=irregular) — combined with ABC to define optimal replenishment strategies."
    - name: "classification_method"
      expr: classification_method
      comment: "Method used to derive the classification (annual consumption value, frequency analysis) — ensures comparability across classification runs."
    - name: "abc_xyz_classification_status"
      expr: abc_xyz_classification_status
      comment: "Status of the classification record (active, superseded, under review) — filters current vs. historical classifications."
    - name: "is_obsolete"
      expr: is_obsolete
      comment: "Indicates whether the SKU has been classified as obsolete — used to segment at-risk inventory for write-down and disposal planning."
    - name: "classification_date"
      expr: classification_date
      comment: "Date the classification was last performed — tracks classification currency and supports scheduled review compliance."
  measures:
    - name: "total_sku_count"
      expr: COUNT(1)
      comment: "Total number of SKUs in the classification. Tracks portfolio size and supports SKU rationalization decisions."
    - name: "total_annual_consumption_value"
      expr: SUM(CAST(annual_consumption_value AS DOUBLE))
      comment: "Total annual consumption value across all classified SKUs. Measures the total spend driven by inventory consumption — key input for ABC segmentation and procurement strategy."
    - name: "avg_annual_consumption_value"
      expr: AVG(CAST(annual_consumption_value AS DOUBLE))
      comment: "Average annual consumption value per SKU. Benchmarks the value contribution per item and identifies high-value SKUs requiring tighter management."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all classified SKUs. Represents the buffer investment — segmented by ABC/XYZ class to optimize safety stock allocation."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity per SKU. Used to benchmark safety stock levels by classification segment and identify over/under-buffered items."
    - name: "obsolete_sku_count"
      expr: COUNT(CASE WHEN is_obsolete = TRUE THEN 1 END)
      comment: "Number of SKUs classified as obsolete. Drives write-down provisioning and portfolio cleanup decisions — a key inventory health KPI."
    - name: "obsolete_sku_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_obsolete = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of the SKU portfolio classified as obsolete. Tracks portfolio health — rising obsolescence rates signal product lifecycle management failures."
    - name: "avg_cycle_count_frequency_days"
      expr: AVG(CAST(cycle_count_frequency_days AS DOUBLE))
      comment: "Average cycle count frequency in days across all classified SKUs. Ensures high-value (A-class) items are counted more frequently — validates risk-based count scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_obsolescence_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory obsolescence risk and write-down metrics tracking estimated write-down values, disposition decisions, and at-risk stock by plant, review status, and end-of-production flags. Directly impacts P&L provisioning and working capital management."
  source: "`vibe_automotive_v1`.`inventory`.`obsolescence_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Status of the obsolescence review (open, approved, closed, escalated) — filters actionable reviews requiring disposition decisions."
    - name: "recommended_disposition"
      expr: recommended_disposition
      comment: "Recommended action for obsolete stock (scrap, return to supplier, rework, donate) — tracks disposition strategy mix and associated cost implications."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the obsolete stock is held — enables plant-level obsolescence risk reporting."
    - name: "eop_flag"
      expr: eop_flag
      comment: "End-of-production flag — identifies stock that became obsolete due to model changeover or program end, a major source of write-downs in automotive."
    - name: "is_critical"
      expr: is_critical
      comment: "Indicates whether the obsolescence case is critical (high value or regulatory impact) — used to prioritize disposition actions."
    - name: "review_date"
      expr: review_date
      comment: "Date the obsolescence review was conducted — primary time dimension for tracking review cadence and aging of open cases."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of obsolescence review records. Tracks the volume of at-risk inventory cases requiring management attention."
    - name: "total_estimated_write_down_value"
      expr: SUM(CAST(estimated_write_down_value AS DOUBLE))
      comment: "Total estimated write-down value across all open obsolescence reviews. Primary P&L risk KPI — directly impacts gross margin and requires CFO-level visibility."
    - name: "avg_estimated_write_down_value"
      expr: AVG(CAST(estimated_write_down_value AS DOUBLE))
      comment: "Average estimated write-down value per obsolescence case. Benchmarks the financial impact per case and identifies high-value outliers requiring priority disposition."
    - name: "total_valuation_price_at_risk"
      expr: SUM(CAST(valuation_price AS DOUBLE))
      comment: "Total book value of inventory under obsolescence review. Represents the gross asset value at risk before write-down — used for balance sheet provisioning."
    - name: "critical_case_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of obsolescence cases flagged as critical. High-priority cases requiring immediate executive decision to minimize financial exposure."
    - name: "eop_driven_case_count"
      expr: COUNT(CASE WHEN eop_flag = TRUE THEN 1 END)
      comment: "Number of obsolescence cases driven by end-of-production events. Tracks the financial impact of model changeovers and program terminations on inventory."
    - name: "write_down_to_book_value_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(estimated_write_down_value AS DOUBLE)) / NULLIF(SUM(CAST(valuation_price AS DOUBLE)), 0), 2)
      comment: "Estimated write-down as a percentage of total book value under review. Measures the severity of obsolescence — high ratios indicate deep discounting or scrapping required."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_consignment_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consignment inventory metrics tracking supplier-owned stock on hand, settlement obligations, consumption rates, and aging by supplier, plant, and settlement status. Manages working capital efficiency and supplier liability exposure."
  source: "`vibe_automotive_v1`.`inventory`.`consignment_stock`"
  dimensions:
    - name: "consignment_stock_status"
      expr: consignment_stock_status
      comment: "Status of the consignment stock (available, consumed, returned, settled) — primary filter for active vs. settled consignment positions."
    - name: "consignment_type"
      expr: consignment_type
      comment: "Type of consignment arrangement (vendor consignment, customer consignment) — segments liability and ownership analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of consumed consignment stock (pending, settled, disputed) — tracks outstanding payment obligations to suppliers."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where consignment stock is held — enables plant-level consignment inventory management."
    - name: "stock_category"
      expr: stock_category
      comment: "Category of consignment stock (raw material, components, spare parts) — supports category-level consignment strategy analysis."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Valuation method applied to consignment stock — ensures consistent financial reporting of supplier-owned inventory."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total consignment stock quantity on hand. Measures the volume of supplier-owned inventory held at company facilities — key for working capital optimization."
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total value of consignment stock on hand. Represents supplier-owned assets on company premises — tracks off-balance-sheet inventory exposure."
    - name: "total_consumption_quantity"
      expr: SUM(CAST(consumption_quantity AS DOUBLE))
      comment: "Total quantity of consignment stock consumed. Drives settlement obligations and tracks actual usage vs. on-hand levels."
    - name: "total_settlement_due_quantity"
      expr: SUM(CAST(settlement_due_quantity AS DOUBLE))
      comment: "Total quantity of consumed consignment stock pending settlement payment. Tracks outstanding supplier payment obligations — key for accounts payable management."
    - name: "avg_aging_days"
      expr: AVG(CAST(aging_days AS DOUBLE))
      comment: "Average age of consignment stock in days. Long-aging consignment stock may indicate demand forecast errors or product obsolescence — triggers supplier return negotiations."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with active consignment arrangements. Tracks the breadth of consignment program and supplier dependency concentration."
    - name: "consumption_to_onhand_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(consumption_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Consumption quantity as a percentage of on-hand quantity. Measures consignment stock turnover velocity — low ratios indicate slow-moving consignment requiring renegotiation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment metrics tracking the volume, value, and approval status of manual and system-generated inventory corrections by reason code, plant, and adjustment type. Drives inventory accuracy improvement and internal control monitoring."
  source: "`vibe_automotive_v1`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of inventory adjustment (quantity correction, valuation adjustment, write-off) — primary dimension for root cause analysis of inventory discrepancies."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment (pending approval, approved, posted, rejected) — filters actionable vs. completed adjustments."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment (cycle count variance, damage, theft, system error) — key dimension for identifying systemic inventory accuracy issues."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the adjustment was made — enables plant-level adjustment frequency and value analysis."
    - name: "is_approved"
      expr: is_approved
      comment: "Indicates whether the adjustment has been approved — used to separate authorized from pending adjustments in financial reporting."
    - name: "is_manual"
      expr: is_manual
      comment: "Indicates whether the adjustment was manually entered vs. system-generated — tracks manual intervention rates as a process quality indicator."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the adjustment was posted to inventory — primary time dimension for trend analysis of adjustment frequency."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of inventory adjustments. High adjustment volumes signal inventory accuracy problems requiring process improvement or system fixes."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial impact of all inventory adjustments. Measures the P&L exposure from inventory discrepancies — a key internal controls and audit KPI."
    - name: "avg_cost_impact_per_adjustment"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average financial impact per adjustment. Identifies whether adjustments are high-value outliers or systemic small-value issues — informs prioritization of corrective actions."
    - name: "total_quantity_adjusted"
      expr: SUM(CAST(quantity_adjusted AS DOUBLE))
      comment: "Total quantity adjusted across all adjustment records. Measures the physical magnitude of inventory corrections relative to total stock levels."
    - name: "manual_adjustment_count"
      expr: COUNT(CASE WHEN is_manual = TRUE THEN 1 END)
      comment: "Number of manually entered adjustments. High manual adjustment rates indicate process gaps or system integration failures requiring automation."
    - name: "manual_adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that were manually entered. A key process automation KPI — best-in-class operations target below 10% manual adjustment rate."
    - name: "unapproved_adjustment_count"
      expr: COUNT(CASE WHEN is_approved = FALSE THEN 1 END)
      comment: "Number of adjustments pending or without approval. Unapproved adjustments represent unresolved inventory discrepancies and internal control gaps."
    - name: "total_tax_impact"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount associated with inventory adjustments. Tracks tax exposure from inventory corrections — relevant for customs and indirect tax compliance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_wip_order_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work-in-progress inventory metrics tracking issued vs. required quantities, scrap rates, and cost by production order and component. Drives production efficiency, material yield, and WIP cost management."
  source: "`vibe_automotive_v1`.`inventory`.`wip_order_stock`"
  dimensions:
    - name: "wip_order_stock_status"
      expr: wip_order_stock_status
      comment: "Status of the WIP stock record (open, partially issued, fully issued, closed) — primary filter for active production orders."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status of the WIP component (available, reserved, issued, scrapped) — tracks material disposition within the production process."
    - name: "component_name"
      expr: component_name
      comment: "Name of the WIP component — enables component-level material consumption and scrap analysis."
    - name: "backflush_flag"
      expr: backflush_flag
      comment: "Indicates whether material consumption is recorded via backflushing — tracks automation of goods issue posting in production."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the WIP stock record — primary time dimension for production period analysis."
  measures:
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total material quantity required by production orders. Baseline demand signal for production material planning and procurement."
    - name: "total_issued_quantity"
      expr: SUM(CAST(issued_quantity AS DOUBLE))
      comment: "Total material quantity actually issued to production. Compared against required quantity to measure material fulfillment rate and identify shortages."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total material quantity scrapped during production. A key manufacturing quality and yield KPI — high scrap drives material cost overruns and production delays."
    - name: "total_wip_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of WIP inventory across all production orders. Measures working capital tied up in in-process production — key for financial closing and cost accounting."
    - name: "material_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(issued_quantity AS DOUBLE)) / NULLIF(SUM(CAST(required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required material quantity that has been issued to production. Below 95% indicates material shortages impacting production schedule adherence."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(issued_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap quantity as a percentage of issued quantity. Primary material yield KPI — directly impacts production cost and is a key IATF 16949 quality metric."
    - name: "avg_wip_cost_per_order"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average WIP cost per production order component record. Benchmarks cost per component and identifies high-cost outliers for cost reduction focus."
    - name: "backflush_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN backflush_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of WIP stock records using backflushing for goods issue. Tracks automation of material consumption posting — higher rates reduce manual transaction burden."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_safety_stock_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy metrics tracking coverage levels, service level targets, demand variability factors, and policy review compliance by plant and SKU. Drives inventory optimization and service level management decisions."
  source: "`vibe_automotive_v1`.`inventory`.`safety_stock_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of safety stock policy (fixed quantity, days of supply, statistical) — segments policies by calculation methodology for benchmarking."
    - name: "safety_stock_policy_status"
      expr: safety_stock_policy_status
      comment: "Status of the policy (active, under review, expired) — filters current vs. outdated policies."
    - name: "safety_stock_method"
      expr: safety_stock_method
      comment: "Calculation method for safety stock (fixed, statistical, demand-driven) — enables method-level performance comparison."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the SKU covered by the policy (active, phase-out, obsolete) — ensures safety stock policies are aligned with product lifecycle."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for which the safety stock policy applies — primary dimension for plant-level inventory buffer management."
    - name: "effective_from"
      expr: effective_from
      comment: "Effective start date of the safety stock policy — tracks policy currency and supports scheduled review compliance."
  measures:
    - name: "total_active_policies"
      expr: COUNT(1)
      comment: "Total number of active safety stock policies. Tracks the breadth of inventory buffer management coverage across the SKU portfolio."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity mandated across all active policies. Represents the aggregate buffer investment — key working capital KPI for supply chain finance."
    - name: "total_maximum_stock_level"
      expr: SUM(CAST(maximum_stock_level AS DOUBLE))
      comment: "Total maximum stock level across all policies. Defines the upper bound of inventory investment — used to calculate maximum working capital exposure."
    - name: "avg_service_level_target"
      expr: AVG(CAST(service_level_target AS DOUBLE))
      comment: "Average service level target (%) across all safety stock policies. Tracks the aggregate service commitment — typically 95-99% in automotive supply chains."
    - name: "avg_demand_variability_factor"
      expr: AVG(CAST(demand_variability_factor AS DOUBLE))
      comment: "Average demand variability factor across all policies. Higher values indicate more volatile demand requiring larger safety buffers — key input for S&OP risk assessment."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across all safety stock policies. Benchmarks trigger levels for replenishment and supports policy optimization."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days factored into safety stock policies. Longer lead times require higher safety stock — tracks the supply chain responsiveness impact on buffer investment."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`inventory_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master SKU catalog metrics for product portfolio analysis"
  source: "`vibe_automotive_v1`.`inventory`.`sku_master`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "sku_count"
      expr: COUNT(1)
      comment: "Number of distinct SKUs"
$$;