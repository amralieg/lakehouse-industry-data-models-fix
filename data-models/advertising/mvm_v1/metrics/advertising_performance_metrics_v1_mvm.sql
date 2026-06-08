-- Metric views for domain: performance | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_impression_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core impression delivery metrics providing visibility into ad exposure volume, media cost efficiency, viewability quality, and audience reach. These KPIs are foundational to evaluating campaign delivery health and media investment effectiveness."
  source: "`advertising_ecm`.`performance`.`impression_event`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier for grouping impressions by campaign to evaluate per-campaign delivery performance."
    - name: "flight_id"
      expr: flight_id
      comment: "Flight identifier enabling analysis of impression delivery within specific campaign flight windows."
    - name: "line_item_id"
      expr: line_item_id
      comment: "Line item identifier for granular delivery analysis at the line-item level."
    - name: "channel"
      expr: channel
      comment: "Advertising channel (e.g. display, video, social) for cross-channel performance comparison."
    - name: "device_type"
      expr: device_type
      comment: "Device type (desktop, mobile, tablet) for device-level audience and delivery analysis."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code for geographic segmentation of impression delivery."
    - name: "geo_region"
      expr: geo_region
      comment: "Geographic region for sub-national delivery analysis."
    - name: "impression_type"
      expr: impression_type
      comment: "Type of impression (e.g. display, video, native) for format-level performance breakdown."
    - name: "viewability_status"
      expr: viewability_status
      comment: "Viewability classification of the impression (viewable, non-viewable, unmeasured) for quality filtering."
    - name: "ad_position"
      expr: ad_position
      comment: "Position of the ad on the page (above-the-fold, below-the-fold) influencing viewability and engagement."
    - name: "content_category"
      expr: content_category
      comment: "Content category of the page where the impression was served, used for brand safety and contextual analysis."
    - name: "impression_date"
      expr: DATE_TRUNC('day', impression_timestamp)
      comment: "Daily bucketing of impression timestamps for time-series trend analysis."
    - name: "impression_month"
      expr: DATE_TRUNC('month', impression_timestamp)
      comment: "Monthly bucketing of impression timestamps for period-over-period reporting."
    - name: "publisher_id"
      expr: publisher_id
      comment: "Publisher identifier for evaluating delivery and quality metrics by publisher partner."
    - name: "programmatic_deal_id"
      expr: programmatic_deal_id
      comment: "Programmatic deal identifier for PMP and preferred deal performance analysis."
    - name: "is_bot_traffic"
      expr: is_bot_traffic
      comment: "Boolean flag indicating whether the impression was identified as bot/invalid traffic, used for quality filtering."
  measures:
    - name: "total_impressions"
      expr: COUNT(1)
      comment: "Total number of ad impressions served. The foundational delivery volume metric used in every campaign performance review and billing reconciliation."
    - name: "unique_users_reached"
      expr: COUNT(DISTINCT user_identifier)
      comment: "Count of distinct users reached by the campaign. Measures audience reach breadth, a primary campaign objective metric for brand and awareness campaigns."
    - name: "total_media_cost"
      expr: SUM(CAST(media_cost AS DOUBLE))
      comment: "Total media cost in the impression currency. Core investment metric used to track spend pacing, budget utilization, and cost efficiency across campaigns."
    - name: "avg_cpm"
      expr: AVG(CAST(bid_price_cpm AS DOUBLE))
      comment: "Average CPM (cost per thousand impressions) bid price. Indicates media pricing efficiency and competitiveness in auction environments."
    - name: "viewable_impressions"
      expr: SUM(CASE WHEN viewability_status = 'viewable' THEN 1 ELSE 0 END)
      comment: "Count of impressions classified as viewable per MRC standards. Directly tied to media quality and contractual viewability commitments."
    - name: "avg_viewability_percentage"
      expr: AVG(CAST(viewability_percentage AS DOUBLE))
      comment: "Average viewability percentage across all impressions. A key quality KPI used in agency-client reporting and vendor performance evaluation."
    - name: "avg_time_in_view_seconds"
      expr: AVG(CAST(time_in_view_seconds AS DOUBLE))
      comment: "Average time an ad was in view (seconds). Measures attention quality beyond binary viewability, informing creative and placement optimization decisions."
    - name: "avg_brand_safety_score"
      expr: AVG(CAST(brand_safety_score AS DOUBLE))
      comment: "Average brand safety score across impressions. Monitors brand risk exposure and informs publisher and content category exclusion decisions."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud/IVT score across impressions. Tracks invalid traffic risk, triggering investigation and vendor remediation when elevated."
    - name: "valid_impressions"
      expr: SUM(CASE WHEN is_bot_traffic = false THEN 1 ELSE 0 END)
      comment: "Count of impressions not flagged as bot traffic. Represents the clean, human-delivered impression volume used for quality-adjusted performance reporting."
    - name: "total_media_cost_valid_only"
      expr: SUM(CASE WHEN is_bot_traffic = false THEN media_cost ELSE 0 END)
      comment: "Total media cost attributable to non-bot impressions. Measures the effective spend on valid human traffic, informing IVT-adjusted cost efficiency."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_click_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Click performance metrics measuring user engagement, click quality, and cost efficiency. These KPIs drive optimization of creative, placement, and bidding strategies across campaigns."
  source: "`advertising_ecm`.`performance`.`click_event`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier for aggregating click performance at the campaign level."
    - name: "flight_id"
      expr: flight_id
      comment: "Flight identifier for click analysis within specific campaign flight periods."
    - name: "line_item_id"
      expr: line_item_id
      comment: "Line item identifier for granular click performance analysis."
    - name: "ad_id"
      expr: ad_id
      comment: "Ad identifier for creative-level click performance comparison."
    - name: "publisher_id"
      expr: publisher_id
      comment: "Publisher identifier for evaluating click quality and volume by publisher."
    - name: "device_type"
      expr: device_type
      comment: "Device type for cross-device click behavior analysis."
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country code for geographic click distribution analysis."
    - name: "click_interaction_type"
      expr: click_interaction_type
      comment: "Type of click interaction (e.g. standard click, engagement click) for interaction quality segmentation."
    - name: "click_source_platform"
      expr: click_source_platform
      comment: "Platform from which the click originated for cross-platform performance comparison."
    - name: "click_validation_status"
      expr: click_validation_status
      comment: "Validation status of the click (valid, invalid, suspicious) for quality-adjusted reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost-per-click financial analysis."
    - name: "click_date"
      expr: DATE_TRUNC('day', click_timestamp)
      comment: "Daily bucketing of click timestamps for time-series click trend analysis."
    - name: "click_month"
      expr: DATE_TRUNC('month', click_timestamp)
      comment: "Monthly bucketing of click timestamps for period-over-period reporting."
    - name: "conversion_attributed_flag"
      expr: conversion_attributed_flag
      comment: "Boolean flag indicating whether this click was attributed to a downstream conversion, enabling click-to-conversion path analysis."
  measures:
    - name: "total_clicks"
      expr: COUNT(1)
      comment: "Total number of click events recorded. The primary engagement volume metric used in campaign performance reporting and billing for CPC campaigns."
    - name: "valid_clicks"
      expr: SUM(CASE WHEN click_validation_status = 'valid' THEN 1 ELSE 0 END)
      comment: "Count of clicks passing validation checks. Represents clean, human-generated engagement used for quality-adjusted performance reporting."
    - name: "conversion_attributed_clicks"
      expr: SUM(CASE WHEN conversion_attributed_flag = true THEN 1 ELSE 0 END)
      comment: "Count of clicks that were attributed to a downstream conversion. Measures the click-to-conversion linkage rate, a key indicator of campaign effectiveness."
    - name: "total_cpc_cost"
      expr: SUM(CAST(cpc_rate AS DOUBLE))
      comment: "Total cost incurred from CPC-billed clicks. Core financial metric for CPC campaign budget management and cost efficiency analysis."
    - name: "avg_cpc_rate"
      expr: AVG(CAST(cpc_rate AS DOUBLE))
      comment: "Average cost per click. Benchmarks click pricing efficiency and informs bid strategy optimization decisions."
    - name: "avg_click_fraud_score"
      expr: AVG(CAST(click_fraud_score AS DOUBLE))
      comment: "Average fraud score across click events. Monitors click fraud risk exposure, triggering publisher remediation or traffic exclusion when elevated."
    - name: "unique_users_clicked"
      expr: COUNT(DISTINCT device_fingerprint)
      comment: "Count of distinct device fingerprints that generated clicks. Approximates unique user engagement, informing reach vs. frequency optimization."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_conversion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion performance metrics measuring campaign outcome effectiveness, revenue attribution, and conversion quality. These are the highest-value KPIs for evaluating ROI and campaign success against business objectives."
  source: "`advertising_ecm`.`performance`.`conversion_event`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier for attributing conversions and revenue to specific campaigns."
    - name: "flight_id"
      expr: flight_id
      comment: "Flight identifier for conversion analysis within specific campaign flight windows."
    - name: "line_item_id"
      expr: line_item_id
      comment: "Line item identifier for granular conversion attribution analysis."
    - name: "advertiser_id"
      expr: advertiser_id
      comment: "Advertiser identifier for cross-campaign conversion performance comparison by client."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand identifier for brand-level conversion and revenue attribution analysis."
    - name: "attribution_model_id"
      expr: attribution_model_id
      comment: "Attribution model identifier enabling comparison of conversion counts and values across different attribution methodologies."
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion event (e.g. purchase, lead, sign-up) for outcome-type segmentation."
    - name: "attribution_type"
      expr: attribution_type
      comment: "Attribution type (click-through, view-through) for understanding the conversion pathway."
    - name: "device_type"
      expr: device_type
      comment: "Device type on which the conversion occurred for cross-device conversion analysis."
    - name: "geo_country"
      expr: geo_country
      comment: "Country where the conversion occurred for geographic revenue attribution."
    - name: "product_category"
      expr: product_category
      comment: "Product category associated with the conversion for category-level revenue analysis."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of the conversion record (confirmed, pending, rejected) for data quality filtering."
    - name: "conversion_currency"
      expr: conversion_currency
      comment: "Currency of the conversion value for multi-currency revenue reporting."
    - name: "is_duplicate"
      expr: is_duplicate
      comment: "Boolean flag identifying duplicate conversion records, enabling deduplication-adjusted reporting."
    - name: "conversion_date"
      expr: DATE_TRUNC('day', conversion_timestamp)
      comment: "Daily bucketing of conversion timestamps for time-series conversion trend analysis."
    - name: "conversion_month"
      expr: DATE_TRUNC('month', conversion_timestamp)
      comment: "Monthly bucketing of conversion timestamps for period-over-period revenue reporting."
  measures:
    - name: "total_conversions"
      expr: COUNT(1)
      comment: "Total number of conversion events recorded. The primary campaign outcome metric used in performance reporting, client billing, and ROI calculation."
    - name: "unique_converting_users"
      expr: COUNT(DISTINCT user_identifier)
      comment: "Count of distinct users who converted. Measures the breadth of campaign-driven customer acquisition, a key metric for brand growth and CRM strategy."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total attributed revenue value from all conversions. The primary revenue attribution metric used in ROI analysis, client reporting, and campaign investment justification."
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average value per conversion event. Benchmarks conversion quality and informs bid strategy — higher average values justify higher CPAs."
    - name: "clean_conversions"
      expr: SUM(CASE WHEN is_duplicate = false AND conversion_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Count of non-duplicate, confirmed conversions. Represents the quality-adjusted conversion volume used for accurate performance reporting and client billing."
    - name: "clean_conversion_value"
      expr: SUM(CASE WHEN is_duplicate = false AND conversion_status = 'confirmed' THEN conversion_value ELSE 0 END)
      comment: "Total revenue from non-duplicate, confirmed conversions. The quality-adjusted revenue figure used for accurate ROI reporting and advertiser billing reconciliation."
    - name: "avg_fraud_score_conversions"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score across conversion events. Monitors conversion fraud risk, which directly impacts advertiser billing accuracy and campaign ROI integrity."
    - name: "view_through_conversions"
      expr: SUM(CASE WHEN attribution_type = 'view_through' THEN 1 ELSE 0 END)
      comment: "Count of conversions attributed via view-through (impression-based) attribution. Measures the upper-funnel contribution of display advertising to downstream conversions."
    - name: "click_through_conversions"
      expr: SUM(CASE WHEN attribution_type = 'click_through' THEN 1 ELSE 0 END)
      comment: "Count of conversions attributed via click-through attribution. Measures direct response effectiveness of ad clicks in driving campaign outcomes."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_delivery_pacing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign delivery pacing metrics monitoring spend and impression delivery against plan. These operational KPIs are critical for identifying under- or over-delivery risks, enabling real-time budget reallocation and campaign optimization."
  source: "`advertising_ecm`.`performance`.`delivery_pacing`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier for monitoring delivery pacing at the campaign level."
    - name: "flight_id"
      expr: flight_id
      comment: "Flight identifier for pacing analysis within specific campaign flight windows."
    - name: "line_item_id"
      expr: line_item_id
      comment: "Line item identifier for granular pacing monitoring at the line-item level."
    - name: "media_placement_id"
      expr: media_placement_id
      comment: "Media placement identifier for placement-level delivery pacing analysis."
    - name: "pacing_status"
      expr: pacing_status
      comment: "Current pacing status (on-track, under-delivering, over-delivering) for operational triage and prioritization."
    - name: "pacing_granularity"
      expr: pacing_granularity
      comment: "Granularity of the pacing measurement (hourly, daily, weekly) for appropriate time-window analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (even, accelerated, front-loaded) for pacing strategy analysis."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of pacing alerts (critical, warning, info) for operational prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial pacing analysis."
    - name: "pacing_alert_triggered"
      expr: pacing_alert_triggered
      comment: "Boolean flag indicating whether a pacing alert was triggered, used to filter and count at-risk line items."
    - name: "frequency_cap_reached"
      expr: frequency_cap_reached
      comment: "Boolean flag indicating frequency cap was reached, which may explain under-delivery."
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Daily bucketing of pacing measurement timestamps for trend analysis."
  measures:
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total actual impressions delivered across all pacing records. Core delivery volume metric for reconciling against planned impression commitments."
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total planned impressions across all pacing records. The delivery commitment baseline used to calculate delivery variance and pacing health."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend amount across all pacing records. Core financial metric for budget utilization monitoring and client billing reconciliation."
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned spend amount across all pacing records. The budget commitment baseline used to calculate spend variance and financial pacing health."
    - name: "avg_impression_pacing_percentage"
      expr: AVG(CAST(impression_pacing_percentage AS DOUBLE))
      comment: "Average impression pacing percentage (actual vs. planned). The primary pacing health KPI — values significantly below 100% signal under-delivery risk requiring immediate intervention."
    - name: "avg_spend_pacing_percentage"
      expr: AVG(CAST(spend_pacing_percentage AS DOUBLE))
      comment: "Average spend pacing percentage (actual vs. planned). Monitors budget burn rate against plan, enabling proactive budget reallocation before flight end."
    - name: "avg_effective_cpm"
      expr: AVG(CAST(effective_cpm AS DOUBLE))
      comment: "Average effective CPM across pacing records. Measures realized media cost efficiency, benchmarked against planned CPM to identify pricing variance."
    - name: "avg_effective_cpa"
      expr: AVG(CAST(effective_cpa AS DOUBLE))
      comment: "Average effective cost per acquisition across pacing records. The primary efficiency KPI for performance campaigns, directly tied to advertiser ROI targets."
    - name: "avg_bid_win_rate"
      expr: AVG(CAST(bid_win_rate AS DOUBLE))
      comment: "Average bid win rate across pacing records. Low win rates explain under-delivery and trigger bid price or targeting adjustments."
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate across pacing records. Monitors delivery quality against viewability commitments, informing placement optimization."
    - name: "pacing_alert_count"
      expr: SUM(CASE WHEN pacing_alert_triggered = true THEN 1 ELSE 0 END)
      comment: "Count of pacing records where an alert was triggered. Operational metric for identifying the number of at-risk line items requiring immediate attention."
    - name: "total_conversion_count"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversion count from pacing records. Provides a campaign-level conversion volume view aligned with delivery pacing context for CPA optimization."
    - name: "avg_inventory_availability_score"
      expr: AVG(CAST(inventory_availability_score AS DOUBLE))
      comment: "Average inventory availability score. Low scores indicate supply constraints that may cause under-delivery, informing targeting expansion or deal renegotiation."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across pacing records. Composite quality indicator used to balance delivery speed against inventory quality in optimization decisions."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_video_completion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Video advertising performance metrics measuring completion rates, viewer engagement depth, and video quality. These KPIs are essential for evaluating video campaign effectiveness and optimizing creative and placement strategies."
  source: "`advertising_ecm`.`performance`.`video_completion_event`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier for video performance analysis at the campaign level."
    - name: "flight_id"
      expr: flight_id
      comment: "Flight identifier for video performance analysis within specific campaign flight windows."
    - name: "line_item_id"
      expr: line_item_id
      comment: "Line item identifier for granular video performance analysis."
    - name: "ad_id"
      expr: ad_id
      comment: "Ad identifier for creative-level video performance comparison."
    - name: "publisher_id"
      expr: publisher_id
      comment: "Publisher identifier for evaluating video completion quality by publisher."
    - name: "completion_quartile"
      expr: completion_quartile
      comment: "Video completion quartile (Q1=25%, Q2=50%, Q3=75%, Q4=100%) for engagement depth analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type for cross-device video engagement analysis."
    - name: "video_format"
      expr: video_format
      comment: "Video format (in-stream, out-stream, rewarded) for format-level performance comparison."
    - name: "video_position"
      expr: video_position
      comment: "Video ad position (pre-roll, mid-roll, post-roll) for position-level completion rate analysis."
    - name: "is_skipped"
      expr: is_skipped
      comment: "Boolean flag indicating whether the video was skipped, enabling skip rate analysis."
    - name: "is_viewable"
      expr: is_viewable
      comment: "Boolean flag indicating whether the video impression was viewable per MRC standards."
    - name: "is_autoplay"
      expr: is_autoplay
      comment: "Boolean flag indicating autoplay vs. user-initiated playback, which significantly impacts completion rate benchmarks."
    - name: "content_category"
      expr: content_category
      comment: "Content category of the page/app where the video was served for contextual performance analysis."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code for geographic video performance analysis."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Daily bucketing of video completion event timestamps for time-series trend analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Monthly bucketing of video completion event timestamps for period-over-period reporting."
  measures:
    - name: "total_video_events"
      expr: COUNT(1)
      comment: "Total number of video completion events recorded. Baseline volume metric for video campaign delivery reporting."
    - name: "full_completions"
      expr: SUM(CASE WHEN completion_quartile = 'Q4' THEN 1 ELSE 0 END)
      comment: "Count of videos watched to 100% completion. The primary video engagement KPI used in client reporting and creative performance evaluation."
    - name: "skipped_videos"
      expr: SUM(CASE WHEN is_skipped = true THEN 1 ELSE 0 END)
      comment: "Count of video ads that were skipped by the user. High skip counts signal creative relevance issues and inform creative optimization decisions."
    - name: "viewable_video_events"
      expr: SUM(CASE WHEN is_viewable = true THEN 1 ELSE 0 END)
      comment: "Count of video events where the ad was viewable per MRC standards. Measures quality-adjusted video delivery against viewability commitments."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average video completion percentage across all events. Measures average viewer engagement depth, a key creative effectiveness indicator."
    - name: "avg_video_duration_seconds"
      expr: AVG(CAST(video_duration_seconds AS DOUBLE))
      comment: "Average video creative duration in seconds. Contextualizes completion rates — longer videos typically have lower completion rates."
    - name: "avg_time_to_completion_seconds"
      expr: AVG(CAST(time_to_completion_seconds AS DOUBLE))
      comment: "Average time to video completion in seconds. Measures actual viewer engagement time, informing optimal video length decisions."
    - name: "avg_viewable_percentage"
      expr: AVG(CAST(viewable_percentage AS DOUBLE))
      comment: "Average viewable percentage across video events. Monitors video viewability quality, informing placement and player size optimization."
    - name: "sound_on_completions"
      expr: SUM(CASE WHEN is_sound_on = true AND completion_quartile = 'Q4' THEN 1 ELSE 0 END)
      comment: "Count of full video completions with sound on. Measures high-quality, fully engaged video views — the gold standard for video brand impact measurement."
    - name: "avg_skip_offset_seconds"
      expr: AVG(CAST(skip_offset_seconds AS DOUBLE))
      comment: "Average number of seconds before the skip button appeared. Contextualizes skip behavior — shorter skip offsets correlate with higher skip rates."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_viewability_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewability quality metrics providing a dedicated measurement layer for MRC-compliant viewability reporting. These KPIs are critical for validating media quality, fulfilling contractual viewability guarantees, and optimizing placement strategies."
  source: "`advertising_ecm`.`performance`.`viewability_measurement`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier for campaign-level viewability quality reporting."
    - name: "flight_id"
      expr: flight_id
      comment: "Flight identifier for viewability analysis within specific campaign flight windows."
    - name: "line_item_id"
      expr: line_item_id
      comment: "Line item identifier for granular viewability performance analysis."
    - name: "publisher_id"
      expr: publisher_id
      comment: "Publisher identifier for evaluating viewability performance by publisher partner."
    - name: "media_placement_id"
      expr: media_placement_id
      comment: "Media placement identifier for placement-level viewability analysis."
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (display, video, native) for format-level viewability benchmarking."
    - name: "device_type"
      expr: device_type
      comment: "Device type for cross-device viewability analysis."
    - name: "environment"
      expr: environment
      comment: "Environment (web, app, CTV) for environment-level viewability benchmarking."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Viewability measurement methodology (e.g. Active View, MOAT, IAS) for methodology comparison."
    - name: "viewability_standard"
      expr: viewability_standard
      comment: "Viewability standard applied (MRC, GROUPM, custom) for standard-level compliance reporting."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the viewability measurement record for data quality filtering."
    - name: "mrc_compliant_flag"
      expr: mrc_compliant_flag
      comment: "Boolean flag indicating MRC compliance of the measurement, used for regulatory and contractual compliance reporting."
    - name: "invalid_traffic_flag"
      expr: invalid_traffic_flag
      comment: "Boolean flag indicating invalid traffic detection, used for IVT-adjusted viewability reporting."
    - name: "viewability_guaranteed_io_flag"
      expr: viewability_guaranteed_io_flag
      comment: "Boolean flag indicating whether the impression is under a viewability-guaranteed IO, enabling contractual compliance monitoring."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the viewability measurement for time-series viewability trend analysis."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Monthly bucketing of measurement timestamps for period-over-period viewability reporting."
  measures:
    - name: "total_measured_impressions"
      expr: SUM(CAST(measurable_impression_count AS DOUBLE))
      comment: "Total number of impressions that were measurable for viewability. Denominator for viewability rate calculations and measurability reporting."
    - name: "total_viewable_impressions"
      expr: SUM(CAST(viewable_impression_count AS DOUBLE))
      comment: "Total number of viewable impressions. Core viewability delivery metric used in client reporting and contractual compliance verification."
    - name: "total_impressions_measured"
      expr: SUM(CAST(total_impression_count AS DOUBLE))
      comment: "Total impression count across all viewability measurement records. Used as the universe denominator for measurability rate calculations."
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate across all measurement records. The primary viewability KPI used in agency-client reporting, vendor scorecards, and IO compliance monitoring."
    - name: "avg_measurability_rate"
      expr: AVG(CAST(measurability_rate AS DOUBLE))
      comment: "Average measurability rate (measurable impressions / total impressions). Low measurability rates indicate technical issues with viewability tagging or publisher cooperation."
    - name: "avg_in_view_percentage"
      expr: AVG(CAST(in_view_percentage AS DOUBLE))
      comment: "Average in-view percentage across measurement records. Measures the proportion of the ad that was visible on screen, informing creative size and placement optimization."
    - name: "avg_time_in_view_seconds"
      expr: AVG(CAST(time_in_view_seconds AS DOUBLE))
      comment: "Average time the ad was in view (seconds). Measures attention quality beyond binary viewability, a premium metric for brand impact campaigns."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of viewability measurements. Monitors measurement reliability, flagging low-quality data that could distort viewability reporting."
    - name: "guaranteed_viewability_threshold_avg"
      expr: AVG(CAST(guaranteed_viewability_threshold AS DOUBLE))
      comment: "Average guaranteed viewability threshold across measurement records. Contextualizes actual viewability rates against contractual commitments for compliance monitoring."
    - name: "invalid_traffic_impression_count"
      expr: SUM(CASE WHEN invalid_traffic_flag = true THEN total_impression_count ELSE 0 END)
      comment: "Total impressions flagged as invalid traffic. Measures IVT exposure volume, informing publisher remediation and media quality investment decisions."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI target governance metrics enabling tracking of performance commitments, contractual obligations, and target attainment thresholds. These metrics are used in executive reporting to monitor whether campaigns are on track to meet agreed KPI targets."
  source: "`advertising_ecm`.`performance`.`performance_kpi_target`"
  dimensions:
    - name: "campaign_id"
      expr: campaign_id
      comment: "Campaign identifier for monitoring KPI targets at the campaign level."
    - name: "flight_id"
      expr: flight_id
      comment: "Flight identifier for KPI target analysis within specific campaign flight windows."
    - name: "line_item_id"
      expr: line_item_id
      comment: "Line item identifier for granular KPI target monitoring."
    - name: "kpi_type"
      expr: kpi_type
      comment: "Type of KPI being targeted (e.g. CTR, CPA, ROAS, viewability rate) for KPI-category analysis."
    - name: "target_status"
      expr: target_status
      comment: "Current status of the KPI target (active, paused, completed, breached) for operational monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the KPI target for triage and escalation prioritization."
    - name: "target_unit"
      expr: target_unit
      comment: "Unit of the KPI target (percentage, currency, count) for appropriate target comparison."
    - name: "target_currency_code"
      expr: target_currency_code
      comment: "Currency code for financial KPI targets."
    - name: "is_contractual_commitment"
      expr: is_contractual_commitment
      comment: "Boolean flag indicating whether the KPI target is a contractual commitment, enabling prioritization of legally binding targets."
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used to measure the KPI for methodology-level target comparison."
    - name: "viewability_standard"
      expr: viewability_standard
      comment: "Viewability standard applied to viewability KPI targets for standard-level compliance reporting."
    - name: "target_period_start_date"
      expr: target_period_start_date
      comment: "Start date of the KPI target measurement period for time-bounded target analysis."
    - name: "target_period_end_date"
      expr: target_period_end_date
      comment: "End date of the KPI target measurement period for target expiry monitoring."
  measures:
    - name: "total_kpi_targets"
      expr: COUNT(1)
      comment: "Total number of KPI targets defined. Measures the scope of performance commitments across campaigns, used in governance and compliance reporting."
    - name: "contractual_kpi_targets"
      expr: SUM(CASE WHEN is_contractual_commitment = true THEN 1 ELSE 0 END)
      comment: "Count of KPI targets that are contractual commitments. Identifies legally binding performance obligations requiring priority monitoring and escalation."
    - name: "active_kpi_targets"
      expr: SUM(CASE WHEN target_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active KPI targets. Measures the live performance commitment portfolio requiring ongoing monitoring."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average KPI target value across all targets. Provides a benchmark of the performance bar set across campaigns, useful for portfolio-level ambition assessment."
    - name: "avg_lower_threshold"
      expr: AVG(CAST(lower_threshold AS DOUBLE))
      comment: "Average lower threshold across KPI targets. Represents the minimum acceptable performance floor, below which intervention is required."
    - name: "avg_upper_threshold"
      expr: AVG(CAST(upper_threshold AS DOUBLE))
      comment: "Average upper threshold across KPI targets. Represents the performance ceiling, above which over-delivery may trigger budget reallocation."
    - name: "avg_tolerance_percentage"
      expr: AVG(CAST(tolerance_percentage AS DOUBLE))
      comment: "Average tolerance percentage across KPI targets. Measures the acceptable variance band around targets, informing alert sensitivity calibration."
    - name: "alert_enabled_targets"
      expr: SUM(CASE WHEN alert_enabled = true THEN 1 ELSE 0 END)
      comment: "Count of KPI targets with alerting enabled. Measures the proportion of targets under active monitoring, identifying governance gaps where targets lack alerting."
$$;