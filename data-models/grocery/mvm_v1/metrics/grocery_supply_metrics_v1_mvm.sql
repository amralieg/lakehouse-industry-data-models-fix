-- Metric views for domain: supply | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management covering order value, freight costs, vendor acknowledgment rates, and promotional purchasing patterns. Used by supply chain leadership to govern vendor spend and order execution quality."
  source: "`grocery_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g., Open, Closed, Cancelled) — primary filter for active vs. historical order analysis."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g., Standard, Promotional, Emergency) — used to segment spend by procurement strategy."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Method of shipment for the order (e.g., LTL, FTL, Parcel) — used to analyze freight cost drivers by transport mode."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated — essential for multi-currency spend normalization."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms with the supplier (e.g., Net 30, Net 60) — used to assess cash flow exposure by vendor terms."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates whether the order requires cold-chain handling — used to segment temperature-sensitive procurement spend."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the purchase order is tied to a promotional event — used to isolate promotional vs. everyday replenishment spend."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month-truncated order creation date — primary time dimension for trending purchase order volume and spend over time."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery responsibility — used to segment freight liability and landed cost analysis."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement activity tracking."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Sum of total order amounts across all purchase orders — primary spend KPI for procurement budget governance."
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Sum of total PO values (may include allowances and adjustments) — used alongside total_order_value to reconcile gross vs. net procurement spend."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges across all purchase orders — key cost driver for supply chain logistics spend analysis."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowances earned on purchase orders — measures vendor funding captured through procurement negotiations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges on purchase orders — used for tax liability reporting and landed cost calculations."
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_amount AS DOUBLE))
      comment: "Average value per purchase order — used to benchmark order sizing efficiency and identify over/under-ordering patterns."
    - name: "vendor_acknowledgment_rate"
      expr: ROUND(100.0 * SUM(CAST(vendor_acknowledgment_received_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders where vendor acknowledgment was received — measures supplier responsiveness and EDI compliance, a leading indicator of on-time delivery risk."
    - name: "edi_transmission_rate"
      expr: ROUND(100.0 * SUM(CAST(edi_transmission_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders transmitted via EDI — measures digital procurement adoption and automation efficiency."
    - name: "promotional_po_rate"
      expr: ROUND(100.0 * SUM(CAST(promotional_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders tied to promotional events — used to assess promotional procurement burden on supply chain capacity."
    - name: "freight_cost_per_order"
      expr: ROUND(SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average freight cost per purchase order — used to benchmark logistics efficiency and identify high-cost shipping patterns."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level purchase order KPIs covering ordered vs. received quantities, unit costs, extended costs, and fill performance. Used by buyers and supply planners to manage item-level procurement accuracy and vendor fill compliance."
  source: "`grocery_ecm`.`supply`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line (e.g., Open, Received, Cancelled) — primary filter for active vs. closed line analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of delivery for the PO line (e.g., DC, DSD) — used to segment procurement by supply chain channel."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature handling requirement for the line item (e.g., Ambient, Refrigerated, Frozen) — used to analyze cold-chain procurement volumes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the PO line transaction — used for multi-currency cost normalization."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the line item is a private-label product — used to segment own-brand vs. national brand procurement spend."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Indicates whether the line item is organically certified — used to track organic procurement volumes and costs."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the line item contains hazardous materials — used for compliance reporting and special handling cost analysis."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month-truncated requested delivery date — used to trend procurement demand by delivery period."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity (e.g., EACH, CASE, PALLET) — required for accurate quantity aggregation and comparison."
  measures:
    - name: "total_po_lines"
      expr: COUNT(1)
      comment: "Total number of PO lines — baseline volume metric for procurement line activity."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all PO lines — primary volume KPI for procurement demand planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units received against PO lines — measures actual inbound supply fulfillment."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total units invoiced by suppliers — used to reconcile received vs. billed quantities for accounts payable accuracy."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × quantity) across all PO lines — primary cost of goods purchased metric."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges at the PO line level — used to allocate logistics costs to individual SKUs and categories."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowances at the line level — measures item-level vendor funding captured through trade terms."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across PO lines — used to benchmark cost trends by supplier, category, and time period."
    - name: "po_line_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received — critical vendor fill rate KPI that directly impacts in-stock availability and customer satisfaction."
    - name: "invoice_to_order_quantity_ratio"
      expr: ROUND(SUM(CAST(invoiced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of invoiced to ordered quantity — used to detect overbilling or underbilling by suppliers, a key accounts payable control metric."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound receiving quality and throughput KPIs covering acceptance rates, rejection rates, OSD (over/short/damaged) incidents, temperature compliance, and inspection outcomes. Used by DC operations and quality teams to govern inbound supply quality."
  source: "`grocery_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the goods receipt (e.g., Complete, Pending, Rejected) — primary filter for receipt processing pipeline analysis."
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of goods receipt (e.g., PO Receipt, Transfer, Return) — used to segment inbound volume by supply source."
    - name: "putaway_status"
      expr: putaway_status
      comment: "Status of putaway execution for the receipt — used to identify bottlenecks in DC inbound processing throughput."
    - name: "osd_type"
      expr: osd_type
      comment: "Type of over/short/damaged discrepancy (e.g., Over, Short, Damaged) — used to classify inbound quality failures by root cause."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the quality inspection (e.g., Pass, Fail, Conditional) — used to track supplier quality performance over time."
    - name: "dsd_flag"
      expr: dsd_flag
      comment: "Indicates whether the receipt is a Direct Store Delivery — used to segment DC-routed vs. DSD inbound quality metrics."
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Indicates whether the receipt was processed as a cross-dock — used to measure cross-dock throughput and quality separately from standard putaway."
    - name: "receipt_date"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month-truncated receipt date — primary time dimension for trending inbound receiving volume and quality over time."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the received shipment met temperature requirements — used to monitor cold-chain compliance at point of receipt."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts — baseline inbound volume metric for DC receiving throughput."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_received_quantity AS DOUBLE))
      comment: "Total units received across all goods receipts — primary inbound volume KPI for supply chain throughput measurement."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(total_accepted_quantity AS DOUBLE))
      comment: "Total units accepted after inspection — measures usable inbound supply available for putaway and replenishment."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(total_rejected_quantity AS DOUBLE))
      comment: "Total units rejected at receipt — measures inbound quality failures that reduce available inventory and increase reverse logistics costs."
    - name: "receipt_acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(total_accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received units that pass acceptance — primary inbound quality KPI; low rates signal supplier quality issues or cold-chain failures."
    - name: "receipt_rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(total_rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received units rejected — used to identify high-rejection suppliers and drive corrective action with vendor quality teams."
    - name: "osd_incident_rate"
      expr: ROUND(100.0 * SUM(CAST(osd_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with an over/short/damaged discrepancy — key inbound quality metric used to benchmark supplier and carrier performance."
    - name: "temperature_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(temperature_compliant_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts meeting temperature compliance requirements — critical cold-chain KPI for food safety and regulatory compliance."
    - name: "inspection_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(inspection_completed_flag AS INT)) / NULLIF(SUM(CAST(inspection_required_flag AS INT)), 0), 2)
      comment: "Percentage of required inspections that were completed — measures quality control process adherence and identifies inspection backlog risk."
    - name: "avg_temperature_at_receipt"
      expr: AVG(CAST(temperature_at_receipt AS DOUBLE))
      comment: "Average temperature recorded at point of receipt — used to monitor cold-chain integrity trends and identify systemic temperature excursion patterns."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment performance KPIs covering on-time arrival, freight costs, temperature compliance, and receiving throughput. Used by supply chain operations and carrier management teams to govern inbound logistics performance."
  source: "`grocery_ecm`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g., In Transit, Received, Delayed) — primary filter for active shipment pipeline monitoring."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of inbound shipment (e.g., Full Truckload, LTL, Parcel) — used to segment freight cost and performance by transport mode."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for the shipment (e.g., DC, Store, Cross-Dock) — used to analyze inbound flow by supply chain node type."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the shipment (e.g., Standard, Expedited, Critical) — used to assess expedite frequency and associated cost premiums."
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Indicates whether the shipment is designated for cross-docking — used to measure cross-dock utilization and throughput efficiency."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the shipment maintained required temperature throughout transit — critical cold-chain compliance dimension."
    - name: "scheduled_arrival_date"
      expr: DATE_TRUNC('month', scheduled_arrival_date)
      comment: "Month-truncated scheduled arrival date — primary time dimension for trending inbound shipment volume and on-time performance."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (e.g., Prepaid, Collect, Third Party) — used to segment freight cost responsibility and analyze carrier billing patterns."
    - name: "temperature_requirement"
      expr: temperature_requirement
      comment: "Temperature handling requirement for the shipment (e.g., Ambient, Refrigerated, Frozen) — used to segment cold-chain vs. ambient inbound volumes."
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(1)
      comment: "Total number of inbound shipments — baseline volume metric for inbound logistics throughput."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total inbound freight cost across all shipments — primary logistics spend KPI for carrier cost management and budget governance."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per inbound shipment — used to benchmark carrier efficiency and identify cost outliers by route or carrier."
    - name: "total_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total inbound weight in pounds — used to calculate freight cost per pound and assess DC receiving capacity utilization."
    - name: "total_cube_ft"
      expr: SUM(CAST(total_cube_ft AS DOUBLE))
      comment: "Total cubic footage of inbound shipments — used to measure DC dock and storage capacity utilization."
    - name: "temperature_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(temperature_compliant_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inbound shipments meeting temperature compliance requirements — critical food safety KPI for cold-chain integrity governance."
    - name: "receiving_discrepancy_rate"
      expr: ROUND(100.0 * SUM(CAST(receiving_discrepancy_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inbound shipments with a receiving discrepancy — measures inbound accuracy and supplier/carrier reliability."
    - name: "cross_dock_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(cross_dock_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inbound shipments processed as cross-dock — measures cross-dock strategy adoption and DC throughput efficiency."
    - name: "freight_cost_per_lb"
      expr: ROUND(SUM(CAST(freight_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_weight_lbs AS DOUBLE)), 0), 4)
      comment: "Freight cost per pound of inbound goods — normalized logistics efficiency metric used to compare carrier and route cost performance."
    - name: "haccp_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(haccp_compliant_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inbound shipments meeting HACCP compliance standards — regulatory compliance KPI for food safety governance."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order execution KPIs covering fill rates, order quantities, shipment accuracy, and cold-chain compliance. Used by replenishment planners and store operations to govern in-stock performance and DC-to-store supply reliability."
  source: "`grocery_ecm`.`supply`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g., Open, Shipped, Delivered, Cancelled) — primary filter for active replenishment pipeline monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g., Auto, Manual, Emergency) — used to segment planned vs. reactive replenishment activity."
    - name: "replenishment_trigger"
      expr: replenishment_trigger
      comment: "Business event that triggered the replenishment order (e.g., Min/Max, Forecast, Manual) — used to evaluate replenishment strategy effectiveness."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for the replenishment (e.g., Store, Pharmacy, Fuel Center) — used to segment replenishment performance by store format."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replenishment order (e.g., Standard, High, Critical) — used to assess expedite frequency and its impact on logistics costs."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates whether the replenishment requires cold-chain handling — used to segment temperature-sensitive replenishment performance."
    - name: "cross_dock_eligible_flag"
      expr: cross_dock_eligible_flag
      comment: "Indicates whether the order is eligible for cross-docking — used to measure cross-dock strategy utilization in replenishment."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month-truncated order creation date — primary time dimension for trending replenishment volume and fill performance over time."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for the replenishment order (e.g., Ambient, Refrigerated, Frozen) — used to analyze cold-chain replenishment volumes and compliance."
  measures:
    - name: "total_replenishment_orders"
      expr: COUNT(1)
      comment: "Total number of replenishment orders — baseline volume metric for replenishment activity and DC outbound throughput."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(total_ordered_quantity AS DOUBLE))
      comment: "Total units ordered for replenishment — primary demand volume KPI for DC picking and outbound planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(total_shipped_quantity AS DOUBLE))
      comment: "Total units shipped on replenishment orders — measures actual DC outbound fulfillment volume."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_received_quantity AS DOUBLE))
      comment: "Total units received at destination stores — measures end-to-end replenishment delivery completion."
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average fill rate percentage across replenishment orders — primary in-stock KPI; low fill rates directly cause on-shelf availability failures and lost sales."
    - name: "replenishment_ship_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(total_shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered replenishment units actually shipped — measures DC execution accuracy and identifies supply constraints impacting store replenishment."
    - name: "replenishment_receipt_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(total_received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered replenishment units received at destination — end-to-end fill rate KPI that captures both DC and transit losses."
    - name: "total_cube_volume"
      expr: SUM(CAST(total_cube_volume AS DOUBLE))
      comment: "Total cubic volume of replenishment orders — used to measure DC outbound capacity utilization and trailer fill efficiency."
    - name: "total_weight"
      expr: SUM(CAST(total_weight AS DOUBLE))
      comment: "Total weight of replenishment orders in lbs — used alongside cube volume to assess trailer capacity utilization and freight cost drivers."
    - name: "approval_required_rate"
      expr: ROUND(100.0 * SUM(CAST(approval_required_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replenishment orders requiring manual approval — measures process automation efficiency; high rates indicate over-reliance on manual intervention."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting accuracy and quality KPIs covering MAPE, forecast bias, confidence scores, safety stock, and promotional lift. Used by demand planning teams and supply chain leadership to govern forecast quality and its downstream impact on inventory and service levels."
  source: "`grocery_ecm`.`supply`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (e.g., Draft, Approved, Superseded) — used to filter to active, approved forecasts for planning decisions."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Statistical or ML method used to generate the forecast (e.g., ARIMA, Exponential Smoothing, ML Ensemble) — used to compare accuracy across forecasting approaches."
    - name: "forecast_model_name"
      expr: forecast_model_name
      comment: "Name of the specific forecast model used — used to benchmark model performance and drive model selection decisions."
    - name: "new_product_indicator"
      expr: new_product_indicator
      comment: "Indicates whether the forecast is for a new product introduction — used to segment NPI forecast accuracy separately from established item forecasting."
    - name: "forecast_period_start_date"
      expr: DATE_TRUNC('month', forecast_period_start_date)
      comment: "Month-truncated forecast period start date — primary time dimension for trending forecast accuracy and volume over planning horizons."
    - name: "forecast_horizon_weeks"
      expr: forecast_horizon_weeks
      comment: "Number of weeks in the forecast horizon — used to analyze how forecast accuracy degrades at longer planning horizons."
    - name: "override_reason_code"
      expr: override_reason_code
      comment: "Reason code for manual forecast overrides — used to measure override frequency and identify systematic model weaknesses requiring correction."
  measures:
    - name: "total_forecasts"
      expr: COUNT(1)
      comment: "Total number of demand forecast records — baseline volume metric for forecast coverage and planning activity."
    - name: "total_forecast_units"
      expr: SUM(CAST(total_forecast_units AS DOUBLE))
      comment: "Total forecasted demand units — primary demand signal KPI used to size procurement, replenishment, and DC capacity plans."
    - name: "total_baseline_forecast_units"
      expr: SUM(CAST(baseline_forecast_units AS DOUBLE))
      comment: "Total baseline (pre-promotional) forecast units — used to isolate underlying demand trends from promotional lift effects."
    - name: "total_promotional_lift_units"
      expr: SUM(CAST(promotional_lift_units AS DOUBLE))
      comment: "Total incremental units attributed to promotional events — measures the supply chain impact of promotional activity on demand."
    - name: "total_safety_stock_units"
      expr: SUM(CAST(safety_stock_units AS DOUBLE))
      comment: "Total safety stock units planned across all forecasts — measures inventory buffer investment required to achieve target service levels."
    - name: "avg_mape"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across forecasts — primary forecast accuracy KPI; high MAPE drives excess inventory or stockouts, directly impacting margin and service levels."
    - name: "avg_forecast_bias_percentage"
      expr: AVG(CAST(forecast_bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage — measures systematic over- or under-forecasting; persistent bias causes chronic overstock or stockout conditions."
    - name: "avg_forecast_confidence_score"
      expr: AVG(CAST(forecast_confidence_score AS DOUBLE))
      comment: "Average model confidence score across forecasts — used to identify low-confidence forecasts requiring planner review and override."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for forecast inputs — measures the reliability of demand signals feeding the forecast engine; low scores indicate data governance issues."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient across items — measures demand volatility; high variability drives safety stock requirements and replenishment complexity."
    - name: "promotional_lift_share"
      expr: ROUND(100.0 * SUM(CAST(promotional_lift_units AS DOUBLE)) / NULLIF(SUM(CAST(total_forecast_units AS DOUBLE)), 0), 2)
      comment: "Percentage of total forecasted demand attributable to promotional lift — measures promotional dependency in the demand plan and its supply chain implications."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_allocation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation planning KPIs covering fill rate performance, plan execution status, and supply constraint indicators. Used by allocation analysts and merchandising leadership to govern product allocation accuracy and promotional event readiness."
  source: "`grocery_ecm`.`supply`.`allocation_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the allocation plan (e.g., Draft, Approved, Released, Completed) — primary filter for active vs. historical allocation analysis."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., Promotional, Seasonal, Everyday) — used to segment allocation performance by business purpose."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to calculate the allocation (e.g., Sales History, Forecast, Equal Split) — used to evaluate allocation strategy effectiveness."
    - name: "allocation_strategy_code"
      expr: allocation_strategy_code
      comment: "Strategy code governing the allocation logic — used to benchmark fill rate performance across different allocation strategies."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the allocation plan — used to assess whether high-priority allocations achieve better fill rates than standard plans."
    - name: "constrained_supply_flag"
      expr: constrained_supply_flag
      comment: "Indicates whether the allocation was executed under supply constraint conditions — used to quantify the frequency and impact of supply shortages on allocation outcomes."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates whether the allocated product requires cold-chain handling — used to segment temperature-sensitive allocation performance."
    - name: "seasonal_event"
      expr: seasonal_event
      comment: "Seasonal or promotional event associated with the allocation (e.g., Thanksgiving, Back-to-School) — used to analyze allocation performance by key retail events."
    - name: "plan_created_date"
      expr: DATE_TRUNC('month', plan_created_date)
      comment: "Month-truncated plan creation date — primary time dimension for trending allocation volume and fill performance over planning cycles."
  measures:
    - name: "total_allocation_plans"
      expr: COUNT(1)
      comment: "Total number of allocation plans — baseline volume metric for allocation planning activity."
    - name: "avg_actual_fill_rate_pct"
      expr: AVG(CAST(actual_fill_rate_pct AS DOUBLE))
      comment: "Average actual fill rate percentage across allocation plans — primary allocation execution KPI; low fill rates signal supply constraints or planning failures impacting on-shelf availability."
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average fill rate target percentage across allocation plans — used as the benchmark against actual fill rate to measure allocation plan attainment."
    - name: "fill_rate_attainment"
      expr: ROUND(AVG(CAST(actual_fill_rate_pct AS DOUBLE)) / NULLIF(AVG(CAST(fill_rate_target_pct AS DOUBLE)), 0) * 100.0, 2)
      comment: "Actual fill rate as a percentage of target fill rate — measures how well allocation execution meets planned service level commitments."
    - name: "constrained_supply_rate"
      expr: ROUND(100.0 * SUM(CAST(constrained_supply_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocation plans executed under supply constraint — measures supply shortage frequency and its potential impact on store in-stock levels."
    - name: "cold_chain_allocation_rate"
      expr: ROUND(100.0 * SUM(CAST(cold_chain_required_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocation plans requiring cold-chain handling — used to plan DC cold-chain capacity and assess temperature-sensitive product allocation complexity."
    - name: "endcap_display_allocation_rate"
      expr: ROUND(100.0 * SUM(CAST(endcap_display_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocation plans designated for endcap display — measures promotional display allocation intensity and its supply chain demand implications."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_vendor_lead_time`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor lead time performance KPIs covering total lead time, order-to-ship days, transit days, safety stock requirements, and fill rate performance. Used by procurement and supply planning teams to govern supplier reliability and optimize reorder point calculations."
  source: "`grocery_ecm`.`supply`.`vendor_lead_time`"
  dimensions:
    - name: "lead_time_status"
      expr: lead_time_status
      comment: "Current status of the lead time record (e.g., Active, Expired, Pending) — used to filter to current, actionable lead time data."
    - name: "lead_time_tier"
      expr: lead_time_tier
      comment: "Tier classification of the lead time (e.g., Standard, Expedited, Emergency) — used to segment lead time performance by service level tier."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation for the lead time (e.g., Truck, Rail, Air) — used to analyze lead time and cost trade-offs by transport mode."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for the lead time (e.g., DC, Store, Pharmacy) — used to segment lead time performance by supply chain node."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates whether cold-chain handling is required — used to compare lead times for temperature-sensitive vs. ambient products."
    - name: "seasonal_period_code"
      expr: seasonal_period_code
      comment: "Seasonal period code for the lead time record — used to analyze how lead times fluctuate during peak seasons and plan safety stock accordingly."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterm governing the shipment — used to segment lead time by delivery responsibility and identify where transit time risk lies."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month-truncated effective date of the lead time record — used to trend lead time changes over time and assess supplier improvement or degradation."
  measures:
    - name: "total_lead_time_records"
      expr: COUNT(1)
      comment: "Total number of vendor lead time records — baseline volume metric for lead time data coverage across supplier-SKU-DC combinations."
    - name: "avg_total_lead_time_days"
      expr: AVG(CAST(total_lead_time_days AS DOUBLE))
      comment: "Average total lead time in days from order placement to receipt — primary supplier reliability KPI that directly drives reorder point and safety stock calculations."
    - name: "avg_order_to_ship_days"
      expr: AVG(CAST(order_to_ship_days AS DOUBLE))
      comment: "Average days from order placement to supplier shipment — measures supplier processing speed and identifies order fulfillment bottlenecks at the vendor."
    - name: "avg_ship_to_receipt_days"
      expr: AVG(CAST(ship_to_receipt_days AS DOUBLE))
      comment: "Average days from supplier shipment to DC receipt — measures transit time performance and identifies carrier or route reliability issues."
    - name: "avg_safety_stock_days"
      expr: AVG(CAST(safety_stock_days AS DOUBLE))
      comment: "Average safety stock days held across supplier-SKU combinations — measures inventory buffer investment required to absorb lead time variability."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days — measures supplier consistency; high variability drives excess safety stock and increases inventory carrying costs."
    - name: "avg_vendor_fill_rate_percent"
      expr: AVG(CAST(vendor_fill_rate_percent AS DOUBLE))
      comment: "Average vendor fill rate percentage across lead time records — measures supplier ability to fulfill orders completely, a key input to safety stock and reorder point models."
    - name: "avg_seasonal_adjustment_factor"
      expr: AVG(CAST(seasonal_adjustment_factor AS DOUBLE))
      comment: "Average seasonal adjustment factor applied to lead times — measures the magnitude of seasonal lead time inflation and its impact on peak season inventory planning."
    - name: "lead_time_to_safety_stock_ratio"
      expr: ROUND(AVG(CAST(total_lead_time_days AS DOUBLE)) / NULLIF(AVG(CAST(safety_stock_days AS DOUBLE)), 0), 2)
      comment: "Ratio of average total lead time to average safety stock days — measures whether safety stock coverage is proportionate to lead time exposure; ratios below 1.0 indicate under-buffered supply risk."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_dc_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DC-to-DC and DC-to-store transfer KPIs covering freight costs, on-time delivery, damage and shortage rates, and transfer volume. Used by distribution and logistics teams to govern inter-facility transfer efficiency and cost performance."
  source: "`grocery_ecm`.`supply`.`dc_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the DC transfer (e.g., In Transit, Delivered, Cancelled) — primary filter for active transfer pipeline monitoring."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g., DC-to-DC, DC-to-Store, Emergency) — used to segment transfer performance by supply chain flow type."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Business reason for the transfer (e.g., Rebalancing, Promotional, Shortage Cover) — used to analyze transfer cost drivers by business purpose."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer (e.g., Standard, Expedited) — used to assess expedite frequency and associated cost premiums."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location (e.g., DC, Store, Pharmacy) — used to segment transfer performance by destination node type."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone for the transfer (e.g., Ambient, Refrigerated, Frozen) — used to segment cold-chain transfer performance and costs."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Indicates whether the transfer was delivered on time — used as a dimension to filter and compare on-time vs. late transfer characteristics."
    - name: "transfer_date"
      expr: DATE_TRUNC('month', transfer_date)
      comment: "Month-truncated transfer date — primary time dimension for trending transfer volume, cost, and quality over time."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of DC transfers — baseline volume metric for inter-facility transfer activity."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost for DC transfers in USD — primary logistics spend KPI for transfer cost management and budget governance."
    - name: "avg_freight_cost_per_transfer"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per DC transfer — used to benchmark transfer efficiency and identify high-cost transfer lanes or routes."
    - name: "total_cube_cf"
      expr: SUM(CAST(total_cube_cf AS DOUBLE))
      comment: "Total cubic footage transferred — used to measure trailer utilization and DC outbound capacity consumption."
    - name: "total_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight transferred in pounds — used alongside cube to assess trailer fill efficiency and freight cost per unit weight."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(on_time_delivery_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DC transfers delivered on time — primary logistics service level KPI; low rates signal carrier or routing issues impacting store replenishment."
    - name: "damage_reported_rate"
      expr: ROUND(100.0 * SUM(CAST(damage_reported_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers with damage reported — measures product integrity during transit; high rates drive shrink costs and store receiving rejections."
    - name: "shortage_reported_rate"
      expr: ROUND(100.0 * SUM(CAST(shortage_reported_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transfers with a shortage reported — measures transfer accuracy and identifies systemic picking or loading errors at origin DCs."
    - name: "freight_cost_per_cf"
      expr: ROUND(SUM(CAST(freight_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_cube_cf AS DOUBLE)), 0), 4)
      comment: "Freight cost per cubic foot transferred — normalized logistics efficiency metric used to compare cost performance across transfer lanes and carrier contracts."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`supply_direct_store_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct Store Delivery (DSD) KPIs covering invoice amounts, discrepancy rates, temperature compliance, and payment terms performance. Used by store operations and accounts payable teams to govern DSD supplier performance and invoice accuracy."
  source: "`grocery_ecm`.`supply`.`direct_store_delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the DSD delivery (e.g., Scheduled, Delivered, Discrepancy) — primary filter for active DSD pipeline monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the DSD invoice — used for multi-currency DSD spend normalization."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the DSD supplier — used to assess cash flow exposure and early payment discount capture."
    - name: "temperature_compliance_flag"
      expr: temperature_compliance_flag
      comment: "Indicates whether the DSD delivery met temperature requirements — critical cold-chain compliance dimension for perishable DSD categories."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a discrepancy was identified on the DSD delivery — used to segment clean vs. disputed deliveries for accounts payable analysis."
    - name: "quality_inspection_flag"
      expr: quality_inspection_flag
      comment: "Indicates whether a quality inspection was performed on the DSD delivery — used to measure inspection coverage and its correlation with discrepancy rates."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month-truncated scheduled delivery date — primary time dimension for trending DSD volume and invoice amounts over time."
  measures:
    - name: "total_dsd_deliveries"
      expr: COUNT(1)
      comment: "Total number of DSD deliveries — baseline volume metric for DSD supplier activity and store receiving workload."
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total DSD invoice amount — primary spend KPI for DSD supplier cost management and accounts payable budget governance."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts — measures actual DSD spend net of trade discounts and allowances."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts captured on DSD invoices — measures trade discount realization from DSD supplier agreements."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges on DSD invoices — used for tax liability reporting and landed cost calculations."
    - name: "dsd_discrepancy_rate"
      expr: ROUND(100.0 * SUM(CAST(discrepancy_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSD deliveries with a discrepancy — measures DSD supplier delivery accuracy; high rates drive accounts payable disputes and store receiving inefficiency."
    - name: "temperature_compliance_rate"
      expr: ROUND(100.0 * SUM(CAST(temperature_compliance_flag AS INT)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DSD deliveries meeting temperature compliance — critical food safety KPI for perishable DSD categories such as dairy, bakery, and beverages."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average DSD invoice amount per delivery — used to benchmark DSD order sizing and identify anomalous invoice values for audit purposes."
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoice_amount AS DOUBLE)), 0), 2)
      comment: "Discount amount as a percentage of gross invoice amount — measures trade discount realization efficiency from DSD supplier contracts."
$$;