-- Metric views for domain: consumer | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_dtc_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct-to-consumer order performance metrics covering revenue, discounting, fulfillment, and subscription behaviour. Primary KPI surface for DTC channel steering."
  source: "`consumer_goods_ecm`.`consumer`.`dtc_order`"
  dimensions:
    - name: "order_channel"
      expr: channel_code
      comment: "Sales channel through which the DTC order was placed (e.g. web, mobile, app)."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. placed, shipped, delivered, cancelled)."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Warehouse/logistics fulfilment state of the order."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment instrument used (e.g. credit card, PayPal, BNPL)."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the order."
    - name: "is_subscription_order"
      expr: subscription_order_flag
      comment: "Indicates whether the order originated from a subscription programme."
    - name: "is_gift_order"
      expr: gift_order_flag
      comment: "Indicates whether the order was placed as a gift."
    - name: "is_return"
      expr: return_flag
      comment: "Indicates whether the order has an associated return."
    - name: "device_type"
      expr: device_type
      comment: "Device category used to place the order (e.g. desktop, mobile, tablet)."
    - name: "order_date_day"
      expr: DATE_TRUNC('DAY', order_date)
      comment: "Order date truncated to day for daily trend analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order date truncated to month for monthly trend analysis."
    - name: "ip_country_code"
      expr: ip_country_code
      comment: "Country inferred from the shopper IP address at order time."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of DTC orders placed. Baseline volume KPI for channel health."
    - name: "total_order_revenue"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Gross DTC revenue (order total including tax and shipping). Primary top-line revenue KPI."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of order subtotals before tax and shipping. Used to isolate product revenue from fulfilment costs."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total promotional and coupon discounts granted. Tracks promotional spend erosion on DTC revenue."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected from consumers. Informs shipping cost recovery analysis."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across DTC orders. Required for tax compliance reporting."
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value (AOV). Core DTC efficiency KPI — rising AOV signals upsell/basket-size improvement."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount granted per order. Monitors promotional intensity and margin risk."
    - name: "subscription_order_count"
      expr: COUNT(CASE WHEN subscription_order_flag = TRUE THEN 1 END)
      comment: "Number of orders originating from subscriptions. Tracks subscription channel contribution to DTC volume."
    - name: "return_order_count"
      expr: COUNT(CASE WHEN return_flag = TRUE THEN 1 END)
      comment: "Number of orders with a return. Numerator for return rate calculation."
    - name: "distinct_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Unique shoppers who placed at least one DTC order. Measures active buyer base size."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_dtc_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level DTC order metrics enabling SKU, category, and brand-level revenue, margin, and return analysis. Supports product performance and profitability steering."
  source: "`consumer_goods_ecm`.`consumer`.`dtc_order_line`"
  dimensions:
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the ordered SKU."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel for the order line."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment state of the individual order line."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the line."
    - name: "is_returned"
      expr: is_returned
      comment: "Indicates whether this line item was returned."
    - name: "is_subscription_line"
      expr: subscription_flag
      comment: "Indicates whether the line is part of a subscription order."
    - name: "is_gift"
      expr: gift_flag
      comment: "Indicates whether the line was ordered as a gift."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return on this line. Used to identify quality or fulfilment issues."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Actual ship date truncated to month for shipment trend analysis."
    - name: "actual_delivery_date_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Actual delivery date truncated to month for delivery performance trending."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total gross revenue at line level. Primary product-level revenue KPI."
    - name: "total_line_net_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net revenue after discounts at line level. Used for net revenue reporting by SKU/brand."
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold at line level. Required for gross margin calculation."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount value granted at line level. Tracks promotional erosion by SKU/brand."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at line level."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit. Monitors price realisation vs. list price."
    - name: "avg_line_discount_pct"
      expr: AVG(CAST(line_discount_pct AS DOUBLE))
      comment: "Average discount percentage applied at line level. Signals promotional depth by SKU/brand."
    - name: "returned_line_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Number of returned order lines. Numerator for line return rate."
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total order lines. Denominator for return rate and other line-level ratios."
    - name: "distinct_skus_ordered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs ordered. Measures product breadth in DTC channel."
    - name: "distinct_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Unique shoppers with at least one order line. Supports buyer reach analysis at SKU/brand level."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_dtc_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DTC return and refund metrics covering return volume, refund value, fraud risk, and quality signals. Supports returns management, fraud control, and consumer satisfaction steering."
  source: "`consumer_goods_ecm`.`consumer`.`dtc_return`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current status of the return request (e.g. requested, approved, rejected, completed)."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Coded reason for the return. Key driver for quality and fulfilment root-cause analysis."
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which the return was initiated (e.g. online, in-store, call centre)."
    - name: "return_method"
      expr: return_method
      comment: "Physical return method (e.g. carrier drop-off, in-store, mail)."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g. original payment, store credit, loyalty points)."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition of the returned product (e.g. restock, destroy, donate)."
    - name: "product_condition_code"
      expr: product_condition_code
      comment: "Condition of the returned product. Informs restocking and write-off decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund transaction."
    - name: "is_fraud_review"
      expr: fraud_review_flag
      comment: "Indicates whether the return was flagged for fraud review."
    - name: "is_safety_incident"
      expr: safety_incident_flag
      comment: "Indicates whether the return is linked to a safety incident. Critical for regulatory and quality escalation."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Return request date truncated to month for trend analysis."
  measures:
    - name: "total_returns"
      expr: COUNT(1)
      comment: "Total number of return requests. Baseline return volume KPI."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total gross refund value issued. Measures financial exposure from returns."
    - name: "total_net_refund_amount"
      expr: SUM(CAST(net_refund_amount AS DOUBLE))
      comment: "Total net refund after restocking fees. Reflects actual cash outflow from returns."
    - name: "total_restocking_fee_revenue"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected. Offsets return processing costs."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund value per return. Monitors refund magnitude trends."
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across returns. Elevated scores signal systemic return fraud risk."
    - name: "fraud_flagged_returns"
      expr: COUNT(CASE WHEN fraud_review_flag = TRUE THEN 1 END)
      comment: "Number of returns flagged for fraud review. Tracks fraud exposure in the returns channel."
    - name: "safety_incident_returns"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of returns linked to safety incidents. Critical regulatory and quality KPI."
    - name: "distinct_shoppers_returning"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Unique shoppers who initiated a return. Identifies repeat returners and potential policy abuse."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_loyalty_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty programme health metrics covering enrolment, tier distribution, points economics, and engagement. Supports loyalty investment decisions and programme optimisation."
  source: "`consumer_goods_ecm`.`consumer`.`loyalty_account`"
  dimensions:
    - name: "membership_tier"
      expr: membership_tier
      comment: "Current loyalty tier of the account (e.g. Bronze, Silver, Gold, Platinum)."
    - name: "account_status"
      expr: account_status
      comment: "Operational status of the loyalty account (e.g. active, suspended, closed)."
    - name: "account_type"
      expr: account_type
      comment: "Type of loyalty account (e.g. individual, household, business)."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the consumer enrolled in the loyalty programme."
    - name: "country_code"
      expr: country_code
      comment: "Country of the loyalty account holder."
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "Customer lifetime value segment assigned to the account."
    - name: "is_fraud_flagged"
      expr: fraud_flag
      comment: "Indicates whether the account has been flagged for fraudulent activity."
    - name: "preferred_redemption_type"
      expr: preferred_redemption_type
      comment: "Consumer's preferred method of redeeming loyalty points."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Enrolment date truncated to month for cohort and growth analysis."
    - name: "points_currency_code"
      expr: points_currency_code
      comment: "Currency denomination of the loyalty points programme."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'active' THEN 1 END)
      comment: "Number of active loyalty accounts. Core programme health KPI."
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total loyalty accounts including all statuses. Baseline enrolment size."
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all accounts. Represents loyalty liability on the balance sheet."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total points ever earned across all accounts. Measures programme engagement depth."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total points ever redeemed. Measures programme value delivery to consumers."
    - name: "total_lifetime_points_expired"
      expr: SUM(CAST(lifetime_points_expired AS DOUBLE))
      comment: "Total points expired without redemption. High expiry signals poor programme engagement."
    - name: "avg_points_balance"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average points balance per account. Monitors per-member engagement level."
    - name: "avg_tier_qualification_spend"
      expr: AVG(CAST(tier_qualification_spend AS DOUBLE))
      comment: "Average qualifying spend required for tier attainment. Informs tier threshold calibration."
    - name: "fraud_flagged_accounts"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of accounts flagged for fraud. Tracks programme integrity risk."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty points transaction economics covering earn, redemption, and reversal flows. Supports programme ROI, liability management, and fraud detection."
  source: "`consumer_goods_ecm`.`consumer`.`loyalty_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (e.g. earn, redeem, expire, adjust, reverse)."
    - name: "points_direction"
      expr: points_direction
      comment: "Direction of points movement (credit or debit)."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the loyalty transaction."
    - name: "channel"
      expr: channel
      comment: "Channel through which the loyalty transaction was triggered."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the loyalty transaction."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the monetary value associated with the transaction."
    - name: "is_bonus_transaction"
      expr: is_bonus_transaction
      comment: "Indicates whether the transaction includes a bonus points multiplier."
    - name: "is_fraud_flagged"
      expr: fraud_flag
      comment: "Indicates whether the transaction was flagged for fraud."
    - name: "trigger_event"
      expr: trigger_event
      comment: "Business event that triggered the loyalty transaction (e.g. purchase, referral, birthday)."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Transaction timestamp truncated to month for trend analysis."
    - name: "program_year"
      expr: program_year
      comment: "Programme year of the transaction for annual programme performance comparison."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total loyalty transactions. Baseline activity volume KPI."
    - name: "total_points_transacted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points moved across all transactions. Measures overall programme activity."
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value associated with loyalty transactions. Links points activity to revenue."
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total qualifying spend that generated loyalty points. Measures spend driven by the programme."
    - name: "total_redemption_value"
      expr: SUM(CAST(redemption_value AS DOUBLE))
      comment: "Total monetary value of points redeemed. Represents programme liability converted to consumer benefit."
    - name: "avg_earn_rate"
      expr: AVG(CAST(earn_rate AS DOUBLE))
      comment: "Average points earn rate per transaction. Monitors programme generosity and cost."
    - name: "avg_bonus_multiplier"
      expr: AVG(CAST(bonus_multiplier AS DOUBLE))
      comment: "Average bonus multiplier applied. Tracks promotional points inflation."
    - name: "fraud_flagged_transactions"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of transactions flagged for fraud. Monitors programme integrity."
    - name: "distinct_active_accounts"
      expr: COUNT(DISTINCT loyalty_account_id)
      comment: "Unique loyalty accounts with at least one transaction in the period. Measures active programme participation."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_shopper`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer master metrics covering acquisition, lifecycle, consent, and engagement. Supports CRM investment, lifecycle management, and regulatory compliance decisions."
  source: "`consumer_goods_ecm`.`consumer`.`shopper`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Consumer lifecycle stage (e.g. prospect, active, lapsed, churned)."
    - name: "consumer_type"
      expr: consumer_type
      comment: "Classification of the consumer (e.g. individual, business, household)."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty programme tier of the shopper."
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "Customer lifetime value segment assigned to the shopper."
    - name: "country_code"
      expr: country_code
      comment: "Country of the shopper."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the shopper was acquired."
    - name: "gender"
      expr: gender
      comment: "Self-reported gender of the shopper. Used for demographic segmentation."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Shopper's preferred communication language."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether the shopper has opted in to email marketing."
    - name: "sms_opt_in"
      expr: sms_opt_in
      comment: "Whether the shopper has opted in to SMS marketing."
    - name: "is_gdpr_subject"
      expr: gdpr_subject
      comment: "Whether the shopper is subject to GDPR regulations."
    - name: "is_ccpa_subject"
      expr: ccpa_subject
      comment: "Whether the shopper is subject to CCPA regulations."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Acquisition date truncated to month for cohort analysis."
    - name: "preferred_store_banner"
      expr: preferred_store_banner
      comment: "Shopper's preferred retail banner. Informs retail partnership and channel strategy."
  measures:
    - name: "total_shoppers"
      expr: COUNT(1)
      comment: "Total registered shoppers. Baseline consumer base size KPI."
    - name: "active_shoppers"
      expr: COUNT(CASE WHEN lifecycle_status = 'active' THEN 1 END)
      comment: "Number of shoppers in active lifecycle status. Core CRM health metric."
    - name: "email_opted_in_shoppers"
      expr: COUNT(CASE WHEN email_opt_in = TRUE THEN 1 END)
      comment: "Shoppers opted in to email marketing. Measures addressable email audience size."
    - name: "sms_opted_in_shoppers"
      expr: COUNT(CASE WHEN sms_opt_in = TRUE THEN 1 END)
      comment: "Shoppers opted in to SMS marketing. Measures addressable SMS audience size."
    - name: "loyalty_enrolled_shoppers"
      expr: COUNT(CASE WHEN loyalty_enrollment_date IS NOT NULL THEN 1 END)
      comment: "Shoppers enrolled in the loyalty programme. Measures loyalty programme penetration of the consumer base."
    - name: "identity_verified_shoppers"
      expr: COUNT(CASE WHEN identity_verified = TRUE THEN 1 END)
      comment: "Shoppers with verified identity. Supports fraud risk and data quality governance."
    - name: "avg_loyalty_points_balance"
      expr: AVG(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Average loyalty points balance per shopper. Monitors per-consumer engagement with the loyalty programme."
    - name: "push_notification_opted_in_shoppers"
      expr: COUNT(CASE WHEN push_notification_opt_in = TRUE THEN 1 END)
      comment: "Shoppers opted in to push notifications. Measures mobile engagement channel reach."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription programme metrics covering active subscriptions, revenue, churn, and trial conversion. Supports recurring revenue management and subscriber retention decisions."
  source: "`consumer_goods_ecm`.`consumer`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (e.g. active, paused, cancelled, trial)."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g. replenishment, curated box, service)."
    - name: "frequency"
      expr: frequency
      comment: "Delivery/billing frequency of the subscription (e.g. weekly, monthly, quarterly)."
    - name: "channel"
      expr: channel
      comment: "Channel through which the subscription was acquired."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the subscription."
    - name: "acquisition_source"
      expr: acquisition_source
      comment: "Source that drove the subscription acquisition."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method used for subscription billing."
    - name: "is_trial"
      expr: trial_flag
      comment: "Indicates whether the subscription is in a trial period."
    - name: "is_auto_renew"
      expr: auto_renew_flag
      comment: "Indicates whether the subscription auto-renews."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation. Key churn root-cause dimension."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Subscription start date truncated to month for cohort and growth analysis."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total subscriptions across all statuses. Baseline subscription portfolio size."
    - name: "active_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'active' THEN 1 END)
      comment: "Number of currently active subscriptions. Primary recurring revenue health KPI."
    - name: "cancelled_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'cancelled' THEN 1 END)
      comment: "Number of cancelled subscriptions. Numerator for churn rate calculation."
    - name: "trial_subscriptions"
      expr: COUNT(CASE WHEN trial_flag = TRUE THEN 1 END)
      comment: "Number of subscriptions currently in trial. Measures trial pipeline for conversion forecasting."
    - name: "total_subscription_revenue"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Sum of subscription prices (gross). Approximates recurring revenue run-rate."
    - name: "total_net_subscription_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Sum of net subscription prices after discounts. Measures actual recurring revenue."
    - name: "avg_subscription_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average subscription price. Monitors pricing strategy effectiveness."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to subscriptions. Tracks promotional depth in subscription channel."
    - name: "distinct_subscribing_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Unique shoppers with at least one subscription. Measures subscriber base breadth."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score response metrics covering score distribution, sentiment, and closed-loop performance. Supports consumer satisfaction and brand health steering."
  source: "`consumer_goods_ecm`.`consumer`.`nps_response`"
  dimensions:
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the NPS survey was delivered (e.g. email, in-app, SMS)."
    - name: "survey_trigger_event"
      expr: survey_trigger_event
      comment: "Business event that triggered the NPS survey (e.g. post-purchase, post-return, anniversary)."
    - name: "consumer_segment"
      expr: consumer_segment
      comment: "Consumer segment of the survey respondent."
    - name: "respondent_category"
      expr: respondent_category
      comment: "NPS respondent category (Promoter, Passive, Detractor)."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the verbatim response (e.g. positive, neutral, negative)."
    - name: "brand_name"
      expr: brand_name
      comment: "Brand for which the NPS survey was conducted."
    - name: "country_code"
      expr: country_code
      comment: "Country of the survey respondent."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the respondent made their most recent purchase."
    - name: "closed_loop_status"
      expr: closed_loop_status
      comment: "Status of the closed-loop follow-up action for detractors."
    - name: "device_type"
      expr: device_type
      comment: "Device used to complete the NPS survey."
    - name: "survey_date_month"
      expr: DATE_TRUNC('MONTH', survey_date)
      comment: "Survey date truncated to month for NPS trend analysis."
    - name: "is_repeat_buyer"
      expr: repeat_buyer_flag
      comment: "Indicates whether the respondent is a repeat buyer."
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total NPS survey responses received. Baseline response volume KPI."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN respondent_category = 'Promoter' THEN 1 END)
      comment: "Number of Promoter responses (NPS score 9-10). Numerator for NPS calculation."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN respondent_category = 'Detractor' THEN 1 END)
      comment: "Number of Detractor responses (NPS score 0-6). Subtracted in NPS calculation."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from NLP analysis of verbatim comments. Complements NPS with qualitative signal."
    - name: "closed_loop_completed_count"
      expr: COUNT(CASE WHEN closed_loop_status = 'completed' THEN 1 END)
      comment: "Number of detractor cases with completed closed-loop follow-up. Measures service recovery effectiveness."
    - name: "distinct_responding_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Unique shoppers who responded to an NPS survey. Measures survey reach across the consumer base."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer interaction and service metrics covering contact volume, resolution, escalation, SLA compliance, and sentiment. Supports contact centre efficiency and consumer experience decisions."
  source: "`consumer_goods_ecm`.`consumer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of consumer interaction (e.g. complaint, enquiry, feedback, return request)."
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred (e.g. phone, email, chat, social)."
    - name: "contact_reason_code"
      expr: contact_reason_code
      comment: "Coded reason for the consumer contact. Drives root-cause analysis of contact drivers."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (e.g. open, resolved, escalated, closed)."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the interaction was resolved (e.g. refund, replacement, information provided)."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the interaction (e.g. positive, neutral, negative)."
    - name: "is_escalated"
      expr: escalation_flag
      comment: "Indicates whether the interaction was escalated."
    - name: "is_sla_breach"
      expr: sla_breach_flag
      comment: "Indicates whether the interaction breached its SLA target."
    - name: "is_adverse_event"
      expr: adverse_event_flag
      comment: "Indicates whether the interaction involves an adverse event (e.g. product safety issue)."
    - name: "is_bot_handled"
      expr: is_bot_handled
      comment: "Indicates whether the interaction was handled by an automated bot."
    - name: "country_code"
      expr: country_code
      comment: "Country of the consumer interaction."
    - name: "interaction_date_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Interaction timestamp truncated to month for volume and trend analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the interaction (e.g. low, medium, high, critical)."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total consumer interactions. Baseline contact volume KPI for service operations."
    - name: "escalated_interactions"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated interactions. High escalation rate signals systemic service quality issues."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of interactions that breached SLA targets. Core service level compliance KPI."
    - name: "adverse_event_count"
      expr: COUNT(CASE WHEN adverse_event_flag = TRUE THEN 1 END)
      comment: "Number of interactions flagged as adverse events. Critical regulatory and safety KPI."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across interactions. Tracks consumer experience quality over time."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across interactions. Monitors service commitment levels."
    - name: "bot_handled_interactions"
      expr: COUNT(CASE WHEN is_bot_handled = TRUE THEN 1 END)
      comment: "Number of interactions handled by bots. Measures automation penetration in service operations."
    - name: "distinct_shoppers_contacting"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Unique shoppers who initiated a consumer interaction. Measures service demand breadth."
    - name: "repeat_contact_count"
      expr: COUNT(CASE WHEN repeat_contact_flag = TRUE THEN 1 END)
      comment: "Number of repeat contacts for the same issue. High repeat contact rate signals unresolved root causes."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`consumer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer consent and privacy compliance metrics covering consent coverage, opt-in rates, withdrawal trends, and regulatory jurisdiction exposure. Supports GDPR/CCPA compliance and data governance decisions."
  source: "`consumer_goods_ecm`.`consumer`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g. marketing, data processing, profiling, third-party sharing)."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. granted, withdrawn, expired)."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (e.g. consent, legitimate interest, contract)."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the consent record (e.g. EU-GDPR, US-CCPA)."
    - name: "capture_method"
      expr: capture_method
      comment: "Method used to capture consent (e.g. web form, in-store, call centre)."
    - name: "country_code"
      expr: country_code
      comment: "Country associated with the consent record."
    - name: "is_double_opt_in"
      expr: double_opt_in_flag
      comment: "Indicates whether double opt-in was completed. Higher quality consent signal."
    - name: "is_parental_consent"
      expr: parental_consent_flag
      comment: "Indicates whether parental consent was obtained (for minors)."
    - name: "is_profiling_consent"
      expr: profiling_consent_flag
      comment: "Indicates whether consent for profiling was granted."
    - name: "is_third_party_sharing"
      expr: third_party_sharing_flag
      comment: "Indicates whether consent for third-party data sharing was granted."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (e.g. brand-level, category-level, global)."
    - name: "capture_date_month"
      expr: DATE_TRUNC('MONTH', capture_timestamp)
      comment: "Consent capture timestamp truncated to month for consent trend analysis."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records. Baseline consent portfolio size for compliance reporting."
    - name: "active_consents"
      expr: COUNT(CASE WHEN consent_status = 'granted' THEN 1 END)
      comment: "Number of currently granted consents. Measures addressable consented audience."
    - name: "withdrawn_consents"
      expr: COUNT(CASE WHEN consent_status = 'withdrawn' THEN 1 END)
      comment: "Number of withdrawn consents. Tracks opt-out trends and regulatory risk exposure."
    - name: "re_consent_required_count"
      expr: COUNT(CASE WHEN re_consent_required_flag = TRUE THEN 1 END)
      comment: "Number of records requiring re-consent. Measures compliance remediation workload."
    - name: "double_opt_in_count"
      expr: COUNT(CASE WHEN double_opt_in_flag = TRUE THEN 1 END)
      comment: "Number of consents with double opt-in confirmation. Measures high-quality consent coverage."
    - name: "profiling_consent_count"
      expr: COUNT(CASE WHEN profiling_consent_flag = TRUE THEN 1 END)
      comment: "Number of consents covering profiling. Measures addressable audience for personalisation."
    - name: "third_party_sharing_consent_count"
      expr: COUNT(CASE WHEN third_party_sharing_flag = TRUE THEN 1 END)
      comment: "Number of consents covering third-party data sharing. Governs data partnership eligibility."
    - name: "distinct_consented_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Unique shoppers with at least one consent record. Measures consent programme reach."
$$;