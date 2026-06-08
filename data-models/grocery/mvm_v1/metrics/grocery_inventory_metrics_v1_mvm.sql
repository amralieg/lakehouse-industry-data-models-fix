-- Metric views for domain: inventory | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core inventory health metrics derived from the stock position fact table. Tracks on-hand availability, out-of-stock exposure, shrink, and perishable risk across SKUs, departments, and storage locations. Used by supply chain, store operations, and category management to steer replenishment and reduce lost sales."
  source: "`grocery_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to the SKU master — primary grouping dimension for all inventory KPIs."
    - name: "department_id"
      expr: department_id
      comment: "Department owning the stock position, enabling department-level inventory performance analysis."
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Physical storage location of the stock, used to analyse inventory by aisle, bay, or zone."
    - name: "location_type"
      expr: location_type
      comment: "Classification of the storage location (e.g. shelf, backroom, cooler) for segmented inventory analysis."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Flag indicating whether the SKU is perishable, enabling targeted freshness and waste management reporting."
    - name: "perishable_category"
      expr: perishable_category
      comment: "Sub-category of perishable items (e.g. dairy, produce, meat) for granular freshness KPI segmentation."
    - name: "oos_flag"
      expr: oos_flag
      comment: "Current out-of-stock indicator on the position, used to filter or segment OOS vs in-stock positions."
    - name: "cold_chain_compliance_flag"
      expr: cold_chain_compliance_flag
      comment: "Indicates whether the cold chain requirement is being met for this stock position — critical for food safety compliance."
    - name: "fifo_lifo_indicator"
      expr: fifo_lifo_indicator
      comment: "Rotation method applied to this position (FIFO/LIFO), relevant for perishable and expiry management."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Expiration date bucketed to month, enabling cohort analysis of near-expiry inventory volumes."
    - name: "oos_root_cause"
      expr: oos_root_cause
      comment: "Root cause category of the out-of-stock event (e.g. supplier delay, forecast miss), used to drive corrective action."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier associated with the stock position, enabling supplier-level inventory performance benchmarking."
    - name: "record_created_date"
      expr: DATE_TRUNC('day', record_created_timestamp)
      comment: "Date the stock position record was created, used for trend analysis of inventory snapshots."
  measures:
    - name: "total_on_hand_units"
      expr: SUM(CAST(on_hand_quantity AS DOUBLE))
      comment: "Total on-hand inventory units across all positions. Core availability metric used by store ops and supply chain to assess stock coverage."
    - name: "total_available_units"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total sellable (available) inventory units — excludes reserved and in-transit stock. Directly reflects what can be sold today."
    - name: "total_reserved_units"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total units reserved for pending orders or allocations. Monitors fulfilment commitments against on-hand stock."
    - name: "total_in_transit_units"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total units currently in transit to the store or DC. Used to project near-term availability and avoid unnecessary reorders."
    - name: "total_on_order_units"
      expr: SUM(CAST(on_order_quantity AS DOUBLE))
      comment: "Total units on open purchase or replenishment orders. Indicates future supply pipeline depth."
    - name: "total_shrink_units"
      expr: SUM(CAST(shrink_quantity AS DOUBLE))
      comment: "Total inventory units lost to shrink (theft, damage, spoilage). A key P&L driver monitored by loss prevention and finance."
    - name: "total_estimated_lost_sales_value"
      expr: SUM(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Total estimated revenue lost due to out-of-stock events. Directly quantifies the financial impact of inventory gaps for executive review."
    - name: "avg_oos_duration_hours"
      expr: AVG(CAST(oos_duration_hours AS DOUBLE))
      comment: "Average duration (hours) a position remained out of stock. Measures replenishment responsiveness and service level quality."
    - name: "total_oos_positions"
      expr: COUNT(CASE WHEN oos_flag = TRUE THEN stock_position_id END)
      comment: "Count of stock positions currently flagged as out-of-stock. Operational KPI for store managers to prioritise restocking actions."
    - name: "oos_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oos_flag = TRUE THEN stock_position_id END) / NULLIF(COUNT(stock_position_id), 0), 2)
      comment: "Percentage of stock positions that are currently out of stock. A headline service-level KPI tracked at every operational review."
    - name: "cold_chain_non_compliance_positions"
      expr: COUNT(CASE WHEN cold_chain_compliance_flag = FALSE THEN stock_position_id END)
      comment: "Number of stock positions failing cold chain compliance. A food safety and regulatory risk metric requiring immediate operational response."
    - name: "avg_last_cycle_count_quantity"
      expr: AVG(CAST(last_cycle_count_quantity AS DOUBLE))
      comment: "Average quantity recorded at the last cycle count per position. Baseline for assessing inventory accuracy and variance trends."
    - name: "total_stock_positions"
      expr: COUNT(stock_position_id)
      comment: "Total number of active stock positions. Denominator for rate calculations and a measure of inventory breadth across the estate."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_shrink_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shrink loss analytics measuring the financial and operational impact of inventory shrinkage across categories, departments, and disposal methods. Used by loss prevention, finance, and store operations to identify shrink drivers, quantify P&L exposure, and prioritise mitigation programmes."
  source: "`grocery_ecm`.`inventory`.`shrink_record`"
  dimensions:
    - name: "department_id"
      expr: department_id
      comment: "Department where shrink was recorded, enabling department-level shrink benchmarking and accountability."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU associated with the shrink event, used to identify high-shrink products for targeted loss prevention."
    - name: "shrink_category"
      expr: shrink_category
      comment: "High-level classification of shrink type (e.g. theft, spoilage, damage, administrative error) — primary driver dimension for loss prevention strategy."
    - name: "shrink_cause"
      expr: shrink_cause
      comment: "Specific cause of the shrink event, enabling root-cause analysis and targeted corrective actions."
    - name: "disposal_method"
      expr: disposal_method
      comment: "How the shrunk inventory was disposed of (e.g. donated, discarded, returned to vendor), relevant for sustainability and cost recovery tracking."
    - name: "disposition_method"
      expr: disposition_method
      comment: "Disposition approach applied to the shrink (e.g. markdown, donation, write-off), used to assess value recovery from shrink events."
    - name: "shrink_record_status"
      expr: shrink_record_status
      comment: "Processing status of the shrink record (e.g. pending, approved, closed), used to filter actionable vs. resolved shrink events."
    - name: "temperature_violation"
      expr: temperature_violation
      comment: "Flag indicating whether a temperature violation contributed to the shrink event — critical for cold chain and food safety analysis."
    - name: "compliance_flag_haccp"
      expr: compliance_flag_haccp
      comment: "HACCP compliance flag on the shrink record, used for regulatory reporting and food safety audit trails."
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period of the shrink event, enabling period-over-period shrink trend analysis aligned to financial reporting cycles."
    - name: "recorded_date"
      expr: DATE_TRUNC('month', recorded_timestamp)
      comment: "Month the shrink was recorded, used for monthly shrink trend reporting and seasonal pattern identification."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store where the shrink occurred, enabling store-level shrink benchmarking and targeted loss prevention deployment."
  measures:
    - name: "total_shrink_quantity_lost"
      expr: SUM(CAST(quantity_lost AS DOUBLE))
      comment: "Total units lost to shrink. Primary volume metric for loss prevention programmes and inventory accuracy assessments."
    - name: "total_shrink_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of shrink losses. A direct P&L impact metric reviewed by finance and loss prevention leadership at every period close."
    - name: "avg_shrink_cost_per_event"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average cost per shrink event. Benchmarks the severity of individual shrink incidents and helps prioritise high-value loss categories."
    - name: "total_shrink_events"
      expr: COUNT(shrink_record_id)
      comment: "Total number of shrink events recorded. Tracks shrink frequency trends and the effectiveness of loss prevention interventions."
    - name: "temperature_violation_shrink_events"
      expr: COUNT(CASE WHEN temperature_violation = TRUE THEN shrink_record_id END)
      comment: "Number of shrink events caused by temperature violations. Quantifies cold chain failure impact on shrink — a food safety and cost risk metric."
    - name: "temperature_violation_shrink_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_violation = TRUE THEN shrink_record_id END) / NULLIF(COUNT(shrink_record_id), 0), 2)
      comment: "Percentage of shrink events attributable to temperature violations. Measures cold chain programme effectiveness and regulatory exposure."
    - name: "total_shrink_events_with_haccp_flag"
      expr: COUNT(CASE WHEN compliance_flag_haccp = TRUE THEN shrink_record_id END)
      comment: "Count of shrink events flagged for HACCP non-compliance. A regulatory risk metric requiring escalation and corrective action documentation."
    - name: "avg_temperature_reading_at_shrink"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature recorded at the time of shrink events. Used to correlate temperature deviations with shrink incidence for cold chain optimisation."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_oos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-stock event analytics quantifying the frequency, duration, and financial impact of shelf availability failures. Used by category managers, supply chain planners, and store operations to reduce lost sales, improve replenishment speed, and address root causes of availability gaps."
  source: "`grocery_ecm`.`inventory`.`oos_event`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU that experienced the OOS event — primary dimension for identifying high-risk products requiring availability intervention."
    - name: "department_id"
      expr: department_id
      comment: "Department where the OOS event occurred, enabling department-level availability performance benchmarking."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location of the OOS event, used for store-level availability scorecards and targeted replenishment prioritisation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause of the OOS event (e.g. forecast miss, supplier delay, execution failure) — the primary driver dimension for corrective action planning."
    - name: "oos_severity"
      expr: oos_severity
      comment: "Severity classification of the OOS event (e.g. critical, moderate, minor), used to prioritise response and escalation."
    - name: "detection_method"
      expr: detection_method
      comment: "How the OOS was detected (e.g. cycle count, POS signal, manual check), used to evaluate detection system effectiveness."
    - name: "location_type"
      expr: location_type
      comment: "Type of location where OOS occurred (e.g. shelf, endcap, cooler), enabling location-type availability analysis."
    - name: "is_resolved"
      expr: is_resolved
      comment: "Whether the OOS event has been resolved, used to track open vs. closed availability incidents."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier linked to the OOS event, enabling supplier-level availability performance and accountability reporting."
    - name: "oos_start_month"
      expr: DATE_TRUNC('month', oos_start_timestamp)
      comment: "Month the OOS event started, used for monthly availability trend analysis and seasonal pattern identification."
    - name: "promo_campaign_id"
      expr: promo_campaign_id
      comment: "Promotional campaign active during the OOS event — used to assess whether promotions are driving availability failures."
  measures:
    - name: "total_oos_events"
      expr: COUNT(oos_event_id)
      comment: "Total number of out-of-stock events. Headline availability KPI tracked at every operational and executive review."
    - name: "total_estimated_lost_sales_value"
      expr: SUM(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Total estimated revenue lost due to OOS events. Directly quantifies the financial cost of availability failures for executive decision-making."
    - name: "avg_estimated_lost_sales_per_event"
      expr: AVG(CAST(estimated_lost_sales_value AS DOUBLE))
      comment: "Average lost sales value per OOS event. Benchmarks the revenue impact severity of individual availability failures."
    - name: "total_oos_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total cumulative hours of out-of-stock exposure across all events. Measures the aggregate availability gap experienced by shoppers."
    - name: "avg_oos_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration (hours) per OOS event. Measures replenishment responsiveness — a key operational efficiency KPI."
    - name: "unresolved_oos_events"
      expr: COUNT(CASE WHEN is_resolved = FALSE THEN oos_event_id END)
      comment: "Number of OOS events not yet resolved. An operational urgency metric driving immediate store and supply chain action."
    - name: "oos_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_resolved = TRUE THEN oos_event_id END) / NULLIF(COUNT(oos_event_id), 0), 2)
      comment: "Percentage of OOS events that have been resolved. Measures the effectiveness of the replenishment and availability recovery process."
    - name: "total_forecasted_demand_units"
      expr: SUM(CAST(forecasted_demand_qty AS DOUBLE))
      comment: "Total forecasted demand units during OOS periods. Used to size the demand signal missed due to availability failures."
    - name: "avg_forecast_vs_actual_demand_gap"
      expr: AVG(forecasted_demand_qty - actual_sales_qty)
      comment: "Average gap between forecasted demand and actual sales during OOS events. Quantifies demand fulfilment shortfall attributable to availability failures."
    - name: "distinct_skus_with_oos"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that experienced at least one OOS event. Measures the breadth of availability risk across the assortment."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and cycle count performance metrics. Measures variance between system and physical counts, shrink detection rates, and temperature compliance during counting. Used by store operations, loss prevention, and finance to govern inventory accuracy, validate book stock, and identify systemic counting or shrink issues."
  source: "`grocery_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "department_id"
      expr: department_id
      comment: "Department where the cycle count was performed, enabling department-level inventory accuracy benchmarking."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU counted during the cycle count, used to identify products with persistent inventory accuracy issues."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location of the cycle count, enabling store-level accuracy scorecards."
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count performed (e.g. full, partial, spot), used to segment accuracy results by counting methodology."
    - name: "count_method"
      expr: count_method
      comment: "Method used to perform the count (e.g. manual, RF scanner, RFID), used to assess technology impact on counting accuracy."
    - name: "count_reason"
      expr: count_reason
      comment: "Business reason triggering the cycle count (e.g. scheduled, discrepancy, audit), used to categorise count activity by driver."
    - name: "cycle_count_status"
      expr: cycle_count_status
      comment: "Current status of the cycle count record (e.g. pending, approved, rejected), used to filter completed vs. in-progress counts."
    - name: "shrink_flag"
      expr: shrink_flag
      comment: "Indicates whether the cycle count identified a shrink event, used to segment accuracy variances attributable to shrink."
    - name: "tolerance_flag"
      expr: tolerance_flag
      comment: "Indicates whether the count variance exceeded the acceptable tolerance threshold — a key inventory accuracy governance flag."
    - name: "temperature_compliance_flag"
      expr: temperature_compliance_flag
      comment: "Whether temperature compliance was maintained during the count — relevant for perishable and cold chain inventory accuracy."
    - name: "is_out_of_stock"
      expr: is_out_of_stock
      comment: "Whether the counted item was found to be out of stock at time of count, used to correlate cycle counts with OOS detection."
    - name: "count_month"
      expr: DATE_TRUNC('month', count_timestamp)
      comment: "Month the cycle count was performed, used for monthly inventory accuracy trend reporting."
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location counted, enabling location-level accuracy analysis and targeted recount scheduling."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(cycle_count_id)
      comment: "Total number of cycle count records. Measures counting programme activity and coverage across the store estate."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total unit variance between system and physical counts. A headline inventory accuracy metric — large positive or negative values indicate systemic book stock errors."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances. Directly quantifies the P&L exposure from inventory inaccuracy, reviewed by finance at period close."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across cycle counts. The primary inventory accuracy rate KPI — benchmarked against industry standards and internal targets."
    - name: "total_shrink_flagged_counts"
      expr: COUNT(CASE WHEN shrink_flag = TRUE THEN cycle_count_id END)
      comment: "Number of cycle counts that identified a shrink event. Measures the shrink detection effectiveness of the counting programme."
    - name: "shrink_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN shrink_flag = TRUE THEN cycle_count_id END) / NULLIF(COUNT(cycle_count_id), 0), 2)
      comment: "Percentage of cycle counts that detected shrink. Measures the loss prevention value delivered by the cycle counting programme."
    - name: "tolerance_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tolerance_flag = TRUE THEN cycle_count_id END) / NULLIF(COUNT(cycle_count_id), 0), 2)
      comment: "Percentage of cycle counts where variance exceeded the tolerance threshold. A governance KPI for inventory accuracy programme management."
    - name: "temperature_non_compliance_counts"
      expr: COUNT(CASE WHEN temperature_compliance_flag = FALSE THEN cycle_count_id END)
      comment: "Number of cycle counts with temperature compliance failures. Flags cold chain risk during inventory counting operations."
    - name: "avg_counted_quantity"
      expr: AVG(CAST(counted_quantity AS DOUBLE))
      comment: "Average physical quantity counted per cycle count record. Used to normalise variance metrics and assess counting completeness."
    - name: "oos_detected_at_count_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_out_of_stock = TRUE THEN cycle_count_id END) / NULLIF(COUNT(cycle_count_id), 0), 2)
      comment: "Percentage of cycle counts where the item was found to be out of stock. Measures the OOS detection contribution of the cycle counting programme."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory flow and movement analytics tracking the volume, value, and compliance of all goods movements (receipts, transfers, adjustments, shrink). Used by supply chain, finance, and store operations to monitor inventory throughput, cost accuracy, and movement quality across the distribution network."
  source: "`grocery_ecm`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (e.g. receipt, transfer, adjustment, shrink write-off) — the primary dimension for movement flow analysis."
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the movement, enabling root-cause analysis of adjustments and shrink-related movements."
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Processing status of the movement record (e.g. posted, pending, reversed), used to filter completed vs. in-progress movements."
    - name: "department_id"
      expr: department_id
      comment: "Department associated with the goods movement, enabling department-level throughput and cost analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU involved in the movement, used to track product-level inventory flow and identify high-movement items."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier linked to the movement, enabling supplier-level inbound flow and quality analysis."
    - name: "cost_method"
      expr: cost_method
      comment: "Costing method applied to the movement (e.g. FIFO, LIFO, WAC), used to segment movement value by valuation methodology."
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Inventory valuation method used for the movement, relevant for finance and audit reporting."
    - name: "is_shrink"
      expr: is_shrink
      comment: "Flag indicating whether the movement represents a shrink event, used to isolate shrink-driven inventory reductions."
    - name: "is_cycle_count_correction"
      expr: is_cycle_count_correction
      comment: "Flag indicating whether the movement is a cycle count correction, used to measure the volume of book stock adjustments."
    - name: "temperature_compliance_flag"
      expr: temperature_compliance_flag
      comment: "Whether temperature compliance was maintained during the movement — critical for cold chain and food safety governance."
    - name: "movement_month"
      expr: DATE_TRUNC('month', movement_timestamp)
      comment: "Month of the goods movement, used for monthly throughput trend analysis and period-over-period comparisons."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the movement cost, used for multi-currency financial reporting and FX normalisation."
  measures:
    - name: "total_movement_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units moved across all goods movement types. Primary throughput metric for supply chain and warehouse operations."
    - name: "total_movement_cost_value"
      expr: SUM(CAST(cost_at_movement AS DOUBLE))
      comment: "Total cost value of all goods movements. A key financial metric for inventory valuation, COGS calculation, and period-end reconciliation."
    - name: "avg_cost_per_unit_moved"
      expr: AVG(CAST(cost_at_movement AS DOUBLE))
      comment: "Average cost per goods movement record. Used to benchmark unit economics of inventory flow and detect cost anomalies."
    - name: "total_shrink_movements"
      expr: COUNT(CASE WHEN is_shrink = TRUE THEN goods_movement_id END)
      comment: "Number of goods movements classified as shrink. Measures the frequency of shrink-driven inventory reductions across the movement ledger."
    - name: "total_shrink_quantity"
      expr: SUM(CASE WHEN is_shrink = TRUE THEN quantity ELSE 0 END)
      comment: "Total units lost to shrink as recorded in goods movements. Quantifies shrink volume for loss prevention and P&L reporting."
    - name: "total_cycle_count_correction_movements"
      expr: COUNT(CASE WHEN is_cycle_count_correction = TRUE THEN goods_movement_id END)
      comment: "Number of movements that are cycle count corrections. Measures the volume of book stock adjustments driven by physical counting — a proxy for inventory accuracy issues."
    - name: "total_cycle_count_correction_quantity"
      expr: SUM(CASE WHEN is_cycle_count_correction = TRUE THEN quantity ELSE 0 END)
      comment: "Total units adjusted via cycle count corrections. Quantifies the magnitude of inventory book stock corrections for accuracy governance."
    - name: "temperature_non_compliant_movements"
      expr: COUNT(CASE WHEN temperature_compliance_flag = FALSE THEN goods_movement_id END)
      comment: "Number of goods movements with temperature compliance failures. A food safety and cold chain risk metric requiring operational escalation."
    - name: "total_goods_movements"
      expr: COUNT(goods_movement_id)
      comment: "Total number of goods movement transactions. Baseline throughput metric and denominator for movement quality rate calculations."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_receiving_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving performance metrics tracking acceptance rates, rejection rates, shrink at receiving, and financial accuracy of supplier deliveries. Used by supply chain, vendor management, and finance to evaluate supplier delivery quality, identify receiving exceptions, and manage inbound cost accuracy."
  source: "`grocery_ecm`.`inventory`.`receiving_record`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier who made the delivery — primary dimension for supplier-level receiving performance scorecards."
    - name: "department_id"
      expr: department_id
      comment: "Department receiving the goods, enabling department-level inbound quality and volume analysis."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location receiving the delivery, used for store-level receiving performance benchmarking."
    - name: "receiving_type"
      expr: receiving_type
      comment: "Type of receiving process (e.g. standard PO, DSD, cross-dock), used to segment receiving performance by delivery channel."
    - name: "receiving_record_status"
      expr: receiving_record_status
      comment: "Status of the receiving record (e.g. complete, pending, disputed), used to track open receiving exceptions."
    - name: "temperature_compliance_flag"
      expr: temperature_compliance_flag
      comment: "Whether the inbound delivery met temperature requirements — a food safety and supplier quality KPI."
    - name: "is_shrink"
      expr: is_shrink
      comment: "Flag indicating shrink was identified at receiving, used to attribute shrink to the inbound process."
    - name: "inventory_valuation_method"
      expr: inventory_valuation_method
      comment: "Valuation method applied to the received goods, relevant for financial reconciliation and audit."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of the receipt, used for monthly inbound volume and quality trend analysis."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('week', scheduled_delivery_date)
      comment: "Scheduled delivery date bucketed to week, used to analyse on-time delivery performance and receiving workload planning."
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period of the receipt, enabling period-aligned inbound cost and volume reporting."
  measures:
    - name: "total_receiving_records"
      expr: COUNT(receiving_record_id)
      comment: "Total number of receiving records. Baseline inbound volume metric and denominator for receiving quality rate calculations."
    - name: "total_net_received_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net financial value of goods received. A key inbound cost metric used by finance for COGS and accounts payable reconciliation."
    - name: "total_gross_received_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross value of goods received before discounts. Used alongside net amount to measure discount capture effectiveness."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured at receiving. Measures the financial benefit of trade terms and promotional allowances applied at inbound."
    - name: "avg_discount_per_receipt"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount captured per receiving record. Benchmarks trade terms utilisation and supplier discount compliance."
    - name: "temperature_non_compliant_receipts"
      expr: COUNT(CASE WHEN temperature_compliance_flag = FALSE THEN receiving_record_id END)
      comment: "Number of receipts failing temperature compliance. A supplier quality and food safety KPI — non-compliant receipts may require rejection or quarantine."
    - name: "temperature_non_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_compliance_flag = FALSE THEN receiving_record_id END) / NULLIF(COUNT(receiving_record_id), 0), 2)
      comment: "Percentage of receipts with temperature compliance failures. Measures cold chain integrity of the inbound supply chain."
    - name: "shrink_at_receiving_events"
      expr: COUNT(CASE WHEN is_shrink = TRUE THEN receiving_record_id END)
      comment: "Number of receiving records where shrink was identified at the point of receipt. Measures inbound shrink frequency for supplier accountability."
    - name: "avg_temperature_at_receipt"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature recorded at receipt. Used to monitor cold chain performance of inbound deliveries and identify supplier temperature trends."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_lot_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot and batch traceability metrics tracking inventory freshness, expiry risk, cold chain compliance, and recall exposure. Used by food safety, quality assurance, and supply chain teams to manage perishable inventory rotation, regulatory compliance, and supplier quality."
  source: "`grocery_ecm`.`inventory`.`lot_batch`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU associated with the lot/batch, used to track freshness and compliance at the product level."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier who produced the lot/batch — primary dimension for supplier quality and traceability reporting."
    - name: "department_id"
      expr: department_id
      comment: "Department holding the lot/batch, enabling department-level freshness and compliance analysis."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location holding the lot/batch, used for store-level expiry risk and rotation compliance reporting."
    - name: "lot_batch_status"
      expr: lot_batch_status
      comment: "Current status of the lot/batch (e.g. active, quarantined, recalled, expired), used to filter actionable inventory risk."
    - name: "lot_type"
      expr: lot_type
      comment: "Classification of the lot type (e.g. standard, promotional, seasonal), used to segment batch performance by procurement type."
    - name: "rotation_method"
      expr: rotation_method
      comment: "Rotation method applied to the batch (e.g. FIFO, FEFO), used to assess rotation compliance and freshness management."
    - name: "rotation_compliance_flag"
      expr: rotation_compliance_flag
      comment: "Whether the batch is being rotated in compliance with the required method — a food safety and waste reduction KPI."
    - name: "cold_chain_flag"
      expr: cold_chain_flag
      comment: "Indicates whether the batch requires cold chain management, used to segment compliance metrics by temperature-sensitive inventory."
    - name: "usda_fda_certified_flag"
      expr: usda_fda_certified_flag
      comment: "Whether the batch carries USDA/FDA certification — a regulatory compliance dimension for food safety reporting."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the batch, used for trade compliance, import regulation, and supplier diversity reporting."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Expiration date bucketed to month, used to identify near-expiry inventory cohorts requiring markdown or rotation action."
    - name: "production_month"
      expr: DATE_TRUNC('month', production_date)
      comment: "Production date bucketed to month, used to track batch age and freshness at the time of receipt and sale."
  measures:
    - name: "total_batch_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total inventory quantity across all lot/batch records. Measures the volume of traceable inventory in the supply chain."
    - name: "total_lot_batches"
      expr: COUNT(lot_batch_id)
      comment: "Total number of active lot/batch records. Measures traceability programme coverage and batch management workload."
    - name: "rotation_non_compliance_batches"
      expr: COUNT(CASE WHEN rotation_compliance_flag = FALSE THEN lot_batch_id END)
      comment: "Number of batches failing rotation compliance. A food safety and waste risk metric — non-compliant batches risk spoilage and regulatory penalties."
    - name: "rotation_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rotation_compliance_flag = TRUE THEN lot_batch_id END) / NULLIF(COUNT(lot_batch_id), 0), 2)
      comment: "Percentage of batches meeting rotation compliance requirements. A headline food safety KPI reviewed by quality assurance and store operations leadership."
    - name: "recalled_batches"
      expr: COUNT(CASE WHEN recall_date IS NOT NULL THEN lot_batch_id END)
      comment: "Number of batches subject to a product recall. A critical food safety and regulatory risk metric requiring immediate executive attention."
    - name: "quarantined_batches"
      expr: COUNT(CASE WHEN quarantine_start_date IS NOT NULL AND quarantine_end_date IS NULL THEN lot_batch_id END)
      comment: "Number of batches currently in quarantine. Measures active food safety holds and their potential impact on available inventory."
    - name: "avg_entry_temperature_c"
      expr: AVG(CAST(entry_temperature_c AS DOUBLE))
      comment: "Average temperature at which batches entered the facility. Used to monitor cold chain integrity at the point of receipt and identify supplier temperature compliance trends."
    - name: "cold_chain_batches"
      expr: COUNT(CASE WHEN cold_chain_flag = TRUE THEN lot_batch_id END)
      comment: "Number of batches requiring cold chain management. Measures the volume of temperature-sensitive inventory requiring active monitoring."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_replenishment_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment signal quality and responsiveness metrics tracking forecast accuracy, critical stock signals, and OOS risk indicators. Used by supply chain planners and category managers to evaluate the effectiveness of automated replenishment, prioritise critical reorders, and improve forecast-driven inventory management."
  source: "`grocery_ecm`.`inventory`.`replenishment_signal`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for which the replenishment signal was generated — primary dimension for product-level replenishment performance analysis."
    - name: "department_id"
      expr: department_id
      comment: "Department associated with the replenishment signal, enabling department-level replenishment effectiveness reporting."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location for which the signal was generated, used for store-level replenishment performance benchmarking."
    - name: "signal_type"
      expr: signal_type
      comment: "Type of replenishment signal (e.g. reorder point, min/max, forecast-driven), used to evaluate the performance of different replenishment strategies."
    - name: "replenishment_signal_status"
      expr: replenishment_signal_status
      comment: "Current status of the signal (e.g. open, actioned, cancelled), used to track signal fulfilment and backlog."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the signal is for a critically low stock situation requiring urgent action."
    - name: "is_oos"
      expr: is_oos
      comment: "Flag indicating whether the signal was triggered by an out-of-stock condition, used to measure OOS-driven replenishment frequency."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the replenishment signal, used to segment and triage replenishment workload."
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier linked to the replenishment signal, enabling supplier-level replenishment lead time and fulfilment analysis."
    - name: "signal_generated_month"
      expr: DATE_TRUNC('month', signal_generated_timestamp)
      comment: "Month the replenishment signal was generated, used for monthly signal volume and quality trend analysis."
    - name: "demand_forecast_date"
      expr: DATE_TRUNC('week', demand_forecast_date)
      comment: "Demand forecast date bucketed to week, used to align replenishment signals with forecast planning horizons."
  measures:
    - name: "total_replenishment_signals"
      expr: COUNT(replenishment_signal_id)
      comment: "Total number of replenishment signals generated. Measures the volume of replenishment activity and system responsiveness."
    - name: "critical_signals"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN replenishment_signal_id END)
      comment: "Number of critical replenishment signals. Measures the frequency of urgent stock situations requiring immediate supply chain response."
    - name: "critical_signal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN replenishment_signal_id END) / NULLIF(COUNT(replenishment_signal_id), 0), 2)
      comment: "Percentage of replenishment signals classified as critical. A supply chain health KPI — high rates indicate systemic inventory management issues."
    - name: "oos_triggered_signals"
      expr: COUNT(CASE WHEN is_oos = TRUE THEN replenishment_signal_id END)
      comment: "Number of replenishment signals triggered by an out-of-stock condition. Measures the reactive (vs. proactive) component of replenishment activity."
    - name: "oos_signal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_oos = TRUE THEN replenishment_signal_id END) / NULLIF(COUNT(replenishment_signal_id), 0), 2)
      comment: "Percentage of replenishment signals triggered by OOS conditions. A key indicator of replenishment proactivity — lower rates indicate better anticipatory planning."
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_pct AS DOUBLE))
      comment: "Average forecast accuracy percentage across replenishment signals. A strategic supply chain KPI — low accuracy drives excess stock or OOS events and inflates replenishment costs."
    - name: "distinct_skus_with_signals"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active replenishment signals. Measures the breadth of replenishment activity and assortment coverage."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_transfer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-location inventory transfer performance metrics tracking fulfilment rates, cost efficiency, temperature compliance, and expedited transfer frequency. Used by supply chain, store operations, and finance to optimise stock redistribution, reduce transfer costs, and ensure cold chain integrity during movement."
  source: "`grocery_ecm`.`inventory`.`transfer_order`"
  dimensions:
    - name: "transfer_order_status"
      expr: transfer_order_status
      comment: "Current status of the transfer order (e.g. open, in-transit, received, cancelled), used to track transfer pipeline and exceptions."
    - name: "transfer_order_type"
      expr: transfer_order_type
      comment: "Type of transfer (e.g. store-to-store, DC-to-store, cross-dock), used to segment transfer performance by movement channel."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Business reason for the transfer (e.g. replenishment, rebalancing, recall), used to categorise transfer activity by driver."
    - name: "department_id"
      expr: department_id
      comment: "Department associated with the transfer, enabling department-level transfer volume and cost analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being transferred, used to identify high-transfer products and assess redistribution patterns."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location (e.g. store, DC, MFC), used to segment transfer flows by destination channel."
    - name: "source_location_type"
      expr: source_location_type
      comment: "Type of source location for the transfer, used to analyse origin patterns of inter-location stock movements."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether the transfer was expedited, used to measure emergency transfer frequency and associated cost premiums."
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Whether the transfer required temperature-controlled transport, used to segment cold chain transfer compliance analysis."
    - name: "temperature_compliance_status"
      expr: temperature_compliance_status
      comment: "Temperature compliance outcome for the transfer, used to measure cold chain integrity during inter-location movements."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Flag indicating whether the transfer used cross-docking, used to measure cross-dock utilisation and efficiency."
    - name: "transfer_month"
      expr: DATE_TRUNC('month', transfer_date)
      comment: "Month of the transfer, used for monthly transfer volume and cost trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transfer cost, used for multi-currency financial reporting."
  measures:
    - name: "total_transfer_orders"
      expr: COUNT(transfer_order_id)
      comment: "Total number of transfer orders. Baseline throughput metric for inter-location inventory redistribution activity."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total units requested across all transfer orders. Measures the demand placed on the transfer network."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped via transfer orders. Measures actual transfer throughput against requested volumes."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units received at the destination. Used to calculate transfer fulfilment rates and identify in-transit losses."
    - name: "total_transfer_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all transfer orders. A key supply chain cost metric reviewed by finance and logistics leadership."
    - name: "avg_transfer_cost_per_order"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per transfer order. Benchmarks transfer efficiency and identifies cost outliers for logistics optimisation."
    - name: "transfer_fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested transfer quantity that was received at the destination. Measures end-to-end transfer reliability and in-transit loss rate."
    - name: "expedited_transfer_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expedited = TRUE THEN transfer_order_id END) / NULLIF(COUNT(transfer_order_id), 0), 2)
      comment: "Percentage of transfer orders that were expedited. High rates indicate reactive supply chain management and elevated logistics costs."
    - name: "total_shrink_in_transit"
      expr: SUM(CAST(shrink_quantity AS DOUBLE))
      comment: "Total units lost to shrink during transfer. Measures in-transit loss exposure and the effectiveness of transfer handling procedures."
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Total units approved for transfer. Used alongside requested and shipped quantities to measure transfer approval efficiency."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_perishable_rotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Perishable inventory rotation compliance and freshness management metrics. Tracks rotation compliance rates, temperature adherence, and expiry risk across perishable categories. Used by store operations, food safety teams, and category managers to reduce waste, ensure regulatory compliance, and protect brand reputation."
  source: "`grocery_ecm`.`inventory`.`perishable_rotation`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU subject to perishable rotation, used to identify products with persistent rotation compliance issues."
    - name: "department_id"
      expr: department_id
      comment: "Department managing the perishable rotation, enabling department-level freshness compliance benchmarking."
    - name: "store_location_id"
      expr: store_location_id
      comment: "Store location where the rotation check was performed, used for store-level compliance scorecards."
    - name: "category_id"
      expr: category_id
      comment: "Product category of the perishable item, enabling category-level rotation compliance and waste analysis."
    - name: "event_type"
      expr: event_type
      comment: "Type of rotation event (e.g. scheduled check, exception, markdown trigger), used to categorise rotation activity by driver."
    - name: "rotation_method"
      expr: rotation_method
      comment: "Rotation method applied (e.g. FIFO, FEFO), used to assess compliance by rotation strategy."
    - name: "rotation_compliance_flag"
      expr: rotation_compliance_flag
      comment: "Whether the rotation check found the item in compliance — the primary freshness governance flag."
    - name: "temperature_compliance_flag"
      expr: temperature_compliance_flag
      comment: "Whether temperature compliance was maintained at the time of the rotation check — a food safety KPI."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Expiration date bucketed to month, used to identify near-expiry inventory cohorts requiring immediate rotation or markdown action."
    - name: "rotation_check_month"
      expr: DATE_TRUNC('month', rotation_check_timestamp)
      comment: "Month the rotation check was performed, used for monthly compliance trend reporting."
    - name: "storage_location_id"
      expr: storage_location_id
      comment: "Storage location of the perishable item at time of rotation check, used for location-level freshness compliance analysis."
  measures:
    - name: "total_rotation_checks"
      expr: COUNT(perishable_rotation_id)
      comment: "Total number of perishable rotation checks performed. Measures the coverage and activity of the freshness management programme."
    - name: "rotation_compliant_checks"
      expr: COUNT(CASE WHEN rotation_compliance_flag = TRUE THEN perishable_rotation_id END)
      comment: "Number of rotation checks where compliance was confirmed. Measures the effectiveness of the perishable rotation programme."
    - name: "rotation_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rotation_compliance_flag = TRUE THEN perishable_rotation_id END) / NULLIF(COUNT(perishable_rotation_id), 0), 2)
      comment: "Percentage of perishable rotation checks that were compliant. A headline food safety and waste reduction KPI reviewed by store operations and quality assurance leadership."
    - name: "temperature_non_compliant_rotation_checks"
      expr: COUNT(CASE WHEN temperature_compliance_flag = FALSE THEN perishable_rotation_id END)
      comment: "Number of rotation checks with temperature compliance failures. Measures cold chain risk in perishable storage and handling."
    - name: "temperature_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_compliance_flag = TRUE THEN perishable_rotation_id END) / NULLIF(COUNT(perishable_rotation_id), 0), 2)
      comment: "Percentage of rotation checks meeting temperature compliance requirements. A food safety KPI directly linked to regulatory compliance and product quality."
    - name: "avg_temperature_at_rotation"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature recorded during perishable rotation checks. Used to monitor cold chain performance and identify storage zones with temperature drift."
    - name: "distinct_skus_rotation_checked"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that received a rotation check. Measures the breadth of the freshness management programme across the perishable assortment."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location capacity utilisation and availability metrics. Tracks how effectively storage space is being used, identifies OOS locations, and monitors temperature-controlled zone compliance. Used by store operations, space planning, and supply chain to optimise storage allocation and ensure cold chain infrastructure readiness."
  source: "`grocery_ecm`.`inventory`.`storage_location`"
  dimensions:
    - name: "department_id"
      expr: department_id
      comment: "Department owning the storage location, enabling department-level space utilisation analysis."
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (e.g. shelf, backroom, cooler, freezer), used to segment capacity and utilisation by location type."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Zone classification of the storage location (e.g. ambient, chilled, frozen), used for temperature zone capacity planning."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Whether the location is temperature-controlled, used to segment cold chain vs. ambient storage capacity metrics."
    - name: "storage_location_status"
      expr: storage_location_status
      comment: "Operational status of the storage location (e.g. active, inactive, under maintenance), used to filter available vs. unavailable locations."
    - name: "oos_flag"
      expr: oos_flag
      comment: "Whether the storage location is currently flagged as out of stock, used to identify empty locations requiring replenishment."
    - name: "is_accessible"
      expr: is_accessible
      comment: "Whether the location is currently accessible for picking or stocking, used to identify operational constraints."
    - name: "is_security_restricted"
      expr: is_security_restricted
      comment: "Whether the location has security restrictions (e.g. pharmacy, high-value goods), used for access control and compliance reporting."
    - name: "last_cycle_count_date"
      expr: DATE_TRUNC('month', last_cycle_count_date)
      comment: "Month of the last cycle count at this location, used to identify locations overdue for inventory verification."
  measures:
    - name: "total_storage_locations"
      expr: COUNT(storage_location_id)
      comment: "Total number of storage locations. Baseline capacity metric for space planning and inventory infrastructure management."
    - name: "total_capacity_units"
      expr: SUM(CAST(capacity_units AS DOUBLE))
      comment: "Total unit capacity across all storage locations. Measures the theoretical maximum inventory holding capacity of the estate."
    - name: "total_current_onhand_units"
      expr: SUM(CAST(current_onhand_units AS DOUBLE))
      comment: "Total units currently on hand across all storage locations. Measures actual inventory occupancy of the storage estate."
    - name: "total_available_units"
      expr: SUM(CAST(available_units AS DOUBLE))
      comment: "Total available (uncommitted) units across storage locations. Measures free storage capacity available for new stock."
    - name: "total_reserved_units"
      expr: SUM(CAST(reserved_units AS DOUBLE))
      comment: "Total units reserved across storage locations. Measures committed storage capacity for pending orders and allocations."
    - name: "storage_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(current_onhand_units AS DOUBLE)) / NULLIF(SUM(CAST(capacity_units AS DOUBLE)), 0), 2)
      comment: "Percentage of storage capacity currently occupied. A strategic space planning KPI — high rates indicate replenishment risk; low rates indicate underutilised assets."
    - name: "oos_location_count"
      expr: COUNT(CASE WHEN oos_flag = TRUE THEN storage_location_id END)
      comment: "Number of storage locations currently flagged as out of stock. Measures the breadth of shelf availability gaps requiring replenishment action."
    - name: "oos_location_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oos_flag = TRUE THEN storage_location_id END) / NULLIF(COUNT(storage_location_id), 0), 2)
      comment: "Percentage of storage locations that are out of stock. A headline shelf availability KPI used by store operations to drive restocking prioritisation."
    - name: "total_shrink_units_at_location"
      expr: SUM(CAST(shrink_units AS DOUBLE))
      comment: "Total units lost to shrink across storage locations. Measures location-level shrink exposure for loss prevention targeting."
    - name: "avg_capacity_volume_m3"
      expr: AVG(CAST(capacity_volume_m3 AS DOUBLE))
      comment: "Average volumetric capacity per storage location. Used for space planning and fixture optimisation decisions."
$$;