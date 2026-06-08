-- Metric views for domain: scheduling | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:19:28

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel performance and operational metrics including carriage fees, ad load capacity, and platform distribution reach"
  source: "`media_broadcasting_ecm`.`scheduling`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of channel (linear, OTT, hybrid, etc.)"
    - name: "channel_status"
      expr: channel_status
      comment: "Current operational status of the channel"
    - name: "network_name"
      expr: network_name
      comment: "Network brand name for the channel"
    - name: "broadcast_timezone"
      expr: broadcast_timezone
      comment: "Primary broadcast timezone for scheduling"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the channel is licensed and originates"
    - name: "transmission_standard"
      expr: transmission_standard
      comment: "Technical broadcast standard (ATSC, DVB-T, ISDB, etc.)"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of channel content"
    - name: "dai_enabled_flag"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled"
    - name: "must_carry_status_flag"
      expr: must_carry_status
      comment: "Whether channel has must-carry regulatory status"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the channel was launched"
  measures:
    - name: "total_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Total number of unique channels"
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fee revenue in USD across all channels"
    - name: "avg_carriage_fee_per_channel"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per channel in USD"
    - name: "avg_max_ad_load_pct"
      expr: AVG(CAST(max_ad_load_pct AS DOUBLE))
      comment: "Average maximum advertising load percentage across channels"
    - name: "dai_enabled_channel_count"
      expr: SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of channels with dynamic ad insertion enabled"
    - name: "must_carry_channel_count"
      expr: SUM(CASE WHEN must_carry_status = TRUE THEN 1 ELSE 0 END)
      comment: "Count of channels with must-carry regulatory status"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_ad_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising break performance metrics including sell-through rates, GRP delivery, CPM yield, and makegood obligations"
  source: "`media_broadcasting_ecm`.`scheduling`.`ad_break`"
  dimensions:
    - name: "break_type"
      expr: break_type
      comment: "Type of ad break (local, network, promotional, etc.)"
    - name: "break_status"
      expr: break_status
      comment: "Current status of the ad break (scheduled, aired, preempted, etc.)"
    - name: "daypart_segment"
      expr: break_position
      comment: "Position of the break within the program (opening, mid-roll, closing)"
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date the ad break was broadcast"
    - name: "broadcast_year"
      expr: YEAR(broadcast_date)
      comment: "Year of broadcast"
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_date)
      comment: "Month of broadcast"
    - name: "dai_eligible_flag"
      expr: dai_eligible
      comment: "Whether the break is eligible for dynamic ad insertion"
    - name: "makegood_required_flag"
      expr: makegood_required
      comment: "Whether a makegood is required due to underdelivery"
    - name: "affidavit_generated_flag"
      expr: affidavit_generated
      comment: "Whether proof-of-performance affidavit was generated"
    - name: "blackout_restricted_flag"
      expr: blackout_restricted
      comment: "Whether the break is subject to blackout restrictions"
  measures:
    - name: "total_ad_breaks"
      expr: COUNT(DISTINCT ad_break_id)
      comment: "Total number of unique ad breaks"
    - name: "total_planned_duration_seconds"
      expr: SUM(CAST(planned_duration_seconds AS DOUBLE))
      comment: "Total planned duration of all ad breaks in seconds"
    - name: "total_actual_duration_seconds"
      expr: SUM(CAST(actual_duration_seconds AS DOUBLE))
      comment: "Total actual aired duration of all ad breaks in seconds"
    - name: "total_sold_duration_seconds"
      expr: SUM(CAST(sold_duration_seconds AS DOUBLE))
      comment: "Total sold advertising duration in seconds"
    - name: "avg_grp_target"
      expr: AVG(CAST(grp_target AS DOUBLE))
      comment: "Average gross rating point target across ad breaks"
    - name: "total_grp_target"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Total gross rating points targeted across all ad breaks"
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average rate card cost per thousand impressions in USD"
    - name: "avg_nielsen_program_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating for ad breaks"
    - name: "makegood_required_count"
      expr: SUM(CASE WHEN makegood_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ad breaks requiring makegood fulfillment"
    - name: "dai_eligible_break_count"
      expr: SUM(CASE WHEN dai_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ad breaks eligible for dynamic ad insertion"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_schedule_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program schedule slot performance metrics including on-time delivery, duration variance, and content distribution patterns"
  source: "`media_broadcasting_ecm`.`scheduling`.`schedule_slot`"
  dimensions:
    - name: "slot_type"
      expr: slot_type
      comment: "Type of schedule slot (program, filler, promo, etc.)"
    - name: "slot_status"
      expr: slot_status
      comment: "Current status of the schedule slot"
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date the slot was broadcast"
    - name: "broadcast_year"
      expr: YEAR(broadcast_date)
      comment: "Year of broadcast"
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_date)
      comment: "Month of broadcast"
    - name: "is_live_flag"
      expr: is_live
      comment: "Whether the content was broadcast live"
    - name: "is_repeat_flag"
      expr: is_repeat
      comment: "Whether the content is a repeat broadcast"
    - name: "is_simulcast_flag"
      expr: is_simulcast
      comment: "Whether the content was simulcast across multiple platforms"
    - name: "is_blackout_flag"
      expr: is_blackout
      comment: "Whether the content was subject to blackout restrictions"
    - name: "resolution"
      expr: resolution
      comment: "Video resolution of the content (SD, HD, 4K, etc.)"
    - name: "aspect_ratio"
      expr: aspect_ratio
      comment: "Aspect ratio of the video content"
    - name: "audio_format"
      expr: audio_format
      comment: "Audio format specification"
  measures:
    - name: "total_schedule_slots"
      expr: COUNT(DISTINCT schedule_slot_id)
      comment: "Total number of unique schedule slots"
    - name: "total_planned_duration_seconds"
      expr: SUM(CAST(planned_duration_seconds AS DOUBLE))
      comment: "Total planned duration of all schedule slots in seconds"
    - name: "total_actual_duration_seconds"
      expr: SUM(CAST(actual_duration_seconds AS DOUBLE))
      comment: "Total actual aired duration of all schedule slots in seconds"
    - name: "avg_planned_duration_seconds"
      expr: AVG(CAST(planned_duration_seconds AS DOUBLE))
      comment: "Average planned duration per schedule slot in seconds"
    - name: "avg_actual_duration_seconds"
      expr: AVG(CAST(actual_duration_seconds AS DOUBLE))
      comment: "Average actual aired duration per schedule slot in seconds"
    - name: "live_broadcast_count"
      expr: SUM(CASE WHEN is_live = TRUE THEN 1 ELSE 0 END)
      comment: "Count of live broadcast schedule slots"
    - name: "repeat_broadcast_count"
      expr: SUM(CASE WHEN is_repeat = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat broadcast schedule slots"
    - name: "simulcast_count"
      expr: SUM(CASE WHEN is_simulcast = TRUE THEN 1 ELSE 0 END)
      comment: "Count of simulcast schedule slots"
    - name: "blackout_count"
      expr: SUM(CASE WHEN is_blackout = TRUE THEN 1 ELSE 0 END)
      comment: "Count of schedule slots subject to blackout restrictions"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_playout_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playout event execution metrics including on-time performance, failover incidents, and rights clearance compliance"
  source: "`media_broadcasting_ecm`.`scheduling`.`playout_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of playout event (program, commercial, promo, etc.)"
    - name: "playout_status"
      expr: playout_status
      comment: "Status of the playout event execution"
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date the event was played out"
    - name: "broadcast_year"
      expr: YEAR(broadcast_date)
      comment: "Year of playout"
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_date)
      comment: "Month of playout"
    - name: "automation_mode"
      expr: automation_mode
      comment: "Automation mode used for playout (manual, semi-auto, full-auto)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Type of transmission (live, file-based, streaming)"
    - name: "broadcast_standard"
      expr: broadcast_standard
      comment: "Broadcast technical standard used"
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Status of rights clearance for the content"
    - name: "failover_activated_flag"
      expr: failover_activated
      comment: "Whether failover was activated during playout"
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether content was subject to blackout"
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether content was simulcast"
    - name: "dai_eligible_flag"
      expr: dai_eligible
      comment: "Whether event was eligible for dynamic ad insertion"
    - name: "affidavit_generated_flag"
      expr: affidavit_generated
      comment: "Whether proof-of-performance affidavit was generated"
  measures:
    - name: "total_playout_events"
      expr: COUNT(DISTINCT playout_event_id)
      comment: "Total number of unique playout events"
    - name: "total_scheduled_duration_seconds"
      expr: SUM(CAST(scheduled_duration_seconds AS DOUBLE))
      comment: "Total scheduled duration of all playout events in seconds"
    - name: "total_actual_duration_seconds"
      expr: SUM(CAST(actual_duration_seconds AS DOUBLE))
      comment: "Total actual duration of all playout events in seconds"
    - name: "total_start_deviation_seconds"
      expr: SUM(CAST(start_deviation_seconds AS DOUBLE))
      comment: "Total cumulative start time deviation in seconds"
    - name: "avg_start_deviation_seconds"
      expr: AVG(CAST(start_deviation_seconds AS DOUBLE))
      comment: "Average start time deviation per playout event in seconds"
    - name: "failover_incident_count"
      expr: SUM(CASE WHEN failover_activated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of playout events where failover was activated"
    - name: "blackout_event_count"
      expr: SUM(CASE WHEN blackout_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of playout events subject to blackout"
    - name: "simulcast_event_count"
      expr: SUM(CASE WHEN simulcast_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of simulcast playout events"
    - name: "dai_eligible_event_count"
      expr: SUM(CASE WHEN dai_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of playout events eligible for dynamic ad insertion"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_daypart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daypart performance metrics including audience delivery, CPM pricing, and advertising eligibility by time segment"
  source: "`media_broadcasting_ecm`.`scheduling`.`daypart`"
  dimensions:
    - name: "daypart_name"
      expr: daypart_name
      comment: "Name of the daypart (Prime Time, Late Night, etc.)"
    - name: "daypart_type"
      expr: daypart_type
      comment: "Type classification of the daypart"
    - name: "daypart_status"
      expr: daypart_status
      comment: "Current status of the daypart"
    - name: "day_category"
      expr: day_category
      comment: "Category of days (weekday, weekend, holiday, etc.)"
    - name: "applicable_days"
      expr: applicable_days
      comment: "Days of week the daypart applies to"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the daypart definition became effective"
    - name: "dai_eligible_flag"
      expr: dai_eligible
      comment: "Whether daypart is eligible for dynamic ad insertion"
    - name: "upfront_eligible_flag"
      expr: upfront_eligible
      comment: "Whether daypart is eligible for upfront sales"
    - name: "scatter_eligible_flag"
      expr: scatter_eligible
      comment: "Whether daypart is eligible for scatter market sales"
    - name: "makegood_eligible_flag"
      expr: makegood_eligible
      comment: "Whether daypart is eligible for makegood placement"
    - name: "sweeps_period_flag"
      expr: sweeps_period_flag
      comment: "Whether daypart falls within a ratings sweeps period"
  measures:
    - name: "total_dayparts"
      expr: COUNT(DISTINCT daypart_id)
      comment: "Total number of unique daypart definitions"
    - name: "avg_audience_000"
      expr: AVG(CAST(avg_audience_000 AS DOUBLE))
      comment: "Average audience size in thousands across dayparts"
    - name: "total_audience_000"
      expr: SUM(CAST(avg_audience_000 AS DOUBLE))
      comment: "Total audience reach in thousands across all dayparts"
    - name: "avg_base_cpm_usd"
      expr: AVG(CAST(base_cpm_usd AS DOUBLE))
      comment: "Average base cost per thousand impressions in USD"
    - name: "avg_rate_multiplier"
      expr: AVG(CAST(rate_multiplier AS DOUBLE))
      comment: "Average rate multiplier applied to base CPM"
    - name: "avg_grp_index"
      expr: AVG(CAST(grp_index AS DOUBLE))
      comment: "Average gross rating point index across dayparts"
    - name: "avg_hut_level"
      expr: AVG(CAST(hut_level AS DOUBLE))
      comment: "Average homes using television level across dayparts"
    - name: "upfront_eligible_daypart_count"
      expr: SUM(CASE WHEN upfront_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dayparts eligible for upfront sales"
    - name: "scatter_eligible_daypart_count"
      expr: SUM(CASE WHEN scatter_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dayparts eligible for scatter market sales"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_program_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program schedule execution metrics including rights clearance, regulatory compliance, and transmission quality"
  source: "`media_broadcasting_ecm`.`scheduling`.`program_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of program schedule (daily, weekly, special event, etc.)"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the program schedule"
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of the scheduled broadcast"
    - name: "broadcast_year"
      expr: YEAR(broadcast_date)
      comment: "Year of scheduled broadcast"
    - name: "broadcast_month"
      expr: DATE_TRUNC('MONTH', broadcast_date)
      comment: "Month of scheduled broadcast"
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Status of rights clearance for scheduled content"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Type of transmission (terrestrial, satellite, cable, OTT)"
    - name: "broadcast_standard"
      expr: broadcast_standard
      comment: "Technical broadcast standard"
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether schedule includes blackout restrictions"
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether schedule includes simulcast content"
    - name: "emergency_alert_ready_flag"
      expr: emergency_alert_ready
      comment: "Whether schedule is configured for emergency alert system"
    - name: "fcc_children_programming_compliant_flag"
      expr: fcc_children_programming_compliant
      comment: "Whether schedule meets FCC children's programming requirements"
    - name: "must_carry_compliant_flag"
      expr: must_carry_compliant
      comment: "Whether schedule meets must-carry obligations"
  measures:
    - name: "total_program_schedules"
      expr: COUNT(DISTINCT program_schedule_id)
      comment: "Total number of unique program schedules"
    - name: "total_program_time_seconds"
      expr: SUM(CAST(total_program_time_seconds AS DOUBLE))
      comment: "Total program content time in seconds across all schedules"
    - name: "total_ad_time_seconds"
      expr: SUM(CAST(total_ad_time_seconds AS DOUBLE))
      comment: "Total advertising time in seconds across all schedules"
    - name: "total_runtime_seconds"
      expr: SUM(CAST(total_runtime_seconds AS DOUBLE))
      comment: "Total runtime in seconds across all schedules"
    - name: "avg_program_time_seconds"
      expr: AVG(CAST(total_program_time_seconds AS DOUBLE))
      comment: "Average program content time per schedule in seconds"
    - name: "avg_ad_time_seconds"
      expr: AVG(CAST(total_ad_time_seconds AS DOUBLE))
      comment: "Average advertising time per schedule in seconds"
    - name: "blackout_schedule_count"
      expr: SUM(CASE WHEN blackout_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of schedules with blackout restrictions"
    - name: "simulcast_schedule_count"
      expr: SUM(CASE WHEN simulcast_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of schedules with simulcast content"
    - name: "fcc_compliant_schedule_count"
      expr: SUM(CASE WHEN fcc_children_programming_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of schedules compliant with FCC children's programming rules"
    - name: "must_carry_compliant_schedule_count"
      expr: SUM(CASE WHEN must_carry_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of schedules meeting must-carry obligations"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_simulcast_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Simulcast configuration performance metrics including platform reach, failover reliability, and content passthrough capabilities"
  source: "`media_broadcasting_ecm`.`scheduling`.`simulcast_config`"
  dimensions:
    - name: "simulcast_type"
      expr: simulcast_type
      comment: "Type of simulcast (linear-to-OTT, multi-platform, regional, etc.)"
    - name: "simulcast_config_status"
      expr: simulcast_config_status
      comment: "Current status of the simulcast configuration"
    - name: "distribution_platform"
      expr: distribution_platform
      comment: "Target distribution platform for simulcast"
    - name: "failover_mode"
      expr: failover_mode
      comment: "Failover mode configuration (automatic, manual, hybrid)"
    - name: "effective_year"
      expr: YEAR(effective_from)
      comment: "Year the simulcast configuration became effective"
    - name: "dai_enabled_flag"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled for simulcast"
    - name: "blackout_enforced_flag"
      expr: blackout_enforced
      comment: "Whether blackout restrictions are enforced"
    - name: "must_carry_compliant_flag"
      expr: must_carry_compliant
      comment: "Whether simulcast meets must-carry obligations"
    - name: "closed_caption_passthrough_flag"
      expr: closed_caption_passthrough
      comment: "Whether closed captions are passed through in simulcast"
    - name: "scte35_cue_passthrough_flag"
      expr: scte35_cue_passthrough
      comment: "Whether SCTE-35 cues are passed through for ad insertion"
    - name: "watermark_enabled_flag"
      expr: watermark_enabled
      comment: "Whether video watermarking is enabled"
  measures:
    - name: "total_simulcast_configs"
      expr: COUNT(DISTINCT simulcast_config_id)
      comment: "Total number of unique simulcast configurations"
    - name: "dai_enabled_config_count"
      expr: SUM(CASE WHEN dai_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of simulcast configurations with dynamic ad insertion enabled"
    - name: "blackout_enforced_config_count"
      expr: SUM(CASE WHEN blackout_enforced = TRUE THEN 1 ELSE 0 END)
      comment: "Count of simulcast configurations enforcing blackout restrictions"
    - name: "must_carry_compliant_config_count"
      expr: SUM(CASE WHEN must_carry_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of simulcast configurations meeting must-carry obligations"
    - name: "closed_caption_passthrough_count"
      expr: SUM(CASE WHEN closed_caption_passthrough = TRUE THEN 1 ELSE 0 END)
      comment: "Count of configurations with closed caption passthrough enabled"
    - name: "scte35_passthrough_count"
      expr: SUM(CASE WHEN scte35_cue_passthrough = TRUE THEN 1 ELSE 0 END)
      comment: "Count of configurations with SCTE-35 cue passthrough enabled"
    - name: "watermark_enabled_count"
      expr: SUM(CASE WHEN watermark_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of configurations with video watermarking enabled"
$$;