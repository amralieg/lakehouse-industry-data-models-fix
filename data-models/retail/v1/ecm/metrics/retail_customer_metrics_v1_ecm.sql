-- Metric views for domain: customer | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer profile metrics tracking customer acquisition, lifecycle, and engagement patterns"
  source: "`retail_ecm`.`customer`.`profile`"
  dimensions:
    - name: "customer_type"
      expr: customer_type
      comment: "Type of customer (B2B, B2C, etc.)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the customer"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Customer loyalty tier classification"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which customer was acquired"
    - name: "preferred_contact_method"
      expr: preferred_contact_method
      comment: "Customer's preferred method of contact"
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of customer profile"
    - name: "marketing_consent_flag"
      expr: marketing_consent_flag
      comment: "Whether customer has consented to marketing communications"
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether customer is flagged as VIP"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year customer was acquired"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month customer was acquired"
  measures:
    - name: "total_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of unique customer profiles"
    - name: "avg_customer_lifetime_value"
      expr: AVG(CAST(cltv_score AS DOUBLE))
      comment: "Average customer lifetime value score across customers"
    - name: "total_customer_lifetime_value"
      expr: SUM(CAST(cltv_score AS DOUBLE))
      comment: "Total customer lifetime value across all customers"
    - name: "avg_customer_acquisition_cost"
      expr: AVG(CAST(cac_amount AS DOUBLE))
      comment: "Average cost to acquire a customer"
    - name: "total_customer_acquisition_cost"
      expr: SUM(CAST(cac_amount AS DOUBLE))
      comment: "Total customer acquisition cost across all customers"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_consent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customers who have opted in to marketing communications"
    - name: "vip_customer_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vip_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customers flagged as VIP"
    - name: "avg_mdm_confidence_score"
      expr: AVG(CAST(mdm_confidence_score AS DOUBLE))
      comment: "Average master data management confidence score for customer identity resolution"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer account financial and operational metrics tracking credit, balance, and account health"
  source: "`retail_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account"
    - name: "account_tier"
      expr: account_tier
      comment: "Account tier classification"
    - name: "account_type"
      expr: account_type
      comment: "Type of account"
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Customer's preferred shopping channel"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for account transactions"
    - name: "loyalty_program_enrolled"
      expr: loyalty_program_enrolled
      comment: "Whether account is enrolled in loyalty program"
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether account is tax exempt"
    - name: "b2b_pricing_flag"
      expr: b2b_pricing_flag
      comment: "Whether account receives B2B pricing"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year account was opened"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month account was opened"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique customer accounts"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of total credit limit currently utilized across all accounts"
    - name: "loyalty_enrollment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN loyalty_program_enrolled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts enrolled in loyalty program"
    - name: "tax_exempt_account_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tax_exempt_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts that are tax exempt"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment performance metrics tracking segment size, value, and targeting effectiveness"
  source: "`retail_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the customer segment"
    - name: "segment_type"
      expr: segment_type
      comment: "Type of customer segment"
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment"
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier assigned to segment"
    - name: "b2b_b2c_indicator"
      expr: b2b_b2c_indicator
      comment: "Whether segment is B2B or B2C focused"
    - name: "discount_sensitivity"
      expr: discount_sensitivity
      comment: "Segment's sensitivity to discounts"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment"
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit that owns this segment"
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of unique customer segments"
    - name: "total_segment_members"
      expr: SUM(CAST(membership_count AS BIGINT))
      comment: "Total number of customers across all segments"
    - name: "avg_segment_size"
      expr: AVG(CAST(membership_count AS DOUBLE))
      comment: "Average number of customers per segment"
    - name: "avg_segment_cltv"
      expr: AVG(CAST(average_cltv AS DOUBLE))
      comment: "Average customer lifetime value per segment"
    - name: "avg_segment_aov"
      expr: AVG(CAST(average_aov AS DOUBLE))
      comment: "Average order value per segment"
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(average_purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency across segments"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across segments"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across segments"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service case metrics tracking resolution efficiency, satisfaction, and service quality"
  source: "`retail_ecm`.`customer`.`service_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of service case"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service case"
    - name: "priority"
      expr: priority
      comment: "Priority level of the case"
    - name: "channel"
      expr: channel
      comment: "Channel through which case was created"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether case has been escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether case breached SLA"
    - name: "resolution_code"
      expr: resolution_code
      comment: "Code indicating how case was resolved"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year case was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month case was created"
  measures:
    - name: "total_service_cases"
      expr: COUNT(DISTINCT service_case_id)
      comment: "Total number of unique service cases"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across all service cases"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per service case"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across service cases"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service cases that were escalated"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service cases that breached SLA"
    - name: "case_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_closed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service cases that have been closed"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_b2b_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "B2B contract value and performance metrics tracking contract revenue, compliance, and renewal patterns"
  source: "`retail_ecm`.`customer`.`b2b_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the B2B contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of B2B contract"
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier assigned to contract"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms of the contract"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the contract"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract auto-renews"
    - name: "exclusive_agreement_flag"
      expr: exclusive_agreement_flag
      comment: "Whether contract is an exclusive agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for contract value"
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year contract became effective"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT b2b_contract_id)
      comment: "Total number of unique B2B contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total value of all B2B contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average value per B2B contract"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all B2B contracts"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across B2B contracts"
    - name: "total_minimum_order_value"
      expr: SUM(CAST(minimum_order_value AS DOUBLE))
      comment: "Total minimum order value commitments across contracts"
    - name: "total_volume_commitment"
      expr: SUM(CAST(volume_commitment AS DOUBLE))
      comment: "Total volume commitment across all B2B contracts"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts set to auto-renew"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction metrics tracking engagement patterns, channel effectiveness, and customer sentiment"
  source: "`retail_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction"
    - name: "channel"
      expr: channel
      comment: "Channel through which interaction occurred"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction"
    - name: "direction"
      expr: direction
      comment: "Direction of interaction (inbound/outbound)"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used for interaction"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the interaction"
    - name: "email_opened_flag"
      expr: email_opened_flag
      comment: "Whether email was opened"
    - name: "email_clicked_flag"
      expr: email_clicked_flag
      comment: "Whether email was clicked"
    - name: "interaction_year"
      expr: YEAR(interaction_timestamp)
      comment: "Year interaction occurred"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month interaction occurred"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of unique customer interactions"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across customer interactions"
    - name: "email_open_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_opened_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of email interactions that were opened"
    - name: "email_click_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN email_clicked_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of email interactions that were clicked"
    - name: "sms_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sms_delivered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SMS interactions successfully delivered"
    - name: "unsubscribe_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN unsubscribed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions resulting in unsubscribe"
    - name: "avg_geolocation_latitude"
      expr: AVG(CAST(geolocation_latitude AS DOUBLE))
      comment: "Average latitude of customer interactions with geolocation data"
    - name: "avg_geolocation_longitude"
      expr: AVG(CAST(geolocation_longitude AS DOUBLE))
      comment: "Average longitude of customer interactions with geolocation data"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_wishlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wishlist and registry metrics tracking customer intent, conversion, and gift registry performance"
  source: "`retail_ecm`.`customer`.`wishlist`"
  dimensions:
    - name: "wishlist_type"
      expr: wishlist_type
      comment: "Type of wishlist or registry"
    - name: "wishlist_status"
      expr: wishlist_status
      comment: "Current status of the wishlist"
    - name: "visibility"
      expr: visibility
      comment: "Visibility setting of the wishlist"
    - name: "conversion_status"
      expr: conversion_status
      comment: "Conversion status of wishlist items"
    - name: "channel"
      expr: channel
      comment: "Channel through which wishlist was created"
    - name: "is_default_flag"
      expr: is_default_flag
      comment: "Whether this is the customer's default wishlist"
    - name: "notification_enabled_flag"
      expr: notification_enabled_flag
      comment: "Whether notifications are enabled for this wishlist"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year of the event associated with wishlist"
  measures:
    - name: "total_wishlists"
      expr: COUNT(DISTINCT wishlist_id)
      comment: "Total number of unique wishlists"
    - name: "total_wishlist_value"
      expr: SUM(CAST(total_value_amount AS DOUBLE))
      comment: "Total value of all items across all wishlists"
    - name: "avg_wishlist_value"
      expr: AVG(CAST(total_value_amount AS DOUBLE))
      comment: "Average value per wishlist"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate_percentage AS DOUBLE))
      comment: "Average conversion rate of wishlist items to purchases"
    - name: "notification_enabled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wishlists with notifications enabled"
    - name: "privacy_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN privacy_consent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wishlists with privacy consent granted"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level customer metrics tracking combined household value, spending patterns, and loyalty"
  source: "`retail_ecm`.`customer`.`household`"
  dimensions:
    - name: "household_type"
      expr: household_type
      comment: "Type of household"
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household"
    - name: "segment"
      expr: segment
      comment: "Segment classification of the household"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the household"
    - name: "estimated_income_band"
      expr: estimated_income_band
      comment: "Estimated income band of the household"
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Household's preferred shopping channel"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether household has opted in to marketing"
    - name: "city"
      expr: city
      comment: "City where household is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province where household is located"
  measures:
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total number of unique households"
    - name: "total_household_cltv"
      expr: SUM(CAST(combined_cltv AS DOUBLE))
      comment: "Total combined customer lifetime value across all households"
    - name: "avg_household_cltv"
      expr: AVG(CAST(combined_cltv AS DOUBLE))
      comment: "Average combined customer lifetime value per household"
    - name: "total_household_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend amount across all households"
    - name: "avg_household_spend"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average spend amount per household"
    - name: "avg_basket_value"
      expr: AVG(CAST(average_basket_value AS DOUBLE))
      comment: "Average basket value across households"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of households opted in to marketing"
$$;