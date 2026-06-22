-- Metric views for domain: order | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_guest_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs covering revenue, volume, ticket size, discounting, and fulfillment performance. Primary steering dashboard for operations and finance leadership."
  source: "`vibe_restaurants_v1`.`order`.`guest_order`"
  dimensions:
    - name: "order_channel"
      expr: channel_id
      comment: "FK to order.channel — used to slice revenue and volume by ordering channel (dine-in, drive-thru, delivery, mobile, etc.)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (dine-in, takeout, delivery, catering) for operational segmentation."
    - name: "order_status"
      expr: order_status
      comment: "Current fulfillment status of the order (placed, fulfilled, cancelled, voided) for pipeline analysis."
    - name: "daypart"
      expr: daypart
      comment: "Time-of-day segment (breakfast, lunch, dinner, late-night) for daypart revenue and volume analysis."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level performance comparison."
    - name: "placed_date"
      expr: DATE_TRUNC('DAY', placed_at)
      comment: "Calendar day the order was placed, for daily trend analysis."
    - name: "placed_month"
      expr: DATE_TRUNC('MONTH', placed_at)
      comment: "Calendar month the order was placed, for monthly revenue trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction for multi-currency reporting."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the order included a limited-time offer item, for LTO impact analysis."
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender type (cash, credit, mobile pay, gift card) for payment mix analysis."
    - name: "loyalty_program"
      expr: loyalty_program_id
      comment: "FK to loyalty.program — identifies orders tied to a loyalty program for loyalty-driven revenue analysis."
    - name: "franchisee"
      expr: franchisee_id
      comment: "FK to franchise.franchisee — enables franchisee-level revenue and volume benchmarking."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders placed. Baseline volume KPI for operational and executive dashboards."
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Gross revenue across all orders (pre-refund). Primary top-line financial KPI."
    - name: "total_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of order subtotals before tax and tip. Used for food revenue analysis excluding tax."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax remittance and compliance reporting."
    - name: "total_tip_collected"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amounts collected. Used for tip compliance and labor cost analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all orders. Measures promotional spend and margin erosion."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average ticket size per order. Core KPI for menu engineering and upsell effectiveness."
    - name: "avg_subtotal"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average food subtotal per order, excluding tax and tip. Tracks menu mix and pricing effectiveness."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity and margin risk."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Count of cancelled orders. Elevated cancellation rates signal operational or demand issues."
    - name: "voided_orders"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided orders. Tracks potential fraud, training gaps, or POS issues."
    - name: "loyalty_order_count"
      expr: COUNT(CASE WHEN loyalty_member_id IS NOT NULL THEN 1 END)
      comment: "Orders linked to a loyalty member. Measures loyalty program engagement and penetration."
    - name: "loyalty_order_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders tied to loyalty members. KPI for loyalty program adoption and ROI."
    - name: "lto_order_count"
      expr: COUNT(CASE WHEN is_lto = TRUE THEN 1 END)
      comment: "Orders containing at least one LTO item. Measures LTO traffic-driving effectiveness."
    - name: "unique_guests"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Count of distinct guests placing orders. Measures customer reach and repeat visit frequency."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level revenue, margin, and mix KPIs. Drives menu engineering, product performance, and food cost analysis."
  source: "`vibe_restaurants_v1`.`order`.`order_item`"
  dimensions:
    - name: "menu_item"
      expr: order_menu_item_id
      comment: "FK to menu.menu_item — enables item-level revenue and volume analysis."
    - name: "combo_meal"
      expr: order_combo_meal_id
      comment: "FK to menu.combo_meal — identifies combo meal orders for bundle performance analysis."
    - name: "daypart_code"
      expr: daypart_code
      comment: "Daypart code (breakfast, lunch, dinner) for time-of-day item mix analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the order item (prepared, voided, refunded) for fulfillment quality analysis."
    - name: "service_channel"
      expr: service_channel
      comment: "Channel through which the item was ordered (dine-in, drive-thru, delivery) for channel mix analysis."
    - name: "is_combo_component"
      expr: is_combo_component
      comment: "Whether the item is part of a combo meal. Used to separate a-la-carte vs. combo revenue."
    - name: "is_lto"
      expr: is_lto
      comment: "Whether the item is a limited-time offer. Measures LTO item-level contribution."
    - name: "pmix_category"
      expr: pmix_category
      comment: "Product mix category for menu engineering classification (star, plow-horse, puzzle, dog)."
    - name: "kitchen_station"
      expr: kitchen_station_id
      comment: "FK to restaurant.kitchen_station — for station-level throughput and quality analysis."
    - name: "restaurant_unit"
      expr: profit_center_id
      comment: "FK to finance.profit_center — enables profit-center-level item revenue analysis."
  measures:
    - name: "total_items_sold"
      expr: COUNT(1)
      comment: "Total order item lines. Baseline volume for product mix analysis."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units sold across all order items. Core product volume KPI for menu engineering."
    - name: "total_gross_revenue"
      expr: SUM(CAST(line_gross_amount AS DOUBLE))
      comment: "Total gross revenue from order items before discounts. Measures full price revenue potential."
    - name: "total_net_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net revenue after discounts. Primary item-level revenue KPI for P&L reporting."
    - name: "total_item_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total food cost for items sold. Used to compute item-level gross margin."
    - name: "total_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discounts applied at the item level. Measures promotional impact on item revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at item level. Required for tax compliance and remittance."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per item unit. Tracks pricing effectiveness and menu price realization."
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(line_net_amount AS DOUBLE)) - SUM(CAST(cost AS DOUBLE))) / NULLIF(SUM(CAST(line_net_amount AS DOUBLE)), 0), 2)
      comment: "Item-level gross margin percentage. Core menu engineering KPI — identifies high-margin vs. low-margin items."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items that were refunded. Signals quality issues or guest dissatisfaction at item level."
    - name: "void_item_count"
      expr: COUNT(CASE WHEN waste_flag = TRUE THEN 1 END)
      comment: "Count of items flagged as waste. Tracks food waste for cost and sustainability reporting."
    - name: "lto_item_revenue"
      expr: SUM(CASE WHEN is_lto = TRUE THEN line_net_amount ELSE 0 END)
      comment: "Net revenue from LTO items. Measures the financial contribution of limited-time offers."
    - name: "combo_item_revenue"
      expr: SUM(CASE WHEN is_combo_component = TRUE THEN line_net_amount ELSE 0 END)
      comment: "Net revenue from combo meal components. Measures combo bundle revenue contribution."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing KPIs covering tender mix, settlement performance, tip collection, and payment exceptions. Used by finance and operations leadership."
  source: "`vibe_restaurants_v1`.`order`.`payment`"
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Payment method (cash, credit card, mobile pay, gift card) for tender mix analysis."
    - name: "card_type"
      expr: card_type
      comment: "Card network (Visa, Mastercard, Amex) for interchange cost analysis."
    - name: "card_entry_method"
      expr: card_entry_method
      comment: "How the card was entered (swipe, chip, tap, manual) for fraud and security analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (authorized, captured, declined, voided) for settlement monitoring."
    - name: "channel"
      expr: channel
      comment: "Order channel associated with the payment for channel-level revenue reconciliation."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the payment for time-of-day tender mix analysis."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the payment was settled. Used for daily cash reconciliation and settlement reporting."
    - name: "processor_name"
      expr: processor_name
      comment: "Payment processor (e.g., Stripe, Square, Heartland) for processor performance benchmarking."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level payment and settlement analysis."
    - name: "is_split_tender"
      expr: is_split_tender
      comment: "Whether the payment was part of a split tender transaction. Tracks split-pay frequency."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total payment transactions processed. Baseline volume for payment operations monitoring."
    - name: "total_tendered_amount"
      expr: SUM(CAST(tendered_amount AS DOUBLE))
      comment: "Total amount tendered by guests. Used for cash management and settlement reconciliation."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount applied to orders. Primary revenue collection KPI."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tips collected. Used for tip pool distribution and labor cost analysis."
    - name: "total_interchange_fees"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total card interchange fees paid. Measures payment processing cost for margin analysis."
    - name: "total_change_due"
      expr: SUM(CAST(change_due_amount AS DOUBLE))
      comment: "Total change returned to guests. Monitors cash handling accuracy and drawer management."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at payment level. Cross-check for tax remittance reconciliation."
    - name: "voided_payment_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided payments. Elevated void rates signal fraud risk or operational issues."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were voided. Key fraud and exception management KPI."
    - name: "avg_tip_per_transaction"
      expr: AVG(CAST(tip_amount AS DOUBLE))
      comment: "Average tip amount per payment transaction. Tracks tipping behavior and service quality perception."
    - name: "interchange_cost_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(interchange_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(applied_amount AS DOUBLE)), 0), 2)
      comment: "Interchange fees as a percentage of applied payment amount. Measures card processing cost efficiency."
    - name: "split_tender_count"
      expr: COUNT(CASE WHEN is_split_tender = TRUE THEN 1 END)
      comment: "Count of split-tender transactions. Tracks payment complexity and POS handling requirements."
    - name: "offline_auth_count"
      expr: COUNT(CASE WHEN offline_authorization_flag = TRUE THEN 1 END)
      comment: "Count of payments authorized offline. Monitors connectivity risk and potential revenue exposure."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund volume, value, and reason analysis. Critical for guest satisfaction, fraud detection, and financial reconciliation."
  source: "`vibe_restaurants_v1`.`order`.`refund`"
  dimensions:
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (full, partial, loyalty points) for refund classification and financial impact analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the refund (wrong order, quality issue, late delivery) for root cause analysis."
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (pending, approved, processed, voided) for refund pipeline monitoring."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the original order was placed. Identifies channel-specific refund patterns."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the original order. Identifies time-of-day quality or operational issues driving refunds."
    - name: "refund_method"
      expr: method
      comment: "How the refund was issued (original payment method, cash, gift card) for treasury management."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level refund rate benchmarking."
    - name: "refunded_date"
      expr: DATE_TRUNC('DAY', refunded_at)
      comment: "Date the refund was processed for daily refund trend analysis."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag for refunds identified as fraudulent. Used for fraud monitoring and loss prevention."
    - name: "third_party_delivery_provider"
      expr: third_party_delivery_provider
      comment: "Delivery platform associated with the refund. Measures third-party delivery quality and dispute rates."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total refund transactions. Baseline volume KPI for guest satisfaction and operations monitoring."
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of refunds issued. Direct financial impact KPI for P&L and cash management."
    - name: "total_refund_subtotal"
      expr: SUM(CAST(subtotal AS DOUBLE))
      comment: "Total refund subtotal (food value refunded). Measures food revenue reversal impact."
    - name: "total_refund_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax refunded. Required for tax remittance adjustments and compliance reporting."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund value per transaction. Tracks severity of refund events over time."
    - name: "fraudulent_refund_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Count of refunds flagged as fraudulent. Key loss prevention and fraud management KPI."
    - name: "fraudulent_refund_amount"
      expr: SUM(CASE WHEN is_fraudulent = TRUE THEN amount ELSE 0 END)
      comment: "Total value of fraudulent refunds. Measures financial exposure from refund fraud."
    - name: "fraud_refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds flagged as fraudulent. Monitors fraud risk and loss prevention effectiveness."
    - name: "csat_impacted_refund_count"
      expr: COUNT(CASE WHEN csat_impact_flag = TRUE THEN 1 END)
      comment: "Refunds flagged as having a guest satisfaction impact. Links operational failures to CSAT outcomes."
    - name: "voided_refund_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of refunds that were subsequently voided. Tracks refund reversal activity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_drive_thru_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drive-thru speed-of-service and throughput KPIs. Core operational dashboard for QSR drive-thru performance management."
  source: "`vibe_restaurants_v1`.`order`.`drive_thru_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of drive-thru event (arrival, order, payment, pickup) for stage-level SOS analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the drive-thru event for peak vs. off-peak performance comparison."
    - name: "lane_number"
      expr: lane_number
      comment: "Drive-thru lane identifier for multi-lane throughput comparison."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level drive-thru SOS benchmarking."
    - name: "business_date"
      expr: business_date
      comment: "Business date of the drive-thru event for daily SOS trend analysis."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether the event had an exception (e.g., SOS breach, pull-forward). Used for exception rate monitoring."
    - name: "pull_forward_flag"
      expr: pull_forward_flag
      comment: "Whether the vehicle was pulled forward to wait. Tracks pull-forward rate as a throughput management tactic."
    - name: "franchise_flag"
      expr: franchise_flag
      comment: "Whether the unit is franchised. Enables franchise vs. company-owned SOS comparison."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather at time of event. Used to contextualize SOS variance due to external conditions."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel (drive-thru, mobile order pickup) for channel-specific throughput analysis."
  measures:
    - name: "total_drive_thru_events"
      expr: COUNT(1)
      comment: "Total drive-thru events recorded. Baseline volume for throughput and SOS analysis."
    - name: "avg_elapsed_time_seconds"
      expr: AVG(CAST(elapsed_time_seconds AS DOUBLE))
      comment: "Average time elapsed for the event stage. Core speed-of-service KPI for drive-thru operations."
    - name: "avg_cumulative_time_seconds"
      expr: AVG(CAST(cumulative_time_seconds AS DOUBLE))
      comment: "Average total time from arrival to current event stage. Measures end-to-end drive-thru experience."
    - name: "avg_sos_variance_seconds"
      expr: AVG(CAST(sos_variance_seconds AS DOUBLE))
      comment: "Average variance from SOS target. Negative = faster than target; positive = slower. Key performance gap metric."
    - name: "total_order_revenue"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total revenue from drive-thru orders. Measures drive-thru channel revenue contribution."
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average ticket value for drive-thru orders. Tracks upsell effectiveness in drive-thru channel."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drive-thru events with exceptions. Measures operational reliability and SOS compliance."
    - name: "pull_forward_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pull_forward_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles pulled forward. High rates indicate kitchen throughput constraints."
    - name: "sos_breach_count"
      expr: COUNT(CASE WHEN sos_variance_seconds > 0 THEN 1 END)
      comment: "Count of events where actual time exceeded SOS target. Measures SOS compliance failures."
    - name: "sos_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sos_variance_seconds <= 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drive-thru events meeting SOS target. Primary drive-thru performance KPI for operations leadership."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery channel performance KPIs covering delivery time, cost, platform economics, and guest satisfaction. Used by operations and channel management teams."
  source: "`vibe_restaurants_v1`.`order`.`delivery_order`"
  dimensions:
    - name: "delivery_platform"
      expr: delivery_platform_id
      comment: "FK to order.delivery_platform — enables platform-level performance comparison (e.g., DoorDash vs. Uber Eats)."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status (dispatched, in-transit, delivered, failed) for delivery pipeline monitoring."
    - name: "delivery_exception_type"
      expr: delivery_exception_type
      comment: "Type of delivery exception (late, wrong address, undeliverable) for root cause analysis."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level delivery performance benchmarking."
    - name: "is_contactless_delivery"
      expr: is_contactless_delivery
      comment: "Whether contactless delivery was requested. Tracks contactless adoption and operational requirements."
    - name: "delivery_city"
      expr: delivery_city
      comment: "City of delivery destination for geographic delivery performance analysis."
    - name: "order_placed_date"
      expr: DATE_TRUNC('DAY', order_placed_timestamp)
      comment: "Date the delivery order was placed for daily delivery volume and performance trending."
    - name: "delivery_state_province"
      expr: delivery_state_province
      comment: "State or province of delivery for regional delivery performance analysis."
  measures:
    - name: "total_delivery_orders"
      expr: COUNT(1)
      comment: "Total delivery orders. Baseline volume KPI for delivery channel management."
    - name: "avg_actual_delivery_time_minutes"
      expr: AVG(CAST(total_ticket_time_minutes AS DOUBLE))
      comment: "Average end-to-end delivery time in minutes. Primary delivery speed KPI for guest experience."
    - name: "avg_delivery_distance_km"
      expr: AVG(CAST(delivery_distance_km AS DOUBLE))
      comment: "Average delivery distance. Used for delivery zone optimization and driver cost analysis."
    - name: "total_delivery_fee_revenue"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Total delivery fees collected. Measures delivery fee revenue contribution."
    - name: "total_platform_commission"
      expr: SUM(CAST(platform_commission_amount AS DOUBLE))
      comment: "Total commissions paid to delivery platforms. Key cost-of-channel metric for delivery economics."
    - name: "avg_platform_commission_rate"
      expr: AVG(CAST(platform_commission_rate AS DOUBLE))
      comment: "Average commission rate charged by delivery platforms. Used for platform contract negotiation."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tips collected on delivery orders. Used for driver compensation and tip compliance analysis."
    - name: "avg_customer_rating"
      expr: AVG(CAST(customer_feedback AS DOUBLE))
      comment: "Average guest rating for delivery orders. Measures delivery experience quality and platform satisfaction."
    - name: "delivery_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_exception_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders with exceptions. Measures delivery reliability and operational quality."
    - name: "net_delivery_revenue"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE) - CAST(platform_commission_amount AS DOUBLE))
      comment: "Net delivery revenue after platform commissions. Measures true delivery channel profitability."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_kds_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kitchen Display System throughput and performance KPIs. Measures kitchen efficiency, ticket times, and re-fire rates for operations management."
  source: "`vibe_restaurants_v1`.`order`.`kds_ticket`"
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current KDS ticket status (open, in-progress, bumped, voided) for kitchen pipeline monitoring."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the KDS ticket for peak vs. off-peak kitchen performance analysis."
    - name: "order_channel"
      expr: order_channel
      comment: "Order channel routed to KDS (dine-in, drive-thru, delivery) for channel-specific kitchen load analysis."
    - name: "kitchen_station"
      expr: kitchen_station_id
      comment: "FK to restaurant.kitchen_station — enables station-level throughput and bottleneck analysis."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level kitchen performance benchmarking."
    - name: "priority_level"
      expr: priority_level
      comment: "Ticket priority level for analyzing how priority routing affects throughput."
    - name: "re_fire_flag"
      expr: re_fire_flag
      comment: "Whether the ticket was re-fired. Used to identify quality issues requiring order remakes."
    - name: "sos_met_flag"
      expr: sos_met_flag
      comment: "Whether the ticket met the SOS target. Primary kitchen SOS compliance dimension."
    - name: "ticket_created_date"
      expr: DATE_TRUNC('DAY', ticket_created_timestamp)
      comment: "Date the KDS ticket was created for daily kitchen performance trending."
  measures:
    - name: "total_kds_tickets"
      expr: COUNT(1)
      comment: "Total KDS tickets processed. Baseline kitchen throughput volume KPI."
    - name: "sos_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sos_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KDS tickets meeting SOS target. Primary kitchen speed-of-service KPI."
    - name: "re_fire_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN re_fire_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tickets requiring a re-fire. Measures kitchen quality and order accuracy."
    - name: "void_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN void_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KDS tickets voided. Tracks order cancellation and waste at kitchen level."
    - name: "avg_item_count_per_ticket"
      expr: COUNT(1)
      comment: "Total KDS tickets — use with item_count dimension for average items per ticket analysis."
    - name: "sos_breach_count"
      expr: COUNT(CASE WHEN sos_met_flag = FALSE THEN 1 END)
      comment: "Count of KDS tickets that breached SOS target. Identifies kitchen throughput failures."
    - name: "re_fire_ticket_count"
      expr: COUNT(CASE WHEN re_fire_flag = TRUE THEN 1 END)
      comment: "Absolute count of re-fired tickets. Measures kitchen quality issues requiring management attention."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount and promotional spend KPIs. Measures promotional effectiveness, margin erosion, and discount authorization compliance."
  source: "`vibe_restaurants_v1`.`order`.`discount`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (percentage, fixed amount, BOGO, loyalty redemption) for promotional mix analysis."
    - name: "discount_scope"
      expr: scope
      comment: "Scope of the discount (order-level, item-level, category-level) for discount impact analysis."
    - name: "daypart_restriction"
      expr: daypart_restriction
      comment: "Daypart restriction on the discount for time-limited promotional analysis."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level discount rate benchmarking."
    - name: "promotion"
      expr: promotion_id
      comment: "FK to marketing.promotion — links discounts to specific promotions for ROI analysis."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the discount was voided. Tracks discount reversal activity."
    - name: "is_pre_approved"
      expr: is_pre_approved
      comment: "Whether the discount was pre-approved vs. manager-authorized. Monitors authorization compliance."
    - name: "applied_date"
      expr: DATE_TRUNC('DAY', applied_at)
      comment: "Date the discount was applied for daily promotional spend trending."
    - name: "tax_treatment"
      expr: tax_treatment
      comment: "How the discount affects tax calculation (pre-tax, post-tax) for tax compliance analysis."
  measures:
    - name: "total_discounts_applied"
      expr: COUNT(1)
      comment: "Total discount transactions. Baseline volume for promotional activity monitoring."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of discounts applied. Primary promotional spend KPI for marketing ROI."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact from discounts. Measures net revenue effect of promotional activity."
    - name: "total_cogs_impact"
      expr: SUM(CAST(cogs_impact_amount AS DOUBLE))
      comment: "Total COGS impact from discounts. Measures food cost effect of promotional pricing."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average discount value per transaction. Tracks discount depth and promotional generosity."
    - name: "discount_to_original_price_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(original_price AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of original price. Measures average discount depth across promotions."
    - name: "manager_override_discount_count"
      expr: COUNT(CASE WHEN authorization_required = TRUE AND is_pre_approved = FALSE THEN 1 END)
      comment: "Count of discounts requiring manager authorization. Monitors exception-based discount compliance."
    - name: "voided_discount_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided discounts. Tracks discount reversal activity and potential misuse."
    - name: "unique_guests_discounted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guests receiving discounts. Measures promotional reach and targeting effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_ingredient_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient consumption and food cost KPIs at the order level. Drives food cost management, waste reduction, and theoretical vs. actual variance analysis."
  source: "`vibe_restaurants_v1`.`order`.`order_ingredient_usage`"
  dimensions:
    - name: "ingredient"
      expr: ingredient_id
      comment: "FK to supply.ingredient — enables ingredient-level consumption and cost analysis."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level food cost and waste benchmarking."
    - name: "usage_type"
      expr: usage_type
      comment: "Type of ingredient usage (standard, modifier-driven, waste) for consumption classification."
    - name: "is_modifier_driven"
      expr: is_modifier_driven
      comment: "Whether usage was driven by a modifier (e.g., extra cheese). Tracks modifier-driven food cost."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Whether the usage was classified as waste. Used for waste reduction program monitoring."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ingredient quantity. Required for accurate consumption aggregation."
    - name: "usage_date"
      expr: DATE_TRUNC('DAY', usage_timestamp)
      comment: "Date of ingredient usage for daily food cost trending."
    - name: "order_item"
      expr: order_item_id
      comment: "FK to order.order_item — links ingredient usage to specific menu items for recipe cost analysis."
  measures:
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total ingredient quantity consumed. Baseline consumption KPI for inventory depletion tracking."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual ingredient quantity used. Used for actual vs. theoretical food cost comparison."
    - name: "total_theoretical_quantity"
      expr: SUM(CAST(theoretical_quantity AS DOUBLE))
      comment: "Total theoretical ingredient quantity based on recipes. Baseline for variance analysis."
    - name: "total_usage_cost"
      expr: SUM(CAST(usage_cost AS DOUBLE))
      comment: "Total food cost from ingredient usage. Primary food cost KPI for P&L management."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost (quantity × unit cost). Used for detailed food cost reconciliation."
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total ingredient quantity wasted. Measures food waste for cost reduction and sustainability programs."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance between actual and theoretical quantity. Identifies over-portioning or theft."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost_amount AS DOUBLE))
      comment: "Total cost variance from theoretical. Measures financial impact of portioning and waste variances."
    - name: "variance_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_quantity AS DOUBLE)) / NULLIF(SUM(CAST(theoretical_quantity AS DOUBLE)), 0), 2)
      comment: "Variance as a percentage of theoretical usage. Key food cost control KPI — targets typically <2%."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(waste_quantity AS DOUBLE)) / NULLIF(SUM(CAST(actual_quantity AS DOUBLE)), 0), 2)
      comment: "Waste as a percentage of total actual usage. Measures food waste intensity for sustainability reporting."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_status_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order lifecycle and fulfillment event KPIs. Tracks order state transitions, SOS compliance, cancellation rates, and fulfillment exceptions for operations management."
  source: "`vibe_restaurants_v1`.`order`.`status_event`"
  dimensions:
    - name: "current_state"
      expr: current_state
      comment: "Current order state at time of event. Used to analyze order pipeline distribution."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (dine-in, drive-thru, delivery) for channel-specific fulfillment analysis."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel for the order event. Enables channel-level SOS and exception analysis."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment mode (immediate, scheduled, catering) for fulfillment type performance analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart of the status event for time-of-day operational performance analysis."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level fulfillment performance benchmarking."
    - name: "business_date"
      expr: business_date
      comment: "Business date of the event for daily operational performance trending."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Boolean flag indicating data quality issues with the event record. Used for data governance monitoring."
    - name: "is_sos_breach"
      expr: is_sos_breach
      comment: "Whether the event represents an SOS breach. Primary SOS compliance dimension."
    - name: "is_cancellation_event"
      expr: is_cancellation_event
      comment: "Whether the event is a cancellation. Used for cancellation rate analysis."
    - name: "third_party_delivery_provider"
      expr: third_party_delivery_provider
      comment: "Third-party delivery provider associated with the event. Enables provider-level SOS analysis."
  measures:
    - name: "total_status_events"
      expr: COUNT(1)
      comment: "Total order status events. Baseline volume for order lifecycle monitoring."
    - name: "sos_breach_count"
      expr: COUNT(CASE WHEN is_sos_breach = TRUE THEN 1 END)
      comment: "Count of SOS breach events. Measures speed-of-service failures across the order lifecycle."
    - name: "sos_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_sos_breach = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with SOS breaches. Primary SOS compliance KPI for operations leadership."
    - name: "cancellation_event_count"
      expr: COUNT(CASE WHEN is_cancellation_event = TRUE THEN 1 END)
      comment: "Count of cancellation events. Measures order cancellation volume for demand and operations analysis."
    - name: "void_event_count"
      expr: COUNT(CASE WHEN is_void_event = TRUE THEN 1 END)
      comment: "Count of void events. Tracks order voiding activity for fraud and exception management."
    - name: "manager_override_count"
      expr: COUNT(CASE WHEN manager_override = TRUE THEN 1 END)
      comment: "Count of events requiring manager override. Monitors exception frequency and management intervention."
    - name: "data_quality_issue_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Count of events with data quality flags. Used for data governance and pipeline reliability monitoring."
    - name: "terminal_state_count"
      expr: COUNT(CASE WHEN is_terminal_state = TRUE THEN 1 END)
      comment: "Count of events reaching a terminal state (fulfilled, cancelled, voided). Measures order completion volume."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_tax`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax collection, remittance, and compliance KPIs. Used by finance and tax teams for tax liability management and regulatory reporting."
  source: "`vibe_restaurants_v1`.`order`.`tax`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (sales tax, VAT, GST, excise) for tax liability classification."
    - name: "authority_level"
      expr: authority_level
      comment: "Tax authority level (federal, state, county, city) for jurisdictional tax analysis."
    - name: "authority_name"
      expr: authority_name
      comment: "Name of the tax authority for jurisdiction-specific remittance reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country of tax jurisdiction for multi-country tax compliance reporting."
    - name: "state_code"
      expr: state_code
      comment: "State or province of tax jurisdiction for state-level tax remittance analysis."
    - name: "tax_status"
      expr: tax_status
      comment: "Current status of the tax record (applied, refunded, adjusted) for tax liability monitoring."
    - name: "remittance_status"
      expr: remittance_status
      comment: "Whether the tax has been remitted to the authority. Critical for tax compliance monitoring."
    - name: "is_exempt"
      expr: is_exempt
      comment: "Whether the transaction was tax-exempt. Used for exemption certificate compliance tracking."
    - name: "is_tax_inclusive"
      expr: is_tax_inclusive
      comment: "Whether the price is tax-inclusive. Used for tax calculation method analysis."
    - name: "period_date"
      expr: period_date
      comment: "Tax period date for periodic tax remittance and filing analysis."
    - name: "restaurant_unit"
      expr: unit_id
      comment: "FK to restaurant.unit — enables unit-level tax collection and compliance analysis."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total tax collected. Primary tax liability KPI for remittance and compliance reporting."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable revenue base. Used to validate effective tax rate calculations."
    - name: "total_refunded_tax"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total tax refunded. Required for net tax liability calculation and remittance adjustments."
    - name: "total_original_tax"
      expr: SUM(CAST(original_tax_amount AS DOUBLE))
      comment: "Total original tax before adjustments. Used for tax adjustment variance analysis."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable revenue. Monitors tax rate accuracy and compliance."
    - name: "exempt_transaction_count"
      expr: COUNT(CASE WHEN is_exempt = TRUE THEN 1 END)
      comment: "Count of tax-exempt transactions. Used for exemption certificate audit and compliance monitoring."
    - name: "net_tax_liability"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net tax liability after refunds. Primary figure for tax remittance to authorities."
    - name: "avg_tax_rate"
      expr: AVG(CAST(rate AS DOUBLE))
      comment: "Average tax rate applied across transactions. Used to monitor rate consistency and identify anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`order_sos_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Speed-of-service target configuration and compliance threshold KPIs. Used by operations leadership to manage SOS standards across brands, formats, and channels."
  source: "`vibe_restaurants_v1`.`order`.`sos_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of SOS target (total order time, handoff time, queue time) for target category analysis."
    - name: "service_channel"
      expr: service_channel
      comment: "Service channel the target applies to (drive-thru, dine-in, delivery) for channel-specific SOS standards."
    - name: "applies_to_order_type"
      expr: applies_to_order_type
      comment: "Order type the target applies to for order-type-specific SOS standard management."
    - name: "daypart"
      expr: daypart
      comment: "Daypart the target applies to for daypart-specific SOS standard analysis."
    - name: "restaurant_format"
      expr: restaurant_format
      comment: "Restaurant format (QSR, fast casual, drive-thru only) for format-specific SOS benchmarking."
    - name: "brand"
      expr: brand_id
      comment: "FK to restaurant.brand — enables brand-level SOS target comparison."
    - name: "is_active"
      expr: is_active
      comment: "Whether the SOS target is currently active. Used to filter to current standards."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date the SOS target became effective. Used for target version history analysis."
  measures:
    - name: "total_sos_targets"
      expr: COUNT(1)
      comment: "Total SOS target configurations. Baseline count for target governance and version management."
    - name: "avg_target_total_order_time_seconds"
      expr: AVG(CAST(target_total_order_time_seconds AS DOUBLE))
      comment: "Average total order time target in seconds. Benchmarks SOS standards across formats and channels."
    - name: "avg_compliance_threshold_pct"
      expr: AVG(CAST(compliance_threshold_percent AS DOUBLE))
      comment: "Average compliance threshold percentage. Measures how stringent SOS compliance standards are set."
    - name: "avg_warning_threshold_pct"
      expr: AVG(CAST(warning_threshold_percent AS DOUBLE))
      comment: "Average warning threshold percentage. Used to calibrate early-warning SOS monitoring systems."
    - name: "active_target_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active SOS targets. Used for target governance and configuration auditing."
$$;