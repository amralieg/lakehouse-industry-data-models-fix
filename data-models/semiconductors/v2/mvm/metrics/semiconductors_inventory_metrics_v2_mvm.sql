-- Metric views for domain: inventory | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_die_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Die bank inventory KPIs tracking available die inventory, valuation, and quality metrics for semiconductor wafer die storage"
  source: "`vibe_semiconductors_v1`.`inventory`.`die_bank`"
  dimensions:
    - name: "die_bank_status"
      expr: die_bank_status
      comment: "Current status of the die bank (e.g., available, reserved, quarantined)"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier used for die storage and transport"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status indicating quality verification level"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL rating indicating moisture sensitivity classification"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Flag indicating whether die bank is held on consignment"
    - name: "is_engineering_sample"
      expr: is_engineering_sample
      comment: "Flag indicating whether die are engineering samples vs production"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulations"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for chemical substance regulations"
    - name: "esd_sensitivity_class"
      expr: esd_sensitivity_class
      comment: "Electrostatic discharge sensitivity classification"
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Method used for inventory valuation (FIFO, LIFO, weighted average)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for die bank valuation"
    - name: "creation_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month when die bank was created"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month when die bank expires"
  measures:
    - name: "total_die_banks"
      expr: COUNT(1)
      comment: "Total number of die bank records"
    - name: "total_die_inventory_value"
      expr: SUM(CAST(quantity_available AS DOUBLE) * unit_cost)
      comment: "Total inventory value of available die calculated as quantity times unit cost"
    - name: "avg_die_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per die across all die banks"
    - name: "total_die_size_area"
      expr: SUM(CAST(die_size_mm2 AS DOUBLE))
      comment: "Total die area in square millimeters across all die banks"
    - name: "avg_die_size"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters"
    - name: "die_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_reserved AS DOUBLE)) / NULLIF(SUM(CAST(quantity_initial AS DOUBLE)), 0), 2)
      comment: "Percentage of initial die quantity that has been reserved for use"
    - name: "die_scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_scrapped AS DOUBLE)) / NULLIF(SUM(CAST(quantity_initial AS DOUBLE)), 0), 2)
      comment: "Percentage of initial die quantity that has been scrapped"
    - name: "die_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_available AS DOUBLE)) / NULLIF(SUM(CAST(quantity_initial AS DOUBLE)), 0), 2)
      comment: "Percentage of initial die quantity that remains available for use"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_finished_good`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished goods inventory KPIs tracking packaged semiconductor products, quality status, and inventory valuation"
  source: "`vibe_semiconductors_v1`.`inventory`.`finished_good`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status of finished goods"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle status (active, EOL, phase-out)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Product qualification and certification status"
    - name: "device_type"
      expr: device_type
      comment: "Type of semiconductor device"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Operating temperature grade classification"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Performance speed grade classification"
    - name: "msd_level"
      expr: msd_level
      comment: "Moisture sensitivity level rating"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status flag"
    - name: "aec_q_qualified"
      expr: aec_q_qualified
      comment: "AEC-Q automotive qualification flag"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS environmental compliance flag"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH chemical compliance flag"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where product was manufactured"
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Inventory valuation method used"
    - name: "eol_month"
      expr: DATE_TRUNC('MONTH', eol_date)
      comment: "Month when product reaches end-of-life"
  measures:
    - name: "total_finished_goods"
      expr: COUNT(1)
      comment: "Total number of finished good SKU records"
    - name: "total_fg_inventory_value"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) * standard_cost)
      comment: "Total inventory value of finished goods on hand at standard cost"
    - name: "avg_fg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per finished good unit"
    - name: "avg_dppm_target"
      expr: AVG(CAST(dppm_target AS DOUBLE))
      comment: "Average defective parts per million target across finished goods"
    - name: "avg_storage_temp_max"
      expr: AVG(CAST(storage_temperature_max_c AS DOUBLE))
      comment: "Average maximum storage temperature in Celsius"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods movement transaction KPIs tracking inventory flows, material transfers, and valuation changes across the supply chain"
  source: "`vibe_semiconductors_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (receipt, issue, transfer, adjustment)"
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type classification (unrestricted, blocked, quality inspection)"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for tested semiconductor units"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the goods movement"
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of reference document triggering the movement"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator (consignment, project stock, etc.)"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating if this is a reversal transaction"
    - name: "source_plant_code"
      expr: source_plant_code
      comment: "Source plant code for the movement"
    - name: "destination_plant_code"
      expr: destination_plant_code
      comment: "Destination plant code for the movement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for valuation"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month when goods movement occurred"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when movement was posted to accounting"
  measures:
    - name: "total_movements"
      expr: COUNT(1)
      comment: "Total number of goods movement transactions"
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_movement_value"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of all goods movements"
    - name: "avg_movement_quantity"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per goods movement transaction"
    - name: "avg_movement_value"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation amount per goods movement"
    - name: "avg_unit_value"
      expr: AVG(valuation_amount / NULLIF(quantity, 0))
      comment: "Average value per unit moved"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer lot inventory KPIs tracking fabricated wafer lots, yield metrics, and work-in-process status"
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the wafer lot"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of wafer lot (production, engineering, qualification)"
    - name: "process_stage"
      expr: process_stage
      comment: "Current fabrication process stage"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification for lot processing"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Flag indicating if lot is on hold"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lot hold status"
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter in millimeters"
    - name: "valuation_currency"
      expr: valuation_currency
      comment: "Currency used for inventory valuation"
    - name: "lot_start_month"
      expr: DATE_TRUNC('MONTH', lot_start_date)
      comment: "Month when lot processing started"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Target month for lot completion"
    - name: "actual_completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_date)
      comment: "Actual month when lot was completed"
  measures:
    - name: "total_wafer_lots"
      expr: COUNT(1)
      comment: "Total number of wafer lot records"
    - name: "total_wafer_lot_value"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total inventory valuation amount for all wafer lots"
    - name: "avg_wafer_lot_value"
      expr: AVG(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Average inventory valuation per wafer lot"
    - name: "total_wafers_current"
      expr: SUM(CAST(wafer_count_current AS DOUBLE))
      comment: "Total current wafer count across all lots"
    - name: "total_wafers_started"
      expr: SUM(CAST(wafer_count_start AS DOUBLE))
      comment: "Total starting wafer count across all lots"
    - name: "total_good_wafers"
      expr: SUM(CAST(good_wafer_count AS DOUBLE))
      comment: "Total count of good wafers across all lots"
    - name: "total_scrap_wafers"
      expr: SUM(CAST(scrap_wafer_count AS DOUBLE))
      comment: "Total count of scrapped wafers across all lots"
    - name: "wafer_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(good_wafer_count AS DOUBLE)) / NULLIF(SUM(CAST(wafer_count_start AS DOUBLE)), 0), 2)
      comment: "Percentage of starting wafers that are classified as good"
    - name: "wafer_scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_wafer_count AS DOUBLE)) / NULLIF(SUM(CAST(wafer_count_start AS DOUBLE)), 0), 2)
      comment: "Percentage of starting wafers that were scrapped"
    - name: "wafer_attrition_rate"
      expr: ROUND(100.0 * (SUM(CAST(wafer_count_start AS DOUBLE)) - SUM(CAST(wafer_count_current AS DOUBLE))) / NULLIF(SUM(CAST(wafer_count_start AS DOUBLE)), 0), 2)
      comment: "Percentage of starting wafers lost during processing"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_physical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count KPIs tracking cycle count accuracy, variances, and inventory reconciliation performance"
  source: "`vibe_semiconductors_v1`.`inventory`.`physical_inventory`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the physical count (planned, in-progress, completed, approved)"
    - name: "count_type"
      expr: count_type
      comment: "Type of physical count (cycle count, annual inventory, spot check)"
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory being counted"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for semiconductor units"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status"
    - name: "consignment_flag"
      expr: consignment_flag
      comment: "Flag indicating consignment inventory"
    - name: "freeze_flag"
      expr: freeze_flag
      comment: "Flag indicating if inventory is frozen for counting"
    - name: "recount_flag"
      expr: recount_flag
      comment: "Flag indicating if recount was required"
    - name: "variance_exceeds_tolerance_flag"
      expr: variance_exceeds_tolerance_flag
      comment: "Flag indicating if variance exceeds acceptable tolerance"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the count"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the count"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month when physical count was performed"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when count was posted to accounting"
  measures:
    - name: "total_count_records"
      expr: COUNT(1)
      comment: "Total number of physical inventory count records"
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book quantity across all count records"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physically counted quantity"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance quantity (counted minus book)"
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value_usd AS DOUBLE))
      comment: "Total variance value in USD"
    - name: "count_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_quantity = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of count records with zero variance (perfect accuracy)"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_tolerance_pct AS DOUBLE))
      comment: "Average variance tolerance percentage"
    - name: "avg_absolute_variance_qty"
      expr: AVG(ABS(variance_quantity))
      comment: "Average absolute variance quantity per count record"
    - name: "inventory_accuracy_rate"
      expr: ROUND(100.0 * (1 - ABS(SUM(CAST(variance_quantity AS DOUBLE))) / NULLIF(SUM(CAST(book_quantity AS DOUBLE)), 0)), 2)
      comment: "Overall inventory accuracy rate based on total variance vs book quantity"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_raw_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Raw material inventory KPIs tracking semiconductor manufacturing materials, supplier performance, and inventory optimization"
  source: "`vibe_semiconductors_v1`.`inventory`.`raw_material`"
  dimensions:
    - name: "material_status"
      expr: material_status
      comment: "Current status of the raw material"
    - name: "material_class"
      expr: material_class
      comment: "Classification of the material"
    - name: "material_group"
      expr: material_group
      comment: "Material group categorization"
    - name: "wafer_type"
      expr: wafer_type
      comment: "Type of wafer material"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the material"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification for safety"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Required storage conditions"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag"
    - name: "reach_svhc_flag"
      expr: reach_svhc_flag
      comment: "REACH substance of very high concern flag"
    - name: "batch_managed"
      expr: batch_managed
      comment: "Flag indicating if material is batch-managed"
    - name: "serialized"
      expr: serialized
      comment: "Flag indicating if material is serialized"
    - name: "inspection_required"
      expr: inspection_required
      comment: "Flag indicating if incoming inspection is required"
    - name: "lot_size_type"
      expr: lot_size_type
      comment: "Type of lot sizing used"
    - name: "price_control_type"
      expr: price_control_type
      comment: "Price control method (standard, moving average)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the material"
  measures:
    - name: "total_raw_materials"
      expr: COUNT(1)
      comment: "Total number of raw material SKUs"
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard price per raw material"
    - name: "avg_moving_avg_price"
      expr: AVG(CAST(moving_avg_price AS DOUBLE))
      comment: "Average moving average price per raw material"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for raw materials"
    - name: "avg_shelf_life_days"
      expr: AVG(CAST(shelf_life_days AS DOUBLE))
      comment: "Average shelf life in days"
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point_qty AS DOUBLE))
      comment: "Average reorder point quantity"
    - name: "avg_safety_stock"
      expr: AVG(CAST(safety_stock_qty AS DOUBLE))
      comment: "Average safety stock quantity"
    - name: "avg_max_stock"
      expr: AVG(CAST(max_stock_qty AS DOUBLE))
      comment: "Average maximum stock quantity"
    - name: "avg_wafer_diameter"
      expr: AVG(CAST(wafer_diameter_mm AS DOUBLE))
      comment: "Average wafer diameter in millimeters"
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_pct AS DOUBLE))
      comment: "Average material purity percentage"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation KPIs tracking material allocations, fulfillment performance, and demand commitment metrics"
  source: "`vibe_semiconductors_v1`.`inventory`.`reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the reservation"
    - name: "reservation_type"
      expr: reservation_type
      comment: "Type of reservation (sales order, production order, transfer)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the reservation"
    - name: "reason"
      expr: reason
      comment: "Reason for the reservation"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status of reserved material"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for semiconductor units"
    - name: "is_kgd"
      expr: is_kgd
      comment: "Known Good Die flag"
    - name: "reservation_month"
      expr: DATE_TRUNC('MONTH', reservation_timestamp)
      comment: "Month when reservation was created"
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_timestamp)
      comment: "Month when reservation expires"
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Requested delivery month"
  measures:
    - name: "total_reservations"
      expr: COUNT(1)
      comment: "Total number of inventory reservations"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved across all reservations"
    - name: "avg_reserved_quantity"
      expr: AVG(CAST(reserved_quantity AS DOUBLE))
      comment: "Average quantity per reservation"
    - name: "reservation_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reservation_status = 'fulfilled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reservations that have been fulfilled"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock balance KPIs tracking inventory levels, availability, turnover, and working capital optimization across all material types"
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (unrestricted, blocked, quality inspection)"
    - name: "batch_classification"
      expr: batch_classification
      comment: "Batch classification"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for semiconductor units"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator (consignment, project stock)"
    - name: "storage_condition_code"
      expr: storage_condition_code
      comment: "Storage condition code"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for accounting"
    - name: "msd_level"
      expr: msd_level
      comment: "Moisture sensitivity level"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control flag"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Hazardous material flag"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag"
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Slow-moving inventory flag"
    - name: "unrestricted_use_flag"
      expr: unrestricted_use_flag
      comment: "Unrestricted use flag"
    - name: "wafer_process_node"
      expr: wafer_process_node
      comment: "Wafer process node technology"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_timestamp)
      comment: "Month of the stock balance snapshot"
    - name: "last_receipt_month"
      expr: DATE_TRUNC('MONTH', last_goods_receipt_date)
      comment: "Month of last goods receipt"
    - name: "last_issue_month"
      expr: DATE_TRUNC('MONTH', last_goods_issue_date)
      comment: "Month of last goods issue"
    - name: "last_count_month"
      expr: DATE_TRUNC('MONTH', last_physical_count_date)
      comment: "Month of last physical count"
  measures:
    - name: "total_stock_records"
      expr: COUNT(1)
      comment: "Total number of stock balance records"
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all stock locations"
    - name: "total_qty_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for use"
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved for orders"
    - name: "total_qty_blocked"
      expr: SUM(CAST(qty_blocked AS DOUBLE))
      comment: "Total quantity blocked from use"
    - name: "total_qty_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity in transit between locations"
    - name: "total_qty_in_wip"
      expr: SUM(CAST(qty_in_wip AS DOUBLE))
      comment: "Total quantity in work-in-process"
    - name: "total_qty_quality_inspection"
      expr: SUM(CAST(qty_quality_inspection AS DOUBLE))
      comment: "Total quantity in quality inspection"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(qty_available AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available for use"
    - name: "inventory_reservation_rate"
      expr: ROUND(100.0 * SUM(CAST(qty_reserved AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is reserved"
    - name: "inventory_blocked_rate"
      expr: ROUND(100.0 * SUM(CAST(qty_blocked AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is blocked"
    - name: "avg_stock_aging_days"
      expr: AVG(CAST(stock_aging_days AS DOUBLE))
      comment: "Average number of days inventory has been in stock"
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point_qty AS DOUBLE))
      comment: "Average reorder point quantity"
    - name: "avg_safety_stock"
      expr: AVG(CAST(safety_stock_qty AS DOUBLE))
      comment: "Average safety stock quantity"
    - name: "stock_below_reorder_point_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qty_on_hand < reorder_point_qty THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stock records below reorder point"
    - name: "stock_below_safety_stock_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN qty_on_hand < safety_stock_qty THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stock records below safety stock level"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location KPIs tracking warehouse capacity utilization, environmental compliance, and facility performance"
  source: "`vibe_semiconductors_v1`.`inventory`.`storage_location`"
  dimensions:
    - name: "location_status"
      expr: location_status
      comment: "Current operational status of the storage location"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of storage facility"
    - name: "cleanroom_iso_class"
      expr: cleanroom_iso_class
      comment: "ISO cleanroom classification"
    - name: "hazmat_classification"
      expr: hazmat_classification
      comment: "Hazardous material classification"
    - name: "msd_sensitivity_level"
      expr: msd_sensitivity_level
      comment: "Moisture sensitivity level capability"
    - name: "esd_protection_class"
      expr: esd_protection_class
      comment: "ESD protection class"
    - name: "fire_suppression_type"
      expr: fire_suppression_type
      comment: "Type of fire suppression system"
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Inventory valuation method used at this location"
    - name: "is_osat_partner_location"
      expr: is_osat_partner_location
      comment: "Flag indicating OSAT partner location"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR controlled location flag"
    - name: "kgd_storage_certified"
      expr: kgd_storage_certified
      comment: "Known Good Die storage certification flag"
    - name: "msd_floor_life_capable"
      expr: msd_floor_life_capable
      comment: "MSD floor life management capability flag"
    - name: "nitrogen_purge_capable"
      expr: nitrogen_purge_capable
      comment: "Nitrogen purge capability flag"
    - name: "photomask_storage_capable"
      expr: photomask_storage_capable
      comment: "Photomask storage capability flag"
    - name: "shelf_life_tracking_enabled"
      expr: shelf_life_tracking_enabled
      comment: "Shelf life tracking enabled flag"
    - name: "wip_staging_area"
      expr: wip_staging_area
      comment: "Work-in-process staging area flag"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the storage location"
    - name: "commissioned_month"
      expr: DATE_TRUNC('MONTH', commissioned_date)
      comment: "Month when location was commissioned"
  measures:
    - name: "total_storage_locations"
      expr: COUNT(1)
      comment: "Total number of storage locations"
    - name: "total_max_capacity"
      expr: SUM(CAST(max_capacity_units AS DOUBLE))
      comment: "Total maximum capacity across all locations"
    - name: "total_current_utilization"
      expr: SUM(CAST(current_utilization_units AS DOUBLE))
      comment: "Total current utilization across all locations"
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(current_utilization_units AS DOUBLE)) / NULLIF(SUM(CAST(max_capacity_units AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity currently utilized"
    - name: "avg_max_capacity"
      expr: AVG(CAST(max_capacity_units AS DOUBLE))
      comment: "Average maximum capacity per location"
    - name: "avg_current_utilization"
      expr: AVG(CAST(current_utilization_units AS DOUBLE))
      comment: "Average current utilization per location"
    - name: "avg_weight_capacity_kg"
      expr: AVG(CAST(weight_capacity_kg AS DOUBLE))
      comment: "Average weight capacity in kilograms"
    - name: "avg_max_temperature"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum temperature in Celsius"
    - name: "avg_min_temperature"
      expr: AVG(CAST(min_temperature_c AS DOUBLE))
      comment: "Average minimum temperature in Celsius"
    - name: "avg_max_humidity"
      expr: AVG(CAST(max_humidity_pct AS DOUBLE))
      comment: "Average maximum humidity percentage"
    - name: "avg_min_humidity"
      expr: AVG(CAST(min_humidity_pct AS DOUBLE))
      comment: "Average minimum humidity percentage"
$$;