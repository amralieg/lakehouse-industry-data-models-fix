-- Metric views for domain: customer | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the customer profile master entity. Tracks active customer base size, acquisition trends, lifecycle distribution, and loyalty tier composition — core inputs for CRM, retention, and growth strategy."
  source: "`vibe_retail_v1`.`customer`.`profile`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Customer lifecycle stage (e.g. prospect, active, lapsed, churned) — used to segment KPIs by customer maturity."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty program tier (e.g. Bronze, Silver, Gold, Platinum) — key dimension for retention and reward strategy analysis."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the customer was acquired (e.g. organic, paid, referral, in-store) — used to evaluate channel ROI."
    - name: "entity_type"
      expr: entity_type
      comment: "Distinguishes individual consumers from business entities — enables B2C vs B2B segmentation."
    - name: "gender"
      expr: gender
      comment: "Customer gender — used for demographic segmentation in marketing and product strategy."
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Customer's preferred engagement channel (e.g. email, SMS, in-store) — informs omnichannel investment decisions."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the customer profile (e.g. active, inactive, merged) — used to filter and monitor data quality."
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of customer acquisition — enables cohort analysis and acquisition trend reporting."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Customer's preferred language — used for localization and regional marketing segmentation."
    - name: "nationality"
      expr: nationality
      comment: "Customer nationality — supports geographic and demographic segmentation."
  measures:
    - name: "total_active_customers"
      expr: COUNT(CASE WHEN profile_status = 'active' AND is_current_flag = TRUE THEN profile_id END)
      comment: "Count of currently active customer profiles. Core KPI for measuring the size of the active customer base — a primary growth indicator."
    - name: "total_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total distinct customer profiles in the system. Baseline headcount metric used in penetration, coverage, and growth rate calculations."
    - name: "new_customer_acquisitions"
      expr: COUNT(CASE WHEN is_current_flag = TRUE THEN profile_id END)
      comment: "Count of current-version customer profiles — proxies new or refreshed customer records for acquisition trend analysis."
    - name: "mdm_avg_confidence_score"
      expr: AVG(CAST(mdm_confidence_score AS DOUBLE))
      comment: "Average MDM (Master Data Management) confidence score across customer profiles. Measures data quality and identity resolution accuracy — low scores signal data governance risk."
    - name: "marketing_opt_in_rate"
      expr: COUNT(CASE WHEN marketing_opt_in = 'true' OR marketing_opt_in = 'yes' OR marketing_opt_in = '1' THEN profile_id END)
      comment: "Count of customers opted into marketing communications. Drives addressable audience sizing for campaign planning and compliance monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs over customer accounts. Tracks credit exposure, loyalty enrollment, tax-exempt portfolio, and account lifecycle health — critical for credit risk, revenue operations, and compliance."
  source: "`vibe_retail_v1`.`customer`.`account`"
  dimensions:
    - name: "account_type"
      expr: CAST(account_type AS STRING)
      comment: "Type of customer account (encoded as numeric) — used to segment KPIs by account classification."
    - name: "account_status"
      expr: CAST(account_status AS STRING)
      comment: "Current status of the account (encoded as numeric) — used to filter active vs. inactive accounts in KPI views."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the account operates — essential for multi-currency financial reporting."
    - name: "b2b_pricing_flag"
      expr: b2b_pricing_flag
      comment: "Indicates whether the account is on B2B pricing — enables B2B vs B2C account segmentation."
    - name: "loyalty_program_enrolled"
      expr: loyalty_program_enrolled
      comment: "Whether the account is enrolled in the loyalty program — used to measure loyalty program penetration."
    - name: "suspension_reason"
      expr: suspension_reason
      comment: "Reason for account suspension — used to categorize and analyze account health issues."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened — enables cohort and vintage analysis of account portfolios."
    - name: "is_current_flag"
      expr: is_current_flag
      comment: "SCD current record flag — used to filter to the latest version of each account record."
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Measures aggregate credit exposure — a key risk management and capital allocation KPI."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account. Benchmarks credit policy generosity and risk appetite across account segments."
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN is_current_flag = TRUE THEN account_id END)
      comment: "Count of current active account records. Core operational metric for account portfolio size and growth tracking."
    - name: "loyalty_enrolled_accounts"
      expr: COUNT(CASE WHEN loyalty_program_enrolled = TRUE THEN account_id END)
      comment: "Number of accounts enrolled in the loyalty program. Measures loyalty program penetration — directly tied to retention and repeat purchase strategy."
    - name: "suspended_accounts"
      expr: COUNT(CASE WHEN suspension_reason IS NOT NULL THEN account_id END)
      comment: "Count of accounts with a suspension reason recorded. Tracks account health risk — rising suspensions signal credit or compliance issues requiring intervention."
    - name: "b2b_account_count"
      expr: COUNT(CASE WHEN b2b_pricing_flag = TRUE THEN account_id END)
      comment: "Number of accounts on B2B pricing. Measures B2B customer base size — informs wholesale and enterprise revenue strategy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level financial and behavioral KPIs. Tracks combined lifetime value, spend, loyalty, and basket metrics across household units — essential for family/household-based marketing, segmentation, and CLV strategy."
  source: "`vibe_retail_v1`.`customer`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household (e.g. active, inactive) — used to filter KPIs to relevant household cohorts."
    - name: "household_type"
      expr: household_type
      comment: "Classification of the household type — enables demographic segmentation for targeted marketing."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the household — key dimension for retention investment and reward tier analysis."
    - name: "segment"
      expr: segment
      comment: "Marketing or behavioral segment assigned to the household — used for targeted campaign and offer analysis."
    - name: "estimated_income_band"
      expr: estimated_income_band
      comment: "Estimated household income band — used for affluence-based segmentation and premium product targeting."
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Household's preferred engagement channel — informs omnichannel investment and personalization strategy."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the household has opted into marketing — used to size addressable audience for campaigns."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the household — supports localization and regional marketing decisions."
    - name: "last_purchase_month"
      expr: DATE_TRUNC('MONTH', last_purchase_date)
      comment: "Month of the household's most recent purchase — used for recency analysis and lapsed customer identification."
  measures:
    - name: "total_combined_cltv"
      expr: SUM(CAST(combined_cltv AS DOUBLE))
      comment: "Sum of combined customer lifetime value across all households. Top-line CLV metric used by executives to assess the total value of the customer base."
    - name: "avg_combined_cltv"
      expr: AVG(CAST(combined_cltv AS DOUBLE))
      comment: "Average combined CLV per household. Benchmarks household value — used to identify high-value segments and prioritize retention investment."
    - name: "total_household_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total cumulative spend across all households. Revenue contribution metric used to size the household customer segment's financial impact."
    - name: "avg_household_spend"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average total spend per household. Used to benchmark household spending levels and identify high-value vs. low-value household cohorts."
    - name: "avg_basket_value"
      expr: AVG(CAST(average_basket_value AS DOUBLE))
      comment: "Average basket value across households. Measures transaction size efficiency — a key input for upsell and cross-sell strategy."
    - name: "total_loyalty_points"
      expr: SUM(CAST(total_loyalty_points AS DOUBLE))
      comment: "Total loyalty points outstanding across all households. Measures loyalty liability and program engagement — rising balances signal redemption risk or strong engagement."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(total_purchase_count AS DOUBLE))
      comment: "Average number of purchases per household. Measures customer engagement depth — low frequency signals churn risk or under-activation."
    - name: "data_sharing_consent_count"
      expr: COUNT(CASE WHEN data_sharing_consent = TRUE THEN household_id END)
      comment: "Number of households with data sharing consent. Measures the consented data asset size — critical for privacy compliance and data monetization strategy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction and engagement KPIs. Tracks interaction volume, channel mix, sentiment, NPS, and digital engagement — essential for CX strategy, channel investment decisions, and service quality management."
  source: "`vibe_retail_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (e.g. call, email, chat, in-store visit) — primary dimension for interaction volume analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred (e.g. web, mobile, store, call center) — used for omnichannel engagement analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction (e.g. resolved, escalated, abandoned) — used to measure service effectiveness."
    - name: "direction"
      expr: direction
      comment: "Direction of the interaction (inbound vs. outbound) — used to distinguish customer-initiated vs. brand-initiated contacts."
    - name: "device_type"
      expr: device_type
      comment: "Device used during the interaction (e.g. mobile, desktop, tablet) — informs digital experience investment priorities."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month of the interaction — enables trend analysis of interaction volumes and quality over time."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the interaction (e.g. for email/SMS campaigns) — used to measure communication reach."
    - name: "digital_property"
      expr: digital_property
      comment: "Digital property where the interaction occurred (e.g. website, app, social) — used for digital channel attribution."
  measures:
    - name: "total_interactions"
      expr: COUNT(interaction_id)
      comment: "Total number of customer interactions. Baseline engagement volume metric — used to track CX workload and customer activity trends."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across interactions. Primary customer satisfaction KPI — directly tied to loyalty, churn risk, and brand health."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across customer interactions. Measures overall customer sentiment — declining scores trigger CX intervention and service recovery actions."
    - name: "avg_interaction_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average duration of customer interactions in seconds. Measures service efficiency — high durations signal complexity or agent performance issues."
    - name: "total_interaction_duration_seconds"
      expr: SUM(CAST(duration_seconds AS DOUBLE))
      comment: "Total interaction duration in seconds across all contacts. Measures aggregate service capacity consumed — used for staffing and cost-to-serve analysis."
    - name: "email_open_count"
      expr: COUNT(CASE WHEN email_opened_flag = TRUE THEN interaction_id END)
      comment: "Number of interactions where the email was opened. Measures email campaign reach and engagement — key input for digital marketing ROI."
    - name: "email_click_count"
      expr: COUNT(CASE WHEN email_clicked_flag = TRUE THEN interaction_id END)
      comment: "Number of interactions where the email was clicked. Measures email campaign conversion engagement — used to evaluate content effectiveness."
    - name: "unsubscribe_count"
      expr: COUNT(CASE WHEN unsubscribed_flag = TRUE THEN interaction_id END)
      comment: "Number of customers who unsubscribed during an interaction. Tracks opt-out rate — rising unsubscribes signal messaging fatigue or relevance issues requiring immediate action."
    - name: "unique_customers_interacted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers who had at least one interaction. Measures active engagement breadth — used to assess CX reach and identify under-engaged customer segments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment portfolio KPIs. Tracks segment size, CLV, AOV, churn risk, NPS, and RFM distribution across the segment catalog — essential for marketing strategy, resource allocation, and segment health monitoring."
  source: "`vibe_retail_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of customer segment (e.g. behavioral, demographic, value-based) — used to categorize and compare segment strategies."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (e.g. active, archived, draft) — used to filter to operationally relevant segments."
    - name: "b2b_b2c_indicator"
      expr: b2b_b2c_indicator
      comment: "Indicates whether the segment targets B2B or B2C customers — enables separate B2B and B2C performance tracking."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier of the segment (e.g. Tier 1, Tier 2) — used to allocate marketing budget and attention to highest-value segments."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment (e.g. national, regional, local) — used for geographic marketing strategy analysis."
    - name: "target_marketing_channel"
      expr: target_marketing_channel
      comment: "Primary marketing channel targeted for this segment — used to analyze channel strategy by segment."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit responsible for the segment — enables accountability and performance tracking by business unit."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the segment became effective — used for segment vintage and lifecycle analysis."
  measures:
    - name: "total_segment_members"
      expr: SUM(CAST(membership_count AS BIGINT))
      comment: "Total number of customer memberships across all segments. Measures the aggregate reach of segmentation — used to assess coverage and overlap in the segment portfolio."
    - name: "avg_segment_cltv"
      expr: AVG(CAST(average_cltv AS DOUBLE))
      comment: "Average customer lifetime value across segments. Benchmarks the value profile of the segment portfolio — used to prioritize high-CLV segment investment."
    - name: "avg_segment_aov"
      expr: AVG(CAST(average_aov AS DOUBLE))
      comment: "Average order value across segments. Measures transaction size by segment — used to identify premium segments for upsell and cross-sell targeting."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across segments. Measures portfolio-level retention risk — high scores trigger proactive retention investment and intervention programs."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score across customer segments. Measures satisfaction by segment — used to identify segments requiring CX improvement investment."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(average_purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency across segments. Measures engagement depth by segment — low frequency segments are candidates for activation campaigns."
    - name: "avg_discount_sensitivity"
      expr: AVG(CAST(discount_sensitivity AS DOUBLE))
      comment: "Average discount sensitivity score across segments. Informs promotional pricing strategy — high sensitivity segments require careful margin management."
    - name: "avg_transaction_value"
      expr: AVG(CAST(avg_transaction_value AS DOUBLE))
      comment: "Average transaction value across segments. Measures revenue per transaction by segment — used to benchmark and target high-value transaction segments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`customer_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment membership KPIs. Tracks membership enrollment, renewal rates, fee revenue, assignment confidence, and active membership health — essential for loyalty program management and segment qualification strategy."
  source: "`vibe_retail_v1`.`customer`.`membership`"
  dimensions:
    - name: "customer_membership_status"
      expr: customer_membership_status
      comment: "Current status of the membership (e.g. active, expired, pending) — primary dimension for membership health analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the customer to the segment (e.g. rule-based, ML model, manual) — used to evaluate assignment strategy effectiveness."
    - name: "manual_override_flag"
      expr: manual_override_flag
      comment: "Indicates whether the membership was manually overridden — used to monitor data governance and model trust."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the membership started — enables cohort analysis of membership enrollment trends."
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the membership ended or is scheduled to end — used for churn and expiry forecasting."
  measures:
    - name: "total_active_memberships"
      expr: COUNT(CASE WHEN customer_membership_status = 'active' THEN membership_id END)
      comment: "Count of currently active segment memberships. Measures the live enrolled customer base across segments — core loyalty program health KPI."
    - name: "total_membership_fee_revenue"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total membership fees collected across all memberships. Measures direct revenue from membership programs — used to evaluate program monetization."
    - name: "avg_membership_fee"
      expr: AVG(CAST(fee AS DOUBLE))
      comment: "Average membership fee per enrollment. Benchmarks fee pricing strategy — used to optimize membership tier pricing."
    - name: "avg_renewal_rate"
      expr: AVG(CAST(renewal_rate AS DOUBLE))
      comment: "Average membership renewal rate. Measures loyalty program stickiness — low renewal rates signal dissatisfaction or poor value perception requiring strategic intervention."
    - name: "avg_assignment_confidence_score"
      expr: AVG(CAST(assignment_confidence_score AS DOUBLE))
      comment: "Average confidence score of segment assignment. Measures segmentation model quality — low scores indicate poor model performance and risk of misallocated marketing spend."
    - name: "manual_override_count"
      expr: COUNT(CASE WHEN manual_override_flag = TRUE THEN membership_id END)
      comment: "Number of memberships with manual overrides. Measures reliance on manual intervention in segmentation — high counts signal model trust issues or process gaps."
$$;