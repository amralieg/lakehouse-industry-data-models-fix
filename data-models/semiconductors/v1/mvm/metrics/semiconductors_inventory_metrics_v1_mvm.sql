-- Metric views for domain: inventory | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic wafer lot inventory KPIs tracking WIP valuation, cycle time, yield performance, and operational efficiency across the fab"
  source: "`semiconductors_ecm`.`inventory`.`inventory_wafer_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the wafer lot (e.g., in-process, completed, on-hold)"
    - name: "lot_type"
      expr: lot_type
      comment: "Type classification of the wafer lot (e.g., production, engineering, qualification)"
    - name: "process_stage"
      expr: process_stage
      comment: "Current fabrication process stage of the wafer lot"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification for scheduling and resource allocation"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the lot is currently on quality or compliance hold"
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter in millimeters (e.g., 200mm, 300mm)"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (e.g., DUV, EUV)"
    - name: "lot_start_month"
      expr: DATE_TRUNC('MONTH', lot_start_date)
      comment: "Month when the wafer lot was started in fabrication"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Target month for lot completion"
  measures:
    - name: "total_wip_valuation"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total work-in-process inventory valuation across all wafer lots"
    - name: "avg_wip_valuation_per_lot"
      expr: AVG(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Average WIP valuation per wafer lot, indicating capital intensity"
    - name: "total_wafer_count"
      expr: SUM(CAST(wafer_count_current AS DOUBLE))
      comment: "Total number of wafers currently in process across all lots"
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(actual_completion_date, lot_start_date))
      comment: "Average fabrication cycle time in days from lot start to completion"
    - name: "wafer_scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_wafer_count AS DOUBLE)) / NULLIF(SUM(CAST(wafer_count_start AS DOUBLE)), 0), 2)
      comment: "Percentage of wafers scrapped during fabrication, key quality and yield metric"
    - name: "lots_on_hold_count"
      expr: SUM(CASE WHEN hold_flag = true THEN 1 ELSE 0 END)
      comment: "Number of lots currently on hold due to quality or compliance issues"
    - name: "lots_behind_schedule_count"
      expr: SUM(CASE WHEN actual_completion_date > target_completion_date THEN 1 ELSE 0 END)
      comment: "Number of lots that completed behind target schedule, indicating execution risk"
    - name: "distinct_lot_count"
      expr: COUNT(DISTINCT inventory_wafer_lot_id)
      comment: "Distinct count of wafer lots for volume and throughput analysis"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_finished_good`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished goods inventory KPIs tracking stock valuation, turnover, compliance, and lifecycle risk for packaged semiconductor products"
  source: "`semiconductors_ecm`.`inventory`.`finished_good`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status (e.g., available, reserved, blocked, obsolete)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle stage (e.g., active, mature, end-of-life, discontinued)"
    - name: "package_type"
      expr: package_type
      comment: "Semiconductor package type (e.g., QFN, BGA, TSSOP)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the finished good was manufactured"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulatory adherence"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag for defense-related products"
    - name: "aec_q_qualified"
      expr: aec_q_qualified
      comment: "AEC-Q automotive qualification status for automotive-grade products"
    - name: "msd_level"
      expr: msd_level
      comment: "Moisture sensitivity level (MSL) classification for handling and storage"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status indicating pre-tested die quality"
    - name: "eol_month"
      expr: DATE_TRUNC('MONTH', eol_date)
      comment: "Month of end-of-life date for lifecycle planning"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(standard_cost AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE))
      comment: "Total finished goods inventory valuation at standard cost"
    - name: "avg_unit_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per finished good unit"
    - name: "total_units_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of finished goods units in inventory"
    - name: "eol_inventory_value"
      expr: SUM(CASE WHEN lifecycle_status IN ('end-of-life', 'discontinued') THEN CAST(standard_cost AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE) ELSE 0 END)
      comment: "Inventory value of end-of-life or discontinued products, indicating obsolescence risk"
    - name: "eol_inventory_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lifecycle_status IN ('end-of-life', 'discontinued') THEN CAST(standard_cost AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(standard_cost AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of total inventory value in end-of-life products, key obsolescence metric"
    - name: "non_compliant_inventory_value"
      expr: SUM(CASE WHEN rohs_compliant = false OR itar_controlled = true THEN CAST(standard_cost AS DOUBLE) * CAST(quantity_on_hand AS DOUBLE) ELSE 0 END)
      comment: "Inventory value of non-RoHS or ITAR-controlled products requiring special handling"
    - name: "shelf_life_expired_units"
      expr: SUM(CASE WHEN shelf_life_expiry_date < CURRENT_DATE THEN CAST(quantity_on_hand AS DOUBLE) ELSE 0 END)
      comment: "Units with expired shelf life requiring disposition or rework"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Distinct count of SKUs in finished goods inventory for portfolio complexity analysis"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time stock balance KPIs tracking inventory availability, utilization, aging, and operational efficiency across all stock types"
  source: "`semiconductors_ecm`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g., unrestricted, blocked, quality inspection, consignment)"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for die or wafer quality grading"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status for pre-tested inventory"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicator for special stock types (e.g., consignment, project stock)"
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Flag indicating slow-moving inventory requiring attention"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control flag for trade compliance"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag for environmental regulations"
    - name: "msd_level"
      expr: msd_level
      comment: "Moisture sensitivity level classification"
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Storage condition requirements code"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of the stock balance snapshot for trend analysis"
  measures:
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity of inventory on hand across all stock types"
    - name: "total_qty_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for allocation and shipment"
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved for customer orders or production"
    - name: "total_qty_blocked"
      expr: SUM(CAST(qty_blocked AS DOUBLE))
      comment: "Total quantity blocked due to quality or compliance holds"
    - name: "inventory_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_available AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory available for use, key operational efficiency metric"
    - name: "inventory_utilization_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(qty_reserved AS DOUBLE)) + SUM(CAST(qty_in_wip AS DOUBLE))) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory actively utilized in orders or WIP"
    - name: "blocked_inventory_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_blocked AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of inventory blocked, indicating quality or compliance issues"
    - name: "avg_stock_aging_days"
      expr: AVG(CAST(stock_aging_days AS DOUBLE))
      comment: "Average age of inventory in days, indicating turnover velocity"
    - name: "slow_moving_inventory_qty"
      expr: SUM(CASE WHEN slow_moving_flag = true THEN CAST(qty_on_hand AS DOUBLE) ELSE 0 END)
      comment: "Quantity of slow-moving inventory requiring disposition action"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT primary_stock_material_master_id)
      comment: "Distinct count of materials in stock for portfolio complexity"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods movement transaction KPIs tracking inventory flow velocity, transaction volume, and operational efficiency across the supply chain"
  source: "`semiconductors_ecm`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (e.g., goods receipt, goods issue, transfer, return)"
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type involved in the movement"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the goods movement transaction"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the transaction is a reversal"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator (e.g., consignment, project stock)"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for quality grading"
    - name: "source_plant_code"
      expr: source_plant_code
      comment: "Source plant code for inter-plant transfers"
    - name: "destination_plant_code"
      expr: destination_plant_code
      comment: "Destination plant code for inter-plant transfers"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month of the goods movement for trend analysis"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the movement was posted to financials"
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_movement_value"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of all goods movements"
    - name: "avg_movement_value"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation per goods movement transaction"
    - name: "total_transaction_count"
      expr: COUNT(goods_movement_id)
      comment: "Total number of goods movement transactions for volume analysis"
    - name: "reversal_transaction_count"
      expr: SUM(CASE WHEN reversal_indicator = true THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions indicating process errors or corrections"
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(goods_movement_id), 0), 2)
      comment: "Percentage of transactions that are reversals, key data quality and process efficiency metric"
    - name: "inter_plant_transfer_count"
      expr: SUM(CASE WHEN source_plant_code IS NOT NULL AND destination_plant_code IS NOT NULL AND source_plant_code != destination_plant_code THEN 1 ELSE 0 END)
      comment: "Number of inter-plant transfer transactions for supply chain coordination analysis"
    - name: "distinct_sku_moved_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Distinct count of SKUs involved in movements for activity breadth"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_die_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Die bank inventory KPIs tracking unpackaged die availability, yield performance, quality status, and valuation for assembly operations"
  source: "`semiconductors_ecm`.`inventory`.`die_bank`"
  dimensions:
    - name: "die_bank_status"
      expr: die_bank_status
      comment: "Current status of the die bank (e.g., available, reserved, on-hold, scrapped)"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification indicating die quality grade"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status for pre-tested die"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier used for die storage (e.g., waffle pack, gel pack)"
    - name: "is_engineering_sample"
      expr: is_engineering_sample
      comment: "Indicates whether the die bank contains engineering samples"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Indicates whether the die are held on consignment"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulations"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "Moisture sensitivity level classification"
    - name: "quality_hold_reason"
      expr: quality_hold_reason
      comment: "Reason for quality hold if applicable"
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month when the die bank was created"
  measures:
    - name: "total_die_inventory_value"
      expr: SUM(CAST(unit_cost AS DOUBLE) * CAST(quantity_available AS DOUBLE))
      comment: "Total inventory valuation of available die at unit cost"
    - name: "avg_die_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per die for cost analysis"
    - name: "total_die_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity of die available for assembly operations"
    - name: "total_die_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity of die reserved for specific orders or projects"
    - name: "total_die_scrapped"
      expr: SUM(CAST(quantity_scrapped AS DOUBLE))
      comment: "Total quantity of die scrapped due to quality issues"
    - name: "die_scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_scrapped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_initial AS DOUBLE)), 0), 2)
      comment: "Percentage of initial die quantity scrapped, key yield and quality metric"
    - name: "avg_wafer_probe_yield_pct"
      expr: AVG(CAST(wafer_probe_yield_pct AS DOUBLE))
      comment: "Average wafer probe yield percentage across die banks, indicating test performance"
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters for cost and yield modeling"
    - name: "distinct_die_bank_count"
      expr: COUNT(DISTINCT die_bank_id)
      comment: "Distinct count of die banks for inventory complexity analysis"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_consignment_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consignment inventory KPIs tracking liability exposure, consumption velocity, settlement performance, and compliance for supplier-owned inventory"
  source: "`semiconductors_ecm`.`inventory`.`consignment_stock`"
  dimensions:
    - name: "consignment_status"
      expr: consignment_status
      comment: "Current status of consignment stock (e.g., active, consumed, expired, returned)"
    - name: "consignment_type"
      expr: consignment_type
      comment: "Type of consignment arrangement (e.g., vendor-managed, customer-managed)"
    - name: "ownership_transfer_trigger"
      expr: ownership_transfer_trigger
      comment: "Event that triggers ownership transfer from supplier to company"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status"
    - name: "liability_aging_days"
      expr: liability_aging_days
      comment: "Aging category of consignment liability"
    - name: "consignment_start_month"
      expr: DATE_TRUNC('MONTH', consignment_start_date)
      comment: "Month when consignment arrangement started"
    - name: "consignment_expiry_month"
      expr: DATE_TRUNC('MONTH', consignment_expiry_date)
      comment: "Month when consignment arrangement expires"
  measures:
    - name: "total_consignment_liability"
      expr: SUM(CAST(total_valuation_amount AS DOUBLE))
      comment: "Total financial liability for consignment stock, key balance sheet metric"
    - name: "total_consigned_quantity"
      expr: SUM(CAST(consigned_quantity AS DOUBLE))
      comment: "Total quantity of inventory held on consignment"
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed from consignment stock"
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total quantity available for consumption from consignment"
    - name: "consignment_consumption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(consumed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(consigned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of consigned inventory consumed, indicating utilization efficiency"
    - name: "avg_consignment_unit_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per consignment unit for liability valuation"
    - name: "expired_consignment_value"
      expr: SUM(CASE WHEN consignment_expiry_date < CURRENT_DATE THEN CAST(total_valuation_amount AS DOUBLE) ELSE 0 END)
      comment: "Value of expired consignment stock requiring settlement or return"
    - name: "overdue_settlement_count"
      expr: SUM(CASE WHEN last_settlement_date < DATE_SUB(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of consignment items with settlements overdue by more than 90 days"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Distinct count of suppliers providing consignment stock for relationship management"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory hold KPIs tracking quality containment effectiveness, hold resolution velocity, and regulatory compliance impact on inventory availability"
  source: "`semiconductors_ecm`.`inventory`.`inventory_lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the inventory hold (e.g., active, released, expired)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (e.g., quality, compliance, engineering, supplier)"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardized reason code for the hold"
    - name: "hold_disposition"
      expr: hold_disposition
      comment: "Disposition decision for held inventory (e.g., release, scrap, rework, return)"
    - name: "hold_priority"
      expr: hold_priority
      comment: "Priority level of the hold for resolution sequencing"
    - name: "is_regulatory_hold"
      expr: is_regulatory_hold
      comment: "Indicates whether the hold is due to regulatory compliance issues"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification for the hold"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification if hold is trade-compliance related"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', hold_date)
      comment: "Month when the hold was initiated"
    - name: "hold_release_month"
      expr: DATE_TRUNC('MONTH', hold_release_date)
      comment: "Month when the hold was released"
  measures:
    - name: "total_hold_count"
      expr: COUNT(inventory_lot_hold_id)
      comment: "Total number of inventory holds for volume and trend analysis"
    - name: "active_hold_count"
      expr: SUM(CASE WHEN hold_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active holds impacting inventory availability"
    - name: "regulatory_hold_count"
      expr: SUM(CASE WHEN is_regulatory_hold = true THEN 1 ELSE 0 END)
      comment: "Number of holds due to regulatory compliance issues"
    - name: "total_wafer_quantity_held"
      expr: SUM(CAST(wafer_quantity AS DOUBLE))
      comment: "Total quantity of wafers currently on hold"
    - name: "total_die_quantity_held"
      expr: SUM(CAST(die_quantity AS DOUBLE))
      comment: "Total quantity of die currently on hold"
    - name: "avg_hold_resolution_days"
      expr: AVG(DATEDIFF(hold_release_date, hold_date))
      comment: "Average number of days to resolve and release a hold, key process efficiency metric"
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average defects per million parts for held lots, indicating quality severity"
    - name: "overdue_hold_count"
      expr: SUM(CASE WHEN hold_expiration_date < CURRENT_DATE AND hold_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of holds that have exceeded their expiration date without resolution"
    - name: "distinct_product_family_count"
      expr: COUNT(DISTINCT family_id)
      comment: "Distinct count of product families affected by holds for impact breadth analysis"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory valuation KPIs tracking financial accuracy, cost structure, valuation variance, and compliance for financial reporting and SOX controls"
  source: "`semiconductors_ecm`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g., standard cost, moving average, FIFO)"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (e.g., book, market, lower-of-cost-or-market)"
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (e.g., active, adjusted, closed)"
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory (e.g., raw material, WIP, finished goods)"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for financial reporting segmentation"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Indicates whether the inventory is held on consignment"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Sarbanes-Oxley control flag for financial audit compliance"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for quality-based valuation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the valuation"
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total inventory valuation across all categories and methods"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component of inventory valuation"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component of inventory valuation"
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component of inventory valuation"
    - name: "total_nre_cost_allocation"
      expr: SUM(CAST(nre_cost_allocation AS DOUBLE))
      comment: "Total non-recurring engineering cost allocated to inventory"
    - name: "total_valuation_variance"
      expr: SUM(CAST(valuation_variance AS DOUBLE))
      comment: "Total variance between standard and actual valuation, key financial accuracy metric"
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price per unit across inventory"
    - name: "avg_moving_average_price"
      expr: AVG(CAST(moving_average_price AS DOUBLE))
      comment: "Average moving average price per unit for cost trend analysis"
    - name: "valuation_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(valuation_variance AS DOUBLE)) / NULLIF(SUM(CAST(total_stock_value AS DOUBLE)), 0), 2)
      comment: "Percentage variance between standard and actual valuation, indicating costing accuracy"
    - name: "distinct_valuation_record_count"
      expr: COUNT(DISTINCT stock_valuation_id)
      comment: "Distinct count of valuation records for audit trail completeness"
$$;