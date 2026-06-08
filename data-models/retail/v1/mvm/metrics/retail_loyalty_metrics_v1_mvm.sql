-- Metric views for domain: loyalty | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core membership health and engagement metrics. Tracks active member base, points economics, spend behaviour, tier distribution, and churn signals — the primary dashboard for loyalty programme steering."
  source: "`retail_ecm`.`loyalty`.`loyalty_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership (e.g. Active, Suspended, Closed). Primary filter for active-base analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g. In-Store, Online, Mobile App). Used to evaluate acquisition channel effectiveness."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of member enrollment. Enables cohort analysis and seasonal acquisition trend reporting."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of member enrollment. Supports year-over-year membership growth analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the member's points and spend are denominated. Required for multi-currency programme analysis."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the member holds VIP status (True/False). Enables segmentation of high-value members."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the membership has been flagged for fraud (True/False). Critical for risk and compliance reporting."
    - name: "language_preference"
      expr: language_preference
      comment: "Member's preferred communication language. Supports localisation and engagement strategy analysis."
    - name: "last_activity_month"
      expr: DATE_TRUNC('MONTH', last_activity_date)
      comment: "Month of the member's most recent activity. Used to identify dormant cohorts and recency segments."
    - name: "opt_in_email"
      expr: opt_in_email
      comment: "Whether the member has opted in to email communications (True/False). Drives email reachability reporting."
    - name: "opt_in_sms"
      expr: opt_in_sms
      comment: "Whether the member has opted in to SMS communications (True/False). Drives SMS reachability reporting."
    - name: "opt_in_push"
      expr: opt_in_push
      comment: "Whether the member has opted in to push notifications (True/False). Drives mobile engagement reporting."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN loyalty_membership_id END)
      comment: "Count of memberships currently in Active status. The primary KPI for programme scale and health — a declining active base signals churn risk."
    - name: "total_members"
      expr: COUNT(loyalty_membership_id)
      comment: "Total count of all loyalty memberships regardless of status. Baseline for penetration and activation rate calculations."
    - name: "total_vip_members"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN loyalty_membership_id END)
      comment: "Count of members with VIP status. VIP members typically drive disproportionate revenue; tracking this cohort is essential for retention investment decisions."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all points ever earned across the membership base. Measures programme engagement volume and informs liability forecasting."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Sum of all points ever redeemed across the membership base. Paired with earned points to compute redemption rate and assess programme attractiveness."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Aggregate outstanding points balance across all members. Represents the total unredeemed points liability — a critical finance and risk metric."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average outstanding points balance per member. Indicates typical member engagement depth and per-member liability exposure."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points across all members that are approaching expiry. Drives urgency-based re-engagement campaigns and liability management decisions."
    - name: "total_member_spend_amount"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Aggregate lifetime spend across all loyalty members. Core revenue attribution metric for the loyalty programme — used to justify programme investment."
    - name: "avg_member_spend_amount"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average lifetime spend per loyalty member. Benchmarks member value and informs tier threshold calibration."
    - name: "lifetime_redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that have been redeemed. A low rate signals low programme attractiveness or awareness; a very high rate signals liability risk. Key programme health KPI."
    - name: "fraud_flagged_member_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN loyalty_membership_id END)
      comment: "Count of memberships flagged for fraudulent activity. Directly informs fraud risk exposure and triggers compliance intervention."
    - name: "email_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_in_email = TRUE THEN loyalty_membership_id END) / NULLIF(COUNT(loyalty_membership_id), 0), 2)
      comment: "Percentage of members opted in to email communications. Determines the reachable email audience for campaigns — a key marketing efficiency driver."
    - name: "digital_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_in_push = TRUE OR opt_in_sms = TRUE THEN loyalty_membership_id END) / NULLIF(COUNT(loyalty_membership_id), 0), 2)
      comment: "Percentage of members opted in to at least one digital channel (push or SMS). Measures digital engagement reachability for the programme."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transactional points economics and liability metrics. Tracks points earned, redeemed, and expired at the transaction level — the financial engine of the loyalty programme. Supports P&L, liability, and fraud reporting."
  source: "`retail_ecm`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points ledger transaction (e.g. Earn, Redeem, Expire, Adjust). Primary dimension for decomposing points flow."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the ledger transaction (e.g. Posted, Pending, Reversed). Used to filter to settled transactions for financial reporting."
    - name: "channel"
      expr: channel
      comment: "Channel through which the points transaction occurred (e.g. In-Store, Online, Mobile). Enables omnichannel points flow analysis."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the points ledger transaction. Enables monthly trend analysis of points economics."
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of the points ledger transaction. Supports year-over-year points volume and liability trend reporting."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Indicates whether the points transaction was driven by a promotional offer (True/False). Separates baseline earn from promotional uplift."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code associated with the transaction. Required for multi-currency liability reporting."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month in which the points are set to expire. Used for forward-looking liability expiry scheduling."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason code for manual points adjustments. Supports audit and exception reporting."
  measures:
    - name: "total_points_issued"
      expr: SUM(CASE WHEN transaction_type = 'Earn' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points issued to members via earn transactions. Measures programme engagement volume and drives liability accrual."
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'Redeem' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points redeemed by members. Measures programme utilisation and reduces outstanding liability."
    - name: "total_points_expired"
      expr: SUM(CASE WHEN transaction_type = 'Expire' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points expired without redemption. Represents breakage — a direct financial benefit to the business and a signal of low programme engagement."
    - name: "total_points_liability_amount"
      expr: SUM(CAST(points_liability_amount AS DOUBLE))
      comment: "Total monetary liability associated with outstanding points across all ledger entries. A critical finance metric for balance sheet provisioning."
    - name: "total_qualifying_spend_amount"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total spend amount that qualified for points earning. Measures the revenue base driving loyalty engagement."
    - name: "avg_earn_multiplier"
      expr: AVG(CAST(earn_multiplier AS DOUBLE))
      comment: "Average points earn multiplier applied across transactions. Indicates the blended promotional intensity of the earn programme."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total transaction value in base currency across all ledger entries. Provides the monetary scale of loyalty-linked transactions."
    - name: "avg_redemption_value_per_point"
      expr: AVG(CAST(redemption_value_per_point AS DOUBLE))
      comment: "Average monetary value delivered per redeemed point. Measures the cost efficiency of the redemption programme — a key lever for programme economics."
    - name: "breakage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transaction_type = 'Expire' THEN CAST(points_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CASE WHEN transaction_type = 'Earn' THEN CAST(points_amount AS DOUBLE) ELSE 0 END), 0), 2)
      comment: "Percentage of earned points that expire unredeemed (breakage rate). Directly impacts programme P&L — high breakage reduces liability but signals low member engagement."
    - name: "promotional_points_share_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_promotional = TRUE THEN CAST(points_amount AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(points_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total points issued that were promotional. High promotional share may indicate over-reliance on promotions to drive engagement — a margin risk signal."
    - name: "unique_earning_members"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Count of distinct members with at least one points ledger entry in the period. Measures active programme participation breadth."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption performance and fraud risk metrics. Tracks redemption volume, monetary value, fraud exposure, and fulfilment patterns — essential for programme cost management and risk governance."
  source: "`retail_ecm`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (e.g. Discount, Free Product, Gift Card, Charity). Enables analysis of which reward types drive the most engagement."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (e.g. Completed, Cancelled, Pending, Reversed). Used to filter to settled redemptions for financial reporting."
    - name: "channel"
      expr: channel
      comment: "Channel through which the redemption occurred (e.g. In-Store, Online, Mobile). Enables omnichannel redemption pattern analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method used to fulfil the redemption (e.g. Instant, Voucher, Delivery). Informs operational fulfilment cost and member experience analysis."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of the redemption event. Enables monthly redemption trend and seasonality analysis."
    - name: "redemption_year"
      expr: YEAR(redemption_timestamp)
      comment: "Year of the redemption event. Supports year-over-year redemption volume and cost trend reporting."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Loyalty tier of the member at the time of redemption. Enables tier-level redemption behaviour analysis to calibrate tier benefits."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Indicates whether the redemption was identified as fraudulent (True/False). Critical dimension for fraud risk segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption monetary value. Required for multi-currency programme cost reporting."
  measures:
    - name: "total_redemptions"
      expr: COUNT(redemption_id)
      comment: "Total count of redemption events. Baseline measure of programme utilisation — a key indicator of member engagement and programme attractiveness."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points consumed across all redemptions. Measures the rate at which the points liability is being drawn down."
    - name: "total_redemption_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all redemptions. Represents the direct cost of the redemption programme — a critical P&L line item."
    - name: "avg_redemption_monetary_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per redemption event. Benchmarks redemption generosity and informs reward catalogue pricing decisions."
    - name: "avg_fraud_detection_score"
      expr: AVG(CAST(fraud_detection_score AS DOUBLE))
      comment: "Average fraud detection score across redemptions. A rising average signals increasing fraud risk in the redemption programme — triggers risk team intervention."
    - name: "fraudulent_redemption_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN redemption_id END)
      comment: "Count of redemptions identified as fraudulent. Directly measures fraud exposure and drives compliance and security investment decisions."
    - name: "fraudulent_redemption_value"
      expr: SUM(CASE WHEN is_fraudulent = TRUE THEN CAST(monetary_value AS DOUBLE) ELSE 0 END)
      comment: "Total monetary value of fraudulent redemptions. Quantifies the financial loss from redemption fraud — a key risk governance metric."
    - name: "fraud_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions identified as fraudulent. The primary fraud risk KPI for the loyalty programme — exceeding threshold triggers immediate investigation."
    - name: "cancelled_redemption_count"
      expr: COUNT(CASE WHEN redemption_status = 'Cancelled' THEN redemption_id END)
      comment: "Count of cancelled redemptions. High cancellation rates signal member experience friction or fulfilment failures — an operational quality metric."
    - name: "unique_redeeming_members"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Count of distinct members who redeemed in the period. Measures the breadth of active redemption participation — a key programme engagement KPI."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points consumed per redemption event. Indicates typical redemption size and informs minimum threshold calibration."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Segment portfolio health and value metrics. Tracks the size, spend, LTV, and points economics of loyalty member segments — essential for targeted marketing investment and personalisation strategy."
  source: "`retail_ecm`.`loyalty`.`member_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the member segment. Primary grouping dimension for segment-level performance comparison."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (e.g. Behavioural, Demographic, Predictive). Enables analysis of segment methodology effectiveness."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (e.g. Active, Archived, Draft). Used to filter to operationally active segments."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Customer lifecycle stage associated with the segment (e.g. Acquisition, Growth, Retention, Win-back). Aligns segment metrics to lifecycle strategy."
    - name: "campaign_eligibility_flag"
      expr: campaign_eligibility_flag
      comment: "Whether the segment is eligible for campaign targeting (True/False). Determines the actionable audience pool for marketing."
    - name: "offer_eligibility_flag"
      expr: offer_eligibility_flag
      comment: "Whether the segment is eligible for personalised offers (True/False). Drives personalisation programme scope."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How frequently the segment membership is refreshed (e.g. Daily, Weekly, Monthly). Indicates segment data freshness and operational reliability."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the segment became effective. Enables cohort analysis of segment creation and lifecycle."
  measures:
    - name: "total_segment_member_count"
      expr: SUM(CAST(member_count AS DOUBLE))
      comment: "Total members across all segments. Measures the scale of segmented audience available for targeted marketing."
    - name: "avg_segment_member_count"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average member count per segment. Benchmarks segment granularity — very large or very small segments may indicate poor segmentation quality."
    - name: "total_target_member_count"
      expr: SUM(CAST(target_member_count AS DOUBLE))
      comment: "Total targeted member count across all segments. Measures the planned reach of the segmentation strategy."
    - name: "segment_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(member_count AS DOUBLE)) / NULLIF(SUM(CAST(target_member_count AS DOUBLE)), 0), 2)
      comment: "Percentage of target member count achieved across segments. Measures segmentation model accuracy — low fill rate signals model or data quality issues."
    - name: "avg_segment_ltv"
      expr: AVG(CAST(average_ltv AS DOUBLE))
      comment: "Average lifetime value across segments. Enables prioritisation of high-LTV segments for retention investment."
    - name: "avg_segment_annual_spend"
      expr: AVG(CAST(average_annual_spend AS DOUBLE))
      comment: "Average annual spend per member across segments. Benchmarks segment revenue contribution and informs spend-based tier thresholds."
    - name: "avg_segment_points_balance"
      expr: AVG(CAST(average_points_balance AS DOUBLE))
      comment: "Average points balance per member across segments. Indicates engagement depth by segment — low balances in high-LTV segments signal redemption friction."
    - name: "active_campaign_eligible_segments"
      expr: COUNT(CASE WHEN campaign_eligibility_flag = TRUE AND segment_status = 'Active' THEN member_segment_id END)
      comment: "Count of active segments eligible for campaign targeting. Defines the operational scope of the targeted marketing programme."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points accrual rule portfolio metrics. Tracks the configuration, generosity, and coverage of earn rules — essential for programme economics governance and promotional strategy alignment."
  source: "`retail_ecm`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of accrual rule (e.g. Base Earn, Bonus, Promotional). Enables decomposition of the earn rule portfolio by type."
    - name: "accrual_rule_status"
      expr: accrual_rule_status
      comment: "Current status of the accrual rule (e.g. Active, Inactive, Pending). Used to filter to live earn rules."
    - name: "applicable_channel"
      expr: applicable_channel
      comment: "Channel to which the accrual rule applies (e.g. In-Store, Online, All). Enables channel-level earn rule coverage analysis."
    - name: "earning_basis"
      expr: earning_basis
      comment: "Basis on which points are earned (e.g. Spend, Units, Visit). Determines the earn mechanic type for programme design analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the rule (e.g. Approved, Pending, Rejected). Governance dimension for rule lifecycle management."
    - name: "stacking_allowed_flag"
      expr: stacking_allowed_flag
      comment: "Whether this rule can be stacked with other earn rules (True/False). Stacking rules have higher liability exposure — critical for financial risk governance."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the accrual rule became effective. Enables trend analysis of rule portfolio evolution over time."
  measures:
    - name: "total_active_accrual_rules"
      expr: COUNT(CASE WHEN accrual_rule_status = 'Active' THEN accrual_rule_id END)
      comment: "Count of currently active accrual rules. Measures the complexity and breadth of the earn rule portfolio — excessive rule proliferation increases operational risk."
    - name: "avg_points_per_unit"
      expr: AVG(CAST(points_per_unit AS DOUBLE))
      comment: "Average points awarded per unit across all active earn rules. Benchmarks programme generosity — a key lever for competitive positioning and liability management."
    - name: "avg_bonus_multiplier"
      expr: AVG(CAST(bonus_multiplier AS DOUBLE))
      comment: "Average bonus multiplier across earn rules. Measures the blended promotional uplift in the earn programme — high averages signal elevated liability exposure."
    - name: "avg_minimum_spend_threshold"
      expr: AVG(CAST(minimum_spend_threshold AS DOUBLE))
      comment: "Average minimum spend required to trigger earn rules. Indicates the programme's spend activation barrier — too high reduces participation, too low increases cost."
    - name: "stacking_rule_count"
      expr: COUNT(CASE WHEN stacking_allowed_flag = TRUE THEN accrual_rule_id END)
      comment: "Count of earn rules that allow stacking with other rules. Stacking rules compound liability exposure — a key risk governance metric for the finance team."
    - name: "stacking_rule_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stacking_allowed_flag = TRUE THEN accrual_rule_id END) / NULLIF(COUNT(accrual_rule_id), 0), 2)
      comment: "Percentage of earn rules that allow stacking. High stacking share increases uncontrolled liability risk — monitored by finance and programme governance teams."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_reward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reward catalogue economics and margin metrics. Tracks the cost, value, and margin profile of the reward portfolio — essential for programme cost governance and catalogue optimisation."
  source: "`retail_ecm`.`loyalty`.`reward`"
  dimensions:
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward (e.g. Discount, Free Product, Experience, Gift Card). Primary dimension for reward portfolio composition analysis."
    - name: "reward_category"
      expr: reward_category
      comment: "Category of the reward. Enables category-level cost and engagement analysis within the reward catalogue."
    - name: "reward_status"
      expr: reward_status
      comment: "Current status of the reward (e.g. Active, Inactive, Expired). Used to filter to live catalogue items."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount mechanism (e.g. Percentage, Fixed Amount). Enables analysis of discount structure within the reward catalogue."
    - name: "is_featured"
      expr: is_featured
      comment: "Whether the reward is featured in the catalogue (True/False). Featured rewards receive higher visibility — used to assess merchandising effectiveness."
    - name: "is_combinable"
      expr: is_combinable
      comment: "Whether the reward can be combined with other offers (True/False). Combinable rewards have higher liability exposure."
    - name: "channel_availability"
      expr: channel_availability
      comment: "Channels through which the reward is available (e.g. In-Store, Online, All). Enables omnichannel reward coverage analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the reward became effective. Enables catalogue refresh cadence and seasonal reward analysis."
  measures:
    - name: "total_active_rewards"
      expr: COUNT(CASE WHEN reward_status = 'Active' THEN reward_id END)
      comment: "Count of currently active rewards in the catalogue. Measures catalogue breadth — a key driver of member engagement and programme attractiveness."
    - name: "total_cost_to_business"
      expr: SUM(CAST(cost_to_business AS DOUBLE))
      comment: "Total cost to the business of the reward catalogue. The primary programme cost metric — directly impacts loyalty programme ROI."
    - name: "avg_cost_to_business"
      expr: AVG(CAST(cost_to_business AS DOUBLE))
      comment: "Average cost per reward item. Benchmarks reward generosity and informs catalogue pricing and margin decisions."
    - name: "total_reward_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total face value of all rewards in the catalogue. Represents the maximum potential liability if all rewards were redeemed."
    - name: "avg_reward_monetary_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average face value per reward. Indicates the typical reward generosity level — a key competitive positioning metric."
    - name: "avg_margin_percentage"
      expr: AVG(CAST(margin_percentage AS DOUBLE))
      comment: "Average margin percentage across rewards. Measures the profitability of the reward catalogue — low or negative margins signal unsustainable programme economics."
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase required to qualify for rewards. Indicates the spend activation barrier for reward redemption — calibrated to drive basket size uplift."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value offered across rewards. Measures the blended discount depth in the reward catalogue — a key margin risk indicator."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`loyalty_member_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Personalised offer performance and liability metrics. Tracks offer activation, redemption, estimated liability, and personalisation quality — essential for marketing ROI and offer strategy governance."
  source: "`retail_ecm`.`loyalty`.`member_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of member offer (e.g. Points Bonus, Discount, Free Item). Primary dimension for offer portfolio composition analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (e.g. Active, Expired, Redeemed). Used to filter to live or completed offers."
    - name: "offer_source"
      expr: offer_source
      comment: "Source of the offer (e.g. Personalisation Engine, Manual, Partner). Enables analysis of offer generation channel effectiveness."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channel for which the offer is applicable (e.g. In-Store, Online, All). Enables omnichannel offer coverage analysis."
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount mechanism in the offer (e.g. Percentage, Fixed Amount). Enables discount structure analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "Event or condition that triggers the offer (e.g. Purchase, Birthday, Tier Upgrade). Informs trigger-based campaign effectiveness."
    - name: "offer_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the offer became active. Enables monthly offer volume and liability trend analysis."
    - name: "presentation_month"
      expr: DATE_TRUNC('MONTH', presentation_timestamp)
      comment: "Month the offer was presented to the member. Used to measure offer presentation cadence and timing effectiveness."
  measures:
    - name: "total_offers_issued"
      expr: COUNT(member_offer_id)
      comment: "Total count of personalised offers issued to members. Measures the scale of the personalised marketing programme."
    - name: "total_estimated_liability"
      expr: SUM(CAST(estimated_liability_amount AS DOUBLE))
      comment: "Total estimated financial liability across all issued offers. Critical for finance provisioning and programme cost governance."
    - name: "avg_estimated_liability_per_offer"
      expr: AVG(CAST(estimated_liability_amount AS DOUBLE))
      comment: "Average estimated liability per offer. Benchmarks offer cost and informs offer value calibration decisions."
    - name: "avg_personalization_score"
      expr: AVG(CAST(personalization_score AS DOUBLE))
      comment: "Average personalisation score across offers. Measures the quality of the personalisation engine — low scores indicate poor targeting and wasted marketing spend."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier offered across member offers. Indicates the blended promotional generosity of the offer programme — a key liability driver."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value across member offers. Measures the monetary generosity of the offer catalogue — directly impacts programme margin."
    - name: "avg_minimum_spend_amount"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend required to activate member offers. Indicates the spend threshold calibration — a lever for basket size uplift."
    - name: "unique_members_with_offers"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Count of distinct members who received at least one personalised offer. Measures the reach of the personalised marketing programme."
$$;