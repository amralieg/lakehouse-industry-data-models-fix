-- Metric views for domain: audience | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core engagement and viewership metrics tracking content consumption, ad exposure, and audience interaction across linear, streaming, and on-demand platforms. Enables analysis of content performance, ad delivery, and viewer behavior patterns."
  source: "`media_broadcasting_ecm`.`audience`.`engagement_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of engagement event (play, pause, stop, ad_impression, etc.)"
    - name: "content_genre"
      expr: content_genre
      comment: "Genre classification of the content being consumed"
    - name: "daypart"
      expr: daypart
      comment: "Broadcast daypart (Early Morning, Daytime, Prime Time, Late Night, etc.)"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the engagement event for daily trend analysis"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the engagement event for monthly trend analysis"
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Flag indicating whether event occurred during Nielsen sweeps measurement period"
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Subscription tier of the viewer (free, basic, premium, etc.)"
    - name: "stream_quality"
      expr: stream_quality
      comment: "Quality level of the stream (SD, HD, 4K, etc.)"
    - name: "device_os"
      expr: device_os
      comment: "Operating system of the device used for viewing"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code of the viewer location"
    - name: "is_ad_event"
      expr: is_ad_event
      comment: "Flag indicating whether this is an advertising-related event"
    - name: "content_rating"
      expr: content_rating
      comment: "Content rating classification (TV-G, TV-PG, TV-14, TV-MA, etc.)"
  measures:
    - name: "total_engagement_events"
      expr: COUNT(1)
      comment: "Total number of engagement events recorded"
    - name: "unique_viewers"
      expr: COUNT(DISTINCT audience_profile_id)
      comment: "Distinct count of audience profiles engaging with content"
    - name: "total_content_duration_hours"
      expr: SUM(CAST(content_duration_ms AS DOUBLE)) / 3600000.0
      comment: "Total duration of content in hours (converted from milliseconds)"
    - name: "total_viewing_time_hours"
      expr: SUM(CAST(content_position_ms AS DOUBLE)) / 3600000.0
      comment: "Total time viewers spent watching content in hours"
    - name: "avg_engagement_depth_score"
      expr: AVG(CAST(engagement_depth_score AS DOUBLE))
      comment: "Average engagement depth score indicating viewer interaction intensity"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(content_position_ms AS DOUBLE) / NULLIF(CAST(content_duration_ms AS DOUBLE), 0)), 2)
      comment: "Average percentage of content completed by viewers"
    - name: "total_ad_events"
      expr: SUM(CASE WHEN is_ad_event = true THEN 1 ELSE 0 END)
      comment: "Total count of advertising-related engagement events"
    - name: "sweeps_period_events"
      expr: SUM(CASE WHEN is_sweeps_period = true THEN 1 ELSE 0 END)
      comment: "Count of events occurring during Nielsen sweeps measurement periods"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_nielsen_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nielsen measurement metrics including ratings, shares, GRPs, TRPs, reach, and frequency for broadcast and cable programming. Critical for advertising sales, program scheduling decisions, and competitive performance analysis."
  source: "`media_broadcasting_ecm`.`audience`.`nielsen_rating`"
  dimensions:
    - name: "air_date"
      expr: air_date
      comment: "Date the program aired"
    - name: "air_month"
      expr: DATE_TRUNC('month', air_date)
      comment: "Month the program aired for monthly trend analysis"
    - name: "nielsen_report_week"
      expr: nielsen_report_week
      comment: "Nielsen reporting week identifier"
    - name: "sweeps_period_flag"
      expr: sweeps_period_flag
      comment: "Flag indicating whether rating occurred during sweeps period"
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the rating record (final, preliminary, adjusted, etc.)"
    - name: "daypart_id"
      expr: daypart_id
      comment: "Foreign key to daypart dimension for time-of-day analysis"
  measures:
    - name: "total_rating_records"
      expr: COUNT(1)
      comment: "Total number of Nielsen rating records"
    - name: "avg_household_rating"
      expr: AVG(CAST(household_rating AS DOUBLE))
      comment: "Average household rating across all programs"
    - name: "avg_household_share"
      expr: AVG(CAST(household_share AS DOUBLE))
      comment: "Average household share of viewing audience"
    - name: "total_grp"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total Gross Rating Points delivered across all programs"
    - name: "total_trp"
      expr: SUM(CAST(trp AS DOUBLE))
      comment: "Total Target Rating Points delivered to target demographic"
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total audience impressions delivered"
    - name: "avg_reach_pct"
      expr: AVG(CAST(reach AS DOUBLE))
      comment: "Average reach percentage of target audience exposed at least once"
    - name: "avg_frequency"
      expr: AVG(CAST(frequency AS DOUBLE))
      comment: "Average frequency of exposure per reached viewer"
    - name: "avg_a18_49_rating"
      expr: AVG(CAST(demo_a18_49_rating AS DOUBLE))
      comment: "Average rating for Adults 18-49 key demographic"
    - name: "avg_a25_54_rating"
      expr: AVG(CAST(demo_a25_54_rating AS DOUBLE))
      comment: "Average rating for Adults 25-54 key demographic"
    - name: "avg_hut_level"
      expr: AVG(CAST(hut_level AS DOUBLE))
      comment: "Average Homes Using Television level during program airings"
    - name: "total_viewing_minutes"
      expr: SUM(CAST(time_spent_viewing_min AS DOUBLE))
      comment: "Total minutes of viewing time across all programs"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_reach_frequency_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign-level reach and frequency performance metrics for advertising delivery. Tracks guaranteed audience delivery, makegoods, and cost efficiency metrics (CPM, CPRP) essential for sales reconciliation and advertiser reporting."
  source: "`media_broadcasting_ecm`.`audience`.`reach_frequency_report`"
  dimensions:
    - name: "measurement_period_start"
      expr: measurement_period_start_date
      comment: "Start date of the measurement period"
    - name: "measurement_period_end"
      expr: measurement_period_end_date
      comment: "End date of the measurement period"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement methodology (Nielsen, Comscore, internal, etc.)"
    - name: "report_status"
      expr: report_status
      comment: "Status of the reach/frequency report (draft, final, reconciled, etc.)"
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Flag indicating whether measurement occurred during sweeps period"
    - name: "is_makegood_required"
      expr: is_makegood_required
      comment: "Flag indicating whether campaign underdelivered and requires makegood spots"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial metrics"
    - name: "report_month"
      expr: DATE_TRUNC('month', measurement_period_start_date)
      comment: "Month of the measurement period start for monthly aggregation"
  measures:
    - name: "total_campaigns_measured"
      expr: COUNT(1)
      comment: "Total number of reach/frequency reports generated"
    - name: "unique_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Distinct count of campaigns measured"
    - name: "total_impressions_delivered"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total advertising impressions delivered across all campaigns"
    - name: "total_grp_delivered"
      expr: SUM(CAST(grp AS DOUBLE))
      comment: "Total Gross Rating Points delivered across all campaigns"
    - name: "total_trp_delivered"
      expr: SUM(CAST(trp AS DOUBLE))
      comment: "Total Target Rating Points delivered to target demographics"
    - name: "avg_reach_pct"
      expr: AVG(CAST(reach_pct AS DOUBLE))
      comment: "Average percentage of target audience reached at least once"
    - name: "avg_frequency"
      expr: AVG(CAST(average_frequency AS DOUBLE))
      comment: "Average number of times reached viewers were exposed to campaign"
    - name: "avg_cpm"
      expr: AVG(CAST(cpm AS DOUBLE))
      comment: "Average Cost Per Thousand impressions across campaigns"
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average Cost Per Rating Point across campaigns"
    - name: "avg_delivery_variance_pct"
      expr: AVG(CAST(delivery_variance_pct AS DOUBLE))
      comment: "Average percentage variance between guaranteed and actual delivery"
    - name: "campaigns_requiring_makegoods"
      expr: SUM(CASE WHEN is_makegood_required = true THEN 1 ELSE 0 END)
      comment: "Count of campaigns that underdelivered and require makegood inventory"
    - name: "avg_effective_reach_3plus"
      expr: AVG(CAST(effective_reach_3plus AS DOUBLE))
      comment: "Average number of viewers reached 3 or more times (effective frequency threshold)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_guarantee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising audience guarantee tracking for sold campaigns. Monitors guaranteed vs actual GRP/TRP delivery, makegood obligations, and financial reconciliation. Critical for sales operations and advertiser contract compliance."
  source: "`media_broadcasting_ecm`.`audience`.`guarantee`"
  dimensions:
    - name: "guarantee_status"
      expr: guarantee_status
      comment: "Status of the audience guarantee (active, delivered, underdelivered, reconciled, etc.)"
    - name: "deal_type"
      expr: deal_type
      comment: "Type of advertising deal (upfront, scatter, programmatic, etc.)"
    - name: "rating_metric_type"
      expr: rating_metric_type
      comment: "Type of rating metric guaranteed (GRP, TRP, impressions, etc.)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of financial reconciliation for the guarantee"
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Flag indicating whether guarantee covers sweeps measurement period"
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the guarantee period"
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the guarantee period"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial metrics"
    - name: "guarantee_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month of guarantee start for monthly aggregation"
  measures:
    - name: "total_guarantees"
      expr: COUNT(1)
      comment: "Total number of audience guarantees issued"
    - name: "unique_campaigns"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Distinct count of campaigns with audience guarantees"
    - name: "unique_advertisers"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Distinct count of advertisers with audience guarantees"
    - name: "total_guaranteed_grp"
      expr: SUM(CAST(guaranteed_grp AS DOUBLE))
      comment: "Total Gross Rating Points guaranteed across all deals"
    - name: "total_actual_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total Gross Rating Points actually delivered"
    - name: "total_guaranteed_trp"
      expr: SUM(CAST(guaranteed_trp AS DOUBLE))
      comment: "Total Target Rating Points guaranteed to target demographics"
    - name: "total_actual_trp_delivered"
      expr: SUM(CAST(actual_trp_delivered AS DOUBLE))
      comment: "Total Target Rating Points actually delivered"
    - name: "total_guarantee_value"
      expr: SUM(CAST(total_guarantee_value AS DOUBLE))
      comment: "Total financial value of all audience guarantees"
    - name: "avg_cprp"
      expr: AVG(CAST(cprp AS DOUBLE))
      comment: "Average Cost Per Rating Point across all guarantees"
    - name: "total_delivery_shortfall_grp"
      expr: SUM(CAST(delivery_shortfall_grp AS DOUBLE))
      comment: "Total GRP shortfall requiring makegood inventory"
    - name: "total_makegood_grp_issued"
      expr: SUM(CAST(makegood_grp_issued AS DOUBLE))
      comment: "Total GRP value of makegood spots issued to compensate underdelivery"
    - name: "grp_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_grp_delivered AS DOUBLE)) / NULLIF(SUM(CAST(guaranteed_grp AS DOUBLE)), 0), 2)
      comment: "Percentage of guaranteed GRPs actually delivered"
    - name: "avg_guaranteed_reach_pct"
      expr: AVG(CAST(guaranteed_reach AS DOUBLE))
      comment: "Average guaranteed reach percentage across all deals"
    - name: "avg_guaranteed_frequency"
      expr: AVG(CAST(guaranteed_frequency AS DOUBLE))
      comment: "Average guaranteed frequency across all deals"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_viewership_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed viewership transaction records capturing individual viewing sessions across linear, VOD, and streaming platforms. Enables granular audience behavior analysis, content performance measurement, and ad exposure verification."
  source: "`media_broadcasting_ecm`.`audience`.`viewership_record`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of the broadcast or viewing session"
    - name: "broadcast_month"
      expr: DATE_TRUNC('month', broadcast_date)
      comment: "Month of broadcast for monthly trend analysis"
    - name: "daypart"
      expr: daypart
      comment: "Broadcast daypart classification"
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type (linear, VOD, streaming, etc.)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for viewing (TV, mobile, tablet, desktop, etc.)"
    - name: "stream_quality"
      expr: stream_quality
      comment: "Quality level of the stream (SD, HD, 4K, etc.)"
    - name: "viewing_status"
      expr: viewing_status
      comment: "Status of the viewing session (completed, abandoned, interrupted, etc.)"
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Flag indicating whether viewing occurred during Nielsen sweeps period"
    - name: "is_authenticated"
      expr: is_authenticated
      comment: "Flag indicating whether viewer was authenticated/logged in"
    - name: "blackout_applied"
      expr: blackout_applied
      comment: "Flag indicating whether geographic blackout was applied"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the viewer location"
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system that captured the viewership record"
  measures:
    - name: "total_viewership_records"
      expr: COUNT(1)
      comment: "Total number of viewership records captured"
    - name: "unique_viewers"
      expr: COUNT(DISTINCT viewer_profile_id)
      comment: "Distinct count of viewer profiles"
    - name: "unique_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Distinct count of households viewing content"
    - name: "unique_titles_viewed"
      expr: COUNT(DISTINCT title_id)
      comment: "Distinct count of content titles viewed"
    - name: "total_viewing_hours"
      expr: SUM(CAST(duration_viewed_seconds AS DOUBLE)) / 3600.0
      comment: "Total hours of content viewed across all sessions"
    - name: "avg_completion_rate_pct"
      expr: AVG(CAST(completion_rate AS DOUBLE))
      comment: "Average percentage of content completed by viewers"
    - name: "avg_audience_share"
      expr: AVG(CAST(audience_share AS DOUBLE))
      comment: "Average share of viewing audience"
    - name: "avg_nielsen_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating across viewership records"
    - name: "authenticated_viewing_sessions"
      expr: SUM(CASE WHEN is_authenticated = true THEN 1 ELSE 0 END)
      comment: "Count of authenticated viewing sessions"
    - name: "sweeps_period_sessions"
      expr: SUM(CASE WHEN is_sweeps_period = true THEN 1 ELSE 0 END)
      comment: "Count of viewing sessions during Nielsen sweeps periods"
    - name: "blackout_applied_sessions"
      expr: SUM(CASE WHEN blackout_applied = true THEN 1 ELSE 0 END)
      comment: "Count of sessions where geographic blackout was applied"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audience profile and identity metrics tracking viewer demographics, behavioral attributes, panel participation, and privacy consent status. Enables audience segmentation, targeting, and compliance with data privacy regulations."
  source: "`media_broadcasting_ecm`.`audience`.`audience_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the audience profile (active, inactive, suspended, etc.)"
    - name: "profile_type"
      expr: profile_type
      comment: "Type of audience profile (individual, household, panel member, etc.)"
    - name: "inferred_gender"
      expr: inferred_gender
      comment: "Inferred gender classification"
    - name: "inferred_age_band"
      expr: inferred_age_band
      comment: "Inferred age range classification"
    - name: "income_band"
      expr: income_band
      comment: "Income range classification"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the audience member"
    - name: "content_affinity_genre"
      expr: content_affinity_genre
      comment: "Primary content genre affinity"
    - name: "platform_preference"
      expr: platform_preference
      comment: "Preferred viewing platform (linear, streaming, VOD, etc.)"
    - name: "primary_device_type"
      expr: primary_device_type
      comment: "Primary device type used for viewing"
    - name: "daypart_preference"
      expr: daypart_preference
      comment: "Preferred viewing daypart"
    - name: "gdpr_consent_status"
      expr: gdpr_consent_status
      comment: "GDPR consent status for data processing"
    - name: "ccpa_opt_out"
      expr: ccpa_opt_out
      comment: "CCPA opt-out flag for California privacy compliance"
    - name: "coppa_protected"
      expr: coppa_protected
      comment: "COPPA protection flag for children under 13"
    - name: "hut_eligible"
      expr: hut_eligible
      comment: "Flag indicating eligibility for Homes Using Television measurement"
    - name: "data_clean_room_eligible"
      expr: data_clean_room_eligible
      comment: "Flag indicating eligibility for data clean room matching"
  measures:
    - name: "total_audience_profiles"
      expr: COUNT(1)
      comment: "Total number of audience profiles in the system"
    - name: "unique_demographic_segments"
      expr: COUNT(DISTINCT demographic_segment_id)
      comment: "Distinct count of demographic segments represented"
    - name: "unique_markets"
      expr: COUNT(DISTINCT market_coverage_id)
      comment: "Distinct count of markets represented in audience profiles"
    - name: "avg_ad_receptivity_score"
      expr: AVG(CAST(ad_receptivity_score AS DOUBLE))
      comment: "Average advertising receptivity score across audience profiles"
    - name: "avg_session_duration_minutes"
      expr: AVG(CAST(avg_session_duration_minutes AS DOUBLE))
      comment: "Average viewing session duration in minutes"
    - name: "avg_identity_confidence_score"
      expr: AVG(CAST(identity_confidence_score AS DOUBLE))
      comment: "Average confidence score for identity resolution accuracy"
    - name: "avg_nielsen_grp_index"
      expr: AVG(CAST(nielsen_grp_index AS DOUBLE))
      comment: "Average Nielsen GRP index indicating audience value relative to average"
    - name: "avg_trp_index"
      expr: AVG(CAST(trp_index AS DOUBLE))
      comment: "Average Target Rating Point index for demographic targeting value"
    - name: "avg_panel_weight_factor"
      expr: AVG(CAST(panel_weight_factor AS DOUBLE))
      comment: "Average panel weighting factor for measurement projection"
    - name: "ccpa_opt_out_count"
      expr: SUM(CASE WHEN ccpa_opt_out = true THEN 1 ELSE 0 END)
      comment: "Count of profiles that have opted out under CCPA"
    - name: "coppa_protected_count"
      expr: SUM(CASE WHEN coppa_protected = true THEN 1 ELSE 0 END)
      comment: "Count of profiles protected under COPPA children's privacy rules"
    - name: "hut_eligible_count"
      expr: SUM(CASE WHEN hut_eligible = true THEN 1 ELSE 0 END)
      comment: "Count of profiles eligible for HUT measurement"
    - name: "data_clean_room_eligible_count"
      expr: SUM(CASE WHEN data_clean_room_eligible = true THEN 1 ELSE 0 END)
      comment: "Count of profiles eligible for privacy-safe data clean room matching"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_demographic_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demographic segment definitions and universe estimates for audience targeting and measurement. Tracks key demo cells, Nielsen standard segments, regulatory classifications, and reach potential for advertising sales and programming decisions."
  source: "`media_broadcasting_ecm`.`audience`.`demographic_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the demographic segment"
    - name: "segment_type"
      expr: segment_type
      comment: "Type of demographic segment (age, gender, income, psychographic, etc.)"
    - name: "segment_status"
      expr: segment_status
      comment: "Status of the segment definition (active, deprecated, pending, etc.)"
    - name: "gender_qualifier"
      expr: gender_qualifier
      comment: "Gender classification for the segment"
    - name: "age_range_min"
      expr: age_range_min
      comment: "Minimum age for the segment range"
    - name: "age_range_max"
      expr: age_range_max
      comment: "Maximum age for the segment range"
    - name: "income_quintile"
      expr: income_quintile
      comment: "Income quintile classification"
    - name: "is_key_demo"
      expr: is_key_demo
      comment: "Flag indicating whether this is a key advertising demographic"
    - name: "is_nielsen_standard_cell"
      expr: is_nielsen_standard_cell
      comment: "Flag indicating whether this is a Nielsen standard demographic cell"
    - name: "is_children_segment"
      expr: is_children_segment
      comment: "Flag indicating whether this segment represents children (COPPA implications)"
    - name: "gdpr_special_category"
      expr: gdpr_special_category
      comment: "Flag indicating GDPR special category data requiring enhanced protection"
    - name: "sweeps_priority"
      expr: sweeps_priority
      comment: "Flag indicating priority segment for sweeps measurement periods"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment (national, regional, local, etc.)"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used to measure this segment (panel, census, modeled, etc.)"
  measures:
    - name: "total_demographic_segments"
      expr: COUNT(1)
      comment: "Total number of demographic segment definitions"
    - name: "total_universe_estimate"
      expr: SUM(CAST(universe_estimate AS DOUBLE))
      comment: "Total universe estimate across all demographic segments"
    - name: "avg_reach_potential_pct"
      expr: AVG(CAST(reach_potential_pct AS DOUBLE))
      comment: "Average reach potential percentage across segments"
    - name: "avg_grp_weight_factor"
      expr: AVG(CAST(grp_weight_factor AS DOUBLE))
      comment: "Average GRP weighting factor for segment value"
    - name: "avg_cpm_index"
      expr: AVG(CAST(cpm_index AS DOUBLE))
      comment: "Average CPM index indicating advertising value relative to baseline"
    - name: "key_demo_segments"
      expr: SUM(CASE WHEN is_key_demo = true THEN 1 ELSE 0 END)
      comment: "Count of key advertising demographic segments"
    - name: "nielsen_standard_cells"
      expr: SUM(CASE WHEN is_nielsen_standard_cell = true THEN 1 ELSE 0 END)
      comment: "Count of Nielsen standard demographic cells"
    - name: "children_segments"
      expr: SUM(CASE WHEN is_children_segment = true THEN 1 ELSE 0 END)
      comment: "Count of children segments requiring COPPA compliance"
    - name: "gdpr_special_category_segments"
      expr: SUM(CASE WHEN gdpr_special_category = true THEN 1 ELSE 0 END)
      comment: "Count of segments containing GDPR special category data"
    - name: "sweeps_priority_segments"
      expr: SUM(CASE WHEN sweeps_priority = true THEN 1 ELSE 0 END)
      comment: "Count of priority segments for sweeps measurement"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_panel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measurement panel configuration and quality metrics tracking panel composition, accreditation status, sampling methodology, and measurement capabilities. Critical for ensuring measurement validity and MRC compliance."
  source: "`media_broadcasting_ecm`.`audience`.`panel`"
  dimensions:
    - name: "panel_name"
      expr: panel_name
      comment: "Name of the measurement panel"
    - name: "panel_type"
      expr: panel_type
      comment: "Type of panel (Nielsen, Comscore, proprietary, etc.)"
    - name: "panel_status"
      expr: panel_status
      comment: "Status of the panel (active, inactive, under review, etc.)"
    - name: "mrc_accreditation_status"
      expr: mrc_accreditation_status
      comment: "Media Rating Council accreditation status"
    - name: "measurement_currency_flag"
      expr: measurement_currency_flag
      comment: "Flag indicating whether this panel is the currency standard for the market"
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect panel data (meter, diary, ACR, etc.)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the panel (national, regional, local, etc.)"
    - name: "streaming_measurement_flag"
      expr: streaming_measurement_flag
      comment: "Flag indicating whether panel measures streaming/OTT viewing"
    - name: "out_of_home_measurement_flag"
      expr: out_of_home_measurement_flag
      comment: "Flag indicating whether panel measures out-of-home viewing"
    - name: "sweeps_eligible_flag"
      expr: sweeps_eligible_flag
      comment: "Flag indicating whether panel is eligible for sweeps measurement"
    - name: "country_code"
      expr: country_code
      comment: "Country code for the panel geography"
    - name: "weighting_methodology"
      expr: weighting_methodology
      comment: "Methodology used to weight panel data to universe"
  measures:
    - name: "total_panels"
      expr: COUNT(1)
      comment: "Total number of measurement panels configured"
    - name: "total_universe_estimate"
      expr: SUM(CAST(universe_estimate AS DOUBLE))
      comment: "Total universe estimate across all panels"
    - name: "avg_cooperation_rate_pct"
      expr: AVG(CAST(cooperation_rate AS DOUBLE))
      comment: "Average panel cooperation rate indicating participant engagement"
    - name: "avg_sampling_error_pct"
      expr: AVG(CAST(sampling_error_pct AS DOUBLE))
      comment: "Average sampling error percentage indicating measurement precision"
    - name: "avg_weighting_factor"
      expr: AVG(CAST(weighting_factor AS DOUBLE))
      comment: "Average weighting factor applied to project panel to universe"
    - name: "avg_min_reportable_rating"
      expr: AVG(CAST(min_reportable_rating AS DOUBLE))
      comment: "Average minimum reportable rating threshold for statistical validity"
    - name: "mrc_accredited_panels"
      expr: SUM(CASE WHEN mrc_accreditation_status = 'Accredited' THEN 1 ELSE 0 END)
      comment: "Count of panels with active MRC accreditation"
    - name: "currency_panels"
      expr: SUM(CASE WHEN measurement_currency_flag = true THEN 1 ELSE 0 END)
      comment: "Count of panels designated as measurement currency standard"
    - name: "streaming_capable_panels"
      expr: SUM(CASE WHEN streaming_measurement_flag = true THEN 1 ELSE 0 END)
      comment: "Count of panels capable of measuring streaming/OTT viewing"
    - name: "out_of_home_capable_panels"
      expr: SUM(CASE WHEN out_of_home_measurement_flag = true THEN 1 ELSE 0 END)
      comment: "Count of panels capable of measuring out-of-home viewing"
    - name: "sweeps_eligible_panels"
      expr: SUM(CASE WHEN sweeps_eligible_flag = true THEN 1 ELSE 0 END)
      comment: "Count of panels eligible for sweeps measurement periods"
$$;