-- Metric views for domain: order | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic order pipeline metrics covering order value, backlog, NRE revenue, and compliance posture across the semiconductor order book."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. Open, Confirmed, Shipped, Cancelled) for pipeline segmentation."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, MPW, NRE, Blanket Release) to distinguish revenue streams."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel (Direct, Distributor, eCommerce) for channel mix analysis."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end market (Automotive, Industrial, Consumer, Data Center) for demand segmentation."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for geographic revenue and export compliance analysis."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Order entry month for trend and seasonality analysis."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Flag indicating ITAR-controlled orders requiring export license oversight."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Flag for orders eligible under CHIPS Act incentive programs."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether the order is currently in backlog, enabling backlog vs. shipped split."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH regulatory compliance status for environmental reporting."
    - name: "priority"
      expr: priority
      comment: "Order priority level for fulfillment sequencing and escalation tracking."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders placed; baseline volume KPI for order intake tracking."
    - name: "total_gross_order_value"
      expr: SUM(CAST(gross_order_value AS DOUBLE))
      comment: "Sum of gross order value in transaction currency; primary revenue pipeline indicator."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order value after discounts; reflects true recognized revenue potential."
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total NRE (Non-Recurring Engineering) charges on orders; tracks engineering services revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across orders; required for financial reporting and tax provisioning."
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net order value per order; tracks deal size trends and customer spend patterns."
    - name: "backlog_order_count"
      expr: COUNT(CASE WHEN backlog_flag = TRUE THEN 1 END)
      comment: "Count of orders currently in backlog; measures unfulfilled demand and supply pressure."
    - name: "itar_controlled_order_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled orders; critical for export compliance risk management."
    - name: "chips_act_eligible_order_count"
      expr: COUNT(CASE WHEN chips_act_eligible = TRUE THEN 1 END)
      comment: "Count of CHIPS Act eligible orders; tracks government incentive program exposure."
    - name: "export_license_required_count"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN 1 END)
      comment: "Count of orders requiring export licenses; drives compliance workload planning."
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with active orders; measures customer breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level metrics for revenue, fulfillment performance, and product mix analysis across semiconductor SKUs."
  source: "`vibe_semiconductors_v1`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (Open, Confirmed, Shipped, Cancelled) for fulfillment tracking."
    - name: "item_category"
      expr: item_category
      comment: "Product category classification (Wafer, Die, Package, NRE) for revenue mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency line-level revenue analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms (EXW, DDP, FOB) affecting revenue recognition timing."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Manufacturing origin country for trade compliance and tariff analysis."
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for geographic demand analysis."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "ECCN or export control classification for compliance segmentation."
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Device temperature grade (Commercial, Industrial, Automotive) for product mix analysis."
    - name: "speed_grade"
      expr: speed_grade
      comment: "Device speed grade for product performance tier analysis."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Requested delivery month for demand timing and capacity planning."
    - name: "die_bank_order"
      expr: die_bank_order
      comment: "Flag indicating die bank fulfillment orders vs. standard wafer starts."
    - name: "mpw_order"
      expr: mpw_order
      comment: "Flag indicating Multi-Project Wafer orders for R&D revenue tracking."
    - name: "wafer_start_authorization"
      expr: wafer_start_authorization
      comment: "Flag indicating whether wafer start has been authorized for this line."
  measures:
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total order line count; baseline volume metric for order complexity and workload."
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Sum of net line value; primary revenue measure at the order line level."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered; key demand volume metric for supply planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped; measures actual fulfillment output against demand."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed quantity; indicates committed supply against customer demand."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit across order lines; tracks ASP trends and pricing health."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been shipped; core on-time fulfillment KPI."
    - name: "confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity confirmed by supply; measures supply commitment reliability."
    - name: "mpw_line_count"
      expr: COUNT(CASE WHEN mpw_order = TRUE THEN 1 END)
      comment: "Count of MPW order lines; tracks R&D and prototype revenue contribution."
    - name: "die_bank_line_count"
      expr: COUNT(CASE WHEN die_bank_order = TRUE THEN 1 END)
      comment: "Count of die bank fulfillment lines; measures inventory-backed order activity."
    - name: "distinct_skus_ordered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs ordered; measures product breadth and portfolio demand spread."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_backlog_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backlog health and aging metrics for semiconductor order management, enabling supply-demand gap analysis and revenue at risk assessment."
  source: "`vibe_semiconductors_v1`.`order`.`backlog_position`"
  dimensions:
    - name: "backlog_status"
      expr: backlog_status
      comment: "Current backlog status (Active, On Hold, Cancelled) for pipeline health segmentation."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Supply allocation status against backlog positions; identifies unallocated demand."
    - name: "order_type"
      expr: order_type
      comment: "Order type classification for backlog composition analysis."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End market for backlog demand segmentation by vertical."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for geographic backlog distribution analysis."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for export compliance and regional backlog analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency backlog valuation."
    - name: "snapshot_date"
      expr: DATE_TRUNC('week', snapshot_date)
      comment: "Backlog snapshot week for trend analysis over time."
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority ranking of backlog positions for fulfillment sequencing."
    - name: "revenue_recognition_flag"
      expr: revenue_recognition_flag
      comment: "Flag indicating backlog eligible for revenue recognition upon shipment."
    - name: "design_win_flag"
      expr: design_win_flag
      comment: "Flag indicating backlog tied to a design win; tracks strategic customer commitments."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Flag for export-controlled backlog requiring license management."
  measures:
    - name: "total_backlog_positions"
      expr: COUNT(1)
      comment: "Total number of open backlog positions; baseline demand volume metric."
    - name: "total_backlog_value"
      expr: SUM(CAST(backlog_value AS DOUBLE))
      comment: "Total value of open backlog; primary revenue pipeline and demand signal KPI."
    - name: "total_backlog_quantity"
      expr: SUM(CAST(backlog_quantity AS DOUBLE))
      comment: "Total units in backlog; measures unfulfilled demand volume for supply planning."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity with confirmed supply allocation; measures supply coverage of demand."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity with firm delivery commitments; tracks supply reliability."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from backlog positions; measures fulfillment execution."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total cancelled quantity; tracks demand erosion and cancellation risk."
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price across backlog positions; monitors ASP trends in pipeline."
    - name: "allocation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(allocated_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backlog_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backlog quantity with supply allocation; critical supply-demand gap KPI."
    - name: "design_win_backlog_value"
      expr: SUM(CASE WHEN design_win_flag = TRUE THEN backlog_value ELSE 0 END)
      comment: "Backlog value tied to design wins; measures strategic revenue pipeline quality."
    - name: "export_controlled_backlog_count"
      expr: COUNT(CASE WHEN export_control_flag = TRUE THEN 1 END)
      comment: "Count of export-controlled backlog positions; drives compliance resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment execution and logistics performance metrics for semiconductor order fulfillment, covering delivery accuracy, freight cost, and compliance."
  source: "`vibe_semiconductors_v1`.`order`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current shipment status (In Transit, Delivered, Returned) for logistics tracking."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic shipment distribution and trade compliance analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms affecting revenue recognition and risk transfer point."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Carrier used for shipment; enables carrier performance benchmarking."
    - name: "service_level"
      expr: service_level
      comment: "Shipping service level (Express, Standard, Economy) for cost vs. speed analysis."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for compliance segmentation of shipments."
    - name: "ship_date"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Shipment month for trend analysis of shipping volume and revenue recognition."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status for environmental regulatory reporting."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for hazardous substance regulatory reporting."
    - name: "is_multi_leg"
      expr: is_multi_leg
      comment: "Flag for multi-leg shipments requiring additional logistics coordination."
    - name: "damaged_goods_flag"
      expr: damaged_goods_flag
      comment: "Flag for shipments with reported damage; drives quality and carrier claims analysis."
    - name: "quantity_shortage_flag"
      expr: quantity_shortage_flag
      comment: "Flag for shipments with quantity shortages; measures fulfillment accuracy."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total shipment count; baseline logistics volume KPI."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped; primary fulfillment output metric."
    - name: "total_freight_cost_usd"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost in USD; key logistics cost management KPI."
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared shipment value; used for customs, insurance, and revenue tracking."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kg; logistics capacity and freight cost driver."
    - name: "total_pod_confirmed_quantity"
      expr: SUM(CAST(pod_confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed via proof of delivery; measures delivery completion accuracy."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment; benchmarks logistics efficiency across carriers and lanes."
    - name: "damaged_shipment_count"
      expr: COUNT(CASE WHEN damaged_goods_flag = TRUE THEN 1 END)
      comment: "Count of shipments with damaged goods; tracks logistics quality and carrier performance."
    - name: "shortage_shipment_count"
      expr: COUNT(CASE WHEN quantity_shortage_flag = TRUE THEN 1 END)
      comment: "Count of shipments with quantity shortages; measures pick-and-pack accuracy."
    - name: "pod_confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(pod_confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped quantity confirmed via POD; measures last-mile delivery reliability."
    - name: "distinct_destination_countries"
      expr: COUNT(DISTINCT destination_country_code)
      comment: "Number of unique destination countries; measures geographic reach and export complexity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_allocation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply allocation efficiency metrics for semiconductor inventory management, tracking allocation accuracy, constrained supply, and fulfillment execution."
  source: "`vibe_semiconductors_v1`.`order`.`allocation_record`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current allocation status (Allocated, Confirmed, Shipped, Cancelled) for supply pipeline tracking."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (Standard, Priority, CHIPS Act, MPW) for supply strategy analysis."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of allocation (Fab, Die Bank, Inventory) for supply chain traceability."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End market segment for allocation distribution analysis by vertical."
    - name: "process_node"
      expr: process_node
      comment: "Semiconductor process node for technology-level supply allocation analysis."
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site code for supply source geographic analysis."
    - name: "allocation_date"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Allocation month for trend analysis of supply commitment patterns."
    - name: "constrained_supply_flag"
      expr: constrained_supply_flag
      comment: "Flag indicating constrained supply conditions; critical for capacity and demand management."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Flag for CHIPS Act eligible allocations for government program tracking."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Flag indicating allocation is against a backlog position."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance segmentation of allocations."
    - name: "lot_type"
      expr: lot_type
      comment: "Lot type (Production, Engineering, Qualification) for supply quality segmentation."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total allocation records; baseline supply commitment volume metric."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated to customer orders; primary supply commitment KPI."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity with confirmed delivery commitment; measures supply reliability."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped against allocations; measures fulfillment execution rate."
    - name: "allocation_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated quantity that has been shipped; core allocation execution KPI."
    - name: "confirmation_to_allocation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated quantity confirmed; measures supply commitment reliability."
    - name: "constrained_supply_allocation_count"
      expr: COUNT(CASE WHEN constrained_supply_flag = TRUE THEN 1 END)
      comment: "Count of allocations under constrained supply; tracks capacity pressure and risk exposure."
    - name: "chips_act_allocated_quantity"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN allocated_quantity ELSE 0 END)
      comment: "Total quantity allocated under CHIPS Act eligible orders; tracks government program fulfillment."
    - name: "distinct_customers_allocated"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with active allocations; measures allocation breadth and concentration."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule adherence and on-time performance metrics for semiconductor order fulfillment planning."
  source: "`vibe_semiconductors_v1`.`order`.`delivery_schedule`"
  dimensions:
    - name: "schedule_line_status"
      expr: schedule_line_status
      comment: "Current status of the delivery schedule line for fulfillment tracking."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Overall schedule status for delivery commitment monitoring."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms for revenue recognition and risk transfer analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Manufacturing origin for trade compliance and tariff analysis."
    - name: "eccn_code"
      expr: eccn_code
      comment: "Export control classification number for compliance segmentation."
    - name: "export_control_status"
      expr: export_control_status
      comment: "Export control clearance status for shipment release tracking."
    - name: "mpw_order_flag"
      expr: mpw_order_flag
      comment: "Flag for MPW delivery schedules for R&D fulfillment tracking."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Flag indicating schedule line is in backlog status."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Scheduled delivery month for capacity and logistics planning."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Hazardous materials flag for special handling and compliance tracking."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance status for environmental regulatory reporting."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging type for logistics and handling cost analysis."
  measures:
    - name: "total_schedule_lines"
      expr: COUNT(1)
      comment: "Total delivery schedule lines; baseline fulfillment planning volume metric."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity on delivery schedules; measures committed demand volume."
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery; measures supply plan coverage."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity with confirmed delivery dates; measures supply commitment reliability."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity actually delivered; measures fulfillment execution against schedule."
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value of scheduled deliveries; revenue pipeline from confirmed schedules."
    - name: "schedule_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scheduled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity with a scheduled delivery date; measures supply plan completeness."
    - name: "delivery_execution_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(delivered_quantity AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled quantity actually delivered; core on-time delivery performance KPI."
    - name: "avg_net_value_per_line"
      expr: AVG(CAST(net_value AS DOUBLE))
      comment: "Average net value per schedule line; tracks deal size and revenue density of scheduled deliveries."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization metrics for quality, warranty, and customer satisfaction management in semiconductor order operations."
  source: "`vibe_semiconductors_v1`.`order`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current RMA lifecycle status (Open, In Review, Closed, Rejected) for case management."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized return reason code for defect categorization and root cause analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (Design, Process, Handling, Test Escape) for quality improvement targeting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for credit and financial impact analysis."
    - name: "receiving_facility_code"
      expr: receiving_facility_code
      comment: "Facility receiving the return for logistics and quality routing analysis."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Flag for warranty-covered returns; tracks warranty liability exposure."
    - name: "failure_analysis_requested"
      expr: failure_analysis_requested
      comment: "Flag indicating failure analysis was requested; measures quality investigation workload."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating corrective action is required; tracks systemic quality issues."
    - name: "dppm_impact_flag"
      expr: dppm_impact_flag
      comment: "Flag indicating the return impacts DPPM quality metrics; tracks customer quality KPI exposure."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control flag for returns requiring re-export compliance review."
    - name: "request_date"
      expr: DATE_TRUNC('month', request_date)
      comment: "RMA request month for trend analysis of return volumes and quality events."
  measures:
    - name: "total_rmas"
      expr: COUNT(1)
      comment: "Total RMA count; baseline quality and customer satisfaction metric."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total units returned; measures product quality failure volume."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit issued for returns; measures financial impact of product quality failures."
    - name: "avg_credit_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA; tracks financial severity of individual quality events."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Count of warranty claims; tracks warranty liability and product reliability performance."
    - name: "failure_analysis_request_count"
      expr: COUNT(CASE WHEN failure_analysis_requested = TRUE THEN 1 END)
      comment: "Count of RMAs requiring failure analysis; measures quality investigation workload and systemic risk."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of RMAs requiring corrective action; tracks systemic quality issues needing process improvement."
    - name: "dppm_impacting_rma_count"
      expr: COUNT(CASE WHEN dppm_impact_flag = TRUE THEN 1 END)
      comment: "Count of RMAs impacting DPPM metrics; critical customer quality scorecard KPI."
    - name: "distinct_customers_with_rma"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with active RMAs; measures customer quality issue breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_nre_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) order financial and milestone metrics for semiconductor design services revenue management."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency NRE revenue analysis."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Flag for CHIPS Act eligible NRE orders for government incentive tracking."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance segmentation of NRE projects."
  measures:
    - name: "total_nre_orders"
      expr: COUNT(1)
      comment: "Total NRE orders; baseline engineering services pipeline volume metric."
    - name: "total_nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total contracted NRE value; primary engineering services revenue pipeline KPI."
    - name: "avg_nre_amount"
      expr: AVG(CAST(nre_amount AS DOUBLE))
      comment: "Average NRE contract value; tracks deal size trends in engineering services."
    - name: "chips_act_nre_value"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN nre_amount ELSE 0 END)
      comment: "Total NRE value under CHIPS Act eligible orders; tracks government incentive program exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_nre_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE milestone execution and billing metrics for semiconductor engineering services project management and revenue recognition."
  source: "`vibe_semiconductors_v1`.`order`.`order_nre_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current milestone status (Planned, In Progress, Completed, Invoiced, Paid) for project tracking."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (Design Review, Tapeout, Qualification, Delivery) for project phase analysis."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the milestone for revenue recognition and AR management."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency milestone billing analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the milestone for project risk management and escalation."
    - name: "rework_required_flag"
      expr: rework_required_flag
      comment: "Flag indicating rework is required; tracks quality issues and schedule impact."
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Flag for milestones with contract modifications; tracks scope change frequency."
    - name: "planned_date"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned milestone month for project timeline and revenue recognition forecasting."
    - name: "revenue_recognition_date"
      expr: DATE_TRUNC('month', revenue_recognition_date)
      comment: "Revenue recognition month for financial reporting and period close management."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total NRE milestones; baseline project execution volume metric."
    - name: "total_milestone_amount"
      expr: SUM(CAST(milestone_amount AS DOUBLE))
      comment: "Total contracted milestone value; primary NRE revenue recognition pipeline KPI."
    - name: "total_revenue_recognition_amount"
      expr: SUM(CAST(revenue_recognition_amount AS DOUBLE))
      comment: "Total revenue recognized from milestones; measures actual revenue recognition execution."
    - name: "total_effort_hours_planned"
      expr: SUM(CAST(effort_hours_planned AS DOUBLE))
      comment: "Total planned engineering effort hours; measures resource commitment across NRE projects."
    - name: "total_effort_hours_actual"
      expr: SUM(CAST(effort_hours_actual AS DOUBLE))
      comment: "Total actual engineering effort hours; measures resource consumption and project efficiency."
    - name: "avg_milestone_amount"
      expr: AVG(CAST(milestone_amount AS DOUBLE))
      comment: "Average milestone value; tracks NRE billing granularity and deal structure."
    - name: "effort_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(effort_hours_planned AS DOUBLE)) / NULLIF(SUM(CAST(effort_hours_actual AS DOUBLE)), 0), 2)
      comment: "Ratio of planned to actual effort hours; measures NRE project estimation accuracy and efficiency."
    - name: "revenue_recognition_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(revenue_recognition_amount AS DOUBLE)) / NULLIF(SUM(CAST(milestone_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of milestone value recognized as revenue; tracks revenue recognition completeness."
    - name: "rework_milestone_count"
      expr: COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END)
      comment: "Count of milestones requiring rework; measures NRE quality and schedule risk."
    - name: "completed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Count of completed milestones; measures NRE project delivery execution rate."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_mpw_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-Project Wafer order metrics for semiconductor R&D and prototype revenue tracking, covering yield, reticle utilization, and delivery performance."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency MPW revenue analysis."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for environmental regulatory reporting."
    - name: "order_date"
      expr: DATE_TRUNC('quarter', order_date)
      comment: "Order quarter for MPW booking trend and revenue forecasting."
  measures:
    - name: "total_mpw_orders"
      expr: COUNT(1)
      comment: "Total MPW orders; baseline R&D and prototype revenue pipeline metric."
    - name: "distinct_customers_mpw"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers placing MPW orders; measures R&D customer base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_wafer_start_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer start authorization metrics for semiconductor fab capacity commitment, yield targeting, and supply chain execution."
  source: "`vibe_semiconductors_v1`.`order`.`wafer_start_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current authorization status (Pending, Approved, Released, Cancelled) for fab capacity planning."
    - name: "process_node"
      expr: process_node
      comment: "Process node for technology-level capacity demand analysis."
    - name: "process_technology_code"
      expr: process_technology_code
      comment: "Process technology code for detailed fab routing and capacity allocation."
    - name: "priority_class"
      expr: priority_class
      comment: "Priority class for wafer start sequencing and capacity allocation."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for authorization; tracks governance and escalation patterns."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Flag for CHIPS Act eligible wafer starts for government program tracking."
    - name: "is_mpw"
      expr: is_mpw
      comment: "Flag for Multi-Project Wafer starts for R&D capacity segmentation."
    - name: "is_nre"
      expr: is_nre
      comment: "Flag for NRE wafer starts for engineering services capacity tracking."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned start month for fab capacity loading and scheduling analysis."
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer diameter (200mm, 300mm) for fab capacity and cost analysis."
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total wafer start authorizations; baseline fab demand commitment metric."
    - name: "total_nre_charge_usd"
      expr: SUM(CAST(nre_charge_usd AS DOUBLE))
      comment: "Total NRE charges on wafer start authorizations; tracks mask and setup cost recovery."
    - name: "total_wafer_unit_cost_usd"
      expr: SUM(CAST(wafer_unit_cost_usd AS DOUBLE))
      comment: "Total wafer unit cost across authorizations; measures fab cost commitment."
    - name: "avg_yield_target_pct"
      expr: AVG(CAST(yield_target_pct AS DOUBLE))
      comment: "Average yield target across wafer start authorizations; benchmarks fab quality expectations."
    - name: "avg_wafer_unit_cost_usd"
      expr: AVG(CAST(wafer_unit_cost_usd AS DOUBLE))
      comment: "Average wafer unit cost; tracks cost trends by process node and fab site."
    - name: "chips_act_wafer_start_count"
      expr: COUNT(CASE WHEN chips_act_eligible = TRUE THEN 1 END)
      comment: "Count of CHIPS Act eligible wafer starts; tracks government incentive program utilization."
    - name: "mpw_wafer_start_count"
      expr: COUNT(CASE WHEN is_mpw = TRUE THEN 1 END)
      comment: "Count of MPW wafer starts; measures R&D fab capacity consumption."
    - name: "nre_wafer_start_count"
      expr: COUNT(CASE WHEN is_nre = TRUE THEN 1 END)
      comment: "Count of NRE wafer starts; tracks engineering services fab capacity demand."
    - name: "distinct_fab_sites"
      expr: COUNT(DISTINCT fab_site_id)
      comment: "Number of distinct fab sites with active wafer start authorizations; measures supply source diversification."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blanket order commitment and release metrics for semiconductor long-term supply agreement management and revenue predictability."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency blanket order valuation."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel for blanket order mix analysis."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End market for blanket order demand segmentation."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for geographic blanket order distribution."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Flag for CHIPS Act eligible blanket orders for government program tracking."
    - name: "export_license_required"
      expr: export_license_required
      comment: "Export license requirement flag for compliance planning."
  measures:
    - name: "total_blanket_orders"
      expr: COUNT(1)
      comment: "Total blanket orders; baseline long-term supply commitment volume metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order hold management metrics for semiconductor operations, tracking hold frequency, financial exposure, and resolution performance."
  source: "`vibe_semiconductors_v1`.`order`.`order_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current hold status (Active, Released, Escalated) for hold pipeline management."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (Credit, Export Control, Quality, Compliance) for root cause analysis."
    - name: "hold_code"
      expr: hold_code
      comment: "Standardized hold code for operational categorization and reporting."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for compliance hold segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance hold tracking."
    - name: "chips_act_review_required"
      expr: chips_act_review_required
      comment: "Flag for holds requiring CHIPS Act compliance review."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag for escalated holds requiring management intervention."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag for holds that have breached SLA targets; measures operational responsiveness."
    - name: "die_bank_impacted"
      expr: die_bank_impacted
      comment: "Flag indicating die bank inventory is impacted by the hold."
    - name: "wafer_start_impacted"
      expr: wafer_start_impacted
      comment: "Flag indicating wafer starts are impacted by the hold; tracks fab capacity risk."
    - name: "hold_date"
      expr: DATE_TRUNC('month', hold_date)
      comment: "Hold creation month for trend analysis of hold frequency and type."
  measures:
    - name: "total_order_holds"
      expr: COUNT(1)
      comment: "Total order holds; baseline operational disruption volume metric."
    - name: "total_order_value_at_risk"
      expr: SUM(CAST(order_value_at_risk AS DOUBLE))
      comment: "Total order value at risk from active holds; primary financial exposure KPI for hold management."
    - name: "total_credit_exposure_amount"
      expr: SUM(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Total credit exposure from holds; measures financial risk from credit-related order blocks."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit across held orders; provides context for credit utilization analysis."
    - name: "avg_order_value_at_risk"
      expr: AVG(CAST(order_value_at_risk AS DOUBLE))
      comment: "Average order value at risk per hold; tracks severity of individual hold events."
    - name: "escalated_hold_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated holds; measures operational severity and management intervention frequency."
    - name: "sla_breached_hold_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of holds that breached SLA targets; measures operational responsiveness and process compliance."
    - name: "wafer_start_impacted_hold_count"
      expr: COUNT(CASE WHEN wafer_start_impacted = TRUE THEN 1 END)
      comment: "Count of holds impacting wafer starts; tracks fab capacity disruption from order management issues."
    - name: "credit_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_exposure_amount AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "Credit exposure as percentage of credit limit; measures customer credit risk concentration."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_lot_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot assignment quality and fulfillment metrics for semiconductor order traceability, yield performance, and compliance management."
  source: "`vibe_semiconductors_v1`.`order`.`lot_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current lot assignment status for fulfillment pipeline tracking."
    - name: "lot_assignment_status"
      expr: lot_assignment_status
      comment: "Detailed lot assignment lifecycle status for traceability."
    - name: "lot_type"
      expr: lot_type
      comment: "Lot type (Production, Engineering, Qualification) for supply quality segmentation."
    - name: "process_node"
      expr: process_node
      comment: "Process node for technology-level lot assignment analysis."
    - name: "quality_disposition"
      expr: quality_disposition
      comment: "Quality disposition (Accept, Reject, Conditional) for lot quality management."
    - name: "kgd_grade"
      expr: kgd_grade
      comment: "Known Good Die grade for die bank quality segmentation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Manufacturing origin for trade compliance and tariff analysis."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for compliance segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance tracking."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "Flag for CHIPS Act eligible lot assignments."
    - name: "assignment_date"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Assignment month for lot fulfillment trend analysis."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Flag indicating lot assignment is against a backlog position."
  measures:
    - name: "total_lot_assignments"
      expr: COUNT(1)
      comment: "Total lot assignments; baseline supply traceability volume metric."
    - name: "total_assigned_quantity"
      expr: SUM(CAST(assigned_quantity AS DOUBLE))
      comment: "Total quantity assigned from lots to orders; measures supply commitment execution."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average lot yield percentage across assignments; tracks supply quality and die output efficiency."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average DPPM (Defective Parts Per Million) across assigned lots; critical customer quality KPI."
    - name: "chips_act_assigned_quantity"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN assigned_quantity ELSE 0 END)
      comment: "Total quantity assigned under CHIPS Act eligible orders; tracks government program fulfillment."
    - name: "itar_controlled_assignment_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled lot assignments; measures export compliance workload."
    - name: "distinct_customers_assigned"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with active lot assignments; measures fulfillment breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order amendment metrics for semiconductor contract change management, tracking amendment frequency, financial impact, and revenue revision patterns."
  source: "`vibe_semiconductors_v1`.`order`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current amendment status (Pending, Approved, Rejected, Applied) for change management tracking."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (Quantity, Price, Date, Cancellation) for change pattern analysis."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for the amendment; tracks governance and escalation patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency amendment impact analysis."
    - name: "customer_requested_flag"
      expr: customer_requested_flag
      comment: "Flag for customer-initiated amendments vs. internal changes; tracks demand volatility."
    - name: "chips_act_order_flag"
      expr: chips_act_order_flag
      comment: "Flag for amendments on CHIPS Act orders for government program change tracking."
    - name: "export_control_review_required"
      expr: export_control_review_required
      comment: "Flag for amendments requiring export control review; tracks compliance workload."
    - name: "wafer_start_impact_flag"
      expr: wafer_start_impact_flag
      comment: "Flag for amendments impacting wafer starts; tracks fab capacity disruption from order changes."
    - name: "allocation_impact_flag"
      expr: allocation_impact_flag
      comment: "Flag for amendments impacting supply allocations; tracks supply chain disruption."
    - name: "amendment_date"
      expr: DATE_TRUNC('month', amendment_date)
      comment: "Amendment month for change frequency trend analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total order amendments; baseline contract change volume metric."
    - name: "total_revenue_impact_amount"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from amendments; measures financial effect of order changes on recognized revenue."
    - name: "total_quantity_original"
      expr: SUM(CAST(quantity_original AS DOUBLE))
      comment: "Total original quantity before amendments; baseline for measuring demand change magnitude."
    - name: "total_quantity_revised"
      expr: SUM(CAST(quantity_revised AS DOUBLE))
      comment: "Total revised quantity after amendments; measures net demand change from order modifications."
    - name: "total_original_value"
      expr: SUM(CAST(original_value AS DOUBLE))
      comment: "Total original order value before amendments; baseline for revenue change analysis."
    - name: "total_revised_value"
      expr: SUM(CAST(revised_value AS DOUBLE))
      comment: "Total revised order value after amendments; measures net revenue impact of contract changes."
    - name: "avg_revenue_impact_per_amendment"
      expr: AVG(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Average revenue impact per amendment; tracks financial severity of individual order changes."
    - name: "customer_requested_amendment_count"
      expr: COUNT(CASE WHEN customer_requested_flag = TRUE THEN 1 END)
      comment: "Count of customer-initiated amendments; measures demand volatility and customer change behavior."
    - name: "wafer_start_impacting_amendment_count"
      expr: COUNT(CASE WHEN wafer_start_impact_flag = TRUE THEN 1 END)
      comment: "Count of amendments impacting wafer starts; tracks fab capacity disruption from demand changes."
    - name: "export_control_review_amendment_count"
      expr: COUNT(CASE WHEN export_control_review_required = TRUE THEN 1 END)
      comment: "Count of amendments requiring export control review; measures compliance workload from order changes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_delivery_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery confirmation and customer acceptance metrics for semiconductor order fulfillment quality, revenue recognition, and logistics performance."
  source: "`vibe_semiconductors_v1`.`order`.`delivery_confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Current confirmation status for delivery acceptance tracking."
    - name: "delivery_confirmation_status"
      expr: delivery_confirmation_status
      comment: "Detailed delivery confirmation lifecycle status for revenue recognition gating."
    - name: "customer_acceptance_status"
      expr: customer_acceptance_status
      comment: "Customer acceptance status (Accepted, Rejected, Pending) for revenue recognition and dispute management."
    - name: "delivery_performance_code"
      expr: delivery_performance_code
      comment: "Delivery performance classification (On Time, Late, Early) for logistics KPI analysis."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of delivery discrepancy (Quantity, Part Number, Damage) for quality root cause analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Delivery terms for revenue recognition timing analysis."
    - name: "receiving_country_code"
      expr: receiving_country_code
      comment: "Receiving country for geographic delivery performance analysis."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Flag for deliveries with discrepancies; measures fulfillment accuracy."
    - name: "invoice_release_flag"
      expr: invoice_release_flag
      comment: "Flag indicating invoice has been released upon delivery confirmation; tracks billing cycle."
    - name: "revenue_recognition_flag"
      expr: revenue_recognition_flag
      comment: "Flag indicating delivery triggers revenue recognition; critical for financial close."
    - name: "export_control_verified_flag"
      expr: export_control_verified_flag
      comment: "Flag for export control verification completion; tracks compliance at delivery."
    - name: "confirmed_receipt_date"
      expr: DATE_TRUNC('month', confirmed_receipt_date)
      comment: "Confirmed receipt month for delivery performance trend analysis."
  measures:
    - name: "total_delivery_confirmations"
      expr: COUNT(1)
      comment: "Total delivery confirmations; baseline fulfillment completion volume metric."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity delivered and confirmed; measures actual fulfillment output."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by customer; measures customer acceptance of deliveries."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped per confirmation records; baseline for delivery accuracy analysis."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between shipped and confirmed; measures delivery accuracy and discrepancy magnitude."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries with discrepancies; measures fulfillment accuracy and logistics quality."
    - name: "invoice_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN invoice_release_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of confirmed deliveries with invoice released; measures billing cycle efficiency."
    - name: "revenue_recognition_eligible_count"
      expr: COUNT(CASE WHEN revenue_recognition_flag = TRUE THEN 1 END)
      comment: "Count of delivery confirmations triggering revenue recognition; tracks revenue recognition events."
    - name: "customer_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(delivered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of delivered quantity accepted by customer; measures delivery quality and customer satisfaction."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order status transition metrics for semiconductor order lifecycle management, SLA compliance, and operational efficiency analysis."
  source: "`vibe_semiconductors_v1`.`order`.`status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "New status after transition; enables funnel and pipeline stage analysis."
    - name: "prior_status"
      expr: prior_status
      comment: "Prior status before transition; enables transition pattern and bottleneck analysis."
    - name: "transition_type"
      expr: transition_type
      comment: "Type of status transition (Automatic, Manual, System) for process automation analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for status change; enables root cause analysis of order delays and holds."
    - name: "cancellation_type"
      expr: cancellation_type
      comment: "Cancellation type for cancelled order analysis and demand erosion tracking."
    - name: "escalation_priority"
      expr: escalation_priority
      comment: "Escalation priority level for operational triage and resource allocation."
    - name: "process_node"
      expr: process_node
      comment: "Process node for technology-level order flow analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag for escalated status transitions requiring management attention."
    - name: "sla_breached_flag"
      expr: sla_breached_flag
      comment: "Flag for transitions that breached SLA targets; measures operational responsiveness."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Flag for export-controlled order transitions requiring compliance review."
    - name: "is_current_status"
      expr: is_current_status
      comment: "Flag indicating this is the current active status; enables point-in-time pipeline analysis."
    - name: "transition_timestamp"
      expr: DATE_TRUNC('month', transition_timestamp)
      comment: "Transition month for order flow velocity and throughput trend analysis."
  measures:
    - name: "total_status_transitions"
      expr: COUNT(1)
      comment: "Total status transitions; baseline order lifecycle activity volume metric."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity across status history records; measures order volume flowing through lifecycle stages."
    - name: "avg_duration_in_prior_status_hours"
      expr: AVG(CAST(duration_in_prior_status_hours AS DOUBLE))
      comment: "Average time spent in prior status; identifies bottlenecks and delays in order processing."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across transitions; benchmarks expected processing time by status."
    - name: "sla_breached_transition_count"
      expr: COUNT(CASE WHEN sla_breached_flag = TRUE THEN 1 END)
      comment: "Count of status transitions that breached SLA; measures operational compliance and process efficiency."
    - name: "escalated_transition_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of escalated transitions; measures management intervention frequency in order processing."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breached_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of status transitions breaching SLA; core operational performance KPI for order management."
    - name: "die_bank_order_transition_count"
      expr: COUNT(CASE WHEN die_bank_order_flag = TRUE THEN 1 END)
      comment: "Count of die bank order status transitions; tracks inventory-backed order flow activity."
    - name: "mpw_order_transition_count"
      expr: COUNT(CASE WHEN mpw_flag = TRUE THEN 1 END)
      comment: "Count of MPW order status transitions; tracks R&D order processing activity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_die_bank_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Die bank order metrics for semiconductor inventory-backed fulfillment, tracking die availability, order value, and delivery performance."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency die bank order valuation."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for environmental regulatory reporting."
    - name: "export_license_required"
      expr: export_license_required
      comment: "Export license requirement flag for compliance planning."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Flag indicating die bank order is in backlog status."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Requested delivery month for die bank demand timing analysis."
  measures:
    - name: "total_die_bank_orders"
      expr: COUNT(1)
      comment: "Total die bank orders; baseline inventory-backed fulfillment volume metric."
    - name: "export_license_required_count"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN 1 END)
      comment: "Count of die bank orders requiring export licenses; drives compliance workload planning."
    - name: "backlog_die_bank_order_count"
      expr: COUNT(CASE WHEN backlog_flag = TRUE THEN 1 END)
      comment: "Count of die bank orders in backlog; measures unfulfilled die inventory demand."
    - name: "distinct_customers_die_bank"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with die bank orders; measures die bank customer base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_shipment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment line-level metrics for semiconductor order fulfillment accuracy, compliance, and revenue tracking at the line item level."
  source: "`vibe_semiconductors_v1`.`order`.`shipment_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current shipment line status for fulfillment tracking."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Manufacturing origin for trade compliance and tariff analysis."
    - name: "eccn_code"
      expr: eccn_code
      comment: "Export control classification number for compliance segmentation."
    - name: "package_type"
      expr: package_type
      comment: "Package type for logistics and handling analysis."
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Device temperature grade for product mix analysis."
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "Moisture sensitivity level for handling and storage compliance."
    - name: "yield_grade"
      expr: yield_grade
      comment: "Yield grade for quality segmentation of shipped product."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance tracking."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance status for environmental regulatory reporting."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for environmental regulatory reporting."
    - name: "partial_shipment_flag"
      expr: partial_shipment_flag
      comment: "Flag for partial shipments; measures fulfillment completeness."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Flag for backordered shipment lines; tracks unfulfilled demand at line level."
    - name: "actual_ship_date"
      expr: DATE_TRUNC('month', actual_ship_date)
      comment: "Actual ship month for revenue recognition and fulfillment trend analysis."
  measures:
    - name: "total_shipment_lines"
      expr: COUNT(1)
      comment: "Total shipment lines; baseline fulfillment line volume metric."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped at line level; primary fulfillment output metric."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total ordered quantity at line level; baseline for fulfillment rate calculation."
    - name: "total_line_net_value"
      expr: SUM(CAST(line_net_value AS DOUBLE))
      comment: "Total net value of shipped lines; primary revenue metric at shipment line level."
    - name: "avg_unit_selling_price"
      expr: AVG(CAST(unit_selling_price AS DOUBLE))
      comment: "Average unit selling price across shipment lines; tracks ASP trends at transaction level."
    - name: "line_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity shipped at line level; measures fulfillment completeness."
    - name: "partial_shipment_line_count"
      expr: COUNT(CASE WHEN partial_shipment_flag = TRUE THEN 1 END)
      comment: "Count of partial shipment lines; measures fulfillment fragmentation and customer experience impact."
    - name: "backorder_line_count"
      expr: COUNT(CASE WHEN backorder_flag = TRUE THEN 1 END)
      comment: "Count of backordered shipment lines; measures unfulfilled demand at line level."
    - name: "itar_controlled_line_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled shipment lines; measures export compliance workload at line level."
$$;