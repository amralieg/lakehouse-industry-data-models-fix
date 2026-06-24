-- Metric views for domain: order | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic order pipeline and revenue metrics derived from order headers. Covers order value, volume, and fulfillment health for executive and sales operations dashboards."
  source: "`vibe_manufacturing_v1`.`order`.`header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g., Open, Confirmed, Delivered, Cancelled). Primary filter for pipeline analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., Standard, Rush, Blanket Release). Used to segment order mix and prioritization."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the order. Enables analysis of high-priority order fulfillment rates."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the order. Supports regional and organizational performance segmentation."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the order was placed (e.g., Direct, Distributor). Enables channel mix analysis."
    - name: "order_currency"
      expr: order_currency
      comment: "Currency in which the order is denominated. Required for multi-currency revenue reporting."
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the order was placed. Enables trend analysis of order intake over time."
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Customer-requested delivery date. Used for on-time delivery performance analysis."
    - name: "division"
      expr: division
      comment: "Business division associated with the order. Supports divisional P&L and performance reporting."
    - name: "sales_document_type"
      expr: sales_document_type
      comment: "SAP-style sales document type (e.g., OR, RE). Enables document-type segmentation of order volume."
  measures:
    - name: "total_order_net_revenue"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net revenue across all orders. Core top-line revenue KPI used in executive dashboards and QBRs."
    - name: "total_order_gross_revenue"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross revenue before tax deductions. Used to assess gross order value and compare against net."
    - name: "total_order_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax collected across orders. Required for tax liability reporting and compliance."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of orders placed. Baseline volume KPI for order intake tracking and capacity planning."
    - name: "avg_order_net_value"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net value per order. Tracks deal size trends and informs pricing and sales strategy."
    - name: "orders_with_billing_block_count"
      expr: COUNT(CASE WHEN billing_block = TRUE THEN 1 END)
      comment: "Number of orders currently blocked for billing. Elevated counts signal credit or compliance issues requiring intervention."
    - name: "orders_with_delivery_block_count"
      expr: COUNT(CASE WHEN delivery_block = TRUE THEN 1 END)
      comment: "Number of orders blocked for delivery. Directly impacts customer service levels and on-time delivery KPIs."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with orders in the period. Measures customer breadth and acquisition effectiveness."
    - name: "total_order_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of all orders in kilograms. Used for logistics capacity planning and freight cost estimation."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of all orders in cubic meters. Supports warehouse and shipping capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order line-level metrics covering revenue, fulfillment, quality, and backorder performance. Enables product-level and SKU-level analysis for sales operations and supply chain teams."
  source: "`vibe_manufacturing_v1`.`order`.`line`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status of the order line (e.g., Not Delivered, Partially Delivered, Fully Delivered). Core dimension for fulfillment analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status of the line item. Used to track quality pass/fail rates by product or plant."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status of the order line. Supports quality management and compliance reporting."
    - name: "plant"
      expr: plant
      comment: "Manufacturing or fulfillment plant assigned to the order line. Enables plant-level performance benchmarking."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the order line. Supports channel-level margin and volume analysis."
    - name: "division"
      expr: division
      comment: "Business division for the order line. Enables divisional revenue and fulfillment reporting."
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Indicates whether the line is on backorder. Key dimension for supply availability and customer satisfaction analysis."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason the order line was rejected. Enables root-cause analysis of order rejections and cancellations."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the scheduled delivery date. Supports monthly delivery performance trending."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the order line quantity. Required for accurate volume aggregation across product types."
  measures:
    - name: "total_line_net_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net revenue across all order lines. Line-level revenue KPI for product and SKU performance analysis."
    - name: "total_line_gross_revenue"
      expr: SUM(CAST(gross_price AS DOUBLE))
      comment: "Total gross revenue across order lines before discounts. Used to measure gross sales value by product."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across order lines. Tracks discount exposure and pricing discipline."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across order lines. Required for tax reporting and compliance."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers. Baseline demand signal for supply planning and capacity management."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery. Measures supply commitment against customer demand."
    - name: "total_sales_quantity"
      expr: SUM(CAST(sales_quantity AS DOUBLE))
      comment: "Total quantity sold across order lines. Core volume KPI for sales performance and inventory depletion tracking."
    - name: "order_line_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity confirmed for delivery. Critical supply chain KPI — low fill rate signals inventory or capacity shortfalls."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across order lines. Tracks product quality trends and supports quality management decisions."
    - name: "backorder_line_count"
      expr: COUNT(CASE WHEN backorder_indicator = TRUE THEN 1 END)
      comment: "Number of order lines currently on backorder. Directly measures supply availability risk and customer service impact."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs ordered. Measures product breadth in the order mix and supports assortment planning."
    - name: "avg_line_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per order line. Tracks average selling price trends and pricing effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance and logistics cost metrics. Tracks on-time delivery, freight costs, backorders, and partial shipments to support supply chain and customer service decisions."
  source: "`vibe_manufacturing_v1`.`order`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g., Open, In Transit, Delivered, Cancelled). Primary dimension for delivery pipeline analysis."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (e.g., Standard, Express, Drop-Ship). Enables analysis of delivery mix and associated cost profiles."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier responsible for the shipment. Enables carrier performance benchmarking on cost and on-time delivery."
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Shipping condition or service level (e.g., Standard, Priority). Used to analyze service level mix and cost."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Origin shipping point or warehouse. Supports geographic and facility-level delivery performance analysis."
    - name: "is_backorder"
      expr: is_backorder
      comment: "Indicates whether the delivery is a backorder fulfillment. Key flag for backorder rate and customer impact analysis."
    - name: "is_partial_delivery"
      expr: is_partial_delivery
      comment: "Indicates whether the delivery is a partial shipment. Tracks partial delivery rate as a customer satisfaction risk indicator."
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month of the planned delivery date. Enables monthly delivery volume and performance trending."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of the actual delivery date. Used to compare planned vs. actual delivery timing."
    - name: "priority"
      expr: priority
      comment: "Priority level of the delivery. Enables analysis of high-priority delivery fulfillment rates."
  measures:
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Total number of deliveries. Baseline logistics volume KPI for capacity and throughput planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all deliveries. Core logistics cost KPI for cost-to-serve and carrier contract management."
    - name: "total_freight_tax"
      expr: SUM(CAST(freight_tax_amount AS DOUBLE))
      comment: "Total freight tax across deliveries. Required for tax compliance and landed cost reporting."
    - name: "total_freight_total_amount"
      expr: SUM(CAST(freight_total_amount AS DOUBLE))
      comment: "Total all-in freight amount (cost + tax). Measures total logistics spend for cost management decisions."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery. Tracks cost efficiency trends and supports carrier negotiation benchmarks."
    - name: "backorder_delivery_count"
      expr: COUNT(CASE WHEN is_backorder = TRUE THEN 1 END)
      comment: "Number of deliveries fulfilling backorders. Elevated counts indicate persistent supply shortfalls impacting customers."
    - name: "partial_delivery_count"
      expr: COUNT(CASE WHEN is_partial_delivery = TRUE THEN 1 END)
      comment: "Number of partial deliveries. High partial delivery rates signal fulfillment fragmentation and customer dissatisfaction risk."
    - name: "partial_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_partial_delivery = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries that are partial shipments. KPI for fulfillment completeness and customer experience quality."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms. Used for freight cost validation, carrier billing reconciliation, and logistics planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total shipment volume in cubic meters. Supports container utilization and freight capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_delivery_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery item-level fulfillment and quality metrics. Tracks picking performance, goods issue status, quantity accuracy, and inspection outcomes at the SKU and item level."
  source: "`vibe_manufacturing_v1`.`order`.`delivery_item`"
  dimensions:
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Status of the goods movement for the delivery item (e.g., Not Started, In Progress, Complete). Core fulfillment status dimension."
    - name: "picking_status"
      expr: picking_status
      comment: "Warehouse picking status for the item. Tracks warehouse execution efficiency and readiness for shipment."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the delivery item. Enables quality pass/fail rate analysis at the item level."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Detailed inspection result for the item. Supports root-cause analysis of quality failures in outbound shipments."
    - name: "item_category"
      expr: item_category
      comment: "Category of the delivery item (e.g., Standard, Free Goods, Returns). Enables item-type segmentation of delivery performance."
    - name: "plant"
      expr: plant
      comment: "Plant from which the item is shipped. Supports plant-level fulfillment performance benchmarking."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Shipping point for the delivery item. Enables shipping location performance analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for the goods issue (e.g., 601 Goods Issue). Required for inventory accounting and audit."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the delivery date for the item. Enables monthly delivery item volume and performance trending."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the delivery item quantities. Required for accurate quantity aggregation."
  measures:
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across delivery items. Baseline demand fulfillment volume KPI."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total quantity picked in the warehouse. Measures warehouse execution progress against order demand."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity actually delivered to customers. Core fulfillment output KPI."
    - name: "delivery_item_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_delivered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity successfully delivered. Item-level fill rate — critical for customer service level measurement."
    - name: "picking_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_picked AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity picked. Measures warehouse picking completeness and accuracy."
    - name: "total_item_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of delivered items in kilograms. Used for freight cost validation and logistics planning."
    - name: "total_item_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of delivered items in cubic meters. Supports container and truck utilization analysis."
    - name: "distinct_sku_delivered_count"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs delivered. Measures product breadth in outbound shipments and assortment fulfillment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_schedule_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule line commitment and demand fulfillment metrics. Tracks confirmed vs. requested quantities, schedule line status, and delivery date adherence for supply planning and MRP alignment."
  source: "`vibe_manufacturing_v1`.`order`.`line`"
  dimensions:
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Indicates whether the schedule line is a backorder. Key flag for supply availability and customer impact analysis."
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers across schedule lines. Baseline demand signal for supply and production planning."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery. Measures supply commitment against customer demand."
    - name: "schedule_line_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity confirmed at schedule line level. Critical supply chain KPI for order fulfillment capability."
    - name: "backorder_schedule_line_count"
      expr: COUNT(CASE WHEN backorder_indicator = TRUE THEN 1 END)
      comment: "Number of schedule lines on backorder. Measures supply shortfall exposure and customer delivery risk."
    - name: "schedule_line_count"
      expr: COUNT(1)
      comment: "Total number of schedule lines. Baseline volume metric for order complexity and planning workload assessment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorization (RMA) metrics covering return volume, credit exposure, warranty claims, and return reasons. Supports quality, customer service, and financial risk management decisions."
  source: "`vibe_manufacturing_v1`.`order`.`rma`"
  dimensions:
    - name: "order_rma_status"
      expr: order_rma_status
      comment: "Current status of the RMA (e.g., Pending, Approved, Rejected, Closed). Primary dimension for return pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RMA request. Tracks approval workflow efficiency and rejection rates."
    - name: "rma_type"
      expr: rma_type
      comment: "Type of return (e.g., Defective, Wrong Item, Warranty). Enables root-cause segmentation of return volume."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return. Core dimension for return root-cause analysis and quality improvement."
    - name: "is_warranty_claim"
      expr: is_warranty_claim
      comment: "Indicates whether the RMA is a warranty claim. Enables warranty cost exposure analysis and product reliability tracking."
    - name: "is_damaged"
      expr: is_damaged
      comment: "Indicates whether the returned item was damaged. Tracks damage-related return rates for packaging and logistics quality."
    - name: "is_wrong_item"
      expr: is_wrong_item
      comment: "Indicates whether the return was due to a wrong item being shipped. Measures order accuracy and fulfillment error rates."
    - name: "is_repairable"
      expr: is_repairable
      comment: "Indicates whether the returned item is repairable. Supports disposition planning and reverse logistics cost optimization."
    - name: "return_plant"
      expr: return_plant
      comment: "Plant receiving the returned goods. Enables plant-level return volume and processing performance analysis."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the RMA was requested. Enables monthly return volume trending and seasonality analysis."
  measures:
    - name: "rma_count"
      expr: COUNT(1)
      comment: "Total number of RMAs. Baseline return volume KPI — rising counts signal product quality or fulfillment issues."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit value issued for returns. Measures financial exposure from returns and impacts net revenue reporting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued to customers. Core financial KPI for return cost management and cash flow impact."
    - name: "total_net_return_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount associated with RMAs. Used to quantify the revenue impact of returns."
    - name: "total_handling_fee"
      expr: SUM(CAST(handling_fee AS DOUBLE))
      comment: "Total handling fees charged on returns. Tracks cost recovery from return processing operations."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN is_warranty_claim = TRUE THEN 1 END)
      comment: "Number of warranty claim RMAs. Tracks product reliability and warranty liability exposure."
    - name: "wrong_item_return_count"
      expr: COUNT(CASE WHEN is_wrong_item = TRUE THEN 1 END)
      comment: "Number of returns due to wrong item shipped. Measures order fulfillment accuracy and picking error rates."
    - name: "damaged_return_count"
      expr: COUNT(CASE WHEN is_damaged = TRUE THEN 1 END)
      comment: "Number of returns due to damage. Tracks packaging and transit damage rates for logistics quality improvement."
    - name: "avg_credit_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA. Tracks average return value and financial impact per return event."
    - name: "distinct_customer_return_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active RMAs. Measures breadth of return impact across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods issue metrics tracking inventory outflow, cost of goods issued, and posting accuracy. Supports inventory accounting, cost-of-sales reporting, and logistics operations decisions."
  source: "`vibe_manufacturing_v1`.`order`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Current status of the goods issue posting (e.g., Posted, Reversed, Pending). Primary dimension for goods issue pipeline analysis."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for the goods issue (e.g., 601 Delivery, 602 Reversal). Required for inventory accounting classification."
    - name: "plant"
      expr: plant
      comment: "Plant from which goods were issued. Enables plant-level inventory outflow and cost analysis."
    - name: "profit_center"
      expr: profit_center
      comment: "Profit center associated with the goods issue. Supports P&L reporting and cost allocation by business unit."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the goods issue has been reversed. Tracks reversal rates as an indicator of posting accuracy and process quality."
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates whether the goods issue was automated. Enables analysis of automation adoption and manual processing overhead."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms for the goods issue. Supports trade term analysis and cost responsibility allocation."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_timestamp)
      comment: "Month the goods issue was posted. Enables monthly cost-of-goods-issued trending and period-close analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue valuation. Required for multi-currency cost reporting."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type used for the goods issue (e.g., Standard Cost, Moving Average). Supports cost accounting analysis."
  measures:
    - name: "total_goods_issue_value"
      expr: SUM(CAST(total_value_cost AS DOUBLE))
      comment: "Total cost value of goods issued. Core cost-of-sales KPI for inventory accounting and gross margin analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of goods issued. Used for revenue recognition and cost-of-goods-sold reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods issues. Required for tax compliance and landed cost reporting."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods issued. Measures inventory outflow volume for supply chain and production planning."
    - name: "goods_issue_count"
      expr: COUNT(1)
      comment: "Total number of goods issue postings. Baseline transaction volume KPI for warehouse and logistics throughput."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed goods issues. Elevated reversal counts indicate posting errors, process failures, or returns requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods issues that were reversed. KPI for posting accuracy and process quality in inventory management."
    - name: "avg_goods_issue_value"
      expr: AVG(CAST(total_value_cost AS DOUBLE))
      comment: "Average cost value per goods issue posting. Tracks average transaction size for cost benchmarking and anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blanket order commitment and release performance metrics. Tracks committed vs. released quantities and values, JIT enablement, and contract utilization for strategic procurement and sales contract management."
  source: "`vibe_manufacturing_v1`.`order`.`blanket_order`"
  dimensions:
    - name: "blanket_order_status"
      expr: blanket_order_status
      comment: "Current status of the blanket order (e.g., Active, Expired, Closed). Primary dimension for blanket order pipeline analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of blanket order contract (e.g., Quantity Contract, Value Contract). Enables contract-type segmentation of commitment analysis."
    - name: "contract_status_reason"
      expr: contract_status_reason
      comment: "Reason for the current contract status. Supports root-cause analysis of contract closures or holds."
    - name: "is_jit_enabled"
      expr: is_jit_enabled
      comment: "Indicates whether Just-In-Time delivery is enabled for the blanket order. Tracks JIT adoption and its impact on release patterns."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization managing the blanket order. Enables organizational performance analysis of contract utilization."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the blanket order. Supports channel-level contract volume and utilization analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the blanket order. Enables regional contract commitment and utilization analysis."
    - name: "release_frequency"
      expr: release_frequency
      comment: "Frequency of releases against the blanket order (e.g., Weekly, Monthly). Supports release pattern analysis and demand smoothing."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the blanket order became effective. Used for contract cohort analysis and pipeline aging."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the blanket order. Required for multi-currency contract value reporting."
  measures:
    - name: "total_committed_value"
      expr: SUM(CAST(total_committed_value AS DOUBLE))
      comment: "Total value committed under blanket orders. Measures contracted revenue backlog and long-term customer commitment."
    - name: "total_released_value"
      expr: SUM(CAST(cumulative_released_value AS DOUBLE))
      comment: "Total value released against blanket orders. Tracks actual revenue realization from committed contracts."
    - name: "contract_value_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_released_value AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_value AS DOUBLE)), 0), 2)
      comment: "Percentage of committed contract value that has been released. Core KPI for blanket order utilization and revenue realization from long-term contracts."
    - name: "total_committed_quantity"
      expr: SUM(CAST(total_committed_quantity AS DOUBLE))
      comment: "Total quantity committed under blanket orders. Baseline supply commitment KPI for production and inventory planning."
    - name: "total_released_quantity"
      expr: SUM(CAST(cumulative_released_quantity AS DOUBLE))
      comment: "Total quantity released against blanket orders. Measures actual demand realization from committed contracts."
    - name: "quantity_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_released_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of committed quantity that has been released. Tracks contract consumption rate and remaining capacity."
    - name: "blanket_order_count"
      expr: COUNT(1)
      comment: "Total number of blanket orders. Baseline KPI for long-term contract portfolio size and customer commitment breadth."
    - name: "jit_enabled_order_count"
      expr: COUNT(CASE WHEN is_jit_enabled = TRUE THEN 1 END)
      comment: "Number of blanket orders with JIT delivery enabled. Tracks JIT adoption rate as a supply chain maturity indicator."
    - name: "avg_committed_value_per_order"
      expr: AVG(CAST(total_committed_value AS DOUBLE))
      comment: "Average committed value per blanket order. Tracks average contract size trends for strategic account management."
$$;