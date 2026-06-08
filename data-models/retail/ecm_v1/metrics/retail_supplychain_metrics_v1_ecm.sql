-- Metric views for domain: supplychain | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement KPIs tracking PO value, fill rates, lead times, and supplier performance for executive procurement decisions"
  source: "`retail_ecm`.`supplychain`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status for tracking order lifecycle and identifying bottlenecks"
    - name: "po_type"
      expr: po_type
      comment: "Purchase order type for segmenting procurement strategies"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of PO creation for time-series procurement analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for tracking procurement governance and bottlenecks"
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Cross-dock flag for analyzing direct-to-store flow efficiency"
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Drop-ship flag for analyzing vendor-direct fulfillment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency procurement analysis"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Total purchase order value driving procurement spend decisions and budget management"
    - name: "total_ordered_units"
      expr: SUM(CAST(total_ordered_units AS DOUBLE))
      comment: "Total units ordered for inventory planning and capacity decisions"
    - name: "total_received_units"
      expr: SUM(CAST(total_received_units AS DOUBLE))
      comment: "Total units received for supplier performance tracking"
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average supplier fill rate percentage driving vendor scorecard and sourcing decisions"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for supplier performance evaluation and safety stock planning"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount for procurement savings tracking and negotiation effectiveness"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount for cash flow planning and working capital management"
    - name: "po_count"
      expr: COUNT(1)
      comment: "Count of purchase orders for procurement workload and efficiency analysis"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of unique vendors for supplier diversification and risk management"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics KPIs tracking on-time arrival, freight costs, and receiving efficiency for supply chain performance management"
  source: "`retail_ecm`.`supplychain`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Shipment status for tracking inbound flow and identifying delays"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Shipment type for segmenting inbound logistics strategies"
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_date)
      comment: "Month of actual arrival for time-series inbound performance analysis"
    - name: "on_time_arrival_flag"
      expr: on_time_arrival_flag
      comment: "On-time arrival flag for supplier and carrier performance tracking"
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Cross-dock flag for analyzing flow-through efficiency"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Hazmat flag for compliance and safety tracking"
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Temperature-controlled flag for cold chain performance"
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Temperature compliance flag for quality and regulatory adherence"
  measures:
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost for transportation spend management and carrier negotiation decisions"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per shipment for cost efficiency benchmarking"
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight for capacity planning and freight optimization"
    - name: "total_expected_weight_kg"
      expr: SUM(CAST(expected_weight_kg AS DOUBLE))
      comment: "Total expected weight for variance analysis and forecasting accuracy"
    - name: "on_time_arrival_rate"
      expr: AVG(CASE WHEN on_time_arrival_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "On-time arrival rate percentage driving carrier scorecard and routing decisions"
    - name: "temperature_compliance_rate"
      expr: AVG(CASE WHEN temperature_compliant_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Temperature compliance rate for cold chain quality and risk management"
    - name: "shipment_count"
      expr: COUNT(1)
      comment: "Count of inbound shipments for workload planning and throughput analysis"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Count of unique carriers for carrier diversification and performance comparison"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of unique vendors for supplier relationship and consolidation analysis"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound fulfillment KPIs tracking fill rates, on-time shipment, and order cycle time for customer service and operational excellence"
  source: "`retail_ecm`.`supplychain`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Order status for tracking fulfillment lifecycle and identifying bottlenecks"
    - name: "order_type"
      expr: order_type
      comment: "Order type for segmenting fulfillment strategies"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order creation for time-series fulfillment analysis"
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for analyzing store vs DC vs customer fulfillment"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for service level and expedite analysis"
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Cross-dock flag for flow-through efficiency tracking"
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Drop-ship flag for vendor-direct fulfillment analysis"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Hazmat flag for compliance and safety tracking"
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Replenishment type for inventory strategy segmentation"
  measures:
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage driving inventory availability and customer service decisions"
    - name: "total_units"
      expr: SUM(CAST(total_units AS DOUBLE))
      comment: "Total units shipped for throughput and capacity planning"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight for transportation planning and cost allocation"
    - name: "total_cube_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Total cube for warehouse and trailer utilization optimization"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Count of outbound orders for workload planning and productivity analysis"
    - name: "unique_destinations"
      expr: COUNT(DISTINCT destination_dc_facility_id)
      comment: "Count of unique destination facilities for network complexity and routing analysis"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Count of unique carriers for carrier diversification and performance comparison"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand planning KPIs tracking forecast accuracy, bias, and promotional lift for inventory optimization and allocation decisions"
  source: "`retail_ecm`.`supplychain`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Forecast status for tracking planning lifecycle and approval workflow"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Forecast type for segmenting statistical vs collaborative planning"
    - name: "forecast_period_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Forecast period month for time-series demand analysis"
    - name: "demand_category"
      expr: demand_category
      comment: "Demand category for segmenting product lifecycle and velocity"
    - name: "planning_channel"
      expr: planning_channel
      comment: "Planning channel for omnichannel demand segmentation"
    - name: "is_promotional_period"
      expr: is_promotional_period
      comment: "Promotional period flag for event-driven demand analysis"
    - name: "is_new_item"
      expr: is_new_item
      comment: "New item flag for launch planning and ramp-up tracking"
    - name: "is_override_applied"
      expr: is_override_applied
      comment: "Override applied flag for planner intervention and judgment analysis"
  measures:
    - name: "total_forecasted_units"
      expr: SUM(CAST(forecasted_units AS DOUBLE))
      comment: "Total forecasted units for aggregate demand planning and capacity decisions"
    - name: "total_baseline_forecast_units"
      expr: SUM(CAST(baseline_forecast_units AS DOUBLE))
      comment: "Total baseline forecast units for statistical model performance tracking"
    - name: "total_promotional_lift_units"
      expr: SUM(CAST(promotional_lift_units AS DOUBLE))
      comment: "Total promotional lift units for event planning and trade spend ROI"
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue for financial planning and sales target alignment"
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average mean absolute percentage error for forecast accuracy tracking and model tuning decisions"
    - name: "avg_wmape"
      expr: AVG(CAST(wmape AS DOUBLE))
      comment: "Average weighted mean absolute percentage error for value-weighted accuracy assessment"
    - name: "avg_forecast_bias"
      expr: AVG(CAST(forecast_bias AS DOUBLE))
      comment: "Average forecast bias for systematic over/under-forecasting detection and correction"
    - name: "avg_weeks_of_supply"
      expr: AVG(CAST(weeks_of_supply AS DOUBLE))
      comment: "Average weeks of supply for inventory health and turn optimization"
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Count of forecasts for planning coverage and workload analysis"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique SKUs forecasted for assortment planning and complexity management"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_replenishment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment planning KPIs tracking order quantities, service levels, and inventory targets for store and DC allocation decisions"
  source: "`retail_ecm`.`supplychain`.`replenishment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Plan status for tracking replenishment lifecycle and approval workflow"
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type for segmenting replenishment strategies"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', plan_horizon_start_date)
      comment: "Plan month for time-series replenishment analysis"
    - name: "node_type"
      expr: node_type
      comment: "Node type for segmenting store vs DC replenishment"
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method for strategy effectiveness comparison"
    - name: "safety_stock_method"
      expr: safety_stock_method
      comment: "Safety stock method for buffer strategy analysis"
    - name: "buyer_override_flag"
      expr: buyer_override_flag
      comment: "Buyer override flag for planner intervention tracking"
    - name: "moq_compliance_flag"
      expr: moq_compliance_flag
      comment: "MOQ compliance flag for supplier constraint adherence"
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Promotion flag for event-driven replenishment analysis"
  measures:
    - name: "total_planned_order_qty"
      expr: SUM(CAST(planned_order_qty AS DOUBLE))
      comment: "Total planned order quantity for aggregate replenishment and capacity planning"
    - name: "total_approved_order_qty"
      expr: SUM(CAST(approved_order_qty AS DOUBLE))
      comment: "Total approved order quantity for committed allocation and purchase order generation"
    - name: "total_planned_order_value"
      expr: SUM(CAST(planned_order_value AS DOUBLE))
      comment: "Total planned order value for financial planning and OTB management"
    - name: "total_forecasted_demand_qty"
      expr: SUM(CAST(forecasted_demand_qty AS DOUBLE))
      comment: "Total forecasted demand quantity for demand-supply alignment tracking"
    - name: "total_current_on_hand_qty"
      expr: SUM(CAST(current_on_hand_qty AS DOUBLE))
      comment: "Total current on-hand quantity for inventory position visibility"
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity for buffer investment and service level decisions"
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average fill rate target percentage for service level policy tracking"
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage for customer service commitment tracking"
    - name: "avg_weeks_of_supply_target"
      expr: AVG(CAST(weeks_of_supply_target AS DOUBLE))
      comment: "Average weeks of supply target for inventory turn and working capital optimization"
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Count of replenishment plans for planning coverage and workload analysis"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique SKUs planned for assortment and complexity management"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier SLA performance KPIs tracking breach rates, fill rates, and chargeback exposure for vendor management and contract compliance"
  source: "`retail_ecm`.`supplychain`.`sla_performance`"
  dimensions:
    - name: "performance_status"
      expr: performance_status
      comment: "Performance status for tracking SLA compliance lifecycle"
    - name: "sla_type"
      expr: sla_type
      comment: "SLA type for segmenting performance by contract terms"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start_date)
      comment: "Measurement month for time-series SLA tracking"
    - name: "breach_flag"
      expr: breach_flag
      comment: "Breach flag for identifying non-compliance events"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Breach severity for prioritizing corrective actions"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Escalation flag for tracking critical supplier issues"
    - name: "chargeback_eligible_flag"
      expr: chargeback_eligible_flag
      comment: "Chargeback eligible flag for financial recovery tracking"
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Chargeback status for recovery process management"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Corrective action status for supplier improvement tracking"
  measures:
    - name: "breach_rate"
      expr: AVG(CASE WHEN breach_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "SLA breach rate percentage driving vendor scorecard and sourcing decisions"
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage for supplier performance and allocation decisions"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total ordered quantity for demand volume tracking"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total shipped quantity for supplier fulfillment tracking"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total received quantity for end-to-end supply chain performance"
    - name: "total_short_ship_quantity"
      expr: SUM(CAST(short_ship_quantity AS DOUBLE))
      comment: "Total short-ship quantity for supplier reliability and inventory risk assessment"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount for financial recovery and supplier penalty tracking"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual SLA metric value for performance benchmarking"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target SLA metric value for contract compliance tracking"
    - name: "avg_variance_value"
      expr: AVG(CAST(variance_value AS DOUBLE))
      comment: "Average variance from target for performance gap analysis and improvement prioritization"
    - name: "sla_measurement_count"
      expr: COUNT(1)
      comment: "Count of SLA measurements for compliance coverage and audit trail"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of unique vendors measured for supplier base management"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_cross_dock_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cross-dock flow-through KPIs tracking dwell time, fill rates, and plan variance for DC efficiency and direct-to-store optimization"
  source: "`retail_ecm`.`supplychain`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Plan status for tracking cross-dock execution lifecycle"
  measures:
    - name: "cross_dock_plan_count"
      expr: COUNT(1)
      comment: "Count of cross-dock plans for workload and complexity management"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique SKUs cross-docked for assortment and flow-through suitability analysis"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of unique vendors for supplier cross-dock capability assessment"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_quality_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality hold KPIs tracking hold rates, disposition decisions, and chargeback exposure for supplier quality management and risk mitigation"
  source: "`retail_ecm`.`supplychain`.`quality_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Hold status for tracking quality issue lifecycle"
    - name: "hold_type"
      expr: hold_type
      comment: "Hold type for segmenting quality issue categories"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', hold_date)
      comment: "Hold month for time-series quality trend analysis"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Hold reason code for root cause analysis and corrective action prioritization"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for quality resolution tracking"
    - name: "chargeback_eligible_flag"
      expr: chargeback_eligible_flag
      comment: "Chargeback eligible flag for financial recovery tracking"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Hazmat flag for compliance and safety risk tracking"
  measures:
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total affected quantity for quality impact and inventory risk assessment"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount for supplier quality cost recovery and penalty tracking"
    - name: "quality_hold_count"
      expr: COUNT(1)
      comment: "Count of quality holds for defect rate and supplier quality scorecard decisions"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Count of unique vendors with quality holds for supplier risk segmentation"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of unique SKUs on quality hold for product quality risk assessment"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_dc_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center capacity and capability KPIs for network planning, site selection, and facility investment decisions"
  source: "`retail_ecm`.`supplychain`.`dc_facility`"
  dimensions:
    - name: "facility_status"
      expr: facility_status
      comment: "Facility status for tracking operational network footprint"
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type for segmenting DC capabilities and strategies"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type for lease vs own financial analysis"
    - name: "automation_level"
      expr: automation_level
      comment: "Automation level for technology investment and productivity benchmarking"
    - name: "bonded_warehouse_flag"
      expr: bonded_warehouse_flag
      comment: "Bonded warehouse flag for customs and import capability"
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Hazmat certified flag for compliance capability tracking"
    - name: "twenty_four_seven_operation_flag"
      expr: twenty_four_seven_operation_flag
      comment: "24/7 operation flag for capacity and service level capability"
    - name: "temperature_zone_frozen_flag"
      expr: temperature_zone_frozen_flag
      comment: "Frozen temperature zone flag for cold chain capability"
  measures:
    - name: "total_storage_capacity_cubic_feet"
      expr: SUM(CAST(storage_capacity_cubic_feet AS DOUBLE))
      comment: "Total storage capacity in cubic feet for network capacity planning and expansion decisions"
    - name: "total_warehouse_square_footage"
      expr: SUM(CAST(warehouse_square_footage AS DOUBLE))
      comment: "Total warehouse square footage for facility footprint and real estate investment tracking"
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude for geographic network center-of-gravity analysis"
    - name: "avg_longitude"
      expr: AVG(CAST(longitude AS DOUBLE))
      comment: "Average longitude for geographic network center-of-gravity analysis"
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Count of DC facilities for network footprint and complexity management"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`supplychain_wave`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wave picking KPIs tracking fill rates, labor productivity, and pick accuracy for warehouse operations optimization"
  source: "`retail_ecm`.`supplychain`.`wave`"
  dimensions:
    - name: "wave_status"
      expr: wave_status
      comment: "Wave status for tracking picking execution lifecycle"
    - name: "wave_type"
      expr: wave_type
      comment: "Wave type for segmenting picking strategies"
    - name: "channel"
      expr: channel
      comment: "Channel for omnichannel fulfillment analysis"
    - name: "generation_method"
      expr: generation_method
      comment: "Generation method for wave optimization strategy tracking"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Hazmat flag for compliance and safety tracking"
    - name: "is_promotional"
      expr: is_promotional
      comment: "Promotional flag for event-driven fulfillment analysis"
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Temperature-controlled flag for cold chain picking performance"
  measures:
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage driving inventory availability and pick accuracy decisions"
    - name: "avg_units_per_hour"
      expr: AVG(CAST(units_per_hour AS DOUBLE))
      comment: "Average units per hour for labor productivity benchmarking and staffing optimization"
    - name: "total_labor_hours_actual"
      expr: SUM(CAST(labor_hours_actual AS DOUBLE))
      comment: "Total actual labor hours for workforce planning and cost management"
    - name: "total_labor_hours_planned"
      expr: SUM(CAST(labor_hours_planned AS DOUBLE))
      comment: "Total planned labor hours for labor standards and efficiency tracking"
    - name: "total_units"
      expr: SUM(CAST(total_units AS DOUBLE))
      comment: "Total units picked for throughput and capacity planning"
    - name: "total_picked_units"
      expr: SUM(CAST(picked_units AS DOUBLE))
      comment: "Total picked units for execution tracking"
    - name: "total_short_units"
      expr: SUM(CAST(short_units AS DOUBLE))
      comment: "Total short units for inventory accuracy and replenishment gap analysis"
    - name: "wave_count"
      expr: COUNT(1)
      comment: "Count of waves for workload and wave optimization analysis"
    - name: "unique_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Count of unique carriers for carrier consolidation and routing analysis"
$$;