-- Metric views for domain: customer | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer profile metrics tracking acquisition, engagement, loyalty, and lifecycle health across the customer base. Used by CMO, VP Customer, and Growth teams to steer acquisition investment, retention programs, and loyalty strategy."
  source: "`ecommerce_ecm`.`customer`.`customer_profile`"
  dimensions:
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the customer was acquired (e.g., organic, paid, referral, social). Used to evaluate channel ROI and acquisition mix."
    - name: "customer_type"
      expr: customer_type
      comment: "Classification of the customer (e.g., B2C individual, B2B, guest). Drives segmentation and lifecycle strategy."
    - name: "account_status"
      expr: account_status
      comment: "Current status of the customer account (e.g., active, suspended, closed). Critical for churn and retention analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Customer loyalty tier (e.g., Bronze, Silver, Gold, Platinum). Used to measure tier distribution and upgrade/downgrade trends."
    - name: "gender"
      expr: gender
      comment: "Customer gender for demographic segmentation and personalization strategy."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Customer preferred transaction currency. Used for international market analysis."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Customer preferred language. Used for localization investment decisions."
    - name: "kyc_verification_status"
      expr: kyc_verification_status
      comment: "KYC (Know Your Customer) verification status. Critical for compliance and fraud risk reporting."
    - name: "kyc_risk_level"
      expr: kyc_risk_level
      comment: "Risk level assigned during KYC verification. Used for fraud and compliance steering."
    - name: "acquisition_month"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Month of customer acquisition. Used for cohort analysis and acquisition trend reporting."
    - name: "first_purchase_month"
      expr: DATE_TRUNC('month', first_purchase_date)
      comment: "Month of first purchase. Used to measure time-to-first-purchase and activation funnel performance."
    - name: "last_active_month"
      expr: DATE_TRUNC('month', last_active_date)
      comment: "Month of last recorded activity. Used for recency analysis and churn risk identification."
  measures:
    - name: "total_customers"
      expr: COUNT(DISTINCT customer_profile_id)
      comment: "Total number of unique customer profiles. Baseline KPI for customer base size, tracked by executives to measure growth trajectory."
    - name: "email_verified_customers"
      expr: COUNT(DISTINCT CASE WHEN email_verified_flag = TRUE THEN customer_profile_id END)
      comment: "Number of customers with verified email addresses. Drives deliverability and marketing reachability decisions."
    - name: "email_verification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_verified_flag = TRUE THEN customer_profile_id END) / NULLIF(COUNT(DISTINCT customer_profile_id), 0), 2)
      comment: "Percentage of customers with verified emails. A low rate signals data quality risk and marketing channel degradation."
    - name: "marketing_email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in_email = TRUE THEN customer_profile_id END) / NULLIF(COUNT(DISTINCT customer_profile_id), 0), 2)
      comment: "Percentage of customers opted into email marketing. Directly impacts reachable audience size and campaign ROI."
    - name: "marketing_sms_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in_sms = TRUE THEN customer_profile_id END) / NULLIF(COUNT(DISTINCT customer_profile_id), 0), 2)
      comment: "Percentage of customers opted into SMS marketing. Used to size SMS channel investment and compliance exposure."
    - name: "total_loyalty_points_balance"
      expr: SUM(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Total outstanding loyalty points balance across all customers. Represents a financial liability and engagement health indicator for the loyalty program."
    - name: "avg_loyalty_points_balance"
      expr: AVG(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Average loyalty points balance per customer. Used to assess loyalty program engagement depth and identify tier upgrade opportunities."
    - name: "data_processing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_processing_consent = TRUE THEN customer_profile_id END) / NULLIF(COUNT(DISTINCT customer_profile_id), 0), 2)
      comment: "Percentage of customers who have granted data processing consent. Critical GDPR/CCPA compliance KPI monitored by Legal and DPO."
    - name: "third_party_sharing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_sharing_consent = TRUE THEN customer_profile_id END) / NULLIF(COUNT(DISTINCT customer_profile_id), 0), 2)
      comment: "Percentage of customers consenting to third-party data sharing. Governs data monetization and partner data-sharing programs."
    - name: "kyc_verified_customer_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN kyc_verification_status = 'verified' THEN customer_profile_id END) / NULLIF(COUNT(DISTINCT customer_profile_id), 0), 2)
      comment: "Percentage of customers who have passed KYC verification. Regulatory compliance KPI for markets requiring identity verification."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account-level financial and behavioral metrics covering credit exposure, outstanding balances, customer lifetime value, loyalty program participation, and account health. Used by Finance, Risk, and Customer Success teams."
  source: "`ecommerce_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., active, closed, suspended). Used to filter and segment account health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g., individual, business, marketplace seller). Drives differentiated strategy and reporting."
    - name: "account_tier"
      expr: account_tier
      comment: "Commercial tier of the account. Used to prioritize customer success resources and measure tier migration."
    - name: "account_source"
      expr: account_source
      comment: "Originating source of the account (e.g., web, mobile, partner). Used for acquisition channel attribution."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the account holder. Used to correlate loyalty status with financial metrics."
    - name: "loyalty_program_enrolled"
      expr: loyalty_program_enrolled
      comment: "Whether the account is enrolled in a loyalty program. Used to measure loyalty program penetration."
    - name: "marketplace_seller_flag"
      expr: marketplace_seller_flag
      comment: "Indicates if the account is a marketplace seller. Used to separate buyer vs. seller account analytics."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred currency of the account. Used for multi-currency financial exposure analysis."
    - name: "credit_limit_currency"
      expr: credit_limit_currency
      comment: "Currency denomination of the credit limit. Used for credit risk reporting by currency."
    - name: "open_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month the account was opened. Used for cohort-based account lifecycle analysis."
    - name: "last_order_month"
      expr: DATE_TRUNC('month', last_order_date)
      comment: "Month of the most recent order. Used for recency-based churn and re-engagement analysis."
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique accounts. Baseline measure for account base size and growth tracking."
    - name: "total_customer_lifetime_value"
      expr: SUM(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Sum of customer lifetime value across all accounts. Represents the total projected revenue value of the customer base — a top-line strategic KPI."
    - name: "avg_customer_lifetime_value"
      expr: AVG(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Average customer lifetime value per account. Used by executives to benchmark CLV improvement initiatives and segment value."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance owed across all accounts. A critical financial risk KPI monitored by Finance and Credit Risk teams."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per account. Used to assess average credit exposure and collections risk per customer."
    - name: "total_credit_limit_extended"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Measures aggregate credit exposure and informs credit policy decisions."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account. Used to benchmark credit policy and identify over- or under-extended segments."
    - name: "credit_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Ratio of total outstanding balance to total credit limit extended. A key credit risk KPI — high utilization signals elevated default risk."
    - name: "loyalty_program_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_program_enrolled = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts enrolled in a loyalty program. Measures loyalty program penetration and informs enrollment campaign targeting."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts opted into marketing communications. Governs reachable audience size for campaigns and compliance posture."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program enrollment and engagement metrics tracking points economics, tier distribution, membership fees, and program health. Used by Loyalty Program Managers, CMO, and Finance to optimize program ROI and member engagement."
  source: "`ecommerce_ecm`.`customer`.`loyalty_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the loyalty enrollment (e.g., active, cancelled, suspended). Used to measure active vs. churned membership."
    - name: "current_tier"
      expr: current_tier
      comment: "Current loyalty tier of the enrolled member (e.g., Bronze, Silver, Gold, Platinum). Used for tier distribution and upgrade analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for loyalty program cancellation. Used to identify and address top churn drivers."
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Whether auto-renewal is enabled for the membership. Used to forecast renewal revenue and identify at-risk memberships."
    - name: "opt_in_marketing"
      expr: opt_in_marketing
      comment: "Whether the member has opted into loyalty marketing communications. Used to size reachable loyalty audience."
    - name: "membership_fee_currency"
      expr: membership_fee_currency
      comment: "Currency of the membership fee. Used for multi-currency revenue reporting."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of loyalty program enrollment. Used for cohort analysis and enrollment trend tracking."
    - name: "last_activity_month"
      expr: DATE_TRUNC('month', last_activity_date)
      comment: "Month of last loyalty activity. Used for recency analysis and dormant member identification."
    - name: "tier_expiry_month"
      expr: DATE_TRUNC('month', tier_expiry_date)
      comment: "Month when the current tier expires. Used for proactive tier retention campaigns."
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT loyalty_enrollment_id)
      comment: "Total number of loyalty program enrollments. Baseline KPI for program scale and growth."
    - name: "active_enrollments"
      expr: COUNT(DISTINCT CASE WHEN enrollment_status = 'active' THEN loyalty_enrollment_id END)
      comment: "Number of currently active loyalty enrollments. Core program health KPI used by Loyalty Program Managers."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total loyalty points earned across all members over their lifetime. Measures program engagement volume and earn-side economics."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total loyalty points redeemed across all members. Measures redemption activity and program value delivery to members."
    - name: "total_lifetime_points_expired"
      expr: SUM(CAST(lifetime_points_expired AS DOUBLE))
      comment: "Total loyalty points expired without redemption. High expiry signals poor member engagement and program design issues."
    - name: "points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have been redeemed. A key loyalty program health KPI — low redemption indicates disengaged members or poor reward value."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all active enrollments. Represents the financial liability of unredeemed points on the balance sheet."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average current points balance per enrolled member. Used to assess average member engagement depth and reward accumulation."
    - name: "total_membership_fees_collected"
      expr: SUM(CAST(membership_fee_paid AS DOUBLE))
      comment: "Total membership fees collected across all enrollments. Direct revenue contribution from the loyalty program subscription model."
    - name: "avg_membership_fee"
      expr: AVG(CAST(membership_fee_paid AS DOUBLE))
      comment: "Average membership fee paid per enrollment. Used to benchmark fee tier performance and pricing strategy."
    - name: "total_tier_qualifying_spend"
      expr: SUM(CAST(tier_qualifying_spend AS DOUBLE))
      comment: "Total spend qualifying toward tier thresholds across all members. Measures the revenue driven by loyalty tier incentives."
    - name: "avg_next_tier_gap"
      expr: AVG(CAST(next_tier_gap AS DOUBLE))
      comment: "Average points gap between current members and their next tier threshold. Used to design targeted tier upgrade campaigns and estimate incremental spend potential."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_consent_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent lifecycle and compliance metrics tracking consent grant/withdrawal rates, opt-out trends, and data processing consent health. Used by DPO, Legal, and Compliance teams to manage GDPR/CCPA obligations and consent program effectiveness."
  source: "`ecommerce_ecm`.`customer`.`consent_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of consent event (e.g., grant, withdraw, update). Used to track consent lifecycle transitions."
    - name: "consent_category"
      expr: consent_category
      comment: "Category of consent (e.g., marketing, analytics, third-party sharing). Used to measure consent coverage by purpose."
    - name: "processing_purpose"
      expr: processing_purpose
      comment: "Purpose for which data processing consent was collected. Used for GDPR Article 6 lawful basis reporting."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (e.g., consent, legitimate interest, contract). Critical for regulatory compliance reporting."
    - name: "processing_status"
      expr: processing_status
      comment: "Current processing status of the consent event. Used to track consent workflow completion rates."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (e.g., global, regional, product-specific). Used for jurisdictional compliance analysis."
    - name: "geolocation_country"
      expr: geolocation_country
      comment: "Country where the consent event occurred. Used for jurisdiction-specific compliance reporting (GDPR, CCPA, LGPD, etc.)."
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect consent (e.g., web form, mobile app, paper). Used to audit consent collection quality."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the consent event. Used to measure consent integrity and double opt-in compliance."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the consent event occurred. Used for consent trend analysis and regulatory audit timelines."
    - name: "source_system"
      expr: source_system
      comment: "System that originated the consent event. Used to audit consent collection across touchpoints."
  measures:
    - name: "total_consent_events"
      expr: COUNT(DISTINCT consent_event_id)
      comment: "Total number of consent events recorded. Baseline volume KPI for consent program activity monitoring."
    - name: "opt_out_sale_events"
      expr: COUNT(DISTINCT CASE WHEN opt_out_sale_flag = TRUE THEN consent_event_id END)
      comment: "Number of consent events where the customer opted out of data sale. Critical CCPA compliance KPI — high volume triggers data pipeline suppression actions."
    - name: "opt_out_sale_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN opt_out_sale_flag = TRUE THEN consent_event_id END) / NULLIF(COUNT(DISTINCT consent_event_id), 0), 2)
      comment: "Percentage of consent events with data sale opt-out. Measures CCPA opt-out exposure and informs data monetization risk."
    - name: "third_party_sharing_allowed_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_sharing_allowed = TRUE THEN consent_event_id END) / NULLIF(COUNT(DISTINCT consent_event_id), 0), 2)
      comment: "Percentage of consent events permitting third-party data sharing. Governs the addressable audience for data partnership programs."
    - name: "minor_consent_events"
      expr: COUNT(DISTINCT CASE WHEN is_minor = TRUE THEN consent_event_id END)
      comment: "Number of consent events involving minors. Requires parental consent verification — a high-priority compliance and legal risk KPI."
    - name: "parental_consent_verified_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_minor = TRUE AND parental_consent_verified = TRUE THEN consent_event_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_minor = TRUE THEN consent_event_id END), 0), 2)
      comment: "Percentage of minor consent events where parental consent has been verified. Critical child privacy compliance KPI (COPPA, GDPR-K)."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_wishlist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wishlist engagement and conversion metrics measuring customer intent signals, wishlist value, sharing behavior, and notification preferences. Used by Merchandising, Marketing, and Product teams to optimize conversion from intent to purchase."
  source: "`ecommerce_ecm`.`customer`.`wishlist`"
  dimensions:
    - name: "wishlist_type"
      expr: wishlist_type
      comment: "Type of wishlist (e.g., standard, gift registry, event). Used to segment wishlist behavior by use case."
    - name: "wishlist_status"
      expr: wishlist_status
      comment: "Current status of the wishlist (e.g., active, archived, deleted). Used to measure active intent inventory."
    - name: "visibility"
      expr: visibility
      comment: "Visibility setting of the wishlist (e.g., public, private, shared). Used to measure social sharing behavior."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the wishlist was created (e.g., web, mobile, app). Used for channel-specific engagement analysis."
    - name: "source_device_type"
      expr: source_device_type
      comment: "Device type used to create the wishlist (e.g., desktop, mobile, tablet). Used for device-specific UX optimization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the wishlist value. Used for multi-currency intent value analysis."
    - name: "notification_price_drop_enabled"
      expr: notification_price_drop_enabled
      comment: "Whether price drop notifications are enabled. Used to measure price-sensitive customer segments and notification feature adoption."
    - name: "notification_back_in_stock_enabled"
      expr: notification_back_in_stock_enabled
      comment: "Whether back-in-stock notifications are enabled. Used to measure demand recovery opportunity from out-of-stock items."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the wishlist was created. Used for wishlist creation trend analysis."
  measures:
    - name: "total_wishlists"
      expr: COUNT(DISTINCT wishlist_id)
      comment: "Total number of wishlists created. Measures customer intent capture volume — a leading indicator of future purchase demand."
    - name: "total_wishlist_value_at_save"
      expr: SUM(CAST(total_value_at_save AS DOUBLE))
      comment: "Total value of items at the time they were saved to wishlists. Represents the aggregate demand pipeline captured from customer intent signals."
    - name: "total_current_wishlist_value"
      expr: SUM(CAST(total_current_value AS DOUBLE))
      comment: "Total current market value of all items across active wishlists. Measures live demand pipeline value after price changes."
    - name: "avg_current_wishlist_value"
      expr: AVG(CAST(total_current_value AS DOUBLE))
      comment: "Average current value per wishlist. Used to benchmark wishlist depth and identify high-intent customer segments."
    - name: "wishlist_value_change"
      expr: ROUND(SUM(CAST(total_current_value AS DOUBLE)) - SUM(CAST(total_value_at_save AS DOUBLE)), 2)
      comment: "Net change in wishlist value from save time to current (price appreciation or depreciation). Used by Pricing teams to assess price movement impact on demand pipeline."
    - name: "avg_registry_completion_percentage"
      expr: AVG(CAST(registry_completion_percentage AS DOUBLE))
      comment: "Average completion percentage for gift registries. Used to measure registry fulfillment rates and identify gifting campaign opportunities."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segmentation health and scale metrics tracking segment size, activation status, compliance posture, and refresh cadence. Used by Marketing, Data Science, and Compliance teams to govern segment quality and regulatory alignment."
  source: "`ecommerce_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of customer segment (e.g., behavioral, demographic, predictive, RFM). Used to categorize segmentation strategy."
    - name: "segment_status"
      expr: segment_status
      comment: "Current activation status of the segment (e.g., active, draft, deactivated). Used to measure operational segment inventory."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign customers to the segment (e.g., rule-based, ML model, manual). Used to audit segmentation methodology."
    - name: "use_case"
      expr: use_case
      comment: "Business use case the segment serves (e.g., retention, upsell, acquisition). Used to align segment inventory with business objectives."
    - name: "owning_team"
      expr: owning_team
      comment: "Team responsible for the segment. Used for governance and accountability reporting."
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Whether the segment is GDPR compliant. Critical compliance KPI for EU market operations."
    - name: "ccpa_compliant_flag"
      expr: ccpa_compliant_flag
      comment: "Whether the segment is CCPA compliant. Critical compliance KPI for California market operations."
    - name: "consent_required_flag"
      expr: consent_required_flag
      comment: "Whether consent is required to use this segment. Used to enforce consent-gated activation workflows."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How frequently the segment membership is refreshed. Used to assess segment freshness and data staleness risk."
    - name: "activated_month"
      expr: DATE_TRUNC('month', activated_timestamp)
      comment: "Month the segment was activated. Used for segment lifecycle and portfolio growth analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of customer segments defined. Measures the breadth of the segmentation strategy and portfolio size."
    - name: "active_segments"
      expr: COUNT(DISTINCT CASE WHEN segment_status = 'active' THEN segment_id END)
      comment: "Number of currently active segments. Measures operational segment inventory available for campaign targeting."
    - name: "total_segment_members"
      expr: SUM(CAST(member_count AS DOUBLE))
      comment: "Total addressable audience across all active segments (sum of member counts). Used to size campaign reach and identify audience overlap risk."
    - name: "avg_segment_size"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average number of members per segment. Used to assess segment granularity — very small segments may indicate over-fragmentation."
    - name: "total_target_size"
      expr: SUM(CAST(target_size AS DOUBLE))
      comment: "Sum of target sizes across all segments. Used to measure planned audience reach vs. actual member count for segment fill rate analysis."
    - name: "segment_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(member_count AS DOUBLE)) / NULLIF(SUM(CAST(target_size AS DOUBLE)), 0), 2)
      comment: "Ratio of actual segment members to target size. A low fill rate signals data quality issues, overly restrictive rules, or audience availability gaps."
    - name: "gdpr_compliant_segment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gdpr_compliant_flag = TRUE THEN segment_id END) / NULLIF(COUNT(DISTINCT segment_id), 0), 2)
      comment: "Percentage of segments marked as GDPR compliant. Regulatory compliance KPI for EU market — non-compliant segments must be suppressed from EU campaigns."
    - name: "avg_baseline_metric_value"
      expr: AVG(CAST(baseline_metric_value AS DOUBLE))
      comment: "Average baseline KPI value across segments. Used to benchmark segment performance and measure lift from targeted interventions."
$$;