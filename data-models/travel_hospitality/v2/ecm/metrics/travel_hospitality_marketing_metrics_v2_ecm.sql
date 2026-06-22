-- Metric views for domain: marketing | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign financial performance and budget management metrics. Enables CMOs and marketing VPs to track spend efficiency, budget utilization, and campaign portfolio health across brands and segments."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of marketing campaign (e.g. email, paid search, display) for performance segmentation."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (active, paused, completed, cancelled)."
    - name: "brand_scope"
      expr: brand_scope
      comment: "Brand(s) targeted by the campaign for brand-level budget analysis."
    - name: "target_segment"
      expr: target_segment
      comment: "Guest segment targeted by the campaign for audience-level ROI analysis."
    - name: "objective"
      expr: objective
      comment: "Strategic objective of the campaign (awareness, conversion, retention, etc.)."
    - name: "budget_period"
      expr: budget_period
      comment: "Budget period (monthly, quarterly, annual) for time-based budget tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the campaign for governance reporting."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Campaign start month for trend analysis."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved marketing budget across campaigns. Core financial planning KPI for CMO budget oversight."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend incurred across campaigns. Tracks real expenditure against budget commitments."
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed (obligated but not yet invoiced) spend. Critical for cash flow and budget forecasting."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total unspent budget remaining across active campaigns. Signals under-investment or budget reallocation opportunities."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total variance between planned and actual spend. Negative variance indicates overspend requiring executive attention."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per campaign. Benchmarks investment level per initiative for portfolio sizing decisions."
    - name: "total_email_budget"
      expr: SUM(CAST(email_budget_amount AS DOUBLE))
      comment: "Total budget allocated to email channel. Enables channel mix optimization decisions."
    - name: "total_paid_search_budget"
      expr: SUM(CAST(paid_search_budget_amount AS DOUBLE))
      comment: "Total budget allocated to paid search. Supports SEM investment decisions and channel ROI comparison."
    - name: "total_social_budget"
      expr: SUM(CAST(social_budget_amount AS DOUBLE))
      comment: "Total budget allocated to social media channels. Tracks social investment relative to engagement outcomes."
    - name: "total_display_budget"
      expr: SUM(CAST(display_budget_amount AS DOUBLE))
      comment: "Total budget allocated to display advertising. Supports programmatic spend governance."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline volume metric for portfolio breadth and resource allocation planning."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns. Indicates marketing execution intensity at any point in time."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total budget actually spent. Key efficiency KPI — low utilization signals execution gaps; high utilization signals risk of overspend."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign execution performance metrics covering delivery, engagement, conversion, and cost efficiency. Enables marketing operations teams and CMOs to evaluate channel effectiveness and optimize spend allocation."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign_execution`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Marketing delivery channel (email, SMS, push, display) for channel-level performance comparison."
    - name: "channel_category"
      expr: channel_category
      comment: "Broad channel category grouping for portfolio-level channel mix analysis."
    - name: "execution_status"
      expr: execution_status
      comment: "Current status of the execution (scheduled, in-progress, completed, failed) for operational monitoring."
    - name: "attribution_model_type"
      expr: attribution_model_type
      comment: "Attribution model applied (last-click, first-click, linear, data-driven) for revenue attribution analysis."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier for controlled experiment performance comparison."
    - name: "execution_timestamp_month"
      expr: DATE_TRUNC('month', execution_timestamp)
      comment: "Month of execution for trend analysis of campaign delivery performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of execution cost for multi-currency financial reporting."
  measures:
    - name: "total_execution_cost"
      expr: SUM(CAST(execution_cost AS DOUBLE))
      comment: "Total cost incurred across all campaign executions. Primary financial KPI for marketing spend accountability."
    - name: "total_revenue_attributed"
      expr: SUM(CAST(revenue_attributed AS DOUBLE))
      comment: "Total revenue attributed to campaign executions. Core ROI numerator for marketing investment justification."
    - name: "avg_execution_cost"
      expr: AVG(CAST(execution_cost AS DOUBLE))
      comment: "Average cost per execution. Benchmarks efficiency of individual campaign deployments."
    - name: "avg_revenue_attributed"
      expr: AVG(CAST(revenue_attributed AS DOUBLE))
      comment: "Average revenue attributed per execution. Indicates typical revenue yield per campaign deployment."
    - name: "execution_count"
      expr: COUNT(1)
      comment: "Total number of campaign executions. Volume baseline for marketing activity intensity."
    - name: "revenue_to_cost_ratio"
      expr: ROUND(SUM(CAST(revenue_attributed AS DOUBLE)) / NULLIF(SUM(CAST(execution_cost AS DOUBLE)), 0), 2)
      comment: "Revenue generated per dollar of execution cost (marketing ROAS proxy). Fundamental efficiency KPI for budget reallocation decisions."
    - name: "total_channel_cost_model"
      expr: SUM(CAST(channel_cost_model AS DOUBLE))
      comment: "Total modeled channel cost for budget planning and actual-vs-model variance analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_attribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing attribution and conversion analytics. Enables revenue attribution across touchpoints, channels, and campaigns to optimize marketing mix and justify channel investment."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`attribution_event`"
  dimensions:
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of marketing touchpoint (impression, click, email open, direct) for funnel stage analysis."
    - name: "attribution_model"
      expr: attribution_model
      comment: "Attribution model used (last-click, first-click, linear, time-decay) for model comparison analysis."
    - name: "channel"
      expr: channel
      comment: "Marketing channel of the attribution event for channel-level revenue credit analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet) for device-level conversion analysis."
    - name: "ad_platform"
      expr: ad_platform
      comment: "Advertising platform (Google, Meta, programmatic) for platform ROI comparison."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the attribution event for geographic marketing performance analysis."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the event resulted in a conversion (booking). Enables conversion funnel segmentation."
    - name: "event_timestamp_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the attribution event for trend analysis of conversion patterns."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter for campaign traffic source analysis."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter for granular traffic origin attribution."
  measures:
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total monetary value of conversions attributed across all touchpoints. Primary revenue attribution KPI for marketing ROI."
    - name: "total_attribution_credit"
      expr: SUM(CAST(attribution_credit AS DOUBLE))
      comment: "Total attribution credit distributed across touchpoints. Measures fractional revenue ownership per channel/campaign."
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average hours from first touchpoint to conversion. Indicates consideration cycle length; informs retargeting window strategy."
    - name: "conversion_event_count"
      expr: COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END)
      comment: "Total number of conversion events (bookings). Core volume KPI for campaign effectiveness measurement."
    - name: "total_attribution_events"
      expr: COUNT(1)
      comment: "Total attribution events recorded. Baseline touchpoint volume for funnel analysis."
    - name: "conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attribution events that resulted in a conversion. Fundamental funnel efficiency KPI for channel and campaign optimization."
    - name: "avg_conversion_value"
      expr: AVG(CASE WHEN conversion_flag = TRUE THEN conversion_value END)
      comment: "Average value per converting event. Indicates booking quality per channel; informs high-value audience targeting."
    - name: "distinct_campaigns_with_conversions"
      expr: COUNT(DISTINCT CASE WHEN conversion_flag = TRUE THEN campaign_id END)
      comment: "Number of distinct campaigns that generated at least one conversion. Measures breadth of effective campaign portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer redemption performance and discount impact metrics. Enables revenue management and marketing teams to evaluate offer effectiveness, discount depth, and incremental revenue generation."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`offer_redemption`"
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (percentage, flat, points) for offer structure analysis."
    - name: "redemption_channel"
      expr: redemption_channel
      comment: "Channel through which the offer was redeemed (web, mobile, OTA, front desk) for channel effectiveness analysis."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the redemption (valid, rejected, expired) for offer integrity monitoring."
    - name: "market_segment_code"
      expr: market_segment_code
      comment: "Market segment of the redeeming guest for segment-level offer performance analysis."
    - name: "offer_code"
      expr: offer_code
      comment: "Specific offer code redeemed for granular offer-level performance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction for multi-currency financial reporting."
    - name: "booking_date_month"
      expr: DATE_TRUNC('month', booking_date)
      comment: "Month of booking for seasonal offer redemption trend analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device used for redemption for digital channel optimization."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of offer redemptions. Baseline volume KPI for offer uptake and campaign reach."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted to guests. Measures revenue concession cost of marketing offers."
    - name: "total_final_rate_revenue"
      expr: SUM(CAST(final_rate_amount AS DOUBLE))
      comment: "Total revenue realized after discount application. Net revenue yield from offer-driven bookings."
    - name: "total_original_rate_revenue"
      expr: SUM(CAST(original_rate_amount AS DOUBLE))
      comment: "Total revenue at rack/original rate before discount. Baseline for discount impact quantification."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per redemption. Indicates typical offer generosity; informs offer calibration decisions."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied. Key metric for revenue management to assess rate integrity risk."
    - name: "avg_final_rate"
      expr: AVG(CAST(final_rate_amount AS DOUBLE))
      comment: "Average net rate after discount. Benchmarks effective ADR from offer-driven bookings."
    - name: "discount_to_revenue_ratio"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_rate_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of original rate revenue. Measures revenue leakage from promotional activity; critical for revenue integrity governance."
    - name: "distinct_guests_redeeming"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests who redeemed an offer. Measures offer reach and audience penetration."
    - name: "distinct_properties_with_redemptions"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of properties where offers were redeemed. Indicates geographic spread of offer effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_guest_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest communication delivery and engagement metrics. Enables CRM and marketing teams to optimize message effectiveness, reduce opt-outs, and improve conversion from direct communications."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`guest_communication`"
  dimensions:
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (pre-arrival, post-stay, promotional, transactional) for message category analysis."
    - name: "channel"
      expr: channel
      comment: "Delivery channel (email, SMS, push notification) for channel performance comparison."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome (delivered, bounced, failed) for deliverability monitoring."
    - name: "opt_in_status"
      expr: opt_in_status
      comment: "Guest opt-in status at time of send for consent compliance monitoring."
    - name: "language_code"
      expr: language_code
      comment: "Language of the communication for localization effectiveness analysis."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Whether the communication resulted in a booking conversion for direct revenue attribution."
    - name: "sent_timestamp_month"
      expr: DATE_TRUNC('month', sent_timestamp)
      comment: "Month communications were sent for volume and engagement trend analysis."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant for controlled message optimization experiments."
  measures:
    - name: "total_communications_sent"
      expr: COUNT(1)
      comment: "Total communications sent. Baseline volume KPI for CRM activity and guest engagement intensity."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total revenue value from communication-driven conversions. Direct revenue attribution from CRM communications."
    - name: "avg_conversion_value"
      expr: AVG(CASE WHEN conversion_flag = TRUE THEN conversion_value END)
      comment: "Average revenue per converting communication. Indicates quality of bookings driven by direct messaging."
    - name: "conversion_count"
      expr: COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END)
      comment: "Number of communications that resulted in a booking. Core effectiveness KPI for CRM program ROI."
    - name: "communication_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of communications that converted to a booking. Primary CRM effectiveness KPI for channel and message optimization."
    - name: "distinct_guests_reached"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests contacted. Measures CRM program reach and audience penetration."
    - name: "distinct_properties_communicating"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of properties actively communicating with guests. Indicates CRM program adoption breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_survey_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest survey response and satisfaction metrics. Enables marketing and experience teams to track NPS, GSS, CSAT, and sentiment trends to drive service improvement and loyalty investment decisions."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`survey_response`"
  dimensions:
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS classification (Promoter, Passive, Detractor) for loyalty segmentation and advocacy analysis."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment classification (positive, neutral, negative) for qualitative feedback trend analysis."
    - name: "response_channel"
      expr: response_channel
      comment: "Channel through which the survey was completed (email, in-app, web) for response quality analysis."
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest (leisure, business, group) for segment-level satisfaction benchmarking."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Guest loyalty tier at time of survey for tier-level satisfaction and retention analysis."
    - name: "response_status"
      expr: response_status
      comment: "Status of the survey response (complete, partial, abandoned) for response quality filtering."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether a service recovery follow-up was triggered. Identifies dissatisfied guests requiring intervention."
    - name: "checkout_date_month"
      expr: DATE_TRUNC('month', checkout_date)
      comment: "Month of guest checkout for seasonal satisfaction trend analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the stay was booked for channel-level satisfaction comparison."
  measures:
    - name: "total_survey_responses"
      expr: COUNT(1)
      comment: "Total survey responses received. Baseline volume KPI for survey program reach and statistical validity."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score. Premier guest loyalty and advocacy KPI used in executive dashboards and brand health reporting."
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score. Core operational quality KPI tied to brand standards and management incentives."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction Score. Measures overall stay satisfaction for service quality benchmarking."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from verbatim feedback analysis. Tracks qualitative guest perception trends."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN nps_classification = 'Promoter' THEN 1 END)
      comment: "Number of Promoter responses. Measures brand advocacy volume for loyalty program investment decisions."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN nps_classification = 'Detractor' THEN 1 END)
      comment: "Number of Detractor responses. Identifies at-risk guests requiring service recovery intervention."
    - name: "net_promoter_score"
      expr: ROUND(100.0 * COUNT(CASE WHEN nps_classification = 'Promoter' THEN 1 END) / NULLIF(COUNT(1), 0), 2) - ROUND(100.0 * COUNT(CASE WHEN nps_classification = 'Detractor' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Calculated NPS (% Promoters minus % Detractors). The single most-watched guest loyalty KPI in hospitality, used in board reporting and brand benchmarking."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of responses requiring service recovery follow-up. Operational KPI for guest recovery workload and service failure rate."
    - name: "total_spend_amount"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total guest spend associated with survey responses. Enables satisfaction-to-revenue correlation analysis for LTV modeling."
    - name: "avg_total_spend"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average spend per responding guest. Benchmarks revenue contribution of satisfied vs. dissatisfied guests."
    - name: "distinct_properties_surveyed"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of properties with survey responses. Measures survey program coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_social_post`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social media performance and engagement metrics. Enables brand and digital marketing teams to evaluate content effectiveness, audience reach, and social ROI across platforms."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`social_post`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social media platform (Instagram, Facebook, LinkedIn, Twitter) for platform-level performance benchmarking."
    - name: "post_type"
      expr: post_type
      comment: "Type of post (image, video, story, reel, carousel) for content format effectiveness analysis."
    - name: "post_status"
      expr: post_status
      comment: "Current status of the post (published, scheduled, deleted) for content pipeline monitoring."
    - name: "is_boosted"
      expr: is_boosted
      comment: "Whether the post was boosted with paid spend for organic vs. paid performance comparison."
    - name: "content_language"
      expr: content_language
      comment: "Language of the post content for localization performance analysis."
    - name: "actual_publish_month"
      expr: DATE_TRUNC('month', actual_publish_timestamp)
      comment: "Month of publication for social content volume and engagement trend analysis."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions_count AS DOUBLE))
      comment: "Total impressions across all social posts. Measures brand awareness reach and content visibility."
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS DOUBLE))
      comment: "Total unique accounts reached. Measures unduplicated audience exposure for brand awareness campaigns."
    - name: "total_engagements"
      expr: SUM(CAST(engagement_count AS DOUBLE))
      comment: "Total engagement actions (likes, comments, shares, saves). Core social effectiveness KPI for content strategy decisions."
    - name: "total_likes"
      expr: SUM(CAST(likes_count AS DOUBLE))
      comment: "Total likes received. Measures positive audience sentiment and content resonance."
    - name: "total_comments"
      expr: SUM(CAST(comments_count AS DOUBLE))
      comment: "Total comments received. Indicates community engagement depth and conversation generation."
    - name: "total_shares"
      expr: SUM(CAST(shares_count AS DOUBLE))
      comment: "Total shares/reposts. Measures organic amplification and brand advocacy through social channels."
    - name: "total_video_views"
      expr: SUM(CAST(video_views_count AS DOUBLE))
      comment: "Total video views. Measures video content consumption for video strategy investment decisions."
    - name: "total_link_clicks"
      expr: SUM(CAST(link_clicks_count AS DOUBLE))
      comment: "Total link clicks driving traffic to owned properties. Measures social-to-web conversion funnel entry."
    - name: "total_boost_spend"
      expr: SUM(CAST(boost_budget_amount AS DOUBLE))
      comment: "Total paid boost spend on social posts. Tracks paid social investment for ROI calculation."
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate AS DOUBLE))
      comment: "Average engagement rate per post. Industry-standard social KPI for content quality benchmarking against competitors."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score of social posts. Tracks brand perception health through social listening."
    - name: "post_count"
      expr: COUNT(1)
      comment: "Total number of social posts published. Baseline content volume KPI for editorial calendar governance."
    - name: "cost_per_engagement"
      expr: ROUND(SUM(CAST(boost_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(engagement_count AS DOUBLE)), 0), 4)
      comment: "Paid boost cost per engagement action. Measures paid social efficiency; drives budget reallocation between platforms."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_experiment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing experiment and A/B test performance metrics. Enables data-driven decision-making by tracking test outcomes, statistical significance, and estimated business impact of marketing experiments."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`experiment`"
  dimensions:
    - name: "experiment_type"
      expr: experiment_type
      comment: "Type of experiment (A/B test, multivariate, holdout) for methodology-level analysis."
    - name: "experiment_status"
      expr: experiment_status
      comment: "Current status of the experiment (running, completed, paused, cancelled) for portfolio monitoring."
    - name: "channel"
      expr: channel
      comment: "Marketing channel being tested for channel-specific optimization insights."
    - name: "winning_variant"
      expr: winning_variant
      comment: "Winning variant of completed experiments for learning capture and rollout decisions."
    - name: "implementation_flag"
      expr: implementation_flag
      comment: "Whether the winning variant was implemented. Tracks experiment-to-action conversion rate."
    - name: "primary_metric"
      expr: primary_metric
      comment: "Primary success metric of the experiment for outcome-based experiment categorization."
    - name: "start_date_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month experiments were started for experimentation cadence trend analysis."
  measures:
    - name: "total_experiments"
      expr: COUNT(1)
      comment: "Total number of experiments run. Measures organizational experimentation velocity and data-driven culture maturity."
    - name: "implemented_experiment_count"
      expr: COUNT(CASE WHEN implementation_flag = TRUE THEN 1 END)
      comment: "Number of experiments where winning variants were implemented. Measures experiment-to-action conversion rate."
    - name: "implementation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of experiments that resulted in implementation. Measures organizational ability to act on test results."
    - name: "total_estimated_annual_impact"
      expr: SUM(CAST(estimated_annual_impact_amount AS DOUBLE))
      comment: "Total estimated annual revenue/cost impact from all experiments. Quantifies the financial value of the experimentation program for executive investment decisions."
    - name: "avg_lift_percentage"
      expr: AVG(CAST(lift_percentage AS DOUBLE))
      comment: "Average percentage lift achieved by winning variants. Measures typical improvement magnitude from marketing experiments."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level_percentage AS DOUBLE))
      comment: "Average statistical confidence level of experiments. Indicates rigor of the experimentation program."
    - name: "avg_p_value"
      expr: AVG(CAST(p_value AS DOUBLE))
      comment: "Average p-value across experiments. Monitors statistical significance standards across the testing program."
    - name: "statistically_significant_count"
      expr: COUNT(CASE WHEN p_value <= 0.05 THEN 1 END)
      comment: "Number of experiments achieving statistical significance (p <= 0.05). Measures quality of experimental outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment portfolio metrics. Enables marketing strategy teams to manage segment quality, coverage, and targeting effectiveness for personalization and campaign planning."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`guest_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, value-based, predictive) for segmentation strategy analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, inactive, draft) for segment portfolio governance."
    - name: "segment_creation_method"
      expr: segment_creation_method
      comment: "How the segment was created (rule-based, ML model, manual) for methodology comparison."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment for regional marketing planning."
    - name: "loyalty_tier_scope"
      expr: loyalty_tier_scope
      comment: "Loyalty tier scope of the segment for tier-based targeting analysis."
    - name: "campaign_eligibility_flag"
      expr: campaign_eligibility_flag
      comment: "Whether the segment is eligible for campaign targeting. Filters actionable segments."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How often the segment is refreshed (daily, weekly, monthly) for data freshness governance."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of guest segments defined. Measures personalization infrastructure breadth."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN segment_status = 'active' THEN 1 END)
      comment: "Number of active segments available for campaign targeting. Indicates operational personalization capacity."
    - name: "total_estimated_audience_size"
      expr: SUM(CAST(estimated_size AS DOUBLE))
      comment: "Total estimated guests across all segments. Measures total addressable audience for marketing programs."
    - name: "avg_segment_size"
      expr: AVG(CAST(estimated_size AS DOUBLE))
      comment: "Average size of guest segments. Informs segment granularity strategy — very small segments may not be cost-effective to target."
    - name: "avg_target_adr_max"
      expr: AVG(CAST(target_adr_max AS DOUBLE))
      comment: "Average maximum target ADR across segments. Benchmarks revenue potential of the segment portfolio."
    - name: "avg_target_ltv_min"
      expr: AVG(CAST(target_ltv_min AS DOUBLE))
      comment: "Average minimum target lifetime value across segments. Indicates value threshold for segment investment decisions."
    - name: "avg_target_gss_min"
      expr: AVG(CAST(target_gss_min AS DOUBLE))
      comment: "Average minimum target GSS across segments. Measures quality bar set for segment satisfaction expectations."
    - name: "campaign_eligible_segment_count"
      expr: COUNT(CASE WHEN campaign_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of segments eligible for campaign targeting. Measures actionable segment portfolio size for campaign planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign offer portfolio and redemption performance metrics. Enables revenue management and marketing teams to evaluate offer attractiveness, redemption velocity, and discount economics."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign_offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (discount, bonus points, upgrade, package) for offer category performance analysis."
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer (active, expired, paused) for offer portfolio governance."
    - name: "discount_type"
      expr: discount_type
      comment: "Discount mechanism (percentage, flat amount, points multiplier) for offer structure analysis."
    - name: "member_exclusive_flag"
      expr: member_exclusive_flag
      comment: "Whether the offer is exclusive to loyalty members. Measures loyalty program value proposition contribution."
    - name: "enrollment_required_flag"
      expr: enrollment_required_flag
      comment: "Whether enrollment is required to access the offer. Tracks enrollment-gated offer strategy effectiveness."
    - name: "valid_from_date_month"
      expr: DATE_TRUNC('month', valid_from_date)
      comment: "Month offers become valid for seasonal offer portfolio analysis."
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Total number of campaign offers created. Measures offer portfolio breadth and marketing creativity output."
    - name: "active_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'active' THEN 1 END)
      comment: "Number of currently active offers. Indicates live promotional intensity in the market."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer. Benchmarks offer generosity for competitive positioning and margin management."
    - name: "total_redemption_limit"
      expr: SUM(CAST(redemption_limit_total AS DOUBLE))
      comment: "Total redemption capacity across all offers. Measures maximum promotional exposure and revenue risk."
    - name: "avg_bonus_points_multiplier"
      expr: AVG(CAST(bonus_points_multiplier AS DOUBLE))
      comment: "Average bonus points multiplier across offers. Measures loyalty currency investment in promotional offers."
    - name: "avg_tier_credit_multiplier"
      expr: AVG(CAST(tier_credit_multiplier AS DOUBLE))
      comment: "Average tier credit multiplier across offers. Measures tier acceleration investment in promotional strategy."
    - name: "avg_minimum_spend"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold to qualify for offers. Indicates revenue floor strategy for promotional targeting."
    - name: "member_exclusive_offer_count"
      expr: COUNT(CASE WHEN member_exclusive_flag = TRUE THEN 1 END)
      comment: "Number of member-exclusive offers. Measures loyalty program differentiation through exclusive offer access."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing consent and compliance metrics. Enables compliance and marketing teams to monitor opt-in rates, consent health, and regulatory compliance across jurisdictions and channels."
  source: "`vibe_travel_hospitality_v1`.`marketing`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (email marketing, SMS, data processing, profiling) for consent category compliance monitoring."
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (active, withdrawn, expired) for consent portfolio health monitoring."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (consent, legitimate interest, contract) for GDPR/privacy compliance reporting."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction (EU, US, APAC) for region-specific compliance monitoring."
    - name: "is_active"
      expr: is_active
      comment: "Whether the consent record is currently active. Primary filter for addressable marketing audience."
    - name: "double_opt_in_confirmed"
      expr: double_opt_in_confirmed
      comment: "Whether double opt-in was confirmed. Measures consent quality and regulatory compliance standard."
    - name: "consent_date_month"
      expr: DATE_TRUNC('month', consent_date)
      comment: "Month consent was granted for opt-in trend analysis."
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total consent records. Baseline for addressable marketing audience size and consent database health."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active consents. Defines the legally addressable marketing audience — critical for campaign reach planning."
    - name: "double_opt_in_count"
      expr: COUNT(CASE WHEN double_opt_in_confirmed = TRUE THEN 1 END)
      comment: "Number of double opt-in confirmed consents. Measures highest-quality consent tier for premium campaign targeting."
    - name: "opt_out_count"
      expr: COUNT(CASE WHEN consent_status = 'withdrawn' THEN 1 END)
      comment: "Number of withdrawn consents. Tracks opt-out volume as a brand health and communication quality signal."
    - name: "active_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that are currently active. Measures consent database health and addressable audience retention rate."
    - name: "double_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents with double opt-in confirmation. Measures consent quality standard compliance."
    - name: "distinct_guests_with_consent"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests with at least one consent record. Measures CRM database addressability."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`brand`"
  dimensions:
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Description"
      expr: brand_description
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Status"
      expr: brand_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Geographic Focus"
      expr: geographic_focus
    - name: "Guidelines Url"
      expr: guidelines_url
    - name: "Is Featured Brand"
      expr: is_featured_brand
    - name: "Launch Date"
      expr: launch_date
    - name: "Logo Url"
      expr: logo_url
    - name: "Loyalty Program Name"
      expr: loyalty_program_name
    - name: "Parent Company"
      expr: parent_company
    - name: "Positioning Statement"
      expr: positioning_statement
    - name: "Primary Color Hex"
      expr: primary_color_hex
    - name: "Property Count"
      expr: property_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Brand"
      expr: COUNT(DISTINCT brand_id)
    - name: "Total Average Daily Rate Target"
      expr: SUM(average_daily_rate_target)
    - name: "Average Average Daily Rate Target"
      expr: AVG(average_daily_rate_target)
    - name: "Total Guest Satisfaction Score Target"
      expr: SUM(guest_satisfaction_score_target)
    - name: "Average Guest Satisfaction Score Target"
      expr: AVG(guest_satisfaction_score_target)
    - name: "Total Marketing Budget Annual"
      expr: SUM(marketing_budget_annual)
    - name: "Average Marketing Budget Annual"
      expr: AVG(marketing_budget_annual)
    - name: "Total Net Promoter Score Target"
      expr: SUM(net_promoter_score_target)
    - name: "Average Net Promoter Score Target"
      expr: AVG(net_promoter_score_target)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_campaign_treatment_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign Treatment Promotion business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`campaign_treatment_promotion`"
  dimensions:
    - name: "Booking Count"
      expr: booking_count
    - name: "Campaign End Date"
      expr: campaign_end_date
    - name: "Campaign Start Date"
      expr: campaign_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Featured Position"
      expr: featured_position
    - name: "Promo Code"
      expr: promo_code
    - name: "Promotion Status"
      expr: promotion_status
    - name: "Campaign End Date Month"
      expr: DATE_TRUNC('MONTH', campaign_end_date)
    - name: "Campaign Start Date Month"
      expr: DATE_TRUNC('MONTH', campaign_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign Treatment Promotion"
      expr: COUNT(DISTINCT campaign_treatment_promotion_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Promotional Price"
      expr: SUM(promotional_price)
    - name: "Average Promotional Price"
      expr: AVG(promotional_price)
    - name: "Total Revenue Generated"
      expr: SUM(revenue_generated)
    - name: "Average Revenue Generated"
      expr: AVG(revenue_generated)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_communication_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication Template business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`communication_template`"
  dimensions:
    - name: "A B Test Enabled"
      expr: a_b_test_enabled
    - name: "A B Test Variant"
      expr: a_b_test_variant
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Body Content"
      expr: body_content
    - name: "Call To Action Text"
      expr: call_to_action_text
    - name: "Call To Action Url"
      expr: call_to_action_url
    - name: "Compliance Approved"
      expr: compliance_approved
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Version"
      expr: design_version
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Footer Text"
      expr: footer_text
    - name: "Html Content"
      expr: html_content
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Communication Template"
      expr: COUNT(DISTINCT communication_template_id)
    - name: "Total Usage Count"
      expr: SUM(usage_count)
    - name: "Average Usage Count"
      expr: AVG(usage_count)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_content_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content Asset business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`content_asset`"
  dimensions:
    - name: "Alt Text"
      expr: alt_text
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Asset Code"
      expr: asset_code
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Type"
      expr: asset_type
    - name: "Content Asset Description"
      expr: content_asset_description
    - name: "Content Theme"
      expr: content_theme
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creator Name"
      expr: creator_name
    - name: "Download Count"
      expr: download_count
    - name: "File Format"
      expr: file_format
    - name: "File Url"
      expr: file_url
    - name: "Is Active"
      expr: is_active
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Content Asset"
      expr: COUNT(DISTINCT content_asset_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_marketing_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing Calendar business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`marketing_calendar`"
  dimensions:
    - name: "Actual Campaign Count"
      expr: actual_campaign_count
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Blackout Reason"
      expr: blackout_reason
    - name: "Brand Moment Description"
      expr: brand_moment_description
    - name: "Brand Scope"
      expr: brand_scope
    - name: "Collision Risk Flag"
      expr: collision_risk_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Functional Dependencies"
      expr: cross_functional_dependencies
    - name: "Duration Days"
      expr: duration_days
    - name: "End Date"
      expr: end_date
    - name: "Entry Code"
      expr: entry_code
    - name: "Entry Name"
      expr: entry_name
    - name: "Entry Status"
      expr: entry_status
    - name: "Entry Type"
      expr: entry_type
    - name: "Expected Campaign Count"
      expr: expected_campaign_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Marketing Calendar"
      expr: COUNT(DISTINCT marketing_calendar_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`marketing_survey_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Survey Program business metrics"
  source: "`vibe_travel_hospitality_v1`.`marketing`.`survey_program`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Auto Case Creation Flag"
      expr: auto_case_creation_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Retention Days"
      expr: data_retention_days
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Estimated Completion Minutes"
      expr: estimated_completion_minutes
    - name: "Incentive Description"
      expr: incentive_description
    - name: "Incentive Offered Flag"
      expr: incentive_offered_flag
    - name: "Language Codes"
      expr: language_codes
    - name: "Max Reminders"
      expr: max_reminders
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Privacy Notice Version"
      expr: privacy_notice_version
    - name: "Property Scope"
      expr: property_scope
    - name: "Question Count"
      expr: question_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Survey Program"
      expr: COUNT(DISTINCT survey_program_id)
    - name: "Total Service Recovery Threshold Score"
      expr: SUM(service_recovery_threshold_score)
    - name: "Average Service Recovery Threshold Score"
      expr: AVG(service_recovery_threshold_score)
    - name: "Total Target Gss Score"
      expr: SUM(target_gss_score)
    - name: "Average Target Gss Score"
      expr: AVG(target_gss_score)
    - name: "Total Target Nps Score"
      expr: SUM(target_nps_score)
    - name: "Average Target Nps Score"
      expr: AVG(target_nps_score)
    - name: "Total Target Response Rate Pct"
      expr: SUM(target_response_rate_pct)
    - name: "Average Target Response Rate Pct"
      expr: AVG(target_response_rate_pct)
$$;