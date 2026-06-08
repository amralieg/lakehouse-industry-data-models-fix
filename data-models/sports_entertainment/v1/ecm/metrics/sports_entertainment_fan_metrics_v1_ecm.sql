-- Metric views for domain: fan | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fan account metrics tracking account growth, loyalty program performance, and payment method health"
  source: "`sports_entertainment_ecm`.`fan`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the fan account (active, suspended, closed)"
    - name: "account_tier"
      expr: account_tier
      comment: "Tier level of the account (basic, premium, VIP)"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (individual, family, corporate)"
    - name: "registration_channel"
      expr: registration_channel
      comment: "Channel through which the account was registered (web, mobile, venue, partner)"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year the account was registered"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month the account was registered"
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether the account has VIP status"
    - name: "season_ticket_holder_flag"
      expr: season_ticket_holder_flag
      comment: "Whether the account holder is a season ticket holder"
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether GDPR consent has been given"
    - name: "marketing_email_opt_in_flag"
      expr: marketing_email_opt_in_flag
      comment: "Whether the account has opted in to marketing emails"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique fan accounts"
    - name: "total_loyalty_points_balance"
      expr: SUM(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Total loyalty points balance across all accounts"
    - name: "avg_loyalty_points_balance"
      expr: AVG(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Average loyalty points balance per account"
    - name: "total_loyalty_points_ytd_earned"
      expr: SUM(CAST(loyalty_points_ytd_earned AS DOUBLE))
      comment: "Total loyalty points earned year-to-date across all accounts"
    - name: "vip_account_count"
      expr: COUNT(DISTINCT CASE WHEN vip_flag = TRUE THEN account_id END)
      comment: "Number of accounts with VIP status"
    - name: "season_ticket_holder_count"
      expr: COUNT(DISTINCT CASE WHEN season_ticket_holder_flag = TRUE THEN account_id END)
      comment: "Number of accounts that are season ticket holders"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_email_opt_in_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts opted in to marketing emails"
    - name: "gdpr_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gdpr_consent_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts with GDPR consent"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fan engagement metrics tracking interaction quality, channel effectiveness, and loyalty program impact"
  source: "`sports_entertainment_ecm`.`fan`.`engagement_event`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement event (view, click, purchase, share, comment)"
    - name: "engagement_channel"
      expr: engagement_channel
      comment: "Channel through which engagement occurred (web, mobile, social, venue)"
    - name: "engagement_date"
      expr: engagement_date
      comment: "Date of the engagement event"
    - name: "engagement_month"
      expr: DATE_TRUNC('MONTH', engagement_date)
      comment: "Month of the engagement event"
    - name: "device_type"
      expr: device_type
      comment: "Type of device used for engagement (mobile, tablet, desktop)"
    - name: "is_authenticated"
      expr: is_authenticated
      comment: "Whether the user was authenticated during engagement"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code of the engagement location"
    - name: "social_platform"
      expr: social_platform
      comment: "Social media platform if engagement was social"
  measures:
    - name: "total_engagement_events"
      expr: COUNT(engagement_event_id)
      comment: "Total number of engagement events"
    - name: "unique_engaged_fans"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique fans who engaged"
    - name: "avg_engagement_value_score"
      expr: AVG(CAST(engagement_value_score AS DOUBLE))
      comment: "Average engagement value score per event"
    - name: "total_engagement_value"
      expr: SUM(CAST(engagement_value_score AS DOUBLE))
      comment: "Total engagement value score across all events"
    - name: "avg_content_progress_pct"
      expr: AVG(CAST(content_progress_pct AS DOUBLE))
      comment: "Average content completion percentage across engagement events"
    - name: "total_loyalty_points_earned"
      expr: SUM(CAST(loyalty_points_earned AS DOUBLE))
      comment: "Total loyalty points earned through engagement events"
    - name: "total_loyalty_points_redeemed"
      expr: SUM(CAST(loyalty_points_redeemed AS DOUBLE))
      comment: "Total loyalty points redeemed through engagement events"
    - name: "authenticated_engagement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_authenticated = TRUE THEN 1 END) / NULLIF(COUNT(engagement_event_id), 0), 2)
      comment: "Percentage of engagement events from authenticated users"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program transaction metrics tracking points flow, redemption patterns, and program health"
  source: "`sports_entertainment_ecm`.`fan`.`loyalty_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (earn, redeem, transfer, adjustment, expiry)"
    - name: "activity_type"
      expr: activity_type
      comment: "Specific activity that triggered the transaction"
    - name: "activity_channel"
      expr: activity_channel
      comment: "Channel through which the activity occurred"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (pending, completed, reversed, failed)"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the transaction"
    - name: "processing_date"
      expr: processing_date
      comment: "Date the transaction was processed"
    - name: "is_bonus_transaction"
      expr: is_bonus_transaction
      comment: "Whether this was a bonus points transaction"
    - name: "is_tier_qualifying"
      expr: is_tier_qualifying
      comment: "Whether this transaction counts toward tier qualification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for monetary value"
  measures:
    - name: "total_transactions"
      expr: COUNT(loyalty_transaction_id)
      comment: "Total number of loyalty transactions"
    - name: "unique_transacting_fans"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique fans with loyalty transactions"
    - name: "total_points_amount"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points amount across all transactions (positive for earn, negative for redeem)"
    - name: "total_base_points"
      expr: SUM(CAST(base_points_amount AS DOUBLE))
      comment: "Total base points before multipliers"
    - name: "total_tier_qualifying_points"
      expr: SUM(CAST(tier_qualifying_points AS DOUBLE))
      comment: "Total points that count toward tier qualification"
    - name: "avg_points_per_transaction"
      expr: AVG(CAST(points_amount AS DOUBLE))
      comment: "Average points per transaction"
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier applied"
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value associated with transactions"
    - name: "total_redemption_value"
      expr: SUM(CAST(redemption_value AS DOUBLE))
      comment: "Total value of points redeemed"
    - name: "bonus_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_bonus_transaction = TRUE THEN 1 END) / NULLIF(COUNT(loyalty_transaction_id), 0), 2)
      comment: "Percentage of transactions that are bonus transactions"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Membership metrics tracking subscription revenue, retention, and member value"
  source: "`sports_entertainment_ecm`.`fan`.`membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the membership (active, expired, cancelled, suspended)"
    - name: "membership_type"
      expr: membership_type
      comment: "Type of membership (season ticket, club, premium, basic)"
    - name: "membership_tier"
      expr: membership_tier
      comment: "Tier level of the membership"
    - name: "channel"
      expr: channel
      comment: "Channel through which membership was acquired"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the membership started"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of membership payments (monthly, annual, one-time)"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether auto-renewal is enabled"
    - name: "is_vip"
      expr: is_vip
      comment: "Whether this is a VIP membership"
    - name: "is_corporate"
      expr: is_corporate
      comment: "Whether this is a corporate membership"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for fees"
  measures:
    - name: "total_memberships"
      expr: COUNT(membership_id)
      comment: "Total number of memberships"
    - name: "unique_members"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique fans with memberships"
    - name: "total_membership_fee_revenue"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total membership fee revenue"
    - name: "total_net_fee_revenue"
      expr: SUM(CAST(net_fee AS DOUBLE))
      comment: "Total net membership fee revenue after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to memberships"
    - name: "avg_membership_fee"
      expr: AVG(CAST(fee AS DOUBLE))
      comment: "Average membership fee"
    - name: "avg_discount_pct"
      expr: AVG(CAST(merchandise_discount_pct AS DOUBLE))
      comment: "Average merchandise discount percentage for members"
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END) / NULLIF(COUNT(membership_id), 0), 2)
      comment: "Percentage of memberships with auto-renewal enabled"
    - name: "vip_membership_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_vip = TRUE THEN 1 END) / NULLIF(COUNT(membership_id), 0), 2)
      comment: "Percentage of memberships that are VIP"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service metrics tracking case resolution efficiency, fan satisfaction, and service quality"
  source: "`sports_entertainment_ecm`.`fan`.`service_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service case (open, in progress, resolved, closed)"
    - name: "case_type"
      expr: case_type
      comment: "Type of service case (complaint, inquiry, refund, technical)"
    - name: "case_category"
      expr: case_category
      comment: "Category of the service case"
    - name: "case_sub_category"
      expr: case_sub_category
      comment: "Sub-category of the service case"
    - name: "origin_channel"
      expr: origin_channel
      comment: "Channel through which the case was created (phone, email, chat, social, venue)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the case (low, medium, high, critical)"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the case was opened"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the case was escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the case breached SLA targets"
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether the case is for a VIP fan"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided"
  measures:
    - name: "total_service_cases"
      expr: COUNT(service_case_id)
      comment: "Total number of service cases"
    - name: "unique_fans_with_cases"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique fans with service cases"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued through service cases"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per case"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours for cases"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(service_case_id), 0), 2)
      comment: "Percentage of cases that were escalated"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(service_case_id), 0), 2)
      comment: "Percentage of cases that breached SLA"
    - name: "vip_case_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_flag = TRUE THEN 1 END) / NULLIF(COUNT(service_case_id), 0), 2)
      comment: "Percentage of cases from VIP fans"
    - name: "avg_case_reopen_count"
      expr: AVG(CAST(case_reopen_count AS DOUBLE))
      comment: "Average number of times cases are reopened"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score metrics tracking fan satisfaction, sentiment trends, and feedback quality"
  source: "`sports_entertainment_ecm`.`fan`.`nps_response`"
  dimensions:
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (promoter, passive, detractor)"
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which the NPS response was submitted"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Month of the NPS response"
    - name: "survey_trigger_type"
      expr: survey_trigger_type
      comment: "Type of trigger that initiated the survey (post-event, post-purchase, periodic)"
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment label derived from verbatim comments (positive, neutral, negative)"
    - name: "primary_feedback_theme"
      expr: primary_feedback_theme
      comment: "Primary theme identified in feedback"
    - name: "membership_tier_at_response"
      expr: membership_tier_at_response
      comment: "Membership tier of the fan at time of response"
    - name: "is_first_response"
      expr: is_first_response
      comment: "Whether this is the fan's first NPS response"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up action is required"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for response"
  measures:
    - name: "total_nps_responses"
      expr: COUNT(nps_response_id)
      comment: "Total number of NPS responses"
    - name: "unique_responding_fans"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique fans who responded to NPS surveys"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score across all responses"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from text analysis"
    - name: "promoter_count"
      expr: COUNT(CASE WHEN nps_category = 'promoter' THEN 1 END)
      comment: "Number of promoter responses (score 9-10)"
    - name: "detractor_count"
      expr: COUNT(CASE WHEN nps_category = 'detractor' THEN 1 END)
      comment: "Number of detractor responses (score 0-6)"
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END) / NULLIF(COUNT(nps_response_id), 0), 2)
      comment: "Percentage of responses requiring follow-up"
    - name: "avg_survey_completion_time_seconds"
      expr: AVG(CAST(survey_completion_time_seconds AS DOUBLE))
      comment: "Average time to complete survey in seconds"
    - name: "avg_response_latency_minutes"
      expr: AVG(CAST(response_latency_minutes AS DOUBLE))
      comment: "Average time between survey invitation and response in minutes"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing campaign performance metrics tracking ROI, conversion efficiency, and channel effectiveness"
  source: "`sports_entertainment_ecm`.`fan`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (draft, active, paused, completed, cancelled)"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (acquisition, retention, engagement, reactivation)"
    - name: "channel"
      expr: channel
      comment: "Marketing channel (email, social, display, search, SMS)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the campaign"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment for the campaign"
    - name: "priority"
      expr: priority
      comment: "Priority level of the campaign"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the campaign is automated"
  measures:
    - name: "total_campaigns"
      expr: COUNT(campaign_id)
      comment: "Total number of campaigns"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated across all campaigns"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend across all campaigns"
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS BIGINT))
      comment: "Total actual impressions delivered"
    - name: "total_actual_conversions"
      expr: SUM(CAST(actual_conversions AS BIGINT))
      comment: "Total actual conversions achieved"
    - name: "total_target_impressions"
      expr: SUM(CAST(target_impressions AS BIGINT))
      comment: "Total target impressions planned"
    - name: "total_target_conversions"
      expr: SUM(CAST(target_conversions AS BIGINT))
      comment: "Total target conversions planned"
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per campaign"
    - name: "avg_actual_spend_per_campaign"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average actual spend per campaign"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fan communication metrics tracking delivery success, engagement rates, and opt-out trends"
  source: "`sports_entertainment_ecm`.`fan`.`communication`"
  dimensions:
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (promotional, transactional, service, newsletter)"
    - name: "channel"
      expr: channel
      comment: "Communication channel (email, SMS, push, in-app)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status (delivered, bounced, failed, pending)"
    - name: "send_month"
      expr: DATE_TRUNC('MONTH', send_timestamp)
      comment: "Month the communication was sent"
    - name: "trigger_type"
      expr: trigger_type
      comment: "Type of trigger that initiated the communication (event, behavior, scheduled)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used to open the communication"
    - name: "language_code"
      expr: language_code
      comment: "Language of the communication"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier"
    - name: "personalization_flag"
      expr: personalization_flag
      comment: "Whether the communication was personalized"
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Whether the recipient opted out"
  measures:
    - name: "total_communications_sent"
      expr: COUNT(communication_id)
      comment: "Total number of communications sent"
    - name: "unique_recipients"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique fans who received communications"
    - name: "delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'delivered' THEN 1 END) / NULLIF(COUNT(communication_id), 0), 2)
      comment: "Percentage of communications successfully delivered"
    - name: "open_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN open_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN delivery_status = 'delivered' THEN 1 END), 0), 2)
      comment: "Percentage of delivered communications that were opened"
    - name: "click_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN click_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN delivery_status = 'delivered' THEN 1 END), 0), 2)
      comment: "Percentage of delivered communications that were clicked"
    - name: "conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN delivery_status = 'delivered' THEN 1 END), 0), 2)
      comment: "Percentage of delivered communications that resulted in conversion"
    - name: "opt_out_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_out_flag = TRUE THEN 1 END) / NULLIF(COUNT(communication_id), 0), 2)
      comment: "Percentage of communications that resulted in opt-out"
    - name: "personalization_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN personalization_flag = TRUE THEN 1 END) / NULLIF(COUNT(communication_id), 0), 2)
      comment: "Percentage of communications that were personalized"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`fan_segment_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fan segmentation metrics tracking segment membership, activation effectiveness, and audience quality"
  source: "`sports_entertainment_ecm`.`fan`.`segment_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the segment assignment (active, expired, revoked)"
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used for assignment (rule-based, model-based, manual)"
    - name: "activation_status"
      expr: activation_status
      comment: "Status of activation to marketing platforms"
    - name: "segment_category"
      expr: segment_category
      comment: "Category of the segment"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of the segment assignment"
    - name: "is_primary_segment"
      expr: is_primary_segment
      comment: "Whether this is the fan's primary segment"
    - name: "consent_verified"
      expr: consent_verified
      comment: "Whether consent has been verified for this assignment"
    - name: "loyalty_tier_at_assignment"
      expr: loyalty_tier_at_assignment
      comment: "Loyalty tier of the fan at time of assignment"
    - name: "fan_type_at_assignment"
      expr: fan_type_at_assignment
      comment: "Fan type at time of assignment"
  measures:
    - name: "total_segment_assignments"
      expr: COUNT(segment_assignment_id)
      comment: "Total number of segment assignments"
    - name: "unique_fans_in_segments"
      expr: COUNT(DISTINCT fan_profile_id)
      comment: "Number of unique fans assigned to segments"
    - name: "avg_assignment_score"
      expr: AVG(CAST(assignment_score AS DOUBLE))
      comment: "Average assignment score (confidence/propensity)"
    - name: "avg_engagement_score_at_assignment"
      expr: AVG(CAST(engagement_score_at_assignment AS DOUBLE))
      comment: "Average engagement score at time of assignment"
    - name: "avg_score_percentile"
      expr: AVG(CAST(score_percentile AS DOUBLE))
      comment: "Average score percentile within segment"
    - name: "activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN activation_status = 'activated' THEN 1 END) / NULLIF(COUNT(segment_assignment_id), 0), 2)
      comment: "Percentage of assignments successfully activated"
    - name: "consent_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_verified = TRUE THEN 1 END) / NULLIF(COUNT(segment_assignment_id), 0), 2)
      comment: "Percentage of assignments with verified consent"
    - name: "primary_segment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_primary_segment = TRUE THEN 1 END) / NULLIF(COUNT(segment_assignment_id), 0), 2)
      comment: "Percentage of assignments that are primary segments"
$$;