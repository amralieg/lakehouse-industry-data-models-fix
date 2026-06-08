-- Metric views for domain: customer | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer profile metrics tracking acquisition, engagement, identity resolution quality, and loyalty program participation"
  source: "`apparel_fashion_ecm`.`customer`.`profile`"
  dimensions:
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the customer was acquired (e.g., organic, paid social, retail store)"
    - name: "customer_type"
      expr: customer_type
      comment: "Type of customer (e.g., retail, wholesale, VIP)"
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the customer profile (e.g., active, inactive, merged)"
    - name: "country_of_residence"
      expr: country_of_residence
      comment: "Country where the customer resides"
    - name: "registration_source"
      expr: registration_source
      comment: "Source system or channel where the profile was originally registered"
    - name: "identity_resolution_method"
      expr: identity_resolution_method
      comment: "Method used to resolve customer identity across touchpoints"
    - name: "is_verified"
      expr: is_verified
      comment: "Whether the customer profile has been verified"
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether customer has opted in to email communications"
    - name: "sms_opt_in"
      expr: sms_opt_in
      comment: "Whether customer has opted in to SMS communications"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether customer has provided GDPR consent"
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "Whether customer has opted out under CCPA"
    - name: "acquisition_year"
      expr: YEAR(created_timestamp)
      comment: "Year the customer profile was created"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the customer profile was created"
  measures:
    - name: "total_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of unique customer profiles"
    - name: "verified_customers"
      expr: COUNT(DISTINCT CASE WHEN is_verified = TRUE THEN profile_id END)
      comment: "Number of verified customer profiles"
    - name: "email_opt_in_customers"
      expr: COUNT(DISTINCT CASE WHEN email_opt_in = TRUE THEN profile_id END)
      comment: "Number of customers opted in to email communications"
    - name: "sms_opt_in_customers"
      expr: COUNT(DISTINCT CASE WHEN sms_opt_in = TRUE THEN profile_id END)
      comment: "Number of customers opted in to SMS communications"
    - name: "gdpr_consented_customers"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_flag = TRUE THEN profile_id END)
      comment: "Number of customers who have provided GDPR consent"
    - name: "avg_identity_confidence_score"
      expr: AVG(CAST(identity_confidence_score AS DOUBLE))
      comment: "Average identity resolution confidence score across customer profiles"
    - name: "loyalty_enrolled_customers"
      expr: COUNT(DISTINCT CASE WHEN loyalty_enrollment_date IS NOT NULL THEN profile_id END)
      comment: "Number of customers enrolled in loyalty programs"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program enrollment and engagement metrics tracking member activity, points economics, and tier progression"
  source: "`apparel_fashion_ecm`.`customer`.`loyalty_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the loyalty enrollment (e.g., active, suspended, terminated)"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the customer enrolled in the loyalty program"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for points and monetary values"
    - name: "member_card_type"
      expr: member_card_type
      comment: "Type of loyalty membership card issued"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year the customer enrolled in the loyalty program"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month the customer enrolled in the loyalty program"
    - name: "opt_in_email"
      expr: opt_in_email
      comment: "Whether member has opted in to email communications"
    - name: "opt_in_sms"
      expr: opt_in_sms
      comment: "Whether member has opted in to SMS communications"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT loyalty_enrollment_id)
      comment: "Total number of loyalty program enrollments"
    - name: "active_members"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN loyalty_enrollment_id END)
      comment: "Number of active loyalty program members"
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total points balance across all loyalty members"
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total lifetime points earned across all members"
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total lifetime points redeemed across all members"
    - name: "total_lifetime_points_expired"
      expr: SUM(CAST(lifetime_points_expired AS DOUBLE))
      comment: "Total lifetime points expired across all members"
    - name: "avg_points_balance"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average points balance per loyalty member"
    - name: "points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have been redeemed (lifetime redemption rate)"
    - name: "points_expiry_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_expired AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have expired (lifetime expiry rate)"
    - name: "avg_tier_qualification_spend"
      expr: AVG(CAST(tier_qualification_spend AS DOUBLE))
      comment: "Average spend required for tier qualification across members"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_cltv_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer lifetime value metrics tracking predicted future value, historical performance, and churn risk"
  source: "`apparel_fashion_ecm`.`customer`.`cltv_record`"
  dimensions:
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "Customer lifetime value tier classification (e.g., high, medium, low)"
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary channel through which the customer transacts"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty program tier of the customer"
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Whether the customer is a loyalty program member"
    - name: "retention_risk_flag"
      expr: retention_risk_flag
      comment: "Whether the customer is flagged as at risk of churning"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate CLTV (e.g., predictive model, historical average)"
    - name: "model_version"
      expr: model_version
      comment: "Version of the CLTV calculation model"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for monetary values"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year the CLTV was calculated"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month the CLTV was calculated"
  measures:
    - name: "total_cltv_records"
      expr: COUNT(DISTINCT cltv_record_id)
      comment: "Total number of CLTV calculation records"
    - name: "total_predicted_future_value"
      expr: SUM(CAST(predicted_future_value AS DOUBLE))
      comment: "Total predicted future value across all customers"
    - name: "total_historical_revenue"
      expr: SUM(CAST(historical_revenue AS DOUBLE))
      comment: "Total historical revenue across all customers"
    - name: "total_cltv"
      expr: SUM(CAST(total_cltv AS DOUBLE))
      comment: "Total customer lifetime value (historical + predicted) across all customers"
    - name: "avg_cltv"
      expr: AVG(CAST(total_cltv AS DOUBLE))
      comment: "Average customer lifetime value per customer"
    - name: "avg_predicted_future_value"
      expr: AVG(CAST(predicted_future_value AS DOUBLE))
      comment: "Average predicted future value per customer"
    - name: "avg_historical_revenue"
      expr: AVG(CAST(historical_revenue AS DOUBLE))
      comment: "Average historical revenue per customer"
    - name: "avg_aov"
      expr: AVG(CAST(aov AS DOUBLE))
      comment: "Average order value across customers"
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency per customer"
    - name: "avg_churn_probability"
      expr: AVG(CAST(churn_probability AS DOUBLE))
      comment: "Average churn probability across customers"
    - name: "high_churn_risk_customers"
      expr: COUNT(DISTINCT CASE WHEN churn_probability > 0.5 THEN cltv_record_id END)
      comment: "Number of customers with churn probability greater than 50%"
    - name: "avg_return_rate"
      expr: AVG(CAST(return_rate AS DOUBLE))
      comment: "Average return rate across customers"
    - name: "avg_discount_sensitivity_score"
      expr: AVG(CAST(discount_sensitivity_score AS DOUBLE))
      comment: "Average discount sensitivity score across customers"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score for CLTV predictions"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction metrics tracking engagement across channels, sentiment, satisfaction, and conversion outcomes"
  source: "`apparel_fashion_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (e.g., purchase, inquiry, complaint, browse)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred (e.g., web, mobile, store, call center)"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (e.g., completed, pending, abandoned)"
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction (e.g., converted, not converted, escalated)"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used for the interaction (e.g., desktop, mobile, tablet)"
    - name: "referral_channel"
      expr: referral_channel
      comment: "Channel through which the customer was referred to this interaction"
    - name: "interaction_year"
      expr: YEAR(interaction_timestamp)
      comment: "Year the interaction occurred"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month the interaction occurred"
    - name: "interaction_date"
      expr: DATE_TRUNC('DAY', interaction_timestamp)
      comment: "Date the interaction occurred"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of customer interactions"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across interactions"
    - name: "positive_sentiment_interactions"
      expr: COUNT(DISTINCT CASE WHEN sentiment_score > 0 THEN interaction_id END)
      comment: "Number of interactions with positive sentiment"
    - name: "negative_sentiment_interactions"
      expr: COUNT(DISTINCT CASE WHEN sentiment_score < 0 THEN interaction_id END)
      comment: "Number of interactions with negative sentiment"
    - name: "converted_interactions"
      expr: COUNT(DISTINCT CASE WHEN outcome = 'converted' THEN interaction_id END)
      comment: "Number of interactions that resulted in conversion"
    - name: "interaction_conversion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN outcome = 'converted' THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions that resulted in conversion"
    - name: "gdpr_consent_captured_interactions"
      expr: COUNT(DISTINCT CASE WHEN gdpr_consent_captured = TRUE THEN interaction_id END)
      comment: "Number of interactions where GDPR consent was captured"
    - name: "ccpa_opt_out_requested_interactions"
      expr: COUNT(DISTINCT CASE WHEN ccpa_opt_out_requested = TRUE THEN interaction_id END)
      comment: "Number of interactions where CCPA opt-out was requested"
    - name: "referral_conversion_interactions"
      expr: COUNT(DISTINCT CASE WHEN referral_conversion_status = 'converted' THEN interaction_id END)
      comment: "Number of referral interactions that resulted in conversion"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service request metrics tracking case resolution, SLA compliance, satisfaction, and escalation patterns"
  source: "`apparel_fashion_ecm`.`customer`.`service_request`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of service request case (e.g., return, complaint, inquiry, technical support)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service request (e.g., open, in progress, resolved, closed)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the service request (e.g., low, medium, high, critical)"
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team assigned to handle the service request"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which the service request was submitted (e.g., email, phone, chat, web form)"
    - name: "resolution_category"
      expr: resolution_category
      comment: "Category of resolution provided for the service request"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the service request was escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the service request breached SLA targets"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the service request originated"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the service request was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the service request was created"
  measures:
    - name: "total_service_requests"
      expr: COUNT(DISTINCT service_request_id)
      comment: "Total number of customer service requests"
    - name: "resolved_service_requests"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'resolved' THEN service_request_id END)
      comment: "Number of service requests that have been resolved"
    - name: "escalated_service_requests"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN service_request_id END)
      comment: "Number of service requests that were escalated"
    - name: "sla_breached_requests"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN service_request_id END)
      comment: "Number of service requests that breached SLA targets"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_breach_flag = FALSE THEN service_request_id END) / NULLIF(COUNT(DISTINCT service_request_id), 0), 2)
      comment: "Percentage of service requests that met SLA targets"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN service_request_id END) / NULLIF(COUNT(DISTINCT service_request_id), 0), 2)
      comment: "Percentage of service requests that were escalated"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across all service requests"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per service request"
    - name: "avg_sla_target_response_hours"
      expr: AVG(CAST(sla_target_response_hours AS DOUBLE))
      comment: "Average SLA target response time in hours"
    - name: "avg_sla_target_resolution_hours"
      expr: AVG(CAST(sla_target_resolution_hours AS DOUBLE))
      comment: "Average SLA target resolution time in hours"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer referral program metrics tracking referral conversion, reward economics, and viral growth effectiveness"
  source: "`apparel_fashion_ecm`.`customer`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g., pending, accepted, converted, expired)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the referral was made (e.g., email, social, SMS)"
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the referral resulted in a conversion"
    - name: "reward_issued_flag"
      expr: reward_issued_flag
      comment: "Whether a reward was issued for the referral"
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward issued (e.g., points, discount, cash)"
    - name: "referral_tier"
      expr: referral_tier
      comment: "Tier of the referral program (e.g., standard, premium, VIP)"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the referral was flagged as fraudulent"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the referral originated"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used for the referral"
    - name: "referral_year"
      expr: YEAR(referral_date)
      comment: "Year the referral was made"
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the referral was made"
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total number of customer referrals"
    - name: "converted_referrals"
      expr: COUNT(DISTINCT CASE WHEN conversion_flag = TRUE THEN referral_id END)
      comment: "Number of referrals that resulted in conversion"
    - name: "referral_conversion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN conversion_flag = TRUE THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals that resulted in conversion"
    - name: "total_conversion_amount"
      expr: SUM(CAST(conversion_amount AS DOUBLE))
      comment: "Total revenue generated from converted referrals"
    - name: "avg_conversion_amount"
      expr: AVG(CAST(conversion_amount AS DOUBLE))
      comment: "Average revenue per converted referral"
    - name: "total_reward_value"
      expr: SUM(CAST(reward_value AS DOUBLE))
      comment: "Total value of rewards issued for referrals"
    - name: "avg_reward_value"
      expr: AVG(CAST(reward_value AS DOUBLE))
      comment: "Average reward value per referral"
    - name: "rewards_issued"
      expr: COUNT(DISTINCT CASE WHEN reward_issued_flag = TRUE THEN referral_id END)
      comment: "Number of referrals for which rewards were issued"
    - name: "referral_roi"
      expr: ROUND(100.0 * SUM(CAST(conversion_amount AS DOUBLE)) / NULLIF(SUM(CAST(reward_value AS DOUBLE)), 0), 2)
      comment: "Return on investment for referral program (conversion revenue / reward cost)"
    - name: "fraudulent_referrals"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN referral_id END)
      comment: "Number of referrals flagged as fraudulent"
    - name: "fraud_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN referral_id END) / NULLIF(COUNT(DISTINCT referral_id), 0), 2)
      comment: "Percentage of referrals flagged as fraudulent"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer consent and privacy compliance metrics tracking opt-in rates, consent lifecycle, and regulatory adherence"
  source: "`apparel_fashion_ecm`.`customer`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g., marketing, data processing, third-party sharing)"
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent (e.g., granted, withdrawn, expired)"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (e.g., consent, legitimate interest, contract)"
    - name: "consent_method"
      expr: consent_method
      comment: "Method through which consent was collected (e.g., web form, email, in-store)"
    - name: "collection_channel"
      expr: collection_channel
      comment: "Channel through which consent was collected"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction applicable to the consent (e.g., GDPR, CCPA)"
    - name: "country_code"
      expr: country_code
      comment: "Country code where consent was collected"
    - name: "is_active"
      expr: is_active
      comment: "Whether the consent is currently active"
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in was used for consent collection"
    - name: "third_party_sharing_flag"
      expr: third_party_sharing_flag
      comment: "Whether consent includes third-party data sharing"
    - name: "granted_year"
      expr: YEAR(granted_timestamp)
      comment: "Year the consent was granted"
    - name: "granted_month"
      expr: DATE_TRUNC('MONTH', granted_timestamp)
      comment: "Month the consent was granted"
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_id)
      comment: "Total number of consent records"
    - name: "active_consents"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN consent_id END)
      comment: "Number of active consent records"
    - name: "granted_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'granted' THEN consent_id END)
      comment: "Number of consents that have been granted"
    - name: "withdrawn_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'withdrawn' THEN consent_id END)
      comment: "Number of consents that have been withdrawn"
    - name: "consent_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'granted' THEN consent_id END) / NULLIF(COUNT(DISTINCT consent_id), 0), 2)
      comment: "Percentage of consent requests that were granted"
    - name: "consent_withdrawal_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'withdrawn' THEN consent_id END) / NULLIF(COUNT(DISTINCT consent_id), 0), 2)
      comment: "Percentage of consents that have been withdrawn"
    - name: "double_opt_in_consents"
      expr: COUNT(DISTINCT CASE WHEN double_opt_in_flag = TRUE THEN consent_id END)
      comment: "Number of consents collected using double opt-in"
    - name: "third_party_sharing_consents"
      expr: COUNT(DISTINCT CASE WHEN third_party_sharing_flag = TRUE THEN consent_id END)
      comment: "Number of consents that include third-party data sharing"
    - name: "suppressed_consents"
      expr: COUNT(DISTINCT CASE WHEN suppression_flag = TRUE THEN consent_id END)
      comment: "Number of consents that have been suppressed"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`customer_wholesale_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wholesale account metrics tracking B2B relationship health, credit utilization, contract compliance, and account tier performance"
  source: "`apparel_fashion_ecm`.`customer`.`wholesale_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the wholesale account (e.g., active, suspended, closed)"
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the wholesale account (e.g., platinum, gold, silver, bronze)"
    - name: "account_type"
      expr: account_type
      comment: "Type of wholesale account (e.g., distributor, retailer, franchise)"
    - name: "relationship_status"
      expr: relationship_status
      comment: "Status of the business relationship (e.g., active, at risk, under review)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the wholesale account"
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry segment of the wholesale account"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the wholesale account"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country code for billing address"
    - name: "edi_capable"
      expr: edi_capable
      comment: "Whether the account is EDI capable for electronic data interchange"
    - name: "rfid_enabled"
      expr: rfid_enabled
      comment: "Whether the account is RFID enabled for inventory tracking"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for the account"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the account was onboarded"
    - name: "onboarding_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month the account was onboarded"
  measures:
    - name: "total_wholesale_accounts"
      expr: COUNT(DISTINCT wholesale_account_id)
      comment: "Total number of wholesale accounts"
    - name: "active_wholesale_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN wholesale_account_id END)
      comment: "Number of active wholesale accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit across all wholesale accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per wholesale account"
    - name: "edi_capable_accounts"
      expr: COUNT(DISTINCT CASE WHEN edi_capable = TRUE THEN wholesale_account_id END)
      comment: "Number of wholesale accounts that are EDI capable"
    - name: "edi_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN edi_capable = TRUE THEN wholesale_account_id END) / NULLIF(COUNT(DISTINCT wholesale_account_id), 0), 2)
      comment: "Percentage of wholesale accounts that are EDI capable"
    - name: "rfid_enabled_accounts"
      expr: COUNT(DISTINCT CASE WHEN rfid_enabled = TRUE THEN wholesale_account_id END)
      comment: "Number of wholesale accounts that are RFID enabled"
    - name: "rfid_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rfid_enabled = TRUE THEN wholesale_account_id END) / NULLIF(COUNT(DISTINCT wholesale_account_id), 0), 2)
      comment: "Percentage of wholesale accounts that are RFID enabled"
$$;