-- Metric views for domain: order | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic order pipeline and revenue metrics derived from order headers. Covers order volume, order value, average order size, and order mix — essential for executive revenue steering, sales performance reviews, and demand planning."
  source: "`manufacturing_ecm`.`order`.`header`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. Open, Confirmed, Shipped, Cancelled). Primary dimension for pipeline health analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, Rush, Blanket Release). Used to segment order mix and prioritize fulfillment resources."
    - name: "order_priority"
      expr: order_priority
      comment: "Business priority assigned to the order. Enables escalation tracking and SLA compliance analysis."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the order. Supports regional and organizational performance benchmarking."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the order was placed (e.g. Direct, Distributor, OEM). Key dimension for go-to-market strategy analysis."
    - name: "division"
      expr: division
      comment: "Business division associated with the order. Enables P&L attribution and divisional performance tracking."
    - name: "order_currency"
      expr: order_currency
      comment: "Currency in which the order is denominated. Required for multi-currency revenue normalization."
    - name: "credit_status"
      expr: credit_status
      comment: "Credit approval status of the order. Flags orders at financial risk and informs credit management decisions."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms for the order (e.g. Net 30, Net 60). Drives cash flow forecasting and working capital analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery responsibility. Affects freight cost allocation and risk transfer analysis."
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month in which the order was placed. Enables trend analysis, seasonality detection, and monthly booking comparisons."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of the customer-requested delivery date. Used for demand forecasting and capacity planning."
    - name: "billing_block"
      expr: billing_block
      comment: "Indicates whether the order has a billing block applied. Flags revenue at risk due to billing holds."
    - name: "delivery_block"
      expr: delivery_block
      comment: "Indicates whether the order has a delivery block applied. Flags orders that cannot ship and may impact customer satisfaction."
    - name: "sales_document_type"
      expr: sales_document_type
      comment: "SAP/ERP sales document type classification. Supports detailed order-type segmentation for operational reporting."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT header_id)
      comment: "Total number of distinct orders placed. Core volume KPI for demand tracking and sales performance measurement."
    - name: "total_net_revenue"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net order value across all orders. Primary revenue booking metric used in financial reporting and sales target tracking."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross order value including taxes and surcharges. Used for top-line revenue reporting and tax liability estimation."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax compliance reporting and regulatory submissions."
    - name: "avg_order_net_value"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net value per order. Key indicator of deal size trends; a declining average signals mix shift toward smaller transactions."
    - name: "orders_with_billing_block"
      expr: COUNT(DISTINCT CASE WHEN billing_block = TRUE THEN header_id END)
      comment: "Number of orders currently blocked from billing. Directly quantifies revenue at risk due to billing holds requiring resolution."
    - name: "orders_with_delivery_block"
      expr: COUNT(DISTINCT CASE WHEN delivery_block = TRUE THEN header_id END)
      comment: "Number of orders blocked from delivery. Measures operational risk to customer commitments and on-time delivery performance."
    - name: "avg_order_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per order in kilograms. Informs logistics capacity planning and freight cost estimation."
    - name: "total_order_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volumetric size of all orders in cubic metres. Used for warehouse space planning and container/truck load optimization."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level order metrics capturing product demand, pricing, discounting, and fulfillment quality. Enables SKU-level revenue analysis, discount governance, and delivery performance tracking at the most granular order unit."
  source: "`manufacturing_ecm`.`order`.`order_line`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Fulfillment status of the order line (e.g. Not Delivered, Partially Delivered, Fully Delivered). Core dimension for delivery performance analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection outcome for the order line. Enables quality-driven segmentation of revenue and volume."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection state of the order line item. Flags lines pending quality clearance before shipment."
    - name: "plant"
      expr: plant
      comment: "Manufacturing or distribution plant fulfilling the order line. Enables plant-level throughput and capacity analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel for the order line. Supports channel-level margin and volume analysis."
    - name: "division"
      expr: division
      comment: "Business division associated with the order line. Enables divisional revenue and volume attribution."
    - name: "currency"
      expr: currency
      comment: "Transaction currency for the order line. Required for multi-currency revenue normalization."
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Flags order lines that are on backorder. Directly measures supply shortfall impact on customer commitments."
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason code for order line rejection. Enables root-cause analysis of lost or cancelled order lines."
    - name: "pricing_condition"
      expr: pricing_condition
      comment: "Pricing condition applied to the line (e.g. list price, contract price, promotional). Supports pricing strategy analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities on the order line. Required for accurate volume aggregation across product families."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the actual delivery date. Enables monthly delivery volume and revenue recognition trend analysis."
    - name: "promised_month"
      expr: DATE_TRUNC('MONTH', promised_date)
      comment: "Month of the promised delivery date. Used to measure promise-to-actual delivery performance over time."
  measures:
    - name: "total_order_lines"
      expr: COUNT(DISTINCT order_line_id)
      comment: "Total number of distinct order lines. Baseline volume metric for line-level throughput and workload measurement."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Sum of net price across all order lines. Line-level revenue booking metric for product and channel profitability analysis."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_price AS DOUBLE))
      comment: "Sum of gross price across all order lines before discounts. Used to measure list-price revenue and discount impact."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across order lines. Critical for discount governance, margin protection, and pricing compliance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across order lines. Required for tax liability reporting and compliance."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers across all order lines. Primary demand volume metric for supply planning."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for fulfillment. Measures supply commitment against customer demand."
    - name: "total_sales_quantity"
      expr: SUM(CAST(sales_quantity AS DOUBLE))
      comment: "Total quantity sold across order lines. Core sales volume metric for product performance and market share analysis."
    - name: "order_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity confirmed for fulfillment. Key supply chain KPI measuring ability to meet customer demand; below-target rates signal inventory or capacity gaps."
    - name: "avg_net_price_per_line"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net price per order line. Tracks deal size trends at the line level; useful for pricing strategy and mix analysis."
    - name: "avg_discount_per_line"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount granted per order line. Monitors discounting behaviour and identifies lines with excessive price concessions."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across order lines. Tracks product quality trends and supports quality-driven supplier and plant performance reviews."
    - name: "backorder_line_count"
      expr: COUNT(DISTINCT CASE WHEN backorder_indicator = TRUE THEN order_line_id END)
      comment: "Number of order lines currently on backorder. Directly quantifies supply shortfall impact on customer commitments and delivery risk."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_price AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross price. Measures pricing discipline and margin erosion risk; high rates trigger pricing governance reviews."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery execution metrics covering on-time performance, freight cost efficiency, backorder exposure, and logistics throughput. Essential for customer service level management, logistics cost control, and supply chain operational reviews."
  source: "`manufacturing_ecm`.`order`.`delivery`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. Open, In Transit, Delivered, Cancelled). Primary dimension for delivery pipeline analysis."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Classification of the delivery (e.g. Standard, Express, Return). Enables cost and performance analysis by delivery type."
    - name: "delivery_state"
      expr: delivery_state
      comment: "Operational state of the delivery document. Supports workflow and exception management analysis."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier responsible for the shipment. Enables carrier performance benchmarking and freight cost analysis."
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Shipping condition code (e.g. standard ground, air freight). Supports freight mode analysis and cost optimization."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Origin shipping point for the delivery. Enables plant/warehouse-level logistics performance analysis."
    - name: "priority"
      expr: priority
      comment: "Delivery priority level. Used to track SLA adherence and prioritization effectiveness."
    - name: "is_backorder"
      expr: is_backorder
      comment: "Flags deliveries fulfilling backorder demand. Measures backorder clearance rate and supply recovery performance."
    - name: "is_partial_delivery"
      expr: is_partial_delivery
      comment: "Indicates whether the delivery is a partial shipment. Tracks split-delivery frequency and its impact on customer satisfaction."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flags deliveries containing hazardous materials. Required for regulatory compliance tracking and special handling cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of freight cost amounts. Required for multi-currency freight cost normalization."
    - name: "planned_delivery_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month of the planned delivery date. Enables monthly delivery schedule adherence and capacity planning analysis."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of the actual delivery date. Used for trend analysis of delivery execution performance."
  measures:
    - name: "total_deliveries"
      expr: COUNT(DISTINCT delivery_id)
      comment: "Total number of distinct deliveries executed. Baseline logistics throughput metric for capacity and workload management."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all deliveries. Primary logistics cost KPI for budget management and carrier cost benchmarking."
    - name: "total_freight_tax"
      expr: SUM(CAST(freight_tax_amount AS DOUBLE))
      comment: "Total freight tax amount. Required for tax compliance and total landed cost calculation."
    - name: "total_freight_total_amount"
      expr: SUM(CAST(freight_total_amount AS DOUBLE))
      comment: "Total all-in freight cost including taxes. Represents the complete logistics cost burden for financial reporting."
    - name: "avg_freight_cost_per_delivery"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per delivery. Tracks per-shipment logistics efficiency; rising averages signal carrier or route cost issues."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(total_gross_weight_kg AS DOUBLE))
      comment: "Total gross weight shipped in kilograms. Measures logistics throughput volume and informs carrier capacity negotiations."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volumetric shipment size in cubic metres. Used for container utilization analysis and freight rate optimization."
    - name: "on_time_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN actual_delivery_date <= planned_delivery_date THEN delivery_id END)
      comment: "Number of deliveries completed on or before the planned delivery date. Core customer service level KPI."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_delivery_date <= planned_delivery_date THEN delivery_id END) / NULLIF(COUNT(DISTINCT CASE WHEN actual_delivery_date IS NOT NULL AND planned_delivery_date IS NOT NULL THEN delivery_id END), 0), 2)
      comment: "Percentage of deliveries completed on or before the planned date. Premier customer service KPI; below-target rates trigger logistics and supply chain intervention."
    - name: "partial_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN is_partial_delivery = TRUE THEN delivery_id END)
      comment: "Number of partial deliveries. High partial delivery rates indicate supply shortfalls and negatively impact customer satisfaction scores."
    - name: "backorder_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN is_backorder = TRUE THEN delivery_id END)
      comment: "Number of deliveries fulfilling backorder demand. Tracks backorder clearance velocity and supply recovery effectiveness."
    - name: "avg_freight_cost_per_kg"
      expr: ROUND(SUM(CAST(freight_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_weight_kg AS DOUBLE)), 0), 4)
      comment: "Freight cost per kilogram shipped. Normalised logistics efficiency metric enabling fair carrier and lane cost comparisons."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_delivery_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level delivery execution metrics covering quantity fulfilment accuracy, picking performance, and quality inspection outcomes. Enables SKU-level delivery quality analysis and warehouse operational efficiency measurement."
  source: "`manufacturing_ecm`.`order`.`delivery_item`"
  dimensions:
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Status of goods movement for the delivery item (e.g. Not Started, Partially Processed, Completed). Core dimension for goods issue tracking."
    - name: "picking_status"
      expr: picking_status
      comment: "Warehouse picking status for the item. Enables warehouse throughput and picking accuracy analysis."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the delivery item. Flags items failing quality gates before shipment."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Detailed inspection result for the item. Supports quality root-cause analysis and supplier quality management."
    - name: "item_category"
      expr: item_category
      comment: "Category classification of the delivery item. Enables product-category-level delivery performance analysis."
    - name: "plant"
      expr: plant
      comment: "Plant from which the item is being shipped. Supports plant-level fulfilment performance benchmarking."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Shipping point for the delivery item. Enables shipping-point-level throughput and cost analysis."
    - name: "shipping_condition"
      expr: shipping_condition
      comment: "Shipping condition applied to the item. Supports freight mode and cost analysis at item level."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for the goods issue. Required for inventory accounting and stock reconciliation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for item quantities. Required for accurate volume aggregation across product lines."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of the item delivery date. Enables monthly delivery volume trend analysis at item level."
    - name: "promised_delivery_month"
      expr: DATE_TRUNC('MONTH', promised_delivery_date)
      comment: "Month of the promised delivery date for the item. Used to measure promise-to-actual delivery accuracy."
  measures:
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all delivery items. Baseline demand volume metric for fulfilment planning."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity actually delivered. Measures fulfilment execution against ordered quantities."
    - name: "total_quantity_picked"
      expr: SUM(CAST(quantity_picked AS DOUBLE))
      comment: "Total quantity picked in the warehouse. Tracks warehouse execution progress and picking throughput."
    - name: "item_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_delivered AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity successfully delivered. Item-level fulfilment accuracy KPI; gaps indicate supply shortfalls or picking errors."
    - name: "pick_accuracy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_picked AS DOUBLE)) / NULLIF(SUM(CAST(quantity_ordered AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity picked. Measures warehouse picking completeness; below-target rates signal warehouse capacity or process issues."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of delivered items in kilograms. Logistics throughput metric for carrier capacity and freight cost analysis."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total volume of delivered items in cubic metres. Used for container utilization and warehouse space planning."
    - name: "on_time_item_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN delivery_date <= promised_delivery_date THEN delivery_item_id END)
      comment: "Number of delivery items delivered on or before the promised date. Item-level on-time delivery KPI for customer commitment tracking."
    - name: "on_time_item_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN delivery_date <= promised_delivery_date THEN delivery_item_id END) / NULLIF(COUNT(DISTINCT CASE WHEN delivery_date IS NOT NULL AND promised_delivery_date IS NOT NULL THEN delivery_item_id END), 0), 2)
      comment: "Percentage of delivery items delivered on or before the promised date. Granular customer promise adherence KPI driving service level management."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods issue execution metrics covering inventory outflow value, posting accuracy, and delivery timeliness. Critical for inventory accounting, COGS recognition, and supply chain execution quality reviews."
  source: "`manufacturing_ecm`.`order`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Processing status of the goods issue (e.g. Posted, Reversed, Pending). Core dimension for goods issue pipeline and exception management."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for the goods issue. Required for inventory accounting classification and stock reconciliation."
    - name: "plant"
      expr: plant
      comment: "Plant from which goods were issued. Enables plant-level inventory outflow and COGS analysis."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Shipping point associated with the goods issue. Supports shipping-point-level throughput analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue value. Required for multi-currency COGS and inventory value normalization."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status at time of goods issue. Flags issues posted with quality holds or exceptions."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing the goods issue. Affects revenue recognition timing and risk transfer analysis."
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates whether the goods issue was posted automatically. Measures automation adoption and manual processing overhead."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags goods issues that have been reversed. Tracks posting error rates and reversal frequency for process quality analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the goods issue. Supports data lineage and system integration quality analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_timestamp)
      comment: "Month in which the goods issue was posted. Enables monthly COGS and inventory outflow trend analysis."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of the actual delivery date associated with the goods issue. Used for delivery-to-posting lag analysis."
  measures:
    - name: "total_goods_issues"
      expr: COUNT(DISTINCT goods_issue_id)
      comment: "Total number of goods issues posted. Baseline inventory outflow volume metric for supply chain throughput measurement."
    - name: "total_goods_issue_value"
      expr: SUM(CAST(total_value_cost AS DOUBLE))
      comment: "Total cost value of goods issued. Primary COGS and inventory outflow metric for financial reporting and margin analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue amount associated with goods issues. Used for revenue recognition and order-to-cash performance analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods issues. Required for tax compliance reporting and VAT reconciliation."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods issued. Measures physical inventory outflow volume for supply chain throughput analysis."
    - name: "avg_goods_issue_value"
      expr: AVG(CAST(total_value_cost AS DOUBLE))
      comment: "Average cost value per goods issue. Tracks per-transaction inventory cost trends and identifies high-value issue anomalies."
    - name: "reversal_count"
      expr: COUNT(DISTINCT CASE WHEN reversal_indicator = TRUE THEN goods_issue_id END)
      comment: "Number of goods issues that have been reversed. Measures posting error frequency; high reversal rates indicate process quality issues requiring investigation."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reversal_indicator = TRUE THEN goods_issue_id END) / NULLIF(COUNT(DISTINCT goods_issue_id), 0), 2)
      comment: "Percentage of goods issues that were reversed. Process quality KPI; elevated rates signal systematic posting errors or approval workflow failures."
    - name: "automated_posting_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_automated = TRUE THEN goods_issue_id END) / NULLIF(COUNT(DISTINCT goods_issue_id), 0), 2)
      comment: "Percentage of goods issues posted automatically. Measures process automation maturity; low rates indicate manual processing overhead and error risk."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return merchandise authorisation metrics covering return volume, credit exposure, warranty claim rates, and return reason analysis. Essential for product quality management, customer satisfaction, and reverse logistics cost control."
  source: "`manufacturing_ecm`.`order`.`rma`"
  dimensions:
    - name: "order_rma_status"
      expr: order_rma_status
      comment: "Current status of the RMA (e.g. Pending, Approved, Received, Closed). Primary dimension for return pipeline management."
    - name: "rma_type"
      expr: rma_type
      comment: "Type of return (e.g. Defective, Wrong Item, Warranty, Customer Change). Enables return reason segmentation for quality and commercial analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RMA request. Tracks return authorisation workflow efficiency and approval cycle times."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardised reason code for the return. Primary dimension for root-cause analysis of product quality and fulfilment issues."
    - name: "is_warranty_claim"
      expr: is_warranty_claim
      comment: "Flags returns that are warranty claims. Enables warranty cost tracking and product reliability analysis."
    - name: "is_damaged"
      expr: is_damaged
      comment: "Indicates whether the returned item was damaged. Tracks damage-in-transit rates and packaging/carrier quality issues."
    - name: "is_repairable"
      expr: is_repairable
      comment: "Indicates whether the returned item can be repaired. Informs repair vs. scrap decisions and reverse logistics cost planning."
    - name: "is_wrong_item"
      expr: is_wrong_item
      comment: "Flags returns caused by wrong item shipment. Measures order fulfilment accuracy and picking error rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RMA credit and refund amounts. Required for multi-currency return value normalization."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used for the return. Enables reverse logistics cost analysis by shipping mode."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month in which the RMA was requested. Enables monthly return volume trend analysis and seasonality detection."
    - name: "actual_return_month"
      expr: DATE_TRUNC('MONTH', actual_return_date)
      comment: "Month in which the return was physically received. Used for return processing cycle time and inventory recovery analysis."
  measures:
    - name: "total_rmas"
      expr: COUNT(DISTINCT rma_id)
      comment: "Total number of RMAs raised. Baseline return volume metric; rising counts signal product quality or fulfilment issues requiring investigation."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit value issued to customers for returns. Measures financial exposure from returns and impacts net revenue reporting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total cash refunds issued for returns. Direct cash outflow metric for financial planning and customer satisfaction management."
    - name: "total_handling_fee"
      expr: SUM(CAST(handling_fee AS DOUBLE))
      comment: "Total handling fees charged on returns. Measures cost recovery from reverse logistics and return processing operations."
    - name: "total_net_return_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of returned goods. Used for net revenue adjustment and return rate financial impact analysis."
    - name: "warranty_claim_count"
      expr: COUNT(DISTINCT CASE WHEN is_warranty_claim = TRUE THEN rma_id END)
      comment: "Number of RMAs that are warranty claims. Tracks product reliability issues and warranty liability exposure."
    - name: "warranty_claim_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_warranty_claim = TRUE THEN rma_id END) / NULLIF(COUNT(DISTINCT rma_id), 0), 2)
      comment: "Percentage of returns that are warranty claims. Product quality KPI; elevated rates trigger engineering and supplier quality investigations."
    - name: "wrong_item_return_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_wrong_item = TRUE THEN rma_id END) / NULLIF(COUNT(DISTINCT rma_id), 0), 2)
      comment: "Percentage of returns caused by wrong item shipment. Measures order fulfilment accuracy; high rates indicate picking or order management process failures."
    - name: "avg_credit_per_rma"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount issued per RMA. Tracks per-return financial impact; rising averages signal higher-value product return trends."
    - name: "damaged_return_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_damaged = TRUE THEN rma_id END) / NULLIF(COUNT(DISTINCT rma_id), 0), 2)
      comment: "Percentage of returns where the item was damaged. Measures packaging and transit quality; high rates trigger carrier and packaging reviews."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_schedule_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule line metrics covering confirmed delivery commitments, quantity fulfilment accuracy, and MRP availability performance. Enables supply planning quality assessment, delivery promise reliability tracking, and backorder risk management."
  source: "`manufacturing_ecm`.`order`.`schedule_line`"
  dimensions:
    - name: "schedule_line_status"
      expr: schedule_line_status
      comment: "Status of the schedule line (e.g. Open, Confirmed, Delivered, Cancelled). Primary dimension for delivery commitment pipeline analysis."
    - name: "plant"
      expr: plant
      comment: "Plant responsible for fulfilling the schedule line. Enables plant-level supply commitment and delivery performance analysis."
    - name: "shipping_point"
      expr: shipping_point
      comment: "Shipping point for the schedule line. Supports shipping-point-level throughput and on-time performance analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms for the schedule line delivery. Affects delivery responsibility and risk transfer analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the schedule line net amount. Required for multi-currency revenue commitment analysis."
    - name: "backorder_indicator"
      expr: backorder_indicator
      comment: "Flags schedule lines on backorder. Directly measures supply shortfall exposure against confirmed delivery commitments."
    - name: "split_indicator"
      expr: split_indicator
      comment: "Indicates whether the schedule line was split from a parent line. Tracks delivery split frequency and its impact on logistics complexity."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the schedule line. Enables priority-based fulfilment analysis and SLA compliance tracking."
    - name: "confirmed_delivery_month"
      expr: DATE_TRUNC('MONTH', confirmed_delivery_date)
      comment: "Month of the confirmed delivery date. Enables monthly delivery commitment and revenue recognition trend analysis."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of the customer-requested delivery date. Used to measure promise-to-request alignment and demand planning accuracy."
    - name: "mrp_availability_month"
      expr: DATE_TRUNC('MONTH', mrp_confirmed_availability_date)
      comment: "Month of MRP-confirmed material availability. Tracks supply planning accuracy and MRP system reliability."
  measures:
    - name: "total_schedule_lines"
      expr: COUNT(DISTINCT schedule_line_id)
      comment: "Total number of schedule lines. Baseline delivery commitment volume metric for supply planning workload measurement."
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested by customers across schedule lines. Primary demand signal for supply and production planning."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed for delivery. Measures supply commitment against customer demand at schedule line level."
    - name: "total_committed_net_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net revenue value of confirmed schedule lines. Measures the financial value of delivery commitments in the pipeline."
    - name: "schedule_line_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity confirmed for delivery. Supply commitment KPI; below-target rates indicate supply constraints requiring MRP or procurement intervention."
    - name: "backorder_line_count"
      expr: COUNT(DISTINCT CASE WHEN backorder_indicator = TRUE THEN schedule_line_id END)
      comment: "Number of schedule lines currently on backorder. Quantifies open supply shortfall exposure and customer delivery risk."
    - name: "backorder_quantity"
      expr: SUM(CAST(CASE WHEN backorder_indicator = TRUE THEN requested_quantity ELSE 0 END AS DOUBLE))
      comment: "Total quantity on backorder across schedule lines. Measures the magnitude of supply shortfall for prioritisation and expediting decisions."
    - name: "avg_confirmed_quantity_per_line"
      expr: AVG(CAST(confirmed_quantity AS DOUBLE))
      comment: "Average confirmed quantity per schedule line. Tracks order size trends at the schedule line level for logistics and production planning."
    - name: "split_line_count"
      expr: COUNT(DISTINCT CASE WHEN split_indicator = TRUE THEN schedule_line_id END)
      comment: "Number of schedule lines that were split. High split rates indicate supply fragmentation and increase logistics complexity and cost."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`order_blanket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blanket order commitment and release performance metrics. Tracks contracted volume utilisation, release cadence, and JIT enablement — critical for long-term customer contract management, supply planning, and procurement governance."
  source: "`manufacturing_ecm`.`order`.`blanket_order`"
  dimensions:
    - name: "blanket_order_status"
      expr: blanket_order_status
      comment: "Current status of the blanket order (e.g. Active, Expired, Cancelled). Primary dimension for contract portfolio health analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of blanket order contract (e.g. Value Contract, Quantity Contract). Enables contract mix and commitment structure analysis."
    - name: "contract_status_reason"
      expr: contract_status_reason
      comment: "Reason for the current contract status. Supports root-cause analysis of contract cancellations or holds."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization managing the blanket order. Enables regional and organisational contract portfolio analysis."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the blanket order. Supports channel-level contract volume and value analysis."
    - name: "plant"
      expr: plant
      comment: "Plant responsible for fulfilling blanket order releases. Enables plant-level capacity commitment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the blanket order value. Required for multi-currency contract value normalization."
    - name: "is_jit_enabled"
      expr: is_jit_enabled
      comment: "Indicates whether Just-In-Time delivery is enabled for the blanket order. Tracks JIT adoption and its impact on inventory and delivery performance."
    - name: "release_frequency"
      expr: release_frequency
      comment: "Frequency at which releases are scheduled (e.g. Weekly, Monthly). Supports release cadence analysis and supply planning."
    - name: "region"
      expr: region
      comment: "Geographic region of the blanket order. Enables regional contract portfolio and demand analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the blanket order became effective. Used for contract cohort analysis and portfolio vintage tracking."
    - name: "effective_until_month"
      expr: DATE_TRUNC('MONTH', effective_until)
      comment: "Month the blanket order expires. Enables contract renewal pipeline management and expiry risk analysis."
  measures:
    - name: "total_blanket_orders"
      expr: COUNT(DISTINCT blanket_order_id)
      comment: "Total number of active blanket orders. Baseline contract portfolio volume metric for customer commitment management."
    - name: "total_committed_value"
      expr: SUM(CAST(total_committed_value AS DOUBLE))
      comment: "Total contracted value across all blanket orders. Measures the financial scale of long-term customer commitments in the order book."
    - name: "total_released_value"
      expr: SUM(CAST(cumulative_released_value AS DOUBLE))
      comment: "Total value released against blanket orders. Measures revenue realisation from contracted commitments."
    - name: "total_committed_quantity"
      expr: SUM(CAST(total_committed_quantity AS DOUBLE))
      comment: "Total quantity committed across blanket orders. Primary supply planning input for long-horizon production and procurement scheduling."
    - name: "total_released_quantity"
      expr: SUM(CAST(cumulative_released_quantity AS DOUBLE))
      comment: "Total quantity released against blanket orders. Measures physical fulfilment progress against contracted commitments."
    - name: "contract_utilisation_value_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_released_value AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_value AS DOUBLE)), 0), 2)
      comment: "Percentage of committed contract value that has been released. Key contract performance KPI; low utilisation signals under-ordering risk and potential contract renegotiation."
    - name: "contract_utilisation_quantity_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_released_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_committed_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of committed contract quantity that has been released. Measures volume draw-down against contracted supply commitments."
    - name: "avg_committed_value_per_contract"
      expr: AVG(CAST(total_committed_value AS DOUBLE))
      comment: "Average committed value per blanket order. Tracks contract size trends and informs customer segmentation by commitment level."
    - name: "jit_enabled_contract_count"
      expr: COUNT(DISTINCT CASE WHEN is_jit_enabled = TRUE THEN blanket_order_id END)
      comment: "Number of blanket orders with JIT delivery enabled. Measures JIT adoption across the contract portfolio and its supply chain implications."
$$;