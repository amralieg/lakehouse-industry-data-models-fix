-- Metric views for domain: order | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic order-level KPIs tracking order value, backlog, compliance, and fulfillment performance for executive steering and operational decision-making."
  source: "`vibe_semiconductors_v1`.`order`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., open, confirmed, shipped, cancelled) for pipeline and fulfillment analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, MPW, NRE) for segmentation and revenue mix analysis."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "Target end-market segment (e.g., automotive, industrial, consumer) for strategic market analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel (e.g., direct, distributor, OEM) for channel performance and margin analysis."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country code for geographic revenue and compliance reporting."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Indicates whether order is in backlog for capacity planning and fulfillment prioritization."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility flag for regulatory reporting and incentive tracking."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance and risk management."
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year of order placement for trend analysis and year-over-year comparisons."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for monthly revenue tracking and seasonality analysis."
    - name: "requested_delivery_year"
      expr: YEAR(requested_delivery_date)
      comment: "Year of requested delivery for demand forecasting and capacity planning."
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of orders for volume tracking and conversion analysis."
    - name: "unique_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts placing orders for customer base growth and concentration analysis."
    - name: "gross_order_value"
      expr: SUM(CAST(gross_order_value AS DOUBLE))
      comment: "Total gross order value (before discounts and adjustments) for top-line revenue tracking and bookings analysis."
    - name: "net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net order value (after discounts) for realized revenue and margin analysis."
    - name: "nre_amount"
      expr: SUM(CAST(nre_amount AS DOUBLE))
      comment: "Total non-recurring engineering charges for design win monetization and engineering services revenue."
    - name: "tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected for financial reconciliation and compliance reporting."
    - name: "avg_gross_order_value"
      expr: AVG(CAST(gross_order_value AS DOUBLE))
      comment: "Average gross order value per order for deal size analysis and pricing strategy."
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net order value per order for realized deal size and customer value segmentation."
    - name: "discount_rate"
      expr: ROUND(100.0 * (SUM(CAST(gross_order_value AS DOUBLE)) - SUM(CAST(net_order_value AS DOUBLE))) / NULLIF(SUM(CAST(gross_order_value AS DOUBLE)), 0), 2)
      comment: "Average discount rate as percentage of gross value for pricing discipline and margin protection analysis."
    - name: "backlog_order_count"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders in backlog for capacity constraint visibility and fulfillment risk management."
    - name: "backlog_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders in backlog for supply chain health and customer satisfaction risk assessment."
    - name: "chips_act_eligible_order_value"
      expr: SUM(CASE WHEN chips_act_eligible = TRUE THEN CAST(net_order_value AS DOUBLE) ELSE 0 END)
      comment: "Net order value eligible for CHIPS Act incentives for regulatory reporting and subsidy optimization."
    - name: "itar_controlled_order_value"
      expr: SUM(CASE WHEN itar_controlled = TRUE THEN CAST(net_order_value AS DOUBLE) ELSE 0 END)
      comment: "Net order value subject to ITAR controls for export compliance risk and licensing workload forecasting."
    - name: "cancelled_order_count"
      expr: SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Number of cancelled orders for customer satisfaction and demand volatility analysis."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders cancelled for order quality and customer commitment assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item KPIs for revenue realization, product mix, fulfillment efficiency, and compliance tracking at the SKU level."
  source: "`vibe_semiconductors_v1`.`order`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line for fulfillment tracking and exception management."
    - name: "item_category"
      expr: item_category
      comment: "Category of line item (e.g., standard product, custom, sample) for product mix and margin analysis."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of inventory allocation (e.g., ATP, CTP, backorder) for supply chain efficiency analysis."
    - name: "ship_to_country"
      expr: ship_to_country
      comment: "Destination country for geographic revenue and export compliance analysis."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "ECCN or export control classification for compliance risk segmentation."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for regulatory adherence and market access tracking."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for EU market access and chemical regulation adherence."
    - name: "mpw_order"
      expr: mpw_order
      comment: "Multi-project wafer order flag for foundry service revenue and capacity utilization analysis."
    - name: "temperature_grade"
      expr: temperature_grade
      comment: "Temperature grade specification (e.g., commercial, industrial, automotive) for product mix and margin analysis."
    - name: "speed_grade"
      expr: speed_grade
      comment: "Speed grade specification for product performance mix and pricing tier analysis."
    - name: "line_entry_year"
      expr: YEAR(date_entered)
      comment: "Year line was entered for trend analysis and booking velocity tracking."
    - name: "line_entry_month"
      expr: DATE_TRUNC('MONTH', date_entered)
      comment: "Month line was entered for monthly booking and pipeline analysis."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery for demand forecasting and capacity planning."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of order lines for order complexity and SKU diversity analysis."
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs ordered for product portfolio breadth and demand concentration analysis."
    - name: "unique_orders"
      expr: COUNT(DISTINCT order_id)
      comment: "Number of unique orders containing lines for order-to-line ratio and order complexity analysis."
    - name: "net_line_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net line value for revenue realization and product mix contribution analysis."
    - name: "ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered for demand volume and capacity planning."
    - name: "confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for supply commitment and allocation effectiveness analysis."
    - name: "shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped for fulfillment performance and revenue recognition tracking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across lines for pricing trend and product mix analysis."
    - name: "avg_line_value"
      expr: AVG(CAST(net_value AS DOUBLE))
      comment: "Average net value per line for deal size and SKU-level revenue contribution analysis."
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity shipped for fulfillment effectiveness and customer satisfaction assessment."
    - name: "confirmation_rate"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity confirmed for supply availability and allocation efficiency analysis."
    - name: "lines_with_partial_shipment"
      expr: SUM(CASE WHEN partial_shipment_allowed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lines allowing partial shipment for fulfillment flexibility and customer preference analysis."
    - name: "mpw_line_count"
      expr: SUM(CASE WHEN mpw_order = TRUE THEN 1 ELSE 0 END)
      comment: "Number of multi-project wafer lines for foundry service volume and capacity utilization tracking."
    - name: "mpw_revenue"
      expr: SUM(CASE WHEN mpw_order = TRUE THEN CAST(net_value AS DOUBLE) ELSE 0 END)
      comment: "Revenue from multi-project wafer orders for foundry service business contribution analysis."
    - name: "non_compliant_line_count"
      expr: SUM(CASE WHEN rohs_compliant = FALSE OR reach_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Number of lines with compliance issues for regulatory risk and market access constraint analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level KPIs for logistics performance, on-time delivery, quality incidents, and freight cost management."
  source: "`vibe_semiconductors_v1`.`order`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of shipment (e.g., in-transit, delivered, delayed) for logistics tracking and exception management."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Shipping carrier for carrier performance analysis and cost optimization."
    - name: "service_level"
      expr: service_level
      comment: "Service level (e.g., express, standard, economy) for cost-service tradeoff analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic logistics performance and cost analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code for freight responsibility and cost allocation analysis."
    - name: "export_control_classification"
      expr: export_control_classification
      comment: "Export control classification for compliance risk and licensing workload tracking."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for regulatory adherence tracking in shipments."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for EU shipment compliance tracking."
    - name: "damaged_goods_flag"
      expr: damaged_goods_flag
      comment: "Indicates shipment with damaged goods for quality incident tracking and carrier performance."
    - name: "quantity_shortage_flag"
      expr: quantity_shortage_flag
      comment: "Indicates shipment with quantity shortage for fulfillment accuracy and warehouse performance."
    - name: "wrong_part_flag"
      expr: wrong_part_flag
      comment: "Indicates shipment with wrong parts for picking accuracy and quality control effectiveness."
    - name: "ship_year"
      expr: YEAR(ship_date)
      comment: "Year of shipment for trend analysis and year-over-year logistics performance."
    - name: "ship_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month of shipment for monthly logistics volume and cost tracking."
  measures:
    - name: "total_shipment_count"
      expr: COUNT(1)
      comment: "Total number of shipments for logistics volume and operational workload tracking."
    - name: "unique_accounts_shipped"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts receiving shipments for customer reach and service coverage analysis."
    - name: "shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped for fulfillment volume and revenue recognition tracking."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_usd AS DOUBLE))
      comment: "Total freight cost in USD for logistics cost management and carrier negotiation analysis."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared value of shipments for insurance coverage and risk exposure analysis."
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight in kg for freight planning and carrier capacity utilization."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_usd AS DOUBLE))
      comment: "Average freight cost per shipment for cost benchmarking and carrier performance evaluation."
    - name: "freight_cost_per_unit"
      expr: ROUND(SUM(CAST(freight_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 4)
      comment: "Freight cost per unit shipped for unit economics and pricing strategy analysis."
    - name: "freight_cost_as_pct_of_value"
      expr: ROUND(100.0 * SUM(CAST(freight_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(declared_value_usd AS DOUBLE)), 0), 2)
      comment: "Freight cost as percentage of declared value for logistics efficiency and margin impact analysis."
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN actual_arrival_date <= estimated_arrival_date THEN 1 ELSE 0 END)
      comment: "Number of shipments delivered on or before estimated arrival for on-time delivery performance tracking."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_arrival_date <= estimated_arrival_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered on time for customer satisfaction and carrier performance assessment."
    - name: "damaged_shipment_count"
      expr: SUM(CASE WHEN damaged_goods_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with damaged goods for quality incident tracking and carrier accountability."
    - name: "damage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN damaged_goods_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with damage for logistics quality and carrier selection criteria."
    - name: "shortage_shipment_count"
      expr: SUM(CASE WHEN quantity_shortage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with quantity shortages for fulfillment accuracy and warehouse performance tracking."
    - name: "shortage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quantity_shortage_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with shortages for picking accuracy and inventory control effectiveness."
    - name: "wrong_part_shipment_count"
      expr: SUM(CASE WHEN wrong_part_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of shipments with wrong parts for picking accuracy and quality control effectiveness."
    - name: "wrong_part_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN wrong_part_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments with wrong parts for warehouse quality and training effectiveness assessment."
    - name: "perfect_shipment_count"
      expr: SUM(CASE WHEN damaged_goods_flag = FALSE AND quantity_shortage_flag = FALSE AND wrong_part_flag = FALSE AND actual_arrival_date <= estimated_arrival_date THEN 1 ELSE 0 END)
      comment: "Number of perfect shipments (on-time, no damage, no shortage, correct parts) for end-to-end logistics excellence tracking."
    - name: "perfect_shipment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN damaged_goods_flag = FALSE AND quantity_shortage_flag = FALSE AND wrong_part_flag = FALSE AND actual_arrival_date <= estimated_arrival_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of perfect shipments for comprehensive logistics quality and customer experience assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_backlog_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Backlog KPIs for demand visibility, supply constraint analysis, and revenue pipeline health at the snapshot level."
  source: "`vibe_semiconductors_v1`.`order`.`backlog_position`"
  dimensions:
    - name: "backlog_status"
      expr: backlog_status
      comment: "Status of backlog position (e.g., open, committed, at-risk) for pipeline health and fulfillment risk analysis."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status for supply availability and fulfillment readiness tracking."
    - name: "order_type"
      expr: order_type
      comment: "Type of order in backlog for product mix and priority analysis."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End-market segment for backlog concentration and strategic demand analysis."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for geographic backlog distribution and regional capacity planning."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for geographic demand and export planning."
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority rank for allocation sequencing and customer commitment management."
    - name: "backlog_aging_days"
      expr: backlog_aging_days
      comment: "Aging bucket of backlog position for supply constraint severity and customer satisfaction risk."
    - name: "hold_code"
      expr: hold_code
      comment: "Hold code for backlog constraint root cause and resolution tracking."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control flag for compliance-related backlog and licensing workload."
    - name: "design_win_flag"
      expr: design_win_flag
      comment: "Design win flag for strategic backlog and customer lifetime value analysis."
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of backlog snapshot for trend analysis and year-over-year pipeline comparison."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of backlog snapshot for monthly pipeline tracking and forecasting."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery for demand forecasting and capacity planning."
  measures:
    - name: "total_backlog_positions"
      expr: COUNT(1)
      comment: "Total number of backlog positions for pipeline complexity and fulfillment workload tracking."
    - name: "unique_accounts_in_backlog"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with backlog for customer impact breadth and satisfaction risk."
    - name: "unique_skus_in_backlog"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs in backlog for product constraint analysis and capacity allocation."
    - name: "backlog_quantity"
      expr: SUM(CAST(backlog_quantity AS DOUBLE))
      comment: "Total quantity in backlog for supply gap visibility and capacity planning."
    - name: "backlog_value"
      expr: SUM(CAST(backlog_value AS DOUBLE))
      comment: "Total value of backlog for revenue pipeline and financial forecasting."
    - name: "allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated from backlog for supply commitment and fulfillment readiness."
    - name: "committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed to customers for near-term revenue visibility and delivery planning."
    - name: "cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total quantity cancelled from backlog for demand volatility and customer churn analysis."
    - name: "shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from backlog for backlog burn-down and fulfillment velocity tracking."
    - name: "avg_backlog_value_per_position"
      expr: AVG(CAST(backlog_value AS DOUBLE))
      comment: "Average backlog value per position for deal size and customer value analysis."
    - name: "avg_net_selling_price"
      expr: AVG(CAST(net_selling_price AS DOUBLE))
      comment: "Average net selling price in backlog for pricing trend and margin forecast analysis."
    - name: "allocation_rate"
      expr: ROUND(100.0 * SUM(CAST(allocated_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backlog_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backlog quantity allocated for supply availability and fulfillment readiness assessment."
    - name: "commitment_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backlog_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backlog quantity committed for near-term revenue confidence and customer satisfaction."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CAST(cancelled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backlog_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backlog quantity cancelled for demand stability and customer retention risk."
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(backlog_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of backlog quantity fulfilled for backlog burn-down velocity and supply chain effectiveness."
    - name: "design_win_backlog_value"
      expr: SUM(CASE WHEN design_win_flag = TRUE THEN CAST(backlog_value AS DOUBLE) ELSE 0 END)
      comment: "Backlog value from design wins for strategic pipeline and customer lifetime value tracking."
    - name: "export_controlled_backlog_value"
      expr: SUM(CASE WHEN export_control_flag = TRUE THEN CAST(backlog_value AS DOUBLE) ELSE 0 END)
      comment: "Backlog value subject to export controls for compliance risk and licensing workload forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return Merchandise Authorization KPIs for quality performance, warranty cost, failure analysis, and customer satisfaction impact."
  source: "`vibe_semiconductors_v1`.`order`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of RMA (e.g., open, approved, closed) for return processing efficiency and workload tracking."
    - name: "return_reason"
      expr: return_reason
      comment: "Reason for return for root cause analysis and quality improvement prioritization."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Coded return reason for systematic defect tracking and trend analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (e.g., design, manufacturing, handling) for accountability and corrective action targeting."
    - name: "disposition_instruction"
      expr: disposition_instruction
      comment: "Disposition instruction (e.g., scrap, rework, credit) for cost impact and recovery strategy analysis."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Inspection result for return validity and customer claim verification."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Warranty claim flag for warranty cost tracking and product reliability assessment."
    - name: "failure_analysis_requested"
      expr: failure_analysis_requested
      comment: "Failure analysis request flag for engineering workload and quality investigation prioritization."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Corrective action required flag for quality system effectiveness and continuous improvement tracking."
    - name: "dppm_impact_flag"
      expr: dppm_impact_flag
      comment: "DPPM impact flag for quality metric calculation and customer scorecard reporting."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control flag for compliance risk in return logistics and re-export planning."
    - name: "rma_year"
      expr: YEAR(rma_date)
      comment: "Year of RMA creation for trend analysis and year-over-year quality performance."
    - name: "rma_month"
      expr: DATE_TRUNC('MONTH', rma_date)
      comment: "Month of RMA creation for monthly quality tracking and warranty cost forecasting."
  measures:
    - name: "total_rma_count"
      expr: COUNT(1)
      comment: "Total number of RMAs for return volume and quality performance tracking."
    - name: "unique_accounts_with_rma"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with RMAs for customer satisfaction risk and quality impact breadth."
    - name: "unique_skus_returned"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs returned for product quality concentration and design issue identification."
    - name: "returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total quantity returned for return rate calculation and quality cost impact."
    - name: "credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for warranty cost and margin impact analysis."
    - name: "avg_credit_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA for return cost severity and pricing impact assessment."
    - name: "warranty_claim_count"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of warranty claims for warranty cost tracking and product reliability assessment."
    - name: "warranty_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs that are warranty claims for warranty policy effectiveness and product quality."
    - name: "warranty_credit_amount"
      expr: SUM(CASE WHEN warranty_claim_flag = TRUE THEN CAST(credit_amount AS DOUBLE) ELSE 0 END)
      comment: "Total credit amount for warranty claims for warranty reserve adequacy and product cost of quality."
    - name: "failure_analysis_request_count"
      expr: SUM(CASE WHEN failure_analysis_requested = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs requiring failure analysis for engineering workload and quality investigation capacity planning."
    - name: "failure_analysis_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN failure_analysis_requested = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs requiring failure analysis for quality issue severity and root cause investigation intensity."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs requiring corrective action for quality system effectiveness and continuous improvement workload."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs requiring corrective action for systemic quality issue prevalence and improvement opportunity identification."
    - name: "dppm_impacting_rma_count"
      expr: SUM(CASE WHEN dppm_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RMAs impacting DPPM for customer scorecard quality metric and supplier performance rating."
    - name: "dppm_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dppm_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs impacting DPPM for customer-visible quality performance and business retention risk."
    - name: "avg_rma_cycle_time_days"
      expr: AVG(DATEDIFF(closed_date, request_date))
      comment: "Average days from RMA request to closure for return processing efficiency and customer experience."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`order_allocation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation KPIs for supply-demand matching effectiveness, inventory utilization, and fulfillment prioritization performance."
  source: "`vibe_semiconductors_v1`.`order`.`allocation_record`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of allocation (e.g., active, consumed, expired) for allocation lifecycle and utilization tracking."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., ATP, CTP, reserved) for allocation strategy and policy effectiveness analysis."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of allocated inventory (e.g., die bank, finished goods, WIP) for supply chain stage visibility."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Assignment status for order-to-inventory linkage and fulfillment readiness tracking."
    - name: "backlog_flag"
      expr: backlog_flag
      comment: "Backlog flag for allocation constraint visibility and supply gap analysis."
    - name: "constrained_supply_flag"
      expr: constrained_supply_flag
      comment: "Constrained supply flag for capacity bottleneck identification and allocation prioritization."
    - name: "end_market_segment"
      expr: end_market_segment
      comment: "End-market segment for allocation strategy and customer prioritization analysis."
    - name: "priority_rank"
      expr: priority_rank
      comment: "Priority rank for allocation sequencing and customer commitment management."
    - name: "quality_disposition"
      expr: quality_disposition
      comment: "Quality disposition for allocation quality and yield impact analysis."
    - name: "hold_reason"
      expr: hold_reason
      comment: "Hold reason for allocation constraint root cause and resolution tracking."
    - name: "lot_type"
      expr: lot_type
      comment: "Lot type (e.g., production, engineering, qualification) for inventory mix and allocation policy."
    - name: "fab_site_code"
      expr: fab_site_code
      comment: "Fabrication site code for multi-site allocation and capacity utilization analysis."
    - name: "osat_site_code"
      expr: osat_site_code
      comment: "OSAT site code for assembly allocation and outsourced capacity management."
    - name: "chips_act_eligible"
      expr: chips_act_eligible
      comment: "CHIPS Act eligibility for regulatory reporting and incentive-driven allocation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance and allocation restriction tracking."
    - name: "allocation_year"
      expr: YEAR(allocation_date)
      comment: "Year of allocation for trend analysis and year-over-year allocation performance."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of allocation for monthly allocation velocity and supply chain responsiveness."
  measures:
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of allocation records for allocation activity volume and supply chain complexity."
    - name: "unique_accounts_allocated"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts receiving allocations for customer service breadth and allocation fairness."
    - name: "unique_skus_allocated"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs allocated for product portfolio coverage and allocation diversity."
    - name: "allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity allocated for supply commitment and fulfillment capacity tracking."
    - name: "confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for near-term fulfillment visibility and customer commitment."
    - name: "shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped from allocations for allocation-to-shipment conversion and fulfillment velocity."
    - name: "avg_allocated_quantity"
      expr: AVG(CAST(allocated_quantity AS DOUBLE))
      comment: "Average quantity per allocation for allocation granularity and order size analysis."
    - name: "confirmation_rate"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated quantity confirmed for allocation reliability and supply chain stability."
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(allocated_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated quantity shipped for allocation effectiveness and supply chain execution."
    - name: "backlog_allocation_count"
      expr: SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of allocations in backlog for supply constraint visibility and capacity gap analysis."
    - name: "backlog_allocation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN backlog_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations in backlog for supply chain health and customer satisfaction risk."
    - name: "constrained_allocation_count"
      expr: SUM(CASE WHEN constrained_supply_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of allocations from constrained supply for bottleneck identification and capacity investment prioritization."
    - name: "constrained_allocation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN constrained_supply_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations from constrained supply for supply chain risk and capacity planning."
    - name: "cancelled_allocation_count"
      expr: SUM(CASE WHEN cancellation_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of cancelled allocations for allocation stability and demand volatility analysis."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cancellation_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations cancelled for allocation policy effectiveness and customer commitment stability."
    - name: "avg_allocation_to_ship_days"
      expr: AVG(DATEDIFF(actual_ship_date, allocation_date))
      comment: "Average days from allocation to shipment for allocation velocity and supply chain responsiveness."
$$;