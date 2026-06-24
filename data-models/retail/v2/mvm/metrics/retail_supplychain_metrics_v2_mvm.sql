-- Metric views for domain: supplychain | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order performance, vendor compliance, and procurement spend. Enables procurement teams and executives to monitor order fulfilment accuracy, spend commitments, and supplier on-time delivery."
  source: "`vibe_retail_v1`.`supplychain`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Confirmed, Closed, Cancelled) — primary filter for active vs. historical analysis."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Drop-Ship) — used to segment procurement strategy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — identifies orders pending approval vs. approved, supporting governance and compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated — required for multi-currency spend analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms governing delivery responsibility — used to segment freight cost and risk exposure."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms agreed with the vendor — used for cash flow and working capital analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of purchase order creation — primary time dimension for trend and seasonality analysis."
    - name: "expected_delivery_date_month"
      expr: DATE_TRUNC('MONTH', expected_delivery_date)
      comment: "Month of expected delivery — used to project inbound inventory receipts and cash commitments."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates whether the PO is fulfilled via cross-dock (bypass DC storage) — used to analyse cross-dock adoption and cost impact."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Indicates whether the PO is a drop-ship order (vendor ships direct to store/customer) — used to segment fulfilment model analysis."
    - name: "purchasing_org_code"
      expr: purchasing_org_code
      comment: "Purchasing organisation responsible for the order — enables spend analysis by buying team or business unit."
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Purchasing group within the organisation — supports granular procurement accountability reporting."
  measures:
    - name: "total_purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement activity tracking."
    - name: "total_committed_spend"
      expr: SUM(CAST(total_order_amount AS DOUBLE))
      comment: "Total committed procurement spend across all purchase orders — primary financial KPI for budget vs. actuals and open-to-buy management."
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after discounts — represents actual cash outflow obligation to vendors."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total vendor discount captured across purchase orders — measures negotiated savings and vendor deal effectiveness."
    - name: "total_ordered_units"
      expr: SUM(CAST(total_ordered_units AS DOUBLE))
      comment: "Total units ordered across all POs — volume metric for inventory planning and vendor capacity alignment."
    - name: "total_received_units"
      expr: SUM(CAST(total_received_units AS DOUBLE))
      comment: "Total units actually received against purchase orders — used to compute receipt fulfilment and identify shortfalls."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average PO fill rate percentage — measures vendor ability to fulfil ordered quantities; a key supplier performance KPI."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to purchase orders — used to monitor currency exposure and hedging effectiveness."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across POs — informs vendor MOQ compliance and order consolidation opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level purchase order KPIs covering SKU-level procurement cost, receipt accuracy, and vendor compliance. Enables category managers and supply planners to evaluate item-level ordering performance."
  source: "`vibe_retail_v1`.`supplychain`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (e.g. Open, Received, Cancelled) — primary filter for active vs. closed line analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the PO line — required for multi-currency cost analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the ordered item is manufactured — used for sourcing diversification and tariff risk analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms for the PO line — governs delivery risk and cost allocation between buyer and vendor."
    - name: "destination_type"
      expr: destination_type
      comment: "Destination type for the PO line (e.g. DC, Store, Drop-Ship) — used to segment supply chain flow analysis."
    - name: "moq_compliant"
      expr: moq_compliant
      comment: "Indicates whether the ordered quantity meets the vendor minimum order quantity — used to track MOQ compliance rate."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery — used to align procurement receipts with merchandising and promotional calendars."
    - name: "actual_delivery_date_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery — used to measure on-time delivery performance against requested dates."
  measures:
    - name: "total_po_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines — baseline volume metric for procurement line activity."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (unit cost × ordered quantity) across all PO lines — primary cost of goods metric for procurement spend analysis."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net cost after allowances across PO lines — represents actual landed cost commitment to vendors."
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total vendor allowances captured at line level — measures trade deal and promotional funding captured from suppliers."
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total units ordered at line level — volume metric for SKU-level demand fulfilment planning."
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total units received at line level — used to compute receipt accuracy and identify vendor shortfalls."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total units shipped by vendor at line level — used to identify in-transit inventory and shipment gaps."
    - name: "total_confirmed_qty"
      expr: SUM(CAST(confirmed_qty AS DOUBLE))
      comment: "Total vendor-confirmed order quantity — measures vendor commitment vs. original order, highlighting potential shortfalls early."
    - name: "total_otb_consumed"
      expr: SUM(CAST(otb_consumed AS DOUBLE))
      comment: "Total open-to-buy budget consumed by PO lines — critical financial control metric for merchandise planning and budget adherence."
    - name: "avg_retail_price"
      expr: AVG(CAST(retail_price AS DOUBLE))
      comment: "Average retail price of ordered items — used to compute initial markup and margin at the order level."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment performance KPIs covering on-time arrival, freight cost, receiving accuracy, and temperature compliance. Enables DC operations and logistics teams to monitor vendor and carrier delivery performance."
  source: "`vibe_retail_v1`.`supplychain`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g. In Transit, Received, Pending) — primary filter for active shipment monitoring."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of inbound shipment (e.g. Full Truckload, LTL, Parcel) — used to segment freight cost and lead time analysis."
    - name: "carrier_scac_code"
      expr: carrier_scac_code
      comment: "Standard Carrier Alpha Code identifying the carrier — used for carrier performance benchmarking."
    - name: "on_time_arrival_flag"
      expr: on_time_arrival_flag
      comment: "Indicates whether the shipment arrived on or before the expected arrival date — primary on-time delivery dimension."
    - name: "cross_dock_flag"
      expr: cross_dock_flag
      comment: "Indicates whether the shipment was processed as a cross-dock (no DC storage) — used to track cross-dock utilisation."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the shipment required temperature-controlled transport — used to segment cold chain compliance analysis."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the shipment maintained required temperature throughout transit — key cold chain quality KPI dimension."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the shipment contained hazardous materials — used for regulatory compliance and safety reporting."
    - name: "expected_arrival_date_month"
      expr: DATE_TRUNC('MONTH', expected_arrival_date)
      comment: "Month of expected arrival — used for inbound volume forecasting and DC labour planning."
    - name: "actual_arrival_date_month"
      expr: DATE_TRUNC('MONTH', actual_arrival_date)
      comment: "Month of actual arrival — used for trend analysis of inbound receipt volumes."
    - name: "line_status"
      expr: line_status
      comment: "Line-level status of the inbound shipment record — used to filter active vs. completed shipment lines."
  measures:
    - name: "total_inbound_shipment_count"
      expr: COUNT(1)
      comment: "Total number of inbound shipments — baseline volume metric for DC inbound activity and labour planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total inbound freight cost — primary logistics cost KPI for carrier spend management and cost-per-unit analysis."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total units shipped by vendors — used to measure inbound volume and compare against received quantities."
    - name: "total_received_qty"
      expr: SUM(CAST(received_qty AS DOUBLE))
      comment: "Total units received at the DC — used to compute receipt accuracy and identify vendor shortfalls."
    - name: "total_actual_weight_kg"
      expr: SUM(CAST(actual_weight_kg AS DOUBLE))
      comment: "Total actual weight of inbound shipments in kilograms — used for freight cost normalisation and carrier billing validation."
    - name: "total_expected_cube_m3"
      expr: SUM(CAST(expected_cube_m3 AS DOUBLE))
      comment: "Total expected cubic volume of inbound shipments — used for DC dock and storage capacity planning."
    - name: "on_time_arrival_shipment_count"
      expr: SUM(CASE WHEN on_time_arrival_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of shipments that arrived on time — numerator for on-time arrival rate; key carrier and vendor performance KPI."
    - name: "temperature_compliant_shipment_count"
      expr: SUM(CASE WHEN temperature_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature-controlled shipments that maintained compliance — numerator for cold chain compliance rate; critical for perishable and pharma categories."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per inbound shipment — used to benchmark carrier efficiency and identify cost outliers."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_receiving_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DC receiving quality and throughput KPIs covering discrepancy rates, damage, temperature compliance, and unload efficiency. Enables DC managers to monitor inbound quality and identify systemic receiving issues."
  source: "`vibe_retail_v1`.`supplychain`.`receiving_event`"
  dimensions:
    - name: "receiving_status"
      expr: receiving_status
      comment: "Status of the receiving event (e.g. Complete, Pending, In Progress) — primary filter for active vs. completed receiving activity."
    - name: "receiving_type"
      expr: receiving_type
      comment: "Type of receiving process (e.g. Standard, Cross-Dock, Returns) — used to segment receiving throughput by process type."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates whether damage was recorded during receiving — primary dimension for inbound quality analysis."
    - name: "shortage_flag"
      expr: shortage_flag
      comment: "Indicates whether a shortage was identified during receiving — used to track vendor fulfilment accuracy."
    - name: "overage_flag"
      expr: overage_flag
      comment: "Indicates whether an overage was identified during receiving — used to track vendor shipment accuracy and manage excess inventory."
    - name: "temperature_compliant_flag"
      expr: temperature_compliant_flag
      comment: "Indicates whether the received shipment was temperature compliant — key cold chain quality dimension."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the receiving event involved hazardous materials — used for safety and regulatory compliance reporting."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates whether a quality inspection was required for this receipt — used to track inspection workload and compliance."
    - name: "discrepancy_reason_code"
      expr: discrepancy_reason_code
      comment: "Reason code for any receiving discrepancy — used to identify root causes of vendor or carrier failures."
    - name: "created_timestamp_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month of receiving event creation — primary time dimension for receiving volume trend analysis."
  measures:
    - name: "total_receiving_event_count"
      expr: COUNT(1)
      comment: "Total number of receiving events — baseline volume metric for DC inbound throughput and labour planning."
    - name: "damaged_receiving_event_count"
      expr: SUM(CASE WHEN damage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receiving events with recorded damage — numerator for damage rate KPI; drives vendor claims and quality improvement actions."
    - name: "shortage_receiving_event_count"
      expr: SUM(CASE WHEN shortage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receiving events with shortages — numerator for shortage rate KPI; measures vendor fulfilment accuracy."
    - name: "overage_receiving_event_count"
      expr: SUM(CASE WHEN overage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receiving events with overages — used to identify vendor over-shipment patterns and manage excess inventory risk."
    - name: "temperature_non_compliant_count"
      expr: SUM(CASE WHEN temperature_compliant_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of receiving events where temperature compliance failed — critical cold chain quality KPI driving vendor corrective actions."
    - name: "total_temperature_reading_sum"
      expr: SUM(CAST(temperature_reading AS DOUBLE))
      comment: "Sum of temperature readings at receiving — used with count to compute average temperature for cold chain audit reporting."
    - name: "avg_temperature_reading"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature recorded at receiving — used to monitor cold chain integrity and identify systemic temperature excursions."
    - name: "putaway_task_generated_count"
      expr: SUM(CASE WHEN putaway_task_generated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receiving events that generated putaway tasks — measures DC workflow throughput and WMS task generation efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound order fulfilment KPIs covering fill rate, on-time shipment, order volume, and freight metrics. Enables DC operations and supply chain leadership to monitor store replenishment and outbound service levels."
  source: "`vibe_retail_v1`.`supplychain`.`outbound_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the outbound order (e.g. Open, Shipped, Delivered, Cancelled) — primary filter for active order monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of outbound order (e.g. Replenishment, Transfer, Emergency) — used to segment fulfilment performance by order category."
    - name: "replenishment_type"
      expr: replenishment_type
      comment: "Replenishment method driving the outbound order (e.g. Min/Max, Forecast-Driven, Promotional) — used to evaluate replenishment strategy effectiveness."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination for the outbound order (e.g. Store, DC, Customer) — used to segment outbound volume by supply chain node."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level selected for the outbound order (e.g. Standard, Express, Overnight) — used to analyse service level mix and cost."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the outbound order — used to monitor high-priority order fulfilment rates and escalation patterns."
    - name: "is_cross_dock"
      expr: is_cross_dock
      comment: "Indicates whether the outbound order was fulfilled via cross-dock — used to track cross-dock adoption and efficiency."
    - name: "is_drop_ship"
      expr: is_drop_ship
      comment: "Indicates whether the outbound order is a drop-ship — used to segment fulfilment model performance."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of outbound order creation — primary time dimension for outbound volume trend analysis."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month of actual shipment — used to measure outbound throughput and compare against requested ship dates."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country of the outbound order destination — used for cross-border fulfilment analysis and regulatory reporting."
  measures:
    - name: "total_outbound_order_count"
      expr: COUNT(1)
      comment: "Total number of outbound orders — baseline volume metric for DC outbound throughput and capacity planning."
    - name: "total_outbound_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of outbound orders in kilograms — used for freight cost normalisation and carrier capacity planning."
    - name: "total_outbound_cube_m3"
      expr: SUM(CAST(total_cube_m3 AS DOUBLE))
      comment: "Total cubic volume of outbound orders — used for trailer utilisation and DC dock capacity planning."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average outbound order fill rate percentage — primary service level KPI measuring DC ability to fulfil store replenishment orders completely."
    - name: "on_time_ship_order_count"
      expr: SUM(CASE WHEN actual_ship_date <= requested_ship_date THEN 1 ELSE 0 END)
      comment: "Count of outbound orders shipped on or before the requested ship date — numerator for on-time shipment rate; key DC service level KPI."
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled outbound orders — measures order cancellation rate; high cancellation rates signal supply or planning failures."
    - name: "hazmat_order_count"
      expr: SUM(CASE WHEN is_hazmat = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outbound orders containing hazardous materials — used for regulatory compliance monitoring and safety reporting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_outbound_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level outbound fulfilment KPIs covering pick accuracy, short-ship rates, and line-level cost. Enables DC operations and category managers to identify fulfilment gaps at the item level."
  source: "`vibe_retail_v1`.`supplychain`.`outbound_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the outbound order line (e.g. Picked, Packed, Shipped, Short) — primary filter for active vs. completed line analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the outbound order line — required for multi-currency cost analysis."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether a SKU substitution was applied to fulfil the line — used to track substitution rates and assortment gap analysis."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates whether the line item is a hazardous material — used for compliance and safety reporting."
    - name: "is_temperature_controlled"
      expr: is_temperature_controlled
      comment: "Indicates whether the line item requires temperature-controlled handling — used for cold chain compliance analysis."
    - name: "short_ship_reason_code"
      expr: short_ship_reason_code
      comment: "Reason code for short-shipped lines — used to identify root causes of fulfilment failures (e.g. out-of-stock, pick error)."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of product expiry for the outbound line — used to monitor near-expiry inventory being shipped and reduce waste."
    - name: "created_timestamp_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the outbound order line was created — primary time dimension for line-level fulfilment trend analysis."
  measures:
    - name: "total_outbound_line_count"
      expr: COUNT(1)
      comment: "Total number of outbound order lines — baseline volume metric for DC pick and pack workload planning."
    - name: "total_ordered_qty"
      expr: SUM(CAST(ordered_qty AS DOUBLE))
      comment: "Total units ordered across outbound lines — used as denominator for fill rate and short-ship rate calculations."
    - name: "total_shipped_qty"
      expr: SUM(CAST(shipped_qty AS DOUBLE))
      comment: "Total units actually shipped — used to compute line-level fill rate and identify fulfilment gaps."
    - name: "total_picked_qty"
      expr: SUM(CAST(picked_qty AS DOUBLE))
      comment: "Total units picked in the warehouse — used to measure pick accuracy and compare against shipped quantities."
    - name: "total_packed_qty"
      expr: SUM(CAST(packed_qty AS DOUBLE))
      comment: "Total units packed — used to identify pack-to-ship discrepancies and packing station throughput."
    - name: "total_short_ship_qty"
      expr: SUM(CAST(short_ship_qty AS DOUBLE))
      comment: "Total units short-shipped — primary metric for fulfilment failure analysis; directly impacts store in-stock rates and sales."
    - name: "total_allocated_qty"
      expr: SUM(CAST(allocated_qty AS DOUBLE))
      comment: "Total units allocated to outbound orders — used to measure inventory commitment and available-to-promise accuracy."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of outbound order lines — measures cost of goods shipped; used for DC cost accounting and margin analysis."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total cubic volume of outbound lines — used for trailer utilisation optimisation and freight cost allocation."
    - name: "substitution_line_count"
      expr: SUM(CASE WHEN substitution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outbound lines fulfilled with a SKU substitution — measures assortment gap frequency and substitution programme effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_replenishment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment planning KPIs covering order quantities, safety stock adequacy, service level targets, and MOQ compliance. Enables supply planners and inventory managers to evaluate replenishment strategy effectiveness and identify planning gaps."
  source: "`vibe_retail_v1`.`supplychain`.`replenishment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the replenishment plan (e.g. Draft, Approved, Released, Cancelled) — primary filter for active vs. historical plan analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of replenishment plan (e.g. Regular, Promotional, Emergency) — used to segment planning activity by replenishment driver."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method applied (e.g. Min/Max, Reorder Point, Forecast-Driven) — used to evaluate method effectiveness by SKU/location."
    - name: "node_type"
      expr: node_type
      comment: "Type of inventory node in the replenishment network (e.g. DC, Store, Hub) — used to segment planning by supply chain tier."
    - name: "moq_compliance_flag"
      expr: moq_compliance_flag
      comment: "Indicates whether the planned order quantity meets the vendor minimum order quantity — used to track MOQ compliance rate."
    - name: "buyer_override_flag"
      expr: buyer_override_flag
      comment: "Indicates whether a buyer manually overrode the system-generated replenishment recommendation — used to measure planner intervention rate."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Indicates whether the replenishment plan is driven by a promotional event — used to segment promotional vs. baseline replenishment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the replenishment plan — required for multi-currency order value analysis."
    - name: "order_release_date_month"
      expr: DATE_TRUNC('MONTH', order_release_date)
      comment: "Month of planned order release — primary time dimension for replenishment volume and spend forecasting."
    - name: "plan_horizon_start_date_month"
      expr: DATE_TRUNC('MONTH', plan_horizon_start_date)
      comment: "Month of planning horizon start — used to align replenishment plans with merchandising and promotional calendars."
    - name: "safety_stock_method"
      expr: safety_stock_method
      comment: "Method used to calculate safety stock (e.g. Fixed, Statistical, Service-Level-Driven) — used to evaluate safety stock methodology effectiveness."
  measures:
    - name: "total_replenishment_plan_count"
      expr: COUNT(1)
      comment: "Total number of replenishment plans — baseline volume metric for planning activity and system utilisation."
    - name: "total_planned_order_qty"
      expr: SUM(CAST(planned_order_qty AS DOUBLE))
      comment: "Total planned order quantity across all replenishment plans — primary volume metric for inbound inventory pipeline planning."
    - name: "total_approved_order_qty"
      expr: SUM(CAST(approved_order_qty AS DOUBLE))
      comment: "Total approved order quantity — measures the volume of replenishment orders approved for release; used to track plan execution rate."
    - name: "total_planned_order_value"
      expr: SUM(CAST(planned_order_value AS DOUBLE))
      comment: "Total planned order value — primary financial KPI for replenishment spend forecasting and open-to-buy management."
    - name: "total_forecasted_demand_qty"
      expr: SUM(CAST(forecasted_demand_qty AS DOUBLE))
      comment: "Total forecasted demand quantity driving replenishment plans — used to validate demand signal quality and planning accuracy."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity held across replenishment plans — measures inventory buffer investment and risk coverage."
    - name: "total_on_order_qty"
      expr: SUM(CAST(on_order_qty AS DOUBLE))
      comment: "Total quantity currently on order — used to compute inventory pipeline coverage and avoid over-ordering."
    - name: "total_current_on_hand_qty"
      expr: SUM(CAST(current_on_hand_qty AS DOUBLE))
      comment: "Total current on-hand inventory quantity at planning time — used to assess stock coverage and reorder urgency."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage across replenishment plans — measures the ambition of the replenishment strategy and its alignment with business service commitments."
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average fill rate target percentage — used to benchmark planned service levels against actual fill rate performance."
    - name: "avg_weeks_of_supply_target"
      expr: AVG(CAST(weeks_of_supply_target AS DOUBLE))
      comment: "Average weeks of supply target across plans — measures inventory coverage ambition; high values indicate over-stocking risk, low values indicate stockout risk."
    - name: "buyer_override_plan_count"
      expr: SUM(CASE WHEN buyer_override_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of replenishment plans with buyer overrides — measures planner intervention rate; high override rates signal forecast or system trust issues."
    - name: "moq_non_compliant_plan_count"
      expr: SUM(CASE WHEN moq_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of replenishment plans that do not meet vendor MOQ — identifies plans at risk of vendor rejection or surcharges."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_demand_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting accuracy and volume KPIs covering forecast bias, MAPE, WMAPE, promotional lift, and revenue projections. Enables demand planning teams and supply chain leadership to evaluate forecast quality and its impact on inventory and revenue."
  source: "`vibe_retail_v1`.`supplychain`.`demand_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the demand forecast record (e.g. Active, Superseded, Archived) — primary filter for current vs. historical forecast analysis."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of demand forecast (e.g. Statistical, Consensus, Promotional) — used to compare forecast method performance."
    - name: "statistical_model_code"
      expr: statistical_model_code
      comment: "Statistical model used to generate the forecast — used to benchmark model accuracy and guide model selection decisions."
    - name: "demand_category"
      expr: demand_category
      comment: "Category of demand being forecast (e.g. Baseline, Promotional, Seasonal) — used to segment forecast accuracy by demand type."
    - name: "is_latest_version"
      expr: is_latest_version
      comment: "Indicates whether this is the most recent forecast version — used to filter analysis to current forecasts only."
    - name: "is_promotional_period"
      expr: is_promotional_period
      comment: "Indicates whether the forecast covers a promotional period — used to evaluate promotional forecast accuracy separately from baseline."
    - name: "is_new_item"
      expr: is_new_item
      comment: "Indicates whether the forecast is for a new item (no sales history) — used to track new item forecast accuracy and cold-start performance."
    - name: "is_override_applied"
      expr: is_override_applied
      comment: "Indicates whether a manual override was applied to the statistical forecast — used to measure planner intervention rate and override impact."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the forecasted revenue — required for multi-currency revenue forecast analysis."
    - name: "time_bucket_granularity"
      expr: time_bucket_granularity
      comment: "Granularity of the forecast time bucket (e.g. Weekly, Daily) — used to segment accuracy metrics by planning horizon granularity."
    - name: "forecast_period_start_date_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Month of forecast period start — primary time dimension for demand trend and seasonality analysis."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system that generated the forecast — used to compare forecast quality across planning systems."
  measures:
    - name: "total_forecast_record_count"
      expr: COUNT(1)
      comment: "Total number of demand forecast records — baseline volume metric for forecast coverage and planning system activity."
    - name: "total_forecasted_units"
      expr: SUM(CAST(forecasted_units AS DOUBLE))
      comment: "Total forecasted demand units — primary volume KPI for inventory planning, procurement, and capacity decisions."
    - name: "total_baseline_forecast_units"
      expr: SUM(CAST(baseline_forecast_units AS DOUBLE))
      comment: "Total baseline (pre-promotional) forecasted units — used to isolate underlying demand trends from promotional distortion."
    - name: "total_promotional_lift_units"
      expr: SUM(CAST(promotional_lift_units AS DOUBLE))
      comment: "Total promotional lift units forecasted — measures the incremental demand attributed to promotions; used to evaluate promotional ROI."
    - name: "total_forecasted_revenue"
      expr: SUM(CAST(forecasted_revenue AS DOUBLE))
      comment: "Total forecasted revenue — primary financial planning KPI linking demand forecasts to revenue projections for executive reporting."
    - name: "total_replenishment_recommendation_units"
      expr: SUM(CAST(replenishment_recommendation_units AS DOUBLE))
      comment: "Total replenishment units recommended by the forecast — measures the inventory pipeline implied by current demand forecasts."
    - name: "avg_mape"
      expr: AVG(CAST(mape AS DOUBLE))
      comment: "Average Mean Absolute Percentage Error across forecasts — primary forecast accuracy KPI; lower values indicate better forecast quality and reduced inventory waste."
    - name: "avg_wmape"
      expr: AVG(CAST(wmape AS DOUBLE))
      comment: "Average Weighted Mean Absolute Percentage Error — volume-weighted forecast accuracy KPI; preferred over MAPE for high-volume SKU performance evaluation."
    - name: "avg_forecast_bias"
      expr: AVG(CAST(forecast_bias AS DOUBLE))
      comment: "Average forecast bias — measures systematic over- or under-forecasting; persistent bias drives excess inventory or stockouts and is a key planning health indicator."
    - name: "avg_confidence_level_pct"
      expr: AVG(CAST(confidence_level_pct AS DOUBLE))
      comment: "Average forecast confidence level percentage — measures statistical certainty of forecasts; low confidence signals high demand variability requiring safety stock review."
    - name: "avg_seasonality_index"
      expr: AVG(CAST(seasonality_index AS DOUBLE))
      comment: "Average seasonality index across forecasts — measures the strength of seasonal demand patterns; used to validate seasonal planning assumptions."
    - name: "override_applied_count"
      expr: SUM(CASE WHEN is_override_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Count of forecasts with manual overrides applied — measures planner intervention frequency; high override rates may indicate model distrust or data quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_dc_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution centre facility capacity and operational profile KPIs. Enables supply chain network planners and real estate teams to evaluate DC footprint, capacity utilisation, and operational capabilities."
  source: "`vibe_retail_v1`.`supplychain`.`dc_facility`"
  dimensions:
    - name: "facility_status"
      expr: facility_status
      comment: "Operational status of the DC facility (e.g. Active, Closed, Under Construction) — primary filter for active network analysis."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of distribution centre (e.g. Regional DC, Cross-Dock, Fulfilment Centre) — used to segment network capacity by facility type."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the facility (e.g. Owned, Leased, 3PL) — used for real estate strategy and cost structure analysis."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of warehouse automation (e.g. Manual, Semi-Automated, Fully Automated) — used to assess automation investment and productivity benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country where the DC facility is located — used for geographic network analysis and regulatory compliance."
    - name: "bonded_warehouse_flag"
      expr: bonded_warehouse_flag
      comment: "Indicates whether the facility is a bonded warehouse — used for customs and import/export compliance reporting."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates whether the facility is certified to handle hazardous materials — used for network capability and compliance analysis."
    - name: "temperature_zone_frozen_flag"
      expr: temperature_zone_frozen_flag
      comment: "Indicates whether the facility has frozen storage capability — used to assess cold chain network coverage."
    - name: "temperature_zone_chilled_flag"
      expr: temperature_zone_chilled_flag
      comment: "Indicates whether the facility has chilled storage capability — used to assess fresh and chilled product network coverage."
    - name: "twenty_four_seven_operation_flag"
      expr: twenty_four_seven_operation_flag
      comment: "Indicates whether the facility operates 24/7 — used to assess network throughput capacity and operational flexibility."
    - name: "opened_date_year"
      expr: DATE_TRUNC('YEAR', opened_date)
      comment: "Year the facility opened — used for network age analysis and capital reinvestment planning."
  measures:
    - name: "total_facility_count"
      expr: COUNT(1)
      comment: "Total number of DC facilities in the network — baseline metric for supply chain network footprint analysis."
    - name: "total_storage_capacity_cubic_feet"
      expr: SUM(CAST(storage_capacity_cubic_feet AS DOUBLE))
      comment: "Total storage capacity in cubic feet across all DC facilities — primary capacity metric for network-level inventory storage planning."
    - name: "total_warehouse_square_footage"
      expr: SUM(CAST(warehouse_square_footage AS DOUBLE))
      comment: "Total warehouse square footage across the DC network — used for real estate portfolio management and capacity expansion planning."
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total facility square footage (including non-warehouse areas) — used for total real estate footprint and cost-per-square-foot analysis."
    - name: "avg_storage_capacity_cubic_feet"
      expr: AVG(CAST(storage_capacity_cubic_feet AS DOUBLE))
      comment: "Average storage capacity per DC facility — used to benchmark facility size and identify under-utilised or over-capacity nodes."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplychain_warehouse_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse zone capacity, occupancy, and operational configuration KPIs. Enables DC managers and slotting teams to monitor zone utilisation, cycle count compliance, and storage efficiency."
  source: "`vibe_retail_v1`.`supplychain`.`warehouse_zone`"
  dimensions:
    - name: "zone_status"
      expr: zone_status
      comment: "Operational status of the warehouse zone (e.g. Active, Inactive, Under Maintenance) — primary filter for active zone analysis."
    - name: "zone_type"
      expr: zone_type
      comment: "Type of warehouse zone (e.g. Bulk, Pick, Reserve, Staging) — used to segment capacity and utilisation by zone function."
    - name: "temperature_classification"
      expr: temperature_classification
      comment: "Temperature classification of the zone (e.g. Ambient, Chilled, Frozen) — used to assess cold chain storage capacity distribution."
    - name: "automation_type"
      expr: automation_type
      comment: "Type of automation in the zone (e.g. Manual, Conveyor, AS/RS) — used to benchmark automation investment and throughput efficiency."
    - name: "pick_method"
      expr: pick_method
      comment: "Picking method used in the zone (e.g. Batch, Wave, Zone, Discrete) — used to evaluate pick productivity and method effectiveness."
    - name: "slotting_strategy"
      expr: slotting_strategy
      comment: "Slotting strategy applied to the zone (e.g. Velocity-Based, Category-Based) — used to assess slotting effectiveness and travel time reduction."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Indicates whether the zone is certified for hazardous materials storage — used for compliance and safety reporting."
    - name: "rfid_enabled_flag"
      expr: rfid_enabled_flag
      comment: "Indicates whether the zone has RFID tracking enabled — used to assess inventory visibility technology coverage."
    - name: "cycle_count_frequency"
      expr: cycle_count_frequency
      comment: "Frequency of cycle counts in the zone (e.g. Daily, Weekly, Monthly) — used to assess inventory accuracy programme intensity."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the warehouse zone became effective — used for zone lifecycle and network reconfiguration analysis."
  measures:
    - name: "total_warehouse_zone_count"
      expr: COUNT(1)
      comment: "Total number of warehouse zones — baseline metric for DC layout complexity and zone management overhead."
    - name: "total_capacity_cubic_meters"
      expr: SUM(CAST(total_capacity_cubic_meters AS DOUBLE))
      comment: "Total storage capacity in cubic meters across all warehouse zones — primary capacity metric for DC storage planning and utilisation analysis."
    - name: "total_weight_capacity_kg"
      expr: SUM(CAST(weight_capacity_kg AS DOUBLE))
      comment: "Total weight capacity in kilograms across warehouse zones — used to assess structural load limits and heavy goods storage planning."
    - name: "avg_current_occupancy_pct"
      expr: AVG(CAST(current_occupancy_pct AS DOUBLE))
      comment: "Average current occupancy percentage across warehouse zones — primary utilisation KPI; high values indicate capacity risk, low values indicate under-utilisation."
    - name: "high_occupancy_zone_count"
      expr: SUM(CASE WHEN current_occupancy_pct >= 90.0 THEN 1 ELSE 0 END)
      comment: "Count of warehouse zones at or above 90% occupancy — critical operational risk metric; high counts signal imminent capacity constraints requiring immediate action."
    - name: "avg_temperature_max_celsius"
      expr: AVG(CAST(temperature_max_celsius AS DOUBLE))
      comment: "Average maximum temperature threshold across temperature-controlled zones — used to validate cold chain zone configuration and compliance."
$$;