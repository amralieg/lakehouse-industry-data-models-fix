-- Metric views for domain: order | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order-level financial and operational KPIs derived from the order header. Covers GMV, average order value, discount penetration, tax yield, and shipping revenue — the primary steering metrics for the order management function."
  source: "`vibe_retail_v1`.`order`.`header`"
  dimensions:
    - name: "order_channel"
      expr: channel
      comment: "Sales channel through which the order was placed (e.g. web, store, mobile, marketplace). Primary dimension for omnichannel performance analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. standard, subscription, B2B, exchange). Used to segment revenue and operational metrics by order class."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. placed, confirmed, shipped, delivered, cancelled). Drives funnel and fulfilment analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Primary payment method used on the order. Informs tender-mix and payment-risk analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (e.g. authorised, captured, refunded, failed). Used to identify revenue at risk and payment failure rates."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO 4217 currency code for the order. Required for multi-currency financial reporting."
    - name: "order_date_day"
      expr: DATE_TRUNC('DAY', order_date)
      comment: "Order placement date truncated to day. Primary time grain for daily sales trending."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order placement date truncated to month. Used for monthly revenue and volume reporting."
    - name: "promised_delivery_date"
      expr: promised_delivery_date
      comment: "Date the order was promised for delivery. Used to measure on-time delivery performance."
    - name: "locale"
      expr: locale
      comment: "Locale/region of the order. Supports geographic revenue segmentation."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT header_id)
      comment: "Total number of distinct orders placed. Baseline volume metric for order management and capacity planning."
    - name: "gross_merchandise_value"
      expr: SUM(CAST(grand_total_amount AS DOUBLE))
      comment: "Sum of grand total amounts across all orders. Primary top-line revenue KPI used in executive dashboards and QBRs."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-shipping subtotals. Used to isolate product revenue from fees and taxes."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied across all orders. Measures promotional spend and markdown impact on revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax liability reporting and compliance."
    - name: "total_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping revenue collected. Used to assess shipping cost recovery and carrier strategy."
    - name: "avg_order_value"
      expr: AVG(CAST(grand_total_amount AS DOUBLE))
      comment: "Average grand total per order. Core KPI for customer spend analysis and pricing strategy; a rising AOV signals upsell effectiveness."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per order. Tracks promotional generosity and its trend relative to AOV."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity; high values signal margin risk and require executive review."
    - name: "shipping_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipping_amount AS DOUBLE)) / NULLIF(SUM(CAST(grand_total_amount AS DOUBLE)), 0), 2)
      comment: "Shipping revenue as a percentage of GMV. Indicates how much of fulfilment cost is recovered from customers."
    - name: "tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of subtotal. Used for tax compliance monitoring and jurisdiction analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level revenue, margin, and fulfilment KPIs. Provides the most granular view of product-level performance including COGS, margin, returns, and substitution rates — essential for merchandising and supply chain steering."
  source: "`vibe_retail_v1`.`order`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g. open, shipped, cancelled, returned). Used to track line-level fulfilment health."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfil the line (e.g. ship-from-store, DC ship, BOPIS, drop-ship). Critical for fulfilment cost and capacity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO 4217 currency code for the line. Required for multi-currency financial reporting."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Indicates whether the line is on backorder. Used to measure inventory availability and customer experience impact."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether a substitute SKU was used. Tracks substitution rate as a proxy for out-of-stock severity."
    - name: "gift_flag"
      expr: gift_flag
      comment: "Indicates whether the line is a gift. Used for gift-order segmentation and packaging cost analysis."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction for the line. Supports geographic tax compliance reporting."
    - name: "actual_ship_date"
      expr: DATE_TRUNC('DAY', actual_ship_date)
      comment: "Actual ship date truncated to day. Used for ship-date trending and SLA compliance analysis."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for line cancellation. Used to diagnose root causes of cancellations (e.g. OOS, fraud, customer request)."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for line return. Used to identify quality, sizing, or expectation-gap issues driving returns."
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all lines. Baseline volume metric for demand and inventory planning."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total units shipped. Measures fulfilment throughput and is compared to ordered quantity to compute fill rate."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total units returned. Drives return rate KPI and informs product quality and customer satisfaction decisions."
    - name: "total_cancelled_quantity"
      expr: SUM(CAST(cancelled_quantity AS DOUBLE))
      comment: "Total units cancelled. Used to measure cancellation impact on revenue and inventory release."
    - name: "total_extended_price"
      expr: SUM(CAST(extended_price AS DOUBLE))
      comment: "Sum of extended (quantity × unit price) line amounts. Represents gross line revenue before discounts and tax."
    - name: "total_line_revenue"
      expr: SUM(CAST(total AS DOUBLE))
      comment: "Sum of final line totals after discounts and tax. Net line revenue used in P&L reporting."
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold across all lines. Core input to gross margin calculation and merchandising profitability analysis."
    - name: "total_margin_amount"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin dollars across all lines. Primary profitability KPI for merchandising and category management."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied at the line level. Measures promotional spend impact on line-level revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the line level. Required for tax liability and jurisdiction-level compliance reporting."
    - name: "gross_margin_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(total AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of net line revenue. Key profitability ratio used in category reviews and vendor negotiations."
    - name: "line_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units that were shipped. Measures inventory availability and fulfilment effectiveness; low fill rate signals supply chain issues."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(returned_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped units that were returned. High return rates indicate product quality, sizing, or expectation issues requiring merchandising action."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cancelled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered units that were cancelled. Tracks demand leakage and inventory availability problems."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average selling price per unit across all lines. Used to monitor price realisation and markdown effectiveness."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across order lines. Used for tax burden analysis by jurisdiction and product category."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction KPIs for in-store performance management. Covers store revenue, basket size, tender mix, and void/return rates — the primary metrics for store operations and loss prevention."
  source: "`vibe_retail_v1`.`order`.`pos_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of POS transaction (e.g. sale, return, exchange, void). Used to segment revenue from returns and voids."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the POS transaction (e.g. completed, voided, suspended). Used to filter valid transactions for revenue reporting."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfilment method associated with the transaction (e.g. in-store, BOPIS, ship-from-store). Supports omnichannel store performance analysis."
    - name: "primary_payment_method"
      expr: primary_payment_method
      comment: "Primary tender type used in the transaction. Drives tender-mix analysis and payment processing cost management."
    - name: "business_date"
      expr: DATE_TRUNC('DAY', business_date)
      comment: "Fiscal business date of the transaction truncated to day. Primary time dimension for daily store sales reporting."
    - name: "business_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Fiscal business date truncated to month. Used for monthly store performance trending."
    - name: "manager_override_flag"
      expr: manager_override_flag
      comment: "Indicates whether a manager override was applied. High override rates are a loss-prevention signal requiring investigation."
    - name: "training_mode_flag"
      expr: training_mode_flag
      comment: "Indicates whether the transaction was recorded in training mode. Used to exclude training transactions from production metrics."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for return transactions. Used to analyse return drivers and inform product and policy decisions."
  measures:
    - name: "total_transactions"
      expr: COUNT(DISTINCT pos_transaction_id)
      comment: "Total number of distinct POS transactions. Baseline traffic and throughput metric for store operations."
    - name: "total_sales_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total transaction amount across all POS transactions. Primary in-store revenue KPI used in daily and weekly store performance reviews."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax subtotals. Used to isolate product revenue from tax in store P&L analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at POS. Required for tax remittance and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at POS. Measures in-store promotional spend and associate discount behaviour."
    - name: "total_tender_amount"
      expr: SUM(CAST(tender_amount AS DOUBLE))
      comment: "Total tender collected. Used to reconcile cash and payment processor settlements against sales."
    - name: "total_change_amount"
      expr: SUM(CAST(change_amount AS DOUBLE))
      comment: "Total change given to customers. Used in cash management and till reconciliation."
    - name: "total_units_sold"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total units sold across all POS transactions. Measures store throughput and is used in units-per-transaction analysis."
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction value (basket size in dollars). Core store KPI; declining ATV signals traffic quality or mix issues requiring management action."
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(total_quantity AS DOUBLE))
      comment: "Average units per transaction. Measures basket depth; used alongside ATV to diagnose revenue per visit trends."
    - name: "discount_penetration_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal at POS. High penetration signals excessive promotional dependency or associate discount abuse."
    - name: "manager_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN manager_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT pos_transaction_id), 0), 2)
      comment: "Percentage of transactions requiring a manager override. A loss-prevention KPI; elevated rates trigger audit and training interventions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_pos_transaction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "POS line-level product performance metrics. Provides SKU-level sales, margin, markdown, and return analysis for in-store merchandising decisions and category management."
  source: "`vibe_retail_v1`.`order`.`pos_transaction_line`"
  dimensions:
    - name: "department_code"
      expr: department_code
      comment: "Department code for the sold item. Primary dimension for department-level sales and margin analysis."
    - name: "category_code"
      expr: category_code
      comment: "Category code for the sold item. Used for category-level performance reporting and assortment decisions."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfilment method for the line (e.g. in-store, BOPIS). Used to segment sales by fulfilment channel."
    - name: "return_flag"
      expr: return_flag
      comment: "Indicates whether the line is a return. Used to separate sales from returns in revenue reporting."
    - name: "voided_flag"
      expr: voided_flag
      comment: "Indicates whether the line was voided. Used to exclude voided lines from revenue and to monitor void rates."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Indicates whether the item is a private-label product. Used to track private-label penetration and margin contribution."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for returned lines. Used to identify product quality and customer satisfaction issues."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line. Used for tax compliance and jurisdiction-level analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the sold quantity. Required for accurate volume aggregation across different UOMs."
  measures:
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total units sold at POS line level. Baseline volume metric for product and category performance."
    - name: "total_net_line_amount"
      expr: SUM(CAST(net_line_amount AS DOUBLE))
      comment: "Sum of net line amounts (after discounts, before tax). Represents net product revenue at the line level."
    - name: "total_line_amount"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Sum of total line amounts including tax. Used for gross revenue reporting at the line level."
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold at POS line level. Core input to in-store gross margin calculation."
    - name: "total_extended_price"
      expr: SUM(CAST(extended_price AS DOUBLE))
      comment: "Sum of extended prices (quantity × unit retail price) before markdowns. Used to measure gross sales before promotional adjustments."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown dollars applied at POS. Measures in-store markdown spend and its impact on margin."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the POS line level. Required for tax remittance and compliance."
    - name: "gross_margin_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(net_line_amount AS DOUBLE)) - SUM(CAST(cost_of_goods_sold AS DOUBLE))) / NULLIF(SUM(CAST(net_line_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of net line revenue at POS. Key profitability KPI for category and department management."
    - name: "markdown_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(markdown_amount AS DOUBLE)) / NULLIF(SUM(CAST(extended_price AS DOUBLE)), 0), 2)
      comment: "Markdown as a percentage of extended price. Measures in-store price reduction intensity; high rates signal clearance pressure or pricing strategy issues."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average selling price per unit at POS. Used to monitor price realisation and the impact of markdowns on average selling price."
    - name: "avg_weight_per_line"
      expr: AVG(CAST(weight_actual AS DOUBLE))
      comment: "Average actual weight per POS line. Used for weighted-item category analysis and shrinkage monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order cancellation KPIs covering cancellation volume, financial impact, refund processing, and fraud signals. Used by operations, finance, and loss prevention to manage cancellation risk and customer experience."
  source: "`vibe_retail_v1`.`order`.`cancellation`"
  dimensions:
    - name: "cancellation_status"
      expr: cancellation_status
      comment: "Current status of the cancellation (e.g. pending, approved, processed, reversed). Used to track cancellation pipeline health."
    - name: "initiator_type"
      expr: initiator_type
      comment: "Who initiated the cancellation (e.g. customer, associate, system, fraud). Critical for root-cause analysis of cancellation drivers."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the cancellation. Used to categorise and prioritise cancellation root causes for operational improvement."
    - name: "channel"
      expr: channel
      comment: "Channel through which the cancellation was initiated. Used to identify channel-specific cancellation patterns."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to process the refund (e.g. original payment, store credit, gift card). Used for refund liability and cash flow analysis."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the cancellation was flagged as potentially fraudulent. Used by loss prevention to monitor fraud-driven cancellation trends."
    - name: "refund_eligible_flag"
      expr: refund_eligible_flag
      comment: "Indicates whether the cancellation qualifies for a refund. Used to track refund liability exposure."
    - name: "cancellation_date"
      expr: DATE_TRUNC('DAY', cancellation_timestamp)
      comment: "Date of cancellation truncated to day. Primary time dimension for cancellation volume trending."
    - name: "stage"
      expr: stage
      comment: "Processing stage of the cancellation (e.g. pre-shipment, post-shipment, in-transit). Used to assess operational complexity and cost of cancellations."
  measures:
    - name: "total_cancellations"
      expr: COUNT(DISTINCT cancellation_id)
      comment: "Total number of distinct cancellations. Baseline volume metric for cancellation management and trend monitoring."
    - name: "total_cancelled_amount"
      expr: SUM(CAST(cancelled_amount AS DOUBLE))
      comment: "Total revenue value of cancelled orders. Measures revenue leakage from cancellations; a key metric for demand and revenue forecasting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund dollars issued for cancellations. Measures cash outflow from cancellations and informs refund liability management."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected on cancellations. Measures fee revenue that partially offsets cancellation processing costs."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total cancellation fees charged. Used to assess fee policy effectiveness in deterring unnecessary cancellations."
    - name: "avg_cancelled_amount"
      expr: AVG(CAST(cancelled_amount AS DOUBLE))
      comment: "Average cancelled order value. Used to understand the financial profile of cancellations and prioritise high-value recovery efforts."
    - name: "fraud_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT cancellation_id), 0), 2)
      comment: "Percentage of cancellations flagged as fraudulent. Loss-prevention KPI; elevated rates trigger fraud rule review and system intervention."
    - name: "refund_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(restocking_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(refund_amount AS DOUBLE)), 0), 2)
      comment: "Restocking fees as a percentage of refund amount. Measures how much of the refund cost is recovered through fees."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across cancellations. Used to monitor the overall fraud risk profile of the cancellation population."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing KPIs covering authorisation rates, fraud, refunds, and tender mix. Used by finance, treasury, and risk management to monitor payment health and optimise payment strategy."
  source: "`vibe_retail_v1`.`order`.`payment`"
  dimensions:
    - name: "payment_method_type"
      expr: method_type
      comment: "Type of payment method (e.g. credit_card, debit_card, wallet, gift_card, bnpl). Primary dimension for tender-mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. authorised, captured, refunded, voided, failed). Used to track payment pipeline health and failure rates."
    - name: "card_brand"
      expr: card_brand
      comment: "Card brand used for card payments (e.g. Visa, Mastercard, Amex). Used for interchange cost analysis and card-mix reporting."
    - name: "digital_wallet_type"
      expr: digital_wallet_type
      comment: "Digital wallet provider used (e.g. Apple Pay, Google Pay). Used to track wallet adoption and associated processing costs."
    - name: "bnpl_provider"
      expr: bnpl_provider
      comment: "Buy-now-pay-later provider used. Used to monitor BNPL adoption, associated fees, and default risk."
    - name: "fraud_decision"
      expr: fraud_decision
      comment: "Fraud screening decision for the payment (e.g. approved, declined, review). Used to monitor fraud prevention effectiveness."
    - name: "channel"
      expr: channel
      comment: "Channel through which the payment was made. Used to segment payment performance by sales channel."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO 4217 currency code for the payment. Required for multi-currency treasury and FX analysis."
    - name: "payment_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date the payment was created truncated to day. Primary time dimension for payment volume and revenue trending."
  measures:
    - name: "total_payments"
      expr: COUNT(DISTINCT payment_id)
      comment: "Total number of distinct payment records. Baseline volume metric for payment processing capacity and trend analysis."
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount collected. Represents gross cash collected and is a primary treasury and revenue metric."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued. Measures cash outflow from refunds; used in net revenue and cash flow analysis."
    - name: "net_payment_amount"
      expr: SUM((CAST(amount AS DOUBLE)) - (CAST(refund_amount AS DOUBLE)))
      comment: "Net payment amount after refunds. Represents actual cash retained and is the key treasury metric for settlement reconciliation."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to monitor payment size trends and detect anomalies."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across payments. Used to monitor the overall fraud risk profile of the payment population and calibrate fraud thresholds."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as a percentage of total payment amount. Measures refund burden on revenue; high rates signal product, fulfilment, or fraud issues."
    - name: "fraud_decline_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_decision = 'declined' THEN 1 END) / NULLIF(COUNT(DISTINCT payment_id), 0), 2)
      comment: "Percentage of payments declined due to fraud screening. Balances fraud prevention against false-positive customer friction; requires executive calibration."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount and promotion effectiveness KPIs. Measures promotional spend, discount depth, and approval compliance — used by merchandising, marketing, and finance to govern promotional investment and margin impact."
  source: "`vibe_retail_v1`.`order`.`discount`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (e.g. percentage, fixed amount, BOGO, loyalty). Used to segment promotional spend by discount mechanism."
    - name: "applied_at_level"
      expr: applied_at_level
      comment: "Level at which the discount was applied (e.g. order, line, category). Used to understand discount architecture and stacking behaviour."
    - name: "channel"
      expr: channel
      comment: "Channel through which the discount was applied. Used to compare promotional intensity across sales channels."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the discount (e.g. auto-approved, pending, approved, rejected). Used to monitor discount governance compliance."
    - name: "stackable_flag"
      expr: stackable_flag
      comment: "Indicates whether the discount can be stacked with other discounts. Used to analyse multi-discount order economics."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the discount. Used to categorise discount drivers (e.g. clearance, loyalty, competitive match)."
    - name: "discount_date"
      expr: DATE_TRUNC('DAY', applied_timestamp)
      comment: "Date the discount was applied truncated to day. Primary time dimension for promotional spend trending."
    - name: "valid_from_date"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month the discount became valid. Used to align promotional spend with campaign calendar periods."
  measures:
    - name: "total_discounts_applied"
      expr: COUNT(DISTINCT discount_id)
      comment: "Total number of distinct discounts applied. Baseline volume metric for promotional activity tracking."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total discount dollars applied. Primary promotional spend metric used in marketing ROI and margin impact analysis."
    - name: "total_original_price"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Sum of original prices before discounts. Used as the denominator for discount depth calculations."
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Sum of final prices after discounts. Represents net revenue after promotional adjustments."
    - name: "total_taxable_amount_adjustment"
      expr: SUM(CAST(taxable_amount_adjustment AS DOUBLE))
      comment: "Total taxable amount adjustment from discounts. Used for tax compliance to ensure discounts are correctly reflected in tax calculations."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average discount amount per discount record. Used to monitor discount generosity trends and compare across channels and campaigns."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average discount percentage applied. Measures average depth of promotional discounting; rising averages signal margin erosion risk."
    - name: "discount_depth_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(original_price AS DOUBLE)), 0), 2)
      comment: "Total discount as a percentage of original price. Measures overall promotional intensity; used in margin governance and promotional ROI reviews."
    - name: "price_realisation_pct"
      expr: ROUND(100.0 * SUM(CAST(final_price AS DOUBLE)) / NULLIF(SUM(CAST(original_price AS DOUBLE)), 0), 2)
      comment: "Final price as a percentage of original price. Measures how much of the listed price is actually realised after discounts; a key pricing effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_gift_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift card programme KPIs covering liability, redemption, reload activity, and escheatment risk. Used by finance and treasury to manage gift card liability and by marketing to assess programme health."
  source: "`vibe_retail_v1`.`order`.`gift_card`"
  dimensions:
    - name: "card_status"
      expr: card_status
      comment: "Current status of the gift card (e.g. active, redeemed, expired, blocked). Used to segment the gift card portfolio by lifecycle stage."
    - name: "card_type"
      expr: card_type
      comment: "Type of gift card (e.g. physical, digital, promotional). Used to analyse programme mix and associated costs."
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the gift card was issued (e.g. store, web, mobile). Used to track gift card issuance by channel."
    - name: "reloadable_flag"
      expr: reloadable_flag
      comment: "Indicates whether the card is reloadable. Used to segment liability between one-time and recurring gift card products."
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Indicates whether the card is eligible for escheatment. Used to manage regulatory compliance for unclaimed property."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the gift card. Required for multi-currency liability reporting."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the gift card was issued. Used for cohort-based liability and redemption analysis."
    - name: "program_code"
      expr: program_code
      comment: "Gift card programme code. Used to segment performance across different gift card programmes."
  measures:
    - name: "total_gift_cards"
      expr: COUNT(DISTINCT gift_card_id)
      comment: "Total number of distinct gift cards in the portfolio. Baseline metric for programme scale and liability exposure."
    - name: "total_initial_balance"
      expr: SUM(CAST(initial_balance AS DOUBLE))
      comment: "Total initial balance loaded across all gift cards. Represents gross gift card revenue and initial liability."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all active gift cards. Represents current gift card liability on the balance sheet; a critical finance metric."
    - name: "total_redeemed_amount"
      expr: SUM(CAST(total_redeemed_amount AS DOUBLE))
      comment: "Total amount redeemed across all gift cards. Measures gift card revenue conversion and programme utilisation."
    - name: "total_reloaded_amount"
      expr: SUM(CAST(total_reloaded_amount AS DOUBLE))
      comment: "Total amount reloaded onto reloadable gift cards. Measures the recurring revenue and loyalty value of the reloadable programme."
    - name: "total_fees_charged"
      expr: SUM(CAST(total_fees_charged AS DOUBLE))
      comment: "Total fees charged on gift cards (e.g. inactivity fees). Measures fee revenue and informs fee policy decisions."
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_redeemed_amount AS DOUBLE)) / NULLIF(SUM(CAST(initial_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of initial balance that has been redeemed. Measures programme utilisation; low rates indicate high breakage (unredeemed liability that may be recognised as revenue)."
    - name: "breakage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(current_balance AS DOUBLE)) / NULLIF(SUM(CAST(initial_balance AS DOUBLE)), 0), 2)
      comment: "Outstanding balance as a percentage of initial balance. Approximates breakage (unredeemed value); high breakage has revenue recognition and regulatory implications."
    - name: "avg_initial_balance"
      expr: AVG(CAST(initial_balance AS DOUBLE))
      comment: "Average initial balance per gift card. Used to monitor gift card denomination trends and programme economics."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_gift_card_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift card transaction-level KPIs covering transaction volume, balance movements, fraud, and escheatment. Used by finance and loss prevention to monitor gift card programme integrity and liability movements."
  source: "`vibe_retail_v1`.`order`.`gift_card_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of gift card transaction (e.g. activation, redemption, reload, void, escheatment). Used to segment transaction volume by activity type."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the gift card transaction (e.g. completed, reversed, pending). Used to filter valid transactions for financial reporting."
    - name: "channel"
      expr: channel
      comment: "Channel through which the transaction occurred. Used to analyse gift card usage patterns by channel."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the transaction was reversed. Used to monitor reversal rates and identify potential fraud or processing errors."
    - name: "escheatment_flag"
      expr: escheatment_flag
      comment: "Indicates whether the transaction is related to escheatment. Used for unclaimed property compliance reporting."
    - name: "fraud_decision"
      expr: fraud_decision
      comment: "Fraud screening decision for the transaction. Used to monitor gift card fraud patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction. Required for multi-currency liability and revenue reporting."
    - name: "business_date"
      expr: DATE_TRUNC('DAY', business_date)
      comment: "Business date of the transaction truncated to day. Primary time dimension for daily gift card activity reporting."
  measures:
    - name: "total_transactions"
      expr: COUNT(DISTINCT gift_card_transaction_id)
      comment: "Total number of distinct gift card transactions. Baseline volume metric for programme activity monitoring."
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total amount transacted across all gift card transactions. Measures gross gift card activity and liability movement."
    - name: "total_activation_fee_amount"
      expr: SUM(CAST(activation_fee_amount AS DOUBLE))
      comment: "Total activation fees collected. Measures fee revenue from gift card activations."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average gift card transaction amount. Used to monitor transaction size trends and detect anomalies."
    - name: "avg_balance_after"
      expr: AVG(CAST(balance_after AS DOUBLE))
      comment: "Average gift card balance after transactions. Used to monitor the health of the gift card portfolio and remaining liability."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across gift card transactions. Used to monitor fraud risk in the gift card programme."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT gift_card_transaction_id), 0), 2)
      comment: "Percentage of gift card transactions that were reversed. High reversal rates signal fraud or processing issues requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription programme KPIs covering recurring revenue, churn, delivery performance, and discount economics. Used by e-commerce and finance leadership to manage subscription growth, retention, and profitability."
  source: "`vibe_retail_v1`.`order`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (e.g. active, paused, cancelled, expired). Primary dimension for subscription lifecycle analysis."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g. replenishment, curated box, service). Used to segment recurring revenue by subscription model."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency of the subscription (e.g. weekly, monthly, quarterly). Used to model recurring revenue cadence."
    - name: "channel"
      expr: channel
      comment: "Channel through which the subscription was acquired. Used to assess channel-level subscription acquisition and retention."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the subscription auto-renews. Used to forecast renewal revenue and identify at-risk subscriptions."
    - name: "gift_subscription_flag"
      expr: gift_subscription_flag
      comment: "Indicates whether the subscription is a gift. Used to segment gift vs. self-purchased subscriptions for retention analysis."
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for subscription cancellation. Used to diagnose churn drivers and inform retention strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subscription. Required for multi-currency recurring revenue reporting."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the subscription started. Used for cohort-based retention and lifetime value analysis."
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Delivery frequency of the subscription (e.g. weekly, bi-weekly, monthly). Used to model delivery volume and fulfilment capacity."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total number of distinct subscriptions. Baseline metric for subscription programme scale and growth tracking."
    - name: "active_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'active' THEN 1 END)
      comment: "Number of currently active subscriptions. Core metric for recurring revenue base and subscriber growth reporting."
    - name: "cancelled_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled subscriptions. Used to measure churn volume and inform retention investment decisions."
    - name: "total_subscription_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total subscription revenue across all subscriptions. Primary recurring revenue KPI for subscription business performance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied to subscriptions. Measures promotional investment in subscriber acquisition and retention."
    - name: "avg_subscription_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average subscription value. Used to monitor average recurring revenue per subscriber and track pricing strategy effectiveness."
    - name: "avg_discount_per_subscription"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per subscription. Used to assess the cost of subscriber acquisition and retention incentives."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled. Primary churn KPI; rising cancellation rates trigger retention programme review and investment."
    - name: "discount_penetration_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subscription revenue. Measures the cost of promotional incentives relative to recurring revenue generated."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_promise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery promise accuracy and SLA compliance KPIs. Used by supply chain, fulfilment, and customer experience leadership to monitor promise quality, SLA breach rates, and the accuracy of delivery date commitments."
  source: "`vibe_retail_v1`.`order`.`promise`"
  dimensions:
    - name: "promise_type"
      expr: promise_type
      comment: "Type of delivery promise (e.g. standard, express, same-day). Used to segment SLA performance by service level."
    - name: "promise_status"
      expr: promise_status
      comment: "Current status of the promise (e.g. active, met, breached, revised). Used to track promise lifecycle and SLA compliance."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfilment method associated with the promise (e.g. ship, BOPIS, same-day). Used to compare promise accuracy across fulfilment methods."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the order was placed. Used to analyse promise accuracy by sales channel."
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Carrier service level used for the promise (e.g. ground, 2-day, overnight). Used to assess carrier-level SLA performance."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the promise SLA was breached. Primary flag for SLA compliance monitoring and customer experience impact assessment."
    - name: "accuracy_flag"
      expr: accuracy_flag
      comment: "Indicates whether the promise was accurate (actual delivery matched promised date). Used to measure promise accuracy rate."
    - name: "peak_season_flag"
      expr: peak_season_flag
      comment: "Indicates whether the promise was made during peak season. Used to compare promise accuracy in peak vs. non-peak periods."
    - name: "weather_impact_flag"
      expr: weather_impact_flag
      comment: "Indicates whether weather impacted the promise. Used to isolate weather-related SLA breaches from operational failures."
    - name: "promise_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the promise was created. Used for monthly SLA compliance trending."
  measures:
    - name: "total_promises"
      expr: COUNT(DISTINCT promise_id)
      comment: "Total number of distinct delivery promises made. Baseline volume metric for promise engine activity."
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Total number of SLA breaches. Measures fulfilment failure volume; directly linked to customer satisfaction and compensation costs."
    - name: "total_accurate_promises"
      expr: COUNT(CASE WHEN accuracy_flag = TRUE THEN 1 END)
      comment: "Total number of promises that were accurate. Used to calculate promise accuracy rate."
    - name: "total_variance_hours"
      expr: SUM(CAST(variance_hours AS DOUBLE))
      comment: "Total variance hours between promised and actual delivery. Measures the aggregate delivery delay burden on customers."
    - name: "avg_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average delivery variance in hours (actual vs. promised). Key SLA quality metric; positive values indicate late deliveries requiring carrier or node intervention."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of delivery promises. Measures the promise engine's self-assessed accuracy; low scores indicate model calibration issues."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT promise_id), 0), 2)
      comment: "Percentage of promises that resulted in an SLA breach. Primary customer experience KPI; high breach rates trigger carrier review and fulfilment network investment."
    - name: "promise_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accuracy_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT promise_id), 0), 2)
      comment: "Percentage of promises that were accurate. Measures the reliability of delivery date commitments; a key trust and NPS driver."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order hold management KPIs covering hold volume, fraud signals, SLA compliance, and resolution effectiveness. Used by operations and loss prevention to manage order risk and minimise customer impact from holds."
  source: "`vibe_retail_v1`.`order`.`hold`"
  dimensions:
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold applied (e.g. fraud, payment, inventory, compliance). Used to categorise hold volume by root cause."
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g. active, released, escalated, expired). Used to track hold pipeline and resolution progress."
    - name: "fraud_decision"
      expr: fraud_decision
      comment: "Fraud screening decision associated with the hold. Used to measure fraud-driven hold rates and false-positive impact."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the hold exceeded its SLA target. Used to measure hold resolution timeliness and customer experience impact."
    - name: "manual_review_required_flag"
      expr: manual_review_required_flag
      comment: "Indicates whether the hold requires manual review. Used to measure analyst workload and automation opportunity."
    - name: "auto_release_eligible_flag"
      expr: auto_release_eligible_flag
      comment: "Indicates whether the hold is eligible for automatic release. Used to track automation coverage and reduce manual intervention."
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the hold (e.g. released, cancelled, escalated). Used to analyse hold resolution patterns."
    - name: "hold_date"
      expr: DATE_TRUNC('DAY', start_timestamp)
      comment: "Date the hold was placed truncated to day. Primary time dimension for hold volume trending."
  measures:
    - name: "total_holds"
      expr: COUNT(DISTINCT hold_id)
      comment: "Total number of distinct order holds. Baseline metric for hold volume and operational workload."
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Total number of holds that breached their SLA. Measures hold resolution failures and their customer experience impact."
    - name: "total_fraud_holds"
      expr: COUNT(CASE WHEN hold_type = 'fraud' THEN 1 END)
      comment: "Total number of fraud-related holds. Measures fraud screening activity and its operational impact on order flow."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across held orders. Used to monitor the fraud risk profile of held orders and calibrate fraud thresholds."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT hold_id), 0), 2)
      comment: "Percentage of holds that breached their SLA. Measures hold resolution timeliness; high rates indicate staffing or process issues in the review queue."
    - name: "auto_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_release_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT hold_id), 0), 2)
      comment: "Percentage of holds eligible for automatic release. Measures automation coverage; increasing this rate reduces manual review costs."
    - name: "manual_review_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN manual_review_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT hold_id), 0), 2)
      comment: "Percentage of holds requiring manual review. Measures analyst workload and the cost of fraud/risk screening operations."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order status transition and SLA compliance KPIs. Used by operations and customer experience teams to monitor order lifecycle velocity, exception rates, and SLA adherence across the order fulfilment process."
  source: "`vibe_retail_v1`.`order`.`status_history`"
  dimensions:
    - name: "status_code"
      expr: status_code
      comment: "Current order status code. Used to analyse order volume distribution across lifecycle stages."
    - name: "previous_status_code"
      expr: previous_status_code
      comment: "Previous order status code. Used to analyse status transition patterns and identify bottlenecks in the order lifecycle."
    - name: "order_type"
      expr: order_type
      comment: "Type of order associated with the status event. Used to segment status history by order class."
    - name: "source_order_channel"
      expr: source_order_channel
      comment: "Channel from which the order originated. Used to compare lifecycle velocity and exception rates across channels."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates whether the status event is associated with an exception. Used to measure exception rates in the order lifecycle."
    - name: "exception_category"
      expr: exception_category
      comment: "Category of the exception (e.g. carrier delay, inventory shortage, payment failure). Used to diagnose root causes of order exceptions."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the status transition breached its SLA. Used to measure SLA compliance across the order lifecycle."
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month of the status transition. Used for monthly SLA compliance and exception rate trending."
  measures:
    - name: "total_status_events"
      expr: COUNT(DISTINCT status_history_id)
      comment: "Total number of distinct order status events. Baseline metric for order lifecycle activity volume."
    - name: "total_exceptions"
      expr: COUNT(CASE WHEN exception_flag = TRUE THEN 1 END)
      comment: "Total number of order status events flagged as exceptions. Measures operational disruption volume in the order lifecycle."
    - name: "total_sla_breaches"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Total number of status transitions that breached their SLA. Measures fulfilment SLA compliance failures."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT status_history_id), 0), 2)
      comment: "Percentage of order status events that are exceptions. Measures operational quality; high exception rates signal systemic fulfilment or carrier issues."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT status_history_id), 0), 2)
      comment: "Percentage of status transitions that breached their SLA. Primary order lifecycle SLA KPI used in operations reviews."
    - name: "notification_sent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_notification_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(DISTINCT status_history_id), 0), 2)
      comment: "Percentage of status events where a customer notification was sent. Measures proactive communication coverage; low rates indicate gaps in customer experience."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_line_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line Status History business metrics"
  source: "`vibe_retail_v1`.`order`.`line_status_history`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Carrier Service Level"
      expr: carrier_service_level
    - name: "Current Status"
      expr: current_status
    - name: "Estimated Delivery Date"
      expr: estimated_delivery_date
    - name: "Exception Category"
      expr: exception_category
    - name: "Exception Flag"
      expr: exception_flag
    - name: "Fulfillment Node Type"
      expr: fulfillment_node_type
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Notes"
      expr: notes
    - name: "Previous Status"
      expr: previous_status
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Sku"
      expr: sku
    - name: "Sla Met Flag"
      expr: sla_met_flag
    - name: "Sla Target Timestamp"
      expr: sla_target_timestamp
    - name: "Status Reason Code"
      expr: status_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Line Status History"
      expr: COUNT(DISTINCT line_status_history_id)
    - name: "Total Quantity Affected"
      expr: SUM(quantity_affected)
    - name: "Average Quantity Affected"
      expr: AVG(quantity_affected)
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`order_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Line business metrics"
  source: "`vibe_retail_v1`.`order`.`order_line`"
  dimensions:
    - name: "Actual Ship Date"
      expr: actual_ship_date
    - name: "Backorder Flag"
      expr: backorder_flag
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expected Ship Date"
      expr: expected_ship_date
    - name: "Fulfillment Method"
      expr: fulfillment_method
    - name: "Gift Flag"
      expr: gift_flag
    - name: "Gift Message"
      expr: gift_message
    - name: "Gtin"
      expr: gtin
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Original Sku"
      expr: original_sku
    - name: "Personalization Notes"
      expr: personalization_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Line"
      expr: COUNT(DISTINCT order_line_id)
    - name: "Total Cancelled Quantity"
      expr: SUM(cancelled_quantity)
    - name: "Average Cancelled Quantity"
      expr: AVG(cancelled_quantity)
    - name: "Total Cost Of Goods Sold"
      expr: SUM(cost_of_goods_sold)
    - name: "Average Cost Of Goods Sold"
      expr: AVG(cost_of_goods_sold)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Extended Price"
      expr: SUM(extended_price)
    - name: "Average Extended Price"
      expr: AVG(extended_price)
    - name: "Total Margin Amount"
      expr: SUM(margin_amount)
    - name: "Average Margin Amount"
      expr: AVG(margin_amount)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Returned Quantity"
      expr: SUM(returned_quantity)
    - name: "Average Returned Quantity"
      expr: AVG(returned_quantity)
    - name: "Total Shipped Quantity"
      expr: SUM(shipped_quantity)
    - name: "Average Shipped Quantity"
      expr: AVG(shipped_quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Total"
      expr: SUM(total)
    - name: "Average Total"
      expr: AVG(total)
    - name: "Total Unit Retail Price"
      expr: SUM(unit_retail_price)
    - name: "Average Unit Retail Price"
      expr: AVG(unit_retail_price)
$$;