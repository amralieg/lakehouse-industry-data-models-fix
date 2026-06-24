-- Metric views for domain: distribution | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_playback_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming playback quality and engagement KPIs derived from individual viewer sessions. Drives decisions on CDN investment, QoS thresholds, DAI monetization effectiveness, and platform health."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`playback_session`"
  dimensions:
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used (HLS, DASH, etc.) for protocol-level performance segmentation."
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution delivered (1080p, 4K, etc.) for quality tier analysis."
    - name: "playback_mode"
      expr: playback_mode
      comment: "Playback mode (live, VOD, DVR) for content consumption pattern analysis."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason the session ended (user exit, error, completion) for churn and error root-cause analysis."
    - name: "geographic_city"
      expr: geographic_city
      comment: "City of the viewer for geographic performance and CDN PoP optimization."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was active in the session, for DAI monetization segmentation."
    - name: "session_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Session start date truncated to day for daily trend analysis."
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Session start month for monthly trend and seasonality analysis."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of playback sessions initiated. Baseline volume metric for platform health and capacity planning."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average content completion rate across sessions. A key engagement KPI — low completion signals content or quality issues requiring intervention."
    - name: "total_watch_duration_hours"
      expr: SUM(CAST(total_watch_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total hours of content consumed across all sessions. Core engagement and monetization volume metric used in licensing and ad revenue forecasting."
    - name: "avg_watch_duration_minutes"
      expr: AVG(CAST(total_watch_duration_seconds AS DOUBLE)) / 60.0
      comment: "Average session watch duration in minutes. Measures viewer stickiness and content engagement depth."
    - name: "dai_session_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions with DAI enabled. Tracks monetization coverage and DAI rollout effectiveness across the platform."
    - name: "closed_caption_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_captions_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions with closed captions enabled. Accessibility compliance KPI monitored by regulatory and product teams."
    - name: "total_ad_duration_hours"
      expr: SUM(CAST(total_ad_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total ad time delivered across all sessions in hours. Direct input to ad revenue reconciliation and fill-rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_qos_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality-of-Service event KPIs measuring streaming reliability, buffering, and error rates. Used by engineering and operations to maintain SLA compliance and improve viewer experience."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`qos_event`"
  dimensions:
    - name: "event_severity"
      expr: event_severity
      comment: "Severity level of the QoS event (critical, warning, info) for prioritized incident response."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol associated with the QoS event for protocol-level quality analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where the QoS event occurred for regional infrastructure investment decisions."
    - name: "isp_name"
      expr: isp_name
      comment: "Internet service provider associated with the event for ISP-level quality benchmarking."
    - name: "drm_system"
      expr: drm_system
      comment: "DRM system active during the event for DRM-related quality issue isolation."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the QoS event for daily quality trend monitoring."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the QoS event for monthly SLA reporting."
  measures:
    - name: "total_qos_events"
      expr: COUNT(1)
      comment: "Total number of QoS events recorded. Baseline volume for platform reliability monitoring."
    - name: "avg_buffer_level_seconds"
      expr: AVG(CAST(buffer_level_seconds AS DOUBLE))
      comment: "Average buffer level in seconds at time of QoS event. Low buffer levels indicate imminent rebuffering and poor viewer experience."
    - name: "avg_playback_position_seconds"
      expr: AVG(CAST(playback_position_seconds AS DOUBLE))
      comment: "Average playback position when QoS events occur. Identifies content segments with recurring quality issues."
    - name: "avg_seek_position_seconds"
      expr: AVG(CAST(seek_position_seconds AS DOUBLE))
      comment: "Average seek position during QoS events. Helps identify whether seek operations are triggering quality degradation."
    - name: "critical_event_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN event_severity = 'critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of QoS events classified as critical severity. Key SLA health indicator — elevated rates trigger NOC escalation."
    - name: "distinct_affected_sessions"
      expr: COUNT(DISTINCT playback_session_id)
      comment: "Number of unique playback sessions impacted by QoS events. Measures breadth of quality issues affecting the viewer base."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_dai_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dynamic Ad Insertion session KPIs measuring ad fill rates, pod performance, and monetization efficiency. Core metrics for ad operations, revenue management, and FAST/AVOD platform optimization."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`dai_session`"
  dimensions:
    - name: "stitching_mode"
      expr: stitching_mode
      comment: "Ad stitching mode (server-side, client-side) for DAI technology performance comparison."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol of the DAI session for protocol-level monetization analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the DAI session for regional ad revenue and fill-rate analysis."
    - name: "ad_pod_position"
      expr: ad_pod_position
      comment: "Position of the ad pod (pre-roll, mid-roll, post-roll) for pod-level yield optimization."
    - name: "frequency_cap_applied"
      expr: frequency_cap_applied_flag
      comment: "Whether frequency capping was applied in this session, for cap impact analysis on fill rates."
    - name: "blackout_override"
      expr: blackout_override_flag
      comment: "Whether a blackout override was applied, for blackout monetization impact analysis."
    - name: "session_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "DAI session date for daily ad revenue and fill-rate trending."
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "DAI session month for monthly ad revenue reporting."
  measures:
    - name: "total_dai_sessions"
      expr: COUNT(1)
      comment: "Total number of DAI sessions. Baseline volume for ad monetization capacity and demand planning."
    - name: "avg_fill_rate_percentage"
      expr: AVG(CAST(fill_rate_percentage AS DOUBLE))
      comment: "Average ad fill rate across DAI sessions. Primary monetization efficiency KPI — low fill rates indicate unsold inventory or targeting mismatches."
    - name: "total_ads_inserted"
      expr: SUM(CAST(ads_inserted_count AS DOUBLE))
      comment: "Total number of ads successfully inserted across all DAI sessions. Measures ad delivery volume for revenue reconciliation."
    - name: "total_ads_requested"
      expr: SUM(CAST(ads_requested_count AS DOUBLE))
      comment: "Total number of ad requests made across all DAI sessions. Denominator for fill-rate calculation and demand forecasting."
    - name: "total_ad_pod_duration_hours"
      expr: SUM(CAST(ad_pod_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total ad pod duration delivered in hours. Measures monetized inventory volume for revenue reporting."
    - name: "total_ad_duration_hours"
      expr: SUM(CAST(total_ad_duration_seconds AS DOUBLE)) / 3600.0
      comment: "Total ad time delivered across all DAI sessions in hours. Direct input to CPM-based revenue calculation."
    - name: "avg_ad_decision_response_time_ms"
      expr: AVG(CAST(ad_decision_server_response_time_ms AS DOUBLE))
      comment: "Average ad decision server response time in milliseconds. Operational KPI — high latency causes ad timeouts and fill-rate degradation."
    - name: "frequency_cap_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN frequency_cap_applied_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DAI sessions where frequency capping was applied. Measures cap policy impact on ad delivery and potential revenue suppression."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA performance KPIs measuring actual vs. target service levels, breach rates, and penalty exposure. Used by operations leadership to manage partner contracts, CDN vendors, and platform reliability commitments."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`sla_performance`"
  dimensions:
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform affected by the SLA measurement for platform-level performance benchmarking."
    - name: "affected_region"
      expr: affected_region
      comment: "Geographic region of the SLA measurement for regional reliability analysis."
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider associated with the SLA measurement for vendor performance comparison."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol for protocol-level SLA compliance analysis."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the measurement period resulted in an SLA breach, for breach vs. compliant segmentation."
    - name: "measurement_granularity"
      expr: measurement_granularity
      comment: "Granularity of the measurement (hourly, daily, monthly) for appropriate aggregation context."
    - name: "measurement_period_month"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Month of the measurement period for monthly SLA compliance reporting."
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of SLA measurement records. Baseline for breach rate calculation."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual SLA metric value across measurement periods. Compared against target to assess overall service level health."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across measurement periods. Baseline for variance and compliance analysis."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and target SLA values. Negative variance indicates underperformance requiring vendor or operational intervention."
    - name: "breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurement periods resulting in an SLA breach. Primary contract compliance KPI — elevated rates trigger penalty clauses and partner escalations."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure from SLA breaches. Direct P&L impact metric used in vendor contract negotiations and budget planning."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per SLA measurement period. Benchmarks typical breach cost for contract risk assessment."
    - name: "penalty_applicable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN penalty_applicable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breach records where a financial penalty is applicable. Measures contractual exposure rate beyond simple breach frequency."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA breach incident KPIs tracking severity, financial penalties, resolution times, and dispute rates. Used by operations and finance leadership to manage vendor accountability and contractual risk."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`sla_breach`"
  dimensions:
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the SLA breach (critical, major, minor) for prioritized remediation."
    - name: "affected_platform"
      expr: affected_platform
      comment: "Platform affected by the breach for platform-level reliability accountability."
    - name: "affected_region"
      expr: affected_region
      comment: "Geographic region of the breach for regional infrastructure investment decisions."
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider associated with the breach for vendor performance management."
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the SLA metric that was breached (uptime, latency, error rate) for metric-level trend analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the breach is under dispute, for disputed vs. confirmed breach analysis."
    - name: "breach_month"
      expr: DATE_TRUNC('month', breach_timestamp)
      comment: "Month of the breach for monthly breach trend and penalty accrual reporting."
  measures:
    - name: "total_breaches"
      expr: COUNT(1)
      comment: "Total number of SLA breach incidents. Baseline reliability KPI for executive dashboards and vendor scorecards."
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure from all SLA breaches. Direct P&L impact metric for finance and legal review."
    - name: "avg_breach_duration_minutes"
      expr: AVG(CAST(breach_duration_minutes AS DOUBLE))
      comment: "Average duration of SLA breaches in minutes. Measures operational impact severity and remediation effectiveness."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured metric value at time of breach. Quantifies how far below threshold performance fell."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average SLA threshold value for breached metrics. Provides context for measured vs. required performance."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage by which the measured value missed the SLA threshold. Measures breach depth for severity-weighted penalty calculations."
    - name: "penalty_applicable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN penalty_applicable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaches where financial penalties apply. Measures contractual exposure rate for budget risk management."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA breaches under dispute. High dispute rates signal contract ambiguity or vendor accountability issues."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_delivery_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content delivery event KPIs measuring throughput, error rates, ad fill performance, and CDN efficiency. Used by distribution operations and engineering to optimize delivery infrastructure and monetization."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`delivery_event`"
  dimensions:
    - name: "delivery_technology"
      expr: delivery_technology
      comment: "Delivery technology (OTT, satellite, cable, IPTV) for technology-level performance comparison."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used for the delivery event for protocol-level quality analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the delivery event for regional CDN and infrastructure optimization."
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence location for PoP-level performance and capacity analysis."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether DAI was active during the delivery event for monetization coverage analysis."
    - name: "video_codec"
      expr: video_codec
      comment: "Video codec used for the delivery event for codec-level efficiency analysis."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the delivery event for daily throughput and error trend monitoring."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the delivery event for monthly capacity and cost reporting."
  measures:
    - name: "total_delivery_events"
      expr: COUNT(1)
      comment: "Total number of delivery events. Baseline volume metric for infrastructure capacity planning."
    - name: "total_bytes_delivered_gb"
      expr: SUM(CAST(bytes_delivered AS DOUBLE)) / 1073741824.0
      comment: "Total gigabytes of content delivered. Core CDN cost and capacity metric used in vendor billing reconciliation."
    - name: "avg_ad_fill_rate_percent"
      expr: AVG(CAST(ad_fill_rate_percent AS DOUBLE))
      comment: "Average ad fill rate across delivery events. Measures monetization efficiency of the delivery pipeline."
    - name: "distinct_sessions_served"
      expr: COUNT(DISTINCT playback_session_id)
      comment: "Number of unique playback sessions served. Measures reach of the delivery infrastructure."
    - name: "error_event_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN error_message IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery events with errors. Key reliability KPI — elevated rates trigger CDN and infrastructure investigations."
    - name: "dai_coverage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery events with DAI enabled. Measures monetization coverage across the delivery footprint."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_carriage_fee_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage fee invoice KPIs measuring billing volumes, payment status, dispute rates, and revenue recognition. Used by finance and distribution operations to manage partner billing and cash flow."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`distribution_carriage_fee_invoice`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (paid, outstanding, overdue) for accounts receivable management."
    - name: "fee_basis"
      expr: fee_basis
      comment: "Basis for the carriage fee calculation (per-subscriber, flat fee, tiered) for fee structure analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute for dispute rate monitoring and cash flow risk assessment."
    - name: "billing_period_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing period month for monthly revenue recognition and cash flow trending."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice issuance month for billing cycle analysis."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of carriage fee invoices issued. Baseline billing volume metric."
    - name: "total_base_fee_amount"
      expr: SUM(CAST(base_fee_amount AS DOUBLE))
      comment: "Total base carriage fee billed across all invoices. Core revenue metric for distribution partnership P&L."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed across all carriage fee invoices. Required for tax liability reporting."
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoice amount including fees, adjustments, and taxes. Primary revenue recognition metric for carriage agreements."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to carriage fee invoices. Measures billing correction volume and partner dispute resolution impact."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriage fee invoices under dispute. High rates signal contract ambiguity or partner relationship issues requiring executive attention."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount per carriage fee billing. Benchmarks typical partner billing size for portfolio analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_subscriber_count_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber count reporting KPIs measuring verified subscriber volumes, variance rates, and carriage fee basis. Used by distribution finance and operations to validate partner billing and audit compliance."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`subscriber_count_report`"
  dimensions:
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the subscriber count report is under dispute for audit and billing accuracy monitoring."
    - name: "variance_flag"
      expr: variance_flag
      comment: "Whether a variance was detected between reported and verified subscriber counts for data quality monitoring."
    - name: "invoice_generated_flag"
      expr: invoice_generated_flag
      comment: "Whether an invoice has been generated from this report for billing pipeline completeness tracking."
    - name: "audit_rights_exercised"
      expr: audit_rights_exercised
      comment: "Whether audit rights were exercised for this report period for compliance and governance tracking."
    - name: "reporting_period_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Reporting period month for monthly subscriber count trend analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of subscriber count reports submitted. Baseline for reporting compliance monitoring."
    - name: "total_reported_subscribers"
      expr: SUM(CAST(reported_subscriber_count AS DOUBLE))
      comment: "Total reported subscriber count across all partners and periods. Primary input to carriage fee billing calculations."
    - name: "total_verified_subscribers"
      expr: SUM(CAST(verified_subscriber_count AS DOUBLE))
      comment: "Total verified subscriber count after audit. Compared against reported count to identify billing discrepancies."
    - name: "total_variance_count"
      expr: SUM(CAST(variance_count AS DOUBLE))
      comment: "Total subscriber count variance (reported minus verified) across all reports. Measures billing accuracy and partner data quality."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between reported and verified subscriber counts. Key audit quality KPI — high variance triggers partner investigations."
    - name: "avg_carriage_fee_per_subscriber"
      expr: AVG(CAST(carriage_fee_per_subscriber AS DOUBLE))
      comment: "Average carriage fee per subscriber across all reports. Benchmarks per-subscriber economics for contract negotiation."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriber count reports under dispute. Elevated rates indicate systemic data quality or contract interpretation issues."
    - name: "variance_detection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN variance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with detected subscriber count variances. Measures billing accuracy across the distribution partner portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution deal KPIs measuring deal economics, win rates, revenue share, and programmatic deal performance. Used by distribution sales and business development leadership to optimize deal structures and partner economics."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`deal`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of distribution deal (direct, programmatic, PMP, preferred) for deal structure analysis."
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the deal (active, expired, negotiating) for pipeline and portfolio management."
    - name: "revenue_model"
      expr: revenue_model
      comment: "Revenue model of the deal (CPM, flat fee, revenue share) for monetization strategy analysis."
    - name: "auction_type"
      expr: auction_type
      comment: "Auction type for programmatic deals (first-price, second-price) for yield optimization analysis."
    - name: "private_marketplace_flag"
      expr: private_marketplace_flag
      comment: "Whether the deal is a private marketplace deal for PMP vs. open exchange performance comparison."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the deal includes exclusivity provisions for exclusivity premium analysis."
    - name: "territory"
      expr: territory
      comment: "Geographic territory of the deal for regional deal portfolio analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the deal became effective for deal cohort and vintage analysis."
  measures:
    - name: "total_deals"
      expr: COUNT(1)
      comment: "Total number of distribution deals. Baseline portfolio size metric for business development tracking."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all deals. Measures contracted revenue floor for financial planning."
    - name: "total_flat_fee_revenue"
      expr: SUM(CAST(flat_fee_amount AS DOUBLE))
      comment: "Total flat fee revenue committed across all deals. Measures predictable revenue from fixed-fee deal structures."
    - name: "avg_bid_floor_cpm"
      expr: AVG(CAST(bid_floor_cpm AS DOUBLE))
      comment: "Average bid floor CPM across programmatic deals. Key yield management metric for programmatic inventory pricing strategy."
    - name: "avg_clearing_price_cpm"
      expr: AVG(CAST(clearing_price_cpm AS DOUBLE))
      comment: "Average clearing price CPM across programmatic deals. Measures actual yield vs. floor price for pricing optimization."
    - name: "avg_win_rate"
      expr: AVG(CAST(win_rate AS DOUBLE))
      comment: "Average programmatic bid win rate across deals. Low win rates signal floor prices are too high or targeting is too narrow."
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage across revenue-share deals. Benchmarks partner economics for contract negotiation."
    - name: "pmp_deal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN private_marketplace_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deals structured as private marketplace deals. Measures premium programmatic deal mix for yield strategy."
    - name: "avg_minimum_subscriber_guarantee"
      expr: AVG(CAST(minimum_subscriber_guarantee AS DOUBLE))
      comment: "Average minimum subscriber guarantee committed across deals. Measures distribution reach commitments in partner contracts."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_release_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content release window KPIs measuring windowing economics, exclusivity rates, and pricing across distribution platforms. Used by content strategy and distribution leadership to optimize windowing sequencing and revenue maximization."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`release_window`"
  dimensions:
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the release window (SVOD, TVOD, AVOD, FAST) for monetization model analysis."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic territory scope of the release window for territorial windowing strategy analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the release window is exclusive to a platform for exclusivity premium analysis."
    - name: "hdr_enabled"
      expr: hdr_enabled
      comment: "Whether HDR is enabled for this release window for premium format distribution analysis."
    - name: "ad_insertion_enabled"
      expr: ad_insertion_enabled
      comment: "Whether ad insertion is enabled for this window for AVOD/FAST monetization analysis."
    - name: "window_open_month"
      expr: DATE_TRUNC('month', window_open_date)
      comment: "Month the release window opens for windowing schedule and content availability trend analysis."
  measures:
    - name: "total_release_windows"
      expr: COUNT(1)
      comment: "Total number of active release windows. Baseline for content availability and windowing portfolio management."
    - name: "total_purchase_revenue"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price revenue across all TVOD release windows. Measures transactional video revenue contribution."
    - name: "total_rental_revenue"
      expr: SUM(CAST(rental_price AS DOUBLE))
      comment: "Total rental price revenue across all TVOD rental windows. Measures rental monetization contribution."
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fee revenue committed across release windows. Measures distribution fee income from windowing agreements."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts across release windows. Measures contracted revenue floor from windowing deals."
    - name: "avg_revenue_share_percent"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue share percentage across release windows. Benchmarks platform economics for windowing negotiation."
    - name: "avg_ad_load_minutes"
      expr: AVG(CAST(ad_load_minutes AS DOUBLE))
      comment: "Average ad load per release window in minutes. Measures monetization intensity of AVOD/FAST windows."
    - name: "exclusivity_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of release windows with exclusivity provisions. Measures premium content exclusivity strategy execution."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_recommendation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content recommendation KPIs measuring click-through rates, consumption rates, and algorithm performance. Used by product and data science leadership to optimize recommendation engines and drive viewer engagement."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`recommendation_event`"
  dimensions:
    - name: "algorithm_name"
      expr: algorithm_name
      comment: "Name of the recommendation algorithm for algorithm-level performance comparison."
    - name: "algorithm_version"
      expr: algorithm_version
      comment: "Version of the recommendation algorithm for A/B test and model iteration analysis."
    - name: "recommendation_context"
      expr: recommendation_context
      comment: "Context in which the recommendation was served (home screen, end card, search) for placement optimization."
    - name: "device_type"
      expr: device_type
      comment: "Device type on which the recommendation was served for device-level engagement analysis."
    - name: "platform"
      expr: platform
      comment: "Platform on which the recommendation was served for platform-level algorithm performance."
    - name: "slate_position"
      expr: slate_position
      comment: "Position of the recommended item in the slate for position-bias and ranking optimization."
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date the recommendation event occurred for daily engagement trend monitoring."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the recommendation event occurred for monthly algorithm performance reporting."
  measures:
    - name: "total_recommendations_served"
      expr: COUNT(1)
      comment: "Total number of recommendation events served. Baseline volume for recommendation engine capacity and coverage analysis."
    - name: "click_through_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN clicked_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of served recommendations that were clicked. Primary recommendation relevance KPI — low CTR triggers algorithm retraining."
    - name: "consumption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN was_consumed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of served recommendations that resulted in content consumption. Measures recommendation-to-viewing conversion effectiveness."
    - name: "play_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN was_played_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of served recommendations that resulted in playback. Measures recommendation-to-play conversion for content discovery effectiveness."
    - name: "avg_recommendation_score"
      expr: AVG(CAST(recommendation_score AS DOUBLE))
      comment: "Average model confidence score for served recommendations. Tracks algorithm confidence calibration and model quality over time."
    - name: "avg_ranking_score"
      expr: AVG(CAST(ranking_score AS DOUBLE))
      comment: "Average ranking score assigned to served recommendations. Measures ranking model quality and position-relevance alignment."
    - name: "distinct_titles_recommended"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of unique titles recommended. Measures catalog coverage and diversity of the recommendation engine."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_ab_test_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B test assignment KPIs measuring experiment coverage, traffic allocation, and control group distribution. Used by product and data science teams to validate experiment design and ensure statistical validity of platform tests."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`ab_test_assignment`"
  dimensions:
    - name: "experiment_name"
      expr: experiment_name
      comment: "Name of the A/B experiment for experiment-level performance tracking."
    - name: "variant_name"
      expr: variant_name
      comment: "Variant assigned to the user (control, treatment A, treatment B) for variant-level outcome comparison."
    - name: "assignment_bucket"
      expr: assignment_bucket
      comment: "Assignment bucket for the user for traffic split validation and bucket-level analysis."
    - name: "control_flag"
      expr: control_flag
      comment: "Whether the assignment is to the control group for control vs. treatment segmentation."
    - name: "experiment_start_month"
      expr: DATE_TRUNC('month', experiment_start_date)
      comment: "Month the experiment started for experiment cohort and timeline analysis."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of A/B test assignments. Baseline for experiment sample size validation and statistical power assessment."
    - name: "distinct_experiments"
      expr: COUNT(DISTINCT experiment_key)
      comment: "Number of distinct experiments running. Measures experiment portfolio breadth and potential interaction effects."
    - name: "distinct_subscribers_in_tests"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers enrolled in A/B tests. Measures experiment reach and population coverage."
    - name: "avg_traffic_percentage"
      expr: AVG(CAST(traffic_percentage AS DOUBLE))
      comment: "Average traffic percentage allocated to experiments. Validates that traffic splits are within intended ranges for experiment integrity."
    - name: "avg_allocation_ratio"
      expr: AVG(CAST(allocation_ratio AS DOUBLE))
      comment: "Average allocation ratio across test assignments. Monitors allocation balance for statistical validity of experiment results."
    - name: "avg_exposure_rate"
      expr: AVG(CAST(exposure_rate AS DOUBLE))
      comment: "Average exposure rate across test assignments. Measures how frequently assigned users are actually exposed to the experiment treatment."
    - name: "control_group_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN control_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments in the control group. Validates control group sizing for experiment statistical design."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_frequency_cap_state`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad frequency cap state KPIs measuring cap utilization, cap-reached rates, and impression delivery against limits. Used by ad operations to optimize frequency policies and balance viewer experience with monetization."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`frequency_cap_state`"
  dimensions:
    - name: "cap_scope"
      expr: cap_scope
      comment: "Scope of the frequency cap (campaign, advertiser, category) for cap policy effectiveness analysis."
    - name: "cap_period"
      expr: cap_period
      comment: "Time period of the frequency cap (hourly, daily, weekly) for cap window optimization."
    - name: "cap_window"
      expr: cap_window
      comment: "Cap window definition for granular frequency policy analysis."
    - name: "is_capped"
      expr: is_capped
      comment: "Whether the subscriber is currently capped for capped vs. uncapped audience segmentation."
    - name: "cap_reached_flag"
      expr: cap_reached_flag
      comment: "Whether the frequency cap limit has been reached for cap saturation analysis."
    - name: "window_start_month"
      expr: DATE_TRUNC('month', window_start_at)
      comment: "Month of the cap window for monthly frequency policy impact reporting."
  measures:
    - name: "total_cap_states"
      expr: COUNT(1)
      comment: "Total number of frequency cap state records. Baseline for cap policy coverage analysis."
    - name: "distinct_capped_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique subscribers with active frequency cap states. Measures cap policy reach across the subscriber base."
    - name: "cap_reached_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cap_reached_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cap states where the frequency limit has been reached. High rates indicate overly restrictive caps suppressing ad revenue."
    - name: "total_impressions_served"
      expr: SUM(CAST(impressions_served AS DOUBLE))
      comment: "Total impressions served across all frequency cap states. Measures ad delivery volume subject to frequency management."
    - name: "avg_current_count"
      expr: AVG(CAST(current_count AS DOUBLE))
      comment: "Average current impression count relative to cap limits. Measures average cap utilization across the subscriber base."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_clip_distribution_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social and digital clip distribution KPIs measuring reach, engagement, and monetization of short-form content across social platforms. Used by digital distribution and marketing leadership to optimize social content strategy."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`clip_distribution_event`"
  dimensions:
    - name: "publish_status"
      expr: publish_status
      comment: "Publication status of the clip (published, scheduled, failed) for distribution pipeline monitoring."
    - name: "monetized_flag"
      expr: monetized_flag
      comment: "Whether the clip is monetized on the social platform for monetization coverage analysis."
    - name: "published_month"
      expr: DATE_TRUNC('month', published_at)
      comment: "Month the clip was published for monthly social distribution trend analysis."
  measures:
    - name: "total_clips_distributed"
      expr: COUNT(1)
      comment: "Total number of clips distributed across social platforms. Baseline for social content distribution volume tracking."
    - name: "total_views"
      expr: SUM(CAST(view_count AS DOUBLE))
      comment: "Total views across all distributed clips. Primary reach metric for social content strategy effectiveness."
    - name: "total_likes"
      expr: SUM(CAST(like_count AS DOUBLE))
      comment: "Total likes across all distributed clips. Measures audience sentiment and content resonance on social platforms."
    - name: "total_shares"
      expr: SUM(CAST(share_count AS DOUBLE))
      comment: "Total shares across all distributed clips. Measures viral amplification and organic reach extension."
    - name: "total_estimated_revenue"
      expr: SUM(CAST(estimated_revenue AS DOUBLE))
      comment: "Total estimated revenue from monetized social clips. Measures social platform monetization contribution to overall distribution revenue."
    - name: "monetization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN monetized_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of distributed clips that are monetized. Measures social monetization coverage and revenue capture effectiveness."
    - name: "avg_views_per_clip"
      expr: ROUND(SUM(CAST(view_count AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average views per distributed clip. Measures per-clip reach efficiency for content selection and social strategy optimization."
$$;