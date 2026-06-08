-- Metric views for domain: order | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order performance metrics tracking order value, volume, and fulfillment efficiency across channels, markets, and compliance dimensions"
  source: "`semiconductors_ecm`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., open, confirmed, shipped, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, blanket, NRE, MPW, die bank)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel through which the order was placed"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end-market segment (e.g., automotive, mobile, AI, IoT)"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for the order shipment"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "priority"
      expr: priority
      comment: "Order priority level"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether the order is in backlog"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Indicates whether the order qualifies for CHIPS Act incentives"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates whether the order is subject to ITAR export controls"
    - name: "export_license_required"
      expr: export_license_required
      comment: "Indicates whether an export license is required for this order"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current allocation status of the order"
    - name: "order_source"
      expr: order_source
      comment: "Source system or channel from which the order originated"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of orders"
    - name: "total_gross_order_value"
      expr: SUM(CAST(gross_order_value AS DOUBLE))
      comment: "Total gross order value across all orders"
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value (after discounts and adjustments)"
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total non-recurring engineering charges across orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on orders"
    - name: "avg_gross_order_value"
      expr: AVG(CAST(gross_order_value AS DOUBLE))
      comment: "Average gross order value per order"
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net order value per order"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers placing orders"
    - name: "backlog_order_count"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders currently in backlog"
    - name: "backlog_order_value"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN CAST(net_order_value AS DOUBLE) ELSE 0 END)
      comment: "Total net value of orders in backlog"
    - name: "chips_act_eligible_order_value"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN CAST(net_order_value AS DOUBLE) ELSE 0 END)
      comment: "Total net order value for CHIPS Act eligible orders"
    - name: "export_controlled_order_count"
      expr: SUM(CASE WHEN export_license_required = TRUE OR itar_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders requiring export controls or ITAR compliance"
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled orders"
    - name: "on_hold_order_count"
      expr: SUM(CASE WHEN hold_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of orders currently on hold"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level metrics tracking product mix, fulfillment performance, and revenue realization at the SKU level"
  source: "`semiconductors_ecm`.`order`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line"
    - name: "item_category"
      expr: item_category
      comment: "Category of the line item"
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation for this line"
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for the line item"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product was manufactured"
    - name: "order_year"
      expr: YEAR(date_entered)
      comment: "Year the order line was entered"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', date_entered)
      comment: "Month the order line was entered"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for the line item"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Indicates whether the line item is RoHS compliant"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Indicates whether the line item is REACH compliant"
    - name: "die_bank_order"
      expr: die_bank_order
      comment: "Indicates whether this is a die bank order line"
    - name: "mpw_order"
      expr: mpw_order
      comment: "Indicates whether this is a multi-project wafer order line"
    - name: "wafer_start_authorization"
      expr: wafer_start_authorization
      comment: "Indicates whether this line requires wafer start authorization"
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Temperature grade specification for the product"
    - name: "speed_grade"
      expr: speed_grade
      comment: "Speed grade specification for the product"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of order lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for shipment"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity actually shipped"
    - name: "total_line_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value across all order lines"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across order lines"
    - name: "avg_line_value"
      expr: AVG(CAST(net_value AS DOUBLE))
      comment: "Average net value per order line"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs ordered"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with order lines"
    - name: "cancelled_line_count"
      expr: SUM(CASE WHEN cancellation_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cancelled order lines"
    - name: "partial_shipment_line_count"
      expr: SUM(CASE WHEN partial_shipment_allowed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lines allowing partial shipment"
    - name: "die_bank_line_count"
      expr: SUM(CASE WHEN die_bank_order = TRUE THEN 1 ELSE 0 END)
      comment: "Number of die bank order lines"
    - name: "mpw_line_count"
      expr: SUM(CASE WHEN mpw_order = TRUE THEN 1 ELSE 0 END)
      comment: "Number of multi-project wafer order lines"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order_backlog_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backlog health and aging metrics tracking unfulfilled demand, allocation efficiency, and customer commitment performance"
  source: "`semiconductors_ecm`.`order`.`backlog_position`"
  dimensions:
    - name: "backlog_status"
      expr: backlog_status
      comment: "Current status of the backlog position"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status for the backlog item"
    - name: "order_type"
      expr: order_type
      comment: "Type of order in backlog"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end-market segment for backlog item"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the backlog position"
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for backlog item"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the backlog snapshot"
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority ranking of the backlog item"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Indicates whether export controls apply"
    - name: "design_win_flag"
      expr: design_win_flag
      comment: "Indicates whether this is associated with a design win"
    - name: "hold_code"
      expr: hold_code
      comment: "Hold code if the backlog item is on hold"
    - name: "push_out_reason_code"
      expr: push_out_reason_code
      comment: "Reason code for delivery date push-outs"
  measures:
    - name: "total_backlog_positions"
      expr: COUNT(1)
      comment: "Total number of backlog positions"
    - name: "total_backlog_value"
      expr: SUM(CAST(backlog_value AS DOUBLE))
      comment: "Total value of backlog positions"
    - name: "total_original_order_quantity"
      expr: SUM(CAST(original_order_quantity AS DOUBLE))
      comment: "Total originally ordered quantity in backlog"
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed for delivery"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to backlog positions"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity already shipped from backlog"
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total quantity cancelled from backlog"
    - name: "avg_backlog_value"
      expr: AVG(CAST(backlog_value AS DOUBLE))
      comment: "Average value per backlog position"
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price in backlog"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with backlog positions"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs in backlog"
    - name: "design_win_backlog_count"
      expr: SUM(CASE WHEN design_win_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of backlog positions associated with design wins"
    - name: "on_hold_backlog_count"
      expr: SUM(CASE WHEN hold_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of backlog positions currently on hold"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment execution and logistics performance metrics tracking on-time delivery, freight efficiency, and quality incidents"
  source: "`semiconductors_ecm`.`order`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the shipping carrier"
    - name: "service_level"
      expr: service_level
      comment: "Service level for the shipment (e.g., express, standard)"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for the shipment"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code defining delivery terms"
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for the shipment"
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month the shipment was dispatched"
    - name: "ship_year"
      expr: YEAR(ship_date)
      comment: "Year the shipment was dispatched"
    - name: "package_type"
      expr: package_type
      comment: "Type of packaging used for the shipment"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Indicates whether the shipment is RoHS compliant"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Indicates whether the shipment is REACH compliant"
    - name: "damaged_goods_flag"
      expr: damaged_goods_flag
      comment: "Indicates whether damaged goods were reported"
    - name: "quantity_shortage_flag"
      expr: quantity_shortage_flag
      comment: "Indicates whether a quantity shortage occurred"
    - name: "wrong_part_flag"
      expr: wrong_part_flag
      comment: "Indicates whether wrong parts were shipped"
    - name: "is_multi_leg"
      expr: is_multi_leg
      comment: "Indicates whether the shipment involves multiple legs"
  measures:
    - name: "total_shipment_count"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all shipments"
    - name: "total_pod_confirmed_quantity"
      expr: SUM(CAST(pod_confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed via proof of delivery"
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost in USD"
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared value of shipments in USD"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of shipments in kilograms"
    - name: "avg_freight_cost_usd"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment in USD"
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per shipment in kilograms"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers receiving shipments"
    - name: "distinct_carrier_count"
      expr: COUNT(DISTINCT carrier_name)
      comment: "Number of unique carriers used"
    - name: "damaged_shipment_count"
      expr: SUM(CASE WHEN damaged_goods_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with damaged goods reported"
    - name: "shortage_shipment_count"
      expr: SUM(CASE WHEN quantity_shortage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with quantity shortages"
    - name: "wrong_part_shipment_count"
      expr: SUM(CASE WHEN wrong_part_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with wrong parts shipped"
    - name: "multi_leg_shipment_count"
      expr: SUM(CASE WHEN is_multi_leg = TRUE THEN 1 ELSE 0 END)
      comment: "Number of multi-leg shipments"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order_allocation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply allocation and constraint management metrics tracking allocation efficiency, constrained supply impact, and fab utilization"
  source: "`semiconductors_ecm`.`order`.`allocation_record`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., firm, tentative, reserved)"
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of the allocation (e.g., fab, die bank, finished goods)"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status of the allocation"
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end-market segment for the allocation"
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site code where allocation originates"
    - name: "osat_site_code"
      expr: osat_site_code
      comment: "OSAT (assembly/test) site code for the allocation"
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month the allocation was made"
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year the allocation was made"
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether the allocation is for backlog"
    - name: "constrained_supply_flag"
      expr: constrained_supply_flag
      comment: "Indicates whether the allocation is constrained by supply"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Indicates whether the allocation is CHIPS Act eligible"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Indicates whether the allocation is ITAR controlled"
    - name: "quality_disposition"
      expr: quality_disposition
      comment: "Quality disposition status for the allocation"
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority ranking of the allocation"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot allocated (e.g., production, engineering)"
  measures:
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of allocation records"
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated across all records"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for allocation"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from allocations"
    - name: "avg_allocated_quantity"
      expr: AVG(CAST(allocated_quantity AS DOUBLE))
      comment: "Average quantity per allocation record"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with allocations"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs allocated"
    - name: "distinct_fab_tool_count"
      expr: COUNT(DISTINCT allocated_fab_tool_id)
      comment: "Number of unique fab tools used in allocations"
    - name: "constrained_allocation_count"
      expr: SUM(CASE WHEN constrained_supply_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of allocations constrained by supply"
    - name: "backlog_allocation_count"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of allocations for backlog orders"
    - name: "cancelled_allocation_count"
      expr: SUM(CASE WHEN cancellation_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cancelled allocations"
    - name: "on_hold_allocation_count"
      expr: SUM(CASE WHEN hold_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of allocations currently on hold"
    - name: "chips_act_allocation_count"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of CHIPS Act eligible allocations"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization and quality incident metrics tracking return rates, credit impact, and root cause analysis"
  source: "`semiconductors_ecm`.`order`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for the return"
    - name: "disposition_instruction"
      expr: disposition_instruction
      comment: "Disposition instruction for returned goods"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the inspection of returned goods"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the RMA was requested"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the RMA was requested"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates whether the RMA is a warranty claim"
    - name: "failure_analysis_requested"
      expr: failure_analysis_requested
      comment: "Indicates whether failure analysis was requested"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether corrective action is required"
    - name: "dppm_impact_flag"
      expr: dppm_impact_flag
      comment: "Indicates whether the RMA impacts DPPM metrics"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Indicates whether export controls apply to the return"
    - name: "return_shipping_carrier"
      expr: return_shipping_carrier
      comment: "Carrier used for return shipment"
  measures:
    - name: "total_rma_count"
      expr: COUNT(1)
      comment: "Total number of RMA records"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for RMAs"
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with RMAs"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs returned via RMA"
    - name: "warranty_claim_count"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs that are warranty claims"
    - name: "failure_analysis_requested_count"
      expr: SUM(CASE WHEN failure_analysis_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs with failure analysis requested"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs requiring corrective action"
    - name: "dppm_impact_rma_count"
      expr: SUM(CASE WHEN dppm_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs impacting DPPM quality metrics"
    - name: "closed_rma_count"
      expr: SUM(CASE WHEN closed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of closed RMAs"
    - name: "open_rma_count"
      expr: SUM(CASE WHEN closed_date IS NULL THEN 1 ELSE 0 END)
      comment: "Number of open RMAs"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`order_wafer_start_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer fabrication start authorization metrics tracking fab capacity utilization, cycle time performance, and yield targets"
  source: "`semiconductors_ecm`.`order`.`wafer_start_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the wafer start authorization"
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for the authorization"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority class of the wafer start"
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer size in millimeters"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for the wafer start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the wafer start is planned"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the wafer start is planned"
    - name: "is_mpw"
      expr: is_mpw
      comment: "Indicates whether this is a multi-project wafer start"
    - name: "is_nre"
      expr: is_nre
      comment: "Indicates whether this is a non-recurring engineering wafer start"
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Indicates whether the wafer start is CHIPS Act eligible"
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system code for the authorization"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for cancellation if applicable"
  measures:
    - name: "total_wsa_count"
      expr: COUNT(1)
      comment: "Total number of wafer start authorizations"
    - name: "total_nre_charge_usd"
      expr: SUM(CAST(nre_charge_usd AS DOUBLE))
      comment: "Total NRE charges in USD for wafer starts"
    - name: "total_wafer_unit_cost_usd"
      expr: SUM(CAST(wafer_unit_cost_usd AS DOUBLE))
      comment: "Total wafer unit cost in USD"
    - name: "avg_nre_charge_usd"
      expr: AVG(CAST(nre_charge_usd AS DOUBLE))
      comment: "Average NRE charge per wafer start in USD"
    - name: "avg_wafer_unit_cost_usd"
      expr: AVG(CAST(wafer_unit_cost_usd AS DOUBLE))
      comment: "Average wafer unit cost in USD"
    - name: "avg_yield_target_pct"
      expr: AVG(CAST(yield_target_pct AS DOUBLE))
      comment: "Average yield target percentage"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with wafer start authorizations"
    - name: "distinct_fab_tool_count"
      expr: COUNT(DISTINCT primary_fab_tool_id)
      comment: "Number of unique fab tools authorized for wafer starts"
    - name: "mpw_wsa_count"
      expr: SUM(CASE WHEN is_mpw = TRUE THEN 1 ELSE 0 END)
      comment: "Number of multi-project wafer start authorizations"
    - name: "nre_wsa_count"
      expr: SUM(CASE WHEN is_nre = TRUE THEN 1 ELSE 0 END)
      comment: "Number of NRE wafer start authorizations"
    - name: "chips_act_wsa_count"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Number of CHIPS Act eligible wafer start authorizations"
    - name: "cancelled_wsa_count"
      expr: SUM(CASE WHEN cancellation_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cancelled wafer start authorizations"
    - name: "started_wsa_count"
      expr: SUM(CASE WHEN actual_start_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of wafer starts that have actually begun"
$$;