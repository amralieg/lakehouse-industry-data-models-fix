-- Metric views for domain: distribution | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_content_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order volume and size KPIs for content delivery"
  source: "`media_broadcasting_ecm`.`distribution`.`content_delivery_order`"
  dimensions:
    - name: "order_date_day"
      expr: DATE_TRUNC('day', order_date)
      comment: "Order date (day bucket)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the content"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of content delivery orders"
    - name: "total_file_size_gb"
      expr: SUM(CAST(file_size_gb AS DOUBLE))
      comment: "Sum of file sizes for all orders (GB)"
    - name: "avg_file_size_gb"
      expr: AVG(CAST(file_size_gb AS DOUBLE))
      comment: "Average file size per order (GB)"
    - name: "avg_approval_lead_time_seconds"
      expr: AVG(unix_timestamp(approved_timestamp) - unix_timestamp(order_date))
      comment: "Average time from order creation to approval (seconds)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad delivery performance and volume metrics"
  source: "`media_broadcasting_ecm`.`distribution`.`delivery_event`"
  dimensions:
    - name: "event_date_day"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Event date (day bucket)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used for the event"
    - name: "event_type"
      expr: event_type
      comment: "Type of delivery event"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total delivery events recorded"
    - name: "total_bytes_delivered"
      expr: SUM(CAST(bytes_delivered AS DOUBLE))
      comment: "Total bytes delivered across all events"
    - name: "avg_ad_fill_rate_percent"
      expr: AVG(CAST(ad_fill_rate_percent AS DOUBLE))
      comment: "Average ad fill rate percentage"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_subscriber_count_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber count reporting health and volume"
  source: "`media_broadcasting_ecm`.`distribution`.`subscriber_count_report`"
  dimensions:
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start date of the reporting period"
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End date of the reporting period"
    - name: "distribution_partner_id"
      expr: distribution_partner_id
      comment: "Partner responsible for the report"
    - name: "market_coverage_id"
      expr: market_coverage_id
      comment: "Market coverage identifier"
    - name: "channel_id"
      expr: channel_id
      comment: "Channel identifier"
  measures:
    - name: "total_reported_subscribers"
      expr: SUM(CAST(reported_subscriber_count AS DOUBLE))
      comment: "Total number of subscribers reported in the period"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across reports"
    - name: "count_reports"
      expr: COUNT(1)
      comment: "Number of subscriber count reports submitted"
    - name: "reports_with_variance"
      expr: SUM(CASE WHEN variance_flag THEN 1 ELSE 0 END)
      comment: "Count of reports where variance flag is true"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and status KPIs for distribution deals"
  source: "`media_broadcasting_ecm`.`distribution`.`deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the deal"
    - name: "deal_type"
      expr: deal_type
      comment: "Type/category of the deal"
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type the deal applies to"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the deal becomes effective"
  measures:
    - name: "total_deals"
      expr: COUNT(1)
      comment: "Total number of deals"
    - name: "sum_flat_fee_amount"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Sum of flat fee amounts across deals"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across deals"
    - name: "sum_minimum_guarantee_amount"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amount across deals"
    - name: "active_deals"
      expr: SUM(CASE WHEN effective_date <= current_date() AND expiration_date >= current_date() THEN 1 ELSE 0 END)
      comment: "Count of deals currently active"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_abr_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technical characteristics of Adaptive Bitrate profiles"
  source: "`media_broadcasting_ecm`.`distribution`.`abr_profile`"
  dimensions:
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used by the profile"
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used in the profile"
    - name: "audio_codec"
      expr: audio_codec
      comment: "Audio codec used in the profile"
    - name: "hdr_format"
      expr: hdr_format
      comment: "HDR format supported by the profile"
    - name: "profile_status"
      expr: profile_status
      comment: "Operational status of the profile"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the profile was created"
  measures:
    - name: "count_profiles"
      expr: COUNT(1)
      comment: "Number of ABR profiles defined"
    - name: "avg_frame_rate"
      expr: AVG(CAST(frame_rate AS DOUBLE))
      comment: "Average frame rate across ABR profiles"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_cdn_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and capacity KPIs for CDN configurations"
  source: "`media_broadcasting_ecm`.`distribution`.`cdn_configuration`"
  dimensions:
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN service provider"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the configuration"
    - name: "geo_blocking_enabled"
      expr: geo_blocking_enabled
      comment: "Whether geo‑blocking is enabled"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the CDN configuration was created"
  measures:
    - name: "count_configurations"
      expr: COUNT(1)
      comment: "Total CDN configurations"
    - name: "total_bandwidth_limit_gbps"
      expr: SUM(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Sum of bandwidth limits across configurations (Gbps)"
    - name: "avg_cost_per_gb"
      expr: AVG(CAST(cost_per_gb AS DOUBLE))
      comment: "Average cost per GB across CDN configurations"
    - name: "geo_blocking_enabled_count"
      expr: SUM(CASE WHEN geo_blocking_enabled THEN 1 ELSE 0 END)
      comment: "Number of configurations with geo‑blocking enabled"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_device_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capability and market reach metrics for device types"
  source: "`media_broadcasting_ecm`.`distribution`.`device_type`"
  dimensions:
    - name: "device_category"
      expr: device_category
      comment: "Category of the device (e.g., TV, Mobile)"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Device manufacturer"
    - name: "os_family"
      expr: os_family
      comment: "Operating system family"
    - name: "hdr_capable"
      expr: hdr_capable
      comment: "HDR capability flag"
    - name: "dai_supported"
      expr: dai_supported
      comment: "Dynamic ad insertion support flag"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the device type record was created"
  measures:
    - name: "count_devices"
      expr: COUNT(1)
      comment: "Total distinct device types recorded"
    - name: "avg_max_bitrate_mbps"
      expr: AVG(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Average maximum bitrate supported (Mbps)"
    - name: "avg_active_install_base"
      expr: AVG(CAST(active_install_base AS DOUBLE))
      comment: "Average active install base across device types"
    - name: "hdr_capable_count"
      expr: SUM(CASE WHEN hdr_capable THEN 1 ELSE 0 END)
      comment: "Number of device types that are HDR capable"
$$;