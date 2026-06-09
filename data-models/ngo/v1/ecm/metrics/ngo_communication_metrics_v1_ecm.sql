-- Metric views for domain: communication | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`communication_advocacy_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic advocacy campaign performance metrics tracking fundraising effectiveness, reach, engagement, and budget utilization for mission-driven campaigns"
  source: "`ngo_ecm`.`communication`.`advocacy_campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the advocacy campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type or category of advocacy campaign"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (active, closed, planned)"
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic region or area targeted by the campaign"
    - name: "theme"
      expr: theme
      comment: "Thematic focus or cause area of the campaign"
    - name: "sdg_alignment_tags"
      expr: sdg_alignment_tags
      comment: "Sustainable Development Goals aligned with this campaign"
    - name: "primary_channel_mix"
      expr: primary_channel_mix
      comment: "Primary communication channels used for campaign outreach"
    - name: "is_donor_restricted"
      expr: is_donor_restricted
      comment: "Whether the campaign is subject to donor restrictions"
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Compliance review status for donor and regulatory requirements"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the campaign was launched"
    - name: "launch_quarter"
      expr: CONCAT('Q', QUARTER(launch_date))
      comment: "Quarter the campaign was launched"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of advocacy campaigns"
    - name: "total_actual_fundraising_amount"
      expr: SUM(CAST(actual_fundraising_amount AS DOUBLE))
      comment: "Total actual funds raised across campaigns"
    - name: "total_target_fundraising_amount"
      expr: SUM(CAST(target_fundraising_amount AS DOUBLE))
      comment: "Total target fundraising goal across campaigns"
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual campaign expenditure"
    - name: "total_budget_allocated_amount"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to campaigns"
    - name: "avg_actual_fundraising_amount"
      expr: AVG(CAST(actual_fundraising_amount AS DOUBLE))
      comment: "Average funds raised per campaign"
    - name: "fundraising_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_fundraising_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_fundraising_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising target achieved across campaigns"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated budget actually spent"
    - name: "return_on_campaign_spend"
      expr: ROUND(SUM(CAST(actual_fundraising_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_spend_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of funds raised to campaign spend (fundraising efficiency)"
    - name: "distinct_campaign_owners"
      expr: COUNT(DISTINCT campaign_owner_name)
      comment: "Number of unique campaign owners managing advocacy campaigns"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`communication_campaign_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign engagement and conversion metrics tracking constituent interactions, response rates, and conversion effectiveness across channels"
  source: "`ngo_ecm`.`communication`.`campaign_touchpoint`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the touchpoint"
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of campaign touchpoint interaction"
    - name: "campaign_member_status"
      expr: campaign_member_status
      comment: "Status of the constituent in the campaign"
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the touchpoint resulted in a conversion"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion achieved (donation, signup, etc.)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the touchpoint interaction"
    - name: "country_code"
      expr: country_code
      comment: "Country where the touchpoint occurred"
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Whether the constituent opted out during this touchpoint"
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the campaign touchpoint"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_date)
      comment: "Month when the constituent responded"
  measures:
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total number of campaign touchpoints"
    - name: "total_conversions"
      expr: SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of touchpoints that resulted in conversions"
    - name: "conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints that converted"
    - name: "total_conversion_value_usd"
      expr: SUM(CAST(conversion_value_usd AS DOUBLE))
      comment: "Total monetary value of all conversions in USD"
    - name: "avg_conversion_value_usd"
      expr: AVG(CAST(conversion_value_usd AS DOUBLE))
      comment: "Average conversion value per touchpoint in USD"
    - name: "total_touchpoint_cost_usd"
      expr: SUM(CAST(cost_per_touchpoint_usd AS DOUBLE))
      comment: "Total cost of all campaign touchpoints in USD"
    - name: "avg_cost_per_touchpoint_usd"
      expr: AVG(CAST(cost_per_touchpoint_usd AS DOUBLE))
      comment: "Average cost per touchpoint in USD"
    - name: "cost_per_conversion"
      expr: ROUND(SUM(CAST(cost_per_touchpoint_usd AS DOUBLE)) / NULLIF(SUM(CASE WHEN conversion_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Average cost to achieve one conversion"
    - name: "return_on_touchpoint_investment"
      expr: ROUND(SUM(CAST(conversion_value_usd AS DOUBLE)) / NULLIF(SUM(CAST(cost_per_touchpoint_usd AS DOUBLE)), 0), 2)
      comment: "Ratio of conversion value to touchpoint cost (campaign ROI)"
    - name: "opt_out_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints resulting in opt-outs"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across touchpoints"
    - name: "distinct_constituents"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents engaged through touchpoints"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`communication_email_broadcast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email campaign performance metrics tracking delivery, engagement, and conversion effectiveness for mass email communications"
  source: "`ngo_ecm`.`communication`.`email_broadcast`"
  dimensions:
    - name: "broadcast_name"
      expr: broadcast_name
      comment: "Name of the email broadcast"
    - name: "broadcast_type"
      expr: broadcast_type
      comment: "Type of email broadcast (newsletter, appeal, update)"
    - name: "broadcast_status"
      expr: broadcast_status
      comment: "Current status of the broadcast"
    - name: "language_code"
      expr: language_code
      comment: "Language of the email content"
    - name: "country_code"
      expr: country_code
      comment: "Target country for the broadcast"
    - name: "is_ab_test"
      expr: is_ab_test
      comment: "Whether this broadcast is part of an A/B test"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier"
    - name: "esp_platform"
      expr: esp_platform
      comment: "Email service provider platform used"
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Compliance review status of the broadcast"
    - name: "send_month"
      expr: DATE_TRUNC('MONTH', send_date)
      comment: "Month when the broadcast was sent"
    - name: "send_quarter"
      expr: CONCAT('Q', QUARTER(send_date))
      comment: "Quarter when the broadcast was sent"
  measures:
    - name: "total_broadcasts"
      expr: COUNT(1)
      comment: "Total number of email broadcasts"
    - name: "total_recipients"
      expr: SUM(CAST(total_recipients AS BIGINT))
      comment: "Total number of email recipients across all broadcasts"
    - name: "total_delivered"
      expr: SUM(CAST(delivered_count AS BIGINT))
      comment: "Total number of emails successfully delivered"
    - name: "total_opens"
      expr: SUM(CAST(open_count AS BIGINT))
      comment: "Total number of email opens"
    - name: "total_unique_opens"
      expr: SUM(CAST(unique_open_count AS BIGINT))
      comment: "Total number of unique recipients who opened emails"
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS BIGINT))
      comment: "Total number of email clicks"
    - name: "total_unique_clicks"
      expr: SUM(CAST(unique_click_count AS BIGINT))
      comment: "Total number of unique recipients who clicked"
    - name: "total_bounces"
      expr: SUM(CAST(bounce_count AS BIGINT))
      comment: "Total number of bounced emails"
    - name: "total_hard_bounces"
      expr: SUM(CAST(hard_bounce_count AS BIGINT))
      comment: "Total number of hard bounces (permanent delivery failures)"
    - name: "total_unsubscribes"
      expr: SUM(CAST(unsubscribe_count AS BIGINT))
      comment: "Total number of unsubscribes from broadcasts"
    - name: "total_spam_complaints"
      expr: SUM(CAST(spam_complaint_count AS BIGINT))
      comment: "Total number of spam complaints received"
    - name: "delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(delivered_count AS BIGINT)) / NULLIF(SUM(CAST(total_recipients AS BIGINT)), 0), 2)
      comment: "Percentage of emails successfully delivered"
    - name: "open_rate"
      expr: ROUND(100.0 * SUM(CAST(unique_open_count AS BIGINT)) / NULLIF(SUM(CAST(delivered_count AS BIGINT)), 0), 2)
      comment: "Percentage of delivered emails that were opened (unique)"
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(unique_click_count AS BIGINT)) / NULLIF(SUM(CAST(delivered_count AS BIGINT)), 0), 2)
      comment: "Percentage of delivered emails that were clicked (unique)"
    - name: "click_to_open_rate"
      expr: ROUND(100.0 * SUM(CAST(unique_click_count AS BIGINT)) / NULLIF(SUM(CAST(unique_open_count AS BIGINT)), 0), 2)
      comment: "Percentage of opens that resulted in clicks (engagement quality)"
    - name: "bounce_rate"
      expr: ROUND(100.0 * SUM(CAST(bounce_count AS BIGINT)) / NULLIF(SUM(CAST(total_recipients AS BIGINT)), 0), 2)
      comment: "Percentage of emails that bounced"
    - name: "unsubscribe_rate"
      expr: ROUND(100.0 * SUM(CAST(unsubscribe_count AS BIGINT)) / NULLIF(SUM(CAST(delivered_count AS BIGINT)), 0), 2)
      comment: "Percentage of delivered emails resulting in unsubscribes"
    - name: "spam_complaint_rate"
      expr: ROUND(100.0 * SUM(CAST(spam_complaint_count AS BIGINT)) / NULLIF(SUM(CAST(delivered_count AS BIGINT)), 0), 2)
      comment: "Percentage of delivered emails marked as spam"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`communication_feedback_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feedback and complaint case management metrics tracking resolution effectiveness, response times, and case outcomes for accountability"
  source: "`ngo_ecm`.`communication`.`feedback_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of feedback case (complaint, inquiry, suggestion)"
    - name: "case_category"
      expr: case_category
      comment: "Primary category of the case"
    - name: "case_subcategory"
      expr: case_subcategory
      comment: "Subcategory providing more detail on the case"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the case"
    - name: "escalation_tier"
      expr: escalation_tier
      comment: "Escalation tier if case was escalated"
    - name: "is_sensitive"
      expr: is_sensitive
      comment: "Whether the case involves sensitive information"
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether the case was submitted anonymously"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which feedback was submitted"
    - name: "language_of_submission"
      expr: language_of_submission
      comment: "Language in which the case was submitted"
    - name: "requires_translation"
      expr: requires_translation
      comment: "Whether the case requires translation"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month when the case was received"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of feedback cases"
    - name: "total_closed_cases"
      expr: SUM(CASE WHEN closed_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Total number of cases that have been closed"
    - name: "total_open_cases"
      expr: SUM(CASE WHEN closed_date IS NULL THEN 1 ELSE 0 END)
      comment: "Total number of cases still open"
    - name: "case_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that have been closed"
    - name: "avg_days_to_resolution"
      expr: AVG(DATEDIFF(resolved_date, received_date))
      comment: "Average number of days from case receipt to resolution"
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closed_date, received_date))
      comment: "Average number of days from case receipt to closure"
    - name: "avg_days_to_assignment"
      expr: AVG(DATEDIFF(assigned_date, received_date))
      comment: "Average number of days from case receipt to assignment"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN resolved_date > sla_due_date THEN 1 ELSE 0 END)
      comment: "Number of cases resolved after SLA due date"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolved_date <= sla_due_date OR resolved_date IS NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases meeting SLA targets"
    - name: "sensitive_case_count"
      expr: SUM(CASE WHEN is_sensitive = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases flagged as sensitive"
    - name: "anonymous_case_count"
      expr: SUM(CASE WHEN is_anonymous = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases submitted anonymously"
    - name: "translation_required_count"
      expr: SUM(CASE WHEN requires_translation = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases requiring translation"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`communication_digital_content`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital content performance metrics tracking reach, engagement, and effectiveness of online communications across platforms"
  source: "`ngo_ecm`.`communication`.`digital_content`"
  dimensions:
    - name: "content_type"
      expr: content_type
      comment: "Type of digital content (blog, video, social post, etc.)"
    - name: "content_status"
      expr: content_status
      comment: "Current status of the content"
    - name: "platform"
      expr: platform
      comment: "Digital platform where content is published"
    - name: "language_code"
      expr: language_code
      comment: "Language of the content"
    - name: "target_audience"
      expr: target_audience
      comment: "Intended audience segment for the content"
    - name: "is_brand_compliant"
      expr: is_brand_compliant
      comment: "Whether content meets brand compliance standards"
    - name: "is_accessibility_compliant"
      expr: is_accessibility_compliant
      comment: "Whether content meets accessibility standards"
    - name: "moderation_status"
      expr: moderation_status
      comment: "Content moderation status"
    - name: "publish_month"
      expr: DATE_TRUNC('MONTH', actual_publish_timestamp)
      comment: "Month when content was published"
  measures:
    - name: "total_content_pieces"
      expr: COUNT(1)
      comment: "Total number of digital content pieces"
    - name: "total_impressions"
      expr: SUM(CAST(impressions_count AS BIGINT))
      comment: "Total number of impressions across all content"
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS BIGINT))
      comment: "Total unique reach across all content"
    - name: "total_engagement_likes"
      expr: SUM(CAST(engagement_likes_count AS BIGINT))
      comment: "Total number of likes across all content"
    - name: "total_engagement_comments"
      expr: SUM(CAST(engagement_comments_count AS BIGINT))
      comment: "Total number of comments across all content"
    - name: "total_engagement_shares"
      expr: SUM(CAST(engagement_shares_count AS BIGINT))
      comment: "Total number of shares across all content"
    - name: "total_click_throughs"
      expr: SUM(CAST(click_through_count AS BIGINT))
      comment: "Total number of click-throughs from content"
    - name: "total_video_views"
      expr: SUM(CAST(video_views_count AS BIGINT))
      comment: "Total number of video views"
    - name: "avg_impressions_per_content"
      expr: AVG(CAST(impressions_count AS BIGINT))
      comment: "Average impressions per content piece"
    - name: "avg_reach_per_content"
      expr: AVG(CAST(reach_count AS BIGINT))
      comment: "Average reach per content piece"
    - name: "engagement_rate"
      expr: ROUND(100.0 * (SUM(CAST(engagement_likes_count AS BIGINT)) + SUM(CAST(engagement_comments_count AS BIGINT)) + SUM(CAST(engagement_shares_count AS BIGINT))) / NULLIF(SUM(CAST(reach_count AS BIGINT)), 0), 2)
      comment: "Overall engagement rate (likes + comments + shares / reach)"
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CAST(click_through_count AS BIGINT)) / NULLIF(SUM(CAST(impressions_count AS BIGINT)), 0), 2)
      comment: "Percentage of impressions resulting in click-throughs"
    - name: "share_rate"
      expr: ROUND(100.0 * SUM(CAST(engagement_shares_count AS BIGINT)) / NULLIF(SUM(CAST(reach_count AS BIGINT)), 0), 2)
      comment: "Percentage of reach resulting in shares (virality indicator)"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`communication_donor_stewardship_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship and relationship management metrics tracking touchpoint effectiveness, donor satisfaction, and retention activities"
  source: "`ngo_ecm`.`communication`.`donor_stewardship_touchpoint`"
  dimensions:
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of stewardship touchpoint"
    - name: "touchpoint_status"
      expr: touchpoint_status
      comment: "Current status of the touchpoint"
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the touchpoint"
    - name: "donor_tier"
      expr: donor_tier
      comment: "Donor tier or segment"
    - name: "donor_response"
      expr: donor_response
      comment: "Donor response to the touchpoint"
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Compliance review status of the touchpoint"
    - name: "is_restricted_communication"
      expr: is_restricted_communication
      comment: "Whether the touchpoint is subject to donor restrictions"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up is required"
    - name: "country_code"
      expr: country_code
      comment: "Country of the donor"
    - name: "touchpoint_month"
      expr: DATE_TRUNC('MONTH', touchpoint_date)
      comment: "Month when the touchpoint occurred"
  measures:
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total number of donor stewardship touchpoints"
    - name: "total_touchpoint_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all stewardship touchpoints"
    - name: "avg_touchpoint_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship touchpoint"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across touchpoints"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for touchpoint records"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of touchpoints requiring follow-up"
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints requiring follow-up"
    - name: "restricted_communication_count"
      expr: SUM(CASE WHEN is_restricted_communication = TRUE THEN 1 ELSE 0 END)
      comment: "Number of touchpoints subject to donor restrictions"
    - name: "distinct_donors_engaged"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors engaged through stewardship touchpoints"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`communication_crisis_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crisis communication response metrics tracking activation speed, stakeholder notification, media management, and post-crisis review effectiveness"
  source: "`ngo_ecm`.`communication`.`crisis_communication`"
  dimensions:
    - name: "crisis_name"
      expr: crisis_name
      comment: "Name of the crisis event"
    - name: "crisis_type"
      expr: crisis_type
      comment: "Type or category of crisis"
    - name: "crisis_communication_status"
      expr: crisis_communication_status
      comment: "Current status of crisis communication response"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the crisis"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the crisis impact"
    - name: "donor_notification_required_flag"
      expr: donor_notification_required_flag
      comment: "Whether donor notification is required"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether regulatory reporting is required"
    - name: "post_crisis_review_status"
      expr: post_crisis_review_status
      comment: "Status of post-crisis review"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month when crisis communication was activated"
  measures:
    - name: "total_crises"
      expr: COUNT(1)
      comment: "Total number of crisis communication events"
    - name: "total_media_inquiries_received"
      expr: SUM(CAST(media_inquiries_received_count AS BIGINT))
      comment: "Total number of media inquiries received during crises"
    - name: "total_media_inquiries_responded"
      expr: SUM(CAST(media_inquiries_responded_count AS BIGINT))
      comment: "Total number of media inquiries responded to"
    - name: "media_inquiry_response_rate"
      expr: ROUND(100.0 * SUM(CAST(media_inquiries_responded_count AS BIGINT)) / NULLIF(SUM(CAST(media_inquiries_received_count AS BIGINT)), 0), 2)
      comment: "Percentage of media inquiries that received responses"
    - name: "total_press_releases_issued"
      expr: SUM(CAST(press_releases_issued_count AS BIGINT))
      comment: "Total number of press releases issued during crises"
    - name: "total_social_media_posts"
      expr: SUM(CAST(social_media_posts_count AS BIGINT))
      comment: "Total number of social media posts during crises"
    - name: "total_stakeholder_briefings"
      expr: SUM(CAST(stakeholder_briefings_count AS BIGINT))
      comment: "Total number of stakeholder briefings conducted"
    - name: "avg_days_to_deactivation"
      expr: AVG(DATEDIFF(deactivation_date, activation_date))
      comment: "Average number of days from crisis activation to deactivation"
    - name: "donor_notification_required_count"
      expr: SUM(CASE WHEN donor_notification_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of crises requiring donor notification"
    - name: "regulatory_reporting_required_count"
      expr: SUM(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of crises requiring regulatory reporting"
    - name: "post_crisis_review_completed_count"
      expr: SUM(CASE WHEN post_crisis_review_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of crises with completed post-crisis reviews"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`communication_constituent_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Constituent consent and data protection compliance metrics tracking opt-in rates, consent status, and GDPR/privacy regulation adherence"
  source: "`ngo_ecm`.`communication`.`constituent_consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, data processing, etc.)"
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent"
    - name: "consent_basis"
      expr: consent_basis
      comment: "Legal basis for consent (GDPR, legitimate interest, etc.)"
    - name: "consent_method"
      expr: consent_method
      comment: "Method through which consent was obtained"
    - name: "applicable_regulation"
      expr: applicable_regulation
      comment: "Applicable data protection regulation"
    - name: "constituent_country_code"
      expr: constituent_country_code
      comment: "Country of the constituent"
    - name: "channel_email"
      expr: channel_email
      comment: "Whether email channel consent is granted"
    - name: "channel_sms"
      expr: channel_sms
      comment: "Whether SMS channel consent is granted"
    - name: "channel_phone"
      expr: channel_phone
      comment: "Whether phone channel consent is granted"
    - name: "double_opt_in_confirmed"
      expr: double_opt_in_confirmed
      comment: "Whether double opt-in was confirmed"
    - name: "is_minor"
      expr: is_minor
      comment: "Whether the constituent is a minor"
    - name: "parental_consent_obtained"
      expr: parental_consent_obtained
      comment: "Whether parental consent was obtained for minors"
    - name: "consent_granted_month"
      expr: DATE_TRUNC('MONTH', consent_granted_date)
      comment: "Month when consent was granted"
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of consent records"
    - name: "active_consent_count"
      expr: SUM(CASE WHEN consent_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active consent records"
    - name: "withdrawn_consent_count"
      expr: SUM(CASE WHEN consent_withdrawn_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of consents that have been withdrawn"
    - name: "consent_withdrawal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_withdrawn_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that have been withdrawn"
    - name: "double_opt_in_confirmed_count"
      expr: SUM(CASE WHEN double_opt_in_confirmed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of consents with confirmed double opt-in"
    - name: "double_opt_in_confirmation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN double_opt_in_confirmed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents with confirmed double opt-in"
    - name: "email_consent_count"
      expr: SUM(CASE WHEN channel_email = TRUE THEN 1 ELSE 0 END)
      comment: "Number of constituents with email consent"
    - name: "sms_consent_count"
      expr: SUM(CASE WHEN channel_sms = TRUE THEN 1 ELSE 0 END)
      comment: "Number of constituents with SMS consent"
    - name: "phone_consent_count"
      expr: SUM(CASE WHEN channel_phone = TRUE THEN 1 ELSE 0 END)
      comment: "Number of constituents with phone consent"
    - name: "minor_consent_count"
      expr: SUM(CASE WHEN is_minor = TRUE THEN 1 ELSE 0 END)
      comment: "Number of consent records for minors"
    - name: "parental_consent_obtained_count"
      expr: SUM(CASE WHEN parental_consent_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Number of minor consents with parental consent obtained"
    - name: "expired_consent_count"
      expr: SUM(CASE WHEN consent_expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of consents that have expired"
    - name: "distinct_constituents_with_consent"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents with consent records"
$$;