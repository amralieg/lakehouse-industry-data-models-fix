-- Metric views for domain: distribution | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core distribution delivery metrics tracking content delivery performance, quality, and audience reach across streaming endpoints and CDN infrastructure"
  source: "`media_broadcasting_ecm`.`distribution`.`delivery_event`"
  dimensions:
    - name: "delivery_technology"
      expr: delivery_technology
      comment: "Technology used for content delivery (e.g., HLS, DASH, progressive download)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used for delivery"
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence location serving the content"
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "Country code of the viewer location"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the viewer"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery event (success, failure, partial)"
    - name: "event_type"
      expr: event_type
      comment: "Type of delivery event (start, stop, error, heartbeat)"
    - name: "cdn_cache_status"
      expr: cdn_cache_status
      comment: "CDN cache hit/miss status"
    - name: "resolution"
      expr: resolution
      comment: "Video resolution delivered"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier for delivery"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was enabled for this delivery"
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of the delivery event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the delivery event"
  measures:
    - name: "total_delivery_events"
      expr: COUNT(1)
      comment: "Total number of delivery events"
    - name: "total_bytes_delivered"
      expr: SUM(CAST(bytes_delivered AS DOUBLE))
      comment: "Total bytes delivered across all events, key metric for bandwidth cost and infrastructure capacity planning"
    - name: "avg_bytes_per_delivery"
      expr: AVG(CAST(bytes_delivered AS DOUBLE))
      comment: "Average bytes delivered per event, indicates typical content size and quality"
    - name: "total_ad_fill_rate_pct"
      expr: AVG(CAST(ad_fill_rate_percent AS DOUBLE))
      comment: "Average ad fill rate percentage, critical revenue metric for ad-supported content"
    - name: "unique_delivery_channels"
      expr: COUNT(DISTINCT delivery_channel_id)
      comment: "Number of distinct delivery channels used, measures distribution breadth"
    - name: "unique_streaming_endpoints"
      expr: COUNT(DISTINCT streaming_endpoint_id)
      comment: "Number of distinct streaming endpoints used, measures infrastructure utilization"
    - name: "unique_cdn_nodes"
      expr: COUNT(DISTINCT cdn_node_code)
      comment: "Number of distinct CDN nodes serving content, measures geographic distribution efficiency"
    - name: "unique_viewers"
      expr: COUNT(DISTINCT viewer_ip_address)
      comment: "Approximate unique viewer count based on IP address, key audience reach metric"
    - name: "failed_delivery_count"
      expr: SUM(CASE WHEN delivery_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed delivery events, critical quality and reliability metric"
    - name: "delivery_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_status = 'success' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of successful deliveries, primary SLA and quality metric for distribution operations"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_playback_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playback session quality and engagement metrics tracking viewer experience, streaming performance, and content consumption patterns"
  source: "`media_broadcasting_ecm`.`distribution`.`playback_session`"
  dimensions:
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used for playback"
    - name: "playback_mode"
      expr: playback_mode
      comment: "Playback mode (live, VOD, DVR)"
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution of the playback session"
    - name: "audio_language"
      expr: audio_language
      comment: "Audio language selected by viewer"
    - name: "subtitle_language"
      expr: subtitle_language
      comment: "Subtitle language selected by viewer"
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason for session exit (user stop, error, completion)"
    - name: "closed_captions_enabled"
      expr: closed_captions_enabled
      comment: "Whether closed captions were enabled during playback"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was enabled"
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence serving the session"
    - name: "geographic_city"
      expr: geographic_city
      comment: "City of the viewer"
    - name: "session_date"
      expr: DATE(session_start_timestamp)
      comment: "Date the session started"
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month the session started"
  measures:
    - name: "total_playback_sessions"
      expr: COUNT(1)
      comment: "Total number of playback sessions"
    - name: "unique_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers with playback sessions, key audience engagement metric"
    - name: "total_watch_hours"
      expr: SUM(CAST(total_watch_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total watch hours across all sessions, primary content consumption and engagement metric"
    - name: "avg_watch_duration_minutes"
      expr: AVG(CAST(total_watch_duration_seconds AS DOUBLE)) / 60.0
      comment: "Average watch duration per session in minutes, measures viewer engagement quality"
    - name: "avg_completion_rate_pct"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average content completion percentage, critical engagement and content quality metric"
    - name: "total_rebuffering_events"
      expr: SUM(CAST(rebuffering_events_count AS DOUBLE))
      comment: "Total rebuffering events across all sessions, primary streaming quality metric"
    - name: "avg_rebuffering_events_per_session"
      expr: AVG(CAST(rebuffering_events_count AS DOUBLE))
      comment: "Average rebuffering events per session, key quality of experience metric"
    - name: "total_ad_breaks_served"
      expr: SUM(CAST(ad_breaks_served_count AS DOUBLE))
      comment: "Total ad breaks served, key revenue opportunity metric for ad-supported content"
    - name: "avg_ad_breaks_per_session"
      expr: AVG(CAST(ad_breaks_served_count AS DOUBLE))
      comment: "Average ad breaks per session, measures ad load and revenue potential"
    - name: "sessions_with_errors"
      expr: SUM(CASE WHEN error_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of sessions with errors, critical quality and reliability metric"
    - name: "error_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN error_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions with errors, primary quality metric for playback reliability"
    - name: "high_completion_sessions"
      expr: SUM(CASE WHEN CAST(completion_percentage AS DOUBLE) >= 80.0 THEN 1 ELSE 0 END)
      comment: "Count of sessions with 80%+ completion, measures content engagement success"
    - name: "high_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(completion_percentage AS DOUBLE) >= 80.0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions with high completion, key content quality and engagement metric"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_carriage_fee_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage fee revenue and billing metrics tracking distribution partner payments, revenue recognition, and accounts receivable performance"
  source: "`media_broadcasting_ecm`.`distribution`.`carriage_fee_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (draft, sent, paid, overdue, disputed)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the invoice"
    - name: "fee_basis"
      expr: fee_basis
      comment: "Basis for fee calculation (per subscriber, flat rate, revenue share)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for invoice amounts"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (wire, ACH, check)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is disputed"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance"
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period"
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when payment is due"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of carriage fee invoices"
    - name: "unique_distribution_partners"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners invoiced, measures partner ecosystem breadth"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoice amount across all invoices, primary carriage fee revenue metric"
    - name: "total_base_fee_amount"
      expr: SUM(CAST(base_fee_amount AS DOUBLE))
      comment: "Total base fee amount before adjustments and taxes"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount (credits, discounts, penalties)"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount, measures typical partner billing size"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN payment_status = 'paid' THEN 1 ELSE 0 END)
      comment: "Count of paid invoices"
    - name: "payment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_status = 'paid' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices paid, key accounts receivable and cash flow metric"
    - name: "disputed_invoice_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed invoices, measures billing quality and partner relationship health"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices disputed, critical billing quality and partner satisfaction metric"
    - name: "total_disputed_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount under dispute, measures revenue at risk"
    - name: "reconciled_invoice_count"
      expr: SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END)
      comment: "Count of reconciled invoices"
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices reconciled, key financial operations efficiency metric"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_streaming_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming endpoint infrastructure and operational metrics tracking endpoint availability, capacity, and cost efficiency"
  source: "`media_broadcasting_ecm`.`distribution`.`streaming_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of streaming endpoint (origin, edge, backup)"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol supported by endpoint"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of endpoint (active, inactive, maintenance)"
    - name: "manifest_format"
      expr: manifest_format
      comment: "Manifest format served by endpoint (HLS, DASH, Smooth)"
    - name: "geo_restriction_mode"
      expr: geo_restriction_mode
      comment: "Geographic restriction mode (allow, block, none)"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled on this endpoint"
    - name: "ipv6_enabled"
      expr: ipv6_enabled
      comment: "Whether IPv6 is enabled on this endpoint"
    - name: "provisioned_month"
      expr: DATE_TRUNC('MONTH', provisioned_date)
      comment: "Month the endpoint was provisioned"
  measures:
    - name: "total_streaming_endpoints"
      expr: COUNT(1)
      comment: "Total number of streaming endpoints"
    - name: "active_endpoints"
      expr: SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active streaming endpoints, measures available infrastructure capacity"
    - name: "endpoint_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints in active status, key infrastructure availability metric"
    - name: "total_bandwidth_capacity_gbps"
      expr: SUM(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Total bandwidth capacity across all endpoints in Gbps, measures infrastructure scale"
    - name: "avg_bandwidth_per_endpoint_gbps"
      expr: AVG(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Average bandwidth capacity per endpoint in Gbps"
    - name: "total_max_bitrate_capacity_mbps"
      expr: SUM(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Total maximum bitrate capacity across all endpoints in Mbps"
    - name: "avg_cost_per_gb"
      expr: AVG(CAST(cost_per_gb AS DOUBLE))
      comment: "Average cost per GB across endpoints, key cost efficiency metric for distribution"
    - name: "total_monthly_bandwidth_cost"
      expr: SUM(CAST(bandwidth_limit_gbps AS DOUBLE) * CAST(cost_per_gb AS DOUBLE) * 1024)
      comment: "Estimated total monthly bandwidth cost assuming full capacity utilization, critical infrastructure cost metric"
    - name: "dai_enabled_endpoints"
      expr: SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of endpoints with dynamic ad insertion enabled, measures monetization infrastructure readiness"
    - name: "dai_enablement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with DAI enabled, measures ad revenue infrastructure coverage"
    - name: "ipv6_enabled_endpoints"
      expr: SUM(CASE WHEN ipv6_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of IPv6-enabled endpoints, measures modern protocol adoption"
    - name: "avg_sla_uptime_target_pct"
      expr: AVG(CAST(sla_uptime_target_percent AS DOUBLE))
      comment: "Average SLA uptime target percentage across endpoints, measures service commitment level"
    - name: "unique_ott_platforms"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of unique OTT platforms served by endpoints, measures platform distribution breadth"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_ott_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTT platform business and operational metrics tracking subscriber base, revenue performance, and platform health"
  source: "`media_broadcasting_ecm`.`distribution`.`ott_platform`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Name of the OTT platform"
    - name: "platform_status"
      expr: platform_status
      comment: "Current status of the platform (active, sunset, beta)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the platform (free, basic, premium, enterprise)"
    - name: "parent_brand"
      expr: parent_brand
      comment: "Parent brand owning the platform"
    - name: "primary_streaming_protocol"
      expr: primary_streaming_protocol
      comment: "Primary streaming protocol used by platform"
    - name: "content_rating_system"
      expr: content_rating_system
      comment: "Content rating system used by platform"
    - name: "billing_currency"
      expr: billing_currency
      comment: "Currency used for billing"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled"
    - name: "fast_channel_enabled"
      expr: fast_channel_enabled
      comment: "Whether FAST channels are enabled"
    - name: "hdr_supported"
      expr: hdr_supported
      comment: "Whether HDR content is supported"
    - name: "coppa_compliant"
      expr: coppa_compliant
      comment: "Whether platform is COPPA compliant"
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR regulations apply"
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the platform launched"
  measures:
    - name: "total_ott_platforms"
      expr: COUNT(1)
      comment: "Total number of OTT platforms"
    - name: "active_platforms"
      expr: SUM(CASE WHEN platform_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active OTT platforms"
    - name: "total_subscribers"
      expr: SUM(CAST(subscriber_count AS DOUBLE))
      comment: "Total subscriber count across all platforms, primary audience scale metric"
    - name: "avg_subscribers_per_platform"
      expr: AVG(CAST(subscriber_count AS DOUBLE))
      comment: "Average subscriber count per platform, measures typical platform scale"
    - name: "total_monthly_subscription_revenue"
      expr: SUM(CAST(subscriber_count AS DOUBLE) * CAST(base_subscription_price AS DOUBLE))
      comment: "Total estimated monthly subscription revenue across all platforms, critical revenue metric"
    - name: "avg_subscription_price"
      expr: AVG(CAST(base_subscription_price AS DOUBLE))
      comment: "Average base subscription price across platforms, measures pricing strategy"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across platforms, key monetization efficiency metric"
    - name: "total_arpu_revenue"
      expr: SUM(CAST(subscriber_count AS DOUBLE) * CAST(arpu AS DOUBLE))
      comment: "Total revenue based on ARPU across all platforms, comprehensive revenue metric including all monetization"
    - name: "avg_sla_uptime_target_pct"
      expr: AVG(CAST(sla_uptime_target_pct AS DOUBLE))
      comment: "Average SLA uptime target percentage, measures service commitment level"
    - name: "dai_enabled_platforms"
      expr: SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of platforms with dynamic ad insertion enabled, measures ad revenue capability"
    - name: "dai_enabled_subscriber_base"
      expr: SUM(CASE WHEN dai_enabled = TRUE THEN CAST(subscriber_count AS DOUBLE) ELSE 0 END)
      comment: "Total subscribers on DAI-enabled platforms, measures addressable ad revenue audience"
    - name: "fast_enabled_platforms"
      expr: SUM(CASE WHEN fast_channel_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of platforms with FAST channels enabled, measures linear streaming capability"
    - name: "hdr_supported_platforms"
      expr: SUM(CASE WHEN hdr_supported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of platforms supporting HDR, measures premium content capability"
    - name: "coppa_compliant_platforms"
      expr: SUM(CASE WHEN coppa_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of COPPA-compliant platforms, measures regulatory compliance for children's content"
    - name: "gdpr_applicable_platforms"
      expr: SUM(CASE WHEN gdpr_applicable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of platforms subject to GDPR, measures European market presence"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_delivery_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery channel operational and commercial metrics tracking channel performance, monetization, and service quality"
  source: "`media_broadcasting_ecm`.`distribution`.`delivery_channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of delivery channel (linear, VOD, FAST, AVOD, SVOD)"
    - name: "channel_name"
      expr: channel_name
      comment: "Name of the delivery channel"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the channel"
    - name: "monetization_model"
      expr: monetization_model
      comment: "Monetization model for the channel (subscription, advertising, transactional, hybrid)"
    - name: "delivery_technology"
      expr: delivery_technology
      comment: "Technology used for content delivery"
    - name: "resolution_format"
      expr: resolution_format
      comment: "Video resolution format (SD, HD, FHD, 4K)"
    - name: "aspect_ratio"
      expr: aspect_ratio
      comment: "Video aspect ratio"
    - name: "audio_format"
      expr: audio_format
      comment: "Audio format (stereo, 5.1, Dolby Atmos)"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the channel"
    - name: "qos_tier"
      expr: qos_tier
      comment: "Quality of service tier"
    - name: "is_active"
      expr: is_active
      comment: "Whether the channel is currently active"
    - name: "blackout_rules_enabled"
      expr: blackout_rules_enabled
      comment: "Whether blackout rules are enabled"
    - name: "retransmission_consent_required"
      expr: retransmission_consent_required
      comment: "Whether retransmission consent is required"
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the channel launched"
  measures:
    - name: "total_delivery_channels"
      expr: COUNT(1)
      comment: "Total number of delivery channels"
    - name: "active_channels"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active delivery channels, measures operational channel inventory"
    - name: "channel_activation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels that are active, measures channel utilization efficiency"
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fee revenue across all channels, primary distribution revenue metric"
    - name: "avg_carriage_fee_per_channel"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per channel, measures typical channel monetization"
    - name: "total_max_bitrate_capacity_mbps"
      expr: SUM(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Total maximum bitrate capacity across all channels in Mbps, measures infrastructure capacity"
    - name: "avg_max_bitrate_mbps"
      expr: AVG(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Average maximum bitrate per channel in Mbps, measures typical quality level"
    - name: "avg_sla_uptime_pct"
      expr: AVG(CAST(sla_uptime_percent AS DOUBLE))
      comment: "Average SLA uptime percentage across channels, key service quality commitment metric"
    - name: "channels_with_blackout_rules"
      expr: SUM(CASE WHEN blackout_rules_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of channels with blackout rules enabled, measures rights restriction complexity"
    - name: "channels_requiring_retransmission_consent"
      expr: SUM(CASE WHEN retransmission_consent_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of channels requiring retransmission consent, measures regulatory compliance scope"
    - name: "unique_ott_platforms"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of unique OTT platforms associated with channels, measures platform distribution breadth"
    - name: "unique_cdn_configurations"
      expr: COUNT(DISTINCT cdn_configuration_id)
      comment: "Number of unique CDN configurations used, measures infrastructure diversity"
    - name: "unique_drm_policies"
      expr: COUNT(DISTINCT drm_policy_id)
      comment: "Number of unique DRM policies applied, measures content protection complexity"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`distribution_release_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Release window commercial and rights metrics tracking content windowing strategy, pricing, and revenue performance"
  source: "`media_broadcasting_ecm`.`distribution`.`release_window`"
  dimensions:
    - name: "window_type"
      expr: window_type
      comment: "Type of release window (theatrical, PVOD, TVOD, SVOD, AVOD, FAST, linear)"
    - name: "window_status"
      expr: window_status
      comment: "Current status of the release window (planned, active, expired, cancelled)"
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the window (flat fee, revenue share, minimum guarantee, hybrid)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial amounts"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the window has exclusivity rights"
    - name: "ad_insertion_enabled"
      expr: ad_insertion_enabled
      comment: "Whether ad insertion is enabled for this window"
    - name: "hdr_enabled"
      expr: hdr_enabled
      comment: "Whether HDR is enabled for this window"
    - name: "closed_caption_required"
      expr: closed_caption_required
      comment: "Whether closed captions are required"
    - name: "audio_description_required"
      expr: audio_description_required
      comment: "Whether audio description is required"
    - name: "max_resolution"
      expr: max_resolution
      comment: "Maximum resolution allowed for this window"
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol for delivery"
    - name: "window_open_month"
      expr: DATE_TRUNC('MONTH', window_open_date)
      comment: "Month the window opens"
    - name: "window_close_month"
      expr: DATE_TRUNC('MONTH', window_close_date)
      comment: "Month the window closes"
  measures:
    - name: "total_release_windows"
      expr: COUNT(1)
      comment: "Total number of release windows"
    - name: "active_windows"
      expr: SUM(CASE WHEN window_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active release windows, measures current distribution scope"
    - name: "total_purchase_price_revenue"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price revenue across all windows, key transactional revenue metric"
    - name: "total_rental_price_revenue"
      expr: SUM(CAST(rental_price AS DOUBLE))
      comment: "Total rental price revenue across all windows, key rental revenue metric"
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fee revenue across all windows, key distribution fee revenue metric"
    - name: "total_minimum_guarantee_revenue"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee revenue, critical upfront revenue and risk mitigation metric"
    - name: "avg_revenue_share_pct"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue share percentage across windows, measures typical deal structure"
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per window, measures typical transactional pricing"
    - name: "avg_rental_price"
      expr: AVG(CAST(rental_price AS DOUBLE))
      comment: "Average rental price per window, measures typical rental pricing"
    - name: "avg_ad_load_minutes"
      expr: AVG(CAST(ad_load_minutes AS DOUBLE))
      comment: "Average ad load in minutes, measures advertising inventory per window"
    - name: "exclusive_windows"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive release windows, measures premium rights distribution"
    - name: "exclusivity_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of windows with exclusivity, key rights strategy metric"
    - name: "ad_enabled_windows"
      expr: SUM(CASE WHEN ad_insertion_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of windows with ad insertion enabled, measures ad revenue opportunity scope"
    - name: "hdr_enabled_windows"
      expr: SUM(CASE WHEN hdr_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of HDR-enabled windows, measures premium quality distribution"
    - name: "accessibility_compliant_windows"
      expr: SUM(CASE WHEN closed_caption_required = TRUE AND audio_description_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fully accessibility-compliant windows, measures regulatory compliance and inclusivity"
    - name: "unique_titles"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of unique titles with release windows, measures content distribution breadth"
    - name: "unique_distribution_partners"
      expr: COUNT(DISTINCT distribution_partner_id)
      comment: "Number of unique distribution partners, measures partner ecosystem breadth"
$$;