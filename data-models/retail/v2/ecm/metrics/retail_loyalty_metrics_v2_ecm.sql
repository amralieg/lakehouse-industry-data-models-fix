-- Metric views for domain: loyalty | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty membership KPIs tracking active member base, engagement health, points economics, and spend performance across the loyalty program."
  source: "`vibe_retail_v1`.`loyalty`.`loyalty_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the loyalty membership (active, suspended, closed, etc.) for cohort segmentation."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (in-store, online, mobile app, etc.) to analyze acquisition mix."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the member holds VIP status, enabling VIP vs. standard member comparisons."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flags memberships identified as fraudulent for exclusion or risk analysis."
    - name: "language_preference"
      expr: language_preference
      comment: "Member language preference for localization and communication segmentation."
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for cohort and trend analysis of member acquisition."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which member spend and points are denominated."
  measures:
    - name: "active_member_count"
      expr: COUNT(DISTINCT CASE WHEN membership_status = 'active' THEN loyalty_membership_id END)
      comment: "Number of distinct active loyalty members. Core KPI for program health and scale."
    - name: "total_member_count"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Total enrolled loyalty members regardless of status. Baseline for penetration and activation rate calculations."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Sum of all points ever earned across members. Indicates program engagement volume and liability exposure."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Sum of all points ever redeemed. Measures redemption activity and program value delivery to members."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Aggregate unredeemed points balance across all members. Represents total outstanding loyalty liability."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points at risk of expiry in the near term. Drives urgency campaigns and liability management decisions."
    - name: "total_member_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Aggregate lifetime spend across all loyalty members. Key revenue attribution metric for the program."
    - name: "avg_member_spend"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average lifetime spend per loyalty member. Benchmarks member value and informs tier threshold calibration."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average unredeemed points balance per member. Signals engagement health and redemption friction."
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have been redeemed. A low rate signals redemption barriers; a very high rate signals liability risk."
    - name: "vip_member_count"
      expr: COUNT(DISTINCT CASE WHEN vip_flag = TRUE THEN loyalty_membership_id END)
      comment: "Number of VIP-flagged members. Tracks the high-value member cohort size for targeted investment decisions."
    - name: "fraud_flagged_member_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN loyalty_membership_id END)
      comment: "Number of memberships flagged for fraud. Monitors program integrity and informs fraud prevention investment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points economics and liability metrics derived from the points ledger. Tracks earn, burn, breakage, and financial exposure at transaction granularity."
  source: "`vibe_retail_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points ledger entry (earn, redeem, adjust, expire, reverse) for earn vs. burn analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the ledger transaction (posted, pending, reversed) for reconciliation filtering."
    - name: "channel"
      expr: channel
      comment: "Channel where the points-generating transaction occurred (in-store, online, mobile) for omnichannel analysis."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Indicates whether the points were awarded under a promotional rule, enabling promotional vs. base earn separation."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the ledger transaction for trend and seasonality analysis."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month in which points are scheduled to expire. Used for forward-looking liability and expiry campaign planning."
  measures:
    - name: "total_points_awarded"
      expr: SUM(CASE WHEN transaction_type = 'earn' THEN points_amount ELSE 0 END)
      comment: "Total points awarded to members. Measures program generosity and earn-side liability creation."
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'redeem' THEN points_amount ELSE 0 END)
      comment: "Total points redeemed by members. Measures redemption activity and value delivered back to customers."
    - name: "total_points_expired"
      expr: SUM(CASE WHEN transaction_type = 'expire' THEN points_amount ELSE 0 END)
      comment: "Total points that have expired without redemption. Represents breakage — a financial benefit to the business but a member experience risk."
    - name: "total_points_liability_amount"
      expr: SUM(CAST(points_liability_amount AS DOUBLE))
      comment: "Total financial liability associated with outstanding points. Critical for finance reporting and balance sheet provisioning."
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total qualifying spend that generated points. Measures the revenue base driving loyalty earn activity."
    - name: "avg_earn_multiplier"
      expr: AVG(CAST(earn_multiplier AS DOUBLE))
      comment: "Average earn multiplier applied across ledger entries. Tracks promotional generosity and cost of earn."
    - name: "avg_redemption_value_per_point"
      expr: AVG(CAST(redemption_value_per_point AS DOUBLE))
      comment: "Average monetary value delivered per redeemed point. Benchmarks redemption economics and program cost efficiency."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total transaction value in base currency associated with points ledger entries. Links points activity to revenue volume."
    - name: "avg_breakage_rate"
      expr: AVG(CAST(breakage_rate AS DOUBLE))
      comment: "Average breakage rate across ledger entries. Informs actuarial estimates for points liability provisioning."
    - name: "promotional_points_awarded"
      expr: SUM(CASE WHEN is_promotional = TRUE THEN points_amount ELSE 0 END)
      comment: "Points awarded under promotional rules. Measures incremental promotional cost vs. base program cost."
    - name: "ledger_transaction_count"
      expr: COUNT(1)
      comment: "Total number of points ledger entries. Baseline volume metric for activity and processing load monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption activity KPIs measuring member value realization, fraud exposure, and fulfillment performance across redemption events."
  source: "`vibe_retail_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (reward, discount, voucher, partner, etc.) for redemption mix analysis."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (completed, pending, cancelled, reversed) for operational monitoring."
    - name: "channel"
      expr: channel
      comment: "Channel where the redemption occurred (in-store, online, mobile) for omnichannel redemption analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "How the reward was fulfilled (instant, shipped, digital, etc.) for fulfillment cost and experience analysis."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flags redemptions identified as fraudulent for fraud rate monitoring and financial impact assessment."
    - name: "redemption_month"
      expr: DATE_TRUNC('month', redemption_timestamp)
      comment: "Month of redemption for trend and seasonality analysis."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member tier at time of redemption. Enables tier-level redemption behavior and value analysis."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of redemption events. Baseline volume metric for program engagement and operational load."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points consumed across all redemptions. Measures burn-side program activity and liability reduction."
    - name: "total_monetary_value_redeemed"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of rewards delivered through redemptions. Represents the cost of the redemption program."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points consumed per redemption event. Benchmarks redemption size and member engagement depth."
    - name: "avg_monetary_value_per_redemption"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per redemption. Tracks reward generosity and cost per redemption event."
    - name: "fraudulent_redemption_count"
      expr: COUNT(DISTINCT CASE WHEN is_fraudulent = TRUE THEN redemption_id END)
      comment: "Number of redemptions flagged as fraudulent. Monitors program integrity and fraud loss exposure."
    - name: "avg_fraud_detection_score"
      expr: AVG(CAST(fraud_detection_score AS DOUBLE))
      comment: "Average fraud detection score across redemptions. Tracks overall fraud risk level in the redemption population."
    - name: "cancelled_redemption_count"
      expr: COUNT(DISTINCT CASE WHEN redemption_status = 'cancelled' THEN redemption_id END)
      comment: "Number of cancelled redemptions. High cancellation rates signal member experience or fulfillment issues."
    - name: "unique_redeeming_members"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Number of distinct members who redeemed. Measures redemption participation breadth across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_engagement_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty engagement campaign performance KPIs measuring enrollment, participation, incremental spend, and tier upgrade outcomes."
  source: "`vibe_retail_v1`.`loyalty`.`engagement_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of engagement campaign (bonus points, tier accelerator, spend challenge, etc.) for campaign mix analysis."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (draft, active, completed, cancelled) for operational filtering."
    - name: "opt_in_required_flag"
      expr: opt_in_required_flag
      comment: "Whether the campaign requires explicit member opt-in. Enables opt-in vs. automatic campaign performance comparison."
    - name: "personalization_enabled_flag"
      expr: personalization_enabled_flag
      comment: "Whether personalization was applied to the campaign. Measures lift from personalized vs. broadcast campaigns."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the campaign launched for trend and seasonality analysis."
    - name: "channel_email_flag"
      expr: channel_email_flag
      comment: "Whether the campaign used the email channel. Enables channel mix and multi-channel performance analysis."
    - name: "channel_in_store_flag"
      expr: channel_in_store_flag
      comment: "Whether the campaign used the in-store channel. Enables in-store vs. digital campaign performance comparison."
  measures:
    - name: "total_actual_incremental_spend"
      expr: SUM(CAST(actual_incremental_spend_amount AS DOUBLE))
      comment: "Total incremental spend generated by engagement campaigns. Primary ROI metric for the loyalty campaign portfolio."
    - name: "total_target_incremental_spend"
      expr: SUM(CAST(target_incremental_spend_amount AS DOUBLE))
      comment: "Total targeted incremental spend across campaigns. Used as the denominator for campaign attainment rate."
    - name: "incremental_spend_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_incremental_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_incremental_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of targeted incremental spend actually achieved. Measures campaign effectiveness vs. plan."
    - name: "avg_actual_participation_rate_pct"
      expr: AVG(CAST(actual_participation_rate_pct AS DOUBLE))
      comment: "Average actual participation rate across campaigns. Benchmarks member engagement responsiveness to loyalty campaigns."
    - name: "avg_target_participation_rate_pct"
      expr: AVG(CAST(target_participation_rate_pct AS DOUBLE))
      comment: "Average targeted participation rate across campaigns. Baseline for participation attainment benchmarking."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier offered across campaigns. Tracks promotional generosity and cost of engagement incentives."
    - name: "avg_qualifying_spend_threshold"
      expr: AVG(CAST(qualifying_spend_threshold AS DOUBLE))
      comment: "Average minimum spend required to qualify for campaign rewards. Informs threshold calibration for future campaigns."
    - name: "active_campaign_count"
      expr: COUNT(DISTINCT CASE WHEN campaign_status = 'active' THEN engagement_campaign_id END)
      comment: "Number of currently active engagement campaigns. Tracks program activity level and resource commitment."
    - name: "total_campaign_count"
      expr: COUNT(DISTINCT engagement_campaign_id)
      comment: "Total number of engagement campaigns. Baseline for campaign portfolio size and throughput analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_partner_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner loyalty transaction KPIs measuring points flow, settlement economics, and reconciliation health across coalition and co-branded partner programs."
  source: "`vibe_retail_v1`.`loyalty`.`partner_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of partner transaction (earn, redeem, adjust, reverse) for earn vs. burn partner analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the partner transaction (posted, pending, disputed, reversed) for reconciliation monitoring."
    - name: "transaction_channel"
      expr: transaction_channel
      comment: "Channel through which the partner transaction occurred for omnichannel partner analysis."
    - name: "partner_category"
      expr: partner_category
      comment: "Category of the partner (travel, dining, retail, financial, etc.) for partner portfolio mix analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the partner transaction. Unreconciled transactions represent financial exposure."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flags disputed partner transactions for financial risk and partner relationship monitoring."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the partner transaction for trend and settlement cycle analysis."
  measures:
    - name: "total_points_awarded_by_partner"
      expr: SUM(CAST(points_awarded AS DOUBLE))
      comment: "Total points awarded through partner transactions. Measures partner-driven earn volume and coalition program scale."
    - name: "total_points_redeemed_at_partner"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed through partner channels. Measures partner redemption utilization and member engagement with partners."
    - name: "total_bonus_points"
      expr: SUM(CAST(bonus_points AS DOUBLE))
      comment: "Total bonus points awarded through partner promotions. Tracks incremental partner promotional cost."
    - name: "total_partner_commission"
      expr: SUM(CAST(partner_commission_amount AS DOUBLE))
      comment: "Total commission paid to or earned from partners. Key financial metric for partner program P&L."
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total transaction value processed through partner channels. Measures partner-driven revenue contribution."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier applied in partner transactions. Tracks partner promotional generosity and cost."
    - name: "disputed_transaction_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN partner_transaction_id END)
      comment: "Number of disputed partner transactions. Monitors partner data quality and financial reconciliation risk."
    - name: "total_partner_transactions"
      expr: COUNT(1)
      comment: "Total number of partner transactions. Baseline volume metric for partner program activity and settlement load."
    - name: "unique_members_transacting_with_partners"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Number of distinct members transacting through partner channels. Measures partner program member penetration."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral program KPIs measuring acquisition effectiveness, conversion rates, fraud exposure, and reward economics for the loyalty referral channel."
  source: "`vibe_retail_v1`.`loyalty`.`referral`"
  dimensions:
    - name: "conversion_status"
      expr: conversion_status
      comment: "Whether the referred prospect converted to a member (converted, pending, expired, etc.) for funnel analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the referral was made (email, social, in-store, app) for referral channel mix analysis."
    - name: "source"
      expr: source
      comment: "Source of the referral (organic, campaign-driven, etc.) for attribution and channel investment decisions."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flags fraudulent referrals for program integrity monitoring and financial loss assessment."
    - name: "qualification_met_flag"
      expr: qualification_met_flag
      comment: "Whether the referral met qualification criteria for reward payout. Tracks reward eligibility rate."
    - name: "referral_month"
      expr: DATE_TRUNC('month', referral_date)
      comment: "Month the referral was made for trend and campaign timing analysis."
    - name: "referee_reward_type"
      expr: referee_reward_type
      comment: "Type of reward offered to the referred new member. Enables reward type effectiveness comparison."
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total number of referrals generated. Baseline volume metric for referral program scale and reach."
    - name: "converted_referral_count"
      expr: COUNT(DISTINCT CASE WHEN conversion_status = 'converted' THEN referral_id END)
      comment: "Number of referrals that resulted in a new member conversion. Primary effectiveness metric for the referral program."
    - name: "referral_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN conversion_status = 'converted' THEN referral_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that converted to new members. Key ROI metric for referral program investment decisions."
    - name: "total_first_purchase_amount"
      expr: SUM(CAST(first_purchase_amount AS DOUBLE))
      comment: "Total first-purchase revenue from referred new members. Measures immediate revenue impact of the referral program."
    - name: "avg_first_purchase_amount"
      expr: AVG(CAST(first_purchase_amount AS DOUBLE))
      comment: "Average first purchase value of referred members. Benchmarks referred member quality vs. organic acquisition."
    - name: "total_referrer_reward_value"
      expr: SUM(CAST(referrer_reward_value AS DOUBLE))
      comment: "Total reward value paid to referring members. Measures referral program cost on the referrer side."
    - name: "total_referee_reward_value"
      expr: SUM(CAST(referee_reward_value AS DOUBLE))
      comment: "Total reward value paid to referred new members. Measures referral program cost on the acquisition side."
    - name: "fraud_flagged_referral_count"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN referral_id END)
      comment: "Number of referrals flagged as fraudulent. Monitors referral fraud exposure and program integrity."
    - name: "avg_viral_coefficient_contribution"
      expr: AVG(CAST(viral_coefficient_contribution AS DOUBLE))
      comment: "Average viral coefficient contribution per referral. Measures organic growth multiplier effect of the referral program."
    - name: "avg_fraud_detection_score"
      expr: AVG(CAST(fraud_detection_score AS DOUBLE))
      comment: "Average fraud detection score across referrals. Tracks overall fraud risk level in the referral population."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty member segment KPIs measuring segment size, value, and engagement characteristics to inform targeted program investment and personalization strategy."
  source: "`vibe_retail_v1`.`loyalty`.`member_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of member segment (behavioral, demographic, value-based, lifecycle, etc.) for segment portfolio analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, archived, draft) for operational filtering."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Member lifecycle stage the segment targets (new, growing, at-risk, lapsed, etc.) for lifecycle management."
    - name: "assignment_method"
      expr: assignment_method
      comment: "How members are assigned to the segment (rule-based, ML model, manual) for methodology comparison."
    - name: "campaign_eligibility_flag"
      expr: campaign_eligibility_flag
      comment: "Whether the segment is eligible for campaign targeting. Filters actionable segments for campaign planning."
    - name: "offer_eligibility_flag"
      expr: offer_eligibility_flag
      comment: "Whether the segment is eligible for personalized offers. Tracks offer-eligible population size."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether segment membership is exclusive (members can only belong to one exclusive segment). Informs segmentation strategy."
  measures:
    - name: "total_segment_member_count"
      expr: SUM(CAST(member_count AS DOUBLE))
      comment: "Total members across all segments. Measures overall segmentation coverage of the loyalty member base."
    - name: "avg_segment_member_count"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average members per segment. Benchmarks segment granularity and targeting precision."
    - name: "avg_member_ltv"
      expr: AVG(CAST(average_ltv AS DOUBLE))
      comment: "Average lifetime value across segments. Identifies highest-value segments for prioritized investment."
    - name: "avg_annual_spend"
      expr: AVG(CAST(average_annual_spend AS DOUBLE))
      comment: "Average annual spend per member across segments. Benchmarks segment spending power for offer calibration."
    - name: "avg_points_balance"
      expr: AVG(CAST(average_points_balance AS DOUBLE))
      comment: "Average points balance across segments. Identifies segments with high unredeemed points for targeted redemption campaigns."
    - name: "total_target_member_count"
      expr: SUM(CAST(target_member_count AS DOUBLE))
      comment: "Total targeted member count across segments. Measures planned segmentation coverage vs. actual."
    - name: "segment_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(member_count AS DOUBLE)) / NULLIF(SUM(CAST(target_member_count AS DOUBLE)), 0), 2)
      comment: "Percentage of target member count achieved across segments. Measures segmentation model accuracy and data completeness."
    - name: "active_segment_count"
      expr: COUNT(DISTINCT CASE WHEN segment_status = 'active' THEN member_segment_id END)
      comment: "Number of active member segments. Tracks segmentation portfolio breadth for personalization capability assessment."
    - name: "avg_minimum_confidence_score"
      expr: AVG(CAST(minimum_confidence_score AS DOUBLE))
      comment: "Average minimum confidence score threshold across ML-driven segments. Monitors model quality standards for segment assignments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_clienteling_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clienteling interaction KPIs measuring associate-driven customer engagement effectiveness, conversion, and follow-up discipline."
  source: "`vibe_retail_v1`.`loyalty`.`clienteling_interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of clienteling interaction (consultation, follow-up, outreach, appointment, etc.) for interaction mix analysis."
    - name: "interaction_channel"
      expr: interaction_channel
      comment: "Channel of the interaction (in-store, phone, email, app, etc.) for channel effectiveness comparison."
    - name: "interaction_outcome"
      expr: interaction_outcome
      comment: "Outcome of the interaction (purchase made, follow-up scheduled, no action, etc.) for conversion analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (completed, pending follow-up, cancelled) for operational monitoring."
    - name: "purchase_made_flag"
      expr: purchase_made_flag
      comment: "Whether a purchase was made during or following the interaction. Primary conversion indicator."
    - name: "follow_up_action_required"
      expr: follow_up_action_required
      comment: "Whether a follow-up action was required. Tracks associate workload and engagement pipeline."
    - name: "interaction_month"
      expr: DATE_TRUNC('month', interaction_date)
      comment: "Month of the interaction for trend and seasonality analysis."
    - name: "vip_tier_at_interaction"
      expr: vip_tier_at_interaction
      comment: "Member VIP tier at time of interaction. Enables tier-level clienteling investment and outcome analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of clienteling interactions. Baseline volume metric for associate engagement activity."
    - name: "purchase_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN purchase_made_flag = TRUE THEN clienteling_interaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clienteling interactions that resulted in a purchase. Primary ROI metric for the clienteling program."
    - name: "total_interaction_value"
      expr: SUM(CAST(total_interaction_value_amount AS DOUBLE))
      comment: "Total monetary value generated through clienteling interactions. Measures revenue impact of the clienteling program."
    - name: "avg_interaction_value"
      expr: AVG(CAST(total_interaction_value_amount AS DOUBLE))
      comment: "Average value per clienteling interaction. Benchmarks associate productivity and interaction quality."
    - name: "follow_up_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_completed_flag = TRUE THEN clienteling_interaction_id END) / NULLIF(COUNT(DISTINCT CASE WHEN follow_up_action_required = TRUE THEN clienteling_interaction_id END), 0), 2)
      comment: "Percentage of required follow-up actions that were completed. Measures associate discipline and customer experience quality."
    - name: "unique_members_engaged"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Number of distinct loyalty members engaged through clienteling. Measures program reach across the member base."
    - name: "unique_associates_active"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of distinct associates conducting clienteling interactions. Tracks program adoption and associate participation."
    - name: "appointment_scheduled_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN appointment_scheduled_flag = TRUE THEN clienteling_interaction_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions that resulted in a scheduled appointment. Measures pipeline building effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_partner_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner program portfolio KPIs measuring earn/redeem economics, settlement efficiency, and partner relationship health."
  source: "`vibe_retail_v1`.`loyalty`.`partner_program`"
  dimensions:
    - name: "partner_type"
      expr: partner_type
      comment: "Type of partner (airline, hotel, financial, retail, dining, etc.) for partner portfolio mix analysis."
    - name: "partner_status"
      expr: partner_status
      comment: "Current status of the partner program (active, suspended, terminated, pending) for portfolio health monitoring."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "How often settlements occur with the partner (weekly, monthly, quarterly) for cash flow planning."
    - name: "integration_method"
      expr: integration_method
      comment: "Technical integration method with the partner (API, file, real-time, batch) for operational risk assessment."
    - name: "auto_enrollment_flag"
      expr: auto_enrollment_flag
      comment: "Whether members are automatically enrolled in the partner program. Impacts partner program penetration rates."
    - name: "promotional_bonus_eligible_flag"
      expr: promotional_bonus_eligible_flag
      comment: "Whether the partner program is eligible for promotional bonus points. Tracks promotional partnership scope."
  measures:
    - name: "active_partner_count"
      expr: COUNT(DISTINCT CASE WHEN partner_status = 'active' THEN partner_program_id END)
      comment: "Number of active partner programs. Measures coalition program breadth and member value proposition."
    - name: "avg_earn_rate_multiplier"
      expr: AVG(CAST(earn_rate_multiplier AS DOUBLE))
      comment: "Average earn rate multiplier across partner programs. Benchmarks partner earn generosity and program competitiveness."
    - name: "avg_redeem_rate_multiplier"
      expr: AVG(CAST(redeem_rate_multiplier AS DOUBLE))
      comment: "Average redeem rate multiplier across partner programs. Benchmarks redemption value delivered through partners."
    - name: "avg_cost_per_point_earned"
      expr: AVG(CAST(cost_per_point_earned AS DOUBLE))
      comment: "Average cost per point earned through partner programs. Key unit economics metric for partner program P&L."
    - name: "avg_revenue_per_point_redeemed"
      expr: AVG(CAST(revenue_per_point_redeemed AS DOUBLE))
      comment: "Average revenue generated per point redeemed through partners. Measures partner redemption monetization efficiency."
    - name: "avg_maximum_earn_per_transaction"
      expr: AVG(CAST(maximum_earn_per_transaction AS DOUBLE))
      comment: "Average maximum earn cap per transaction across partners. Informs liability management and partner cap calibration."
    - name: "total_partner_programs"
      expr: COUNT(DISTINCT partner_program_id)
      comment: "Total number of partner programs in the portfolio. Baseline for partner ecosystem scale assessment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual rule portfolio KPIs measuring earn rate economics, rule complexity, and promotional generosity across the loyalty earn rule library."
  source: "`vibe_retail_v1`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of accrual rule (base earn, bonus, category, brand, tier-specific, etc.) for rule portfolio analysis."
    - name: "accrual_rule_status"
      expr: accrual_rule_status
      comment: "Current status of the accrual rule (active, inactive, pending, expired) for active rule portfolio monitoring."
    - name: "applicable_channel"
      expr: applicable_channel
      comment: "Channel to which the rule applies (in-store, online, mobile, all) for channel-specific earn analysis."
    - name: "earning_basis"
      expr: earning_basis
      comment: "Basis on which points are earned (spend, transaction, unit, visit) for earn mechanics analysis."
    - name: "stacking_allowed_flag"
      expr: stacking_allowed_flag
      comment: "Whether this rule can stack with other rules. Tracks promotional liability risk from rule stacking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rule (approved, pending, rejected) for governance and compliance monitoring."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rule became effective for rule lifecycle and seasonality analysis."
  measures:
    - name: "active_rule_count"
      expr: COUNT(DISTINCT CASE WHEN accrual_rule_status = 'active' THEN accrual_rule_id END)
      comment: "Number of currently active accrual rules. Measures earn rule portfolio complexity and maintenance burden."
    - name: "avg_points_per_unit"
      expr: AVG(CAST(points_per_unit AS DOUBLE))
      comment: "Average points awarded per unit across all rules. Benchmarks overall program earn generosity."
    - name: "avg_bonus_multiplier"
      expr: AVG(CAST(bonus_multiplier AS DOUBLE))
      comment: "Average bonus multiplier across promotional rules. Tracks promotional earn cost and generosity trends."
    - name: "avg_minimum_spend_threshold"
      expr: AVG(CAST(minimum_spend_threshold AS DOUBLE))
      comment: "Average minimum spend required to trigger earn rules. Informs threshold calibration for basket size lift."
    - name: "stacking_eligible_rule_count"
      expr: COUNT(DISTINCT CASE WHEN stacking_allowed_flag = TRUE THEN accrual_rule_id END)
      comment: "Number of rules that allow stacking with other rules. Monitors combinatorial liability risk in the rule portfolio."
    - name: "total_rule_count"
      expr: COUNT(DISTINCT accrual_rule_id)
      comment: "Total number of accrual rules in the library. Baseline for rule portfolio complexity and governance overhead."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_member_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member offer performance metrics tracking personalization effectiveness and redemption rates"
  source: "`vibe_retail_v1`.`loyalty`.`member_offer`"
  dimensions:
    - name: "offer_status"
      expr: offer_status
      comment: "Status of the member offer (Active, Redeemed, Expired, Cancelled, etc.)"
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (Discount, Bonus Points, Free Product, etc.)"
    - name: "offer_source"
      expr: offer_source
      comment: "Source of the offer (Campaign, Triggered, Personalized, etc.)"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (Percentage, Fixed Amount, BOGO, etc.)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "Event that triggered the offer (Birthday, Anniversary, Spend Threshold, etc.)"
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channels where offer can be used (In-Store, Online, Mobile, Omnichannel, etc.)"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when offer became valid"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year when offer became valid"
  measures:
    - name: "total_offers"
      expr: COUNT(member_offer_id)
      comment: "Total number of member offers issued"
    - name: "total_redemptions"
      expr: SUM(CAST(REGEXP_REPLACE(redemption_count, '[^0-9]', '') AS BIGINT))
      comment: "Total number of offer redemptions"
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(REGEXP_REPLACE(redemption_count, '[^0-9]', '') AS BIGINT)) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of offers that were redeemed (engagement effectiveness)"
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value offered across all offers"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer"
    - name: "total_estimated_liability"
      expr: SUM(CAST(estimated_liability_amount AS DOUBLE))
      comment: "Total estimated financial liability from outstanding offers"
    - name: "avg_personalization_score"
      expr: AVG(CAST(personalization_score AS DOUBLE))
      comment: "Average personalization score across offers (targeting quality)"
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier offered"
    - name: "avg_minimum_spend"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold required for offer"
    - name: "redeemed_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'Redeemed' THEN member_offer_id END)
      comment: "Count of offers that have been redeemed"
    - name: "expired_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'Expired' THEN member_offer_id END)
      comment: "Count of offers that expired without redemption (waste indicator)"
    - name: "expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_status = 'Expired' THEN member_offer_id END) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of offers that expired without redemption"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier structure and performance metrics tracking tier economics and member progression"
  source: "`vibe_retail_v1`.`loyalty`.`tier`"
  dimensions:
    - name: "tier_status"
      expr: tier_status
      comment: "Status of the tier (Active, Inactive, Deprecated, etc.)"
    - name: "tier_name"
      expr: tier_name
      comment: "Name of the loyalty tier (Bronze, Silver, Gold, Platinum, etc.)"
    - name: "tier_code"
      expr: tier_code
      comment: "Code identifier for the tier"
    - name: "qualification_threshold_type"
      expr: qualification_threshold_type
      comment: "Type of threshold for tier qualification (Spend, Points, Transactions, etc.)"
    - name: "invitation_only_flag"
      expr: invitation_only_flag
      comment: "Whether tier is invitation-only"
    - name: "lifetime_tier_flag"
      expr: lifetime_tier_flag
      comment: "Whether tier is lifetime (no downgrade)"
  measures:
    - name: "total_tiers"
      expr: COUNT(tier_id)
      comment: "Total number of loyalty tiers defined"
    - name: "active_tier_count"
      expr: COUNT(CASE WHEN tier_status = 'Active' THEN tier_id END)
      comment: "Count of currently active tiers"
    - name: "avg_qualification_threshold"
      expr: AVG(CAST(qualification_threshold_value AS DOUBLE))
      comment: "Average qualification threshold value across tiers"
    - name: "avg_maintenance_threshold"
      expr: AVG(CAST(maintenance_threshold_value AS DOUBLE))
      comment: "Average maintenance threshold value to retain tier"
    - name: "avg_points_earning_multiplier"
      expr: AVG(CAST(points_earning_multiplier AS DOUBLE))
      comment: "Average points earning multiplier across tiers (benefit value)"
    - name: "avg_redemption_discount_pct"
      expr: AVG(CAST(points_redemption_discount_pct AS DOUBLE))
      comment: "Average redemption discount percentage across tiers (benefit value)"
    - name: "invitation_only_tier_count"
      expr: COUNT(CASE WHEN invitation_only_flag = TRUE THEN tier_id END)
      comment: "Count of invitation-only tiers (exclusivity indicator)"
    - name: "lifetime_tier_count"
      expr: COUNT(CASE WHEN lifetime_tier_flag = TRUE THEN tier_id END)
      comment: "Count of lifetime tiers (retention strategy indicator)"
$$;