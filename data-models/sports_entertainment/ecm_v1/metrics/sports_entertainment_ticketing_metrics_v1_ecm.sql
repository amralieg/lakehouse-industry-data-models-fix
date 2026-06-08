-- Metric views for domain: ticketing | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`ticketing_ticket_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core ticketing revenue and order performance metrics including gross merchandise value, average order value, discount effectiveness, and payment conversion rates"
  source: "`sports_entertainment_ecm`.`ticketing`.`ticket_order`"
  dimensions:
    - name: "order_date"
      expr: DATE_TRUNC('day', purchase_timestamp)
      comment: "Date of ticket purchase for daily trend analysis"
    - name: "order_month"
      expr: DATE_TRUNC('month', purchase_timestamp)
      comment: "Month of ticket purchase for monthly trend analysis"
    - name: "sales_channel"
      expr: sales_channel_code
      comment: "Channel through which tickets were sold (online, box office, mobile app, etc.)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the ticket order (completed, cancelled, pending, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Ticket delivery method (mobile, print-at-home, will-call, etc.)"
    - name: "ticket_tier"
      expr: ticket_tier
      comment: "Pricing tier of tickets in the order"
    - name: "is_resale"
      expr: resale_flag
      comment: "Whether this order is a resale transaction"
    - name: "is_accessible_seating"
      expr: accessible_seating_flag
      comment: "Whether order includes accessible seating"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of ticket orders placed"
    - name: "gross_merchandise_value"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total gross merchandise value of all ticket orders including fees and taxes"
    - name: "total_face_value"
      expr: SUM(CAST(face_value_amount AS DOUBLE))
      comment: "Total face value of tickets sold before fees and discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all orders"
    - name: "total_service_fees"
      expr: SUM(CAST(service_fee_amount AS DOUBLE))
      comment: "Total service fees collected across all orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded across all orders"
    - name: "total_tickets_sold"
      expr: SUM(CAST(ticket_quantity AS DOUBLE))
      comment: "Total number of individual tickets sold across all orders"
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value across all ticket orders"
    - name: "avg_tickets_per_order"
      expr: AVG(CAST(ticket_quantity AS DOUBLE))
      comment: "Average number of tickets per order"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(face_value_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of face value discounted across all orders"
    - name: "service_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(service_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(face_value_amount AS DOUBLE)), 0), 2)
      comment: "Service fees as percentage of face value"
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(order_total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of GMV refunded"
    - name: "unique_customers"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique customers who placed orders"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`ticketing_ticket_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ticket inventory utilization and pricing performance metrics including sellthrough rates, dynamic pricing effectiveness, and inventory status distribution"
  source: "`sports_entertainment_ecm`.`ticketing`.`ticket_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of ticket inventory (available, sold, held, killed, etc.)"
    - name: "inventory_type"
      expr: inventory_type
      comment: "Type of inventory (general admission, reserved, premium, etc.)"
    - name: "seat_tier"
      expr: seat_tier
      comment: "Pricing tier of the seat"
    - name: "section"
      expr: section_label
      comment: "Venue section identifier"
    - name: "is_ada_accessible"
      expr: is_ada_accessible
      comment: "Whether seat is ADA accessible"
    - name: "is_dynamic_pricing_enabled"
      expr: is_dynamic_pricing_enabled
      comment: "Whether dynamic pricing is enabled for this inventory"
    - name: "is_resale_eligible"
      expr: resale_eligible
      comment: "Whether ticket is eligible for resale"
    - name: "is_obstructed_view"
      expr: is_obstructed_view
      comment: "Whether seat has obstructed view"
    - name: "sale_channel"
      expr: sale_channel
      comment: "Channel through which inventory is available for sale"
  measures:
    - name: "total_inventory"
      expr: COUNT(1)
      comment: "Total number of ticket inventory records"
    - name: "total_face_value"
      expr: SUM(CAST(face_value_amount AS DOUBLE))
      comment: "Total face value of all inventory"
    - name: "total_dynamic_price"
      expr: SUM(CAST(dynamic_price_amount AS DOUBLE))
      comment: "Total dynamic pricing value of inventory"
    - name: "avg_face_value"
      expr: AVG(CAST(face_value_amount AS DOUBLE))
      comment: "Average face value per ticket"
    - name: "avg_dynamic_price"
      expr: AVG(CAST(dynamic_price_amount AS DOUBLE))
      comment: "Average dynamic price per ticket"
    - name: "dynamic_pricing_uplift_pct"
      expr: ROUND(100.0 * (SUM(CAST(dynamic_price_amount AS DOUBLE)) - SUM(CAST(face_value_amount AS DOUBLE))) / NULLIF(SUM(CAST(face_value_amount AS DOUBLE)), 0), 2)
      comment: "Percentage uplift from dynamic pricing versus face value"
    - name: "unique_venues"
      expr: COUNT(DISTINCT venue_id)
      comment: "Number of unique venues in inventory"
    - name: "unique_events"
      expr: COUNT(DISTINCT event_fixture_id)
      comment: "Number of unique events in inventory"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`ticketing_gate_scan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gate entry and access control metrics including scan success rates, entry timing patterns, fraud detection, and operational efficiency"
  source: "`sports_entertainment_ecm`.`ticketing`.`gate_scan`"
  dimensions:
    - name: "scan_date"
      expr: DATE_TRUNC('day', scan_timestamp)
      comment: "Date of gate scan for daily analysis"
    - name: "scan_hour"
      expr: DATE_TRUNC('hour', scan_timestamp)
      comment: "Hour of gate scan for entry pattern analysis"
    - name: "scan_result"
      expr: scan_result
      comment: "Result of the scan attempt (success, denied, duplicate, etc.)"
    - name: "denial_reason"
      expr: denial_reason_code
      comment: "Reason code for denied entry"
    - name: "gate_identifier"
      expr: gate_identifier
      comment: "Identifier of the gate where scan occurred"
    - name: "device_type"
      expr: device_type
      comment: "Type of scanning device used"
    - name: "is_mobile_ticket"
      expr: is_mobile_ticket
      comment: "Whether ticket was mobile format"
    - name: "scan_direction"
      expr: scan_direction
      comment: "Direction of scan (entry, exit, re-entry)"
    - name: "ticket_type"
      expr: ticket_type
      comment: "Type of ticket scanned"
    - name: "is_override"
      expr: override_flag
      comment: "Whether scan was manually overridden"
  measures:
    - name: "total_scans"
      expr: COUNT(1)
      comment: "Total number of gate scan attempts"
    - name: "unique_tickets_scanned"
      expr: COUNT(DISTINCT access_entitlement_id)
      comment: "Number of unique tickets scanned"
    - name: "unique_fans_entered"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique fans who entered"
    - name: "avg_processing_time_ms"
      expr: AVG(CAST(processing_duration_ms AS DOUBLE))
      comment: "Average scan processing time in milliseconds"
    - name: "unique_gates"
      expr: COUNT(DISTINCT gate_identifier)
      comment: "Number of unique gates used"
    - name: "unique_events"
      expr: COUNT(DISTINCT event_fixture_id)
      comment: "Number of unique events with gate scans"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`ticketing_season_ticket_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Season ticket holder performance metrics including renewal rates, payment plan adherence, account value, and loyalty program engagement"
  source: "`sports_entertainment_ecm`.`ticketing`.`season_ticket_account`"
  dimensions:
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of season ticket enrollment"
    - name: "account_status"
      expr: account_status
      comment: "Current status of season ticket account"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the account"
    - name: "payment_plan_type"
      expr: payment_plan_type
      comment: "Type of payment plan (full, installment, etc.)"
    - name: "payment_plan_status"
      expr: payment_plan_status
      comment: "Current status of payment plan"
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier of season ticket package"
    - name: "loyalty_tier"
      expr: sth_loyalty_tier
      comment: "Season ticket holder loyalty tier"
    - name: "tenure_years"
      expr: tenure_years
      comment: "Number of years as season ticket holder"
    - name: "has_parking"
      expr: parking_included
      comment: "Whether parking is included in package"
    - name: "resale_opt_in"
      expr: resale_opt_in
      comment: "Whether account holder opted into resale program"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether account holder opted into marketing communications"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of season ticket accounts"
    - name: "total_account_value"
      expr: SUM(CAST(net_package_amount AS DOUBLE))
      comment: "Total net value of all season ticket packages"
    - name: "total_face_value"
      expr: SUM(CAST(face_value_amount AS DOUBLE))
      comment: "Total face value of all season ticket packages"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across all accounts"
    - name: "total_account_balance"
      expr: SUM(CAST(account_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts"
    - name: "avg_account_value"
      expr: AVG(CAST(net_package_amount AS DOUBLE))
      comment: "Average net package value per account"
    - name: "avg_seat_count"
      expr: AVG(CAST(seat_count AS DOUBLE))
      comment: "Average number of seats per account"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across accounts"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(face_value_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount rate across all season ticket accounts"
    - name: "unique_franchises"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Number of unique franchises with season ticket accounts"
    - name: "unique_venues"
      expr: COUNT(DISTINCT venue_id)
      comment: "Number of unique venues with season ticket accounts"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`ticketing_resale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Secondary ticket market performance metrics including resale volume, price uplift, marketplace efficiency, and revenue share distribution"
  source: "`sports_entertainment_ecm`.`ticketing`.`resale`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of resale transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of resale transaction"
    - name: "listing_date"
      expr: DATE_TRUNC('day', listing_created_timestamp)
      comment: "Date when listing was created"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of resale listing"
    - name: "seller_type"
      expr: seller_type
      comment: "Type of seller (individual, broker, season ticket holder, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for resale transaction"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method for resold tickets"
    - name: "ticket_tier"
      expr: ticket_tier
      comment: "Pricing tier of resold tickets"
    - name: "is_dynamic_pricing_applied"
      expr: dynamic_pricing_applied
      comment: "Whether dynamic pricing was applied to resale"
    - name: "is_anti_scalping_compliant"
      expr: anti_scalping_compliant
      comment: "Whether resale complies with anti-scalping regulations"
  measures:
    - name: "total_resales"
      expr: COUNT(1)
      comment: "Total number of resale transactions"
    - name: "total_resale_revenue"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total revenue from resale transactions"
    - name: "total_original_face_value"
      expr: SUM(CAST(original_face_value AS DOUBLE))
      comment: "Total original face value of resold tickets"
    - name: "total_listing_price"
      expr: SUM(CAST(listing_price AS DOUBLE))
      comment: "Total listing price of all resale inventory"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees collected from resales"
    - name: "total_revenue_share"
      expr: SUM(CAST(revenue_share_amount AS DOUBLE))
      comment: "Total revenue share amount from resales"
    - name: "total_seller_proceeds"
      expr: SUM(CAST(seller_proceeds AS DOUBLE))
      comment: "Total proceeds paid to sellers"
    - name: "avg_sale_price"
      expr: AVG(CAST(sale_price AS DOUBLE))
      comment: "Average resale transaction price"
    - name: "avg_price_uplift_pct"
      expr: AVG(CAST(price_uplift_pct AS DOUBLE))
      comment: "Average percentage price uplift from original face value"
    - name: "avg_revenue_share_rate"
      expr: AVG(CAST(revenue_share_rate AS DOUBLE))
      comment: "Average revenue share rate percentage"
    - name: "price_uplift_pct"
      expr: ROUND(100.0 * (SUM(CAST(sale_price AS DOUBLE)) - SUM(CAST(original_face_value AS DOUBLE))) / NULLIF(SUM(CAST(original_face_value AS DOUBLE)), 0), 2)
      comment: "Aggregate percentage price uplift from original face value to resale price"
    - name: "platform_fee_rate"
      expr: ROUND(100.0 * SUM(CAST(platform_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(sale_price AS DOUBLE)), 0), 2)
      comment: "Platform fees as percentage of resale revenue"
    - name: "unique_sellers"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique sellers in resale marketplace"
    - name: "unique_buyers"
      expr: COUNT(DISTINCT buyer_fan_fan_profile_id)
      comment: "Number of unique buyers in resale marketplace"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`ticketing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund operations and customer service metrics including refund volume, processing efficiency, reason analysis, and financial impact"
  source: "`sports_entertainment_ecm`.`ticketing`.`refund`"
  dimensions:
    - name: "requested_date"
      expr: DATE_TRUNC('day', requested_timestamp)
      comment: "Date refund was requested"
    - name: "completed_date"
      expr: DATE_TRUNC('day', completed_timestamp)
      comment: "Date refund was completed"
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of refund request"
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (full, partial, exchange, etc.)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for refund request"
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to process refund"
    - name: "original_payment_method"
      expr: original_payment_method
      comment: "Original payment method for the order"
    - name: "is_event_initiated"
      expr: is_event_initiated
      comment: "Whether refund was initiated due to event cancellation or change"
    - name: "is_fraud_related"
      expr: is_fraud_related
      comment: "Whether refund is related to fraud"
    - name: "is_sla_breach"
      expr: sla_breach_flag
      comment: "Whether refund processing breached SLA"
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refund requests"
    - name: "total_gross_refund_amount"
      expr: SUM(CAST(gross_refund_amount AS DOUBLE))
      comment: "Total gross refund amount before fees"
    - name: "total_net_refund_amount"
      expr: SUM(CAST(net_refund_amount AS DOUBLE))
      comment: "Total net refund amount paid to customers"
    - name: "total_service_fee_refund"
      expr: SUM(CAST(service_fee_refund_amount AS DOUBLE))
      comment: "Total service fees refunded"
    - name: "total_tax_refund"
      expr: SUM(CAST(tax_refund_amount AS DOUBLE))
      comment: "Total tax amount refunded"
    - name: "avg_gross_refund_amount"
      expr: AVG(CAST(gross_refund_amount AS DOUBLE))
      comment: "Average gross refund amount per request"
    - name: "avg_net_refund_amount"
      expr: AVG(CAST(net_refund_amount AS DOUBLE))
      comment: "Average net refund amount per request"
    - name: "service_fee_retention_rate"
      expr: ROUND(100.0 * (1 - SUM(CAST(service_fee_refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_refund_amount AS DOUBLE)), 0)), 2)
      comment: "Percentage of service fees retained after refunds"
    - name: "unique_customers"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique customers requesting refunds"
    - name: "unique_events"
      expr: COUNT(DISTINCT event_fixture_id)
      comment: "Number of unique events with refund requests"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`ticketing_promo_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional campaign effectiveness metrics including redemption rates, discount impact, budget utilization, and ROI analysis"
  source: "`sports_entertainment_ecm`.`ticketing`.`promo_code`"
  dimensions:
    - name: "valid_from_date"
      expr: DATE_TRUNC('day', valid_from)
      comment: "Start date of promo code validity"
    - name: "valid_until_date"
      expr: DATE_TRUNC('day', valid_until)
      comment: "End date of promo code validity"
    - name: "code_status"
      expr: code_status
      comment: "Current status of promo code"
    - name: "code_type"
      expr: code_type
      comment: "Type of promotional code"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (percentage, fixed amount, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of promo code"
    - name: "is_presale"
      expr: is_presale
      comment: "Whether promo code is for presale access"
    - name: "is_season_ticket_holder_exclusive"
      expr: is_season_ticket_holder_exclusive
      comment: "Whether promo code is exclusive to season ticket holders"
    - name: "eligible_sales_channel"
      expr: eligible_sales_channel
      comment: "Sales channel where promo code is valid"
  measures:
    - name: "total_promo_codes"
      expr: COUNT(1)
      comment: "Total number of promotional codes"
    - name: "total_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated for promotional codes"
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value offered across all promo codes"
    - name: "total_redeemed_discount"
      expr: SUM(CAST(redeemed_discount_total AS DOUBLE))
      comment: "Total discount amount actually redeemed"
    - name: "total_max_discount"
      expr: SUM(CAST(max_discount_amount AS DOUBLE))
      comment: "Total maximum discount amount across all codes"
    - name: "total_min_order_amount"
      expr: SUM(CAST(min_order_amount AS DOUBLE))
      comment: "Total minimum order amount requirements across all codes"
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total number of times promo codes have been used"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per promo code"
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average number of redemptions per promo code"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(redeemed_discount_total AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of promotional budget utilized through redemptions"
    - name: "unique_sponsors"
      expr: COUNT(DISTINCT sponsor_id)
      comment: "Number of unique sponsors associated with promo codes"
    - name: "unique_franchises"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Number of unique franchises with promo codes"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`ticketing_group_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group sales performance metrics including volume, revenue, discount effectiveness, and fulfillment efficiency for corporate and bulk ticket buyers"
  source: "`sports_entertainment_ecm`.`ticketing`.`group_sale`"
  dimensions:
    - name: "sale_date"
      expr: DATE_TRUNC('day', sale_date)
      comment: "Date of group sale transaction"
    - name: "sale_month"
      expr: DATE_TRUNC('month', sale_date)
      comment: "Month of group sale transaction"
    - name: "sale_status"
      expr: sale_status
      comment: "Current status of group sale"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of group sale"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of group sale"
    - name: "group_type"
      expr: group_type
      comment: "Type of group (corporate, school, charity, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for group sale"
    - name: "has_catering"
      expr: catering_included
      comment: "Whether catering is included in group sale"
    - name: "seating_tier"
      expr: seating_tier
      comment: "Seating tier for group sale"
  measures:
    - name: "total_group_sales"
      expr: COUNT(1)
      comment: "Total number of group sale transactions"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue from group sales"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue from group sales after discounts"
    - name: "total_face_value"
      expr: SUM(CAST(face_value_price AS DOUBLE))
      comment: "Total face value of tickets in group sales"
    - name: "total_discount_amount"
      expr: SUM((CAST(face_value_price AS DOUBLE)) - (CAST(net_amount AS DOUBLE)))
      comment: "Total discount amount applied to group sales"
    - name: "total_catering_amount"
      expr: SUM(CAST(catering_amount AS DOUBLE))
      comment: "Total catering revenue from group sales"
    - name: "total_service_fees"
      expr: SUM(CAST(service_fee_amount AS DOUBLE))
      comment: "Total service fees collected from group sales"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected from group sales"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount collected"
    - name: "total_tickets_sold"
      expr: SUM(CAST(ticket_quantity AS DOUBLE))
      comment: "Total number of tickets sold through group sales"
    - name: "avg_group_size"
      expr: AVG(CAST(ticket_quantity AS DOUBLE))
      comment: "Average number of tickets per group sale"
    - name: "avg_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross revenue per group sale"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate percentage across group sales"
    - name: "discount_rate"
      expr: ROUND(100.0 * (SUM(CAST(face_value_price AS DOUBLE)) - SUM(CAST(net_amount AS DOUBLE))) / NULLIF(SUM(CAST(face_value_price AS DOUBLE)), 0), 2)
      comment: "Aggregate discount rate as percentage of face value"
    - name: "unique_franchises"
      expr: COUNT(DISTINCT franchise_id)
      comment: "Number of unique franchises with group sales"
    - name: "unique_venues"
      expr: COUNT(DISTINCT venue_id)
      comment: "Number of unique venues with group sales"
$$;