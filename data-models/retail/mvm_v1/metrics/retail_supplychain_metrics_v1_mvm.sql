-- Metric views for domain: supplychain | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order performance, supplier fill rates, procurement spend, and on-time delivery compliance. Used by supply chain leadership to evaluate vendor reliability and procurement efficiency."
  source: "`retail_ecm`.`supplychain`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., Open, Closed, Cancelled) for pipeline and backlog analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Drop-Ship) to segment procurement patterns."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO, enabling governance and compliance tracking."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Trade terms governing delivery responsibility, used to analyze landed cost and risk allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order for multi-currency spend analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates whether the PO is fulfilled via cross-docking, supporting flow-through vs. storage analysis."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Indicates direct vendor-to-customer fulfillment, relevant for drop-ship program performance."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order placement for trend and seasonality analysis of procurement activity."
    - name: "expected_delivery_date"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Expected delivery month for forward-looking supply pipeline visibility."
    - name: "purchasing_org_code"
      expr: purchasing_org_code
      comment: "Purchasing organization responsible for the PO, enabling org-level spend accountability."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms agreed with the vendor, used for cash flow and working capital analysis."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement activity tracking."
    - name: "total_procurement_spend"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Total committed procurement spend across all purchase orders. Core financial KPI for budget vs. actuals and spend management."
    - name: "avg_po_value"
      expr: AVG(CAST(total_order_amount AS DOUBLE))
      comment: "Average value per purchase order. Indicates order consolidation efficiency and vendor negotiation leverage."
    - name: "total_ordered_units"
      expr: SUM(CAST(total_ordered_units AS DOUBLE))
      comment: "Total units ordered across all POs. Drives inventory planning and capacity forecasting."
    - name: "total_received_units"
      expr: SUM(CAST(total_received_units AS DOUBLE))
      comment: "Total units actually received against purchase orders. Used to compute receipt completion and supplier reliability."
    - name: "avg_supplier_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average supplier fill rate percentage across POs. Critical KPI for vendor performance scorecards — low fill rates signal supply risk."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total vendor discounts captured across POs. Measures procurement negotiation effectiveness and cost savings."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after discounts. Represents actual cash outflow obligation for accounts payable planning."
    - name: "on_time_delivery_po_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= confirmed_delivery_date THEN 1 END)
      comment: "Number of POs delivered on or before the confirmed delivery date. Numerator for on-time delivery rate calculation."
    - name: "po_with_confirmed_delivery_count"
      expr: COUNT(CASE WHEN confirmed_delivery_date IS NOT NULL THEN 1 END)
      comment: "Number of POs with a confirmed delivery date. Denominator for on-time delivery rate and scheduling compliance metrics."
    - name: "cancelled_po_count"
      expr: COUNT(CASE WHEN po_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled purchase orders. High cancellation rates signal demand volatility or vendor instability."
    - name: "open_po_count"
      expr: COUNT(CASE WHEN po_status = 'Open' THEN 1 END)
      comment: "Number of open (unfulfilled) purchase orders. Represents active supply pipeline and outstanding commitments."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level purchase order metrics for SKU-level procurement performance, cost analysis, and receipt compliance. Enables granular vendor and item-level supply chain decisions."
  source: "`retail_ecm`.`supplychain`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (e.g., Open, Received, Cancelled) for line-level pipeline tracking."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for the PO line (e.g., DC, Store, Drop-Ship) to analyze fulfillment routing."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the ordered item is manufactured. Critical for trade compliance, tariff analysis, and supply diversification."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the PO line for multi-currency cost analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms for the PO line governing delivery risk and cost responsibility."
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Indicates whether the ordered quantity meets the minimum order quantity requirement. Used for vendor compliance tracking."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery for supply pipeline and demand alignment analysis."
    - name: "actual_delivery_date"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month of actual delivery for on-time performance trending."
  measures:
    - name: "total_po_lines"
      expr: COUNT(1)
      comment: "Total number of PO lines. Baseline volume metric for procurement granularity and workload analysis."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × quantity) across all PO lines. Primary cost-of-goods metric for procurement spend analysis."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost after allowances across all PO lines. Represents true landed cost basis for margin calculations."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowances and rebates captured at line level. Measures vendor funding and cost reduction effectiveness."
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total units ordered across all PO lines. Core supply volume metric for inventory planning."
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total units received against PO lines. Used to measure receipt completion and identify open receipts."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total units shipped by the vendor. Enables in-transit quantity tracking and shipment-to-receipt reconciliation."
    - name: "total_confirmed_qty"
      expr: SUM(CAST(confirmed_qty AS DOUBLE))
      comment: "Total vendor-confirmed order quantity. Measures vendor commitment vs. original order for supply risk assessment."
    - name: "total_otb_consumed"
      expr: SUM(CAST(otb_consumed AS DOUBLE))
      comment: "Total Open-to-Buy budget consumed by PO lines. Critical for merchandise financial planning and budget compliance."
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail price across ordered items. Used to assess margin potential and pricing strategy alignment with procurement."
    - name: "on_time_delivery_line_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= confirmed_delivery_date THEN 1 END)
      comment: "Number of PO lines delivered on or before confirmed date. Numerator for line-level on-time delivery rate."
    - name: "moq_non_compliant_line_count"
      expr: COUNT(CASE WHEN moq_compliant = False THEN 1 END)
      comment: "Number of PO lines that do not meet minimum order quantity requirements. Signals vendor negotiation or ordering process issues."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment performance metrics covering on-time arrival, receipt accuracy, freight cost, and temperature compliance. Used by DC operations and supply chain leadership to manage inbound flow efficiency."
  source: "`retail_ecm`.`supplychain`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g., In Transit, Received, Exception) for pipeline visibility."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of inbound shipment (e.g., Vendor, Transfer, Return) to segment inbound flow by origin type."
    - name: "on_time_arrival_flag"
      expr: on_time_arrival_flag
      comment: "Indicates whether the shipment arrived on or before the expected arrival date. Key carrier and vendor performance dimension."
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Indicates cross-dock shipments that bypass storage, enabling flow-through efficiency analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates temperature-sensitive shipments requiring cold chain compliance."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether temperature requirements were maintained throughout transit. Critical for food safety and regulatory compliance."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates hazardous materials shipments requiring special handling and regulatory compliance."
    - name: "freight_currency_code"
      expr: freight_currency_code
      comment: "Currency of freight cost for multi-currency logistics spend analysis."
    - name: "expected_arrival_date"
      expr: DATE_TRUNC('month', expected_arrival_date)
      comment: "Month of expected arrival for inbound supply pipeline planning."
    - name: "actual_arrival_date"
      expr: DATE_TRUNC('month', actual_arrival_date)
      comment: "Month of actual arrival for inbound volume trending and capacity planning."
    - name: "late_arrival_reason_code"
      expr: late_arrival_reason_code
      comment: "Reason code for late arrivals, enabling root cause analysis of inbound delays."
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(1)
      comment: "Total number of inbound shipments. Baseline volume metric for DC inbound workload planning."
    - name: "on_time_arrival_count"
      expr: COUNT(CASE WHEN on_time_arrival_flag = True THEN 1 END)
      comment: "Number of shipments that arrived on time. Numerator for on-time inbound arrival rate — key carrier and vendor KPI."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total inbound freight cost. Core logistics spend metric for carrier contract management and cost-per-unit analysis."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per inbound shipment. Benchmarks carrier efficiency and identifies cost outliers."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total units shipped by vendors. Measures inbound supply volume for DC capacity and labor planning."
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total units received at the DC. Used to compute receipt-to-shipment variance and identify shrinkage."
    - name: "total_unit_variance_qty"
      expr: SUM(CAST(unit_variance_quantity AS DOUBLE))
      comment: "Total unit variance between shipped and received quantities. Measures inbound accuracy and vendor compliance — high variance drives investigation."
    - name: "total_expected_weight_kg"
      expr: SUM(CAST(expected_weight_kg AS DOUBLE))
      comment: "Total expected inbound weight in kilograms. Used for dock scheduling, equipment planning, and freight audit."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual received weight in kilograms. Enables weight-based freight reconciliation and billing verification."
    - name: "temperature_non_compliant_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = True AND temperature_compliant_flag = False THEN 1 END)
      comment: "Number of temperature-controlled shipments that failed compliance. Critical food safety and quality KPI — drives vendor corrective action."
    - name: "total_expected_cube_m3"
      expr: SUM(CAST(expected_cube_m3 AS DOUBLE))
      comment: "Total expected inbound cube in cubic meters. Used for dock door scheduling and unloading resource planning."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_receiving_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DC receiving quality and throughput metrics covering damage rates, discrepancies, temperature compliance, and putaway readiness. Used by DC operations managers to optimize inbound quality and labor efficiency."
  source: "`retail_ecm`.`supplychain`.`receiving_event`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving event (e.g., Complete, Partial, Exception) for inbound workflow tracking."
    - name: "receiving_type"
      expr: receiving_type
      comment: "Type of receiving event (e.g., Standard, Cross-Dock, Return) to segment inbound processing patterns."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates whether damaged goods were identified during receiving. Key quality dimension for vendor claims and shrink analysis."
    - name: "shortage_flag"
      expr: shortage_flag
      comment: "Indicates a shortage vs. expected quantity. Used to identify vendor fill rate issues and trigger claims."
    - name: "overage_flag"
      expr: overage_flag
      comment: "Indicates an overage vs. expected quantity. Used for inventory accuracy and vendor billing reconciliation."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates cold chain compliance at point of receipt. Critical for food safety regulatory compliance."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates hazardous materials received, requiring special handling and compliance documentation."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates items requiring quality inspection before putaway, affecting throughput and labor planning."
    - name: "discrepancy_reason_code"
      expr: discrepancy_reason_code
      comment: "Reason code for receiving discrepancies, enabling root cause analysis and vendor corrective action."
    - name: "unload_start_timestamp"
      expr: DATE_TRUNC('day', unload_start_timestamp)
      comment: "Day of unload start for daily receiving volume and throughput trending."
  measures:
    - name: "total_receiving_events"
      expr: COUNT(1)
      comment: "Total number of receiving events. Baseline inbound throughput metric for DC labor and dock planning."
    - name: "damaged_receiving_event_count"
      expr: COUNT(CASE WHEN damage_flag = True THEN 1 END)
      comment: "Number of receiving events with damage identified. Drives vendor claims, quality programs, and carrier accountability."
    - name: "shortage_event_count"
      expr: COUNT(CASE WHEN shortage_flag = True THEN 1 END)
      comment: "Number of receiving events with unit shortages. Measures vendor fill accuracy and triggers supply chain investigation."
    - name: "overage_event_count"
      expr: COUNT(CASE WHEN overage_flag = True THEN 1 END)
      comment: "Number of receiving events with unit overages. Used for inventory accuracy and vendor billing reconciliation."
    - name: "temperature_non_compliant_event_count"
      expr: COUNT(CASE WHEN temperature_compliant_flag = False THEN 1 END)
      comment: "Number of receiving events failing temperature compliance. Critical food safety KPI — each failure is a potential regulatory and quality risk."
    - name: "putaway_task_generated_count"
      expr: COUNT(CASE WHEN putaway_task_generated_flag = True THEN 1 END)
      comment: "Number of receiving events that successfully generated putaway tasks. Measures receiving-to-putaway workflow efficiency."
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = True THEN 1 END)
      comment: "Number of receiving events requiring quality inspection. Drives QC labor planning and identifies high-risk vendor shipments."
    - name: "avg_temperature_reading"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature reading at point of receipt for temperature-controlled items. Used for cold chain compliance monitoring and trend analysis."
    - name: "seal_intact_count"
      expr: COUNT(CASE WHEN seal_intact_flag = True THEN 1 END)
      comment: "Number of receiving events where trailer seal was intact. Measures cargo security compliance and chain-of-custody integrity."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order fulfillment metrics covering fill rates, on-time shipment, order volume, and replenishment efficiency. Used by DC operations and supply chain leadership to manage store and customer replenishment performance."
  source: "`retail_ecm`.`supplychain`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the outbound order (e.g., Open, Shipped, Cancelled) for fulfillment pipeline visibility."
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g., Replenishment, Transfer, Direct) to segment fulfillment by business purpose."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type (e.g., Store, DC, Customer) for channel-level fulfillment performance analysis."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Replenishment method (e.g., Push, Pull, Cross-Dock) to analyze supply strategy effectiveness."
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority level for SLA compliance analysis and resource allocation decisions."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates cross-dock fulfillment, enabling flow-through vs. storage cost and speed analysis."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Indicates vendor drop-ship orders, relevant for direct fulfillment program performance."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level selected for the order, used for freight cost vs. service trade-off analysis."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order creation for outbound volume trending and seasonal demand analysis."
    - name: "requested_ship_date"
      expr: DATE_TRUNC('week', requested_ship_date)
      comment: "Week of requested ship date for short-term fulfillment capacity planning."
    - name: "replenishment_reason_code"
      expr: replenishment_reason_code
      comment: "Reason driving the replenishment order (e.g., Stockout, Safety Stock, Seasonal) for demand signal analysis."
  measures:
    - name: "total_outbound_orders"
      expr: COUNT(1)
      comment: "Total number of outbound orders. Baseline fulfillment volume metric for DC throughput and labor planning."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average order fill rate percentage. Core service level KPI — low fill rates indicate inventory availability failures impacting store in-stock."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total outbound shipment weight in kilograms. Used for freight cost estimation, carrier capacity planning, and dock scheduling."
    - name: "total_order_cube_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Total outbound cube in cubic meters. Drives trailer utilization analysis and freight consolidation decisions."
    - name: "on_time_ship_count"
      expr: COUNT(CASE WHEN actual_ship_date <= requested_ship_date THEN 1 END)
      comment: "Number of orders shipped on or before the requested ship date. Numerator for outbound on-time ship rate — key DC performance KPI."
    - name: "orders_with_requested_ship_date_count"
      expr: COUNT(CASE WHEN requested_ship_date IS NOT NULL AND actual_ship_date IS NOT NULL THEN 1 END)
      comment: "Number of orders with both requested and actual ship dates populated. Denominator for on-time ship rate calculation."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled outbound orders. High cancellation rates signal demand volatility, inventory issues, or fulfillment failures."
    - name: "cross_dock_order_count"
      expr: COUNT(CASE WHEN is_cross_dock = True THEN 1 END)
      comment: "Number of cross-dock outbound orders. Measures flow-through program utilization and DC bypass efficiency."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= required_delivery_date THEN 1 END)
      comment: "Number of orders delivered on or before the required delivery date. Numerator for end-to-end on-time delivery rate — critical for store in-stock SLA."
    - name: "orders_with_delivery_dates_count"
      expr: COUNT(CASE WHEN required_delivery_date IS NOT NULL AND actual_delivery_date IS NOT NULL THEN 1 END)
      comment: "Number of orders with both required and actual delivery dates. Denominator for on-time delivery rate calculation."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_outbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound shipment execution metrics covering on-time delivery, freight cost, and carrier performance. Used by logistics and supply chain leadership to manage carrier contracts and last-mile delivery SLAs."
  source: "`retail_ecm`.`supplychain`.`outbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the outbound shipment (e.g., Shipped, Delivered, Exception) for real-time fulfillment visibility."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of outbound shipment (e.g., Store Replenishment, Direct-to-Consumer, Transfer) for channel-level performance analysis."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Indicates whether the shipment was delivered on time. Primary carrier performance dimension."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type (e.g., Store, DC, Customer) for delivery performance segmentation."
    - name: "service_level"
      expr: service_level
      comment: "Carrier service level (e.g., Ground, Express, Overnight) for cost vs. service trade-off analysis."
    - name: "carrier_scac_code"
      expr: carrier_scac_code
      comment: "Standard Carrier Alpha Code identifying the carrier. Enables carrier-level performance benchmarking."
    - name: "freight_currency_code"
      expr: freight_currency_code
      comment: "Currency of freight charges for multi-currency logistics cost analysis."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception type code (e.g., Delay, Damage, Lost) for root cause analysis of delivery failures."
    - name: "ship_date"
      expr: DATE_TRUNC('week', ship_date)
      comment: "Week of shipment for outbound volume trending and carrier capacity planning."
    - name: "actual_delivery_date"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month of actual delivery for delivery performance trending and SLA compliance reporting."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Indicates temperature-controlled outbound shipments for cold chain compliance tracking."
  measures:
    - name: "total_outbound_shipments"
      expr: COUNT(1)
      comment: "Total number of outbound shipments. Baseline carrier volume metric for freight contract management."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN on_time_delivery_flag = True THEN 1 END)
      comment: "Number of shipments delivered on time. Numerator for on-time delivery rate — primary carrier SLA KPI."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total outbound freight cost. Core logistics spend metric for carrier contract benchmarking and cost-per-unit analysis."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per outbound shipment. Enables carrier efficiency benchmarking and rate negotiation support."
    - name: "total_shipment_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total outbound shipment weight in kilograms. Used for freight cost per kg analysis and carrier capacity planning."
    - name: "total_shipment_cube_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Total outbound cube in cubic meters. Drives trailer utilization and freight density analysis."
    - name: "exception_shipment_count"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Number of shipments with delivery exceptions. High exception rates signal carrier reliability issues requiring contract review."
    - name: "avg_transit_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, ship_date) AS DOUBLE))
      comment: "Average transit time in days from ship date to actual delivery. Measures carrier speed performance against service level commitments."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecast accuracy and planning metrics covering forecast bias, MAPE, WMAPE, and promotional lift. Used by supply chain planners and merchandising leadership to evaluate forecast model performance and drive inventory investment decisions."
  source: "`retail_ecm`.`supplychain`.`demand_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., Statistical, Consensus, Override) to compare model vs. human-adjusted accuracy."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast record (e.g., Active, Superseded, Approved) for version management."
    - name: "is_latest_version"
      expr: is_latest_version
      comment: "Indicates the most current forecast version. Used to filter analysis to active forecasts."
    - name: "is_promotional_period"
      expr: is_promotional_period
      comment: "Indicates a promotional forecast period. Enables comparison of promotional vs. baseline forecast accuracy."
    - name: "is_new_item"
      expr: is_new_item
      comment: "Indicates a new item forecast with limited history. New item forecasts typically have higher error rates requiring separate benchmarking."
    - name: "is_override_applied"
      expr: is_override_applied
      comment: "Indicates a planner override was applied to the statistical forecast. Used to measure override lift and planner value-add."
    - name: "planning_channel"
      expr: planning_channel
      comment: "Planning channel (e.g., Store, E-Commerce, Wholesale) for channel-level forecast performance analysis."
    - name: "demand_category"
      expr: demand_category
      comment: "Demand category (e.g., Baseline, Promotional, Seasonal) for forecast decomposition analysis."
    - name: "statistical_model_code"
      expr: statistical_model_code
      comment: "Statistical model used to generate the forecast. Enables model performance benchmarking and selection decisions."
    - name: "forecast_period_start_date"
      expr: DATE_TRUNC('month', forecast_period_start_date)
      comment: "Month of forecast period start for temporal accuracy trending."
    - name: "time_bucket_granularity"
      expr: time_bucket_granularity
      comment: "Time granularity of the forecast (e.g., Weekly, Daily) for planning horizon analysis."
  measures:
    - name: "total_forecast_records"
      expr: COUNT(1)
      comment: "Total number of forecast records. Baseline metric for forecast coverage and planning completeness."
    - name: "total_forecasted_units"
      expr: SUM(CAST(forecasted_units AS DOUBLE))
      comment: "Total forecasted demand units. Primary demand signal for inventory investment, procurement, and capacity planning."
    - name: "total_baseline_forecast_units"
      expr: SUM(CAST(baseline_forecast_units AS DOUBLE))
      comment: "Total baseline (pre-promotional) forecasted units. Used to isolate underlying demand trend from promotional lift."
    - name: "total_promotional_lift_units"
      expr: SUM(CAST(promotional_lift_units AS DOUBLE))
      comment: "Total incremental units attributed to promotional activity. Measures promotional demand uplift for event planning and inventory staging."
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue. Enables financial planning alignment between supply chain and finance for budget and OTB management."
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across forecast records. Primary forecast accuracy KPI — lower MAPE drives better inventory efficiency and reduces stockouts and overstock."
    - name: "avg_wmape"
      expr: AVG(CAST(wmape AS DOUBLE))
      comment: "Average Weighted Mean Absolute Percentage Error. Volume-weighted accuracy metric that prioritizes high-volume SKU forecast quality."
    - name: "avg_forecast_bias"
      expr: AVG(CAST(forecast_bias AS DOUBLE))
      comment: "Average forecast bias (systematic over- or under-forecasting). Persistent positive bias leads to overstock; negative bias leads to stockouts — both destroy margin."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of forecasts. Low confidence signals high demand uncertainty requiring safety stock buffer increases."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply implied by the forecast. Directly informs replenishment order quantities and inventory investment levels."
    - name: "override_applied_count"
      expr: COUNT(CASE WHEN is_override_applied = True THEN 1 END)
      comment: "Number of forecasts with planner overrides applied. High override rates may indicate model inadequacy or excessive manual intervention."
    - name: "total_replenishment_recommendation_units"
      expr: SUM(CAST(replenishment_recommendation_units AS DOUBLE))
      comment: "Total units recommended for replenishment based on forecast. Drives automated replenishment order generation and inventory positioning."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_replenishment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment planning KPIs covering order quantities, safety stock adequacy, service level targets, and MOQ compliance. Used by supply chain planners and inventory managers to optimize replenishment decisions and prevent stockouts."
  source: "`retail_ecm`.`supplychain`.`replenishment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the replenishment plan (e.g., Draft, Approved, Released) for workflow and governance tracking."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of replenishment plan (e.g., Regular, Promotional, Emergency) to segment planning activity."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method (e.g., Min/Max, Reorder Point, Vendor Managed) for strategy effectiveness analysis."
    - name: "node_type"
      expr: node_type
      comment: "Type of inventory node (e.g., DC, Store, Hub) for network-level replenishment analysis."
    - name: "moq_compliance_flag"
      expr: moq_compliance_flag
      comment: "Indicates whether the planned order meets minimum order quantity. Non-compliant plans may incur vendor penalties."
    - name: "buyer_override_flag"
      expr: buyer_override_flag
      comment: "Indicates a buyer manually overrode the system-generated replenishment plan. Used to measure planning system trust and override frequency."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Indicates a promotional replenishment plan. Enables promotional vs. baseline inventory investment comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the replenishment plan for multi-currency inventory value analysis."
    - name: "order_release_date"
      expr: DATE_TRUNC('week', order_release_date)
      comment: "Week of planned order release for short-term procurement workload planning."
    - name: "plan_horizon_start_date"
      expr: DATE_TRUNC('month', plan_horizon_start_date)
      comment: "Month of planning horizon start for medium-term supply planning visibility."
    - name: "safety_stock_method"
      expr: safety_stock_method
      comment: "Method used to calculate safety stock (e.g., Fixed, Statistical, Service Level) for methodology benchmarking."
  measures:
    - name: "total_replenishment_plans"
      expr: COUNT(1)
      comment: "Total number of replenishment plans generated. Baseline metric for planning system activity and coverage."
    - name: "total_planned_order_qty"
      expr: SUM(CAST(planned_order_qty AS DOUBLE))
      comment: "Total units planned for replenishment. Primary supply volume metric driving procurement and DC inbound planning."
    - name: "total_approved_order_qty"
      expr: SUM(CAST(approved_order_qty AS DOUBLE))
      comment: "Total approved replenishment order quantity. Represents committed supply volume after buyer review and approval."
    - name: "total_planned_order_value"
      expr: SUM(CAST(planned_order_value AS DOUBLE))
      comment: "Total planned replenishment order value. Core inventory investment metric for OTB and budget management."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across all replenishment plans. Measures buffer inventory investment and service level protection."
    - name: "total_current_on_hand_qty"
      expr: SUM(CAST(current_on_hand_qty AS DOUBLE))
      comment: "Total current on-hand inventory quantity. Baseline for inventory position analysis and weeks-of-supply calculation."
    - name: "total_on_order_qty"
      expr: SUM(CAST(on_order_qty AS DOUBLE))
      comment: "Total quantity already on order. Combined with on-hand, represents total inventory position for replenishment need calculation."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage across replenishment plans. Reflects the organization's in-stock commitment to stores and customers."
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average fill rate target percentage. Measures the ambition level of replenishment plans against vendor and DC performance benchmarks."
    - name: "avg_weeks_of_supply_target"
      expr: AVG(CAST(weeks_of_supply_target AS DOUBLE))
      comment: "Average target weeks of supply. Indicates planned inventory coverage and capital efficiency of the replenishment strategy."
    - name: "moq_non_compliant_plan_count"
      expr: COUNT(CASE WHEN moq_compliance_flag = False THEN 1 END)
      comment: "Number of replenishment plans not meeting minimum order quantity. Non-compliant plans risk vendor penalties and supply disruption."
    - name: "buyer_override_count"
      expr: COUNT(CASE WHEN buyer_override_flag = True THEN 1 END)
      comment: "Number of replenishment plans with buyer overrides. High override rates indicate planning system distrust or model inadequacy requiring recalibration."
    - name: "total_forecasted_demand_qty"
      expr: SUM(CAST(forecasted_demand_qty AS DOUBLE))
      comment: "Total forecasted demand quantity used as input to replenishment plans. Enables comparison of forecast-to-plan alignment."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_warehouse_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse labor productivity and task execution metrics covering throughput, efficiency, exception rates, and task duration. Used by DC operations managers to optimize labor allocation, identify bottlenecks, and improve warehouse productivity."
  source: "`retail_ecm`.`supplychain`.`warehouse_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of warehouse task (e.g., Pick, Pack, Putaway, Replenishment) for labor activity segmentation and productivity benchmarking."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the warehouse task (e.g., Pending, In Progress, Complete, Exception) for workflow monitoring."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task for SLA compliance and resource allocation analysis."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates tasks with exceptions requiring intervention. High exception rates signal process or system issues."
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Reason code for task exceptions, enabling root cause analysis and process improvement."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type used for the task (e.g., Forklift, Conveyor, Manual) for equipment utilization and cost analysis."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates a SKU substitution was made during task execution. High substitution rates signal inventory availability issues."
    - name: "target_zone"
      expr: target_zone
      comment: "Target warehouse zone for the task, enabling zone-level productivity and congestion analysis."
    - name: "task_created_timestamp"
      expr: DATE_TRUNC('day', task_created_timestamp)
      comment: "Day of task creation for daily throughput trending and labor planning."
  measures:
    - name: "total_warehouse_tasks"
      expr: COUNT(1)
      comment: "Total number of warehouse tasks. Baseline throughput metric for DC labor planning and capacity management."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total units processed across all warehouse tasks. Measures DC throughput volume for productivity and capacity analysis."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned units for warehouse tasks. Used to compute task completion rate and identify fulfillment shortfalls."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between planned and actual task execution. Measures picking accuracy and inventory discrepancy at task level."
    - name: "avg_task_duration_minutes"
      expr: AVG(CAST(task_duration_minutes AS DOUBLE))
      comment: "Average task duration in minutes. Core labor productivity KPI — compared against standard labor minutes to identify efficiency gaps."
    - name: "total_standard_labor_minutes"
      expr: SUM(CAST(standard_labor_minutes AS DOUBLE))
      comment: "Total standard (engineered) labor minutes for all tasks. Denominator for labor efficiency ratio and workforce planning."
    - name: "total_actual_labor_minutes"
      expr: SUM(CAST(task_duration_minutes AS DOUBLE))
      comment: "Total actual labor minutes consumed across all tasks. Numerator for labor efficiency ratio and overtime cost analysis."
    - name: "exception_task_count"
      expr: COUNT(CASE WHEN exception_flag = True THEN 1 END)
      comment: "Number of tasks with exceptions. High exception rates indicate process failures, system issues, or inventory inaccuracies requiring intervention."
    - name: "substitution_task_count"
      expr: COUNT(CASE WHEN substitution_flag = True THEN 1 END)
      comment: "Number of tasks where a SKU substitution was made. Measures inventory availability failures at the pick face level."
    - name: "avg_travel_distance_feet"
      expr: AVG(CAST(travel_distance_feet AS DOUBLE))
      comment: "Average travel distance per task in feet. Measures slotting efficiency — high travel distances indicate suboptimal product placement driving labor cost."
    - name: "completed_task_count"
      expr: COUNT(CASE WHEN task_status = 'Complete' THEN 1 END)
      comment: "Number of successfully completed warehouse tasks. Used to compute task completion rate and measure DC execution reliability."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_inventory_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory transfer performance metrics covering transfer volume, value, freight cost, and execution accuracy. Used by supply chain and inventory management teams to optimize inter-facility stock balancing and reduce excess inventory."
  source: "`retail_ecm`.`supplychain`.`inventory_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the inventory transfer (e.g., Pending, In Transit, Received, Cancelled) for pipeline visibility."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of inventory transfer (e.g., DC-to-Store, Store-to-DC, DC-to-DC) for network flow analysis."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason driving the transfer (e.g., Rebalance, Stockout, Markdown) for demand signal and inventory health analysis."
    - name: "destination_facility_type"
      expr: destination_facility_type
      comment: "Type of destination facility for the transfer, enabling network-level inventory flow analysis."
    - name: "origin_facility_type"
      expr: origin_facility_type
      comment: "Type of origin facility for the transfer, used to analyze supply network sourcing patterns."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer for SLA compliance and urgency-based resource allocation."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates cross-dock transfers bypassing storage for flow-through efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transfer value for multi-currency inventory valuation."
    - name: "requested_ship_date"
      expr: DATE_TRUNC('week', requested_ship_date)
      comment: "Week of requested ship date for short-term transfer volume and logistics planning."
    - name: "actual_ship_date"
      expr: DATE_TRUNC('month', actual_ship_date)
      comment: "Month of actual shipment for transfer volume trending and network flow analysis."
  measures:
    - name: "total_inventory_transfers"
      expr: COUNT(1)
      comment: "Total number of inventory transfers. Baseline metric for inter-facility stock movement activity and network complexity."
    - name: "total_transfer_quantity"
      expr: SUM(CAST(transfer_quantity AS DOUBLE))
      comment: "Total units planned for transfer. Measures the scale of inventory rebalancing activity across the supply network."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units actually shipped in transfers. Used to compute transfer execution rate and identify fulfillment gaps."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units received at destination. Enables in-transit quantity tracking and transfer accuracy measurement."
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value AS DOUBLE))
      comment: "Total inventory value transferred across the network. Measures capital deployed in inter-facility stock rebalancing."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for inventory transfers. Measures logistics spend on stock rebalancing — high transfer freight costs signal network imbalance."
    - name: "avg_freight_cost_per_transfer"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per inventory transfer. Benchmarks transfer efficiency and identifies high-cost routing patterns."
    - name: "on_time_receipt_count"
      expr: COUNT(CASE WHEN actual_receipt_date <= expected_receipt_date THEN 1 END)
      comment: "Number of transfers received on or before the expected receipt date. Measures transfer execution reliability for store replenishment planning."
    - name: "transfers_with_receipt_dates_count"
      expr: COUNT(CASE WHEN expected_receipt_date IS NOT NULL AND actual_receipt_date IS NOT NULL THEN 1 END)
      comment: "Number of transfers with both expected and actual receipt dates. Denominator for on-time transfer receipt rate."
    - name: "cancelled_transfer_count"
      expr: COUNT(CASE WHEN transfer_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled inventory transfers. High cancellation rates signal planning instability or execution failures in the supply network."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse wave execution metrics covering pick productivity, labor efficiency, fill rates, and wave throughput. Used by DC operations managers to optimize wave planning, labor deployment, and outbound fulfillment speed."
  source: "`retail_ecm`.`supplychain`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Current status of the wave (e.g., Released, In Progress, Complete) for real-time DC execution monitoring."
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave (e.g., Replenishment, Direct, Promotional) to segment picking activity by fulfillment purpose."
    - name: "channel"
      expr: channel
      comment: "Fulfillment channel (e.g., Store, E-Commerce, Wholesale) for channel-level wave productivity analysis."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level for the wave, used to analyze labor and cost trade-offs by service tier."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Indicates a promotional wave requiring special handling or priority. Used to measure promotional fulfillment efficiency."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates hazmat waves requiring certified handling. Used for compliance and specialized labor planning."
    - name: "generation_method"
      expr: generation_method
      comment: "Method used to generate the wave (e.g., Automatic, Manual) for system vs. planner efficiency comparison."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Equipment type used for wave execution for equipment utilization and cost analysis."
    - name: "release_timestamp"
      expr: DATE_TRUNC('day', release_timestamp)
      comment: "Day of wave release for daily throughput trending and shift-level capacity planning."
  measures:
    - name: "total_waves"
      expr: COUNT(1)
      comment: "Total number of waves executed. Baseline DC throughput metric for operational capacity and shift planning."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average wave fill rate percentage. Measures the proportion of ordered units successfully picked — low fill rates indicate inventory availability failures."
    - name: "total_labor_hours_planned"
      expr: SUM(CAST(labor_hours_planned AS DOUBLE))
      comment: "Total planned labor hours across all waves. Core input for workforce scheduling and labor cost budgeting."
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours consumed across all waves. Used to compute labor efficiency ratio and identify over/under-staffing."
    - name: "avg_units_per_hour"
      expr: AVG(CAST(units_per_hour AS DOUBLE))
      comment: "Average pick productivity in units per hour. Primary warehouse labor efficiency KPI — benchmarked against engineered standards to drive productivity improvement."
    - name: "total_template_code_count"
      expr: COUNT(DISTINCT template_code)
      comment: "Number of distinct wave templates used. Measures wave planning standardization — high template diversity may indicate inefficient wave configuration."
    - name: "promotional_wave_count"
      expr: COUNT(CASE WHEN is_promotional = True THEN 1 END)
      comment: "Number of promotional waves executed. Measures promotional fulfillment volume and associated labor demand for event planning."
    - name: "completed_wave_count"
      expr: COUNT(CASE WHEN wave_status = 'Complete' THEN 1 END)
      comment: "Number of successfully completed waves. Used to compute wave completion rate and measure DC execution reliability."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_dc_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center facility capacity and capability metrics. Used by supply chain network design and real estate teams to evaluate DC footprint, capacity utilization potential, and operational capability."
  source: "`retail_ecm`.`supplychain`.`dc_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of DC facility (e.g., Regional DC, Cross-Dock, Fulfillment Center) for network design segmentation."
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the facility (e.g., Active, Closed, Under Construction) for network capacity planning."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g., Owned, Leased, 3PL) for real estate strategy and cost structure analysis."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of warehouse automation (e.g., Manual, Semi-Automated, Fully Automated) for productivity benchmarking and capex planning."
    - name: "owning_region_code"
      expr: owning_region_code
      comment: "Region owning the facility for geographic network analysis and regional capacity planning."
    - name: "country_code"
      expr: country_code
      comment: "Country of the facility for international supply chain network analysis."
    - name: "temperature_zone_ambient_flag"
      expr: temperature_zone_ambient_flag
      comment: "Indicates ambient temperature zone capability for product storage compatibility analysis."
    - name: "temperature_zone_chilled_flag"
      expr: temperature_zone_chilled_flag
      comment: "Indicates chilled temperature zone capability for fresh and refrigerated product network planning."
    - name: "temperature_zone_frozen_flag"
      expr: temperature_zone_frozen_flag
      comment: "Indicates frozen temperature zone capability for frozen food supply chain network design."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates hazmat handling certification for regulatory compliance and product routing decisions."
    - name: "bonded_warehouse_flag"
      expr: bonded_warehouse_flag
      comment: "Indicates bonded warehouse status for import/export and customs compliance planning."
    - name: "twenty_four_seven_operation_flag"
      expr: twenty_four_seven_operation_flag
      comment: "Indicates 24/7 operational capability for throughput capacity and SLA commitment analysis."
  measures:
    - name: "total_dc_facilities"
      expr: COUNT(1)
      comment: "Total number of DC facilities in the network. Baseline metric for supply chain network footprint analysis."
    - name: "total_storage_capacity_cubic_feet"
      expr: SUM(CAST(storage_capacity_cubic_feet AS DOUBLE))
      comment: "Total storage capacity in cubic feet across the DC network. Core capacity metric for network design and inventory positioning decisions."
    - name: "total_warehouse_square_footage"
      expr: SUM(CAST(warehouse_square_footage AS DOUBLE))
      comment: "Total warehouse square footage across the network. Used for real estate portfolio management and capacity expansion planning."
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total facility square footage including non-warehouse areas. Measures overall real estate footprint for cost and lease management."
    - name: "avg_storage_capacity_cubic_feet"
      expr: AVG(CAST(storage_capacity_cubic_feet AS DOUBLE))
      comment: "Average storage capacity per DC facility. Benchmarks facility size for network rationalization and consolidation decisions."
    - name: "active_facility_count"
      expr: COUNT(CASE WHEN facility_status = 'Active' THEN 1 END)
      comment: "Number of currently active DC facilities. Measures operational network capacity available for supply chain execution."
    - name: "automated_facility_count"
      expr: COUNT(CASE WHEN automation_level IS NOT NULL AND automation_level != 'Manual' THEN 1 END)
      comment: "Number of facilities with some level of automation. Measures automation penetration across the DC network for productivity and capex strategy."
    - name: "cold_chain_capable_facility_count"
      expr: COUNT(CASE WHEN temperature_zone_chilled_flag = True OR temperature_zone_frozen_flag = True THEN 1 END)
      comment: "Number of facilities with cold chain capability. Critical for fresh and frozen product network design and capacity planning."
$$;