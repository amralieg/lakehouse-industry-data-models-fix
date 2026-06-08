-- Metric views for domain: ancillary | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core ancillary revenue and order performance metrics derived from ancillary orders. Tracks revenue yield, refund exposure, discount impact, and payment behaviour across cabin classes, sales channels, and routes — enabling commercial and revenue management teams to steer ancillary monetisation strategy."
  source: "`airlines_ecm`.`ancillary`.`ancillary_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the ancillary order (e.g. CONFIRMED, CANCELLED, PENDING) — used to filter active vs. lapsed revenue."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Indicates whether the ancillary service has been fulfilled, pending, or failed — critical for operational SLA tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (e.g. PAID, REFUNDED, PENDING) — used to reconcile cash vs. accrual revenue."
    - name: "payment_method"
      expr: payment_method
      comment: "Form of payment used (e.g. credit card, miles, voucher) — informs payment mix and cost-of-collection analysis."
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class associated with the ancillary order (e.g. ECONOMY, BUSINESS) — enables yield segmentation by cabin."
    - name: "booking_class"
      expr: booking_class
      comment: "Fare booking class at time of ancillary purchase — used to correlate ancillary attach rate with fare family."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue reporting and FX exposure analysis."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport of the associated flight — enables route-level ancillary revenue analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport of the associated flight — used with origin to define the O&D market for ancillary performance."
    - name: "point_of_sale_country"
      expr: point_of_sale_country
      comment: "Country where the ancillary was sold — supports geographic revenue attribution and regulatory reporting."
    - name: "emd_type"
      expr: emd_type
      comment: "Electronic Miscellaneous Document type associated with the order — used to classify ancillary service categories for IATA reporting."
    - name: "refund_eligibility"
      expr: CASE WHEN refund_eligibility = TRUE THEN 'Refundable' ELSE 'Non-Refundable' END
      comment: "Whether the ancillary order is eligible for refund — used to segment revenue by refundability risk."
    - name: "promotion_code"
      expr: promotion_code
      comment: "Promotion or discount code applied to the order — used to measure promotional campaign effectiveness and discount leakage."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', CAST(order_date AS TIMESTAMP))
      comment: "Month of order creation — primary time dimension for monthly ancillary revenue trend analysis."
    - name: "departure_date_month"
      expr: DATE_TRUNC('MONTH', departure_date)
      comment: "Month of flight departure — used to align ancillary revenue with flight schedule periods."
  measures:
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total ancillary revenue collected including base amount, fees, and taxes. Primary top-line KPI for ancillary commercial performance."
    - name: "total_base_revenue"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Sum of base ancillary charges before taxes and fees — used to isolate core product pricing yield from tax/fee components."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on ancillary orders — required for tax remittance reconciliation and regulatory compliance."
    - name: "total_fee_revenue"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total service and processing fees collected — used to track fee revenue as a distinct ancillary revenue stream."
    - name: "total_discount_given"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across ancillary orders — measures promotional cost and discount leakage impacting net revenue."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total value of refunds issued on ancillary orders — key risk metric for net revenue and cash flow management."
    - name: "net_ancillary_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net ancillary revenue after deducting refunds — the most accurate measure of realised ancillary income for P&L reporting."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total amount per ancillary order — measures ancillary yield per transaction and tracks upsell effectiveness over time."
    - name: "avg_base_amount_per_order"
      expr: AVG(CAST(base_amount AS DOUBLE))
      comment: "Average base charge per ancillary order — used to benchmark pricing strategy and detect price erosion across markets."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(refund_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Refund amount as a percentage of total ancillary revenue — measures revenue leakage risk and customer satisfaction signals."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(base_amount AS DOUBLE) + CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross base price — quantifies promotional dilution of ancillary yield for revenue management review."
    - name: "confirmed_order_count"
      expr: COUNT(CASE WHEN order_status = 'CONFIRMED' THEN ancillary_order_id END)
      comment: "Count of confirmed ancillary orders — baseline volume KPI for ancillary attach rate and demand forecasting."
    - name: "refundable_order_count"
      expr: COUNT(CASE WHEN refund_eligibility = TRUE THEN ancillary_order_id END)
      comment: "Number of orders eligible for refund — used to quantify contingent refund liability on the balance sheet."
    - name: "unique_pnr_count"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of distinct PNRs with at least one ancillary order — measures ancillary attach breadth across the booking population."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular ancillary order item metrics capturing per-product revenue, commission economics, and service fulfilment performance. Enables product-level profitability analysis, channel attribution, and operational service delivery tracking."
  source: "`airlines_ecm`.`ancillary`.`order_item`"
  dimensions:
    - name: "product_code"
      expr: product_code
      comment: "Ancillary product code (e.g. XBAG, SEAT, MEAL) — primary dimension for product-level revenue and volume analysis."
    - name: "product_name"
      expr: product_name
      comment: "Human-readable ancillary product name — used in business dashboards and executive reporting."
    - name: "service_status"
      expr: service_status
      comment: "Current delivery status of the ancillary service item — used to track fulfilment quality and identify service failures."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the ancillary was sold (e.g. WEB, MOBILE, GDS, AIRPORT) — critical for channel mix and distribution cost analysis."
    - name: "emd_type"
      expr: emd_type
      comment: "EMD service type code — used to classify items for IATA settlement and revenue accounting."
    - name: "ssr_code"
      expr: ssr_code
      comment: "Special Service Request code associated with the item — used to link ancillary items to operational service requests."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the order item — required for multi-currency revenue consolidation."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport for the flight associated with this item — enables route-level product performance analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport for the flight associated with this item — used with origin to define O&D market context."
    - name: "refund_eligibility"
      expr: CASE WHEN refund_eligibility = TRUE THEN 'Refundable' ELSE 'Non-Refundable' END
      comment: "Refundability flag for the order item — used to segment revenue by refund risk exposure."
    - name: "flight_date_month"
      expr: DATE_TRUNC('MONTH', flight_date)
      comment: "Month of the associated flight date — primary time dimension for aligning ancillary item revenue with flight operations."
    - name: "booking_date_month"
      expr: DATE_TRUNC('MONTH', CAST(booking_timestamp AS DATE))
      comment: "Month of booking — used to analyse advance purchase patterns and booking window effects on ancillary revenue."
  measures:
    - name: "total_item_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from ancillary order items — granular product-level revenue KPI for P&L attribution."
    - name: "total_base_revenue"
      expr: SUM(CAST(base_amount AS DOUBLE))
      comment: "Sum of base charges across order items — isolates core product pricing from tax and fee components."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on order items — used for tax remittance and regulatory compliance reporting."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees collected on order items — tracks fee revenue contribution by product and channel."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid on ancillary order items — measures distribution cost and agent incentive spend."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per ancillary item — used to benchmark pricing consistency and detect price variance across markets."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate across order items — used to monitor distribution cost trends and renegotiate agent agreements."
    - name: "commission_to_revenue_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Commission as a percentage of total item revenue — measures distribution cost efficiency and margin impact of agent channels."
    - name: "net_item_revenue_after_commission"
      expr: SUM(CAST(total_amount AS DOUBLE) - CAST(commission_amount AS DOUBLE))
      comment: "Net revenue per item after deducting commissions — the most accurate measure of ancillary margin contribution per product."
    - name: "unique_product_count"
      expr: COUNT(DISTINCT product_catalog_id)
      comment: "Number of distinct ancillary products sold — measures product portfolio breadth and identifies concentration risk."
    - name: "unique_pnr_count"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of distinct PNRs purchasing ancillary items — measures ancillary attach rate across the booking population."
    - name: "refundable_item_revenue"
      expr: SUM(CASE WHEN refund_eligibility = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Revenue from refundable ancillary items — quantifies contingent revenue at risk from potential refund claims."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_emd`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic Miscellaneous Document (EMD) metrics for ancillary services. Tracks EMD issuance value, tax economics, commission costs, and document lifecycle status — essential for IATA BSP/ARC settlement, revenue accounting, and regulatory compliance."
  source: "`airlines_ecm`.`ancillary`.`ancillary_emd`"
  dimensions:
    - name: "emd_status"
      expr: emd_status
      comment: "Current status of the EMD document (e.g. OPEN, USED, REFUNDED, VOID) — primary lifecycle dimension for settlement reconciliation."
    - name: "emd_type"
      expr: emd_type
      comment: "EMD type (EMD-S for standalone, EMD-A for associated) — determines settlement routing and IATA reporting classification."
    - name: "coupon_status"
      expr: coupon_status
      comment: "Status of the individual EMD coupon — used to track coupon-level utilisation and identify unused/expired value."
    - name: "ancillary_service_code"
      expr: ancillary_service_code
      comment: "ATPCO/IATA ancillary service code — used to classify EMD revenue by service type for regulatory and commercial reporting."
    - name: "issuing_airline_code"
      expr: issuing_airline_code
      comment: "IATA code of the airline that issued the EMD — used for interline proration and settlement attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the EMD transaction — required for BSP settlement and multi-currency revenue consolidation."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport on the EMD — used for route-level EMD revenue analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport on the EMD — used with origin to define the O&D market for EMD issuance analysis."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "IATA passenger type code (ADT, CHD, INF) — used to segment EMD revenue by passenger category."
    - name: "payment_method"
      expr: payment_method
      comment: "Form of payment on the EMD — used for payment mix analysis and fraud risk monitoring."
    - name: "refund_indicator"
      expr: CASE WHEN refund_indicator = TRUE THEN 'Refunded' ELSE 'Not Refunded' END
      comment: "Whether the EMD has been refunded — used to segment issued vs. net-settled EMD value."
    - name: "exchange_indicator"
      expr: CASE WHEN exchange_indicator = TRUE THEN 'Exchanged' ELSE 'Original' END
      comment: "Whether the EMD was issued as an exchange — used to track reissue activity and associated revenue adjustments."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of EMD issuance — primary time dimension for monthly EMD revenue and volume trend analysis."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service delivery — used to align EMD revenue recognition with service consumption."
  measures:
    - name: "total_emd_face_value"
      expr: SUM(CAST(face_value_amount AS DOUBLE))
      comment: "Total face value of all EMDs issued — primary revenue recognition metric for ancillary EMD settlement with BSP/ARC."
    - name: "total_emd_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on EMDs — required for tax authority remittance and regulatory compliance reporting."
    - name: "total_emd_total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount (face value + tax) collected across all EMDs — gross settlement value for BSP reconciliation."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid on EMDs — measures agent distribution cost for ancillary services sold via GDS/travel agents."
    - name: "avg_commission_percentage"
      expr: AVG(CAST(commission_percentage AS DOUBLE))
      comment: "Average commission rate on EMDs — used to benchmark and negotiate agent commission structures."
    - name: "net_emd_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE) - CAST(commission_amount AS DOUBLE))
      comment: "Net EMD revenue after deducting agent commissions — measures true ancillary income retained by the airline."
    - name: "avg_emd_face_value"
      expr: AVG(CAST(face_value_amount AS DOUBLE))
      comment: "Average face value per EMD — used to track ancillary yield per document and detect pricing anomalies."
    - name: "tax_to_total_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Tax as a percentage of total EMD amount — used to monitor tax burden by market and identify high-tax route exposure."
    - name: "commission_to_face_value_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(face_value_amount AS DOUBLE)), 0), 2)
      comment: "Commission as a percentage of EMD face value — measures distribution cost efficiency for agent-sold ancillary services."
    - name: "refunded_emd_count"
      expr: COUNT(CASE WHEN refund_indicator = TRUE THEN ancillary_emd_id END)
      comment: "Number of EMDs that have been refunded — tracks refund volume for cash flow and settlement impact analysis."
    - name: "unique_pnr_count"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of distinct PNRs with EMD issuances — measures ancillary EMD attach breadth across the booking population."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_upgrade_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upgrade transaction metrics tracking bid-based and complimentary cabin upgrade performance. Enables revenue management to optimise upgrade pricing, monitor bid acceptance rates, and measure miles vs. cash upgrade economics — a high-margin ancillary revenue stream."
  source: "`airlines_ecm`.`ancillary`.`upgrade_transaction`"
  dimensions:
    - name: "upgrade_status"
      expr: upgrade_status
      comment: "Current status of the upgrade transaction (e.g. CONFIRMED, WAITLISTED, DENIED, REFUNDED) — primary lifecycle dimension for upgrade funnel analysis."
    - name: "upgrade_type"
      expr: upgrade_type
      comment: "Type of upgrade (e.g. BID, COMPLIMENTARY, MILES, OPERATIONAL) — used to segment upgrade revenue by monetisation mechanism."
    - name: "origin_cabin_class"
      expr: origin_cabin_class
      comment: "Cabin class the passenger is upgrading from — used to analyse upgrade demand by source cabin."
    - name: "destination_cabin_class"
      expr: destination_cabin_class
      comment: "Cabin class the passenger is upgrading to — used to measure premium cabin fill rate contribution from upgrades."
    - name: "origin_fare_class"
      expr: origin_fare_class
      comment: "Fare class at time of upgrade request — used to correlate upgrade propensity with fare family."
    - name: "destination_fare_class"
      expr: destination_fare_class
      comment: "Fare class assigned after upgrade — used for revenue accounting and inventory management."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the upgrade was requested (e.g. WEB, APP, AIRPORT, CALL_CENTRE) — used for channel mix and cost-to-serve analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the upgrade (e.g. CASH, MILES, VOUCHER) — used to analyse payment mix and miles redemption economics."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency upgrade revenue consolidation."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denied upgrade requests — used to identify capacity constraints and policy barriers limiting upgrade revenue."
    - name: "upgrade_request_month"
      expr: DATE_TRUNC('MONTH', CAST(upgrade_request_timestamp AS DATE))
      comment: "Month of upgrade request — primary time dimension for monthly upgrade volume and revenue trend analysis."
    - name: "bid_acceptance_month"
      expr: DATE_TRUNC('MONTH', CAST(bid_acceptance_timestamp AS DATE))
      comment: "Month of bid acceptance — used to align upgrade revenue recognition with acceptance events."
  measures:
    - name: "total_upgrade_revenue"
      expr: SUM(CAST(upgrade_amount AS DOUBLE))
      comment: "Total cash revenue generated from upgrade transactions — primary top-line KPI for the upgrade ancillary revenue stream."
    - name: "total_bid_amount"
      expr: SUM(CAST(bid_amount AS DOUBLE))
      comment: "Total value of bids submitted for upgrades — measures overall upgrade demand and willingness-to-pay across the bid population."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued on upgrade transactions — measures revenue leakage from denied bids and cancellations."
    - name: "total_miles_redeemed"
      expr: SUM(CAST(miles_redeemed AS DOUBLE))
      comment: "Total frequent flyer miles redeemed for upgrades — measures loyalty programme liability consumption and miles-based upgrade demand."
    - name: "avg_upgrade_amount"
      expr: AVG(CAST(upgrade_amount AS DOUBLE))
      comment: "Average cash value per confirmed upgrade — used to benchmark upgrade yield and optimise bid floor pricing."
    - name: "avg_bid_amount"
      expr: AVG(CAST(bid_amount AS DOUBLE))
      comment: "Average bid amount submitted — measures passenger willingness-to-pay and informs dynamic bid floor calibration."
    - name: "avg_miles_redeemed_per_upgrade"
      expr: AVG(CAST(miles_redeemed AS DOUBLE))
      comment: "Average miles redeemed per upgrade transaction — used to value miles-based upgrades and manage loyalty liability."
    - name: "upgrade_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN upgrade_status = 'CONFIRMED' THEN upgrade_transaction_id END) / NULLIF(COUNT(upgrade_transaction_id), 0), 2)
      comment: "Percentage of upgrade requests that were confirmed — key conversion KPI for upgrade programme effectiveness and inventory optimisation."
    - name: "bid_to_upgrade_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(upgrade_amount AS DOUBLE)) / NULLIF(SUM(CAST(bid_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of confirmed upgrade revenue to total bid value submitted — measures bid programme revenue capture efficiency."
    - name: "net_upgrade_revenue"
      expr: SUM(CAST(upgrade_amount AS DOUBLE) - CAST(refund_amount AS DOUBLE))
      comment: "Net upgrade revenue after refunds — the realised upgrade income used for P&L and revenue management reporting."
    - name: "confirmed_upgrade_count"
      expr: COUNT(CASE WHEN upgrade_status = 'CONFIRMED' THEN upgrade_transaction_id END)
      comment: "Number of confirmed upgrades — volume KPI for premium cabin fill rate contribution from the upgrade programme."
    - name: "denied_upgrade_count"
      expr: COUNT(CASE WHEN upgrade_status = 'DENIED' THEN upgrade_transaction_id END)
      comment: "Number of denied upgrade requests — used to quantify unmet upgrade demand and identify capacity or policy constraints."
    - name: "unique_ffp_member_count"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of distinct frequent flyer members requesting upgrades — measures loyalty programme engagement with the upgrade product."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_seat_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seat assignment metrics tracking paid seat selection revenue, complimentary seat allocation, and assignment method distribution. Enables product and revenue teams to optimise seat product pricing, measure loyalty benefit costs, and monitor operational seat assignment patterns."
  source: "`airlines_ecm`.`ancillary`.`seat_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the seat assignment (e.g. CONFIRMED, CANCELLED, CHANGED) — primary lifecycle dimension for seat inventory management."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method by which the seat was assigned (e.g. SELF_SELECT, AUTO_ASSIGN, AGENT, CHECK_IN) — used to analyse channel mix and cost-to-assign."
    - name: "cabin_class_code"
      expr: cabin_class_code
      comment: "Cabin class of the assigned seat — used to segment seat fee revenue and complimentary allocation by cabin."
    - name: "seat_characteristics"
      expr: seat_characteristics
      comment: "Seat feature codes (e.g. WINDOW, AISLE, EXIT_ROW, EXTRA_LEGROOM) — used to analyse premium seat demand and pricing effectiveness."
    - name: "upgrade_type"
      expr: upgrade_type
      comment: "Type of upgrade associated with the seat assignment — used to link seat assignments to upgrade transactions."
    - name: "is_complimentary"
      expr: CASE WHEN is_complimentary = TRUE THEN 'Complimentary' ELSE 'Paid' END
      comment: "Whether the seat was assigned complimentarily — used to measure loyalty benefit cost vs. paid seat revenue."
    - name: "is_blocked"
      expr: CASE WHEN is_blocked = TRUE THEN 'Blocked' ELSE 'Available' END
      comment: "Whether the seat is blocked — used to monitor blocked seat inventory and its impact on paid seat availability."
    - name: "loyalty_tier_at_assignment"
      expr: loyalty_tier_at_assignment
      comment: "Loyalty tier of the passenger at time of seat assignment — used to measure tier-based complimentary seat benefit costs."
    - name: "seat_fee_currency_code"
      expr: seat_fee_currency_code
      comment: "Currency of the seat fee — required for multi-currency seat revenue consolidation."
    - name: "deck_level"
      expr: deck_level
      comment: "Aircraft deck level (MAIN, UPPER) — used for wide-body aircraft seat product analysis."
    - name: "assignment_date_month"
      expr: DATE_TRUNC('MONTH', CAST(assignment_timestamp AS DATE))
      comment: "Month of seat assignment — primary time dimension for monthly seat revenue and volume trend analysis."
  measures:
    - name: "total_seat_fee_revenue"
      expr: SUM(CAST(seat_fee_amount AS DOUBLE))
      comment: "Total revenue from paid seat selection fees — primary KPI for the seat ancillary product revenue stream."
    - name: "avg_seat_fee_amount"
      expr: AVG(CAST(seat_fee_amount AS DOUBLE))
      comment: "Average seat fee per assignment — used to benchmark seat pricing yield and detect price variance across routes and cabin classes."
    - name: "paid_seat_revenue"
      expr: SUM(CASE WHEN is_complimentary = FALSE THEN CAST(seat_fee_amount AS DOUBLE) ELSE 0 END)
      comment: "Revenue from non-complimentary paid seat assignments — isolates commercial seat revenue from loyalty benefit costs."
    - name: "complimentary_seat_cost"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN CAST(seat_fee_amount AS DOUBLE) ELSE 0 END)
      comment: "Foregone revenue from complimentary seat assignments — quantifies the cost of loyalty tier seat benefits for programme economics analysis."
    - name: "complimentary_seat_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_complimentary = TRUE THEN seat_assignment_id END) / NULLIF(COUNT(seat_assignment_id), 0), 2)
      comment: "Percentage of seat assignments that are complimentary — measures loyalty benefit utilisation rate and its impact on paid seat yield."
    - name: "paid_seat_assignment_count"
      expr: COUNT(CASE WHEN is_complimentary = FALSE AND seat_fee_amount > 0 THEN seat_assignment_id END)
      comment: "Number of paid seat assignments — volume KPI for seat product commercial performance."
    - name: "blocked_seat_count"
      expr: COUNT(CASE WHEN is_blocked = TRUE THEN seat_assignment_id END)
      comment: "Number of blocked seat assignments — used to monitor inventory held back from sale and its revenue opportunity cost."
    - name: "unique_pnr_count"
      expr: COUNT(DISTINCT pnr_id)
      comment: "Number of distinct PNRs with seat assignments — measures seat product attach rate across the booking population."
    - name: "unique_ffp_member_seat_count"
      expr: COUNT(DISTINCT ffp_member_id)
      comment: "Number of distinct FFP members with seat assignments — measures loyalty member engagement with the seat product."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_product_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ancillary product catalogue metrics tracking portfolio composition, pricing benchmarks, and product policy attributes. Enables product management teams to govern the ancillary product portfolio, monitor pricing strategy, and ensure catalogue health for commercial and regulatory compliance."
  source: "`airlines_ecm`.`ancillary`.`product_catalog`"
  dimensions:
    - name: "product_status"
      expr: product_status
      comment: "Current status of the product in the catalogue (e.g. ACTIVE, INACTIVE, DEPRECATED) — used to monitor active product portfolio size."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the product (e.g. FIXED, DYNAMIC, WEIGHT_BASED) — used to segment portfolio by pricing strategy."
    - name: "iata_emd_service_type"
      expr: iata_emd_service_type
      comment: "IATA EMD service type classification — used for regulatory reporting and IATA settlement categorisation."
    - name: "refundable_flag"
      expr: CASE WHEN refundable_flag = TRUE THEN 'Refundable' ELSE 'Non-Refundable' END
      comment: "Whether the product is refundable — used to segment portfolio by refund policy and manage revenue risk."
    - name: "transferable_flag"
      expr: CASE WHEN transferable_flag = TRUE THEN 'Transferable' ELSE 'Non-Transferable' END
      comment: "Whether the product can be transferred between passengers — used to assess product flexibility and customer value."
    - name: "inventory_controlled_flag"
      expr: CASE WHEN inventory_controlled_flag = TRUE THEN 'Inventory Controlled' ELSE 'Open Sell' END
      comment: "Whether the product is subject to inventory controls — used to identify capacity-constrained vs. open-sell ancillary products."
    - name: "partner_product_flag"
      expr: CASE WHEN partner_product_flag = TRUE THEN 'Partner Product' ELSE 'Own Product' END
      comment: "Whether the product is sourced from a partner — used to segment own vs. partner ancillary revenue and margin."
    - name: "channel_availability"
      expr: channel_availability
      comment: "Channels through which the product is available for sale — used to assess distribution reach and channel strategy."
    - name: "base_price_currency"
      expr: base_price_currency
      comment: "Currency of the base price — used for multi-currency pricing governance and FX exposure analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the product became effective — used to track product launch cadence and portfolio refresh rate."
  measures:
    - name: "active_product_count"
      expr: COUNT(CASE WHEN product_status = 'ACTIVE' THEN product_catalog_id END)
      comment: "Number of active ancillary products in the catalogue — measures portfolio breadth available for sale at any point in time."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price_amount AS DOUBLE))
      comment: "Average base price across ancillary products — used to benchmark portfolio pricing level and detect price drift over time."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across products — used to monitor distribution cost commitments embedded in the product catalogue."
    - name: "refundable_product_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refundable_flag = TRUE THEN product_catalog_id END) / NULLIF(COUNT(product_catalog_id), 0), 2)
      comment: "Percentage of products that are refundable — measures refund policy exposure across the ancillary portfolio."
    - name: "inventory_controlled_product_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inventory_controlled_flag = TRUE THEN product_catalog_id END) / NULLIF(COUNT(product_catalog_id), 0), 2)
      comment: "Percentage of products subject to inventory controls — used to assess capacity management complexity in the ancillary portfolio."
    - name: "partner_product_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN partner_product_flag = TRUE THEN product_catalog_id END) / NULLIF(COUNT(product_catalog_id), 0), 2)
      comment: "Percentage of ancillary products sourced from partners — measures partner dependency and own-product vs. partner-product mix."
    - name: "max_base_price"
      expr: MAX(CAST(base_price_amount AS DOUBLE))
      comment: "Maximum base price in the product catalogue — used to identify premium-priced products and detect pricing outliers."
    - name: "min_base_price"
      expr: MIN(CAST(base_price_amount AS DOUBLE))
      comment: "Minimum base price in the product catalogue — used to identify entry-level products and ensure pricing floor compliance."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ancillary pricing metrics tracking fare levels, tax components, commission rates, and pricing policy attributes across routes, cabin classes, and passenger types. Enables revenue management to govern ancillary price points, monitor yield by market, and ensure pricing strategy alignment."
  source: "`airlines_ecm`.`ancillary`.`price`"
  dimensions:
    - name: "price_status"
      expr: price_status
      comment: "Current status of the price record (e.g. ACTIVE, EXPIRED, SUPERSEDED) — used to filter live pricing for revenue management analysis."
    - name: "price_type"
      expr: price_type
      comment: "Type of price (e.g. BASE, PROMOTIONAL, DYNAMIC) — used to segment pricing strategy and measure promotional price penetration."
    - name: "service_type"
      expr: service_type
      comment: "Ancillary service type associated with the price — used to analyse pricing levels by service category."
    - name: "passenger_type_code"
      expr: passenger_type_code
      comment: "Passenger type the price applies to (ADT, CHD, INF) — used to segment pricing by passenger category."
    - name: "booking_class"
      expr: booking_class
      comment: "Booking class the price applies to — used to correlate ancillary pricing with fare family strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price record — required for multi-currency pricing governance."
    - name: "origin_airport_code"
      expr: origin_airport_code
      comment: "Origin airport for the price applicability — used for route-level pricing analysis."
    - name: "destination_airport_code"
      expr: destination_airport_code
      comment: "Destination airport for the price applicability — used with origin to define O&D market pricing."
    - name: "market_code"
      expr: market_code
      comment: "Market code for the price — used to group pricing by commercial market for yield management."
    - name: "refundable_flag"
      expr: CASE WHEN refundable_flag = TRUE THEN 'Refundable' ELSE 'Non-Refundable' END
      comment: "Whether the price is for a refundable product — used to segment pricing by refund policy."
    - name: "emd_type"
      expr: emd_type
      comment: "EMD type associated with the price — used for IATA settlement classification."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the price became effective — used to track pricing change cadence and seasonal pricing patterns."
  measures:
    - name: "avg_fare_amount"
      expr: AVG(CAST(fare_amount AS DOUBLE))
      comment: "Average ancillary fare amount across price records — primary pricing benchmark KPI for revenue management and competitive analysis."
    - name: "avg_total_price"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total price (fare + tax) across price records — measures all-in price level for customer-facing pricing governance."
    - name: "avg_tax_amount"
      expr: AVG(CAST(tax_amount AS DOUBLE))
      comment: "Average tax component per price record — used to monitor tax burden by market and route."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across price records — used to monitor distribution cost commitments in the pricing catalogue."
    - name: "max_fare_amount"
      expr: MAX(CAST(fare_amount AS DOUBLE))
      comment: "Maximum fare amount in the pricing catalogue — used to identify premium price points and detect pricing ceiling breaches."
    - name: "min_fare_amount"
      expr: MIN(CAST(fare_amount AS DOUBLE))
      comment: "Minimum fare amount in the pricing catalogue — used to enforce pricing floor compliance and identify below-floor prices."
    - name: "tax_to_fare_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(fare_amount AS DOUBLE)), 0), 2)
      comment: "Tax as a percentage of fare amount across price records — measures tax burden relative to base pricing by market and route."
    - name: "active_price_record_count"
      expr: COUNT(CASE WHEN price_status = 'ACTIVE' THEN price_id END)
      comment: "Number of active price records — measures pricing catalogue coverage and identifies gaps in market/route pricing."
    - name: "refundable_price_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN refundable_flag = TRUE THEN price_id END) / NULLIF(COUNT(price_id), 0), 2)
      comment: "Percentage of price records that are refundable — used to assess refund policy exposure in the pricing catalogue."
$$;