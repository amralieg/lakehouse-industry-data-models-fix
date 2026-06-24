-- Metric views for domain: supplychain | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order performance: spend, fill rates, on-time delivery, and supplier compliance. Used by procurement leadership to manage vendor relationships and open-to-buy budgets."
  source: "`vibe_retail_v1`.`supplychain`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., open, confirmed, received, cancelled) for pipeline analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., standard, blanket, drop-ship) for spend categorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the PO is denominated, enabling multi-currency spend analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Trade terms governing delivery responsibility, used to segment logistics cost exposure."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order placement for trend analysis of purchasing activity."
    - name: "expected_delivery_date"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Month of expected delivery for forward-looking supply pipeline visibility."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO, used to identify bottlenecks in the procurement process."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms agreed with the vendor, used for cash flow and working capital analysis."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates whether the PO is designated for cross-dock flow-through, bypassing DC storage."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Indicates whether the PO is fulfilled via direct vendor-to-customer drop shipment."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement activity."
    - name: "total_order_amount"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Core procurement spend KPI used in budget vs. actuals reporting."
    - name: "avg_order_amount"
      expr: AVG(CAST(total_order_amount AS DOUBLE))
      comment: "Average purchase order value. Indicates order sizing trends and negotiation effectiveness."
    - name: "total_ordered_units"
      expr: SUM(CAST(total_ordered_units AS DOUBLE))
      comment: "Total units ordered across all POs. Used to assess volume commitments against demand forecasts."
    - name: "total_received_units"
      expr: SUM(CAST(total_received_units AS DOUBLE))
      comment: "Total units actually received. Compared against ordered units to compute supplier fill rate."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average supplier fill rate percentage across POs. Key vendor performance indicator; low fill rate signals supply risk."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total vendor discounts captured on purchase orders. Measures negotiation savings and promotional allowances."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after discounts. Represents actual cash outflow obligation to vendors."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to POs. Used to monitor currency exposure in international sourcing."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Sum of minimum order quantities across POs. Used to assess MOQ compliance and inventory build risk."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level purchase order KPIs covering unit economics, fill rates, and cost performance. Used by buyers and planners to manage item-level procurement efficiency."
  source: "`vibe_retail_v1`.`supplychain`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (e.g., open, confirmed, received, cancelled)."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for the line (e.g., DC, store, drop-ship) for routing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line-level cost, enabling multi-currency cost analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the item was manufactured. Used for sourcing diversification and tariff analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms for the line, governing cost and risk transfer point."
    - name: "ship_date"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month of shipment for tracking vendor on-time shipping performance."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery for supply pipeline planning."
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Whether the line meets minimum order quantity requirements. Used to flag compliance exceptions."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines. Baseline volume metric for line-level procurement activity."
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total units ordered at line level. Core volume metric for item-level demand commitment."
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total units received at line level. Used to compute line-level fill rate and identify shortfalls."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total units shipped by vendor. Compared to ordered qty to identify in-transit shortages."
    - name: "total_confirmed_qty"
      expr: SUM(CAST(confirmed_qty AS DOUBLE))
      comment: "Total units confirmed by vendor. Measures vendor commitment vs. original order."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × quantity) across PO lines. Primary cost-of-goods metric for buyers."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost after allowances. Represents true landed cost commitment at line level."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across PO lines. Used to track cost inflation and negotiate better pricing."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowances captured at line level. Measures promotional and compliance allowance capture."
    - name: "total_otb_consumed"
      expr: SUM(CAST(otb_consumed AS DOUBLE))
      comment: "Total open-to-buy budget consumed by PO lines. Critical for merchandise financial planning and budget control."
    - name: "total_moq"
      expr: SUM(CAST(moq AS DOUBLE))
      comment: "Total minimum order quantity commitments. Used to assess inventory build risk from MOQ constraints."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting accuracy and volume KPIs. Used by supply chain planners and merchandising leadership to evaluate forecast quality and drive replenishment decisions."
  source: "`vibe_retail_v1`.`supplychain`.`demand_forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., statistical, consensus, promotional) for accuracy benchmarking by method."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (e.g., draft, approved, published) for pipeline visibility."
    - name: "demand_category"
      expr: demand_category
      comment: "Category of demand (e.g., base, promotional, seasonal) for decomposed demand analysis."
    - name: "planning_channel"
      expr: planning_channel
      comment: "Sales channel for which the forecast was generated (e.g., store, ecommerce, wholesale)."
    - name: "is_promotional_period"
      expr: is_promotional_period
      comment: "Whether the forecast period includes a promotion. Used to isolate promotional lift accuracy."
    - name: "is_new_item"
      expr: is_new_item
      comment: "Whether the forecast is for a new item. New item forecasts typically have higher error and require separate tracking."
    - name: "is_override_applied"
      expr: is_override_applied
      comment: "Whether a planner override was applied. Used to measure the impact of human judgment on forecast accuracy."
    - name: "forecast_period_start_date"
      expr: DATE_TRUNC('month', forecast_period_start_date)
      comment: "Month of forecast period start for time-series accuracy trending."
    - name: "time_bucket_granularity"
      expr: time_bucket_granularity
      comment: "Granularity of the forecast time bucket (e.g., daily, weekly) for comparing accuracy across horizons."
    - name: "statistical_model_code"
      expr: statistical_model_code
      comment: "Statistical model used to generate the forecast. Used to benchmark model performance."
  measures:
    - name: "total_forecast_records"
      expr: COUNT(1)
      comment: "Total number of forecast records. Baseline volume metric for forecast coverage."
    - name: "total_forecasted_units"
      expr: SUM(CAST(forecasted_units AS DOUBLE))
      comment: "Total forecasted demand units. Core supply planning input used to size replenishment orders."
    - name: "total_baseline_forecast_units"
      expr: SUM(CAST(baseline_forecast_units AS DOUBLE))
      comment: "Total baseline (pre-override, pre-promotional) forecast units. Used to isolate statistical model performance."
    - name: "total_promotional_lift_units"
      expr: SUM(CAST(promotional_lift_units AS DOUBLE))
      comment: "Total promotional demand lift units. Measures the incremental volume attributed to promotions."
    - name: "total_override_units"
      expr: SUM(CAST(override_units AS DOUBLE))
      comment: "Total units added or removed via planner overrides. Quantifies the scale of human intervention in the forecast."
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue. Used by finance and merchandising to align demand plans with financial targets."
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across forecasts. Primary forecast accuracy KPI; high MAPE signals poor model performance."
    - name: "avg_wmape"
      expr: AVG(CAST(wmape AS DOUBLE))
      comment: "Average Weighted MAPE across forecasts. Volume-weighted accuracy metric preferred for high-volume SKU performance."
    - name: "avg_forecast_bias"
      expr: AVG(CAST(forecast_bias AS DOUBLE))
      comment: "Average forecast bias (systematic over- or under-forecasting). Persistent bias leads to chronic overstock or stockout."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average statistical confidence level of forecasts. Low confidence signals high demand uncertainty requiring safety stock buffers."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply implied by the forecast. Used to assess inventory coverage adequacy."
    - name: "total_replenishment_recommendation_units"
      expr: SUM(CAST(replenishment_recommendation_units AS DOUBLE))
      comment: "Total units recommended for replenishment by the forecast engine. Drives automated PO generation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_replenishment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment planning KPIs covering order quantities, safety stock, service levels, and cost. Used by supply chain planners to optimize inventory investment and prevent stockouts."
  source: "`vibe_retail_v1`.`supplychain`.`replenishment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the replenishment plan (e.g., draft, approved, executed)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of replenishment plan (e.g., min-max, days-of-supply, vendor-managed) for method benchmarking."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment algorithm or method applied (e.g., reorder point, periodic review)."
    - name: "node_type"
      expr: node_type
      comment: "Type of inventory node being replenished (e.g., store, DC, hub) for network-level analysis."
    - name: "order_release_date"
      expr: DATE_TRUNC('month', order_release_date)
      comment: "Month of planned order release for supply pipeline timing analysis."
    - name: "plan_horizon_start_date"
      expr: DATE_TRUNC('month', plan_horizon_start_date)
      comment: "Month of planning horizon start for forward-looking supply coverage analysis."
    - name: "buyer_override_flag"
      expr: buyer_override_flag
      comment: "Whether a buyer manually overrode the system-generated plan. Used to measure human intervention frequency."
    - name: "moq_compliance_flag"
      expr: moq_compliance_flag
      comment: "Whether the planned order meets minimum order quantity. Non-compliant plans may be rejected by vendors."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Whether the replenishment plan includes promotional demand uplift."
    - name: "safety_stock_method"
      expr: safety_stock_method
      comment: "Method used to calculate safety stock (e.g., fixed, statistical, service-level-based)."
  measures:
    - name: "total_plan_count"
      expr: COUNT(1)
      comment: "Total number of replenishment plans. Baseline volume metric for planning activity."
    - name: "total_planned_order_qty"
      expr: SUM(CAST(planned_order_qty AS DOUBLE))
      comment: "Total units planned for replenishment orders. Core supply planning output driving PO creation."
    - name: "total_approved_order_qty"
      expr: SUM(CAST(approved_order_qty AS DOUBLE))
      comment: "Total units approved for ordering. Compared to planned qty to measure approval rate and buyer intervention."
    - name: "total_planned_order_value"
      expr: SUM(CAST(planned_order_value AS DOUBLE))
      comment: "Total monetary value of planned replenishment orders. Used for open-to-buy budget management."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock units planned across nodes. Measures inventory buffer investment to protect service levels."
    - name: "total_forecasted_demand_qty"
      expr: SUM(CAST(forecasted_demand_qty AS DOUBLE))
      comment: "Total forecasted demand units driving replenishment plans. Validates alignment between forecast and plan."
    - name: "total_current_on_hand_qty"
      expr: SUM(CAST(current_on_hand_qty AS DOUBLE))
      comment: "Total current on-hand inventory across planned nodes. Used to assess inventory position before ordering."
    - name: "total_on_order_qty"
      expr: SUM(CAST(on_order_qty AS DOUBLE))
      comment: "Total units already on order. Combined with on-hand to compute total supply position."
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average target fill rate across replenishment plans. Reflects service level commitments to stores and customers."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average target service level (probability of no stockout). Key input to safety stock calculations."
    - name: "avg_weeks_of_supply_target"
      expr: AVG(CAST(weeks_of_supply_target AS DOUBLE))
      comment: "Average target weeks of supply. Used to calibrate inventory investment against demand velocity."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across replenishment plans. Used to estimate total inventory investment value."
    - name: "total_min_order_value"
      expr: SUM(CAST(min_order_value AS DOUBLE))
      comment: "Total minimum order value commitments. Used to assess vendor MOV compliance and order consolidation opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment performance KPIs covering on-time arrival, freight cost, and receiving efficiency. Used by DC operations and procurement to manage vendor shipping compliance."
  source: "`vibe_retail_v1`.`supplychain`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g., in-transit, arrived, receiving, complete)."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of inbound shipment (e.g., vendor, transfer, return) for volume segmentation."
    - name: "on_time_arrival_flag"
      expr: on_time_arrival_flag
      comment: "Whether the shipment arrived on or before the expected date. Core vendor compliance KPI."
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Whether the shipment is designated for cross-dock processing, bypassing DC storage."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Whether the shipment requires temperature-controlled handling. Used for cold chain compliance tracking."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether the shipment maintained required temperature throughout transit. Critical for food safety compliance."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the shipment contains hazardous materials. Used for regulatory compliance and handling cost analysis."
    - name: "expected_arrival_date"
      expr: DATE_TRUNC('month', expected_arrival_date)
      comment: "Month of expected arrival for supply pipeline planning and DC labor scheduling."
    - name: "actual_arrival_date"
      expr: DATE_TRUNC('month', actual_arrival_date)
      comment: "Month of actual arrival for on-time performance trending."
    - name: "freight_currency_code"
      expr: freight_currency_code
      comment: "Currency of freight cost for multi-currency logistics spend analysis."
  measures:
    - name: "total_shipment_count"
      expr: COUNT(1)
      comment: "Total number of inbound shipments. Baseline volume metric for inbound logistics activity."
    - name: "on_time_arrival_count"
      expr: SUM(CASE WHEN on_time_arrival_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments that arrived on time. Numerator for on-time arrival rate calculation."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total inbound freight cost. Key logistics spend KPI used to manage carrier costs and negotiate rates."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per inbound shipment. Used to benchmark carrier efficiency and identify cost outliers."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight received across inbound shipments. Used for freight cost reconciliation and dock capacity planning."
    - name: "total_expected_cube_m3"
      expr: SUM(CAST(expected_cube_m3 AS DOUBLE))
      comment: "Total expected cubic volume of inbound shipments. Used for DC receiving capacity and dock scheduling."
    - name: "temperature_compliant_count"
      expr: SUM(CASE WHEN temperature_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of temperature-controlled shipments that maintained compliance. Critical food safety and quality KPI."
    - name: "total_temperature_controlled_count"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of temperature-controlled inbound shipments. Used to size cold chain receiving capacity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_receiving_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DC receiving event KPIs covering throughput, discrepancy rates, and quality. Used by DC operations managers to optimize receiving labor and vendor compliance."
  source: "`vibe_retail_v1`.`supplychain`.`receiving_event`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving event (e.g., in-progress, complete, exception) for throughput tracking."
    - name: "receiving_type"
      expr: receiving_type
      comment: "Type of receiving event (e.g., PO receipt, transfer, return) for volume segmentation."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Whether damaged goods were identified during receiving. Used to track vendor packaging quality."
    - name: "shortage_flag"
      expr: shortage_flag
      comment: "Whether a shortage was identified vs. the ASN. Used to initiate vendor shortage claims."
    - name: "overage_flag"
      expr: overage_flag
      comment: "Whether an overage was received vs. the ASN. Used to manage unexpected inventory and vendor billing."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Whether temperature requirements were met at receipt. Critical for cold chain and food safety compliance."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Whether a quality inspection was required for this receipt. Used to track inspection workload."
    - name: "unload_start_timestamp"
      expr: DATE_TRUNC('day', unload_start_timestamp)
      comment: "Day of unload start for daily receiving throughput analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the receiving event involved hazardous materials. Used for regulatory compliance tracking."
  measures:
    - name: "total_receiving_events"
      expr: COUNT(1)
      comment: "Total number of receiving events. Baseline volume metric for DC inbound throughput."
    - name: "total_temperature_reading"
      expr: SUM(CAST(temperature_reading AS DOUBLE))
      comment: "Sum of temperature readings at receipt. Used with count to compute average temperature compliance."
    - name: "avg_temperature_reading"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature reading at receipt. Used to monitor cold chain integrity across inbound shipments."
    - name: "damage_event_count"
      expr: SUM(CASE WHEN damage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of receiving events with damage identified. Used to track vendor packaging quality and file claims."
    - name: "shortage_event_count"
      expr: SUM(CASE WHEN shortage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of receiving events with shortages vs. ASN. Used to track vendor fill rate compliance and initiate claims."
    - name: "overage_event_count"
      expr: SUM(CASE WHEN overage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of receiving events with overages vs. ASN. Used to manage unexpected inventory and vendor billing disputes."
    - name: "temperature_non_compliant_count"
      expr: SUM(CASE WHEN temperature_compliant_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of receiving events where temperature compliance failed. Critical food safety and quality KPI."
    - name: "putaway_task_generated_count"
      expr: SUM(CASE WHEN putaway_task_generated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of receiving events that generated putaway tasks. Used to measure DC workflow automation effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_po_shipment_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PO-level receipt KPIs covering quantity accuracy, quality, and discrepancy management. Used by receiving managers and buyers to measure vendor delivery performance and initiate claims."
  source: "`vibe_retail_v1`.`supplychain`.`po_shipment_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the PO receipt (e.g., pending, complete, exception) for pipeline tracking."
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of receipt (e.g., standard, blind, cross-dock) for process segmentation."
    - name: "receiving_status"
      expr: receiving_status
      comment: "Operational receiving status for DC workflow management."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status (e.g., passed, failed, pending) for quality gate tracking."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of discrepancy identified (e.g., shortage, overage, damage) for root cause analysis."
    - name: "discrepancy_resolution_status"
      expr: discrepancy_resolution_status
      comment: "Status of discrepancy resolution for vendor claim management."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Whether the receipt was placed on quality hold. Used to track quality exception rates by vendor."
    - name: "putaway_complete_flag"
      expr: putaway_complete_flag
      comment: "Whether putaway was completed for the receipt. Used to measure DC throughput cycle time."
    - name: "shortage_claim_flag"
      expr: shortage_claim_flag
      comment: "Whether a shortage claim was filed against the vendor. Used to track claim frequency and recovery."
    - name: "receipt_timestamp"
      expr: DATE_TRUNC('day', receipt_timestamp)
      comment: "Day of receipt for daily receiving throughput and vendor delivery timing analysis."
  measures:
    - name: "total_receipt_count"
      expr: COUNT(1)
      comment: "Total number of PO shipment receipts. Baseline volume metric for receiving activity."
    - name: "total_expected_quantity"
      expr: SUM(CAST(expected_quantity AS DOUBLE))
      comment: "Total units expected per ASN/PO. Used as denominator for fill rate and accuracy calculations."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units actually received. Core receiving volume metric for inventory accuracy."
    - name: "total_damaged_quantity"
      expr: SUM(CAST(damaged_quantity AS DOUBLE))
      comment: "Total units received in damaged condition. Used to quantify vendor packaging quality issues and claim values."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total units rejected at receipt due to quality or compliance failures. Drives vendor chargebacks and returns."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (received minus expected). Measures overall receiving accuracy and vendor compliance."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score at receipt. Composite vendor quality KPI used in supplier scorecards."
    - name: "total_weight_received_kg"
      expr: SUM(CAST(weight_received_kg AS DOUBLE))
      comment: "Total weight received across PO receipts. Used for freight reconciliation and dock capacity planning."
    - name: "quality_hold_count"
      expr: SUM(CASE WHEN quality_hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of receipts placed on quality hold. Used to track quality exception rates and vendor compliance."
    - name: "shortage_claim_count"
      expr: SUM(CASE WHEN shortage_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of receipts with shortage claims filed. Used to track vendor shortage frequency and recovery amounts."
    - name: "avg_temperature_at_receipt"
      expr: AVG(CAST(temperature_at_receipt AS DOUBLE))
      comment: "Average temperature recorded at receipt for temperature-controlled goods. Cold chain compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor and carrier SLA performance KPIs covering breach rates, fill rates, and chargeback exposure. Used by procurement and operations leadership to manage supplier accountability."
  source: "`vibe_retail_v1`.`supplychain`.`sla_performance`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA being measured (e.g., on-time delivery, fill rate, EDI compliance) for performance segmentation."
    - name: "performance_status"
      expr: performance_status
      comment: "Overall performance status (e.g., compliant, breach, at-risk) for exception management."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the SLA was breached in the measurement period. Primary compliance indicator."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the SLA breach (e.g., minor, major, critical) for prioritized remediation."
    - name: "chargeback_eligible_flag"
      expr: chargeback_eligible_flag
      comment: "Whether the breach qualifies for a vendor chargeback. Used to track financial recovery opportunities."
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Status of the chargeback process (e.g., pending, issued, disputed, collected)."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the performance issue was escalated. Used to track escalation frequency and resolution effectiveness."
    - name: "measurement_period_start_date"
      expr: DATE_TRUNC('month', measurement_period_start_date)
      comment: "Month of measurement period for SLA performance trending over time."
    - name: "scorecard_period"
      expr: scorecard_period
      comment: "Scorecard period label (e.g., Q1-2024) for vendor scorecard reporting."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action plans for SLA breaches. Used to track remediation progress."
  measures:
    - name: "total_sla_measurements"
      expr: COUNT(1)
      comment: "Total number of SLA performance measurements. Baseline volume metric for SLA monitoring coverage."
    - name: "total_breach_count"
      expr: SUM(CASE WHEN breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of SLA breaches. Primary vendor compliance KPI; high breach count signals systemic supplier issues."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed for SLA breaches. Measures financial recovery from non-compliant vendors."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual SLA metric value across measurements. Compared to target to assess overall compliance level."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value. Used as benchmark for actual performance comparison."
    - name: "avg_variance_value"
      expr: AVG(CAST(variance_value AS DOUBLE))
      comment: "Average variance between actual and target SLA values. Negative variance indicates underperformance."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across SLA measurements. Core vendor delivery performance KPI."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered in SLA measurement periods. Used as denominator for fill rate calculations."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units received in SLA measurement periods. Used to compute actual fill rate."
    - name: "total_short_ship_quantity"
      expr: SUM(CAST(short_ship_quantity AS DOUBLE))
      comment: "Total units short-shipped by vendors. Quantifies supply shortfall impact on store and DC inventory."
    - name: "escalation_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of SLA issues escalated. Used to track severity of vendor performance problems requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order KPIs covering fill rates, on-time shipping, and volume throughput. Used by DC operations and supply chain leadership to manage store replenishment and outbound logistics."
  source: "`vibe_retail_v1`.`supplychain`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the outbound order (e.g., planned, released, shipped, delivered)."
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g., store replenishment, transfer, drop-ship) for volume segmentation."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Replenishment method driving the order (e.g., min-max, push, promotional) for planning analysis."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination (e.g., store, DC, customer) for network flow analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Order priority level for DC execution sequencing and SLA management."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Whether the order flows through cross-dock without DC storage. Used to measure cross-dock utilization."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Whether the order is fulfilled via vendor drop-ship. Used to track drop-ship volume and cost."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the order contains hazardous materials. Used for compliance and handling cost analysis."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of order creation for outbound volume trending."
    - name: "requested_ship_date"
      expr: DATE_TRUNC('month', requested_ship_date)
      comment: "Month of requested ship date for DC capacity planning."
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of outbound orders. Baseline volume metric for DC outbound throughput."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average outbound order fill rate. Measures DC ability to fulfill store replenishment orders completely."
    - name: "total_cube_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Total cubic volume of outbound orders. Used for trailer utilization and freight cost planning."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of outbound orders. Used for freight cost calculation and carrier capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order line KPIs covering pick, pack, and ship accuracy. Used by DC operations to measure fulfillment execution quality and identify short-ship root causes."
  source: "`vibe_retail_v1`.`supplychain`.`outbound_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the outbound order line (e.g., allocated, picked, packed, shipped, short)."
    - name: "short_ship_reason_code"
      expr: short_ship_reason_code
      comment: "Reason code for short shipment. Used to identify root causes of fill rate failures."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Whether a substitute SKU was shipped. Used to track substitution rates and customer impact."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the line contains hazardous materials. Used for compliance and handling cost analysis."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Whether the line requires temperature-controlled handling. Used for cold chain capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of line-level cost for multi-currency cost analysis."
    - name: "expiry_date"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of expiry for perishable inventory management and FEFO compliance."
    - name: "created_timestamp"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Day of line creation for daily outbound volume trending."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of outbound order lines. Baseline volume metric for DC pick and pack activity."
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total units ordered across outbound lines. Used as denominator for fill rate and accuracy calculations."
    - name: "total_allocated_qty"
      expr: SUM(CAST(allocated_qty AS DOUBLE))
      comment: "Total units allocated to outbound lines. Measures inventory reservation effectiveness."
    - name: "total_picked_qty"
      expr: SUM(CAST(picked_qty AS DOUBLE))
      comment: "Total units picked. Used to measure pick accuracy and DC labor productivity."
    - name: "total_packed_qty"
      expr: SUM(CAST(packed_qty AS DOUBLE))
      comment: "Total units packed. Used to measure pack station throughput and accuracy."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total units shipped. Core outbound fulfillment volume metric."
    - name: "total_short_ship_qty"
      expr: SUM(CAST(short_ship_qty AS DOUBLE))
      comment: "Total units short-shipped. Quantifies unfulfilled demand and drives root cause analysis."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total cost of goods shipped outbound. Used for inventory valuation and transfer pricing."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of outbound lines. Used to monitor cost of goods and identify pricing anomalies."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume of outbound lines. Used for trailer utilization and freight cost optimization."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of outbound lines. Used for freight cost calculation and carrier capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse wave execution KPIs covering labor productivity, fill rates, and throughput. Used by DC operations managers to optimize pick wave planning and labor allocation."
  source: "`vibe_retail_v1`.`supplychain`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Current status of the wave (e.g., planned, released, picking, complete) for execution tracking."
    - name: "wave_type"
      expr: wave_type
      comment: "Type of wave (e.g., replenishment, ecommerce, store) for throughput segmentation by channel."
    - name: "channel"
      expr: channel
      comment: "Fulfillment channel served by the wave (e.g., store, ecommerce, wholesale) for channel-level productivity analysis."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Whether the wave contains promotional merchandise. Used to plan for higher-complexity promotional picks."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the wave contains hazardous materials. Used for compliance and specialized labor planning."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Whether the wave requires temperature-controlled handling. Used for cold chain labor and equipment planning."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the wave (e.g., ambient, chilled, frozen) for zone-level productivity benchmarking."
    - name: "release_timestamp"
      expr: DATE_TRUNC('day', release_timestamp)
      comment: "Day of wave release for daily throughput trending and labor planning."
    - name: "generation_method"
      expr: generation_method
      comment: "Method used to generate the wave (e.g., automatic, manual) for automation effectiveness analysis."
  measures:
    - name: "total_wave_count"
      expr: COUNT(1)
      comment: "Total number of waves executed. Baseline volume metric for DC outbound throughput."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average wave fill rate. Measures DC ability to fulfill all lines in a wave; low fill rate signals inventory or labor issues."
    - name: "total_labor_hours_planned"
      expr: SUM(CAST(labor_hours_planned AS DOUBLE))
      comment: "Total planned labor hours across waves. Used for workforce scheduling and capacity planning."
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours consumed by waves. Compared to planned to measure labor efficiency."
    - name: "avg_units_per_hour"
      expr: AVG(CAST(units_per_hour AS DOUBLE))
      comment: "Average pick productivity in units per hour. Primary DC labor efficiency KPI used to benchmark and improve operations."
    - name: "total_units_per_hour"
      expr: SUM(CAST(units_per_hour AS DOUBLE))
      comment: "Sum of units-per-hour across waves. Used with count to compute weighted average productivity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_warehouse_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse task execution KPIs covering labor productivity, accuracy, and exception rates. Used by DC operations to optimize task assignment, equipment utilization, and labor standards."
  source: "`vibe_retail_v1`.`supplychain`.`warehouse_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of warehouse task (e.g., pick, pack, putaway, replenishment, cycle count) for productivity benchmarking by activity."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task (e.g., assigned, in-progress, complete, exception) for execution tracking."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task for execution sequencing and SLA management."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether the task encountered an exception. Used to track exception rates and identify process improvement opportunities."
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Reason code for task exceptions. Used for root cause analysis and process improvement."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Whether a SKU substitution was made during task execution. Used to track substitution rates and inventory accuracy."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment used for the task (e.g., forklift, conveyor, manual). Used for equipment utilization analysis."
    - name: "task_created_timestamp"
      expr: DATE_TRUNC('day', task_created_timestamp)
      comment: "Day of task creation for daily workload volume trending."
    - name: "source_zone"
      expr: source_zone
      comment: "Source zone within the DC for zone-level productivity and travel distance analysis."
    - name: "target_zone"
      expr: target_zone
      comment: "Target zone within the DC for zone-level productivity and slotting optimization."
  measures:
    - name: "total_task_count"
      expr: COUNT(1)
      comment: "Total number of warehouse tasks. Baseline volume metric for DC operational workload."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total units processed across warehouse tasks. Core throughput metric for DC operations."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned units for warehouse tasks. Used as denominator for task accuracy calculations."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between planned and actual. Measures task execution accuracy and inventory discrepancies."
    - name: "total_task_duration_minutes"
      expr: SUM(CAST(task_duration_minutes AS DOUBLE))
      comment: "Total time spent on warehouse tasks. Used to measure labor utilization and identify bottlenecks."
    - name: "avg_task_duration_minutes"
      expr: AVG(CAST(task_duration_minutes AS DOUBLE))
      comment: "Average task duration in minutes. Compared to standard labor minutes to measure productivity vs. engineered standards."
    - name: "total_standard_labor_minutes"
      expr: SUM(CAST(standard_labor_minutes AS DOUBLE))
      comment: "Total standard (engineered) labor minutes for tasks. Used as denominator for labor efficiency ratio."
    - name: "total_travel_distance_feet"
      expr: SUM(CAST(travel_distance_feet AS DOUBLE))
      comment: "Total travel distance across warehouse tasks. Used to evaluate slotting effectiveness and reduce non-value-added travel."
    - name: "avg_travel_distance_feet"
      expr: AVG(CAST(travel_distance_feet AS DOUBLE))
      comment: "Average travel distance per task. Key slotting optimization KPI; high travel distance indicates poor slot assignments."
    - name: "exception_task_count"
      expr: SUM(CASE WHEN exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tasks with exceptions. Used to track exception rates and identify systemic process failures."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold KPIs covering affected inventory, chargeback exposure, and resolution cycle times. Used by quality assurance and procurement to manage vendor quality compliance and financial recovery."
  source: "`vibe_retail_v1`.`supplychain`.`quality_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the quality hold (e.g., active, released, disposed) for exception management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold (e.g., inspection, regulatory, damage) for root cause categorization."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for the quality hold. Used for vendor performance analysis and corrective action tracking."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition of held inventory (e.g., accept, return, destroy, rework). Used for inventory recovery analysis."
    - name: "chargeback_eligible_flag"
      expr: chargeback_eligible_flag
      comment: "Whether the quality hold qualifies for a vendor chargeback. Used to track financial recovery opportunities."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the held inventory contains hazardous materials. Used for regulatory compliance and disposal cost tracking."
    - name: "hold_date"
      expr: DATE_TRUNC('month', hold_date)
      comment: "Month of hold creation for quality exception trending over time."
    - name: "disposition_date"
      expr: DATE_TRUNC('month', disposition_date)
      comment: "Month of disposition for resolution cycle time analysis."
    - name: "affected_entity_type"
      expr: affected_entity_type
      comment: "Type of entity affected by the hold (e.g., SKU, lot, handling unit) for scope analysis."
  measures:
    - name: "total_hold_count"
      expr: COUNT(1)
      comment: "Total number of quality holds. Baseline volume metric for quality exception frequency."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total units placed on quality hold. Measures the scale of inventory at risk from quality issues."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed for quality holds. Measures financial recovery from vendor quality failures."
    - name: "avg_temperature_reading_celsius"
      expr: AVG(CAST(temperature_reading_celsius AS DOUBLE))
      comment: "Average temperature reading for temperature-related quality holds. Used to assess cold chain breach severity."
    - name: "chargeback_eligible_count"
      expr: SUM(CASE WHEN chargeback_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of quality holds eligible for vendor chargeback. Used to track financial recovery pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_cross_dock_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cross-dock planning KPIs covering dwell time, fill rates, and plan accuracy. Used by DC operations and supply chain planners to optimize flow-through efficiency and reduce handling costs."
  source: "`vibe_retail_v1`.`supplychain`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the cross-dock plan (e.g., planned, in-progress, complete, cancelled)."
  measures:
    - name: "total_plan_count"
      expr: COUNT(1)
      comment: "Total number of cross-dock plans. Baseline volume metric for cross-dock activity."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_inventory_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-facility inventory transfer KPIs covering transfer volume, cost, and accuracy. Used by supply chain planners to manage network inventory balancing and reduce excess stock."
  source: "`vibe_retail_v1`.`supplychain`.`inventory_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the inventory transfer (e.g., planned, in-transit, received, cancelled)."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of transfer (e.g., DC-to-store, store-to-store, DC-to-DC) for network flow analysis."
    - name: "transfer_reason_code"
      expr: transfer_reason_code
      comment: "Reason for the transfer (e.g., rebalancing, markdown, store closure) for root cause analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the transfer for execution sequencing and SLA management."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Whether the transfer flows through cross-dock. Used to measure cross-dock utilization for transfers."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the transfer involves hazardous materials. Used for compliance and handling cost analysis."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the transfer requires temperature-controlled handling. Used for cold chain capacity planning."
    - name: "actual_ship_date"
      expr: DATE_TRUNC('month', actual_ship_date)
      comment: "Month of actual shipment for transfer volume trending."
    - name: "origin_facility_type"
      expr: origin_facility_type
      comment: "Type of origin facility (e.g., DC, store) for network flow analysis."
    - name: "destination_facility_type"
      expr: destination_facility_type
      comment: "Type of destination facility (e.g., DC, store) for network flow analysis."
  measures:
    - name: "total_transfer_count"
      expr: COUNT(1)
      comment: "Total number of inventory transfers. Baseline volume metric for network inventory balancing activity."
    - name: "total_transfer_quantity"
      expr: SUM(CAST(transfer_quantity AS DOUBLE))
      comment: "Total units planned for transfer. Core volume metric for network inventory rebalancing."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped in transfers. Used to measure transfer execution completeness."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units received at destination. Compared to shipped to measure transfer accuracy."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for inventory transfers. Used to assess network rebalancing cost and optimize transfer decisions."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of transferred inventory. Used for transfer pricing and inventory valuation."
    - name: "total_transfer_value"
      expr: SUM(CAST(total_transfer_value AS DOUBLE))
      comment: "Total value of inventory transferred across the network. Used for financial reporting and working capital analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_dc_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center facility KPIs covering capacity, utilization, and operational characteristics. Used by supply chain leadership to manage DC network capacity and investment decisions."
  source: "`vibe_retail_v1`.`supplychain`.`dc_facility`"
  dimensions:
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the DC facility (e.g., active, inactive, under-construction) for network planning."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of DC facility (e.g., regional DC, fulfillment center, cross-dock hub) for network segmentation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g., owned, leased, 3PL) for cost structure and strategic planning analysis."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation in the facility (e.g., manual, semi-automated, fully automated) for productivity benchmarking."
    - name: "temperature_zone_ambient_flag"
      expr: temperature_zone_ambient_flag
      comment: "Whether the facility has ambient temperature storage. Used for network capability mapping."
    - name: "temperature_zone_chilled_flag"
      expr: temperature_zone_chilled_flag
      comment: "Whether the facility has chilled storage capability. Used for cold chain network planning."
    - name: "temperature_zone_frozen_flag"
      expr: temperature_zone_frozen_flag
      comment: "Whether the facility has frozen storage capability. Used for frozen supply chain network planning."
    - name: "bonded_warehouse_flag"
      expr: bonded_warehouse_flag
      comment: "Whether the facility is a bonded warehouse. Used for import/export and customs compliance planning."
    - name: "owning_region_code"
      expr: owning_region_code
      comment: "Region owning the DC facility. Used for regional supply chain performance analysis."
    - name: "opened_date"
      expr: DATE_TRUNC('year', opened_date)
      comment: "Year the facility opened. Used for asset age analysis and capital investment planning."
  measures:
    - name: "total_facility_count"
      expr: COUNT(1)
      comment: "Total number of DC facilities in the network. Baseline metric for network footprint analysis."
    - name: "total_storage_capacity_cubic_feet"
      expr: SUM(CAST(storage_capacity_cubic_feet AS DOUBLE))
      comment: "Total storage capacity in cubic feet across DC network. Used for network capacity planning and utilization analysis."
    - name: "total_warehouse_square_footage"
      expr: SUM(CAST(warehouse_square_footage AS DOUBLE))
      comment: "Total warehouse square footage across DC network. Used for real estate portfolio management and capacity planning."
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total facility square footage including non-warehouse areas. Used for facility cost and lease management."
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude of DC facilities. Used for network gravity analysis and optimal DC location modeling."
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude of DC facilities. Used for network gravity analysis and transportation cost optimization."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound shipment KPIs covering on-time delivery, freight cost, and volume throughput. Used by DC operations and logistics leadership to manage carrier performance and delivery reliability."
  source: "`vibe_retail_v1`.`supplychain`.`outbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the outbound shipment (e.g., staged, shipped, in-transit, delivered, exception)."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of outbound shipment (e.g., store replenishment, transfer, ecommerce) for volume segmentation."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Whether the shipment was delivered on or before the estimated delivery date. Core carrier performance KPI."
    - name: "service_level"
      expr: service_level
      comment: "Carrier service level used (e.g., ground, expedited, overnight) for cost vs. speed analysis."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of delivery destination (e.g., store, DC, customer) for network flow analysis."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the shipment contains hazardous materials. Used for compliance and specialized carrier cost analysis."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Whether the shipment requires temperature-controlled transport. Used for cold chain cost and compliance analysis."
    - name: "ship_date"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month of shipment for outbound volume trending and carrier capacity planning."
    - name: "freight_currency_code"
      expr: freight_currency_code
      comment: "Currency of freight cost for multi-currency logistics spend analysis."
  measures:
    - name: "total_shipment_count"
      expr: COUNT(1)
      comment: "Total number of outbound shipments. Baseline volume metric for DC outbound logistics activity."
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN on_time_delivery_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments delivered on time. Numerator for on-time delivery rate; core carrier performance KPI."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total outbound freight cost. Primary logistics spend KPI used to manage carrier costs and negotiate rates."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per outbound shipment. Used to benchmark carrier efficiency and identify cost outliers."
    - name: "total_cube_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Total cubic volume of outbound shipments. Used for trailer utilization and freight cost optimization."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of outbound shipments. Used for freight cost calculation and carrier capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain plan KPIs covering inventory position, demand-supply balance, and stockout risk. Used by supply chain planners and executives to manage inventory investment and service level performance."
  source: "`vibe_retail_v1`.`supplychain`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the supply plan (e.g., draft, approved, published, archived)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of supply plan (e.g., replenishment, allocation, promotional) for planning process segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the plan. Used to track planning cycle completion."
    - name: "excess_inventory_flag"
      expr: excess_inventory_flag
      comment: "Whether the plan identifies excess inventory. Used to trigger markdown or transfer actions."
    - name: "supply_constrained_flag"
      expr: supply_constrained_flag
      comment: "Whether the plan is supply-constrained. Used to identify allocation decisions and vendor escalations needed."
    - name: "week_start_date"
      expr: DATE_TRUNC('month', week_start_date)
      comment: "Month of planning week start for time-series supply plan analysis."
    - name: "planning_horizon_weeks"
      expr: planning_horizon_weeks
      comment: "Planning horizon in weeks. Used to segment plans by short-term vs. long-term horizon."
  measures:
    - name: "total_plan_count"
      expr: COUNT(1)
      comment: "Total number of supply plan records. Baseline volume metric for planning coverage."
    - name: "total_demand_forecast_qty"
      expr: SUM(CAST(demand_forecast_qty AS DOUBLE))
      comment: "Total forecasted demand units in supply plans. Core demand signal driving replenishment decisions."
    - name: "total_consensus_demand_qty"
      expr: SUM(CAST(consensus_demand_qty AS DOUBLE))
      comment: "Total consensus demand units after S&OP alignment. Represents the agreed demand plan used for supply decisions."
    - name: "total_beginning_on_hand_qty"
      expr: SUM(CAST(beginning_on_hand_qty AS DOUBLE))
      comment: "Total beginning on-hand inventory across plans. Used to assess starting inventory position."
    - name: "total_projected_on_hand_qty"
      expr: SUM(CAST(projected_on_hand_qty AS DOUBLE))
      comment: "Total projected on-hand inventory at end of planning period. Key inventory health KPI."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock units planned. Measures inventory buffer investment to protect service levels."
    - name: "total_replenishment_order_qty"
      expr: SUM(CAST(replenishment_order_qty AS DOUBLE))
      comment: "Total units planned for replenishment orders. Core supply planning output driving PO creation."
    - name: "total_in_transit_qty"
      expr: SUM(CAST(in_transit_qty AS DOUBLE))
      comment: "Total units currently in transit. Used to compute total supply position including pipeline inventory."
    - name: "total_open_po_qty"
      expr: SUM(CAST(open_po_qty AS DOUBLE))
      comment: "Total units on open purchase orders. Used to assess committed supply against demand."
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply across plans. Key inventory coverage KPI; low WOS signals stockout risk."
    - name: "avg_sell_through_rate_pct"
      expr: AVG(CAST(sell_through_rate_pct AS DOUBLE))
      comment: "Average sell-through rate across plans. Used to assess inventory productivity and markdown risk."
    - name: "avg_stockout_risk_score"
      expr: AVG(CAST(stockout_risk_score AS DOUBLE))
      comment: "Average stockout risk score across plans. Used to prioritize replenishment actions and prevent lost sales."
    - name: "avg_supplier_fill_rate_pct"
      expr: AVG(CAST(supplier_fill_rate_pct AS DOUBLE))
      comment: "Average supplier fill rate in supply plans. Used to assess supply reliability and adjust safety stock."
$$;