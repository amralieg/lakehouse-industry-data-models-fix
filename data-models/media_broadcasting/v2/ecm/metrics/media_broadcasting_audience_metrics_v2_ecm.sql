-- Metric views for domain: audience | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_nielsen_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core Nielsen audience measurement KPIs tracking household ratings, GRP delivery, reach, and demographic performance across channels and dayparts. Primary steering metric for programming and sales teams."
  source: "`vibe_media_broadcasting_v1`.`audience`.`nielsen_rating`"
  dimensions:
    - name: "air_date"
      expr: air_date
      comment: "Date the program aired, used for trend analysis and sweeps period comparisons."
    - name: "sweeps_period_flag"
      expr: sweeps_period_flag
      comment: "Indicates whether the rating was recorded during a Nielsen sweeps period, critical for rate card and upfront negotiations."
    - name: "nielsen_report_week"
      expr: nielsen_report_week
      comment: "Nielsen report week identifier for weekly audience trend analysis."
    - name: "source_code"
      expr: source_code
      comment: "Source system code identifying the originating data feed for lineage and reconciliation."
  measures:
    - name: "avg_household_rating"
      expr: AVG(CAST(household_rating AS DOUBLE))
      comment: "Average household rating across all measured programs. Core currency metric for advertising rate negotiations and programming decisions."
    - name: "avg_household_share"
      expr: AVG(CAST(household_share AS DOUBLE))
      comment: "Average household share (percentage of TVs in use tuned to this program). Indicates competitive strength relative to other programming in the same timeslot."
    - name: "total_grp"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total Gross Rating Points delivered. Primary currency for advertising campaign delivery and guarantee reconciliation."
    - name: "total_trp"
      expr: SUM(CAST(trp AS DOUBLE))
      comment: "Total Target Rating Points delivered against the target demographic. Used for demographic-specific campaign performance evaluation."
    - name: "avg_demo_a18_49_rating"
      expr: AVG(CAST(demo_a18_49_rating AS DOUBLE))
      comment: "Average Adults 18-49 rating, the primary advertising demographic for most broadcast and cable networks. Drives CPM pricing and upfront deal values."
    - name: "avg_demo_a25_54_rating"
      expr: AVG(CAST(demo_a25_54_rating AS DOUBLE))
      comment: "Average Adults 25-54 rating, key demographic for news and premium content advertisers."
    - name: "avg_demo_w18_49_rating"
      expr: AVG(CAST(demo_w18_49_rating AS DOUBLE))
      comment: "Average Women 18-49 rating, critical demographic for lifestyle, beauty, and consumer packaged goods advertisers."
    - name: "avg_demo_m18_49_rating"
      expr: AVG(CAST(demo_m18_49_rating AS DOUBLE))
      comment: "Average Men 18-49 rating, key demographic for sports, automotive, and technology advertisers."
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total audience impressions delivered. Bridges traditional ratings currency to digital impression-based buying for cross-platform deals."
    - name: "avg_hut_level"
      expr: AVG(CAST(hut_level AS DOUBLE))
      comment: "Average Households Using Television level. Baseline universe metric indicating overall TV consumption in the market during the measured period."
    - name: "avg_put_level"
      expr: AVG(CAST(put_level AS DOUBLE))
      comment: "Average Persons Using Television level. Companion to HUT for person-based audience universe sizing."
    - name: "avg_cume_audience"
      expr: AVG(CAST(cume_audience AS DOUBLE))
      comment: "Average cumulative (unduplicated) audience across measured programs. Indicates total unique reach potential for programming and sponsorship valuation."
    - name: "avg_time_spent_viewing_min"
      expr: AVG(CAST(time_spent_viewing_min AS DOUBLE))
      comment: "Average time spent viewing in minutes. Engagement depth metric used to evaluate content stickiness and inform scheduling decisions."
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average frequency of exposure. Used alongside reach to evaluate campaign effectiveness and optimize ad scheduling."
    - name: "total_universe_estimate_hh"
      expr: SUM(CAST(universe_estimate_hh AS DOUBLE))
      comment: "Total household universe estimate. Denominator for rating calculations and market sizing for affiliate and retransmission negotiations."
    - name: "rating_record_count"
      expr: COUNT(1)
      comment: "Total number of Nielsen rating records. Used to assess measurement coverage and data completeness across programs and markets."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience delivery guarantee performance KPIs tracking GRP/TRP commitments vs. actuals, makegood exposure, and guarantee value. Critical for sales operations, revenue assurance, and advertiser relationship management."
  source: "`vibe_media_broadcasting_v1`.`audience`.`guarantee`"
  dimensions:
    - name: "guarantee_number"
      expr: guarantee_number
      comment: "Unique guarantee identifier for tracking individual advertiser commitments."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Indicates whether the guarantee covers a sweeps period, which carries premium pricing and heightened delivery scrutiny."
    - name: "makegood_trigger_condition"
      expr: makegood_trigger_condition
      comment: "Condition that triggers a makegood obligation, used to categorize delivery failure types for operational analysis."
    - name: "source_code"
      expr: source_code
      comment: "Source system identifier for data lineage and reconciliation across sales and audience systems."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the guarantee period, used for cohort and seasonal analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the guarantee period, used to identify active vs. closed guarantees."
  measures:
    - name: "total_guarantee_value"
      expr: SUM(CAST(total_guarantee_value AS DOUBLE))
      comment: "Total monetary value of all audience guarantees. Primary revenue-at-risk metric for sales leadership and CFO reporting."
    - name: "total_guaranteed_grp"
      expr: SUM(CAST(guaranteed_grp AS DOUBLE))
      comment: "Total GRPs committed to advertisers across all guarantees. Baseline for delivery performance tracking."
    - name: "total_actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total GRPs actually delivered against guarantees. Compared to guaranteed GRPs to identify delivery shortfalls."
    - name: "total_delivery_shortfall_grp"
      expr: SUM(CAST(delivery_shortfall_grp AS DOUBLE))
      comment: "Total GRP shortfall across all guarantees. Directly quantifies makegood liability and revenue-at-risk from under-delivery."
    - name: "total_makegood_grp_issued"
      expr: SUM(CAST(makegood_grp_issued AS DOUBLE))
      comment: "Total makegood GRPs issued to compensate for delivery shortfalls. Measures the operational cost of under-delivery to the network."
    - name: "avg_grp_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_grp_delivered AS DOUBLE)) / NULLIF(SUM(CAST(guaranteed_grp AS DOUBLE)), 0), 2)
      comment: "Percentage of guaranteed GRPs actually delivered. Core KPI for sales operations — below 95% typically triggers makegood obligations and advertiser escalations."
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average Cost Per Rating Point across guarantees. Pricing efficiency metric used in upfront and scatter market negotiations."
    - name: "avg_guaranteed_reach"
      expr: AVG(CAST(guaranteed_reach AS DOUBLE))
      comment: "Average guaranteed reach commitment. Used to evaluate the breadth of audience delivery promises made to advertisers."
    - name: "avg_tolerance_threshold_pct"
      expr: AVG(CAST(tolerance_threshold_pct AS DOUBLE))
      comment: "Average delivery tolerance threshold percentage. Indicates the contractual buffer before makegood obligations are triggered."
    - name: "guarantee_count"
      expr: COUNT(1)
      comment: "Total number of active audience guarantees. Indicates sales pipeline depth and delivery obligation volume."
    - name: "guarantees_with_shortfall_count"
      expr: COUNT(CASE WHEN delivery_shortfall_grp > 0 THEN 1 END)
      comment: "Number of guarantees with a GRP delivery shortfall. Operational risk indicator for the makegood management team."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_reach_frequency_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reach and frequency campaign performance KPIs measuring audience coverage, exposure frequency, and cost efficiency. Used by sales, research, and programming teams to evaluate campaign effectiveness and pricing."
  source: "`vibe_media_broadcasting_v1`.`audience`.`reach_frequency_report`"
  dimensions:
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start of the measurement period for trend and seasonal analysis."
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End of the measurement period for campaign window analysis."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Sweeps period flag for premium period performance segmentation."
    - name: "is_makegood_required"
      expr: is_makegood_required
      comment: "Indicates reports where makegood is required, used to triage delivery failures."
    - name: "report_version"
      expr: report_version
      comment: "Report version identifier for tracking revisions and final vs. preliminary data."
    - name: "source_code"
      expr: source_code
      comment: "Source system code for data lineage."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total audience impressions across all reach/frequency reports. Primary volume metric for cross-platform campaign delivery."
    - name: "avg_reach_pct"
      expr: AVG(CAST(reach_pct AS DOUBLE))
      comment: "Average unduplicated reach percentage of the target universe. Measures how broadly a campaign penetrates the target audience."
    - name: "total_reach_persons"
      expr: SUM(CAST(reach_persons AS DOUBLE))
      comment: "Total unique persons reached across campaigns. Absolute audience breadth metric for advertiser reporting."
    - name: "avg_frequency"
      expr: AVG(CAST(average_frequency AS DOUBLE))
      comment: "Average number of times the target audience was exposed to the campaign. Optimal frequency drives ad recall without causing wear-out."
    - name: "total_grp"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total Gross Rating Points across all reports. Aggregate delivery currency for multi-campaign portfolio management."
    - name: "total_trp"
      expr: SUM(CAST(trp AS DOUBLE))
      comment: "Total Target Rating Points. Demographic-specific delivery metric for targeted advertising campaigns."
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average Cost Per Thousand impressions. Pricing efficiency benchmark used in media buying negotiations and competitive analysis."
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average Cost Per Rating Point. Standard pricing metric for broadcast advertising, used in upfront and scatter market rate negotiations."
    - name: "avg_audience_share_pct"
      expr: AVG(CAST(audience_share_pct AS DOUBLE))
      comment: "Average audience share percentage. Competitive positioning metric indicating the program's share of available viewers."
    - name: "avg_delivery_variance_pct"
      expr: AVG(CAST(delivery_variance_pct AS DOUBLE))
      comment: "Average delivery variance percentage against guaranteed levels. Negative variance triggers makegood obligations and affects advertiser satisfaction."
    - name: "total_effective_reach_1plus"
      expr: SUM(CAST(effective_reach_1plus AS DOUBLE))
      comment: "Total persons reached at least once (1+ frequency). Minimum effective reach threshold for brand awareness campaigns."
    - name: "total_effective_reach_3plus"
      expr: SUM(CAST(effective_reach_3plus AS DOUBLE))
      comment: "Total persons reached at least three times (3+ frequency). Standard threshold for advertising recall and persuasion effectiveness."
    - name: "report_count"
      expr: COUNT(1)
      comment: "Total number of reach/frequency reports generated. Indicates measurement coverage and reporting cadence."
    - name: "makegood_required_count"
      expr: COUNT(CASE WHEN is_makegood_required = TRUE THEN 1 END)
      comment: "Number of reports flagging a makegood requirement. Operational risk metric for the sales and traffic teams."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_cross_platform_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cross-platform audience measurement KPIs aggregating linear, OTT, MVPD, and social video impressions into unified reach and GRP metrics. Essential for demonstrating total audience value to advertisers in a fragmented media landscape."
  source: "`vibe_media_broadcasting_v1`.`audience`.`cross_platform_measurement`"
  dimensions:
    - name: "measurement_period_start"
      expr: measurement_period_start
      comment: "Start of the cross-platform measurement period for trend analysis."
    - name: "measurement_period_end"
      expr: measurement_period_end
      comment: "End of the cross-platform measurement period."
    - name: "content_genre"
      expr: content_genre
      comment: "Content genre for cross-platform audience analysis by programming type."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Sweeps period indicator for premium measurement window segmentation."
    - name: "is_mrc_accredited"
      expr: is_mrc_accredited
      comment: "MRC accreditation flag indicating measurement meets industry standards for advertising currency."
    - name: "is_data_suppressed"
      expr: is_data_suppressed
      comment: "Data suppression flag for privacy-compliant filtering of small-sample markets."
    - name: "source_code"
      expr: source_code
      comment: "Source system code for data lineage."
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total cross-platform impressions combining linear, OTT, MVPD, and social video. The unified audience currency for cross-platform advertising deals."
    - name: "total_linear_impressions"
      expr: SUM(CAST(linear_impressions AS DOUBLE))
      comment: "Total linear broadcast impressions. Baseline for understanding the contribution of traditional TV to total audience delivery."
    - name: "total_ott_streaming_impressions"
      expr: SUM(CAST(ott_streaming_impressions AS DOUBLE))
      comment: "Total OTT/streaming impressions. Tracks the growth of digital audience delivery relative to linear."
    - name: "total_mvpd_impressions"
      expr: SUM(CAST(mvpd_impressions AS DOUBLE))
      comment: "Total MVPD (cable/satellite) impressions. Measures the contribution of pay-TV distribution to total audience reach."
    - name: "total_fast_channel_impressions"
      expr: SUM(CAST(fast_channel_impressions AS DOUBLE))
      comment: "Total FAST (Free Ad-Supported Streaming TV) channel impressions. Emerging revenue stream metric for digital distribution strategy."
    - name: "total_social_video_impressions"
      expr: SUM(CAST(social_video_impressions AS DOUBLE))
      comment: "Total social video impressions. Measures the incremental reach contribution of social media distribution."
    - name: "total_deduplicated_reach"
      expr: SUM(CAST(deduplicated_reach AS DOUBLE))
      comment: "Total deduplicated cross-platform reach. True unduplicated audience size across all distribution platforms — the gold standard for cross-platform advertising value."
    - name: "avg_cross_platform_grp"
      expr: AVG(CAST(cross_platform_grp AS DOUBLE))
      comment: "Average cross-platform GRP. Unified rating currency enabling apples-to-apples comparison of linear and digital campaign delivery."
    - name: "avg_cross_platform_trp"
      expr: AVG(CAST(cross_platform_trp AS DOUBLE))
      comment: "Average cross-platform Target Rating Points. Demographic-specific cross-platform delivery metric for targeted advertising."
    - name: "avg_audience_share"
      expr: AVG(CAST(audience_share AS DOUBLE))
      comment: "Average cross-platform audience share. Competitive positioning metric across all distribution channels."
    - name: "avg_average_frequency"
      expr: AVG(CAST(average_frequency AS DOUBLE))
      comment: "Average cross-platform exposure frequency. Ensures campaigns achieve effective frequency thresholds across all platforms."
    - name: "ott_impression_share"
      expr: ROUND(100.0 * SUM(CAST(ott_streaming_impressions AS DOUBLE)) / NULLIF(SUM(CAST(total_impressions AS DOUBLE)), 0), 2)
      comment: "OTT impressions as a percentage of total cross-platform impressions. Strategic metric tracking the digital transformation of audience delivery."
    - name: "measurement_record_count"
      expr: COUNT(1)
      comment: "Total cross-platform measurement records. Indicates measurement coverage breadth across campaigns and time periods."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital audience engagement KPIs measuring viewer interaction depth, content consumption patterns, and platform behavior. Drives content investment decisions, personalization strategy, and OTT platform optimization."
  source: "`vibe_media_broadcasting_v1`.`audience`.`engagement_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of engagement event (play, pause, seek, complete, etc.) for behavioral funnel analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the engagement event for data quality filtering."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the engagement occurred, used for scheduling and ad inventory optimization."
    - name: "is_ad_event"
      expr: is_ad_event
      comment: "Distinguishes ad engagement events from content engagement events for separate monetization analysis."
    - name: "is_concurrent_stream"
      expr: is_concurrent_stream
      comment: "Indicates concurrent streaming events for capacity planning and subscription tier analysis."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Sweeps period flag for premium programming engagement analysis."
    - name: "blackout_applied"
      expr: blackout_applied
      comment: "Indicates whether a blackout rule was applied, used to measure blackout impact on engagement."
    - name: "stream_quality"
      expr: stream_quality
      comment: "Stream quality level for QoE-to-engagement correlation analysis."
    - name: "content_genre"
      expr: content_genre
      comment: "Content genre for engagement pattern analysis by programming type."
  measures:
    - name: "total_content_duration_ms"
      expr: SUM(CAST(content_duration_ms AS DOUBLE))
      comment: "Total content duration consumed in milliseconds. Aggregate watch time metric — the primary indicator of content value and platform stickiness."
    - name: "avg_engagement_depth_score"
      expr: AVG(CAST(engagement_depth_score AS DOUBLE))
      comment: "Average engagement depth score. Composite metric measuring how deeply viewers engage with content — drives content renewal and acquisition decisions."
    - name: "total_seek_events"
      expr: COUNT(CASE WHEN seek_from_position_ms > 0 THEN 1 END)
      comment: "Total seek/scrub events. High seek rates indicate viewer dissatisfaction or ad-skipping behavior, informing content editing and ad placement strategy."
    - name: "total_ad_events"
      expr: COUNT(CASE WHEN is_ad_event = TRUE THEN 1 END)
      comment: "Total ad engagement events. Measures ad exposure volume for DAI monetization reporting and advertiser delivery verification."
    - name: "total_concurrent_streams"
      expr: COUNT(CASE WHEN is_concurrent_stream = TRUE THEN 1 END)
      comment: "Total concurrent streaming events. Capacity planning metric for CDN and infrastructure scaling decisions."
    - name: "engagement_event_count"
      expr: COUNT(1)
      comment: "Total engagement events. Volume baseline for platform activity and audience measurement coverage."
    - name: "avg_content_position_ms"
      expr: AVG(CAST(content_position_ms AS DOUBLE))
      comment: "Average content position at engagement event. Indicates where in the content viewers are most active or dropping off — informs content editing and chapter placement."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_viewership_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Viewership record KPIs measuring audience tuning behavior, completion rates, and platform distribution across linear and digital channels. Core operational metric for programming, distribution, and advertising teams."
  source: "`vibe_media_broadcasting_v1`.`audience`.`viewership_record`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Broadcast date for daily and weekly viewership trend analysis."
    - name: "daypart"
      expr: daypart
      comment: "Daypart for time-of-day audience pattern analysis and scheduling optimization."
    - name: "viewing_status"
      expr: viewing_status
      comment: "Viewing status (live, VOD, DVR, etc.) for platform and consumption mode analysis."
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Sweeps period flag for premium measurement window analysis."
    - name: "blackout_applied"
      expr: blackout_applied
      comment: "Blackout applied flag to measure the audience impact of rights-based blackout rules."
    - name: "drm_protected"
      expr: drm_protected
      comment: "DRM protection flag for content security compliance reporting."
    - name: "is_authenticated"
      expr: is_authenticated
      comment: "Authentication status distinguishing authenticated (TV Everywhere) from unauthenticated viewing."
    - name: "stream_quality"
      expr: stream_quality
      comment: "Stream quality level for QoE impact analysis on viewership completion."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system for data lineage and multi-source reconciliation."
  measures:
    - name: "avg_nielsen_program_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating across viewership records. Primary programming performance metric used in scheduling and content investment decisions."
    - name: "avg_audience_share"
      expr: AVG(CAST(audience_share AS DOUBLE))
      comment: "Average audience share across viewership records. Competitive performance metric indicating the program's share of available viewers."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate AS DOUBLE))
      comment: "Average content completion rate. High completion rates indicate strong content quality and viewer satisfaction — key input for content renewal decisions."
    - name: "viewership_record_count"
      expr: COUNT(1)
      comment: "Total viewership records. Measurement coverage metric indicating the breadth of audience data collection."
    - name: "blackout_applied_count"
      expr: COUNT(CASE WHEN blackout_applied = TRUE THEN 1 END)
      comment: "Number of viewership records where a blackout was applied. Measures the audience impact of rights-based blackout rules on distribution reach."
    - name: "authenticated_view_count"
      expr: COUNT(CASE WHEN is_authenticated = TRUE THEN 1 END)
      comment: "Number of authenticated (TV Everywhere) viewing sessions. Tracks MVPD authentication adoption and subscriber engagement with authenticated streaming."
    - name: "authenticated_view_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_authenticated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of viewing sessions that are authenticated. Measures TV Everywhere adoption and the health of MVPD subscriber engagement."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_demographic_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demographic segment portfolio KPIs measuring audience universe sizes, CPM indices, and GRP weight factors across key advertising demographics. Used by sales and research teams to price inventory and target campaigns."
  source: "`vibe_media_broadcasting_v1`.`audience`.`demographic_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Demographic segment name for human-readable reporting and sales collateral."
    - name: "gender_qualifier"
      expr: gender_qualifier
      comment: "Gender qualifier for demographic targeting analysis."
    - name: "income_quintile"
      expr: income_quintile
      comment: "Income quintile for premium audience segment identification and CPM premium analysis."
    - name: "is_key_demo"
      expr: is_key_demo
      comment: "Indicates whether this is a key advertising demographic (e.g., A18-49). Key demos command premium CPMs and drive upfront deal structures."
    - name: "is_nielsen_standard_cell"
      expr: is_nielsen_standard_cell
      comment: "Indicates Nielsen standard measurement cell status, which determines whether the segment can be used as advertising currency."
    - name: "is_children_segment"
      expr: is_children_segment
      comment: "Children segment flag for COPPA compliance filtering and restricted advertising inventory management."
    - name: "sweeps_priority"
      expr: sweeps_priority
      comment: "Sweeps priority flag indicating segments that receive enhanced measurement during sweeps periods."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment for national vs. local market analysis."
  measures:
    - name: "total_universe_estimate"
      expr: SUM(CAST(universe_estimate AS DOUBLE))
      comment: "Total audience universe estimate across demographic segments. Aggregate addressable audience size for advertising inventory valuation."
    - name: "avg_cpm_index"
      expr: AVG(CAST(cpm_index AS DOUBLE))
      comment: "Average CPM index across demographic segments. Pricing premium indicator — segments above 100 command above-average CPMs in the advertising marketplace."
    - name: "avg_grp_weight_factor"
      expr: AVG(CAST(grp_weight_factor AS DOUBLE))
      comment: "Average GRP weight factor. Used in audience measurement weighting to ensure representative sample composition."
    - name: "avg_reach_potential_pct"
      expr: AVG(CAST(reach_potential_pct AS DOUBLE))
      comment: "Average reach potential percentage. Indicates the maximum addressable reach for each demographic segment, informing campaign planning and guarantee setting."
    - name: "key_demo_segment_count"
      expr: COUNT(CASE WHEN is_key_demo = TRUE THEN 1 END)
      comment: "Number of key advertising demographic segments. Indicates the breadth of premium inventory available for upfront and scatter market sales."
    - name: "children_segment_count"
      expr: COUNT(CASE WHEN is_children_segment = TRUE THEN 1 END)
      comment: "Number of children demographic segments. Compliance metric for COPPA-restricted advertising inventory management."
    - name: "total_segment_count"
      expr: COUNT(1)
      comment: "Total number of demographic segments defined. Indicates the granularity of audience targeting capability available to advertisers."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_clean_room_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data clean room match rate and privacy compliance KPIs for first-party data partnerships. Critical for addressable advertising, audience extension, and privacy-safe data collaboration with advertisers and DSPs."
  source: "`vibe_media_broadcasting_v1`.`audience`.`clean_room_match`"
  dimensions:
    - name: "clean_room_provider"
      expr: clean_room_provider
      comment: "Clean room technology provider (LiveRamp, InfoSum, Habu, etc.) for vendor performance comparison."
    - name: "match_type"
      expr: match_type
      comment: "Type of identity match (deterministic, probabilistic, etc.) for match quality segmentation."
    - name: "match_key_type"
      expr: match_key_type
      comment: "Match key type (email hash, device ID, etc.) for identity resolution methodology analysis."
    - name: "match_status"
      expr: match_status
      comment: "Match status for operational pipeline monitoring."
    - name: "privacy_framework"
      expr: privacy_framework
      comment: "Privacy framework (GDPR, CCPA, etc.) governing the clean room match for compliance reporting."
    - name: "differential_privacy_applied_flag"
      expr: differential_privacy_applied_flag
      comment: "Indicates whether differential privacy was applied, used for privacy-preserving analytics compliance."
    - name: "privacy_threshold_met_flag"
      expr: privacy_threshold_met_flag
      comment: "Indicates whether the privacy threshold was met, filtering out suppressed matches for compliant reporting."
    - name: "activation_platform"
      expr: activation_platform
      comment: "Platform where matched audiences are activated for campaign targeting."
    - name: "match_date"
      expr: match_date
      comment: "Date of the clean room match run for trend analysis of data partnership performance."
  measures:
    - name: "avg_match_rate"
      expr: AVG(CAST(match_rate AS DOUBLE))
      comment: "Average identity match rate across clean room partnerships. Primary KPI for data partnership quality — higher match rates enable more precise addressable advertising targeting."
    - name: "avg_match_rate_percent"
      expr: AVG(CAST(match_rate_percent AS DOUBLE))
      comment: "Average match rate as a percentage. Standardized match quality metric for cross-partner benchmarking."
    - name: "total_matched_record_count"
      expr: SUM(CAST(matched_record_count AS DOUBLE))
      comment: "Total matched records across all clean room runs. Absolute scale of addressable audience available for targeted advertising."
    - name: "total_overlap_count"
      expr: SUM(CAST(overlap_count AS DOUBLE))
      comment: "Total audience overlap count between first-party datasets. Measures the size of the addressable audience intersection for campaign targeting."
    - name: "total_overlap_universe_size"
      expr: SUM(CAST(overlap_universe_size AS DOUBLE))
      comment: "Total universe size across clean room matches. Denominator for match rate calculations and addressable audience sizing."
    - name: "privacy_compliant_match_count"
      expr: COUNT(CASE WHEN privacy_threshold_met_flag = TRUE THEN 1 END)
      comment: "Number of clean room matches meeting privacy thresholds. Compliance metric ensuring only privacy-safe matches are used for advertising activation."
    - name: "total_match_runs"
      expr: COUNT(1)
      comment: "Total clean room match runs. Indicates the volume and cadence of data partnership activity."
    - name: "privacy_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN privacy_threshold_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clean room matches meeting privacy thresholds. Regulatory compliance KPI for GDPR/CCPA-governed data partnerships."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_viewability_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad viewability and invalid traffic (IVT) KPIs for MRC/IAB-standard measurement. Used by sales and ad operations to validate impression quality, reconcile upfront guarantees, and manage makegood obligations for digital advertising."
  source: "`vibe_media_broadcasting_v1`.`audience`.`viewability_record`"
  dimensions:
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start of the viewability measurement period for trend analysis."
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End of the viewability measurement period."
    - name: "measurement_standard"
      expr: measurement_standard
      comment: "Viewability measurement standard (MRC, IAB, etc.) for methodology-based segmentation."
    - name: "measurement_vendor"
      expr: measurement_vendor
      comment: "Third-party measurement vendor for vendor performance comparison."
    - name: "guarantee_met_flag"
      expr: guarantee_met_flag
      comment: "Indicates whether the viewability guarantee was met, used to identify makegood obligations."
    - name: "makegood_required_flag"
      expr: makegood_required_flag
      comment: "Indicates whether a makegood is required due to viewability shortfall."
    - name: "is_verified"
      expr: is_verified
      comment: "Indicates whether the viewability measurement has been verified by the measurement vendor."
  measures:
    - name: "avg_viewability_rate"
      expr: AVG(CAST(viewability_rate AS DOUBLE))
      comment: "Average viewability rate across all measured campaigns. MRC standard requires 50% of pixels in view for 2 seconds — below-threshold rates trigger makegood obligations and affect advertiser trust."
    - name: "total_viewable_impressions"
      expr: SUM(CAST(viewable_impressions AS DOUBLE))
      comment: "Total viewable impressions delivered. The billable impression currency for viewability-guaranteed digital advertising deals."
    - name: "total_measured_impressions"
      expr: SUM(CAST(measured_impressions AS DOUBLE))
      comment: "Total measured impressions. Denominator for viewability rate calculations and measurability reporting."
    - name: "avg_measurable_rate"
      expr: AVG(CAST(measurable_rate AS DOUBLE))
      comment: "Average measurability rate. Indicates what percentage of served impressions could be measured for viewability — low measurability rates indicate technical issues with ad delivery."
    - name: "total_ivt_impressions"
      expr: SUM(CAST(ivt_impressions AS DOUBLE))
      comment: "Total invalid traffic (IVT) impressions. Fraud and bot traffic metric — high IVT rates trigger advertiser credits and supply quality investigations."
    - name: "avg_ivt_rate"
      expr: AVG(CAST(ivt_rate AS DOUBLE))
      comment: "Average invalid traffic rate. MRC-standard fraud metric — rates above 10% typically trigger advertiser credits and supply chain audits."
    - name: "avg_sivt_rate"
      expr: AVG(CAST(sivt_rate AS DOUBLE))
      comment: "Average sophisticated invalid traffic (SIVT) rate. Advanced fraud metric targeting bot networks and domain spoofing — critical for brand safety and supply quality management."
    - name: "avg_in_view_duration_seconds"
      expr: AVG(CAST(in_view_duration_seconds AS DOUBLE))
      comment: "Average in-view duration in seconds. Attention quality metric — longer in-view durations correlate with higher ad recall and brand lift."
    - name: "guarantee_met_count"
      expr: COUNT(CASE WHEN guarantee_met_flag = TRUE THEN 1 END)
      comment: "Number of viewability records where the guarantee was met. Delivery performance metric for viewability-guaranteed advertising contracts."
    - name: "makegood_required_count"
      expr: COUNT(CASE WHEN makegood_required_flag = TRUE THEN 1 END)
      comment: "Number of records requiring a makegood due to viewability shortfall. Operational liability metric for ad operations and sales teams."
    - name: "guarantee_fulfillment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN guarantee_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of viewability guarantees fulfilled. Executive KPI for digital advertising quality and advertiser satisfaction."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_dsp_usage_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DSP/streaming platform music usage KPIs tracking stream counts, revenue, royalty rates, and listener engagement by platform and territory. Used by music label and rights teams to monitor digital distribution performance and royalty obligations."
  source: "`vibe_media_broadcasting_v1`.`audience`.`dsp_usage_report`"
  dimensions:
    - name: "dsp_platform"
      expr: dsp_platform
      comment: "DSP platform name (Spotify, Apple Music, YouTube Music, etc.) for platform-level performance comparison."
    - name: "dsp_name"
      expr: dsp_name
      comment: "DSP name for detailed platform identification."
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period for trend analysis."
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the reporting period."
    - name: "territory"
      expr: territory
      comment: "Territory for geographic revenue and streaming analysis."
    - name: "stream_type"
      expr: stream_type
      comment: "Stream type (on-demand, radio, etc.) for monetization model analysis."
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Subscription tier (premium, free, etc.) for per-stream rate and revenue analysis."
    - name: "monetization_model"
      expr: monetization_model
      comment: "Monetization model for revenue attribution analysis."
    - name: "is_interactive_flag"
      expr: is_interactive_flag
      comment: "Interactive vs. non-interactive streaming flag, which determines royalty rate applicability under the Music Modernization Act."
    - name: "is_final_flag"
      expr: is_final_flag
      comment: "Indicates final vs. preliminary report data for reconciliation and royalty payment processing."
  measures:
    - name: "total_stream_count"
      expr: SUM(CAST(stream_count AS DOUBLE))
      comment: "Total streams across all DSP platforms. Primary volume metric for music catalog performance and chart eligibility."
    - name: "total_monetized_stream_count"
      expr: SUM(CAST(monetized_stream_count AS DOUBLE))
      comment: "Total monetized streams. Revenue-generating subset of total streams — the basis for royalty calculations."
    - name: "total_unique_listener_count"
      expr: SUM(CAST(unique_listener_count AS DOUBLE))
      comment: "Total unique listeners across platforms. Audience reach metric for artist popularity and catalog valuation."
    - name: "total_gross_revenue_amount"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue from DSP streaming. Top-line digital revenue metric for music catalog P&L reporting."
    - name: "total_net_revenue_amount"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after DSP fees and deductions. Bottom-line digital revenue metric for label profitability analysis."
    - name: "total_estimated_royalty_amount"
      expr: SUM(CAST(estimated_royalty_amount AS DOUBLE))
      comment: "Total estimated royalty obligations from streaming. Liability metric for rights holder payment planning and cash flow management."
    - name: "avg_per_stream_rate"
      expr: AVG(CAST(per_stream_rate AS DOUBLE))
      comment: "Average per-stream royalty rate. Benchmarking metric for DSP contract negotiations and MMA compliance monitoring."
    - name: "avg_completion_rate"
      expr: AVG(CAST(completion_rate AS DOUBLE))
      comment: "Average stream completion rate. Content quality and engagement metric — higher completion rates indicate stronger catalog performance."
    - name: "avg_skip_rate"
      expr: AVG(CAST(skip_rate AS DOUBLE))
      comment: "Average skip rate. Inverse engagement metric — high skip rates indicate poor content-audience fit and may affect algorithmic playlist placement."
    - name: "total_complete_play_count"
      expr: SUM(CAST(complete_play_count AS DOUBLE))
      comment: "Total complete plays (full stream without skip). Quality engagement metric used in royalty calculations and chart methodology."
    - name: "monetization_rate"
      expr: ROUND(100.0 * SUM(CAST(monetized_stream_count AS DOUBLE)) / NULLIF(SUM(CAST(stream_count AS DOUBLE)), 0), 2)
      comment: "Percentage of streams that are monetized. Revenue efficiency metric indicating the proportion of catalog consumption generating royalty income."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_sweeps_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nielsen sweeps period operational KPIs tracking diary return rates, PPM compliance, and measurement coverage. Used by research and programming teams to manage the most critical audience measurement windows that set advertising rates."
  source: "`vibe_media_broadcasting_v1`.`audience`.`sweeps_period`"
  dimensions:
    - name: "sweep_name"
      expr: sweep_name
      comment: "Sweeps period name (e.g., November Sweeps) for period identification and year-over-year comparison."
    - name: "sweep_month"
      expr: sweep_month
      comment: "Sweeps month for seasonal analysis of audience measurement performance."
    - name: "sweep_year"
      expr: sweep_year
      comment: "Sweeps year for annual trend analysis."
    - name: "grp_guarantee_applicable"
      expr: grp_guarantee_applicable
      comment: "Indicates whether GRP guarantees apply during this sweeps period, linking measurement to advertising contract obligations."
    - name: "trp_guarantee_applicable"
      expr: trp_guarantee_applicable
      comment: "Indicates whether TRP guarantees apply during this sweeps period."
    - name: "upfront_rate_card_applicable"
      expr: upfront_rate_card_applicable
      comment: "Indicates whether upfront rate card pricing applies, linking sweeps performance to advertising revenue."
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Regulatory reporting requirement flag for compliance tracking."
    - name: "is_special_programming_flag"
      expr: is_special_programming_flag
      comment: "Special programming flag indicating stunting or event programming that may inflate ratings."
  measures:
    - name: "avg_diary_return_rate_pct"
      expr: AVG(CAST(diary_return_rate_pct AS DOUBLE))
      comment: "Average diary return rate percentage. Data quality metric for paper diary markets — low return rates reduce sample reliability and can invalidate sweeps ratings."
    - name: "avg_ppm_compliance_rate_pct"
      expr: AVG(CAST(ppm_compliance_rate_pct AS DOUBLE))
      comment: "Average PPM (Portable People Meter) compliance rate. Panel quality metric — low compliance rates indicate panelist non-cooperation and measurement accuracy risk."
    - name: "sweeps_period_count"
      expr: COUNT(1)
      comment: "Total sweeps periods tracked. Coverage metric for measurement calendar completeness."
    - name: "guarantee_applicable_count"
      expr: COUNT(CASE WHEN grp_guarantee_applicable = TRUE THEN 1 END)
      comment: "Number of sweeps periods with GRP guarantee applicability. Indicates the volume of advertising contracts tied to sweeps measurement performance."
    - name: "special_programming_count"
      expr: COUNT(CASE WHEN is_special_programming_flag = TRUE THEN 1 END)
      comment: "Number of sweeps periods with special programming (stunting). Compliance metric — excessive stunting can trigger FCC scrutiny and advertiser complaints about inflated ratings."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_market_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market coverage and TV household universe KPIs measuring audience reach potential, OTT penetration, and market demographics. Used by distribution, sales, and research teams to size advertising markets and negotiate retransmission and carriage agreements."
  source: "`vibe_media_broadcasting_v1`.`audience`.`market_coverage`"
  dimensions:
    - name: "market_name"
      expr: market_name
      comment: "Market name for geographic performance analysis."
    - name: "dma_rank"
      expr: dma_rank
      comment: "DMA rank for market size segmentation (top 10, top 25, top 50, etc.)."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the market for multilingual programming and advertising strategy."
    - name: "time_zone"
      expr: time_zone
      comment: "Time zone for scheduling and daypart analysis."
    - name: "must_carry_applicable"
      expr: must_carry_applicable
      comment: "Must-carry status for regulatory distribution obligation analysis."
    - name: "retransmission_consent_applicable"
      expr: retransmission_consent_applicable
      comment: "Retransmission consent applicability for carriage fee negotiation analysis."
    - name: "blackout_rule_applicable"
      expr: blackout_rule_applicable
      comment: "Blackout rule applicability for sports rights and distribution compliance analysis."
    - name: "sweeps_participation"
      expr: sweeps_participation
      comment: "Sweeps participation flag for measurement coverage analysis."
  measures:
    - name: "total_tv_household_universe"
      expr: SUM(CAST(tv_household_universe AS DOUBLE))
      comment: "Total TV household universe across all markets. Aggregate addressable audience for advertising inventory valuation and retransmission consent negotiations."
    - name: "total_population_universe"
      expr: SUM(CAST(population_universe AS DOUBLE))
      comment: "Total population universe across markets. Demographic reach metric for national and local advertising planning."
    - name: "avg_cable_penetration_rate"
      expr: AVG(CAST(cable_penetration_rate AS DOUBLE))
      comment: "Average cable penetration rate across markets. Distribution reach metric for cable network carriage negotiations."
    - name: "avg_ott_penetration_rate"
      expr: AVG(CAST(ott_penetration_rate AS DOUBLE))
      comment: "Average OTT penetration rate across markets. Digital transformation metric indicating the shift from linear to streaming consumption."
    - name: "avg_hispanic_tv_household_pct"
      expr: AVG(CAST(hispanic_tv_household_pct AS DOUBLE))
      comment: "Average Hispanic TV household percentage. Demographic composition metric for Spanish-language programming and multicultural advertising strategy."
    - name: "avg_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income across markets. Audience quality metric used in CPM premium pricing for affluent market advertising."
    - name: "avg_hut_base_estimate"
      expr: AVG(CAST(hut_base_estimate AS DOUBLE))
      comment: "Average HUT base estimate. Baseline TV usage metric for rating point calculations and market comparison."
    - name: "market_count"
      expr: COUNT(1)
      comment: "Total number of markets covered. Distribution footprint metric for national reach reporting."
    - name: "must_carry_market_count"
      expr: COUNT(CASE WHEN must_carry_applicable = TRUE THEN 1 END)
      comment: "Number of markets with must-carry obligations. Regulatory compliance metric for broadcast station distribution management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_panel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience measurement panel quality and composition KPIs. Used by research operations to monitor panel health, MRC accreditation status, and measurement reliability — the foundation of all audience currency."
  source: "`vibe_media_broadcasting_v1`.`audience`.`panel`"
  dimensions:
    - name: "panel_name"
      expr: panel_name
      comment: "Panel name for individual panel performance tracking."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the panel (national, local, DMA) for coverage analysis."
    - name: "measurement_currency_flag"
      expr: measurement_currency_flag
      comment: "Indicates whether the panel is used as advertising currency — currency panels require the highest quality standards."
    - name: "sweeps_eligible_flag"
      expr: sweeps_eligible_flag
      comment: "Sweeps eligibility flag for measurement period coverage analysis."
    - name: "streaming_measurement_flag"
      expr: streaming_measurement_flag
      comment: "Indicates whether the panel measures streaming/OTT viewing, critical for cross-platform measurement."
    - name: "out_of_home_measurement_flag"
      expr: out_of_home_measurement_flag
      comment: "Indicates whether the panel captures out-of-home viewing, which can add 5-15% to total audience estimates."
    - name: "vintage_year"
      expr: vintage_year
      comment: "Panel vintage year for tracking panel refresh cycles and sample currency."
  measures:
    - name: "total_universe_estimate"
      expr: SUM(CAST(universe_estimate AS DOUBLE))
      comment: "Total universe estimate across all panels. Aggregate audience universe for national and local market measurement."
    - name: "avg_cooperation_rate"
      expr: AVG(CAST(cooperation_rate AS DOUBLE))
      comment: "Average panel cooperation rate. Panel quality metric — low cooperation rates indicate recruitment challenges and potential sample bias affecting measurement accuracy."
    - name: "avg_sampling_error_pct"
      expr: AVG(CAST(sampling_error_pct AS DOUBLE))
      comment: "Average sampling error percentage. Statistical reliability metric — high sampling error reduces confidence in audience estimates and can invalidate advertising guarantees."
    - name: "avg_weighting_factor"
      expr: AVG(CAST(weighting_factor AS DOUBLE))
      comment: "Average panel weighting factor. Indicates the degree of statistical adjustment required to make the panel representative — large deviations from 1.0 signal sample imbalance."
    - name: "avg_min_reportable_rating"
      expr: AVG(CAST(min_reportable_rating AS DOUBLE))
      comment: "Average minimum reportable rating threshold. Determines the smallest audience that can be reliably measured — affects the granularity of local market reporting."
    - name: "currency_panel_count"
      expr: COUNT(CASE WHEN measurement_currency_flag = TRUE THEN 1 END)
      comment: "Number of panels designated as advertising currency. Indicates the breadth of accredited measurement infrastructure supporting advertising transactions."
    - name: "streaming_capable_panel_count"
      expr: COUNT(CASE WHEN streaming_measurement_flag = TRUE THEN 1 END)
      comment: "Number of panels capable of measuring streaming/OTT viewing. Strategic metric for cross-platform measurement capability assessment."
    - name: "total_panel_count"
      expr: COUNT(1)
      comment: "Total number of measurement panels. Coverage metric for measurement infrastructure completeness."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience profile quality and engagement KPIs measuring identity confidence, ad receptivity, and viewing behavior patterns. Used by data science, personalization, and addressable advertising teams to optimize targeting and content recommendations."
  source: "`vibe_media_broadcasting_v1`.`audience`.`audience_profile`"
  dimensions:
    - name: "inferred_age_band"
      expr: inferred_age_band
      comment: "Inferred age band for demographic targeting analysis."
    - name: "inferred_gender"
      expr: inferred_gender
      comment: "Inferred gender for demographic targeting analysis."
    - name: "income_band"
      expr: income_band
      comment: "Income band for premium audience segment identification."
    - name: "platform_preference"
      expr: platform_preference
      comment: "Preferred viewing platform for platform-specific content and advertising strategy."
    - name: "content_affinity_genre"
      expr: content_affinity_genre
      comment: "Content genre affinity for personalization and targeted advertising."
    - name: "ccpa_opt_out"
      expr: ccpa_opt_out
      comment: "CCPA opt-out status for privacy-compliant audience segmentation and addressable advertising eligibility."
    - name: "coppa_protected"
      expr: coppa_protected
      comment: "COPPA protection flag for children's audience compliance filtering."
    - name: "data_clean_room_eligible"
      expr: data_clean_room_eligible
      comment: "Clean room eligibility flag for addressable advertising and data partnership activation."
    - name: "hut_eligible"
      expr: hut_eligible
      comment: "HUT eligibility flag for Nielsen measurement panel inclusion."
    - name: "sweeps_period_flag"
      expr: sweeps_period_flag
      comment: "Sweeps period flag for premium measurement window audience analysis."
  measures:
    - name: "avg_ad_receptivity_score"
      expr: AVG(CAST(ad_receptivity_score AS DOUBLE))
      comment: "Average ad receptivity score across audience profiles. Targeting quality metric — higher scores indicate audiences more likely to engage with advertising, enabling premium CPM pricing."
    - name: "avg_identity_confidence_score"
      expr: AVG(CAST(identity_confidence_score AS DOUBLE))
      comment: "Average identity confidence score. Data quality metric for addressable advertising — low confidence scores reduce targeting precision and addressable CPM premiums."
    - name: "avg_nielsen_grp_index"
      expr: AVG(CAST(nielsen_grp_index AS DOUBLE))
      comment: "Average Nielsen GRP index across profiles. Indicates the relative audience value of the profile pool for advertising currency purposes."
    - name: "avg_trp_index"
      expr: AVG(CAST(trp_index AS DOUBLE))
      comment: "Average TRP index across profiles. Demographic targeting efficiency metric for campaign planning."
    - name: "avg_panel_weight_factor"
      expr: AVG(CAST(panel_weight_factor AS DOUBLE))
      comment: "Average panel weight factor. Statistical representativeness metric for audience measurement accuracy."
    - name: "avg_avg_session_duration_minutes"
      expr: AVG(CAST(avg_session_duration_minutes AS DOUBLE))
      comment: "Average session duration in minutes across audience profiles. Engagement depth metric driving content investment and subscription retention strategy."
    - name: "clean_room_eligible_count"
      expr: COUNT(CASE WHEN data_clean_room_eligible = TRUE THEN 1 END)
      comment: "Number of profiles eligible for clean room data partnerships. Addressable advertising scale metric for data monetization strategy."
    - name: "ccpa_opted_out_count"
      expr: COUNT(CASE WHEN ccpa_opt_out = TRUE THEN 1 END)
      comment: "Number of profiles with CCPA opt-out. Privacy compliance metric limiting addressable advertising inventory in California."
    - name: "addressable_audience_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_clean_room_eligible = TRUE AND ccpa_opt_out = FALSE AND coppa_protected = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audience profiles eligible for addressable advertising (clean room eligible, not CCPA opted out, not COPPA protected). Strategic metric for addressable advertising revenue potential."
    - name: "total_profile_count"
      expr: COUNT(1)
      comment: "Total audience profiles. Scale metric for addressable advertising inventory and personalization engine coverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`audience_talent_demographic_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent demographic appeal and Q-Score KPIs measuring talent awareness, favorability, and audience affinity by demographic segment. Used by programming, casting, and marketing teams to optimize talent investment and content strategy."
  source: "`vibe_media_broadcasting_v1`.`audience`.`talent_demographic_appeal`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the talent appeal measurement for trend analysis."
    - name: "measurement_vendor"
      expr: measurement_vendor
      comment: "Measurement vendor (Q Scores, YouGov, etc.) for methodology comparison."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Trend direction of talent appeal (rising, stable, declining) for proactive talent management."
    - name: "casting_recommendation_flag"
      expr: casting_recommendation_flag
      comment: "Casting recommendation flag indicating talent with strong demographic appeal for targeted programming."
  measures:
    - name: "avg_q_score"
      expr: AVG(CAST(q_score AS DOUBLE))
      comment: "Average Q Score across talent and demographic segments. Industry-standard talent appeal metric — higher Q Scores correlate with higher ratings and advertising premiums for talent-driven programming."
    - name: "avg_favorability_rating"
      expr: AVG(CAST(favorability_rating AS DOUBLE))
      comment: "Average talent favorability rating. Brand safety and audience affinity metric used in talent contract negotiations and casting decisions."
    - name: "avg_awareness_percentage"
      expr: AVG(CAST(awareness_percentage AS DOUBLE))
      comment: "Average talent awareness percentage. Reach metric indicating how widely known the talent is within the target demographic — drives marketing investment decisions."
    - name: "avg_appeal_index"
      expr: AVG(CAST(appeal_index AS DOUBLE))
      comment: "Average appeal index. Composite talent performance metric combining awareness and favorability — used to rank talent for casting and endorsement decisions."
    - name: "avg_confidence_interval"
      expr: AVG(CAST(confidence_interval AS DOUBLE))
      comment: "Average confidence interval of talent appeal measurements. Statistical reliability metric for research quality assurance."
    - name: "casting_recommended_count"
      expr: COUNT(CASE WHEN casting_recommendation_flag = TRUE THEN 1 END)
      comment: "Number of talent-demographic combinations with a casting recommendation. Talent pipeline metric for programming and casting teams."
    - name: "total_measurement_count"
      expr: COUNT(1)
      comment: "Total talent demographic appeal measurements. Coverage metric for talent research completeness."
$$;