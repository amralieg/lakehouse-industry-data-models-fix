-- Metric views for domain: consumer | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_shopper`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core consumer identity and lifecycle metrics for acquisition, retention, and lifetime value analysis"
  source: "`vibe_consumer_goods_v1`.`consumer`.`shopper`"
  dimensions:
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the shopper was acquired (e.g., social, email, paid search)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the shopper (e.g., active, lapsed, churned)"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty program tier of the shopper"
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "Customer lifetime value segment classification"
    - name: "country_code"
      expr: country_code
      comment: "Country of residence for geographic analysis"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Shopper's preferred language for communication"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the shopper was acquired"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month the shopper was acquired"
    - name: "gdpr_subject_flag"
      expr: gdpr_subject
      comment: "Whether the shopper is subject to GDPR regulations"
    - name: "email_opt_in_flag"
      expr: email_opt_in
      comment: "Whether the shopper has opted in to email communications"
  measures:
    - name: "Total Shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique shoppers in the segment"
    - name: "Avg Loyalty Points Balance"
      expr: AVG(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Average loyalty points balance across shoppers"
    - name: "Total Loyalty Points Balance"
      expr: SUM(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Total loyalty points liability across all shoppers"
    - name: "Email Opt-In Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers who have opted in to email communications"
    - name: "SMS Opt-In Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sms_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers who have opted in to SMS communications"
    - name: "GDPR Subject Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gdpr_subject = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers subject to GDPR regulations"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program transaction metrics for points issuance, redemption, and liability management"
  source: "`vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (e.g., earn, redeem, adjustment, expiry)"
    - name: "channel"
      expr: channel
      comment: "Channel where the transaction occurred"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction (e.g., posted, pending, reversed)"
    - name: "points_direction"
      expr: points_direction
      comment: "Direction of points movement (credit or debit)"
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date the transaction occurred"
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Year of the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction"
    - name: "is_bonus_transaction"
      expr: is_bonus_transaction
      comment: "Whether the transaction was a bonus points award"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the transaction was flagged for fraud"
    - name: "country_code"
      expr: country_code
      comment: "Country where the transaction occurred"
  measures:
    - name: "Total Transactions"
      expr: COUNT(loyalty_transaction_id)
      comment: "Total number of loyalty transactions"
    - name: "Total Points Issued"
      expr: SUM(CAST(CASE WHEN points_direction = 'CREDIT' THEN points_amount ELSE 0 END AS DOUBLE))
      comment: "Total loyalty points issued to customers"
    - name: "Total Points Redeemed"
      expr: SUM(CAST(CASE WHEN points_direction = 'DEBIT' THEN points_amount ELSE 0 END AS DOUBLE))
      comment: "Total loyalty points redeemed by customers"
    - name: "Net Points Movement"
      expr: SUM(CAST(CASE WHEN points_direction = 'CREDIT' THEN points_amount WHEN points_direction = 'DEBIT' THEN -points_amount ELSE 0 END AS DOUBLE))
      comment: "Net change in loyalty points (issued minus redeemed)"
    - name: "Total Monetary Value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of loyalty transactions"
    - name: "Avg Points Per Transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points per transaction"
    - name: "Redemption Rate"
      expr: ROUND(100.0 * SUM(CAST(CASE WHEN points_direction = 'DEBIT' THEN points_amount ELSE 0 END AS DOUBLE)) / NULLIF(SUM(CAST(CASE WHEN points_direction = 'CREDIT' THEN points_amount ELSE 0 END AS DOUBLE)), 0), 2)
      comment: "Percentage of issued points that have been redeemed"
    - name: "Fraud Transaction Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN loyalty_transaction_id END) / NULLIF(COUNT(loyalty_transaction_id), 0), 2)
      comment: "Percentage of transactions flagged for fraud"
    - name: "Bonus Transaction Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bonus_transaction = TRUE THEN loyalty_transaction_id END) / NULLIF(COUNT(loyalty_transaction_id), 0), 2)
      comment: "Percentage of transactions that are bonus awards"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct-to-consumer order metrics for revenue, conversion, and fulfillment performance"
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., pending, shipped, delivered, cancelled)"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the order"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the order"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel through which the order was placed"
    - name: "device_type"
      expr: device_type
      comment: "Device type used to place the order (e.g., mobile, desktop, tablet)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order"
    - name: "order_date"
      expr: DATE_TRUNC('DAY', order_date)
      comment: "Date the order was placed"
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed"
    - name: "gift_order_flag"
      expr: gift_order_flag
      comment: "Whether the order is a gift order"
    - name: "subscription_order_flag"
      expr: subscription_order_flag
      comment: "Whether the order is part of a subscription"
    - name: "return_flag"
      expr: return_flag
      comment: "Whether the order has been returned"
  measures:
    - name: "Total Orders"
      expr: COUNT(DISTINCT dtc_order_id)
      comment: "Total number of direct-to-consumer orders"
    - name: "Total Order Value"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total gross merchandise value of all orders"
    - name: "Total Subtotal Amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal amount before shipping and tax"
    - name: "Total Shipping Amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges across all orders"
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected"
    - name: "Total Discount Amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to orders"
    - name: "Avg Order Value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value across all orders"
    - name: "Return Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN return_flag = TRUE THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of orders that have been returned"
    - name: "Subscription Order Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN subscription_order_flag = TRUE THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of orders that are subscription-based"
    - name: "Gift Order Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gift_order_flag = TRUE THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of orders that are gift orders"
    - name: "Avg Discount Per Order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per order"
    - name: "Discount Penetration Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN discount_amount > 0 THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of orders that received a discount"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct-to-consumer order line item metrics for product-level revenue and margin analysis"
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_order_line`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the line item"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code of the product"
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category code"
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel for the line item"
    - name: "is_returned"
      expr: is_returned
      comment: "Whether the line item has been returned"
    - name: "gift_flag"
      expr: gift_flag
      comment: "Whether the line item is a gift"
    - name: "subscription_flag"
      expr: subscription_flag
      comment: "Whether the line item is part of a subscription"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the line item contains hazardous materials"
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Whether the line item is on regulatory hold"
  measures:
    - name: "Total Line Items"
      expr: COUNT(dtc_order_line_id)
      comment: "Total number of order line items"
    - name: "Total Line Revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue from all line items"
    - name: "Total Line Subtotal"
      expr: SUM(CAST(line_subtotal AS DOUBLE))
      comment: "Total subtotal before discounts"
    - name: "Total Line Discount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount amount applied to line items"
    - name: "Total COGS"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold across all line items"
    - name: "Total Gross Margin"
      expr: SUM((CAST(line_total_amount AS DOUBLE)) - (CAST(cost_of_goods_sold AS DOUBLE)))
      comment: "Total gross margin (revenue minus COGS)"
    - name: "Avg Unit Price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all line items"
    - name: "Line Item Return Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN dtc_order_line_id END) / NULLIF(COUNT(dtc_order_line_id), 0), 2)
      comment: "Percentage of line items that have been returned"
    - name: "Subscription Line Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_flag = TRUE THEN dtc_order_line_id END) / NULLIF(COUNT(dtc_order_line_id), 0), 2)
      comment: "Percentage of line items that are subscription-based"
    - name: "Hazmat Line Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazmat_flag = TRUE THEN dtc_order_line_id END) / NULLIF(COUNT(dtc_order_line_id), 0), 2)
      comment: "Percentage of line items containing hazardous materials"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_cltv_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer lifetime value metrics for predictive revenue modeling and customer segmentation"
  source: "`vibe_consumer_goods_v1`.`consumer`.`cltv_record`"
  dimensions:
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "Customer lifetime value tier classification"
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the CLTV calculation"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary purchase channel for the customer"
    - name: "primary_brand_code"
      expr: primary_brand_code
      comment: "Primary brand purchased by the customer"
    - name: "primary_category_code"
      expr: primary_category_code
      comment: "Primary product category purchased by the customer"
    - name: "nps_category"
      expr: nps_category
      comment: "Net Promoter Score category (promoter, passive, detractor)"
    - name: "calculation_date"
      expr: calculation_date
      comment: "Date the CLTV was calculated"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year of CLTV calculation"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month of CLTV calculation"
    - name: "tier_change_flag"
      expr: tier_change_flag
      comment: "Whether the customer changed CLTV tier in this period"
    - name: "personalization_eligible"
      expr: personalization_eligible
      comment: "Whether the customer is eligible for personalized marketing"
  measures:
    - name: "Total Customers Scored"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique customers with CLTV scores"
    - name: "Avg CLTV Score"
      expr: AVG(CAST(cltv_score AS DOUBLE))
      comment: "Average customer lifetime value score"
    - name: "Total CLTV Amount"
      expr: SUM(CAST(cltv_amount AS DOUBLE))
      comment: "Total predicted customer lifetime value across all customers"
    - name: "Avg Predicted Revenue 12M"
      expr: AVG(CAST(predicted_revenue_12m AS DOUBLE))
      comment: "Average predicted revenue over next 12 months"
    - name: "Total Predicted Revenue 12M"
      expr: SUM(CAST(predicted_revenue_12m AS DOUBLE))
      comment: "Total predicted revenue over next 12 months"
    - name: "Avg Churn Probability"
      expr: AVG(CAST(churn_probability AS DOUBLE))
      comment: "Average probability of customer churn"
    - name: "Avg Purchase Frequency"
      expr: AVG(CAST(purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency per customer"
    - name: "Avg AOV"
      expr: AVG(CAST(aov AS DOUBLE))
      comment: "Average order value per customer"
    - name: "Tier Change Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tier_change_flag = TRUE THEN cltv_record_id END) / NULLIF(COUNT(cltv_record_id), 0), 2)
      comment: "Percentage of customers who changed CLTV tier"
    - name: "Personalization Eligible Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN personalization_eligible = TRUE THEN cltv_record_id END) / NULLIF(COUNT(cltv_record_id), 0), 2)
      comment: "Percentage of customers eligible for personalized marketing"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy consent and compliance metrics for GDPR, CCPA, and data governance"
  source: "`vibe_consumer_goods_v1`.`consumer`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (granted, withdrawn, expired)"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, data processing, profiling, etc.)"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (consent, legitimate interest, contract, etc.)"
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (email, SMS, profiling, third-party sharing, etc.)"
    - name: "capture_method"
      expr: capture_method
      comment: "Method by which consent was captured"
    - name: "country_code"
      expr: country_code
      comment: "Country where consent was captured"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction (GDPR, CCPA, etc.)"
    - name: "consent_date"
      expr: DATE_TRUNC('DAY', consent_timestamp)
      comment: "Date consent was granted"
    - name: "consent_year"
      expr: YEAR(consent_timestamp)
      comment: "Year consent was granted"
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_timestamp)
      comment: "Month consent was granted"
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in was used"
    - name: "parental_consent_flag"
      expr: parental_consent_flag
      comment: "Whether parental consent was obtained (for minors)"
    - name: "third_party_sharing_flag"
      expr: third_party_sharing_flag
      comment: "Whether consent includes third-party data sharing"
    - name: "is_current_record"
      expr: is_current_record
      comment: "Whether this is the current active consent record"
  measures:
    - name: "Total Consent Records"
      expr: COUNT(consent_record_id)
      comment: "Total number of consent records"
    - name: "Total Unique Shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique shoppers with consent records"
    - name: "Consent Grant Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'GRANTED' THEN consent_record_id END) / NULLIF(COUNT(consent_record_id), 0), 2)
      comment: "Percentage of consent records with granted status"
    - name: "Consent Withdrawal Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_status = 'WITHDRAWN' THEN consent_record_id END) / NULLIF(COUNT(consent_record_id), 0), 2)
      comment: "Percentage of consent records that have been withdrawn"
    - name: "Double Opt-In Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_flag = TRUE THEN consent_record_id END) / NULLIF(COUNT(consent_record_id), 0), 2)
      comment: "Percentage of consents using double opt-in verification"
    - name: "Third-Party Sharing Consent Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN third_party_sharing_flag = TRUE THEN consent_record_id END) / NULLIF(COUNT(consent_record_id), 0), 2)
      comment: "Percentage of consents that include third-party data sharing"
    - name: "Parental Consent Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN parental_consent_flag = TRUE THEN consent_record_id END) / NULLIF(COUNT(consent_record_id), 0), 2)
      comment: "Percentage of consents requiring parental approval"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription business metrics for recurring revenue, churn, and customer retention"
  source: "`vibe_consumer_goods_v1`.`consumer`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, paused, cancelled, expired)"
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription plan"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the subscription was acquired"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type used for recurring billing"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the subscription started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the subscription started"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the subscription auto-renews"
    - name: "trial_flag"
      expr: trial_flag
      comment: "Whether the subscription is in trial period"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for subscription cancellation"
  measures:
    - name: "Total Subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total number of subscriptions"
    - name: "Active Subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'ACTIVE' THEN subscription_id END)
      comment: "Number of currently active subscriptions"
    - name: "Total MRR"
      expr: SUM(CAST(CASE WHEN billing_frequency = 'MONTHLY' THEN price WHEN billing_frequency = 'QUARTERLY' THEN price / 3.0 WHEN billing_frequency = 'ANNUAL' THEN price / 12.0 ELSE 0 END AS DOUBLE))
      comment: "Total monthly recurring revenue normalized across billing frequencies"
    - name: "Avg Subscription Price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average subscription price"
    - name: "Churn Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN subscription_status = 'CANCELLED' THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled"
    - name: "Auto-Renew Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions with auto-renew enabled"
    - name: "Trial Conversion Rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trial_flag = TRUE AND subscription_status = 'ACTIVE' THEN subscription_id END) / NULLIF(COUNT(DISTINCT CASE WHEN trial_flag = TRUE THEN subscription_id END), 0), 2)
      comment: "Percentage of trial subscriptions that converted to paid"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segmentation metrics for targeting, personalization, and campaign effectiveness"
  source: "`vibe_consumer_goods_v1`.`consumer`.`segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current membership status in the segment"
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the customer to the segment (rule-based, ML, manual)"
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "Customer lifetime value tier"
    - name: "channel"
      expr: channel
      comment: "Primary channel for the customer"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment"
    - name: "is_control_group"
      expr: is_control_group
      comment: "Whether the customer is in a control group"
    - name: "is_primary_segment"
      expr: is_primary_segment
      comment: "Whether this is the customer's primary segment"
    - name: "personalization_eligible"
      expr: personalization_eligible
      comment: "Whether the customer is eligible for personalized marketing"
    - name: "assignment_year"
      expr: YEAR(assignment_date)
      comment: "Year the customer was assigned to the segment"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month the customer was assigned to the segment"
  measures:
    - name: "Total Segment Members"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique customers in segments"
    - name: "Total Memberships"
      expr: COUNT(segment_membership_id)
      comment: "Total segment membership records (customers can be in multiple segments)"
    - name: "Avg Confidence Score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score for segment assignments"
    - name: "Avg Membership Score"
      expr: AVG(CAST(membership_score AS DOUBLE))
      comment: "Average membership score indicating fit to segment"
    - name: "Control Group Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_control_group = TRUE THEN segment_membership_id END) / NULLIF(COUNT(segment_membership_id), 0), 2)
      comment: "Percentage of segment members in control groups"
    - name: "Personalization Eligible Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN personalization_eligible = TRUE THEN segment_membership_id END) / NULLIF(COUNT(segment_membership_id), 0), 2)
      comment: "Percentage of segment members eligible for personalization"
    - name: "Opt-Out Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_out_flag = TRUE THEN segment_membership_id END) / NULLIF(COUNT(segment_membership_id), 0), 2)
      comment: "Percentage of segment members who have opted out"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score metrics for customer satisfaction and brand loyalty measurement"
  source: "`vibe_consumer_goods_v1`.`consumer`.`nps_response`"
  dimensions:
    - name: "respondent_category"
      expr: respondent_category
      comment: "NPS category (promoter, passive, detractor)"
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the response"
    - name: "brand_name"
      expr: brand_name
      comment: "Brand being evaluated"
    - name: "product_category"
      expr: product_category
      comment: "Product category being evaluated"
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel where the purchase was made"
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered"
    - name: "country_code"
      expr: country_code
      comment: "Country of the respondent"
    - name: "response_year"
      expr: YEAR(response_date)
      comment: "Year of the NPS response"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_date)
      comment: "Month of the NPS response"
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Whether the respondent is a loyalty program member"
    - name: "repeat_buyer_flag"
      expr: repeat_buyer_flag
      comment: "Whether the respondent is a repeat buyer"
    - name: "closed_loop_status"
      expr: closed_loop_status
      comment: "Status of closed-loop follow-up with detractors"
  measures:
    - name: "Total Responses"
      expr: COUNT(nps_response_id)
      comment: "Total number of NPS responses"
    - name: "Total Unique Respondents"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique customers who responded"
    - name: "Promoter Count"
      expr: COUNT(CASE WHEN respondent_category = 'PROMOTER' THEN nps_response_id END)
      comment: "Number of promoter responses (NPS 9-10)"
    - name: "Detractor Count"
      expr: COUNT(CASE WHEN respondent_category = 'DETRACTOR' THEN nps_response_id END)
      comment: "Number of detractor responses (NPS 0-6)"
    - name: "Passive Count"
      expr: COUNT(CASE WHEN respondent_category = 'PASSIVE' THEN nps_response_id END)
      comment: "Number of passive responses (NPS 7-8)"
    - name: "Net Promoter Score"
      expr: ROUND(100.0 * (COUNT(CASE WHEN respondent_category = 'PROMOTER' THEN nps_response_id END) - COUNT(CASE WHEN respondent_category = 'DETRACTOR' THEN nps_response_id END)) / NULLIF(COUNT(nps_response_id), 0), 2)
      comment: "Net Promoter Score (percentage promoters minus percentage detractors)"
    - name: "Avg Sentiment Score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from text analysis"
    - name: "Loyalty Member Response Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_member_flag = TRUE THEN nps_response_id END) / NULLIF(COUNT(nps_response_id), 0), 2)
      comment: "Percentage of responses from loyalty program members"
    - name: "Repeat Buyer Response Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_buyer_flag = TRUE THEN nps_response_id END) / NULLIF(COUNT(nps_response_id), 0), 2)
      comment: "Percentage of responses from repeat buyers"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service interaction metrics for contact center performance and issue resolution"
  source: "`vibe_consumer_goods_v1`.`consumer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (inquiry, complaint, return, technical support, etc.)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred (phone, email, chat, social, etc.)"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (open, in progress, resolved, closed)"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided"
    - name: "contact_reason_code"
      expr: contact_reason_code
      comment: "Reason code for the contact"
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the interaction"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the interaction"
    - name: "interaction_date"
      expr: DATE_TRUNC('DAY', interaction_timestamp)
      comment: "Date of the interaction"
    - name: "interaction_year"
      expr: YEAR(interaction_timestamp)
      comment: "Year of the interaction"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month of the interaction"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the interaction was escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the interaction breached SLA targets"
    - name: "is_bot_handled"
      expr: is_bot_handled
      comment: "Whether the interaction was handled by a bot"
    - name: "repeat_contact_flag"
      expr: repeat_contact_flag
      comment: "Whether this is a repeat contact on the same issue"
    - name: "adverse_event_flag"
      expr: adverse_event_flag
      comment: "Whether the interaction involves an adverse event"
  measures:
    - name: "Total Interactions"
      expr: COUNT(interaction_id)
      comment: "Total number of customer interactions"
    - name: "Total Unique Customers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique customers with interactions"
    - name: "Avg Sentiment Score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across interactions"
    - name: "Escalation Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(interaction_id), 0), 2)
      comment: "Percentage of interactions that were escalated"
    - name: "SLA Breach Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(interaction_id), 0), 2)
      comment: "Percentage of interactions that breached SLA targets"
    - name: "Bot Handling Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bot_handled = TRUE THEN interaction_id END) / NULLIF(COUNT(interaction_id), 0), 2)
      comment: "Percentage of interactions handled by automated bots"
    - name: "Repeat Contact Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_contact_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(interaction_id), 0), 2)
      comment: "Percentage of interactions that are repeat contacts on the same issue"
    - name: "Adverse Event Rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN adverse_event_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(interaction_id), 0), 2)
      comment: "Percentage of interactions involving adverse events"
    - name: "Avg SLA Target Hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target in hours"
$$;