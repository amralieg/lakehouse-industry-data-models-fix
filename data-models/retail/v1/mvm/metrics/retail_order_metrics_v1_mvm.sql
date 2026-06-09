-- Metric views for domain: order | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs derived from the order header fact. Covers order volume, revenue, average order value, discount depth, shipping economics, and payment mix — the primary steering metrics for the retail order domain."
  source: "`retail_ecm`.`order`.`header`"
  dimensions:
    - name: "order_channel"
      expr: channel
      comment: "Sales channel through which the order was placed (e.g., in-store, online, mobile). Enables channel-mix analysis and cross-channel performance comparison."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g., pending, confirmed, shipped, cancelled). Used to filter and segment orders by fulfillment stage."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g., standard, subscription, gift, B2B). Supports segmentation of revenue and volume by business model."
    - name: "payment_method"
      expr: payment_method
      comment: "Primary payment method used on the order (e.g., credit card, gift card, BNPL). Informs payment mix and tender strategy decisions."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment collection status (e.g., authorized, captured, refunded). Critical for cash flow and revenue recognition monitoring."
    - name: "order_currency_code"
      expr: currency_code
      comment: "Currency in which the order was transacted. Required for multi-currency revenue normalization."
    - name: "shipping_country"
      expr: shipping_country_code
      comment: "Destination country for the order shipment. Enables geographic revenue and volume analysis."
    - name: "billing_country"
      expr: billing_country_code
      comment: "Country associated with the billing address. Supports fraud and geographic revenue analysis."
    - name: "order_date_day"
      expr: DATE_TRUNC('DAY', order_date)
      comment: "Order date truncated to day. Primary time dimension for daily order trend analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order date truncated to month. Supports monthly revenue and volume trending."
    - name: "order_date_week"
      expr: DATE_TRUNC('WEEK', order_date)
      comment: "Order date truncated to week. Supports weekly operational cadence reporting."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier assigned to fulfill the order shipment. Enables carrier performance and cost benchmarking."
    - name: "source_system"
      expr: source_system
      comment: "Originating system that created the order record (e.g., OMS, POS, e-commerce platform). Supports data lineage and system-level volume analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT header_id)
      comment: "Total number of distinct orders placed. The primary volume KPI for order throughput and demand measurement."
    - name: "total_gross_revenue"
      expr: SUM(CAST(grand_total_amount AS DOUBLE))
      comment: "Sum of grand total amounts across all orders. The top-line gross revenue KPI used in executive P&L and steering dashboards."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of order subtotals before tax and shipping. Represents net merchandise revenue before logistics and tax adjustments."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across all orders. Measures promotional investment and markdown exposure at the order level."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected from customers. Informs shipping monetization strategy and carrier cost offset analysis."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all orders. Required for tax compliance reporting and liability reconciliation."
    - name: "avg_order_value"
      expr: AVG(CAST(grand_total_amount AS DOUBLE))
      comment: "Average grand total per order (AOV). A primary retail KPI that drives basket-size strategy, upsell investment, and promotional effectiveness evaluation."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount applied per order. Measures the typical promotional depth and informs discount policy calibration."
    - name: "avg_shipping_per_order"
      expr: AVG(CAST(shipping_amount AS DOUBLE))
      comment: "Average shipping charge per order. Benchmarks shipping fee strategy against carrier cost and customer price sensitivity."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. A compound KPI measuring promotional intensity — high values signal margin risk and require executive intervention."
    - name: "shipping_revenue_pct_of_gross"
      expr: ROUND(100.0 * SUM(CAST(shipping_amount AS DOUBLE)) / NULLIF(SUM(CAST(grand_total_amount AS DOUBLE)), 0), 2)
      comment: "Shipping revenue as a percentage of gross order value. Tracks shipping monetization efficiency and customer shipping cost burden."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level KPIs for the order domain. Covers unit economics, margin, fulfillment quality, and SKU-level performance — essential for merchandising, supply chain, and profitability steering."
  source: "`retail_ecm`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g., open, shipped, cancelled, returned). Enables fulfillment pipeline and exception analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfill the line item (e.g., ship-from-store, DC ship, BOPIS, drop-ship). Critical for fulfillment cost and speed benchmarking."
    - name: "line_currency_code"
      expr: currency_code
      comment: "Currency of the order line transaction. Required for multi-currency margin and revenue normalization."
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier assigned to ship this order line. Enables carrier-level performance and cost analysis at the line level."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the line item is on backorder. Used to quantify backorder exposure and its revenue impact."
    - name: "gift_flag"
      expr: gift_flag
      comment: "Indicates whether the line item is a gift. Supports gift order segmentation and packaging cost analysis."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether the ordered SKU was substituted with an alternative. Measures substitution rate and its impact on customer satisfaction."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction applicable to the line item. Required for tax compliance and nexus reporting."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month in which the line item was actually shipped. Supports monthly shipment volume and on-time delivery trending."
    - name: "expected_ship_date_month"
      expr: DATE_TRUNC('MONTH', expected_ship_date)
      comment: "Month in which the line item was expected to ship. Used alongside actual ship date to measure delivery promise adherence."
    - name: "created_date_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the order line was created. Supports cohort-based demand and revenue analysis."
  measures:
    - name: "total_order_lines"
      expr: COUNT(DISTINCT order_line_id)
      comment: "Total number of distinct order lines. Measures order line volume and complexity of order fulfillment operations."
    - name: "total_line_revenue"
      expr: SUM(CAST(extended_price AS DOUBLE))
      comment: "Sum of extended prices across all order lines. Represents gross merchandise revenue at the line level before returns and cancellations."
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold across all order lines. The primary cost input for gross margin calculation and profitability steering."
    - name: "total_gross_margin"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Sum of margin amounts across all order lines. Direct measure of profitability at the line level — a core executive KPI."
    - name: "total_line_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at the order line level. Measures promotional investment and markdown depth at SKU granularity."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines. Measures demand volume and drives inventory replenishment and capacity planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped across all lines. Measures actual fulfillment output and is compared to ordered quantity for fill-rate analysis."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled across all order lines. Quantifies demand loss from cancellations and informs inventory and demand planning."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total units returned across all order lines. A key quality and customer satisfaction KPI — high return rates signal product or expectation issues."
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(extended_price AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of line revenue. The primary profitability ratio for merchandising and category management decisions."
    - name: "line_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units that were shipped. A critical supply chain KPI measuring fulfillment completeness and inventory availability."
    - name: "line_cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cancelled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units that were cancelled. Measures demand leakage and operational failure rate — triggers investigation when elevated."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(returned_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped units that were returned. A key product quality and customer satisfaction KPI — high rates drive product review and policy changes."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average retail price per unit across order lines. Tracks price positioning and the impact of promotions on realized selling prices."
    - name: "avg_line_margin"
      expr: AVG(CAST(margin_amount AS DOUBLE))
      comment: "Average margin amount per order line. Benchmarks per-line profitability and supports SKU-level margin management."
    - name: "discount_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN discount_amount > 0 THEN order_line_id END) / NULLIF(COUNT(DISTINCT order_line_id), 0), 2)
      comment: "Percentage of order lines that had a discount applied. Measures promotional reach and the proportion of revenue exposed to markdown risk."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation event KPIs measuring the volume, financial impact, and operational characteristics of order cancellations. Directly informs retention, fraud, and refund policy decisions."
  source: "`retail_ecm`.`order`.`cancellation`"
  dimensions:
    - name: "cancellation_status"
      expr: cancellation_status
      comment: "Current status of the cancellation request (e.g., pending, approved, rejected, reversed). Used to track cancellation pipeline and approval backlog."
    - name: "cancellation_channel"
      expr: channel
      comment: "Channel through which the cancellation was initiated (e.g., online, call center, in-store). Identifies channel-specific cancellation patterns."
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the cancellation (e.g., customer, system, associate, fraud engine). Critical for root-cause analysis of cancellation drivers."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the cancellation. Enables structured analysis of cancellation root causes to drive corrective action."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g., original payment, store credit, gift card). Informs refund liability and cash flow planning."
    - name: "refund_currency_code"
      expr: refund_currency_code
      comment: "Currency in which the refund was issued. Required for multi-currency refund liability reporting."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the cancellation was flagged as potentially fraudulent. Enables fraud-driven cancellation segmentation and loss quantification."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the cancellation qualifies for a refund. Used to segment cancellations by refund liability exposure."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether the cancellation required manager or system approval. Measures operational overhead in the cancellation workflow."
    - name: "cancellation_date_month"
      expr: DATE_TRUNC('MONTH', cancellation_timestamp)
      comment: "Month in which the cancellation occurred. Supports monthly cancellation trend analysis and seasonality detection."
    - name: "cancellation_stage"
      expr: stage
      comment: "Processing stage of the cancellation (e.g., initiated, processing, completed). Tracks cancellation workflow progression and bottlenecks."
  measures:
    - name: "total_cancellations"
      expr: COUNT(DISTINCT cancellation_id)
      comment: "Total number of distinct cancellation events. The primary volume KPI for cancellation monitoring and trend alerting."
    - name: "total_cancelled_amount"
      expr: SUM(CAST(cancelled_amount AS DOUBLE))
      comment: "Total gross merchandise value cancelled. Measures revenue at risk from cancellations — a direct input to demand and revenue forecasting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund value issued for cancellations. Measures cash outflow from cancellation refunds and informs working capital planning."
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected on cancellations. Measures fee revenue that partially offsets cancellation processing costs."
    - name: "total_cancellation_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total cancellation processing fees charged. Quantifies fee recovery against the operational cost of processing cancellations."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled. Measures inventory demand reversal volume and informs replenishment and allocation adjustments."
    - name: "avg_cancelled_amount"
      expr: AVG(CAST(cancelled_amount AS DOUBLE))
      comment: "Average cancelled order value per cancellation event. Benchmarks the typical financial impact of a cancellation for policy and threshold setting."
    - name: "fraud_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN cancellation_id END) / NULLIF(COUNT(DISTINCT cancellation_id), 0), 2)
      comment: "Percentage of cancellations flagged as fraudulent. A critical risk KPI — elevated rates trigger fraud rule review and loss prevention escalation."
    - name: "refund_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(cancelled_amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as a percentage of cancelled amount. Measures the proportion of cancelled value returned to customers — informs refund policy and liability exposure."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across cancellation events. Tracks the overall fraud risk profile of cancellations and informs model threshold calibration."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount event KPIs measuring promotional investment, discount depth, and approval efficiency. Enables pricing strategy, margin protection, and promotional ROI analysis."
  source: "`retail_ecm`.`order`.`discount`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g., percentage, fixed amount, BOGO, loyalty). Enables analysis of discount mix and effectiveness by type."
    - name: "discount_method"
      expr: discount_method
      comment: "Mechanism through which the discount was applied (e.g., coupon, automatic, loyalty redemption). Supports channel and method-level promotional analysis."
    - name: "applied_at_level"
      expr: applied_at_level
      comment: "Level at which the discount was applied (e.g., order, line, SKU). Determines the scope and granularity of promotional impact."
    - name: "discount_channel"
      expr: channel
      comment: "Sales channel where the discount was applied. Enables channel-specific promotional investment and effectiveness comparison."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the discount (e.g., auto-approved, pending, rejected). Tracks discount governance compliance and approval bottlenecks."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the discount can be combined with other discounts. Used to analyze stacking behavior and its compounding margin impact."
    - name: "discount_currency_code"
      expr: currency_code
      comment: "Currency of the discount transaction. Required for multi-currency promotional spend normalization."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the discount application. Supports structured analysis of discount justification and policy compliance."
    - name: "applied_date_month"
      expr: DATE_TRUNC('MONTH', applied_timestamp)
      comment: "Month in which the discount was applied. Supports monthly promotional spend trending and campaign calendar analysis."
    - name: "valid_from_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month from which the discount offer was valid. Used to align promotional spend with campaign launch periods."
  measures:
    - name: "total_discount_events"
      expr: COUNT(DISTINCT discount_id)
      comment: "Total number of distinct discount applications. Measures promotional reach and the volume of discount events processed."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of all discounts applied. The primary promotional investment KPI — directly impacts gross margin and requires executive oversight."
    - name: "total_taxable_amount_adjustment"
      expr: SUM(CAST(taxable_amount_adjustment AS DOUBLE))
      comment: "Total taxable amount adjustment resulting from discounts. Required for tax compliance and accurate tax liability reporting."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average discount value per discount event. Benchmarks typical promotional depth and informs discount cap policy decisions."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average discount percentage applied across all discount events. Measures typical markdown depth and tracks promotional intensity over time."
    - name: "discount_to_original_price_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(original_price AS DOUBLE)), 0), 2)
      comment: "Total discount as a percentage of total original price. A compound margin-risk KPI measuring the aggregate markdown rate across all promotional events."
    - name: "avg_final_price"
      expr: AVG(CAST(final_price AS DOUBLE))
      comment: "Average realized selling price after discount. Tracks the effective price point achieved after promotional adjustments — key for pricing strategy calibration."
    - name: "price_realization_pct"
      expr: ROUND(100.0 * SUM(CAST(final_price AS DOUBLE)) / NULLIF(SUM(CAST(original_price AS DOUBLE)), 0), 2)
      comment: "Final price as a percentage of original price. Measures how much of the original price was retained after discounting — a direct indicator of pricing power."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction KPIs for in-store retail operations. Covers transaction volume, basket size, tender mix, loyalty engagement, and operational efficiency at the register level."
  source: "`retail_ecm`.`order`.`pos_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of POS transaction (e.g., sale, return, exchange, void). Enables segmentation of transaction volume by operational type."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the POS transaction (e.g., completed, voided, suspended). Used to filter valid transactions and measure void/exception rates."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method associated with the POS transaction (e.g., take-away, ship-to-home, BOPIS). Supports omnichannel fulfillment mix analysis."
    - name: "transaction_currency_code"
      expr: currency_code
      comment: "Currency of the POS transaction. Required for multi-currency store revenue normalization."
    - name: "manager_override_flag"
      expr: manager_override_flag
      comment: "Indicates whether a manager override was applied during the transaction. Measures exception handling frequency and potential policy compliance risk."
    - name: "training_mode_flag"
      expr: training_mode_flag
      comment: "Indicates whether the transaction was processed in training mode. Used to exclude training transactions from production revenue reporting."
    - name: "business_date_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Fiscal business date truncated to month. Primary time dimension for monthly store sales performance reporting."
    - name: "business_date_week"
      expr: DATE_TRUNC('WEEK', business_date)
      comment: "Fiscal business date truncated to week. Supports weekly store operations and sales cadence reporting."
    - name: "transaction_date_day"
      expr: DATE_TRUNC('DAY', transaction_timestamp)
      comment: "Transaction timestamp truncated to day. Enables daily store traffic and revenue analysis."
  measures:
    - name: "total_transactions"
      expr: COUNT(DISTINCT pos_transaction_id)
      comment: "Total number of distinct POS transactions. The primary store traffic and throughput KPI for in-store operations management."
    - name: "total_pos_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from POS transactions. The top-line in-store sales KPI used in store performance dashboards and regional P&L reporting."
    - name: "total_pos_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal amount before tax across POS transactions. Represents net merchandise revenue from in-store sales."
    - name: "total_pos_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at POS. Measures in-store promotional investment and markdown exposure."
    - name: "total_pos_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at POS. Required for tax remittance and compliance reporting at the store level."
    - name: "total_tender_amount"
      expr: SUM(CAST(tender_amount AS DOUBLE))
      comment: "Total tender collected across POS transactions. Measures actual cash and payment collected — key for daily cash reconciliation."
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction value at POS (in-store AOV). A primary retail KPI for basket size management and upsell strategy effectiveness."
    - name: "avg_discount_per_transaction"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per POS transaction. Benchmarks in-store promotional depth and informs discount policy calibration."
    - name: "pos_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "In-store discount as a percentage of subtotal. Measures promotional intensity at POS — elevated rates signal margin risk requiring management action."
    - name: "manager_override_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN manager_override_flag = TRUE THEN pos_transaction_id END) / NULLIF(COUNT(DISTINCT pos_transaction_id), 0), 2)
      comment: "Percentage of transactions requiring a manager override. An operational quality KPI — high rates indicate policy exceptions, training gaps, or potential fraud."
    - name: "avg_change_amount"
      expr: AVG(CAST(change_amount AS DOUBLE))
      comment: "Average change amount returned to customers per cash transaction. Monitors cash handling efficiency and tender accuracy at the register."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_pos_transaction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS transaction line-item KPIs for in-store SKU-level performance. Covers unit sales, revenue, margin, markdown depth, return rates, and private label penetration — essential for category management and store operations."
  source: "`retail_ecm`.`order`.`pos_transaction_line`"
  dimensions:
    - name: "return_flag"
      expr: return_flag
      comment: "Indicates whether the line item is a return transaction. Used to separate sales from returns for net revenue and return rate analysis."
    - name: "voided_flag"
      expr: voided_flag
      comment: "Indicates whether the line item was voided. Used to exclude voided lines from revenue and volume calculations."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private label product. Enables private label penetration analysis — a key strategic KPI for margin improvement."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method for the line item (e.g., take-away, ship-to-home). Supports omnichannel fulfillment mix analysis at the SKU level."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the sold item (e.g., each, kg, litre). Required for accurate quantity aggregation across different product types."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line item. Supports tax category analysis and compliance reporting."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for returned line items. Enables structured return root-cause analysis to drive product and policy improvements."
    - name: "scanned_date_month"
      expr: DATE_TRUNC('MONTH', scanned_timestamp)
      comment: "Month in which the item was scanned at POS. Primary time dimension for monthly SKU-level sales trend analysis."
    - name: "scanned_date_week"
      expr: DATE_TRUNC('WEEK', scanned_timestamp)
      comment: "Week in which the item was scanned at POS. Supports weekly category and SKU performance reporting."
  measures:
    - name: "total_line_items_sold"
      expr: COUNT(DISTINCT CASE WHEN return_flag = FALSE OR return_flag IS NULL THEN pos_transaction_line_id END)
      comment: "Total number of distinct POS line items sold (excluding returns). Measures SKU-level transaction volume and product velocity."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total units sold across all POS line items. The primary volume KPI for in-store demand measurement and inventory replenishment planning."
    - name: "total_net_line_revenue"
      expr: SUM(CAST(net_line_amount AS DOUBLE))
      comment: "Total net revenue across POS line items after discounts. Represents realized in-store merchandise revenue at the SKU level."
    - name: "total_line_revenue_gross"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Total gross line revenue including tax across POS line items. Used for gross sales reporting and tax reconciliation."
    - name: "total_pos_line_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold across POS line items. The primary cost input for in-store gross margin calculation."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown value applied across POS line items. Measures in-store markdown investment and its impact on realized margin."
    - name: "total_pos_line_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across POS line items. Required for line-level tax compliance and jurisdiction reporting."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average retail price per unit at POS. Tracks realized price points and the impact of markdowns on average selling price."
    - name: "avg_extended_price"
      expr: AVG(CAST(extended_price AS DOUBLE))
      comment: "Average extended price per POS line item. Benchmarks per-line revenue contribution and supports basket composition analysis."
    - name: "pos_line_gross_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(net_line_amount AS DOUBLE)) - SUM(CAST(cost_of_goods_sold AS DOUBLE))) / NULLIF(SUM(CAST(net_line_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage at the POS line level. The primary in-store profitability KPI for category management and pricing decisions."
    - name: "markdown_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(markdown_amount AS DOUBLE)) / NULLIF(SUM(CAST(extended_price AS DOUBLE)), 0), 2)
      comment: "Markdown amount as a percentage of extended price. Measures in-store markdown intensity — high rates signal clearance pressure or pricing strategy issues."
    - name: "private_label_penetration_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN private_label_flag = TRUE THEN pos_transaction_line_id END) / NULLIF(COUNT(DISTINCT pos_transaction_line_id), 0), 2)
      comment: "Percentage of POS line items that are private label products. A strategic KPI measuring own-brand penetration — higher rates drive margin improvement."
    - name: "return_line_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN return_flag = TRUE THEN pos_transaction_line_id END) / NULLIF(COUNT(DISTINCT pos_transaction_line_id), 0), 2)
      comment: "Percentage of POS line items that are returns. Measures in-store return rate — a key customer satisfaction and shrinkage KPI."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction KPIs covering tender volume, fraud risk, refund liability, and payment method mix. Essential for financial operations, fraud management, and payment strategy decisions."
  source: "`retail_ecm`.`order`.`payment`"
  dimensions:
    - name: "payment_method_type"
      expr: method_type
      comment: "Type of payment method used (e.g., credit card, debit card, digital wallet, BNPL, gift card). Enables payment mix analysis and tender strategy optimization."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., authorized, captured, refunded, voided). Used to track payment lifecycle and identify collection failures."
    - name: "payment_channel"
      expr: channel
      comment: "Channel through which the payment was processed (e.g., online, in-store, mobile). Enables channel-level payment performance and fraud analysis."
    - name: "card_brand"
      expr: card_brand
      comment: "Card network brand (e.g., Visa, Mastercard, Amex). Supports interchange cost analysis and card brand mix reporting."
    - name: "digital_wallet_type"
      expr: digital_wallet_type
      comment: "Type of digital wallet used (e.g., Apple Pay, Google Pay, PayPal). Tracks digital payment adoption and wallet-specific performance."
    - name: "bnpl_provider"
      expr: bnpl_provider
      comment: "Buy-now-pay-later provider used (e.g., Afterpay, Klarna, Affirm). Enables BNPL adoption and risk analysis by provider."
    - name: "fraud_decision"
      expr: fraud_decision
      comment: "Fraud screening decision for the payment (e.g., approved, declined, review). Used to measure fraud detection effectiveness and false positive rates."
    - name: "payment_currency_code"
      expr: currency_code
      comment: "Currency of the payment transaction. Required for multi-currency payment volume and refund normalization."
    - name: "authorization_date_month"
      expr: DATE_TRUNC('MONTH', authorization_timestamp)
      comment: "Month of payment authorization. Primary time dimension for monthly payment volume and authorization rate trending."
    - name: "capture_date_month"
      expr: DATE_TRUNC('MONTH', capture_timestamp)
      comment: "Month of payment capture. Used to align revenue recognition with actual payment capture events."
  measures:
    - name: "total_payment_transactions"
      expr: COUNT(DISTINCT payment_id)
      comment: "Total number of distinct payment transactions. Measures payment processing volume and is the denominator for payment rate KPIs."
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount collected. Measures gross payment volume — a key financial operations KPI for cash flow and settlement reconciliation."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across payment transactions. Measures refund liability and cash outflow — critical for working capital management."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Benchmarks typical payment size and supports fraud threshold and risk model calibration."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across payment transactions. Tracks the overall fraud risk profile of the payment portfolio and informs model threshold adjustments."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as a percentage of total payment amount. Measures the proportion of collected revenue being returned — a key financial health and customer satisfaction KPI."
    - name: "net_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net payment amount after deducting refunds. Represents actual net cash collected — the true revenue realization KPI for financial reporting."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription KPIs measuring recurring revenue, subscriber lifecycle, churn, and delivery performance. Supports subscription business model steering and retention strategy decisions."
  source: "`retail_ecm`.`order`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current lifecycle status of the subscription (e.g., active, paused, cancelled, expired). Primary dimension for subscriber base health analysis."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g., auto-replenishment, membership, gift). Enables segmentation of recurring revenue by subscription model."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency of the subscription (e.g., monthly, quarterly, annual). Supports revenue recognition timing and cash flow forecasting."
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Frequency of subscription deliveries (e.g., weekly, bi-weekly, monthly). Informs fulfillment capacity planning and delivery cost modeling."
    - name: "subscription_channel"
      expr: channel
      comment: "Channel through which the subscription was acquired (e.g., online, in-store, mobile). Enables channel-level subscriber acquisition and retention analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the subscription is set to auto-renew. Measures auto-renewal adoption rate — a key retention and revenue predictability KPI."
    - name: "gift_subscription_flag"
      expr: gift_subscription_flag
      comment: "Indicates whether the subscription was purchased as a gift. Enables gift subscription segmentation and conversion-to-owned analysis."
    - name: "subscription_currency_code"
      expr: currency_code
      comment: "Currency of the subscription billing. Required for multi-currency recurring revenue normalization."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for subscription cancellation. Enables structured churn root-cause analysis to drive retention interventions."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month in which the subscription started. Supports subscriber cohort analysis and acquisition trend reporting."
    - name: "cancellation_date_month"
      expr: DATE_TRUNC('MONTH', cancellation_date)
      comment: "Month in which the subscription was cancelled. Enables monthly churn trend analysis and seasonality detection."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total number of distinct subscriptions. The primary subscriber base size KPI — a fundamental metric for subscription business health."
    - name: "total_subscription_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total subscription billing amount. Measures gross recurring revenue — the top-line KPI for subscription business model performance."
    - name: "total_subscription_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied to subscriptions. Measures promotional investment in subscriber acquisition and retention."
    - name: "avg_subscription_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average subscription billing amount. Benchmarks average revenue per subscriber (ARPS) — a key subscription economics KPI."
    - name: "net_subscription_revenue"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(discount_amount AS DOUBLE))
      comment: "Net subscription revenue after discounts. Represents realized recurring revenue after promotional adjustments — the true subscription revenue KPI."
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions enrolled in auto-renewal. A critical retention KPI — higher rates indicate stronger subscriber commitment and more predictable revenue."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN subscription_status = 'cancelled' THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled (churn rate). The primary subscriber retention KPI — elevated rates trigger retention program investment and root-cause investigation."
    - name: "avg_discount_per_subscription"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per subscription. Measures the typical promotional depth used to acquire or retain subscribers — informs discount policy and LTV modeling."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_gift_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift card program KPIs covering issuance, redemption, liability, fraud, and breakage. Supports gift card program profitability, escheatment compliance, and fraud management decisions."
  source: "`retail_ecm`.`order`.`gift_card`"
  dimensions:
    - name: "card_status"
      expr: card_status
      comment: "Current status of the gift card (e.g., active, redeemed, expired, blocked). Primary dimension for gift card portfolio health analysis."
    - name: "card_type"
      expr: card_type
      comment: "Type of gift card (e.g., physical, digital, promotional). Enables segmentation of gift card issuance and redemption by product type."
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the gift card was issued (e.g., in-store, online, corporate). Supports channel-level gift card program analysis."
    - name: "gift_card_currency_code"
      expr: currency_code
      comment: "Currency of the gift card balance. Required for multi-currency gift card liability reporting."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the gift card has been flagged for fraud. Used to quantify fraud exposure in the gift card portfolio."
    - name: "reloadable_flag"
      expr: reloadable_flag
      comment: "Indicates whether the gift card can be reloaded. Enables segmentation of reloadable vs. single-use cards for program design analysis."
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Indicates whether the gift card balance is eligible for escheatment (unclaimed property). Critical for regulatory compliance and liability management."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month in which the gift card was issued. Supports monthly issuance trend analysis and seasonal gift card demand planning."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month in which the gift card expires. Used for breakage forecasting and escheatment compliance planning."
  measures:
    - name: "total_gift_cards_issued"
      expr: COUNT(DISTINCT gift_card_id)
      comment: "Total number of distinct gift cards issued. Measures gift card program scale and issuance velocity."
    - name: "total_initial_balance_issued"
      expr: SUM(CAST(initial_balance AS DOUBLE))
      comment: "Total initial balance loaded across all issued gift cards. Measures gross gift card liability created — a key financial reporting and cash flow KPI."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all active gift cards. Represents current gift card liability on the balance sheet — a mandatory financial reporting KPI."
    - name: "total_redeemed_amount"
      expr: SUM(CAST(total_redeemed_amount AS DOUBLE))
      comment: "Total amount redeemed across all gift cards. Measures gift card revenue recognition and program utilization."
    - name: "total_reloaded_amount"
      expr: SUM(CAST(total_reloaded_amount AS DOUBLE))
      comment: "Total amount reloaded onto reloadable gift cards. Measures the recurring revenue and engagement value of the reloadable card program."
    - name: "total_fees_charged"
      expr: SUM(CAST(total_fees_charged AS DOUBLE))
      comment: "Total fees charged on gift cards (e.g., inactivity fees). Measures fee revenue from the gift card program and informs fee policy decisions."
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_redeemed_amount AS DOUBLE)) / NULLIF(SUM(CAST(initial_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of issued gift card value that has been redeemed. Measures program utilization and is the complement of breakage — a key program profitability KPI."
    - name: "breakage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(current_balance AS DOUBLE)) / NULLIF(SUM(CAST(initial_balance AS DOUBLE)), 0), 2)
      comment: "Remaining balance as a percentage of initial balance. Approximates gift card breakage (unredeemed value) — a direct contribution to gift card program profitability."
    - name: "fraud_card_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN gift_card_id END) / NULLIF(COUNT(DISTINCT gift_card_id), 0), 2)
      comment: "Percentage of gift cards flagged for fraud. Measures fraud exposure in the gift card portfolio — elevated rates trigger security and issuance policy reviews."
    - name: "avg_initial_balance"
      expr: AVG(CAST(initial_balance AS DOUBLE))
      comment: "Average initial balance per gift card issued. Benchmarks typical gift card denomination and informs product design and pricing decisions."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order status transition KPIs measuring fulfillment velocity, SLA compliance, exception rates, and customer notification effectiveness. Supports operational excellence and customer experience steering."
  source: "`retail_ecm`.`order`.`status_history`"
  dimensions:
    - name: "status_code"
      expr: status_code
      comment: "Current order status code at the time of the history event. Primary dimension for pipeline stage analysis and bottleneck identification."
    - name: "previous_status_code"
      expr: previous_status_code
      comment: "Status code before the transition. Used with status_code to analyze specific status transition patterns and identify problematic flows."
    - name: "order_type"
      expr: order_type
      comment: "Type of order associated with the status event. Enables SLA and exception analysis segmented by order type."
    - name: "source_order_channel"
      expr: source_order_channel
      comment: "Channel from which the order originated. Supports channel-level fulfillment performance and SLA compliance analysis."
    - name: "fulfillment_node_type"
      expr: fulfillment_node_type
      comment: "Type of fulfillment node processing the order (e.g., DC, store, 3PL). Enables node-type-level fulfillment performance benchmarking."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates whether the status event represents a fulfillment exception. Used to measure exception rates and their impact on delivery performance."
    - name: "exception_category"
      expr: exception_category
      comment: "Category of the fulfillment exception (e.g., carrier delay, inventory shortage, address issue). Enables structured exception root-cause analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the status transition breached the SLA target. The primary SLA compliance dimension for operational performance management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the order at this status stage. Enables priority-segmented SLA and throughput analysis."
    - name: "customer_notification_channel"
      expr: customer_notification_channel
      comment: "Channel used to notify the customer of the status change (e.g., email, SMS, push). Supports notification effectiveness and channel preference analysis."
    - name: "transition_date_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of the status transition event. Primary time dimension for monthly fulfillment performance and SLA compliance trending."
    - name: "transition_date_week"
      expr: DATE_TRUNC('WEEK', transition_timestamp)
      comment: "Week of the status transition event. Supports weekly operational cadence and SLA monitoring."
  measures:
    - name: "total_status_events"
      expr: COUNT(DISTINCT status_history_id)
      comment: "Total number of distinct order status transition events. Measures order processing activity volume and pipeline throughput."
    - name: "total_orders_with_exceptions"
      expr: COUNT(DISTINCT CASE WHEN exception_flag = TRUE THEN header_id END)
      comment: "Number of distinct orders that experienced at least one fulfillment exception. Measures the breadth of fulfillment quality issues across the order base."
    - name: "total_sla_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN status_history_id END)
      comment: "Total number of status events where the SLA target was breached. The primary SLA compliance KPI — directly tied to customer satisfaction and contractual obligations."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN status_history_id END) / NULLIF(COUNT(DISTINCT status_history_id), 0), 2)
      comment: "Percentage of status events that breached SLA targets. A critical operational KPI — elevated rates trigger fulfillment process review and carrier escalation."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN exception_flag = TRUE THEN status_history_id END) / NULLIF(COUNT(DISTINCT status_history_id), 0), 2)
      comment: "Percentage of status events flagged as exceptions. Measures fulfillment quality and operational reliability — a key customer experience KPI."
    - name: "customer_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN customer_notification_sent_flag = TRUE THEN status_history_id END) / NULLIF(COUNT(DISTINCT status_history_id), 0), 2)
      comment: "Percentage of status events where a customer notification was sent. Measures proactive communication coverage — a key customer experience and satisfaction driver."
    - name: "resolution_required_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN resolution_required_flag = TRUE THEN status_history_id END) / NULLIF(COUNT(DISTINCT status_history_id), 0), 2)
      comment: "Percentage of status events requiring manual resolution. Measures operational workload from exception handling and informs staffing and automation investment decisions."
$$;