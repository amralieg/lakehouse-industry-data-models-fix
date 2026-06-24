-- Metric views for domain: inventory | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for wafer lot inventory — tracks active WIP value, hold exposure, and lot throughput to steer fab capacity and financial risk decisions."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the wafer lot (e.g., active, on-hold, completed) for pipeline segmentation."
    - name: "lot_type"
      expr: lot_type
      comment: "Classification of the lot (production, engineering, qualification) to separate revenue-bearing from non-revenue WIP."
    - name: "process_node"
      expr: process_node
      comment: "Technology node (e.g., 7nm, 28nm) enabling yield and cost analysis by node generation."
    - name: "priority_class"
      expr: priority_class
      comment: "Lot priority tier (hot, normal, cold) for cycle-time and expedite analysis."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology (EUV, DUV) used for capacity and cost segmentation."
    - name: "lot_start_date"
      expr: DATE_TRUNC('month', lot_start_date)
      comment: "Month of lot start for trend analysis of WIP intake volume."
    - name: "process_stage"
      expr: process_stage
      comment: "Current fab process stage (front-end, back-end) for WIP stage distribution analysis."
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean indicating whether the lot is currently on hold, enabling hold exposure segmentation."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lot hold to identify systemic hold drivers."
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency of inventory valuation for multi-currency financial reporting."
  measures:
    - name: "total_wip_lots"
      expr: COUNT(1)
      comment: "Total number of wafer lots in WIP inventory; baseline for fab throughput and capacity utilization."
    - name: "total_inventory_valuation"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total financial value of wafer lot WIP inventory; directly informs balance sheet and working capital decisions."
    - name: "avg_lot_valuation"
      expr: AVG(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Average valuation per wafer lot; used to benchmark cost per lot and detect cost anomalies."
    - name: "lots_on_hold"
      expr: COUNT(CASE WHEN hold_flag = TRUE THEN 1 END)
      comment: "Number of lots currently on hold; high hold counts signal quality or compliance risk requiring executive intervention."
    - name: "hold_valuation_at_risk"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN inventory_valuation_amount ELSE 0 END)
      comment: "Total inventory value tied up in held lots; quantifies financial exposure from quality or compliance holds."
    - name: "hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots currently on hold; a rising hold rate is a leading indicator of fab quality or process excursion."
    - name: "distinct_process_nodes_active"
      expr: COUNT(DISTINCT process_node)
      comment: "Number of distinct technology nodes with active WIP; reflects fab complexity and multi-node capacity demand."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational inventory health KPIs — tracks available, reserved, blocked, and in-transit stock quantities to drive replenishment, allocation, and working capital decisions."
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_type"
      expr: stock_type
      comment: "Stock category (unrestricted, quality inspection, blocked) for availability segmentation."
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known-Good-Die certification status enabling premium die inventory tracking."
    - name: "wafer_process_node"
      expr: wafer_process_node
      comment: "Technology node of the wafer stock for node-level inventory planning."
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Boolean flag for slow-moving stock; drives write-down and obsolescence risk decisions."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance status for regulatory inventory segmentation."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control restriction flag for compliance-gated shipment decisions."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Hazardous material flag for safety and logistics planning."
    - name: "last_goods_receipt_date"
      expr: DATE_TRUNC('month', last_goods_receipt_date)
      comment: "Month of last goods receipt for inbound flow trend analysis."
    - name: "snapshot_timestamp"
      expr: DATE_TRUNC('day', snapshot_timestamp)
      comment: "Daily snapshot date for point-in-time inventory level trending."
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Storage condition requirement (ambient, cold, nitrogen) for facility capacity planning."
  measures:
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total on-hand stock quantity across all locations; primary inventory level KPI for supply planning."
    - name: "total_qty_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for allocation and shipment; directly drives order fulfillment capacity."
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved against open orders; measures demand commitment against stock."
    - name: "total_qty_blocked"
      expr: SUM(CAST(qty_blocked AS DOUBLE))
      comment: "Total quantity blocked (quality hold, compliance); quantifies inventory at risk of write-off."
    - name: "total_qty_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity in transit between locations; informs supply chain pipeline visibility."
    - name: "total_qty_in_wip"
      expr: SUM(CAST(qty_in_wip AS DOUBLE))
      comment: "Total quantity currently in work-in-process; tracks fab-to-finished conversion pipeline."
    - name: "total_qty_quality_inspection"
      expr: SUM(CAST(qty_quality_inspection AS DOUBLE))
      comment: "Total quantity under quality inspection; high values indicate incoming quality bottlenecks."
    - name: "availability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_available AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock that is freely available; a key supply chain health indicator for order fulfillment risk."
    - name: "slow_moving_qty"
      expr: SUM(CASE WHEN slow_moving_flag = TRUE THEN qty_on_hand ELSE 0 END)
      comment: "Total on-hand quantity classified as slow-moving; drives obsolescence provisioning and write-down decisions."
    - name: "safety_stock_coverage_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity maintained; benchmarks buffer inventory investment against demand volatility."
    - name: "reorder_point_qty_total"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Aggregate reorder point quantity; used to assess replenishment trigger levels across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial inventory valuation KPIs — tracks total stock value, cost components, and valuation variance to support balance sheet accuracy, margin analysis, and cost control."
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (standard cost, moving average) for accounting policy segmentation."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (finished goods, WIP, raw material) for balance sheet category analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period financial comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) for monthly close and variance reporting."
    - name: "inventory_category"
      expr: inventory_category
      comment: "Inventory category (wafer, die, packaged) for category-level cost analysis."
    - name: "kgd_status"
      expr: kgd_status
      comment: "KGD certification status for premium inventory valuation segmentation."
    - name: "is_consignment"
      expr: is_consignment
      comment: "Consignment stock flag to separate owned from consigned inventory in financial reporting."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (active, closed, pending) for data quality monitoring."
    - name: "valuation_date"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Month of valuation for trend analysis of inventory value over time."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for regulatory inventory segmentation."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total financial value of all inventory; primary balance sheet inventory asset KPI."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component of inventory; drives BOM cost and procurement efficiency analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost embedded in inventory; informs fab cost absorption and workforce efficiency."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost allocated to inventory; used for overhead absorption rate analysis."
    - name: "total_nre_cost_allocation"
      expr: SUM(CAST(nre_cost_allocation AS DOUBLE))
      comment: "Total NRE cost allocated to inventory; tracks design and engineering cost recovery through product cost."
    - name: "total_wip_cost_accumulation"
      expr: SUM(CAST(wip_cost_accumulation AS DOUBLE))
      comment: "Total cost accumulated in WIP inventory; measures in-process capital tied up in the fab."
    - name: "total_valuation_variance"
      expr: SUM(CAST(valuation_variance AS DOUBLE))
      comment: "Total variance between standard and actual inventory cost; a key financial control metric for cost accuracy."
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price across inventory records; tracks cost trend for procurement and pricing decisions."
    - name: "avg_yield_impact_factor"
      expr: AVG(CAST(yield_impact_factor AS DOUBLE))
      comment: "Average yield impact factor on inventory valuation; quantifies how yield losses translate to inventory cost inflation."
    - name: "total_qty_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand per valuation record; reconciles financial and physical inventory counts."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory flow and transaction KPIs — tracks goods movement volume, value, and reversal rates to monitor supply chain velocity, accuracy, and financial posting integrity."
  source: "`vibe_semiconductors_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "SAP-style movement type code (e.g., 101 GR, 261 GI) for transaction classification and audit."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type at time of movement (unrestricted, quality inspection) for flow analysis by stock category."
    - name: "movement_date"
      expr: DATE_TRUNC('month', movement_date)
      comment: "Month of goods movement for volume and value trend analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of financial posting for period-close reconciliation."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean flag for reversed transactions; high reversal rates signal process or data quality issues."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement (scrap, transfer, return) for root cause analysis of inventory changes."
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification at movement time for storage location flow analysis."
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock type (consignment, project stock) for non-standard inventory flow tracking."
  measures:
    - name: "total_movements"
      expr: COUNT(1)
      comment: "Total number of goods movement transactions; baseline for inventory activity volume and process throughput."
    - name: "total_movement_value"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total financial value of all goods movements; key metric for inventory flow value and financial posting accuracy."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total physical quantity moved across all transactions; measures supply chain throughput volume."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed goods movements; high counts indicate transaction errors or process failures requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements that were reversed; a quality KPI for inventory transaction accuracy and ERP data integrity."
    - name: "avg_movement_value"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average value per goods movement transaction; benchmarks transaction size for anomaly detection."
    - name: "distinct_movement_types"
      expr: COUNT(DISTINCT movement_type)
      comment: "Number of distinct movement types active in the period; reflects inventory process complexity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_die_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Die bank inventory KPIs — tracks KGD die availability, yield, cost, and quality status to steer packaging allocation, customer fulfillment, and die cost management."
  source: "`vibe_semiconductors_v1`.`inventory`.`die_bank`"
  dimensions:
    - name: "die_bank_status"
      expr: die_bank_status
      comment: "Current status of the die bank (available, reserved, depleted) for allocation planning."
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known-Good-Die certification status; critical for premium die allocation and customer commitments."
    - name: "process_node"
      expr: process_node
      comment: "Technology node of the die for node-level inventory and cost analysis."
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification of the die (bin 1, bin 2, etc.) for quality tier segmentation."
    - name: "is_consignment"
      expr: is_consignment
      comment: "Whether the die bank is consignment stock; separates owned from consigned die inventory."
    - name: "is_engineering_sample"
      expr: is_engineering_sample
      comment: "Engineering sample flag to separate revenue-bearing from sample die inventory."
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL classification for storage and handling compliance monitoring."
    - name: "creation_date"
      expr: DATE_TRUNC('month', creation_date)
      comment: "Month of die bank creation for aging and intake trend analysis."
    - name: "esd_sensitivity_class"
      expr: esd_sensitivity_class
      comment: "ESD sensitivity class for handling risk and storage compliance segmentation."
  measures:
    - name: "total_die_banks"
      expr: COUNT(1)
      comment: "Total number of die bank records; baseline for die inventory breadth across nodes and products."
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total unit cost across all die bank records; measures aggregate die inventory cost for financial planning."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per die bank; benchmarks die cost by node and bin for pricing and margin analysis."
    - name: "avg_wafer_probe_yield_pct"
      expr: AVG(CAST(wafer_probe_yield_pct AS DOUBLE))
      comment: "Average wafer probe yield percentage across die banks; a primary quality and cost efficiency KPI for fab performance."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in mm²; informs wafer utilization efficiency and cost-per-die calculations."
    - name: "kgd_certified_banks"
      expr: COUNT(CASE WHEN kgd_status = 'certified' THEN 1 END)
      comment: "Number of die banks with KGD certification; tracks premium die availability for high-reliability customer commitments."
    - name: "engineering_sample_banks"
      expr: COUNT(CASE WHEN is_engineering_sample = TRUE THEN 1 END)
      comment: "Number of engineering sample die banks; monitors non-revenue die inventory consuming storage and cost resources."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_finished_good`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished goods inventory KPIs — tracks packaged IC inventory value, qualification status, and compliance posture to support customer fulfillment, revenue recognition, and regulatory risk management."
  source: "`vibe_semiconductors_v1`.`inventory`.`finished_good`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (available, reserved, blocked, shipped) for fulfillment pipeline analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle stage (active, EOL, LTB) for obsolescence and end-of-life inventory management."
    - name: "package_type"
      expr: package_type
      comment: "Package type (BGA, QFN, etc.) for packaging mix and cost analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family for portfolio-level inventory and revenue analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status (qualified, in-progress, failed) for shipment eligibility and customer commitment risk."
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Temperature grade (commercial, industrial, automotive) for market segment inventory analysis."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for regulatory shipment eligibility."
    - name: "aec_q_qualified"
      expr: aec_q_qualified
      comment: "AEC-Q automotive qualification flag for automotive customer fulfillment eligibility."
    - name: "shelf_life_expiry_date"
      expr: DATE_TRUNC('month', shelf_life_expiry_date)
      comment: "Month of shelf life expiry for proactive obsolescence and write-down planning."
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Valuation method (standard cost, FIFO) for accounting policy segmentation."
  measures:
    - name: "total_finished_goods_records"
      expr: COUNT(1)
      comment: "Total finished goods inventory records; baseline for packaged IC inventory breadth."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost of finished goods inventory; primary balance sheet asset value for packaged ICs."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per finished good record; benchmarks unit cost for pricing and margin decisions."
    - name: "total_dppm_target"
      expr: SUM(CAST(dppm_target AS DOUBLE))
      comment: "Sum of DPPM targets across finished goods; used to assess aggregate quality commitment to customers."
    - name: "avg_dppm_target"
      expr: AVG(CAST(dppm_target AS DOUBLE))
      comment: "Average DPPM target across finished goods; benchmarks quality standard for customer-facing quality commitments."
    - name: "aec_qualified_count"
      expr: COUNT(CASE WHEN aec_q_qualified = TRUE THEN 1 END)
      comment: "Number of finished goods with AEC-Q automotive qualification; tracks automotive-eligible inventory for high-value customer segments."
    - name: "itar_controlled_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled finished goods; quantifies export-restricted inventory requiring compliance oversight."
    - name: "distinct_product_families"
      expr: COUNT(DISTINCT product_family)
      comment: "Number of distinct product families in finished goods inventory; reflects portfolio breadth and complexity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_consignment_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consignment inventory KPIs — tracks consigned stock value, consumption, liability aging, and settlement status to manage supplier and OSAT partner financial obligations."
  source: "`vibe_semiconductors_v1`.`inventory`.`consignment_stock`"
  dimensions:
    - name: "consignment_status"
      expr: consignment_status
      comment: "Current consignment status (active, expired, settled) for liability and settlement pipeline management."
    - name: "consignment_type"
      expr: consignment_type
      comment: "Type of consignment (supplier, OSAT, customer) for partner-level consignment analysis."
    - name: "kgd_status"
      expr: kgd_status
      comment: "KGD status of consigned inventory for premium die consignment tracking."
    - name: "ownership_transfer_trigger"
      expr: ownership_transfer_trigger
      comment: "Trigger event for ownership transfer (consumption, shipment) for liability recognition timing."
    - name: "reconciliation_frequency"
      expr: reconciliation_frequency
      comment: "Reconciliation cadence (weekly, monthly) for settlement process compliance monitoring."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance of consigned stock for regulatory eligibility."
    - name: "consignment_start_date"
      expr: DATE_TRUNC('month', consignment_start_date)
      comment: "Month consignment agreement started for aging and liability trend analysis."
    - name: "consignment_expiry_date"
      expr: DATE_TRUNC('month', consignment_expiry_date)
      comment: "Month of consignment expiry for proactive liability management."
  measures:
    - name: "total_consignment_records"
      expr: COUNT(1)
      comment: "Total consignment stock records; baseline for consignment program scope and partner exposure."
    - name: "total_consigned_quantity"
      expr: SUM(CAST(consigned_quantity AS DOUBLE))
      comment: "Total quantity of consigned stock; measures aggregate consignment pipeline volume."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available consignment quantity; drives consumption planning and replenishment decisions."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed from consignment; measures consignment utilization and supplier liability reduction."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total quantity returned to consignment supplier; tracks return activity and associated cost credits."
    - name: "total_valuation_amount"
      expr: SUM(CAST(total_valuation_amount AS DOUBLE))
      comment: "Total financial value of consignment stock on hand; quantifies off-balance-sheet liability exposure."
    - name: "consumption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(consumed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(consigned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of consigned stock consumed; low rates signal excess consignment liability and potential write-back risk."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per consignment record; benchmarks consignment unit cost for supplier negotiation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory hold management KPIs — tracks hold volume, financial exposure, and resolution velocity to manage quality risk, compliance holds, and customer impact."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current hold status (open, released, escalated) for hold pipeline management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (quality, compliance, engineering) for root cause and resolution routing."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Specific reason code for the hold to identify systemic hold drivers."
    - name: "hold_priority"
      expr: hold_priority
      comment: "Priority level of the hold (critical, high, normal) for escalation and resource allocation."
    - name: "is_regulatory_hold"
      expr: is_regulatory_hold
      comment: "Boolean flag for regulatory holds; these carry highest compliance risk and require executive visibility."
    - name: "hold_disposition"
      expr: hold_disposition
      comment: "Disposition decision (use-as-is, rework, scrap) for material review outcome analysis."
    - name: "hold_date"
      expr: DATE_TRUNC('month', hold_date)
      comment: "Month hold was initiated for trend analysis of hold frequency and seasonality."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification for systemic quality improvement and CAPA prioritization."
  measures:
    - name: "total_active_holds"
      expr: COUNT(1)
      comment: "Total inventory lot holds; baseline for quality and compliance hold exposure across the inventory."
    - name: "regulatory_holds"
      expr: COUNT(CASE WHEN is_regulatory_hold = TRUE THEN 1 END)
      comment: "Number of regulatory holds; these carry highest compliance and shipment risk requiring immediate executive action."
    - name: "total_dppm_value"
      expr: SUM(CAST(dppm_value AS DOUBLE))
      comment: "Total DPPM value associated with held lots; quantifies quality defect density driving hold decisions."
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average DPPM value per hold record; benchmarks defect severity across hold events."
    - name: "regulatory_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_hold = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that are regulatory in nature; a compliance risk KPI for export control and trade compliance monitoring."
    - name: "distinct_hold_reason_codes"
      expr: COUNT(DISTINCT hold_reason_code)
      comment: "Number of distinct hold reason codes active; high diversity signals systemic quality issues requiring process investigation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_physical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count accuracy KPIs — tracks count variance, tolerance breaches, and recount rates to ensure inventory record accuracy and SOX financial control compliance."
  source: "`vibe_semiconductors_v1`.`inventory`.`physical_inventory`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the physical count (in-progress, completed, approved) for count cycle management."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (cycle count, annual, spot check) for count program analysis."
    - name: "inventory_category"
      expr: inventory_category
      comment: "Inventory category (wafer, die, finished good) for category-level accuracy analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual inventory accuracy reporting and SOX compliance."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly count accuracy trending."
    - name: "variance_exceeds_tolerance_flag"
      expr: variance_exceeds_tolerance_flag
      comment: "Boolean flag for counts where variance exceeds tolerance; drives recount and investigation decisions."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Boolean flag indicating a recount was required; high recount rates signal counting process quality issues."
    - name: "count_date"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month of physical count for trend analysis of count activity and accuracy."
    - name: "kgd_status"
      expr: kgd_status
      comment: "KGD status of counted inventory for premium die count accuracy monitoring."
  measures:
    - name: "total_count_records"
      expr: COUNT(1)
      comment: "Total physical inventory count records; baseline for count program coverage and activity."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between book and physical count; primary inventory accuracy KPI for SOX and audit compliance."
    - name: "total_variance_value_usd"
      expr: SUM(CAST(variance_value_usd AS DOUBLE))
      comment: "Total financial value of inventory variance; directly impacts balance sheet accuracy and SOX financial controls."
    - name: "tolerance_breach_count"
      expr: COUNT(CASE WHEN variance_exceeds_tolerance_flag = TRUE THEN 1 END)
      comment: "Number of count records where variance exceeds tolerance; triggers mandatory investigation and recount per audit policy."
    - name: "tolerance_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_exceeds_tolerance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts with out-of-tolerance variance; a SOX control KPI — high rates require escalation to finance and audit."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring a recount; measures counting process quality and first-time accuracy."
    - name: "avg_variance_tolerance_pct"
      expr: AVG(CAST(variance_tolerance_pct AS DOUBLE))
      comment: "Average variance tolerance percentage applied across counts; benchmarks tolerance policy stringency."
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book quantity across all count records; denominator for inventory accuracy rate calculations."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physically counted quantity; compared against book quantity to derive inventory accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_kgd_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KGD certification quality KPIs — tracks probe yield, electrical test pass rates, DPPM, and certification status for Known-Good-Die inventory to support premium die customer commitments."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "KGD certification status (certified, pending, failed, expired) for die eligibility management."
    - name: "kgd_grade"
      expr: kgd_grade
      comment: "KGD quality grade for premium tier segmentation and customer allocation."
    - name: "burn_in_test_result"
      expr: burn_in_test_result
      comment: "Burn-in test outcome for reliability screening effectiveness analysis."
    - name: "reliability_screen_result"
      expr: reliability_screen_result
      comment: "Reliability screening result for quality gate pass/fail analysis."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Boolean flag for KGD lots on quality hold; tracks certification pipeline blockages."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export-restricted KGD inventory."
    - name: "certification_date"
      expr: DATE_TRUNC('month', certification_date)
      comment: "Month of KGD certification for throughput and backlog trend analysis."
    - name: "certification_expiry_date"
      expr: DATE_TRUNC('month', certification_expiry_date)
      comment: "Month of certification expiry for proactive recertification planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total KGD certification records; baseline for KGD program throughput and inventory coverage."
    - name: "avg_probe_yield_pct"
      expr: AVG(CAST(probe_yield_pct AS DOUBLE))
      comment: "Average probe yield percentage across KGD certifications; primary quality KPI for die bank value and customer commitment reliability."
    - name: "avg_electrical_test_pass_rate_pct"
      expr: AVG(CAST(electrical_test_pass_rate_pct AS DOUBLE))
      comment: "Average electrical test pass rate; measures KGD screening effectiveness and die quality consistency."
    - name: "avg_dppm_rate"
      expr: AVG(CAST(dppm_rate AS DOUBLE))
      comment: "Average DPPM rate across KGD certifications; directly tied to customer quality commitments and warranty risk."
    - name: "total_dppm_rate"
      expr: SUM(CAST(dppm_rate AS DOUBLE))
      comment: "Sum of DPPM rates for aggregate defect exposure analysis across the KGD portfolio."
    - name: "quality_hold_count"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN 1 END)
      comment: "Number of KGD certifications on quality hold; measures certification pipeline blockage and customer delivery risk."
    - name: "quality_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KGD certifications on quality hold; a leading indicator of KGD supply risk to premium customers."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_photomask_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Photomask asset management KPIs — tracks mask valuation, usage, defect status, and lifecycle to manage NRE cost recovery, mask quality, and reticle availability for production."
  source: "`vibe_semiconductors_v1`.`inventory`.`photomask_asset`"
  dimensions:
    - name: "mask_status"
      expr: mask_status
      comment: "Current mask status (active, retired, quarantined) for production availability management."
    - name: "mask_type"
      expr: mask_type
      comment: "Mask type (reticle, pellicle, binary) for asset category analysis."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology (EUV, DUV, i-line) for mask fleet capacity planning."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node the mask supports for node-level asset inventory analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Mask inspection status (pass, fail, pending) for quality gate management."
    - name: "pellicle_present"
      expr: pellicle_present
      comment: "Boolean flag for pellicle presence; pellicle-equipped masks have different handling and cost profiles."
    - name: "is_mpw_mask"
      expr: is_mpw_mask
      comment: "Multi-project wafer mask flag for shared NRE cost allocation analysis."
    - name: "manufacture_date"
      expr: DATE_TRUNC('month', manufacture_date)
      comment: "Month of mask manufacture for fleet age and lifecycle analysis."
    - name: "mask_substrate_material"
      expr: mask_substrate_material
      comment: "Substrate material (quartz, chrome) for material cost and quality segmentation."
  measures:
    - name: "total_mask_assets"
      expr: COUNT(1)
      comment: "Total photomask assets in inventory; baseline for mask fleet size and production capacity coverage."
    - name: "total_asset_valuation_usd"
      expr: SUM(CAST(asset_valuation_usd AS DOUBLE))
      comment: "Total financial value of photomask assets; a significant capital asset KPI for semiconductor fabs."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost invested in photomask assets; tracks design-to-mask cost recovery and customer NRE billing."
    - name: "avg_asset_valuation_usd"
      expr: AVG(CAST(asset_valuation_usd AS DOUBLE))
      comment: "Average mask asset value; benchmarks per-mask investment for technology node cost analysis."
    - name: "avg_cd_uniformity_nm"
      expr: AVG(CAST(cd_uniformity_nm AS DOUBLE))
      comment: "Average critical dimension uniformity in nm; a key mask quality KPI directly impacting wafer yield."
    - name: "avg_registration_error_nm"
      expr: AVG(CAST(registration_error_nm AS DOUBLE))
      comment: "Average mask registration error in nm; high values indicate mask quality degradation requiring replacement."
    - name: "avg_meef_value"
      expr: AVG(CAST(meef_value AS DOUBLE))
      comment: "Average Mask Error Enhancement Factor; measures mask-to-wafer pattern fidelity for process window management."
    - name: "avg_mask_size_mm"
      expr: AVG(CAST(mask_size_mm AS DOUBLE))
      comment: "Average mask size in mm; informs scanner compatibility and storage capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_raw_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Raw material inventory KPIs — tracks material cost, qualification status, compliance posture, and stock levels to manage fab supply continuity and regulatory risk."
  source: "`vibe_semiconductors_v1`.`inventory`.`raw_material`"
  dimensions:
    - name: "material_status"
      expr: material_status
      comment: "Material lifecycle status (active, discontinued, blocked) for supply continuity risk management."
    - name: "material_class"
      expr: material_class
      comment: "Material classification (chemical, substrate, gas, metal) for category-level supply analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group for procurement category management and spend analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Supplier qualification status for approved vendor list compliance."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for regulatory material eligibility."
    - name: "reach_svhc_flag"
      expr: reach_svhc_flag
      comment: "REACH SVHC substance flag for hazardous material compliance monitoring."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export-restricted raw materials."
    - name: "wafer_type"
      expr: wafer_type
      comment: "Wafer substrate type (silicon, SOI, GaN) for substrate inventory segmentation."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage condition for facility capacity and compliance planning."
    - name: "price_control_type"
      expr: price_control_type
      comment: "Price control method (standard, moving average) for cost accounting segmentation."
  measures:
    - name: "total_raw_materials"
      expr: COUNT(1)
      comment: "Total raw material records; baseline for material portfolio breadth and supply complexity."
    - name: "total_standard_price"
      expr: SUM(CAST(standard_price AS DOUBLE))
      comment: "Total standard price across raw materials; measures aggregate material cost base for procurement spend analysis."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price per raw material; benchmarks unit material cost for procurement efficiency."
    - name: "avg_moving_avg_price"
      expr: AVG(CAST(moving_avg_price AS DOUBLE))
      comment: "Average moving average price; tracks actual material cost trends for variance analysis against standard."
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_pct AS DOUBLE))
      comment: "Average material purity percentage; a critical quality KPI for process chemicals and substrates affecting yield."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across raw materials; measures supply buffer investment against demand volatility."
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Total reorder point quantity; used to assess replenishment trigger levels and supply continuity risk."
    - name: "reach_svhc_material_count"
      expr: COUNT(CASE WHEN reach_svhc_flag = TRUE THEN 1 END)
      comment: "Number of raw materials classified as REACH SVHC substances; quantifies regulatory compliance exposure and substitution priority."
    - name: "avg_wafer_diameter_mm"
      expr: AVG(CAST(wafer_diameter_mm AS DOUBLE))
      comment: "Average wafer diameter in mm; tracks substrate size mix (200mm vs 300mm) for fab equipment compatibility planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation KPIs — tracks reserved quantity, reservation fulfillment, and expiration risk to manage order allocation accuracy and customer delivery commitments."
  source: "`vibe_semiconductors_v1`.`inventory`.`reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current reservation status (open, fulfilled, expired, cancelled) for allocation pipeline management."
    - name: "reservation_type"
      expr: reservation_type
      comment: "Type of reservation (sales order, production, transfer) for demand source analysis."
    - name: "priority"
      expr: priority
      comment: "Reservation priority for allocation sequencing and customer commitment management."
    - name: "is_kgd"
      expr: is_kgd
      comment: "Boolean flag for KGD reservations; tracks premium die allocation commitments."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status at time of reservation for stock quality segmentation."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery for demand timing and fulfillment planning."
    - name: "reservation_timestamp"
      expr: DATE_TRUNC('month', reservation_timestamp)
      comment: "Month reservation was created for intake trend analysis."
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification of reserved inventory for quality tier allocation analysis."
  measures:
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total inventory reservations; baseline for demand commitment volume against available stock."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved across all open reservations; measures committed inventory against available supply."
    - name: "avg_reserved_quantity"
      expr: AVG(CAST(reserved_quantity AS DOUBLE))
      comment: "Average reserved quantity per reservation; benchmarks order size for allocation planning."
    - name: "kgd_reserved_quantity"
      expr: SUM(CASE WHEN is_kgd = TRUE THEN reserved_quantity ELSE 0 END)
      comment: "Total quantity reserved for KGD orders; tracks premium die allocation commitment to high-value customers."
    - name: "kgd_reservation_count"
      expr: COUNT(CASE WHEN is_kgd = TRUE THEN 1 END)
      comment: "Number of KGD reservations; measures premium die demand pipeline for supply planning."
    - name: "distinct_demand_sources"
      expr: COUNT(DISTINCT reservation_type)
      comment: "Number of distinct reservation types active; reflects demand source diversity for allocation policy design."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location capacity and compliance KPIs — tracks facility utilization, environmental compliance, and special capability coverage to manage fab storage infrastructure investment."
  source: "`vibe_semiconductors_v1`.`inventory`.`storage_location`"
  dimensions:
    - name: "location_status"
      expr: location_status
      comment: "Current status of the storage location (active, decommissioned, under maintenance) for capacity planning."
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type (cleanroom, warehouse, vault) for storage infrastructure segmentation."
    - name: "cleanroom_iso_class"
      expr: cleanroom_iso_class
      comment: "ISO cleanroom classification for contamination-sensitive inventory storage compliance."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR-controlled location flag for export-restricted inventory storage compliance."
    - name: "kgd_storage_certified"
      expr: kgd_storage_certified
      comment: "KGD storage certification flag for premium die storage eligibility."
    - name: "photomask_storage_capable"
      expr: photomask_storage_capable
      comment: "Photomask storage capability flag for reticle and mask asset management."
    - name: "nitrogen_purge_capable"
      expr: nitrogen_purge_capable
      comment: "Nitrogen purge capability for moisture-sensitive device storage compliance."
    - name: "is_osat_partner_location"
      expr: is_osat_partner_location
      comment: "OSAT partner location flag for outsourced assembly inventory tracking."
    - name: "commissioned_date"
      expr: DATE_TRUNC('year', commissioned_date)
      comment: "Year location was commissioned for fleet age and capital refresh planning."
  measures:
    - name: "total_storage_locations"
      expr: COUNT(1)
      comment: "Total storage locations; baseline for storage infrastructure capacity and coverage."
    - name: "total_weight_capacity_kg"
      expr: SUM(CAST(weight_capacity_kg AS DOUBLE))
      comment: "Total weight capacity across all storage locations; measures aggregate physical storage capacity for inventory planning."
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum temperature threshold across locations; benchmarks environmental control capability for sensitive materials."
    - name: "avg_max_humidity_pct"
      expr: AVG(CAST(max_humidity_pct AS DOUBLE))
      comment: "Average maximum humidity threshold; measures environmental control capability for moisture-sensitive inventory."
    - name: "kgd_certified_locations"
      expr: COUNT(CASE WHEN kgd_storage_certified = TRUE THEN 1 END)
      comment: "Number of KGD-certified storage locations; measures premium die storage capacity for high-value inventory."
    - name: "photomask_capable_locations"
      expr: COUNT(CASE WHEN photomask_storage_capable = TRUE THEN 1 END)
      comment: "Number of photomask-capable storage locations; tracks reticle storage capacity for fab production continuity."
    - name: "itar_controlled_locations"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Number of ITAR-controlled storage locations; quantifies export-restricted storage infrastructure for compliance management."
    - name: "nitrogen_purge_locations"
      expr: COUNT(CASE WHEN nitrogen_purge_capable = TRUE THEN 1 END)
      comment: "Number of nitrogen-purge-capable locations; measures MSD and moisture-sensitive storage capacity for fab operations."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_lot_genealogy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot genealogy traceability KPIs — tracks material transformation yield, scrap, and quality holds across the lot lineage to support root cause analysis, customer traceability, and yield improvement."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy`"
  dimensions:
    - name: "genealogy_status"
      expr: genealogy_status
      comment: "Status of the genealogy record (active, closed, flagged) for traceability completeness monitoring."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of parent-child relationship (split, merge, transform) for material flow analysis."
    - name: "child_entity_type"
      expr: child_entity_type
      comment: "Type of child entity (wafer lot, die bank, finished good) for cross-stage traceability."
    - name: "parent_entity_type"
      expr: parent_entity_type
      comment: "Type of parent entity for upstream traceability and root cause propagation analysis."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Boolean flag for genealogy records with quality holds; identifies contaminated lineage chains."
    - name: "kgd_status"
      expr: kgd_status
      comment: "KGD status at transformation point for premium die lineage tracking."
    - name: "transformation_timestamp"
      expr: DATE_TRUNC('month', transformation_timestamp)
      comment: "Month of material transformation for genealogy activity trend analysis."
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code for scrap at transformation for yield loss root cause analysis."
  measures:
    - name: "total_genealogy_records"
      expr: COUNT(1)
      comment: "Total lot genealogy records; baseline for traceability coverage across the inventory."
    - name: "total_quantity_in"
      expr: SUM(CAST(quantity_in AS DOUBLE))
      comment: "Total input quantity across all transformations; measures material intake volume through the production chain."
    - name: "total_quantity_out"
      expr: SUM(CAST(quantity_out AS DOUBLE))
      comment: "Total output quantity across all transformations; measures material yield through the production chain."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrapped quantity across all transformations; quantifies material loss for cost and yield improvement decisions."
    - name: "avg_yield_at_transformation_pct"
      expr: AVG(CAST(yield_at_transformation_pct AS DOUBLE))
      comment: "Average yield percentage at each transformation step; a primary operational KPI for production efficiency and cost management."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_in AS DOUBLE)), 0), 2)
      comment: "Overall scrap rate as percentage of input quantity; directly tied to material cost efficiency and fab yield performance."
    - name: "quality_hold_genealogy_count"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN 1 END)
      comment: "Number of genealogy records with quality holds; measures contaminated lineage exposure requiring customer notification assessment."
$$;