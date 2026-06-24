-- Metric views for domain: distribution | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_playback_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core viewer engagement and streaming quality KPIs derived from individual playback sessions. Used by streaming operations, product, and executive teams to monitor audience reach, content completion, ad monetization, and QoS health."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`playback_session`"
  dimensions:
    - name: "ott_platform_id"
      expr: ott_platform_id
      comment: "OTT platform on which the session occurred — enables platform-level performance comparison."
    - name: "delivery_channel_id"
      expr: delivery_channel_id
      comment: "Delivery channel used for the session — supports channel-level QoS and engagement analysis."
    - name: "territory_id"
      expr: territory_id
      comment: "Rights territory of the session — enables geographic audience and compliance reporting."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol used (e.g. HLS, DASH) — informs infrastructure and compatibility decisions."
    - name: "playback_mode"
      expr: playback_mode
      comment: "Mode of playback (e.g. live, VOD, DVR) — segments audience behavior by consumption type."
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution delivered during the session — tracks quality tier distribution across viewers."
    - name: "audio_language"
      expr: audio_language
      comment: "Audio language selected by the viewer — supports localization and accessibility reporting."
    - name: "exit_reason"
      expr: exit_reason
      comment: "Reason the session ended (e.g. user exit, error, completion) — critical for churn and QoS root-cause analysis."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion was active — segments ad-monetized vs. non-monetized sessions."
    - name: "closed_captions_enabled"
      expr: closed_captions_enabled
      comment: "Whether closed captions were enabled — supports accessibility compliance tracking."
    - name: "session_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Calendar day the session started — primary time dimension for daily trend analysis."
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Calendar month the session started — supports monthly KPI roll-ups and executive reporting."
    - name: "geographic_city"
      expr: geographic_city
      comment: "City of the viewer — enables sub-territory geographic audience analysis."
    - name: "cdn_pop_location"
      expr: cdn_pop_location
      comment: "CDN point-of-presence serving the session — supports CDN performance and cost attribution."
    - name: "abr_profile_id"
      expr: abr_profile_id
      comment: "ABR profile applied during the session — links quality tier to viewer experience outcomes."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of playback sessions initiated. Baseline audience reach metric used in all streaming dashboards."
    - name: "unique_viewers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Count of distinct subscribers who initiated at least one session. Core audience size KPI for executive and advertiser reporting."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average content completion rate across all sessions. Measures content engagement depth — low values signal content or QoS issues requiring intervention."
    - name: "fully_completed_sessions"
      expr: COUNT(CASE WHEN completion_percentage >= 90 THEN 1 END)
      comment: "Sessions where viewers watched at least 90% of content. Indicates strong content engagement and is a key input to content renewal and licensing decisions."
    - name: "completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_percentage >= 90 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions reaching 90%+ completion. Executive KPI for content performance — directly tied to subscriber retention and content investment ROI."
    - name: "dai_session_count"
      expr: COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END)
      comment: "Number of sessions with dynamic ad insertion active. Measures monetizable ad inventory volume — directly tied to advertising revenue."
    - name: "dai_session_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions with DAI enabled. Tracks ad monetization coverage — a strategic lever for advertising revenue growth."
    - name: "error_exit_sessions"
      expr: COUNT(CASE WHEN exit_reason = 'error' THEN 1 END)
      comment: "Sessions that ended due to a technical error. QoS health KPI — spikes trigger immediate infrastructure investigation and SLA review."
    - name: "error_exit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exit_reason = 'error' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions ending in error. Critical reliability KPI — directly impacts subscriber satisfaction, churn risk, and SLA compliance."
    - name: "avg_session_completion_pct"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all sessions as a double-precision value. Used for trend analysis and content performance benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_delivery_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution channel portfolio KPIs covering monetization model mix, SLA performance, carriage economics, and active channel health. Used by distribution strategy, operations, and finance teams."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`delivery_channel`"
  dimensions:
    - name: "delivery_technology"
      expr: delivery_technology
      comment: "Technology used for delivery (e.g. OTT, MVPD, FAST) — primary segmentation for distribution strategy analysis."
    - name: "monetization_model"
      expr: monetization_model
      comment: "Revenue model (e.g. SVOD, AVOD, TVOD, FAST) — critical dimension for revenue mix and business model strategy."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the channel — used to filter active vs. inactive channels in health dashboards."
    - name: "target_market"
      expr: target_market
      comment: "Target market for the delivery channel — enables geographic and demographic distribution analysis."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target audience demographic — supports audience segmentation and content strategy alignment."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the channel — supports localization strategy and international expansion tracking."
    - name: "is_active"
      expr: is_active
      comment: "Whether the delivery channel is currently active — used to segment live vs. retired channels."
    - name: "retransmission_consent_required"
      expr: retransmission_consent_required
      comment: "Whether retransmission consent is required — flags regulatory compliance obligations for rights management."
    - name: "launch_date_month"
      expr: DATE_TRUNC('month', launch_date)
      comment: "Month the channel launched — tracks channel portfolio growth over time."
    - name: "blackout_rules_enabled"
      expr: blackout_rules_enabled
      comment: "Whether blackout rules are enforced on this channel — relevant for rights compliance monitoring."
  measures:
    - name: "total_delivery_channels"
      expr: COUNT(1)
      comment: "Total number of delivery channels in the portfolio. Baseline distribution footprint metric for executive channel strategy reviews."
    - name: "active_delivery_channels"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active delivery channels. Tracks live distribution reach — a key input to audience coverage and revenue capacity planning."
    - name: "active_channel_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery channels that are currently active. Measures portfolio health and operational efficiency of the distribution network."
    - name: "avg_sla_uptime_percent"
      expr: AVG(CAST(sla_uptime_percent AS DOUBLE))
      comment: "Average SLA uptime target across all delivery channels. Tracks contractual reliability commitments — below-target values trigger partner escalations and SLA penalty reviews."
    - name: "avg_max_bitrate_mbps"
      expr: AVG(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Average maximum bitrate capacity across delivery channels. Informs infrastructure investment decisions and quality tier benchmarking."
    - name: "total_carriage_fee_usd"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fees across all delivery channels in USD. Direct revenue/cost KPI used in distribution economics and partner negotiation strategy."
    - name: "avg_carriage_fee_usd"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per delivery channel in USD. Benchmarks deal economics across partners and informs pricing strategy for new carriage agreements."
    - name: "channels_with_blackout_rules"
      expr: COUNT(CASE WHEN blackout_rules_enabled = TRUE THEN 1 END)
      comment: "Number of channels with blackout rules enforced. Tracks rights compliance complexity — high counts signal operational overhead in rights management."
    - name: "retransmission_consent_channels"
      expr: COUNT(CASE WHEN retransmission_consent_required = TRUE THEN 1 END)
      comment: "Number of channels requiring retransmission consent. Regulatory compliance KPI — directly tied to legal risk and negotiation workload."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_carriage_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage agreement portfolio KPIs covering deal economics, rights compliance, renewal risk, and partner obligations. Used by distribution business development, legal, and finance teams."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`carriage_agreement`"
  dimensions:
    - name: "partner_id"
      expr: partner_id
      comment: "Distribution partner associated with the agreement — primary dimension for partner-level deal analysis."
    - name: "territory_id"
      expr: territory_id
      comment: "Territory covered by the agreement — enables geographic deal portfolio analysis."
    - name: "carriage_fee_currency"
      expr: carriage_fee_currency
      comment: "Currency of the carriage fee — required for multi-currency deal portfolio analysis."
    - name: "carriage_fee_structure"
      expr: carriage_fee_structure
      comment: "Structure of the carriage fee (e.g. flat, per-subscriber) — informs deal economics benchmarking."
    - name: "must_carry_election"
      expr: must_carry_election
      comment: "Whether must-carry election applies — flags regulatory carriage obligations for compliance tracking."
    - name: "retransmission_consent_granted"
      expr: retransmission_consent_granted
      comment: "Whether retransmission consent has been granted — critical rights compliance dimension."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews — used to identify agreements requiring proactive renegotiation."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the agreement became effective — tracks deal pipeline and portfolio vintage."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the agreement expires — critical for renewal pipeline management and revenue continuity planning."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the agreement — supports legal risk and compliance segmentation."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of carriage agreements in the portfolio. Baseline deal volume metric for distribution business development tracking."
    - name: "total_carriage_fee_amount"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fee value across all agreements. Core revenue/cost KPI for distribution economics — directly informs partner negotiation and financial planning."
    - name: "avg_carriage_fee_amount"
      expr: AVG(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Average carriage fee per agreement. Benchmarks deal pricing across partners and territories — used in negotiation strategy and deal valuation."
    - name: "auto_renewal_agreements"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of agreements set to auto-renew. Tracks revenue continuity risk — non-auto-renewing agreements require proactive renegotiation to avoid distribution gaps."
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with auto-renewal. Measures distribution revenue stability — low rates signal high renegotiation workload and revenue continuity risk."
    - name: "must_carry_agreements"
      expr: COUNT(CASE WHEN must_carry_election = TRUE THEN 1 END)
      comment: "Number of agreements with must-carry election. Regulatory compliance KPI — must-carry obligations have direct legal and operational implications."
    - name: "retransmission_consent_granted_count"
      expr: COUNT(CASE WHEN retransmission_consent_granted = TRUE THEN 1 END)
      comment: "Number of agreements where retransmission consent has been granted. Rights compliance KPI — directly tied to legal authorization for content retransmission."
    - name: "retransmission_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retransmission_consent_granted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with retransmission consent granted. Measures rights compliance coverage — below-target rates signal legal exposure in distribution operations."
    - name: "unique_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of distinct distribution partners under active carriage agreements. Measures distribution network breadth — a strategic indicator of market reach."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_ott_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTT platform portfolio KPIs covering subscriber reach, revenue per user, pricing economics, SLA commitments, and feature capability. Used by digital distribution, product, and executive teams."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`ott_platform`"
  dimensions:
    - name: "territory_id"
      expr: territory_id
      comment: "Territory in which the OTT platform operates — primary geographic dimension for international distribution analysis."
    - name: "parent_brand"
      expr: parent_brand
      comment: "Parent brand of the OTT platform — enables brand-level portfolio aggregation and competitive benchmarking."
    - name: "billing_currency"
      expr: billing_currency
      comment: "Currency used for subscriber billing — required for multi-currency revenue analysis."
    - name: "drm_system"
      expr: drm_system
      comment: "DRM system used by the platform — tracks rights protection technology adoption across the portfolio."
    - name: "primary_streaming_protocol"
      expr: primary_streaming_protocol
      comment: "Primary streaming protocol (e.g. HLS, DASH) — informs infrastructure standardization decisions."
    - name: "fast_channel_enabled"
      expr: fast_channel_enabled
      comment: "Whether FAST (Free Ad-Supported Streaming TV) channels are enabled — segments ad-supported vs. subscription platforms."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled — identifies ad-monetization capable platforms."
    - name: "hdr_supported"
      expr: hdr_supported
      comment: "Whether HDR video is supported — tracks premium quality capability across the platform portfolio."
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Whether GDPR applies to the platform — critical compliance dimension for European market operations."
    - name: "mvpd_carriage_eligible"
      expr: mvpd_carriage_eligible
      comment: "Whether the platform is eligible for MVPD carriage — identifies cross-distribution opportunity."
    - name: "launch_date_year"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year the platform launched — tracks portfolio vintage and maturity for strategic planning."
  measures:
    - name: "total_platforms"
      expr: COUNT(1)
      comment: "Total number of OTT platforms in the distribution portfolio. Baseline digital distribution footprint metric."
    - name: "total_subscriber_count"
      expr: SUM(CAST(subscriber_count AS DOUBLE))
      comment: "Total subscribers across all OTT platforms. Primary audience reach KPI — directly tied to advertising inventory, licensing valuations, and revenue forecasting."
    - name: "avg_subscriber_count"
      expr: AVG(CAST(subscriber_count AS DOUBLE))
      comment: "Average subscriber count per OTT platform. Benchmarks platform scale — informs investment prioritization and platform development strategy."
    - name: "total_arpu"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Sum of ARPU across all platforms (portfolio-level revenue proxy). Used alongside subscriber counts to estimate total revenue potential."
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across OTT platforms. Core monetization efficiency KPI — directly informs pricing strategy and subscriber value benchmarking."
    - name: "avg_base_subscription_price"
      expr: AVG(CAST(base_subscription_price AS DOUBLE))
      comment: "Average base subscription price across platforms. Tracks pricing positioning — used in competitive analysis and pricing strategy reviews."
    - name: "avg_sla_uptime_target_pct"
      expr: AVG(CAST(sla_uptime_target_pct AS DOUBLE))
      comment: "Average SLA uptime target across OTT platforms. Measures contractual reliability commitments — below-target values trigger infrastructure investment decisions."
    - name: "dai_enabled_platforms"
      expr: COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END)
      comment: "Number of OTT platforms with DAI enabled. Tracks ad monetization capability coverage — directly tied to advertising revenue capacity."
    - name: "fast_channel_platforms"
      expr: COUNT(CASE WHEN fast_channel_enabled = TRUE THEN 1 END)
      comment: "Number of platforms with FAST channels enabled. Measures FAST distribution reach — a strategic growth metric for ad-supported streaming revenue."
    - name: "gdpr_applicable_platforms"
      expr: COUNT(CASE WHEN gdpr_applicable = TRUE THEN 1 END)
      comment: "Number of platforms subject to GDPR. Regulatory compliance KPI — directly tied to data governance investment and legal risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_release_window`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Release window economics and rights utilization KPIs covering pricing, revenue share, ad load, exclusivity, and window timing. Used by content licensing, distribution strategy, and finance teams."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`release_window`"
  dimensions:
    - name: "ott_platform_id"
      expr: ott_platform_id
      comment: "OTT platform for the release window — enables platform-level content economics analysis."
    - name: "partner_id"
      expr: partner_id
      comment: "Distribution partner for the release window — supports partner-level deal economics benchmarking."
    - name: "territory_scope"
      expr: territory_scope
      comment: "Geographic scope of the release window — enables territorial rights utilization analysis."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model for the window (e.g. SVOD, TVOD, AVOD) — primary revenue model segmentation dimension."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the release window is exclusive — tracks exclusivity premium in deal economics."
    - name: "ad_insertion_enabled"
      expr: ad_insertion_enabled
      comment: "Whether ad insertion is enabled for this window — segments ad-monetized vs. clean windows."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol for the release window — informs technical delivery standardization."
    - name: "max_resolution"
      expr: max_resolution
      comment: "Maximum video resolution for the window — tracks quality tier distribution across release windows."
    - name: "hdr_enabled"
      expr: hdr_enabled
      comment: "Whether HDR is enabled for this window — tracks premium quality tier adoption."
    - name: "window_open_month"
      expr: DATE_TRUNC('month', window_open_date)
      comment: "Month the release window opens — tracks content release cadence and pipeline timing."
    - name: "window_close_month"
      expr: DATE_TRUNC('month', window_close_date)
      comment: "Month the release window closes — used for rights expiration pipeline management."
    - name: "window_priority"
      expr: window_priority
      comment: "Priority ranking of the release window — used to analyze premium vs. secondary window economics."
  measures:
    - name: "total_release_windows"
      expr: COUNT(1)
      comment: "Total number of release windows in the portfolio. Baseline content distribution pipeline metric."
    - name: "total_carriage_fee_amount"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fees across all release windows. Core distribution revenue KPI — directly informs content licensing economics and financial planning."
    - name: "avg_carriage_fee_amount"
      expr: AVG(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Average carriage fee per release window. Benchmarks deal pricing — used in licensing negotiation strategy and content valuation."
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee commitments across all release windows. Measures guaranteed revenue floor — critical for financial forecasting and risk management."
    - name: "avg_revenue_share_percent"
      expr: AVG(CAST(revenue_share_percent AS DOUBLE))
      comment: "Average revenue share percentage across release windows. Tracks deal economics — directly informs content licensing strategy and partner negotiation leverage."
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per release window. Benchmarks TVOD pricing across the content portfolio — informs pricing strategy and consumer value analysis."
    - name: "avg_rental_price"
      expr: AVG(CAST(rental_price AS DOUBLE))
      comment: "Average rental price per release window. Tracks TVOD rental economics — used in pricing optimization and competitive benchmarking."
    - name: "avg_ad_load_minutes"
      expr: AVG(CAST(ad_load_minutes AS DOUBLE))
      comment: "Average ad load in minutes per release window. Measures ad inventory density — directly tied to advertising revenue potential per window."
    - name: "exclusive_windows"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive release windows. Tracks exclusivity deal volume — exclusive windows command premium pricing and are a key competitive differentiator."
    - name: "exclusivity_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of release windows that are exclusive. Measures exclusivity strategy execution — high rates indicate premium content positioning and competitive moat strength."
    - name: "ad_insertion_enabled_windows"
      expr: COUNT(CASE WHEN ad_insertion_enabled = TRUE THEN 1 END)
      comment: "Number of release windows with ad insertion enabled. Tracks ad-monetized content distribution volume — directly tied to advertising revenue capacity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_streaming_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Streaming endpoint infrastructure KPIs covering capacity, SLA performance, cost efficiency, security posture, and operational health. Used by streaming operations, infrastructure, and finance teams."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`streaming_endpoint`"
  dimensions:
    - name: "ott_platform_id"
      expr: ott_platform_id
      comment: "OTT platform served by the endpoint — enables platform-level infrastructure analysis."
    - name: "territory_id"
      expr: territory_id
      comment: "Territory served by the endpoint — supports geographic infrastructure capacity planning."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the endpoint — primary health dimension for infrastructure monitoring."
    - name: "streaming_protocol"
      expr: streaming_protocol
      comment: "Streaming protocol supported by the endpoint — informs protocol standardization and compatibility analysis."
    - name: "geo_restriction_mode"
      expr: geo_restriction_mode
      comment: "Geographic restriction mode applied — tracks rights enforcement configuration across endpoints."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether DAI is enabled on the endpoint — segments ad-monetization capable infrastructure."
    - name: "ipv6_enabled"
      expr: ipv6_enabled
      comment: "Whether IPv6 is enabled — tracks network modernization progress across the endpoint fleet."
    - name: "token_authentication_scheme"
      expr: token_authentication_scheme
      comment: "Token authentication scheme used — tracks security posture standardization across endpoints."
    - name: "provisioned_date_month"
      expr: DATE_TRUNC('month', provisioned_date)
      comment: "Month the endpoint was provisioned — tracks infrastructure fleet growth and vintage."
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total number of streaming endpoints in the fleet. Baseline infrastructure scale metric for capacity planning."
    - name: "active_endpoints"
      expr: COUNT(CASE WHEN operational_status = 'active' THEN 1 END)
      comment: "Number of endpoints in active operational status. Tracks live streaming capacity — directly tied to audience reach and SLA delivery capability."
    - name: "active_endpoint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN operational_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints that are operationally active. Infrastructure health KPI — low rates signal capacity risk and potential SLA breaches."
    - name: "total_bandwidth_limit_gbps"
      expr: SUM(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Total provisioned bandwidth capacity across all endpoints in Gbps. Measures aggregate streaming capacity — directly informs infrastructure investment and peak load planning."
    - name: "avg_bandwidth_limit_gbps"
      expr: AVG(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Average bandwidth limit per endpoint in Gbps. Benchmarks endpoint capacity — used in infrastructure sizing and cost optimization decisions."
    - name: "avg_max_bitrate_mbps"
      expr: AVG(CAST(max_bitrate_mbps AS DOUBLE))
      comment: "Average maximum bitrate per endpoint in Mbps. Tracks quality delivery capability — informs decisions on quality tier support and infrastructure upgrades."
    - name: "total_cost_per_gb"
      expr: SUM(CAST(cost_per_gb AS DOUBLE))
      comment: "Sum of cost-per-GB rates across endpoints (portfolio cost exposure proxy). Used alongside bandwidth metrics to estimate total CDN delivery cost."
    - name: "avg_cost_per_gb"
      expr: AVG(CAST(cost_per_gb AS DOUBLE))
      comment: "Average CDN delivery cost per GB across endpoints. Core infrastructure cost efficiency KPI — directly informs CDN vendor negotiations and cost optimization strategy."
    - name: "avg_sla_uptime_target_percent"
      expr: AVG(CAST(sla_uptime_target_percent AS DOUBLE))
      comment: "Average SLA uptime target across all streaming endpoints. Measures contractual reliability commitments — below-target values trigger infrastructure investment and vendor escalation."
    - name: "dai_enabled_endpoints"
      expr: COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END)
      comment: "Number of endpoints with DAI enabled. Tracks ad-monetization infrastructure coverage — directly tied to advertising revenue delivery capacity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution partner portfolio KPIs covering subscriber reach, SLA commitments, contract health, and technical capability. Used by distribution business development, operations, and executive teams."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`partner`"
  dimensions:
    - name: "territory_id"
      expr: territory_id
      comment: "Territory in which the partner operates — primary geographic dimension for partner portfolio analysis."
    - name: "carriage_fee_model"
      expr: carriage_fee_model
      comment: "Fee model used with the partner (e.g. flat, per-subscriber) — informs deal economics benchmarking."
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider used by the partner — tracks CDN ecosystem concentration and vendor dependency."
    - name: "drm_capability"
      expr: drm_capability
      comment: "DRM capability of the partner — tracks rights protection technology coverage across the partner network."
    - name: "blackout_capability_flag"
      expr: blackout_capability_flag
      comment: "Whether the partner supports blackout enforcement — critical for rights compliance in sports and live event distribution."
    - name: "dai_support_flag"
      expr: dai_support_flag
      comment: "Whether the partner supports dynamic ad insertion — identifies ad-monetization capable partners."
    - name: "must_carry_obligation_flag"
      expr: must_carry_obligation_flag
      comment: "Whether the partner has must-carry obligations — flags regulatory carriage requirements."
    - name: "qos_monitoring_enabled_flag"
      expr: qos_monitoring_enabled_flag
      comment: "Whether QoS monitoring is enabled for the partner — tracks operational visibility coverage."
    - name: "headquarters_state_province"
      expr: headquarters_state_province
      comment: "State or province of partner headquarters — supports regional partner distribution analysis."
    - name: "contract_end_month"
      expr: DATE_TRUNC('month', contract_end_date)
      comment: "Month the partner contract expires — critical for renewal pipeline management and revenue continuity planning."
  measures:
    - name: "total_partners"
      expr: COUNT(1)
      comment: "Total number of distribution partners. Baseline network breadth metric for distribution strategy reviews."
    - name: "total_subscriber_reach"
      expr: SUM(CAST(subscriber_reach_estimate AS DOUBLE))
      comment: "Total estimated subscriber reach across all distribution partners. Primary audience scale KPI — directly tied to advertising inventory valuation and content licensing economics."
    - name: "avg_subscriber_reach"
      expr: AVG(CAST(subscriber_reach_estimate AS DOUBLE))
      comment: "Average subscriber reach per distribution partner. Benchmarks partner scale — informs prioritization of partner investment and negotiation resources."
    - name: "avg_sla_uptime_target_percent"
      expr: AVG(CAST(sla_uptime_target_percent AS DOUBLE))
      comment: "Average SLA uptime target across all partners. Measures contractual reliability commitments — below-target values trigger partner performance reviews and SLA renegotiation."
    - name: "dai_capable_partners"
      expr: COUNT(CASE WHEN dai_support_flag = TRUE THEN 1 END)
      comment: "Number of partners supporting dynamic ad insertion. Tracks ad monetization network coverage — directly tied to advertising revenue delivery capacity."
    - name: "dai_capability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_support_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with DAI capability. Measures ad monetization infrastructure coverage — a strategic KPI for advertising revenue growth planning."
    - name: "blackout_capable_partners"
      expr: COUNT(CASE WHEN blackout_capability_flag = TRUE THEN 1 END)
      comment: "Number of partners with blackout enforcement capability. Rights compliance KPI — insufficient blackout coverage creates legal exposure in sports and live event rights."
    - name: "qos_monitored_partners"
      expr: COUNT(CASE WHEN qos_monitoring_enabled_flag = TRUE THEN 1 END)
      comment: "Number of partners with QoS monitoring enabled. Operational visibility KPI — unmonitored partners create blind spots in SLA compliance and viewer experience management."
    - name: "qos_monitoring_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qos_monitoring_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of partners with QoS monitoring enabled. Measures operational visibility coverage — low rates signal risk of undetected SLA breaches and viewer experience degradation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`distribution_cdn_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CDN configuration portfolio KPIs covering cost efficiency, capacity, security posture, SLA commitments, and operational health. Used by streaming infrastructure, operations, and finance teams."
  source: "`vibe_media_broadcasting_v1`.`distribution`.`cdn_configuration`"
  dimensions:
    - name: "cdn_provider"
      expr: cdn_provider
      comment: "CDN provider name — primary dimension for vendor-level cost and performance benchmarking."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the CDN configuration — used to filter active vs. inactive configurations."
    - name: "geo_blocking_enabled"
      expr: geo_blocking_enabled
      comment: "Whether geo-blocking is enabled — tracks rights enforcement configuration across CDN deployments."
    - name: "geo_blocking_mode"
      expr: geo_blocking_mode
      comment: "Mode of geo-blocking applied — supports rights compliance configuration analysis."
    - name: "token_authentication_enabled"
      expr: token_authentication_enabled
      comment: "Whether token authentication is enabled — tracks security posture across CDN configurations."
    - name: "compression_enabled"
      expr: compression_enabled
      comment: "Whether compression is enabled — tracks bandwidth optimization adoption across CDN configurations."
    - name: "http2_enabled"
      expr: http2_enabled
      comment: "Whether HTTP/2 is enabled — tracks protocol modernization progress across CDN fleet."
    - name: "ott_platform_id"
      expr: ott_platform_id
      comment: "OTT platform served by this CDN configuration — enables platform-level CDN cost attribution."
    - name: "provisioned_date_month"
      expr: DATE_TRUNC('month', provisioned_date)
      comment: "Month the CDN configuration was provisioned — tracks fleet growth and vintage."
  measures:
    - name: "total_cdn_configurations"
      expr: COUNT(1)
      comment: "Total number of CDN configurations in the fleet. Baseline infrastructure scale metric."
    - name: "total_bandwidth_limit_gbps"
      expr: SUM(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Total provisioned CDN bandwidth capacity in Gbps. Measures aggregate delivery capacity — directly informs infrastructure investment and peak traffic planning."
    - name: "avg_bandwidth_limit_gbps"
      expr: AVG(CAST(bandwidth_limit_gbps AS DOUBLE))
      comment: "Average bandwidth limit per CDN configuration in Gbps. Benchmarks configuration capacity — used in infrastructure sizing and cost optimization."
    - name: "avg_cost_per_gb"
      expr: AVG(CAST(cost_per_gb AS DOUBLE))
      comment: "Average CDN delivery cost per GB. Core cost efficiency KPI — directly informs CDN vendor negotiations and total delivery cost forecasting."
    - name: "total_cost_per_gb"
      expr: SUM(CAST(cost_per_gb AS DOUBLE))
      comment: "Sum of cost-per-GB rates across all CDN configurations (portfolio cost exposure proxy). Used alongside bandwidth metrics to estimate total CDN spend."
    - name: "avg_sla_uptime_target_percent"
      expr: AVG(CAST(sla_uptime_target_percent AS DOUBLE))
      comment: "Average SLA uptime target across CDN configurations. Measures contractual reliability commitments — below-target values trigger vendor escalation and infrastructure investment."
    - name: "token_auth_enabled_configs"
      expr: COUNT(CASE WHEN token_authentication_enabled = TRUE THEN 1 END)
      comment: "Number of CDN configurations with token authentication enabled. Security posture KPI — configurations without token auth are vulnerable to content piracy and unauthorized access."
    - name: "token_auth_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN token_authentication_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CDN configurations with token authentication enabled. Measures content security coverage — low rates signal piracy risk and potential rights violation exposure."
    - name: "geo_blocking_enabled_configs"
      expr: COUNT(CASE WHEN geo_blocking_enabled = TRUE THEN 1 END)
      comment: "Number of CDN configurations with geo-blocking enabled. Rights compliance KPI — geo-blocking is required for territorial rights enforcement across distribution agreements."
$$;