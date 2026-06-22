-- Metric views for domain: order | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 17:03:36

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_guest_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs covering revenue, discounting, tipping, tax, and order mix. Primary steering dashboard for restaurant GMs, ops VPs, and finance teams."
  source: "`vibe_restaurants_v1`.`order`.`guest_order`"
  filter: is_voided = False
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the guest order (e.g. placed, fulfilled, cancelled). Used to slice KPIs by order completion state."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g. dine-in, takeout, delivery, drive-thru). Critical for channel-mix and operational analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period (e.g. breakfast, lunch, dinner, late-night). Enables daypart-level revenue and traffic analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the order. Supports multi-currency reporting."
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender used (e.g. cash, credit, mobile pay). Informs payment mix and fraud risk analysis."
    - name: "delivery_provider"
      expr: delivery_provider
      comment: "Third-party delivery platform (e.g. DoorDash, Uber Eats). Used to evaluate third-party channel performance and commission exposure."
    - name: "is_lto"
      expr: is_lto
      comment: "Indicates whether the order included a limited-time offer item. Used to measure LTO campaign lift."
    - name: "placed_date"
      expr: DATE(placed_at)
      comment: "Calendar date the order was placed. Primary time dimension for daily trend analysis."
    - name: "placed_month"
      expr: DATE_TRUNC('MONTH', placed_at)
      comment: "Month the order was placed. Used for monthly revenue and traffic trending."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier. Enables location-level performance benchmarking."
    - name: "channel_id"
      expr: channel_id
      comment: "Sales channel identifier. Used to attribute orders and revenue to specific ordering channels."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of non-voided guest orders. Primary traffic KPI used by ops and finance to track guest visit volume."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of total order amounts including tax and tip. Top-line revenue KPI for financial reporting and P&L steering."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-tip order subtotals. Used to measure net food and beverage revenue before tax effects."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied across all orders. Tracks promotional spend and discount liability for margin management."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax remittance reconciliation and compliance reporting."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected. Informs labor cost allocation and employee compensation analysis."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total order value (AOV). Core KPI for menu engineering, upsell effectiveness, and revenue-per-visit benchmarking."
    - name: "avg_subtotal_per_order"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average pre-tax subtotal per order. Used alongside AOV to isolate food revenue contribution per visit."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per order. Measures promotional intensity and its impact on net revenue per transaction."
    - name: "avg_tip_per_order"
      expr: AVG(CAST(tip_amount AS DOUBLE))
      comment: "Average tip per order. Tracks guest generosity trends and informs server performance and compensation benchmarking."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled orders. Tracks operational failure and guest experience risk; high cancellation rates trigger operational intervention."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level sales, margin, waste, and refund KPIs. Drives menu engineering, COGS management, and product mix decisions for culinary and finance teams."
  source: "`vibe_restaurants_v1`.`order`.`order_item`"
  dimensions:
    - name: "daypart_code"
      expr: daypart_code
      comment: "Meal period code for the order item. Enables daypart-level product mix and revenue analysis."
    - name: "service_channel"
      expr: service_channel
      comment: "Channel through which the item was ordered (e.g. POS, kiosk, mobile). Used for channel-level product performance analysis."
    - name: "pmix_category"
      expr: pmix_category
      comment: "Product mix category for the item. Core dimension for menu engineering and category-level sales analysis."
    - name: "is_combo_component"
      expr: is_combo_component
      comment: "Indicates whether the item is part of a combo meal. Used to measure combo attachment rates and bundle revenue."
    - name: "is_lto"
      expr: is_lto
      comment: "Indicates whether the item is a limited-time offer. Used to measure LTO sales velocity and campaign ROI."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the order item (e.g. prepared, voided, refunded). Used to filter and segment item-level KPIs."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Indicates whether the item was refunded. Used to isolate refunded items for quality and loss analysis."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Indicates whether the item was wasted. Used to track food waste incidence for cost and sustainability reporting."
    - name: "waste_reason_code"
      expr: waste_reason_code
      comment: "Reason code for item waste. Enables root-cause analysis of food waste by category."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the item transaction. Supports multi-currency reporting."
    - name: "created_date"
      expr: DATE(created_timestamp)
      comment: "Date the order item was created. Primary time dimension for daily item-level trend analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the order item was created. Used for monthly product mix and revenue trending."
  measures:
    - name: "total_items_sold"
      expr: COUNT(1)
      comment: "Total number of order items sold. Core product volume KPI for menu engineering and demand forecasting."
    - name: "total_gross_item_revenue"
      expr: SUM(CAST(line_gross_amount AS DOUBLE))
      comment: "Sum of gross line amounts before discounts. Measures top-line item revenue contribution for menu performance analysis."
    - name: "total_net_item_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Sum of net line amounts after discounts. Core item-level revenue KPI for P&L and menu profitability analysis."
    - name: "total_item_cogs"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of goods sold at the item level. Drives gross margin analysis and food cost management decisions."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount dollars applied at the line item level. Measures promotional discount depth by product."
    - name: "total_item_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the item level. Supports tax compliance and item-level tax rate validation."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund dollars issued at the item level. Tracks quality failures and their direct revenue impact."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items sold. Used for demand planning, inventory forecasting, and product velocity ranking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price per item record. Used to monitor price realization and detect pricing anomalies."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average COGS per item record. Benchmarks cost efficiency across menu items and categories."
    - name: "waste_item_count"
      expr: COUNT(CASE WHEN waste_flag = True THEN 1 END)
      comment: "Count of wasted items. Tracks food waste volume for sustainability and cost reduction initiatives."
    - name: "refunded_item_count"
      expr: COUNT(CASE WHEN refund_flag = True THEN 1 END)
      comment: "Count of refunded items. Measures quality and service failure frequency at the item level."
    - name: "total_modifier_revenue"
      expr: SUM(CAST(modifier_price AS DOUBLE))
      comment: "Total revenue from item modifiers (add-ons, customizations). Measures upsell and customization revenue contribution."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction KPIs covering tender mix, tip collection, interchange costs, split tender, and refund activity. Used by finance and treasury for cash management and payment optimization."
  source: "`vibe_restaurants_v1`.`order`.`payment`"
  filter: is_voided = False
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender type (e.g. cash, credit card, gift card, mobile pay). Core dimension for payment mix analysis."
    - name: "card_type"
      expr: card_type
      comment: "Card network type (e.g. Visa, Mastercard, Amex). Used to analyze interchange cost exposure by card brand."
    - name: "card_entry_method"
      expr: card_entry_method
      comment: "How the card was entered (e.g. swipe, chip, tap, manual). Informs fraud risk and PCI compliance analysis."
    - name: "processor_name"
      expr: processor_name
      comment: "Payment processor used for the transaction. Used to evaluate processor performance and cost benchmarking."
    - name: "channel"
      expr: channel
      comment: "Sales channel associated with the payment. Enables channel-level payment and revenue reconciliation."
    - name: "daypart"
      expr: daypart
      comment: "Meal period for the payment transaction. Used for daypart-level revenue and tender mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the payment. Supports multi-currency financial reporting."
    - name: "is_split_tender"
      expr: is_split_tender
      comment: "Indicates whether the payment was part of a split tender transaction. Used to measure split-pay frequency and complexity."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the payment was settled. Used for cash flow and settlement reconciliation reporting."
    - name: "captured_date"
      expr: DATE(captured_timestamp)
      comment: "Date the payment was captured. Primary time dimension for daily payment volume and revenue trending."
    - name: "captured_month"
      expr: DATE_TRUNC('MONTH', captured_timestamp)
      comment: "Month the payment was captured. Used for monthly financial close and revenue reconciliation."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier. Enables location-level payment and revenue analysis."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of non-voided payment transactions. Baseline volume KPI for payment operations monitoring."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount applied to orders. Primary revenue collection KPI for financial close and treasury management."
    - name: "total_tendered_amount"
      expr: SUM(CAST(tendered_amount AS DOUBLE))
      comment: "Total amount tendered by guests. Used alongside applied amount to calculate change-due liability and cash handling accuracy."
    - name: "total_tip_collected"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected via payment. Informs tip pooling, labor cost allocation, and employee compensation."
    - name: "total_interchange_fees"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees paid to card networks. Directly impacts payment processing cost and net revenue; used to optimize tender mix."
    - name: "total_discount_applied"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied at the payment level. Used to reconcile promotional spend against payment records."
    - name: "total_change_due"
      expr: SUM(CAST(change_due_amount AS DOUBLE))
      comment: "Total change due to guests. Monitors cash handling accuracy and over-tendering patterns at the unit level."
    - name: "avg_payment_amount"
      expr: AVG(CAST(applied_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to benchmark transaction size and detect anomalies in payment processing."
    - name: "avg_tip_per_payment"
      expr: AVG(CAST(tip_amount AS DOUBLE))
      comment: "Average tip per payment transaction. Tracks guest tipping behavior and informs service quality benchmarking."
    - name: "split_tender_count"
      expr: COUNT(CASE WHEN is_split_tender = True THEN 1 END)
      comment: "Count of split-tender payment transactions. Measures payment complexity and its operational impact on throughput."
    - name: "distinct_orders_paid"
      expr: COUNT(DISTINCT guest_order_id)
      comment: "Count of distinct orders with at least one payment. Used to reconcile payment records against order records for financial integrity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund KPIs tracking refund volume, dollar impact, fraud risk, and guest experience signals. Used by ops, finance, and guest experience teams to manage quality and loss prevention."
  source: "`vibe_restaurants_v1`.`order`.`refund`"
  filter: is_voided = False
  dimensions:
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund issued (e.g. full, partial, item-level). Used to categorize refund liability and root-cause analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the refund. Primary dimension for root-cause analysis of quality and service failures."
    - name: "refund_status"
      expr: refund_status
      comment: "Current processing status of the refund. Used to track refund pipeline and identify processing bottlenecks."
    - name: "method"
      expr: method
      comment: "Refund method (e.g. original payment method, cash, gift card). Used to analyze refund channel mix and cash exposure."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the original order was placed. Used to identify which channels generate the most refund activity."
    - name: "daypart"
      expr: daypart
      comment: "Meal period associated with the refunded order. Used to identify daypart-level quality issues."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the refund. Supports multi-currency financial reporting."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Indicates whether the refund was flagged as fraudulent. Used for fraud loss monitoring and prevention program evaluation."
    - name: "csat_impact_flag"
      expr: csat_impact_flag
      comment: "Indicates whether the refund had a customer satisfaction impact. Links operational failures to guest experience outcomes."
    - name: "refunded_date"
      expr: DATE(refunded_at)
      comment: "Date the refund was processed. Primary time dimension for daily refund trend analysis."
    - name: "refunded_month"
      expr: DATE_TRUNC('MONTH', refunded_at)
      comment: "Month the refund was processed. Used for monthly financial close and refund liability reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier. Enables location-level refund performance benchmarking."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refunds issued. Baseline refund volume KPI for quality and loss prevention monitoring."
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of refunds issued. Primary financial KPI for refund liability management and P&L impact assessment."
    - name: "total_refund_subtotal"
      expr: SUM(CAST(subtotal AS DOUBLE))
      comment: "Total pre-tax refund subtotal. Used to isolate food and beverage refund exposure from tax effects."
    - name: "total_refund_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax refunded. Required for tax remittance adjustments and compliance reconciliation."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction. Used to benchmark refund severity and detect unusual refund patterns."
    - name: "fraudulent_refund_count"
      expr: COUNT(CASE WHEN is_fraudulent = True THEN 1 END)
      comment: "Count of refunds flagged as fraudulent. Core fraud loss KPI for loss prevention and risk management teams."
    - name: "fraudulent_refund_amount"
      expr: SUM(CASE WHEN is_fraudulent = True THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of fraudulent refunds. Measures financial exposure from refund fraud for loss prevention investment decisions."
    - name: "csat_impacted_refund_count"
      expr: COUNT(CASE WHEN csat_impact_flag = True THEN 1 END)
      comment: "Count of refunds with a guest satisfaction impact. Links operational failures to guest experience degradation for service recovery prioritization."
    - name: "distinct_orders_refunded"
      expr: COUNT(DISTINCT guest_order_id)
      comment: "Count of distinct orders that received a refund. Used to calculate order-level refund rate when combined with total order counts."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery operations KPIs covering delivery time performance, distance, fees, platform commissions, and guest ratings. Used by ops and third-party channel managers to optimize delivery efficiency and profitability."
  source: "`vibe_restaurants_v1`.`order`.`delivery_order`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. dispatched, delivered, failed). Used to monitor delivery pipeline health."
    - name: "delivery_city"
      expr: delivery_city
      comment: "City of the delivery address. Used for geographic delivery performance analysis."
    - name: "delivery_state_province"
      expr: delivery_state_province
      comment: "State or province of the delivery address. Used for regional delivery performance benchmarking."
    - name: "delivery_exception_type"
      expr: delivery_exception_type
      comment: "Type of delivery exception encountered (e.g. late, wrong address, no-show). Used for root-cause analysis of delivery failures."
    - name: "is_contactless_delivery"
      expr: is_contactless_delivery
      comment: "Indicates whether the delivery was contactless. Used to track contactless adoption and its impact on delivery ratings."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the delivery transaction. Supports multi-currency reporting."
    - name: "order_placed_date"
      expr: DATE(order_placed_timestamp)
      comment: "Date the delivery order was placed. Primary time dimension for daily delivery volume and performance trending."
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the delivery order was placed. Used for monthly delivery channel performance reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier. Enables location-level delivery performance benchmarking."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of delivery orders. Baseline delivery volume KPI for channel capacity and demand planning."
    - name: "total_delivery_fees"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Total delivery fees collected. Measures delivery fee revenue contribution and its offset against delivery costs."
    - name: "total_platform_commission"
      expr: SUM(CAST(platform_commission_amount AS DOUBLE))
      comment: "Total platform commission paid to third-party delivery providers. Core cost KPI for evaluating third-party channel profitability."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected on delivery orders. Informs driver compensation and delivery channel guest satisfaction."
    - name: "avg_delivery_distance_km"
      expr: AVG(CAST(delivery_distance_km AS DOUBLE))
      comment: "Average delivery distance in kilometers. Used to optimize delivery zone sizing and estimate delivery cost per order."
    - name: "avg_total_ticket_time_minutes"
      expr: AVG(CAST(total_ticket_time_minutes AS DOUBLE))
      comment: "Average total ticket time from order placement to delivery completion. Primary delivery speed KPI for SLA management and guest satisfaction."
    - name: "avg_platform_commission_rate"
      expr: AVG(CAST(platform_commission_rate AS DOUBLE))
      comment: "Average platform commission rate across delivery orders. Used to benchmark and negotiate third-party delivery partner contracts."
    - name: "avg_delivery_fee"
      expr: AVG(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Average delivery fee per order. Used to evaluate delivery fee pricing strategy and guest price sensitivity."
    - name: "avg_customer_feedback_score"
      expr: AVG(CAST(customer_feedback AS DOUBLE))
      comment: "Average customer feedback score on delivery orders. Tracks delivery experience quality and its trend over time for service improvement."
    - name: "delivery_exception_count"
      expr: COUNT(CASE WHEN delivery_exception_type IS NOT NULL THEN 1 END)
      comment: "Count of deliveries with an exception. Measures delivery failure frequency for operational quality management."
    - name: "distinct_delivery_zones"
      expr: COUNT(DISTINCT delivery_postal_code)
      comment: "Count of distinct postal codes served by delivery. Measures delivery geographic reach and zone coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_kds_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen Display System (KDS) throughput and speed-of-service KPIs. Used by kitchen managers and ops teams to monitor kitchen efficiency, SOS compliance, and re-fire rates."
  source: "`vibe_restaurants_v1`.`order`.`kds_ticket`"
  filter: void_flag = False
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the KDS ticket (e.g. pending, in-progress, completed, voided). Used to monitor kitchen queue health."
    - name: "daypart"
      expr: daypart
      comment: "Meal period for the KDS ticket. Enables daypart-level kitchen throughput and SOS analysis."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel that originated the order. Used to analyze kitchen load and SOS performance by ordering channel."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the KDS ticket. Used to analyze how priority routing affects kitchen throughput."
    - name: "sos_met_flag"
      expr: sos_met_flag
      comment: "Indicates whether the speed-of-service target was met. Core SOS compliance dimension for kitchen performance reporting."
    - name: "re_fire_flag"
      expr: re_fire_flag
      comment: "Indicates whether the ticket was re-fired. Used to track kitchen quality failures requiring order re-preparation."
    - name: "re_fire_reason"
      expr: re_fire_reason
      comment: "Reason the ticket was re-fired. Used for root-cause analysis of kitchen quality failures."
    - name: "ticket_created_date"
      expr: DATE(ticket_created_timestamp)
      comment: "Date the KDS ticket was created. Primary time dimension for daily kitchen throughput trending."
    - name: "ticket_created_month"
      expr: DATE_TRUNC('MONTH', ticket_created_timestamp)
      comment: "Month the KDS ticket was created. Used for monthly kitchen performance and SOS compliance reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier. Enables location-level kitchen performance benchmarking."
    - name: "kitchen_station_id"
      expr: kitchen_station_id
      comment: "Kitchen station identifier. Used to analyze throughput and SOS compliance at the station level."
  measures:
    - name: "total_kds_tickets"
      expr: COUNT(1)
      comment: "Total number of non-voided KDS tickets. Baseline kitchen throughput volume KPI for capacity and staffing decisions."
    - name: "sos_compliant_ticket_count"
      expr: COUNT(CASE WHEN sos_met_flag = True THEN 1 END)
      comment: "Count of tickets where the speed-of-service target was met. Measures kitchen SOS compliance for operational performance management."
    - name: "sos_breach_ticket_count"
      expr: COUNT(CASE WHEN sos_met_flag = False THEN 1 END)
      comment: "Count of tickets where the speed-of-service target was breached. Tracks SOS failures that drive guest dissatisfaction and operational intervention."
    - name: "re_fire_ticket_count"
      expr: COUNT(CASE WHEN re_fire_flag = True THEN 1 END)
      comment: "Count of re-fired tickets. Measures kitchen quality failure frequency and its impact on throughput and food cost."
    - name: "distinct_orders_in_kitchen"
      expr: COUNT(DISTINCT guest_order_id)
      comment: "Count of distinct guest orders processed through the KDS. Used to reconcile kitchen throughput against order volume."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_catering_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catering order KPIs covering revenue, deposit collection, gratuity, tax, and fulfillment performance. Used by catering sales and ops teams to manage large-event revenue and execution quality."
  source: "`vibe_restaurants_v1`.`order`.`catering_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the catering order (e.g. confirmed, fulfilled, cancelled). Used to monitor catering pipeline health."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment mode for the catering order (e.g. delivery, pickup, on-site). Used to analyze catering channel mix and logistics costs."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the catering order. Used to track outstanding balances and collections pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the catering order. Supports multi-currency catering revenue reporting."
    - name: "delivery_city"
      expr: delivery_city
      comment: "City of the catering delivery address. Used for geographic catering demand analysis."
    - name: "delivery_state_province"
      expr: delivery_state_province
      comment: "State or province of the catering delivery. Used for regional catering revenue and demand analysis."
    - name: "setup_required"
      expr: setup_required
      comment: "Indicates whether on-site setup is required. Used to estimate labor and logistics costs for catering fulfillment."
    - name: "event_date"
      expr: event_date
      comment: "Date of the catering event. Primary time dimension for catering revenue forecasting and capacity planning."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_start_time)
      comment: "Month of the catering event. Used for monthly catering revenue forecasting and pipeline reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit fulfilling the catering order. Enables unit-level catering revenue and capacity analysis."
  measures:
    - name: "total_catering_orders"
      expr: COUNT(1)
      comment: "Total number of catering orders. Baseline catering volume KPI for sales pipeline and capacity planning."
    - name: "total_catering_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total catering order revenue. Primary top-line KPI for catering channel P&L and sales performance management."
    - name: "total_quoted_price"
      expr: SUM(CAST(quoted_price AS DOUBLE))
      comment: "Total quoted price across catering orders. Used to measure price realization and discount-to-quote variance."
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected on catering orders. Tracks cash flow from catering bookings and deposit collection compliance."
    - name: "total_balance_due"
      expr: SUM(CAST(balance_due AS DOUBLE))
      comment: "Total outstanding balance due on catering orders. Measures accounts receivable exposure from catering channel."
    - name: "total_gratuity_collected"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on catering orders. Informs catering staff compensation and event profitability analysis."
    - name: "total_catering_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on catering orders. Required for tax remittance and catering-specific tax compliance reporting."
    - name: "avg_catering_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average catering order value. Used to benchmark catering deal size and evaluate sales team performance."
    - name: "avg_quoted_price"
      expr: AVG(CAST(quoted_price AS DOUBLE))
      comment: "Average quoted price per catering order. Used to monitor pricing consistency and identify under-pricing patterns."
    - name: "cancelled_catering_orders"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled catering orders. Tracks catering cancellation risk and its revenue impact for pipeline management."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order lifecycle and speed-of-service event KPIs. Used by ops teams to monitor SOS compliance, cancellation rates, void events, and fulfillment mode performance across all order types."
  source: "`vibe_restaurants_v1`.`order`.`status_event`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of order associated with the status event. Used to segment SOS and lifecycle KPIs by order type."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel for the order. Used to analyze SOS and lifecycle performance by channel."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment mode (e.g. dine-in, drive-thru, delivery). Used to benchmark SOS targets by fulfillment type."
    - name: "daypart"
      expr: daypart
      comment: "Meal period for the status event. Enables daypart-level SOS and throughput analysis."
    - name: "is_sos_breach"
      expr: is_sos_breach
      comment: "Indicates whether the event represents an SOS breach. Core SOS compliance dimension for operational performance reporting."
    - name: "is_cancellation_event"
      expr: is_cancellation_event
      comment: "Indicates whether the event is a cancellation. Used to track order cancellation frequency and its operational drivers."
    - name: "is_void_event"
      expr: is_void_event
      comment: "Indicates whether the event is a void. Used to monitor void frequency and potential loss exposure."
    - name: "is_terminal_state"
      expr: is_terminal_state
      comment: "Indicates whether the event represents a terminal order state. Used to identify completed order lifecycle events."
    - name: "prior_state"
      expr: prior_state
      comment: "Prior order state before this event. Used for order lifecycle funnel analysis and state transition monitoring."
    - name: "third_party_delivery_provider"
      expr: third_party_delivery_provider
      comment: "Third-party delivery provider associated with the event. Used to analyze SOS and lifecycle performance by delivery partner."
    - name: "business_date"
      expr: business_date
      comment: "Business date of the status event. Primary time dimension for daily operational performance trending."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the status event. Used for monthly SOS compliance and operational performance reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier. Enables location-level SOS and lifecycle performance benchmarking."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total number of order status events. Baseline event volume KPI for order lifecycle monitoring and data quality validation."
    - name: "sos_breach_event_count"
      expr: COUNT(CASE WHEN is_sos_breach = True THEN 1 END)
      comment: "Count of SOS breach events. Primary speed-of-service KPI for operational performance management and guest satisfaction risk."
    - name: "cancellation_event_count"
      expr: COUNT(CASE WHEN is_cancellation_event = True THEN 1 END)
      comment: "Count of order cancellation events. Tracks cancellation frequency for operational quality and revenue loss management."
    - name: "void_event_count"
      expr: COUNT(CASE WHEN is_void_event = True THEN 1 END)
      comment: "Count of order void events. Monitors void frequency as a proxy for operational errors and potential loss exposure."
    - name: "terminal_state_event_count"
      expr: COUNT(CASE WHEN is_terminal_state = True THEN 1 END)
      comment: "Count of terminal state events representing completed order lifecycles. Used to measure order completion throughput."
    - name: "manager_override_event_count"
      expr: COUNT(CASE WHEN manager_override = True THEN 1 END)
      comment: "Count of status events requiring manager override. Tracks exception handling frequency and potential compliance risk."
    - name: "distinct_orders_with_sos_breach"
      expr: COUNT(DISTINCT CASE WHEN is_sos_breach = True THEN guest_order_id END)
      comment: "Count of distinct orders with at least one SOS breach event. Used to calculate order-level SOS compliance rate for executive reporting."
    - name: "distinct_orders_tracked"
      expr: COUNT(DISTINCT guest_order_id)
      comment: "Count of distinct orders with at least one status event. Used to validate event coverage and calculate event-level KPI rates."
$$;