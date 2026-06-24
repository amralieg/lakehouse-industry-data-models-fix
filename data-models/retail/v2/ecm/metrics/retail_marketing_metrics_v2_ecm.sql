-- Metric views for domain: marketing | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic campaign portfolio metrics covering budget utilisation, revenue targeting, and pipeline health across all active marketing campaigns."
  source: "`vibe_retail_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g. brand, performance, retention) for portfolio segmentation."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (draft, active, completed, cancelled)."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary marketing channel driving the campaign (email, paid_social, search, etc.)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status indicating whether the campaign has been signed off."
    - name: "is_omnichannel"
      expr: is_omnichannel
      comment: "Flag indicating whether the campaign spans multiple channels simultaneously."
    - name: "is_personalized"
      expr: is_personalized
      comment: "Flag indicating whether the campaign uses personalised content or targeting."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned campaign start date for trend analysis."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency in which campaign budget and spend are denominated."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the campaign for regional performance analysis."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns in the portfolio; baseline volume metric."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all campaigns; drives investment planning decisions."
    - name: "total_actual_spend_amount"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend incurred across campaigns; compared against budget to assess utilisation."
    - name: "total_target_revenue_goal"
      expr: SUM(CAST(target_revenue_goal AS DOUBLE))
      comment: "Aggregate revenue goal set across campaigns; used to evaluate ambition vs. outcome."
    - name: "avg_budget_per_campaign"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget allocated per campaign; benchmarks investment sizing decisions."
    - name: "avg_actual_spend_per_campaign"
      expr: AVG(CAST(actual_spend_amount AS DOUBLE))
      comment: "Average actual spend per campaign; identifies over- or under-spending patterns."
    - name: "total_target_audience_size"
      expr: SUM(CAST(target_audience_size AS DOUBLE))
      comment: "Total intended audience reach across campaigns; informs scale and media planning."
    - name: "total_target_conversion_goal"
      expr: SUM(CAST(target_conversion_goal AS DOUBLE))
      comment: "Aggregate conversion target across campaigns; used to set and track performance expectations."
    - name: "budget_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget consumed; key efficiency KPI for marketing finance reviews."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_campaign_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Execution-level campaign performance KPIs covering reach, engagement, conversion, revenue attribution, and return on ad spend — the primary steering dashboard for marketing leadership."
  source: "`vibe_retail_v1`.`marketing`.`campaign_performance`"
  dimensions:
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Granularity of the reporting period (daily, weekly, monthly, quarterly)."
    - name: "reporting_period_start_date"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month bucket of the reporting period start for trend analysis."
    - name: "performance_status"
      expr: performance_status
      comment: "Status of the performance record (final, estimated, revised)."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system that provided the performance data for lineage and reconciliation."
    - name: "revenue_currency_code"
      expr: revenue_currency_code
      comment: "Currency of attributed revenue figures for multi-currency normalisation."
    - name: "spend_currency_code"
      expr: spend_currency_code
      comment: "Currency of spend figures for multi-currency normalisation."
  measures:
    - name: "total_impressions_delivered"
      expr: SUM(CAST(impressions_delivered AS DOUBLE))
      comment: "Total ad impressions delivered; measures campaign reach and media execution scale."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks generated; primary engagement signal for performance campaigns."
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions attributed to campaigns; directly tied to revenue and ROI outcomes."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to marketing campaigns; the primary financial outcome metric."
    - name: "total_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total marketing spend recorded; used to compute ROI and efficiency ratios."
    - name: "total_reach"
      expr: SUM(CAST(reach_count AS DOUBLE))
      comment: "Total unique audience reached; measures campaign penetration into target segments."
    - name: "total_email_sends"
      expr: SUM(CAST(email_send_count AS DOUBLE))
      comment: "Total emails sent across campaigns; baseline for email channel performance analysis."
    - name: "total_email_opens"
      expr: SUM(CAST(email_open_count AS DOUBLE))
      comment: "Total email opens; measures audience engagement with email content."
    - name: "total_video_views"
      expr: SUM(CAST(video_view_count AS DOUBLE))
      comment: "Total video views; measures video content consumption and brand awareness."
    - name: "avg_ctr_pct"
      expr: AVG(CAST(ctr_percent AS DOUBLE))
      comment: "Average click-through rate across performance records; benchmarks creative and targeting effectiveness."
    - name: "avg_conversion_rate_pct"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate; key efficiency metric linking engagement to business outcomes."
    - name: "avg_roas"
      expr: AVG(CAST(roas_ratio AS DOUBLE))
      comment: "Average return on ad spend; the primary profitability metric for paid media investment decisions."
    - name: "avg_cpa"
      expr: AVG(CAST(cpa_amount AS DOUBLE))
      comment: "Average cost per acquisition; used to evaluate campaign efficiency and set bidding strategies."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm_amount AS DOUBLE))
      comment: "Average cost per thousand impressions; benchmarks media buying efficiency across channels."
    - name: "avg_email_open_rate_pct"
      expr: AVG(CAST(email_open_rate_percent AS DOUBLE))
      comment: "Average email open rate; measures email channel health and subject-line effectiveness."
    - name: "avg_video_completion_rate_pct"
      expr: AVG(CAST(video_completion_rate_percent AS DOUBLE))
      comment: "Average video completion rate; indicates content quality and audience relevance for video campaigns."
    - name: "revenue_per_impression"
      expr: ROUND(SUM(CAST(attributed_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(impressions_delivered AS DOUBLE)), 0), 4)
      comment: "Revenue generated per impression delivered; compound efficiency metric for media investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_campaign_audience`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience targeting effectiveness metrics measuring reach, response, conversion, and cost efficiency across campaign-audience pairings."
  source: "`vibe_retail_v1`.`marketing`.`campaign_audience`"
  dimensions:
    - name: "campaign_audience_status"
      expr: campaign_audience_status
      comment: "Status of the campaign-audience pairing (active, paused, completed, suppressed)."
    - name: "targeting_role"
      expr: targeting_role
      comment: "Role of the audience in the campaign (primary, lookalike, suppression, control)."
    - name: "test_group_indicator"
      expr: test_group_indicator
      comment: "Flag indicating whether this audience is part of a test or control group."
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channel(s) for which this audience targeting applies."
    - name: "activation_start_date"
      expr: DATE_TRUNC('month', activation_start_date)
      comment: "Month bucket of audience activation start for trend analysis."
    - name: "personalization_strategy"
      expr: personalization_strategy
      comment: "Personalisation approach applied to this audience for creative and message optimisation."
  measures:
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated audience reach planned across campaign-audience pairings; informs media scale decisions."
    - name: "total_actual_reached"
      expr: SUM(CAST(actual_reached_count AS DOUBLE))
      comment: "Total audience members actually reached; measures execution fidelity against targeting plans."
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions generated from targeted audiences; directly tied to campaign ROI."
    - name: "total_responses"
      expr: SUM(CAST(response_count AS DOUBLE))
      comment: "Total audience responses (clicks, engagements) across campaign-audience pairings."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(revenue_attributed_amount AS DOUBLE))
      comment: "Total revenue attributed to campaign-audience pairings; primary financial outcome for audience strategy."
    - name: "total_budget_allocation"
      expr: SUM(CAST(budget_allocation_amount AS DOUBLE))
      comment: "Total budget allocated across campaign-audience pairings; used for spend efficiency analysis."
    - name: "avg_conversion_rate_pct"
      expr: AVG(CAST(conversion_rate_percent AS DOUBLE))
      comment: "Average conversion rate across audience pairings; benchmarks audience quality and targeting precision."
    - name: "avg_response_rate_pct"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate; measures audience engagement quality for targeting optimisation."
    - name: "avg_delivery_rate_pct"
      expr: AVG(CAST(delivery_rate_percent AS DOUBLE))
      comment: "Average message delivery rate; identifies suppression or deliverability issues affecting reach."
    - name: "avg_cost_per_acquisition"
      expr: AVG(CAST(cost_per_acquisition AS DOUBLE))
      comment: "Average cost per acquisition across audience pairings; key efficiency metric for audience investment decisions."
    - name: "avg_roas"
      expr: AVG(CAST(return_on_ad_spend AS DOUBLE))
      comment: "Average return on ad spend by audience pairing; identifies highest-value audience segments."
    - name: "reach_realisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_reached_count AS DOUBLE)) / NULLIF(SUM(CAST(estimated_reach AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated reach actually achieved; measures targeting execution quality."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_attribution_touchpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Multi-touch attribution analytics measuring touchpoint volume, conversion contribution, revenue attribution, and cost efficiency across channels and campaign interactions."
  source: "`vibe_retail_v1`.`marketing`.`attribution_touchpoint`"
  dimensions:
    - name: "touchpoint_type"
      expr: touchpoint_type
      comment: "Type of marketing touchpoint (impression, click, email_open, social_engagement, etc.)."
    - name: "channel_type"
      expr: channel_type
      comment: "Marketing channel associated with the touchpoint for cross-channel attribution analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type on which the touchpoint occurred (desktop, mobile, tablet) for device-mix analysis."
    - name: "conversion_event_flag"
      expr: conversion_event_flag
      comment: "Flag indicating whether this touchpoint resulted in a conversion event."
    - name: "is_view_through"
      expr: is_view_through
      comment: "Flag indicating whether this is a view-through (impression-only) touchpoint vs. a click-through."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source parameter identifying the traffic origin for campaign attribution."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium parameter identifying the marketing medium for attribution analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign parameter linking touchpoints to specific campaign initiatives."
    - name: "touchpoint_date"
      expr: DATE_TRUNC('month', CAST(touchpoint_timestamp AS DATE))
      comment: "Month bucket of touchpoint occurrence for trend and seasonality analysis."
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country of the touchpoint for geographic attribution analysis."
  measures:
    - name: "total_touchpoints"
      expr: COUNT(1)
      comment: "Total number of attribution touchpoints recorded; baseline volume metric for funnel analysis."
    - name: "total_converting_touchpoints"
      expr: COUNT(CASE WHEN conversion_event_flag = TRUE THEN 1 END)
      comment: "Number of touchpoints that resulted in a conversion; measures channel conversion contribution."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(conversion_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed across all touchpoints; primary financial outcome for attribution analysis."
    - name: "total_touchpoint_cost"
      expr: SUM(CAST(cost_per_touchpoint AS DOUBLE))
      comment: "Total cost of all touchpoints; used to compute channel-level ROI and efficiency."
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average time from first touchpoint to conversion; informs customer journey length and nurture strategy."
    - name: "conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_event_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of touchpoints that converted; measures channel and creative effectiveness."
    - name: "revenue_per_touchpoint"
      expr: ROUND(SUM(CAST(conversion_revenue_amount AS DOUBLE)) / NULLIF(COUNT(1), 0), 4)
      comment: "Average revenue generated per touchpoint; compound efficiency metric for channel investment decisions."
    - name: "unique_profiles_touched"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customer profiles touched; measures campaign reach at the individual level."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_media_buy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Paid media execution metrics covering spend efficiency, impression delivery, click performance, and viewability across media buys and placements."
  source: "`vibe_retail_v1`.`marketing`.`media_buy`"
  dimensions:
    - name: "buy_type"
      expr: buy_type
      comment: "Type of media buy (direct, programmatic, sponsorship, etc.) for investment mix analysis."
    - name: "buy_status"
      expr: buy_status
      comment: "Current status of the media buy (booked, live, completed, cancelled)."
    - name: "placement_type"
      expr: placement_type
      comment: "Ad placement type (banner, video, native, search) for creative format analysis."
    - name: "is_programmatic"
      expr: is_programmatic
      comment: "Flag indicating programmatic vs. direct media buying for cost and efficiency benchmarking."
    - name: "dsp_platform_name"
      expr: dsp_platform_name
      comment: "Demand-side platform used for programmatic buying; identifies platform-level performance differences."
    - name: "flight_start_date"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month bucket of media flight start for spend trend analysis."
    - name: "rate_currency_code"
      expr: rate_currency_code
      comment: "Currency of rate and spend figures for multi-currency normalisation."
  measures:
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned media spend across all buys; baseline for budget vs. actual analysis."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual media spend incurred; primary cost metric for paid media investment decisions."
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total impressions planned across media buys; measures intended reach scale."
    - name: "total_delivered_impressions"
      expr: SUM(CAST(delivered_impressions AS DOUBLE))
      comment: "Total impressions actually delivered; measures media execution fidelity."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks generated from media buys; primary engagement metric for performance media."
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions attributed to media buys; directly tied to ROI calculations."
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate AS DOUBLE))
      comment: "Average contracted media rate; benchmarks negotiation outcomes and buying efficiency."
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average ad viewability rate; measures media quality and brand safety compliance."
    - name: "impression_delivery_pct"
      expr: ROUND(100.0 * SUM(CAST(delivered_impressions AS DOUBLE)) / NULLIF(SUM(CAST(planned_impressions AS DOUBLE)), 0), 2)
      comment: "Percentage of planned impressions actually delivered; measures media vendor execution quality."
    - name: "spend_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(planned_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned spend actually incurred; identifies under- or over-delivery against media plans."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_media_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media planning metrics covering budget allocation across channels, reach and frequency targets, and cost efficiency benchmarks for media investment decisions."
  source: "`vibe_retail_v1`.`marketing`.`media_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the media plan (draft, approved, active, completed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the media plan."
    - name: "dsp_platform_name"
      expr: dsp_platform_name
      comment: "Primary DSP platform used for programmatic execution in this plan."
    - name: "flight_start_date"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month bucket of media plan flight start for planning cycle analysis."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of all budget figures in the media plan."
    - name: "geographic_targeting"
      expr: geographic_targeting
      comment: "Geographic scope of the media plan for regional investment analysis."
  measures:
    - name: "total_planned_budget"
      expr: SUM(CAST(total_planned_budget_amount AS DOUBLE))
      comment: "Total planned media budget across all plans; primary investment sizing metric."
    - name: "total_digital_budget"
      expr: SUM(CAST(display_budget_amount AS DOUBLE) + CAST(paid_social_budget_amount AS DOUBLE) + CAST(paid_search_budget_amount AS DOUBLE) + CAST(video_budget_amount AS DOUBLE))
      comment: "Total digital channel budget (display + social + search + video); measures digital investment mix."
    - name: "total_email_budget"
      expr: SUM(CAST(email_budget_amount AS DOUBLE))
      comment: "Total email channel budget allocation; benchmarks email investment relative to total spend."
    - name: "total_tv_budget"
      expr: SUM(CAST(tv_budget_amount AS DOUBLE))
      comment: "Total TV budget allocation; measures traditional broadcast investment scale."
    - name: "total_planned_reach"
      expr: SUM(CAST(planned_reach AS DOUBLE))
      comment: "Total planned unique audience reach across media plans; measures intended campaign scale."
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_total_impressions AS DOUBLE))
      comment: "Total planned impressions across all media plans; baseline for media scale decisions."
    - name: "avg_planned_frequency"
      expr: AVG(CAST(planned_frequency AS DOUBLE))
      comment: "Average planned ad frequency per person; informs creative fatigue and reach-frequency trade-off decisions."
    - name: "avg_target_cpa"
      expr: AVG(CAST(target_cpa AS DOUBLE))
      comment: "Average target cost per acquisition across media plans; benchmarks efficiency expectations."
    - name: "avg_target_roas"
      expr: AVG(CAST(target_roas AS DOUBLE))
      comment: "Average target return on ad spend across media plans; primary profitability benchmark for media investment."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing budget governance metrics covering total investment, channel allocation, spend utilisation, and remaining budget — essential for CFO and CMO financial oversight."
  source: "`vibe_retail_v1`.`marketing`.`marketing_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the marketing budget (draft, approved, active, closed)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the budget record."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (quarter/month) for in-year budget tracking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the budget for regional investment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of all budget figures for multi-currency normalisation."
    - name: "start_date"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month bucket of budget period start for trend analysis."
  measures:
    - name: "total_actual_spend_to_date"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual marketing spend incurred to date; measures budget consumption rate."
    - name: "total_committed_spend"
      expr: SUM(CAST(committed_spend AS DOUBLE))
      comment: "Total committed but not yet incurred spend; measures forward budget obligations."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget AS DOUBLE))
      comment: "Total remaining unspent budget; critical for in-flight reallocation decisions."
    - name: "total_digital_channel_budget"
      expr: SUM(CAST(digital_channel_budget AS DOUBLE))
      comment: "Total budget allocated to digital channels; measures digital investment share."
    - name: "total_influencer_marketing_budget"
      expr: SUM(CAST(influencer_marketing_budget AS DOUBLE))
      comment: "Total influencer marketing budget allocation; tracks emerging channel investment."
    - name: "total_agency_fees_budget"
      expr: SUM(CAST(agency_fees_budget AS DOUBLE))
      comment: "Total agency fees budget; measures external resource cost as a share of total marketing investment."
    - name: "avg_utilisation_pct"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average budget utilisation percentage across budget records; key financial efficiency KPI."
    - name: "avg_target_roi_pct"
      expr: AVG(CAST(target_roi_percentage AS DOUBLE))
      comment: "Average target ROI percentage across budgets; benchmarks expected return on marketing investment."
    - name: "total_target_revenue_goal"
      expr: SUM(CAST(target_revenue_goal AS DOUBLE))
      comment: "Total revenue goal associated with marketing budgets; links investment to expected business outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_conversion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion funnel metrics measuring event volume, revenue generation, time-to-convert, and new customer acquisition across channels and geographies."
  source: "`vibe_retail_v1`.`marketing`.`conversion_event`"
  dimensions:
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion event (purchase, lead, sign_up, download) for funnel stage analysis."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of the conversion event (confirmed, pending, reversed)."
    - name: "attributed_channel"
      expr: attributed_channel
      comment: "Marketing channel credited with the conversion for channel ROI analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type on which the conversion occurred for device-mix optimisation."
    - name: "is_new_customer"
      expr: is_new_customer
      comment: "Flag indicating whether the converting customer is new; measures customer acquisition vs. retention."
    - name: "is_omnichannel"
      expr: is_omnichannel
      comment: "Flag indicating whether the conversion involved multiple channels; measures omnichannel journey impact."
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country of the conversion event for geographic performance analysis."
    - name: "utm_source"
      expr: utm_source
      comment: "UTM source of the converting session for traffic source attribution."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium of the converting session for channel attribution."
    - name: "conversion_date"
      expr: DATE_TRUNC('month', CAST(conversion_timestamp AS DATE))
      comment: "Month bucket of conversion timestamp for trend and seasonality analysis."
  measures:
    - name: "total_conversions"
      expr: COUNT(1)
      comment: "Total number of conversion events; primary volume metric for funnel performance."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue_amount AS DOUBLE))
      comment: "Total revenue attributed to conversion events; primary financial outcome metric for marketing."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total value of all conversion events; measures aggregate business impact of marketing activity."
    - name: "new_customer_conversions"
      expr: COUNT(CASE WHEN is_new_customer = TRUE THEN 1 END)
      comment: "Number of conversions from new customers; measures customer acquisition effectiveness."
    - name: "avg_time_to_conversion_hours"
      expr: AVG(CAST(time_to_conversion_hours AS DOUBLE))
      comment: "Average time from first touch to conversion; informs nurture cadence and journey optimisation."
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average value per conversion event; benchmarks quality of conversions across channels."
    - name: "new_customer_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_new_customer = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conversions from new customers; measures acquisition vs. retention balance."
    - name: "unique_converting_profiles"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customer profiles that converted; measures unique customer acquisition volume."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_audience_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience segment portfolio metrics covering size, quality, reach accuracy, and engagement potential — used by marketing strategists to evaluate targeting asset quality."
  source: "`vibe_retail_v1`.`marketing`.`audience_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of audience segment (behavioural, demographic, lookalike, predictive) for strategy analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, archived, draft) for portfolio health monitoring."
    - name: "activation_status"
      expr: activation_status
      comment: "Whether the segment is currently activated on marketing channels."
    - name: "creation_method"
      expr: creation_method
      comment: "How the segment was created (rule-based, ML model, manual) for methodology analysis."
    - name: "consent_required_flag"
      expr: consent_required_flag
      comment: "Flag indicating whether consent is required to activate this segment; critical for compliance governance."
    - name: "exclusion_flag"
      expr: exclusion_flag
      comment: "Flag indicating whether this is a suppression/exclusion segment."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How often the segment membership is refreshed (daily, weekly, monthly)."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month bucket of segment effective start date for portfolio age analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of audience segments in the portfolio; baseline for targeting asset inventory."
    - name: "total_estimated_reach"
      expr: SUM(CAST(estimated_reach AS DOUBLE))
      comment: "Total estimated reach across all segments; measures aggregate addressable audience size."
    - name: "total_actual_reach"
      expr: SUM(CAST(actual_reach AS DOUBLE))
      comment: "Total actual reach achieved across segments; measures realised audience penetration."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average segment confidence score; measures overall quality of the targeting asset portfolio."
    - name: "avg_cltv"
      expr: AVG(CAST(average_cltv AS DOUBLE))
      comment: "Average customer lifetime value across segments; identifies highest-value audience pools for investment prioritisation."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(average_purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency across segments; measures engagement intensity of targeted audiences."
    - name: "avg_aov"
      expr: AVG(CAST(average_aov AS DOUBLE))
      comment: "Average order value across segments; benchmarks revenue quality of different audience pools."
    - name: "reach_realisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_reach AS DOUBLE)) / NULLIF(SUM(CAST(estimated_reach AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated reach actually achieved; measures segment data quality and activation effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_influencer_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Influencer marketing performance metrics covering reach, engagement, cost efficiency, and content delivery — used to evaluate influencer ROI and programme health."
  source: "`vibe_retail_v1`.`marketing`.`influencer_engagement`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of influencer engagement (sponsored_post, story, reel, review, event) for format analysis."
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the engagement (contracted, content_submitted, published, completed, cancelled)."
    - name: "approval_status"
      expr: approval_status
      comment: "Content approval status; measures compliance and review process efficiency."
    - name: "platform_name"
      expr: platform_name
      comment: "Social platform on which the influencer content was published for channel mix analysis."
    - name: "compensation_type"
      expr: compensation_type
      comment: "Compensation model (flat_fee, commission, gifting, hybrid) for cost structure analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the influencer engagement for financial reconciliation."
    - name: "ftc_disclosure_compliant_flag"
      expr: ftc_disclosure_compliant_flag
      comment: "Flag indicating FTC disclosure compliance; critical for regulatory risk monitoring."
    - name: "content_publish_date"
      expr: DATE_TRUNC('month', content_publish_date)
      comment: "Month bucket of content publication for trend and seasonality analysis."
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of influencer engagements; baseline volume metric for programme scale."
    - name: "total_actual_reach"
      expr: SUM(CAST(actual_reach_count AS DOUBLE))
      comment: "Total audience reach generated by influencer content; measures programme reach impact."
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions_count AS DOUBLE))
      comment: "Total impressions delivered by influencer content; measures content exposure scale."
    - name: "total_actual_engagement_count"
      expr: SUM(CAST(actual_engagement_count AS DOUBLE))
      comment: "Total engagement actions (likes, comments, shares) generated; measures content resonance."
    - name: "total_flat_fee_spend"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee payments to influencers; primary cost metric for influencer programme budgeting."
    - name: "total_gifting_value"
      expr: SUM(CAST(gifting_value_amount AS DOUBLE))
      comment: "Total value of product gifting to influencers; measures non-cash compensation investment."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across performance-based engagements; benchmarks incentive structure."
    - name: "cost_per_engagement"
      expr: ROUND(SUM(CAST(flat_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_engagement_count AS DOUBLE)), 0), 4)
      comment: "Cost per engagement action; compound efficiency metric for influencer investment decisions."
    - name: "cost_per_reach"
      expr: ROUND(SUM(CAST(flat_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_reach_count AS DOUBLE)), 0), 4)
      comment: "Cost per unique person reached; benchmarks influencer efficiency against paid media alternatives."
    - name: "ftc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ftc_disclosure_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of influencer engagements with FTC-compliant disclosures; critical regulatory risk KPI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_automation_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing automation programme metrics covering enrolment volume, conversion rates, message engagement, and journey completion — used to optimise automated customer journeys."
  source: "`vibe_retail_v1`.`marketing`.`automation_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the automation enrolment (active, completed, exited, suppressed)."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source that triggered the enrolment (web, email, in-store, API) for journey entry analysis."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the customer was enrolled in the automation flow."
    - name: "enrollment_trigger_event"
      expr: enrollment_trigger_event
      comment: "Event that triggered the automation enrolment for journey design optimisation."
    - name: "conversion_flag"
      expr: conversion_flag
      comment: "Flag indicating whether the enrolled profile converted during the automation journey."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Flag indicating whether the enrolment was suppressed; measures suppression list impact."
    - name: "consent_status"
      expr: consent_status
      comment: "Consent status of the enrolled profile; critical for compliance governance."
    - name: "enrollment_date"
      expr: DATE_TRUNC('month', CAST(enrollment_timestamp AS DATE))
      comment: "Month bucket of enrolment timestamp for trend and cohort analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total automation enrolments; baseline volume metric for programme reach."
    - name: "total_conversions"
      expr: COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END)
      comment: "Total conversions generated through automation journeys; primary outcome metric."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value_amount AS DOUBLE))
      comment: "Total revenue value generated from automation conversions; measures programme financial impact."
    - name: "conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled profiles that converted; primary effectiveness KPI for automation programmes."
    - name: "suppression_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN suppression_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolments suppressed; measures list hygiene and consent compliance impact."
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value_amount AS DOUBLE))
      comment: "Average conversion value per enrolled profile; benchmarks journey quality and audience value."
    - name: "unique_profiles_enrolled"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customer profiles enrolled; measures unique audience penetration of automation programmes."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_automation_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Automation flow programme health metrics covering enrolment scale, completion rates, and goal achievement — used by marketing operations to optimise journey design."
  source: "`vibe_retail_v1`.`marketing`.`automation_flow`"
  dimensions:
    - name: "flow_status"
      expr: flow_status
      comment: "Current operational status of the automation flow (active, paused, draft, archived)."
    - name: "flow_type"
      expr: flow_type
      comment: "Type of automation flow (welcome, nurture, win-back, post-purchase) for programme categorisation."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary communication channel used in the automation flow."
    - name: "consent_required_flag"
      expr: consent_required_flag
      comment: "Flag indicating whether consent is required for this flow; critical for compliance governance."
    - name: "test_mode_flag"
      expr: test_mode_flag
      comment: "Flag indicating whether the flow is in test mode; filters live vs. test programme analysis."
    - name: "activation_date"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month bucket of flow activation date for programme lifecycle analysis."
  measures:
    - name: "total_flows"
      expr: COUNT(1)
      comment: "Total number of automation flows in the programme portfolio; baseline inventory metric."
    - name: "total_enrolled"
      expr: SUM(CAST(total_enrolled_count AS DOUBLE))
      comment: "Total profiles enrolled across all automation flows; measures programme reach scale."
    - name: "total_active_enrolled"
      expr: SUM(CAST(active_enrolled_count AS DOUBLE))
      comment: "Total profiles currently active in automation flows; measures live programme engagement."
    - name: "total_completed"
      expr: SUM(CAST(completed_count AS DOUBLE))
      comment: "Total profiles that completed automation flows; measures journey completion scale."
    - name: "total_goal_achieved"
      expr: SUM(CAST(goal_achieved_count AS DOUBLE))
      comment: "Total profiles that achieved the flow goal; primary outcome metric for automation programme effectiveness."
    - name: "goal_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(goal_achieved_count AS DOUBLE)) / NULLIF(SUM(CAST(total_enrolled_count AS DOUBLE)), 0), 2)
      comment: "Percentage of enrolled profiles that achieved the flow goal; key effectiveness KPI for journey optimisation."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(completed_count AS DOUBLE)) / NULLIF(SUM(CAST(total_enrolled_count AS DOUBLE)), 0), 2)
      comment: "Percentage of enrolled profiles that completed the full automation journey; measures journey design quality."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_ab_test_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B test campaign analytics measuring test scale, statistical significance, lift, and winning variant identification — used by marketing scientists and strategists to drive evidence-based decisions."
  source: "`vibe_retail_v1`.`marketing`.`campaign`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the test; ensures governance before test launch."
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of A/B tests conducted; baseline metric for experimentation programme scale."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_opt_in_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing consent and opt-in metrics covering opt-in volume, compliance rates, and suppression — critical for regulatory compliance (GDPR, CCPA, CAN-SPAM) and addressable audience governance."
  source: "`vibe_retail_v1`.`marketing`.`opt_in_record`"
  dimensions:
    - name: "opt_in_status"
      expr: opt_in_status
      comment: "Current opt-in status (opted_in, opted_out, pending, expired) for consent portfolio analysis."
    - name: "opt_in_source"
      expr: opt_in_source
      comment: "Source through which the opt-in was captured (web, in-store, email, app) for acquisition channel analysis."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Flag indicating double opt-in confirmation; measures consent quality and regulatory compliance."
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "Flag indicating GDPR compliance of the consent record; critical for EU regulatory risk monitoring."
    - name: "ccpa_compliant_flag"
      expr: ccpa_compliant_flag
      comment: "Flag indicating CCPA compliance; critical for California privacy regulation monitoring."
    - name: "can_spam_compliant_flag"
      expr: can_spam_compliant_flag
      comment: "Flag indicating CAN-SPAM compliance for email marketing regulatory governance."
    - name: "suppression_list_flag"
      expr: suppression_list_flag
      comment: "Flag indicating the record is on a suppression list; measures suppressed audience volume."
    - name: "opt_in_date"
      expr: DATE_TRUNC('month', CAST(opt_in_timestamp AS DATE))
      comment: "Month bucket of opt-in timestamp for consent acquisition trend analysis."
  measures:
    - name: "total_opt_in_records"
      expr: COUNT(1)
      comment: "Total consent records; baseline metric for addressable audience governance."
    - name: "total_opted_in"
      expr: COUNT(CASE WHEN opt_in_status = 'opted_in' THEN 1 END)
      comment: "Total active opt-in records; measures addressable marketing audience size."
    - name: "total_opted_out"
      expr: COUNT(CASE WHEN opt_in_status = 'opted_out' THEN 1 END)
      comment: "Total opt-out records; measures audience attrition and consent health."
    - name: "total_suppressed"
      expr: COUNT(CASE WHEN suppression_list_flag = TRUE THEN 1 END)
      comment: "Total suppressed records; measures compliance-driven audience exclusions."
    - name: "double_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of opt-ins confirmed via double opt-in; measures consent quality and regulatory risk mitigation."
    - name: "gdpr_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records that are GDPR-compliant; critical regulatory risk KPI for EU operations."
    - name: "opt_out_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_in_status = 'opted_out' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of records that have opted out; measures audience churn and communication fatigue."
    - name: "unique_opted_in_profiles"
      expr: COUNT(DISTINCT CASE WHEN opt_in_status = 'opted_in' THEN profile_id END)
      comment: "Number of distinct customer profiles with active opt-in consent; measures true addressable audience size."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_social_post`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social media performance metrics covering reach, engagement, content effectiveness, and paid amplification — used by social media managers and CMOs to steer organic and paid social strategy."
  source: "`vibe_retail_v1`.`marketing`.`social_post`"
  dimensions:
    - name: "platform"
      expr: platform
      comment: "Social media platform (Instagram, Facebook, TikTok, Twitter, LinkedIn) for channel mix analysis."
    - name: "post_type"
      expr: post_type
      comment: "Type of social post (image, video, carousel, story, reel) for content format performance analysis."
    - name: "post_status"
      expr: post_status
      comment: "Current status of the post (scheduled, published, archived, deleted)."
    - name: "is_boosted"
      expr: is_boosted
      comment: "Flag indicating whether the post was boosted with paid spend; separates organic vs. paid performance."
    - name: "target_country_codes"
      expr: target_country_codes
      comment: "Target country codes for geographic social performance analysis."
    - name: "publish_date"
      expr: DATE_TRUNC('month', CAST(actual_publish_timestamp AS DATE))
      comment: "Month bucket of post publication for trend and seasonality analysis."
  measures:
    - name: "total_posts"
      expr: COUNT(1)
      comment: "Total social posts published; baseline volume metric for content output measurement."
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total impressions across all social posts; measures content exposure scale."
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total unique audience reached by social content; measures brand awareness penetration."
    - name: "total_likes"
      expr: SUM(CAST(likes AS DOUBLE))
      comment: "Total likes across social posts; measures positive audience sentiment and content resonance."
    - name: "total_comments"
      expr: SUM(CAST(comments AS DOUBLE))
      comment: "Total comments across social posts; measures deep engagement and community interaction."
    - name: "total_shares"
      expr: SUM(CAST(shares AS DOUBLE))
      comment: "Total shares across social posts; measures viral amplification and organic reach extension."
    - name: "total_video_views"
      expr: SUM(CAST(video_views AS DOUBLE))
      comment: "Total video views across social posts; measures video content consumption."
    - name: "total_link_clicks"
      expr: SUM(CAST(link_clicks AS DOUBLE))
      comment: "Total link clicks from social posts; measures traffic generation effectiveness."
    - name: "total_boost_spend"
      expr: SUM(CAST(boost_budget_amount AS DOUBLE))
      comment: "Total paid boost spend on social posts; measures paid amplification investment."
    - name: "avg_engagement_rate"
      expr: AVG(CAST(engagement_rate AS DOUBLE))
      comment: "Average engagement rate across social posts; primary content effectiveness KPI for social strategy."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across social posts; measures brand perception and content tone effectiveness."
    - name: "cost_per_reach"
      expr: ROUND(SUM(CAST(boost_budget_amount AS DOUBLE)) / NULLIF(SUM(CAST(reach AS DOUBLE)), 0), 4)
      comment: "Cost per unique person reached via boosted posts; measures paid social efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`marketing_email_send`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Email marketing performance metrics tracking delivery, engagement, and conversion effectiveness"
  source: "`vibe_retail_v1`.`marketing`.`email_send`"
  dimensions:
    - name: "send_status"
      expr: send_status
      comment: "Status of the email send (scheduled, sending, completed, failed)"
    - name: "send_type"
      expr: send_type
      comment: "Type of email send (campaign, transactional, automated, test)"
    - name: "is_test_send"
      expr: is_test_send
      comment: "Flag indicating if this was a test send"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier"
    - name: "esp_platform_name"
      expr: esp_platform_name
      comment: "Email service provider platform name"
    - name: "suppression_list_applied"
      expr: suppression_list_applied
      comment: "Flag indicating if suppression list was applied"
  measures:
    - name: "total_sent_count"
      expr: SUM(CAST(sent_count AS BIGINT))
      comment: "Total number of emails sent"
    - name: "total_delivered_count"
      expr: SUM(CAST(delivered_count AS BIGINT))
      comment: "Total number of emails successfully delivered"
    - name: "total_open_count"
      expr: SUM(CAST(open_count AS BIGINT))
      comment: "Total number of email opens"
    - name: "total_unique_open_count"
      expr: SUM(CAST(unique_open_count AS BIGINT))
      comment: "Total number of unique email opens"
    - name: "total_click_count"
      expr: SUM(CAST(click_count AS BIGINT))
      comment: "Total number of email clicks"
    - name: "total_unique_click_count"
      expr: SUM(CAST(unique_click_count AS BIGINT))
      comment: "Total number of unique email clicks"
    - name: "total_bounce_count"
      expr: SUM(CAST(bounce_count AS BIGINT))
      comment: "Total number of bounced emails"
    - name: "total_hard_bounce_count"
      expr: SUM(CAST(hard_bounce_count AS BIGINT))
      comment: "Total number of hard bounces"
    - name: "total_unsubscribe_count"
      expr: SUM(CAST(unsubscribe_count AS BIGINT))
      comment: "Total number of unsubscribes"
    - name: "total_spam_complaint_count"
      expr: SUM(CAST(spam_complaint_count AS BIGINT))
      comment: "Total number of spam complaints"
    - name: "email_send_count"
      expr: COUNT(1)
      comment: "Number of email send jobs executed"
$$;