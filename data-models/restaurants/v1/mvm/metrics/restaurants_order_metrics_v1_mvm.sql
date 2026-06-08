-- Metric views for domain: order | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_guest_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order-level KPIs covering revenue, volume, discounting, tipping, and order mix. Primary steering dashboard for operations, finance, and marketing leadership."
  source: "`restaurants_ecm`.`order`.`guest_order`"
  filter: is_voided = False
  dimensions:
    - name: "order_channel"
      expr: channel_id
      comment: "Foreign key to channel dimension — used to slice KPIs by ordering channel (dine-in, drive-thru, delivery, mobile, etc.)."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (dine-in, takeout, delivery, catering) enabling channel-mix and fulfillment-mode analysis."
    - name: "daypart"
      expr: daypart
      comment: "Meal period (breakfast, lunch, dinner, late-night) for daypart-level revenue and traffic analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (placed, fulfilled, cancelled, voided) for funnel and completion-rate analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (paid, pending, failed, refunded) for cash-flow and exception monitoring."
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender method (cash, credit, mobile pay, gift card) for tender-mix and processing-cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency revenue reporting."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit identifier for store-level performance benchmarking."
    - name: "site_id"
      expr: site_id
      comment: "Physical site identifier for geographic and real-estate performance analysis."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee identifier for franchise vs. company-owned performance comparison."
    - name: "order_placed_date"
      expr: DATE(placed_at)
      comment: "Calendar date the order was placed, used for daily trend and seasonality analysis."
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', placed_at)
      comment: "Month the order was placed for monthly revenue and traffic trending."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the order included a limited-time offer item, used to measure LTO-driven traffic lift."
    - name: "loyalty_member_id"
      expr: loyalty_member_id
      comment: "Loyalty program member identifier to segment orders by loyalty vs. non-loyalty guests."
    - name: "promotion_id"
      expr: promotion_id
      comment: "Promotion applied to the order for promotional ROI and redemption analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of non-voided guest orders. Primary traffic KPI used in QBRs and operational dashboards."
    - name: "total_gross_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of total order amounts (pre-refund) representing gross revenue. Core top-line financial KPI."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of order subtotals before tax and tip. Used for net food revenue analysis excluding tax effects."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount dollars applied across all orders. Measures promotional spend and discount exposure."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax remittance reconciliation and compliance reporting."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected. Relevant for labor cost analysis and server compensation benchmarking."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total order value (ticket size). Key pricing and upsell effectiveness KPI tracked by operations and marketing."
    - name: "avg_subtotal_per_order"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average food subtotal per order excluding tax and tip. Used for menu pricing and mix analysis."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per order. Tracks promotional generosity and its impact on net revenue."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity and margin erosion risk."
    - name: "loyalty_order_count"
      expr: COUNT(CASE WHEN loyalty_member_id IS NOT NULL THEN 1 END)
      comment: "Number of orders placed by loyalty program members. Tracks loyalty program engagement and penetration."
    - name: "loyalty_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_id IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders placed by loyalty members. Key loyalty program health KPI for marketing leadership."
    - name: "lto_order_count"
      expr: COUNT(CASE WHEN is_lto = True THEN 1 END)
      comment: "Number of orders containing a limited-time offer item. Measures LTO-driven traffic and promotional effectiveness."
    - name: "lto_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_lto = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that included an LTO item. Used by marketing to evaluate LTO campaign traffic lift."
    - name: "cancelled_order_count"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled orders. Tracks operational failure and guest experience issues."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that were cancelled. Operational quality KPI — high rates signal fulfillment or demand-forecasting problems."
    - name: "unique_guests"
      expr: COUNT(DISTINCT primary_guest_profile_id)
      comment: "Count of distinct guest profiles placing orders. Measures customer reach and repeat-visit frequency when trended."
    - name: "unique_loyalty_members"
      expr: COUNT(DISTINCT loyalty_member_id)
      comment: "Count of distinct loyalty members placing orders in the period. Tracks active loyalty base size."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item-level revenue, cost, margin, and product-mix KPIs. Enables menu engineering, COGS management, and product performance analysis for operations and finance."
  source: "`restaurants_ecm`.`order`.`order_item`"
  dimensions:
    - name: "menu_item_id"
      expr: menu_item_id
      comment: "Menu item identifier for item-level sales and margin analysis (product mix / PMIX reporting)."
    - name: "pmix_category"
      expr: pmix_category
      comment: "Product mix category grouping for menu engineering quadrant analysis (star, plow-horse, puzzle, dog)."
    - name: "daypart_code"
      expr: daypart_code
      comment: "Daypart code (breakfast, lunch, dinner, late-night) for time-of-day product performance analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Ordering channel for item-level channel-mix analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit for store-level item performance benchmarking."
    - name: "is_lto"
      expr: is_lto
      comment: "Flag indicating whether the item is a limited-time offer, used to isolate LTO contribution to revenue."
    - name: "is_combo_component"
      expr: is_combo_component
      comment: "Flag indicating whether the item is part of a combo meal, used for combo vs. a-la-carte mix analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the order item (prepared, voided, refunded) for quality and exception analysis."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Boolean flag indicating the item was refunded. Used to track item-level refund exposure."
    - name: "waste_flag"
      expr: waste_flag
      comment: "Boolean flag indicating the item was wasted. Used for food waste cost and sustainability reporting."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Boolean flag indicating the item is tax-exempt. Required for tax compliance and exemption reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency item revenue reporting."
    - name: "item_created_date"
      expr: DATE(created_timestamp)
      comment: "Date the order item was created for daily sales trend analysis."
    - name: "item_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the order item was created for monthly product mix trending."
  measures:
    - name: "total_items_sold"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of items sold. Core product volume KPI for menu engineering and demand forecasting."
    - name: "total_gross_item_revenue"
      expr: SUM(CAST(line_gross_amount AS DOUBLE))
      comment: "Sum of gross line amounts before discounts. Measures full-price revenue potential of the menu."
    - name: "total_net_item_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Sum of net line amounts after discounts. Core item-level net revenue KPI for P&L reporting."
    - name: "total_item_cogs"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of goods sold at the item level. Primary input for gross margin and food cost percentage calculations."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount dollars applied at the item line level. Measures item-level promotional spend."
    - name: "total_item_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the item level. Used for tax reconciliation and compliance reporting."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund dollars at the item level. Tracks quality issues and guest satisfaction failures by item."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per item unit. Used for menu pricing analysis and price elasticity monitoring."
    - name: "avg_item_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per item. Used alongside average unit price to assess per-item margin health."
    - name: "gross_margin_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE) - CAST(cost AS DOUBLE))
      comment: "Total gross margin dollars (net revenue minus COGS) at the item level. Core profitability KPI for menu engineering."
    - name: "item_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(line_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(line_gross_amount AS DOUBLE)), 0), 2)
      comment: "Item-level discount as a percentage of gross revenue. Measures promotional intensity by item and category."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refund_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order items that were refunded. Quality and guest satisfaction KPI — high rates signal item-specific issues."
    - name: "waste_item_count"
      expr: COUNT(CASE WHEN waste_flag = True THEN 1 END)
      comment: "Number of items flagged as wasted. Tracks food waste volume for cost control and sustainability reporting."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items wasted. Operational efficiency KPI — high rates indicate over-production or demand forecasting failures."
    - name: "lto_item_revenue"
      expr: SUM(CASE WHEN is_lto = True THEN CAST(line_net_amount AS DOUBLE) ELSE 0 END)
      comment: "Net revenue from LTO items. Measures the direct revenue contribution of limited-time offer promotions."
    - name: "unique_menu_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Count of distinct menu items sold in the period. Measures menu breadth and item variety in guest orders."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery channel KPIs covering fulfillment performance, platform economics, delivery quality, and guest satisfaction. Used by operations and channel strategy leadership."
  source: "`restaurants_ecm`.`order`.`delivery_order`"
  dimensions:
    - name: "delivery_platform_id"
      expr: delivery_platform_id
      comment: "Delivery platform identifier (e.g. DoorDash, Uber Eats, Grubhub) for platform-level performance comparison."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit for store-level delivery performance benchmarking."
    - name: "site_id"
      expr: site_id
      comment: "Physical site for geographic delivery performance analysis."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee identifier for franchise-level delivery channel performance."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status (delivered, failed, cancelled, in-transit) for fulfillment funnel analysis."
    - name: "delivery_exception_type"
      expr: delivery_exception_type
      comment: "Type of delivery exception (late, wrong order, missing item) for root-cause analysis of delivery failures."
    - name: "is_contactless_delivery"
      expr: is_contactless_delivery
      comment: "Flag indicating contactless delivery was requested. Tracks contactless adoption and operational requirements."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency delivery revenue reporting."
    - name: "order_placed_date"
      expr: DATE(order_placed_timestamp)
      comment: "Date the delivery order was placed for daily delivery volume trending."
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the delivery order was placed for monthly delivery channel trending."
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country of delivery for geographic market analysis."
  measures:
    - name: "total_delivery_orders"
      expr: COUNT(1)
      comment: "Total number of delivery orders. Primary delivery channel volume KPI."
    - name: "total_delivery_fee_revenue"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Total delivery fees collected. Measures delivery fee revenue contribution and guest price sensitivity."
    - name: "total_platform_commission"
      expr: SUM(CAST(platform_commission_amount AS DOUBLE))
      comment: "Total commission paid to third-party delivery platforms. Key cost-of-channel KPI for delivery economics."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars on delivery orders. Relevant for driver compensation and guest generosity benchmarking."
    - name: "avg_delivery_distance_km"
      expr: AVG(CAST(delivery_distance_km AS DOUBLE))
      comment: "Average delivery distance in kilometers. Used for delivery zone optimization and cost-per-delivery analysis."
    - name: "avg_platform_commission_rate"
      expr: AVG(CAST(platform_commission_rate AS DOUBLE))
      comment: "Average platform commission rate across delivery orders. Tracks platform cost burden and contract negotiation benchmarks."
    - name: "delivery_exception_count"
      expr: COUNT(CASE WHEN delivery_exception_type IS NOT NULL THEN 1 END)
      comment: "Number of delivery orders with an exception (late, wrong, missing). Tracks delivery quality failures."
    - name: "delivery_exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_exception_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders with an exception. Key delivery quality KPI for operations and platform management."
    - name: "net_delivery_revenue_after_commission"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE) - CAST(platform_commission_amount AS DOUBLE))
      comment: "Net delivery fee revenue after deducting platform commissions. Measures true delivery channel profitability."
    - name: "unique_delivery_guests"
      expr: COUNT(DISTINCT member_id)
      comment: "Count of distinct loyalty members placing delivery orders. Tracks delivery channel guest reach and loyalty overlap."
    - name: "unique_delivery_platforms_used"
      expr: COUNT(DISTINCT delivery_platform_id)
      comment: "Count of distinct delivery platforms used in the period. Measures platform diversification and dependency risk."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction KPIs covering tender mix, processing costs, split tender, and payment exceptions. Used by finance, treasury, and operations leadership."
  source: "`restaurants_ecm`.`order`.`payment`"
  filter: is_voided = False
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Payment tender method (cash, credit card, debit, mobile pay, gift card) for tender-mix analysis."
    - name: "card_type"
      expr: card_type
      comment: "Card network type (Visa, Mastercard, Amex, Discover) for interchange cost analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (captured, pending, failed, refunded) for payment exception and reconciliation monitoring."
    - name: "processor_name"
      expr: processor_name
      comment: "Payment processor name for processor performance and cost benchmarking."
    - name: "daypart"
      expr: daypart
      comment: "Meal period for daypart-level payment volume and tender-mix analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit for store-level payment performance analysis."
    - name: "site_id"
      expr: site_id
      comment: "Physical site for geographic payment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency payment reporting."
    - name: "is_split_tender"
      expr: is_split_tender
      comment: "Flag indicating the payment was part of a split-tender transaction. Tracks split-pay adoption and complexity."
    - name: "offline_authorization_flag"
      expr: offline_authorization_flag
      comment: "Flag indicating the payment was authorized offline. Tracks connectivity risk and offline payment exposure."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the payment was settled for cash-flow and reconciliation analysis."
    - name: "payment_captured_month"
      expr: DATE_TRUNC('MONTH', captured_timestamp)
      comment: "Month the payment was captured for monthly payment volume and revenue trending."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of non-voided payment transactions. Primary payment volume KPI."
    - name: "total_tendered_amount"
      expr: SUM(CAST(tendered_amount AS DOUBLE))
      comment: "Total amount tendered by guests. Measures gross payment inflow before change."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount applied to orders. Core revenue collection KPI for finance reconciliation."
    - name: "total_tip_collected"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip dollars collected across all payments. Used for labor cost and server compensation analysis."
    - name: "total_interchange_fees"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees paid to card networks. Key payment processing cost KPI for treasury and finance."
    - name: "total_change_due"
      expr: SUM(CAST(change_due_amount AS DOUBLE))
      comment: "Total change returned to guests on cash transactions. Tracks cash handling volume and accuracy."
    - name: "avg_payment_amount"
      expr: AVG(CAST(applied_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Tracks ticket size from a payment perspective."
    - name: "interchange_fee_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(interchange_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(applied_amount AS DOUBLE)), 0), 2)
      comment: "Interchange fees as a percentage of total applied payment. Measures effective card processing cost rate."
    - name: "split_tender_order_count"
      expr: COUNT(CASE WHEN is_split_tender = True THEN 1 END)
      comment: "Number of split-tender payment transactions. Tracks operational complexity from multi-tender orders."
    - name: "offline_auth_count"
      expr: COUNT(CASE WHEN offline_authorization_flag = True THEN 1 END)
      comment: "Number of payments authorized offline. Tracks connectivity risk and potential fraud exposure from offline auth."
    - name: "offline_auth_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offline_authorization_flag = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments authorized offline. Operational risk KPI — high rates indicate POS connectivity issues."
    - name: "unique_paying_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guest profiles making payments. Measures unique paying customer reach in the period."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund and chargeback KPIs covering refund volume, value, fraud exposure, and guest recovery. Used by operations, finance, and guest experience leadership."
  source: "`restaurants_ecm`.`order`.`refund`"
  filter: is_voided = False
  dimensions:
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (full, partial, item-level) for refund scope analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the refund (wrong order, quality issue, late delivery) for root-cause analysis."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (original payment, gift card, cash) for refund liability analysis."
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (approved, pending, rejected) for refund processing pipeline monitoring."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the original order was placed, used to identify which channels drive the most refunds."
    - name: "daypart"
      expr: daypart
      comment: "Meal period of the original order for daypart-level refund analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit for store-level refund performance benchmarking."
    - name: "site_id"
      expr: site_id
      comment: "Physical site for geographic refund analysis."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating the refund was identified as fraudulent. Used for fraud loss monitoring and prevention."
    - name: "csat_impact_flag"
      expr: csat_impact_flag
      comment: "Flag indicating the refund had a customer satisfaction impact. Links refund events to CSAT outcomes."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency refund reporting."
    - name: "refund_requested_date"
      expr: DATE(requested_at)
      comment: "Date the refund was requested for daily refund volume trending."
    - name: "refund_requested_month"
      expr: DATE_TRUNC('MONTH', requested_at)
      comment: "Month the refund was requested for monthly refund trend analysis."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of non-voided refunds issued. Primary refund volume KPI for guest experience and operations."
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total dollar value of refunds issued. Core financial KPI for refund liability and P&L impact."
    - name: "total_refund_subtotal"
      expr: SUM(CAST(subtotal AS DOUBLE))
      comment: "Total subtotal value of refunded orders. Used to assess the food revenue impact of refunds."
    - name: "total_refund_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax refunded. Required for tax remittance adjustments and compliance reporting."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction. Tracks refund severity and whether partial vs. full refunds dominate."
    - name: "fraudulent_refund_count"
      expr: COUNT(CASE WHEN is_fraudulent = True THEN 1 END)
      comment: "Number of refunds flagged as fraudulent. Tracks fraud exposure and refund abuse patterns."
    - name: "fraudulent_refund_amount"
      expr: SUM(CASE WHEN is_fraudulent = True THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of fraudulent refunds. Measures financial loss from refund fraud."
    - name: "fraud_refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds flagged as fraudulent. Key fraud risk KPI for loss prevention leadership."
    - name: "csat_impacted_refund_count"
      expr: COUNT(CASE WHEN csat_impact_flag = True THEN 1 END)
      comment: "Number of refunds with a CSAT impact flag. Links operational failures to guest satisfaction outcomes."
    - name: "unique_guests_refunded"
      expr: COUNT(DISTINCT refund_guest_profile_id)
      comment: "Count of distinct guests who received a refund. Tracks breadth of guest experience failures in the period."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount and promotional KPIs covering discount volume, value, type mix, and margin impact. Used by marketing, finance, and operations to govern promotional spend."
  source: "`restaurants_ecm`.`order`.`discount`"
  filter: is_voided = False
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (percentage, fixed amount, BOGO, loyalty redemption) for discount program mix analysis."
    - name: "discount_scope"
      expr: discount_scope
      comment: "Scope of the discount (order-level, item-level, combo) for granularity of promotional impact analysis."
    - name: "discount_name"
      expr: discount_name
      comment: "Name of the discount or promotion applied for campaign-level performance tracking."
    - name: "promotion_id"
      expr: promotion_id
      comment: "Promotion identifier for promotion-level ROI and redemption analysis."
    - name: "channel_id"
      expr: channel_id
      comment: "Channel through which the discount was applied for channel-level promotional spend analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit for store-level discount exposure benchmarking."
    - name: "site_id"
      expr: site_id
      comment: "Physical site for geographic discount analysis."
    - name: "daypart_restriction"
      expr: daypart_restriction
      comment: "Daypart restriction on the discount for time-of-day promotional effectiveness analysis."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Flag indicating whether the discount can be stacked with other promotions. Tracks stacking risk and margin exposure."
    - name: "is_pre_approved"
      expr: is_pre_approved
      comment: "Flag indicating whether the discount was pre-approved vs. manager-authorized. Tracks discount governance compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency discount reporting."
    - name: "discount_applied_date"
      expr: DATE(applied_at)
      comment: "Date the discount was applied for daily promotional spend trending."
    - name: "discount_applied_month"
      expr: DATE_TRUNC('MONTH', applied_at)
      comment: "Month the discount was applied for monthly promotional spend analysis."
  measures:
    - name: "total_discounts_applied"
      expr: COUNT(1)
      comment: "Total number of non-voided discounts applied. Measures promotional redemption volume."
    - name: "total_discount_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total discount dollars applied. Core promotional spend KPI for marketing and finance."
    - name: "total_revenue_impact"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of discounts. Measures net revenue reduction from promotional activity."
    - name: "total_cogs_impact"
      expr: SUM(CAST(cogs_impact_amount AS DOUBLE))
      comment: "Total COGS impact of discounts. Measures cost-side effect of promotional pricing on margin."
    - name: "avg_discount_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average discount amount per redemption. Tracks promotional generosity and discount depth."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average discount percentage applied. Measures typical promotional depth across all discount events."
    - name: "manager_authorized_discount_count"
      expr: COUNT(CASE WHEN authorization_required = True THEN 1 END)
      comment: "Number of discounts requiring manager authorization. Tracks exception-based discount governance compliance."
    - name: "manager_auth_discount_amount"
      expr: SUM(CASE WHEN authorization_required = True THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of manager-authorized discounts. Measures financial exposure from exception discounting."
    - name: "stackable_discount_count"
      expr: COUNT(CASE WHEN is_stackable = True THEN 1 END)
      comment: "Number of stackable discounts applied. Tracks stacking exposure and potential margin erosion from combined promotions."
    - name: "unique_promotions_redeemed"
      expr: COUNT(DISTINCT promotion_id)
      comment: "Count of distinct promotions redeemed in the period. Measures promotional portfolio breadth and activity."
    - name: "unique_guests_discounted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guests who received a discount. Measures promotional reach and guest targeting effectiveness."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_catering_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catering channel KPIs covering event revenue, deposit collection, fulfillment, and cancellation. Used by catering sales, operations, and finance leadership."
  source: "`restaurants_ecm`.`order`.`catering_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Catering order lifecycle status (quoted, confirmed, fulfilled, cancelled) for pipeline and conversion analysis."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Catering fulfillment mode (delivery, pickup, on-site setup) for operational planning."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status for catering orders. Tracks deposit and balance collection health."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for catering orders for tender-mix and accounts-receivable analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for catering order cancellation for root-cause analysis of lost catering revenue."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit fulfilling the catering order for unit-level catering revenue analysis."
    - name: "site_id"
      expr: site_id
      comment: "Physical site for geographic catering demand analysis."
    - name: "franchisee_id"
      expr: franchisee_id
      comment: "Franchisee identifier for franchise-level catering performance."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency catering revenue reporting."
    - name: "event_date"
      expr: event_date
      comment: "Date of the catering event for event-calendar and demand-planning analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_start_time)
      comment: "Month of the catering event for monthly catering revenue forecasting."
    - name: "delivery_country_code"
      expr: delivery_country_code
      comment: "Country of the catering delivery for geographic market analysis."
    - name: "setup_required"
      expr: setup_required
      comment: "Flag indicating on-site setup is required. Used for labor planning and logistics cost estimation."
  measures:
    - name: "total_catering_orders"
      expr: COUNT(1)
      comment: "Total number of catering orders. Primary catering channel volume KPI."
    - name: "total_catering_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total catering order revenue. Core top-line KPI for the catering channel P&L."
    - name: "total_quoted_revenue"
      expr: SUM(CAST(quoted_price AS DOUBLE))
      comment: "Total quoted price across catering orders. Measures catering pipeline value and quote-to-close conversion."
    - name: "total_deposit_collected"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposits collected on catering orders. Tracks cash-flow from catering advance payments."
    - name: "total_balance_due"
      expr: SUM(CAST(balance_due AS DOUBLE))
      comment: "Total outstanding balance due on catering orders. Tracks accounts-receivable exposure for the catering channel."
    - name: "total_gratuity_collected"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on catering orders. Relevant for staff compensation and catering service quality."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on catering orders. Required for tax remittance and compliance reporting."
    - name: "avg_catering_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average catering order value. Tracks catering ticket size and upsell effectiveness."
    - name: "avg_quoted_price"
      expr: AVG(CAST(quoted_price AS DOUBLE))
      comment: "Average quoted price per catering order. Used for pricing strategy and quote accuracy analysis."
    - name: "cancelled_catering_orders"
      expr: COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled catering orders. Tracks lost catering revenue and pipeline attrition."
    - name: "catering_cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN order_status = 'cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catering orders that were cancelled. Key catering channel health KPI for sales leadership."
    - name: "quote_to_revenue_conversion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_amount AS DOUBLE)) / NULLIF(SUM(CAST(quoted_price AS DOUBLE)), 0), 2)
      comment: "Ratio of actual revenue collected to total quoted price. Measures catering sales conversion and pricing accuracy."
    - name: "unique_catering_guests"
      expr: COUNT(DISTINCT primary_catering_guest_profile_id)
      comment: "Count of distinct catering guests. Measures catering customer reach and repeat catering business."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`order_tax`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax collection, exemption, and remittance KPIs. Used by finance and tax compliance teams for regulatory reporting, remittance reconciliation, and exemption management."
  source: "`restaurants_ecm`.`order`.`tax`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (sales tax, VAT, GST, excise) for tax-type-level compliance reporting."
    - name: "tax_name"
      expr: tax_name
      comment: "Name of the tax authority or tax line for detailed tax reporting."
    - name: "authority_level"
      expr: authority_level
      comment: "Tax authority level (federal, state, local) for jurisdictional tax analysis."
    - name: "authority_name"
      expr: authority_name
      comment: "Name of the tax authority for jurisdiction-level remittance reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country code for multi-jurisdiction tax compliance reporting."
    - name: "state_code"
      expr: state_code
      comment: "State or province code for state-level tax remittance analysis."
    - name: "tax_status"
      expr: tax_status
      comment: "Current status of the tax line (applied, voided, refunded, adjusted) for tax reconciliation."
    - name: "remittance_status"
      expr: remittance_status
      comment: "Tax remittance status (pending, remitted, overdue) for compliance deadline monitoring."
    - name: "is_exempt"
      expr: is_exempt
      comment: "Flag indicating the order item is tax-exempt. Used for exemption certificate compliance and audit."
    - name: "is_refunded"
      expr: is_refunded
      comment: "Flag indicating the tax was refunded. Used for tax refund reconciliation."
    - name: "is_tax_inclusive"
      expr: is_tax_inclusive
      comment: "Flag indicating tax is included in the price (tax-inclusive pricing). Used for revenue recognition accuracy."
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the taxed order was placed for channel-level tax analysis."
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit for store-level tax collection benchmarking."
    - name: "tax_period_date"
      expr: period_date
      comment: "Tax period date for period-level tax remittance reporting."
    - name: "tax_applied_month"
      expr: DATE_TRUNC('MONTH', applied_timestamp)
      comment: "Month the tax was applied for monthly tax collection trending."
  measures:
    - name: "total_tax_collected"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total tax collected across all tax lines. Primary tax remittance KPI for finance and compliance."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable revenue base. Used to validate effective tax rates and identify under-taxation risks."
    - name: "total_tax_refunded"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total tax refunded. Required for net tax remittance calculations and compliance adjustments."
    - name: "net_tax_liability"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net tax liability (collected minus refunded). Core tax remittance KPI for regulatory compliance."
    - name: "avg_effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount AS DOUBLE)) / NULLIF(SUM(CAST(taxable_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of taxable revenue. Used to validate tax engine accuracy and identify rate anomalies."
    - name: "exempt_transaction_count"
      expr: COUNT(CASE WHEN is_exempt = True THEN 1 END)
      comment: "Number of tax-exempt transactions. Tracks exemption certificate usage and compliance audit exposure."
    - name: "exempt_transaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_exempt = True THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax lines that are exempt. Monitors exemption rate for audit risk and compliance governance."
    - name: "total_original_tax_amount"
      expr: SUM(CAST(original_tax_amount AS DOUBLE))
      comment: "Total original tax amount before adjustments. Used to measure the magnitude of tax adjustments and corrections."
    - name: "tax_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE) - CAST(original_tax_amount AS DOUBLE))
      comment: "Total tax adjustment (current amount minus original). Tracks tax engine corrections and manual overrides."
$$;