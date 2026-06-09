-- Metric views for domain: performance | Business: Advertising | Version: 1 | Generated on: 2026-05-08 02:24:04

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_impression_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core impression delivery and viewability metrics for campaign performance analysis"
  source: "`advertising_ecm`.`performance`.`impression_event`"
  dimensions:
    - name: "impression_date"
      expr: DATE(impression_timestamp)
      comment: "Date of impression event for daily trend analysis"
    - name: "device_type"
      expr: device_type
      comment: "Device type (mobile, desktop, tablet, CTV) for cross-device analysis"
    - name: "channel"
      expr: channel
      comment: "Marketing channel (display, video, social, search) for channel mix analysis"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code for geographic performance analysis"
    - name: "viewability_status"
      expr: viewability_status
      comment: "Viewability classification (viewable, non-viewable, unmeasurable) for quality assessment"
    - name: "ad_position"
      expr: ad_position
      comment: "Ad position on page (above-fold, below-fold) for placement optimization"
    - name: "impression_type"
      expr: impression_type
      comment: "Type of impression (standard, video, rich-media) for format analysis"
    - name: "is_bot_traffic"
      expr: is_bot_traffic
      comment: "Bot traffic flag for invalid traffic filtering"
  measures:
    - name: "total_impressions"
      expr: COUNT(1)
      comment: "Total number of ad impressions delivered"
    - name: "total_media_cost"
      expr: SUM(CAST(media_cost AS DOUBLE))
      comment: "Total media spend across all impressions"
    - name: "viewable_impressions"
      expr: COUNT(CASE WHEN viewability_status = 'viewable' THEN 1 END)
      comment: "Count of impressions meeting viewability standard"
    - name: "avg_viewability_percentage"
      expr: AVG(CAST(viewability_percentage AS DOUBLE))
      comment: "Average percentage of ad pixels in view"
    - name: "avg_time_in_view_seconds"
      expr: AVG(CAST(time_in_view_seconds AS DOUBLE))
      comment: "Average time ad was visible on screen in seconds"
    - name: "avg_brand_safety_score"
      expr: AVG(CAST(brand_safety_score AS DOUBLE))
      comment: "Average brand safety score across impressions"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score for impression quality assessment"
    - name: "avg_bid_price_cpm"
      expr: AVG(CAST(bid_price_cpm AS DOUBLE))
      comment: "Average CPM bid price for cost benchmarking"
    - name: "unique_users"
      expr: COUNT(DISTINCT user_identifier)
      comment: "Unique user reach for audience deduplication"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_click_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Click engagement and interaction quality metrics for campaign optimization"
  source: "`advertising_ecm`.`performance`.`click_event`"
  dimensions:
    - name: "click_date"
      expr: DATE(click_timestamp)
      comment: "Date of click event for daily engagement trend analysis"
    - name: "device_type"
      expr: device_type
      comment: "Device type for cross-device click behavior analysis"
    - name: "click_interaction_type"
      expr: click_interaction_type
      comment: "Type of click interaction (standard, video-click, expand) for engagement quality"
    - name: "click_validation_status"
      expr: click_validation_status
      comment: "Click validation status (valid, invalid, suspicious) for quality filtering"
    - name: "conversion_attributed_flag"
      expr: conversion_attributed_flag
      comment: "Whether click led to attributed conversion for conversion path analysis"
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country code for geographic click performance"
  measures:
    - name: "total_clicks"
      expr: COUNT(1)
      comment: "Total number of click events"
    - name: "valid_clicks"
      expr: COUNT(CASE WHEN click_validation_status = 'valid' THEN 1 END)
      comment: "Count of validated legitimate clicks"
    - name: "clicks_with_conversion"
      expr: COUNT(CASE WHEN conversion_attributed_flag = TRUE THEN 1 END)
      comment: "Count of clicks that led to attributed conversions"
    - name: "avg_click_fraud_score"
      expr: AVG(CAST(click_fraud_score AS DOUBLE))
      comment: "Average fraud risk score for click quality assessment"
    - name: "avg_cpc_rate"
      expr: AVG(CAST(cpc_rate AS DOUBLE))
      comment: "Average cost per click for efficiency benchmarking"
    - name: "total_click_cost"
      expr: SUM(CAST(cpc_rate AS DOUBLE))
      comment: "Total cost of all clicks for budget tracking"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_conversion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conversion performance and revenue attribution metrics for ROI analysis"
  source: "`advertising_ecm`.`performance`.`conversion_event`"
  dimensions:
    - name: "conversion_date"
      expr: DATE(conversion_timestamp)
      comment: "Date of conversion event for daily conversion trend analysis"
    - name: "conversion_type"
      expr: conversion_type
      comment: "Type of conversion (purchase, lead, signup, download) for funnel analysis"
    - name: "attribution_type"
      expr: attribution_type
      comment: "Attribution model type (first-touch, last-touch, linear, data-driven) for credit allocation"
    - name: "device_type"
      expr: device_type
      comment: "Device type for cross-device conversion analysis"
    - name: "conversion_status"
      expr: conversion_status
      comment: "Conversion status (completed, pending, cancelled) for quality filtering"
    - name: "is_duplicate"
      expr: is_duplicate
      comment: "Duplicate flag for deduplication analysis"
    - name: "geo_country"
      expr: geo_country
      comment: "Country for geographic conversion performance"
    - name: "product_category"
      expr: product_category
      comment: "Product category for category-level conversion analysis"
  measures:
    - name: "total_conversions"
      expr: COUNT(1)
      comment: "Total number of conversion events"
    - name: "unique_conversions"
      expr: COUNT(CASE WHEN is_duplicate = FALSE THEN 1 END)
      comment: "Count of deduplicated unique conversions"
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total revenue or value generated from conversions"
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average order value or conversion value"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score for conversion quality assessment"
    - name: "unique_converters"
      expr: COUNT(DISTINCT user_identifier)
      comment: "Unique users who converted for customer acquisition tracking"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_delivery_pacing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign delivery pacing and budget utilization metrics for flight management"
  source: "`advertising_ecm`.`performance`.`delivery_pacing`"
  dimensions:
    - name: "measurement_date"
      expr: DATE(measurement_timestamp)
      comment: "Date of pacing measurement for daily tracking"
    - name: "pacing_status"
      expr: pacing_status
      comment: "Pacing status (on-track, under-delivering, over-delivering) for delivery health"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (even, ASAP, frontloaded) for pacing strategy analysis"
    - name: "pacing_alert_triggered"
      expr: pacing_alert_triggered
      comment: "Alert flag for campaigns requiring intervention"
    - name: "frequency_cap_reached"
      expr: frequency_cap_reached
      comment: "Frequency cap flag for reach saturation analysis"
  measures:
    - name: "total_actual_impressions"
      expr: SUM(CAST(actual_impressions AS DOUBLE))
      comment: "Total impressions delivered in period"
    - name: "total_planned_impressions"
      expr: SUM(CAST(planned_impressions AS DOUBLE))
      comment: "Total planned impressions for period"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total media spend in period"
    - name: "total_planned_spend"
      expr: SUM(CAST(planned_spend_amount AS DOUBLE))
      comment: "Total planned budget for period"
    - name: "avg_impression_pacing_pct"
      expr: AVG(CAST(impression_pacing_percentage AS DOUBLE))
      comment: "Average impression delivery pacing percentage vs plan"
    - name: "avg_spend_pacing_pct"
      expr: AVG(CAST(spend_pacing_percentage AS DOUBLE))
      comment: "Average spend pacing percentage vs budget"
    - name: "avg_bid_win_rate"
      expr: AVG(CAST(bid_win_rate AS DOUBLE))
      comment: "Average auction win rate for inventory competitiveness"
    - name: "avg_effective_cpm"
      expr: AVG(CAST(effective_cpm AS DOUBLE))
      comment: "Average effective CPM for cost efficiency benchmarking"
    - name: "avg_effective_cpa"
      expr: AVG(CAST(effective_cpa AS DOUBLE))
      comment: "Average effective cost per acquisition for ROI tracking"
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions in pacing period"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_rtb_bid_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time bidding auction performance and programmatic efficiency metrics"
  source: "`advertising_ecm`.`performance`.`rtb_bid_event`"
  dimensions:
    - name: "bid_date"
      expr: DATE(bid_timestamp)
      comment: "Date of bid event for daily auction trend analysis"
    - name: "bid_status"
      expr: bid_status
      comment: "Bid status (won, lost, timeout, error) for auction outcome analysis"
    - name: "bid_strategy"
      expr: bid_strategy
      comment: "Bidding strategy (fixed, dynamic, data-driven) for optimization analysis"
    - name: "win_indicator"
      expr: win_indicator
      comment: "Auction win flag for win rate calculation"
    - name: "device_type"
      expr: device_type
      comment: "Device type for device-level auction performance"
    - name: "inventory_type"
      expr: inventory_type
      comment: "Inventory type (open-exchange, PMP, programmatic-guaranteed) for supply path analysis"
    - name: "deal_type"
      expr: deal_type
      comment: "Deal type (open-auction, private-marketplace, preferred-deal) for deal performance"
    - name: "geo_country"
      expr: geo_country
      comment: "Country for geographic auction competitiveness"
  measures:
    - name: "total_bid_requests"
      expr: COUNT(1)
      comment: "Total number of bid requests received"
    - name: "total_bids_won"
      expr: COUNT(CASE WHEN win_indicator = TRUE THEN 1 END)
      comment: "Total number of auctions won"
    - name: "avg_bid_price_cpm"
      expr: AVG(CAST(bid_price_cpm AS DOUBLE))
      comment: "Average bid price CPM for bidding strategy benchmarking"
    - name: "avg_clearing_price_cpm"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE))
      comment: "Average winning auction clearing price for market pricing analysis"
    - name: "avg_floor_price_cpm"
      expr: AVG(CAST(floor_price_cpm AS DOUBLE))
      comment: "Average publisher floor price for inventory cost benchmarking"
    - name: "total_clearing_cost"
      expr: SUM(CAST(clearing_price_cpm AS DOUBLE))
      comment: "Total cost of won auctions for budget tracking"
    - name: "avg_supply_path_cost"
      expr: AVG(CAST(supply_path_cost AS DOUBLE))
      comment: "Average supply chain cost for SPO analysis"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_viewability_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRC-compliant viewability and ad quality metrics for media quality assurance"
  source: "`advertising_ecm`.`performance`.`viewability_measurement`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of viewability measurement for daily quality tracking"
    - name: "viewability_standard"
      expr: viewability_standard
      comment: "Viewability standard applied (MRC, GroupM, custom) for compliance reporting"
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format (display, video, native) for format-level quality analysis"
    - name: "device_type"
      expr: device_type
      comment: "Device type for cross-device viewability comparison"
    - name: "environment"
      expr: environment
      comment: "Environment (web, in-app, CTV) for environment-level quality"
    - name: "mrc_compliant_flag"
      expr: mrc_compliant_flag
      comment: "MRC compliance flag for accredited measurement filtering"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Measurement status (measured, unmeasured) for measurability analysis"
    - name: "invalid_traffic_flag"
      expr: invalid_traffic_flag
      comment: "IVT flag for traffic quality filtering"
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(total_impression_count AS DOUBLE))
      comment: "Total impressions measured for viewability"
    - name: "measurable_impressions"
      expr: SUM(CAST(measurable_impression_count AS DOUBLE))
      comment: "Total impressions that could be measured"
    - name: "viewable_impressions"
      expr: SUM(CAST(viewable_impression_count AS DOUBLE))
      comment: "Total impressions meeting viewability standard"
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate for quality benchmarking"
    - name: "avg_measurability_rate"
      expr: AVG(CAST(measurability_rate AS DOUBLE))
      comment: "Average measurability rate for measurement coverage"
    - name: "avg_in_view_percentage"
      expr: AVG(CAST(in_view_percentage AS DOUBLE))
      comment: "Average percentage of ad pixels in view"
    - name: "avg_time_in_view_seconds"
      expr: AVG(CAST(time_in_view_seconds AS DOUBLE))
      comment: "Average time ad was viewable in seconds"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for measurement reliability"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_ivt_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invalid traffic detection and ad fraud metrics for media quality protection"
  source: "`advertising_ecm`.`performance`.`ivt_classification`"
  dimensions:
    - name: "classification_date"
      expr: DATE(classification_timestamp)
      comment: "Date of IVT classification for daily fraud trend analysis"
    - name: "ivt_flag"
      expr: ivt_flag
      comment: "Invalid traffic flag for filtering fraudulent activity"
    - name: "ivt_type"
      expr: ivt_type
      comment: "IVT type (GIVT, SIVT) for fraud severity classification"
    - name: "ivt_category"
      expr: ivt_category
      comment: "IVT category (bot, data-center, click-farm) for fraud pattern analysis"
    - name: "detection_method"
      expr: detection_method
      comment: "Detection method (signature, behavioral, ML) for detection strategy analysis"
    - name: "mrc_compliant_flag"
      expr: mrc_compliant_flag
      comment: "MRC compliance flag for accredited fraud detection"
    - name: "chargeback_eligible_flag"
      expr: chargeback_eligible_flag
      comment: "Chargeback eligibility flag for financial recovery tracking"
    - name: "event_type"
      expr: event_type
      comment: "Event type (impression, click) for fraud distribution analysis"
  measures:
    - name: "total_events_classified"
      expr: COUNT(1)
      comment: "Total events classified for IVT"
    - name: "total_ivt_events"
      expr: COUNT(CASE WHEN ivt_flag = TRUE THEN 1 END)
      comment: "Total invalid traffic events detected"
    - name: "total_invalid_impressions"
      expr: SUM(CAST(invalid_impression_count AS DOUBLE))
      comment: "Total invalid impressions for fraud volume tracking"
    - name: "total_invalid_clicks"
      expr: SUM(CAST(invalid_click_count AS DOUBLE))
      comment: "Total invalid clicks for click fraud tracking"
    - name: "total_invalid_spend"
      expr: SUM(CAST(invalid_spend_amount AS DOUBLE))
      comment: "Total spend on invalid traffic for financial impact assessment"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average detection confidence score for classification reliability"
    - name: "avg_behavioral_anomaly_score"
      expr: AVG(CAST(behavioral_anomaly_score AS DOUBLE))
      comment: "Average behavioral anomaly score for SIVT risk assessment"
    - name: "chargeback_eligible_spend"
      expr: SUM(CASE WHEN chargeback_eligible_flag = TRUE THEN CAST(invalid_spend_amount AS DOUBLE) ELSE 0 END)
      comment: "Total spend eligible for chargeback recovery"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_video_completion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Video ad engagement and completion metrics for video campaign optimization"
  source: "`advertising_ecm`.`performance`.`video_completion_event`"
  dimensions:
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of video completion event for daily engagement trend analysis"
    - name: "completion_quartile"
      expr: completion_quartile
      comment: "Video completion quartile (25%, 50%, 75%, 100%) for engagement depth analysis"
    - name: "device_type"
      expr: device_type
      comment: "Device type for cross-device video performance"
    - name: "is_skipped"
      expr: is_skipped
      comment: "Skip flag for skip rate calculation"
    - name: "is_viewable"
      expr: is_viewable
      comment: "Viewability flag for viewable completion analysis"
    - name: "is_autoplay"
      expr: is_autoplay
      comment: "Autoplay flag for user-initiated vs autoplay comparison"
    - name: "is_sound_on"
      expr: is_sound_on
      comment: "Sound flag for audible completion analysis"
    - name: "player_size"
      expr: player_size
      comment: "Player size (small, medium, large, fullscreen) for player optimization"
    - name: "video_position"
      expr: video_position
      comment: "Video position (pre-roll, mid-roll, post-roll) for placement analysis"
  measures:
    - name: "total_video_events"
      expr: COUNT(1)
      comment: "Total video completion events tracked"
    - name: "completed_videos"
      expr: COUNT(CASE WHEN completion_quartile = '100%' THEN 1 END)
      comment: "Total videos completed to 100% for VCR calculation"
    - name: "skipped_videos"
      expr: COUNT(CASE WHEN is_skipped = TRUE THEN 1 END)
      comment: "Total videos skipped for skip rate calculation"
    - name: "viewable_completions"
      expr: COUNT(CASE WHEN is_viewable = TRUE AND completion_quartile = '100%' THEN 1 END)
      comment: "Total viewable completed videos for quality completion metric"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average video completion percentage for engagement depth"
    - name: "avg_time_to_completion_seconds"
      expr: AVG(CAST(time_to_completion_seconds AS DOUBLE))
      comment: "Average time to completion for engagement duration"
    - name: "avg_viewable_percentage"
      expr: AVG(CAST(viewable_percentage AS DOUBLE))
      comment: "Average viewable percentage during video play"
    - name: "avg_video_duration_seconds"
      expr: AVG(CAST(video_duration_seconds AS DOUBLE))
      comment: "Average video duration for creative length analysis"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_brand_safety_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand safety and content suitability metrics for brand protection and GARM compliance"
  source: "`advertising_ecm`.`performance`.`brand_safety_signal`"
  dimensions:
    - name: "signal_date"
      expr: DATE(signal_timestamp)
      comment: "Date of brand safety signal for daily risk trend analysis"
    - name: "blocking_action"
      expr: blocking_action
      comment: "Blocking action taken (blocked, allowed, flagged) for enforcement analysis"
    - name: "garm_suitability_tier"
      expr: garm_suitability_tier
      comment: "GARM suitability tier for industry-standard brand safety classification"
    - name: "adjacency_risk_level"
      expr: adjacency_risk_level
      comment: "Content adjacency risk level (low, medium, high) for risk segmentation"
    - name: "adult_content_flag"
      expr: adult_content_flag
      comment: "Adult content flag for category-level risk filtering"
    - name: "hate_speech_flag"
      expr: hate_speech_flag
      comment: "Hate speech flag for harmful content detection"
    - name: "violence_flag"
      expr: violence_flag
      comment: "Violence flag for violent content detection"
    - name: "misinformation_flag"
      expr: misinformation_flag
      comment: "Misinformation flag for fake news detection"
    - name: "viewability_status"
      expr: viewability_status
      comment: "Viewability status for quality-adjusted brand safety"
  measures:
    - name: "total_signals"
      expr: COUNT(1)
      comment: "Total brand safety signals evaluated"
    - name: "blocked_impressions"
      expr: COUNT(CASE WHEN blocking_action = 'blocked' THEN 1 END)
      comment: "Total impressions blocked for brand safety violations"
    - name: "high_risk_impressions"
      expr: COUNT(CASE WHEN adjacency_risk_level = 'high' THEN 1 END)
      comment: "Total high-risk impressions for risk exposure tracking"
    - name: "avg_brand_safety_score"
      expr: AVG(CAST(brand_safety_score AS DOUBLE))
      comment: "Average brand safety score for overall safety benchmarking"
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate for quality-adjusted safety metrics"
    - name: "adult_content_impressions"
      expr: COUNT(CASE WHEN adult_content_flag = TRUE THEN 1 END)
      comment: "Total impressions with adult content for category risk tracking"
    - name: "hate_speech_impressions"
      expr: COUNT(CASE WHEN hate_speech_flag = TRUE THEN 1 END)
      comment: "Total impressions with hate speech for harmful content tracking"
    - name: "misinformation_impressions"
      expr: COUNT(CASE WHEN misinformation_flag = TRUE THEN 1 END)
      comment: "Total impressions with misinformation for fake news exposure"
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`performance_auction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programmatic auction dynamics and supply-side performance metrics"
  source: "`advertising_ecm`.`performance`.`auction`"
  dimensions:
    - name: "auction_date"
      expr: DATE(auction_timestamp)
      comment: "Date of auction for daily auction trend analysis"
    - name: "auction_type"
      expr: auction_type
      comment: "Auction type (first-price, second-price, header-bidding) for auction mechanism analysis"
    - name: "auction_status"
      expr: auction_status
      comment: "Auction status (completed, timeout, error) for auction health monitoring"
    - name: "device_type"
      expr: device_type
      comment: "Device type for device-level auction performance"
    - name: "geo_country"
      expr: geo_country
      comment: "Country for geographic auction dynamics"
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format for format-level auction competitiveness"
  measures:
    - name: "total_auctions"
      expr: COUNT(1)
      comment: "Total number of auctions conducted"
    - name: "completed_auctions"
      expr: COUNT(CASE WHEN auction_status = 'completed' THEN 1 END)
      comment: "Total successfully completed auctions"
    - name: "avg_floor_price"
      expr: AVG(CAST(floor_price AS DOUBLE))
      comment: "Average auction floor price for publisher pricing strategy"
    - name: "avg_winning_bid_amount"
      expr: AVG(CAST(winning_bid_amount AS DOUBLE))
      comment: "Average winning bid amount for market clearing price analysis"
    - name: "total_winning_bid_value"
      expr: SUM(CAST(winning_bid_amount AS DOUBLE))
      comment: "Total value of winning bids for revenue tracking"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score for auction quality assessment"
    - name: "avg_viewability_prediction"
      expr: AVG(CAST(viewability_prediction AS DOUBLE))
      comment: "Average predicted viewability for pre-bid quality forecasting"
$$;