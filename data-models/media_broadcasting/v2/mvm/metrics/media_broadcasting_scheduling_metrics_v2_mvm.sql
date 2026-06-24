-- Metric views for domain: scheduling | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-23 04:34:26

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_ad_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad break performance and monetization metrics. Tracks sold inventory, GRP delivery, CPM rates, and break fill efficiency to inform ad sales strategy and yield management."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`ad_break`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of broadcast for time-series trending of ad break performance."
    - name: "break_type"
      expr: break_type
      comment: "Type of ad break (e.g., commercial, promo, PSA) for inventory classification."
    - name: "break_position"
      expr: break_position
      comment: "Position of the break within the program (e.g., pre-roll, mid-roll, post-roll) for yield analysis."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the break is eligible for dynamic ad insertion, enabling DAI vs. linear inventory segmentation."
    - name: "simulcast_eligible"
      expr: simulcast_eligible
      comment: "Whether the break is eligible for simulcast delivery, supporting multi-platform reach analysis."
    - name: "blackout_restricted"
      expr: blackout_restricted
      comment: "Indicates if the break is subject to blackout restrictions, affecting available inventory."
    - name: "makegood_required"
      expr: makegood_required
      comment: "Flags breaks requiring make-good spots due to under-delivery, a key liability indicator."
    - name: "affidavit_generated"
      expr: affidavit_generated
      comment: "Whether a broadcast affidavit has been generated for compliance and billing verification."
  measures:
    - name: "total_ad_breaks"
      expr: COUNT(1)
      comment: "Total number of ad breaks scheduled. Baseline volume metric for inventory planning."
    - name: "total_sold_avail_count"
      expr: COUNT(CASE WHEN sold_avail_count IS NOT NULL THEN 1 END)
      comment: "Number of ad breaks with sold avails recorded, indicating monetized inventory volume."
    - name: "makegood_break_count"
      expr: COUNT(CASE WHEN makegood_required = TRUE THEN 1 END)
      comment: "Number of breaks flagged as requiring make-good. Elevated counts signal under-delivery risk and advertiser liability."
    - name: "dai_eligible_break_count"
      expr: COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END)
      comment: "Number of breaks eligible for dynamic ad insertion. Drives digital monetization strategy."
    - name: "avg_nielsen_program_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating across ad breaks. Core audience delivery metric used in CPM negotiations and upfront planning."
    - name: "total_grp_target"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Total Gross Rating Points targeted across all ad breaks. Primary currency for audience guarantee commitments."
    - name: "avg_rate_card_cpm"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average rate card CPM across ad breaks. Benchmarks pricing competitiveness and yield per thousand impressions."
    - name: "affidavit_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ad breaks with affidavits generated. Measures compliance with broadcast verification requirements; low rates indicate billing and regulatory risk."
    - name: "makegood_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN makegood_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ad breaks requiring make-good. A rising rate signals systemic under-delivery and advertiser satisfaction risk."
    - name: "dai_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ad breaks eligible for DAI. Tracks digital transformation of ad inventory and addressable advertising reach."
    - name: "blackout_restricted_break_count"
      expr: COUNT(CASE WHEN blackout_restricted = TRUE THEN 1 END)
      comment: "Number of breaks subject to blackout restrictions. Quantifies inventory lost to rights-based blackout rules."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel portfolio and monetization metrics. Tracks channel capacity, ad load limits, DAI adoption, and carriage economics to inform network strategy and distribution decisions."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of channel (e.g., linear, OTT, FAST) for portfolio segmentation."
    - name: "network_name"
      expr: network_name
      comment: "Name of the broadcast network for network-level performance aggregation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for geographic and regulatory segmentation."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the channel for audience targeting and localization analysis."
    - name: "transmission_standard"
      expr: transmission_standard
      comment: "Transmission standard (e.g., ATSC, DVB) for technical infrastructure planning."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled on the channel, segmenting addressable vs. traditional inventory."
    - name: "must_carry_status"
      expr: must_carry_status
      comment: "Whether the channel has must-carry regulatory status, affecting distribution obligations."
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Whether DRM is enabled, relevant for content protection compliance reporting."
    - name: "resolution_profile"
      expr: resolution_profile
      comment: "Video resolution profile (e.g., HD, 4K) for quality tier analysis."
    - name: "launch_date"
      expr: launch_date
      comment: "Channel launch date for cohort and lifecycle analysis."
  measures:
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of channels in the portfolio. Baseline for network scale assessment."
    - name: "dai_enabled_channel_count"
      expr: COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END)
      comment: "Number of channels with DAI enabled. Tracks addressable advertising footprint across the network."
    - name: "must_carry_channel_count"
      expr: COUNT(CASE WHEN must_carry_status = TRUE THEN 1 END)
      comment: "Number of channels with must-carry regulatory status. Informs regulatory compliance posture and distribution obligations."
    - name: "avg_max_ad_load_pct"
      expr: AVG(CAST(max_ad_load_pct AS DOUBLE))
      comment: "Average maximum ad load percentage across channels. Benchmarks monetization ceiling and informs yield optimization strategy."
    - name: "total_carriage_fee_usd"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fees across all channels. Direct revenue/cost metric for distribution contract negotiations."
    - name: "avg_carriage_fee_usd"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per channel. Benchmarks per-channel distribution economics for portfolio decisions."
    - name: "dai_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with DAI enabled. Measures digital ad transformation progress across the channel portfolio."
    - name: "active_channel_count"
      expr: COUNT(CASE WHEN decommission_date IS NULL THEN 1 END)
      comment: "Number of channels not yet decommissioned. Tracks active network footprint for operational planning."
    - name: "drm_enabled_channel_count"
      expr: COUNT(CASE WHEN drm_enabled = TRUE THEN 1 END)
      comment: "Number of channels with DRM protection enabled. Supports content security compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_program_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program schedule execution and compliance metrics. Tracks schedule adherence, ad load delivery, simulcast reach, and regulatory compliance to steer scheduling operations and FCC obligations."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Broadcast date for daily schedule performance trending."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Type of transmission (e.g., live, tape-delayed) for schedule type segmentation."
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source system that generated the schedule (e.g., WideOrbit, Dalet) for operational provenance."
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether the schedule includes simulcast programming, enabling multi-platform reach analysis."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether the schedule is subject to blackout restrictions, affecting audience reach."
    - name: "fcc_children_programming_compliant"
      expr: fcc_children_programming_compliant
      comment: "FCC children's programming compliance flag. Critical for regulatory reporting and license renewal."
    - name: "must_carry_compliant"
      expr: must_carry_compliant
      comment: "Must-carry compliance flag for regulatory obligation tracking."
    - name: "emergency_alert_ready"
      expr: emergency_alert_ready
      comment: "Whether the schedule is configured for emergency alert system readiness, a public safety compliance indicator."
    - name: "playout_failover_mode"
      expr: playout_failover_mode
      comment: "Failover mode configured for the schedule, relevant for operational resilience reporting."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of program schedules. Baseline volume for scheduling operations."
    - name: "simulcast_schedule_count"
      expr: COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END)
      comment: "Number of schedules with simulcast enabled. Measures multi-platform distribution reach."
    - name: "fcc_compliant_schedule_count"
      expr: COUNT(CASE WHEN fcc_children_programming_compliant = TRUE THEN 1 END)
      comment: "Number of schedules meeting FCC children's programming requirements. Tracks regulatory compliance posture."
    - name: "fcc_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fcc_children_programming_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules compliant with FCC children's programming rules. A declining rate signals license renewal risk."
    - name: "must_carry_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN must_carry_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules meeting must-carry obligations. Directly tied to distribution regulatory compliance."
    - name: "emergency_alert_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_alert_ready = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules configured for emergency alert readiness. Public safety compliance KPI monitored by regulators."
    - name: "as_run_confirmed_schedule_count"
      expr: COUNT(CASE WHEN as_run_confirmed_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of schedules with confirmed as-run logs. Measures broadcast execution verification completeness."
    - name: "as_run_confirmation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN as_run_confirmed_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules with as-run confirmation. Low rates indicate gaps in broadcast verification and billing reconciliation."
    - name: "simulcast_platform_reach"
      expr: SUM(CAST(simulcast_platform_count AS BIGINT))
      comment: "Total simulcast platform count across all schedules. Measures aggregate multi-platform distribution reach."
    - name: "blackout_schedule_count"
      expr: COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END)
      comment: "Number of schedules subject to blackout restrictions. Quantifies audience reach impact from rights-based blackouts."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_playout_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playout execution quality and operational reliability metrics. Tracks on-air delivery accuracy, failover incidents, DAI eligibility, and simulcast performance to steer broadcast operations."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`playout_event`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Broadcast date for daily playout performance trending."
    - name: "automation_mode"
      expr: automation_mode
      comment: "Playout automation mode (e.g., auto, manual, semi-auto) for operational efficiency segmentation."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the playout event is eligible for dynamic ad insertion."
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether the event was simulcast across platforms."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether the playout event was subject to a blackout."
    - name: "failover_activated"
      expr: failover_activated
      comment: "Whether failover was activated during this playout event, indicating a transmission incident."
    - name: "must_carry_flag"
      expr: must_carry_flag
      comment: "Whether the event is subject to must-carry obligations."
    - name: "substitution_reason"
      expr: substitution_reason
      comment: "Reason for content substitution, enabling root-cause analysis of schedule deviations."
    - name: "affidavit_generated"
      expr: affidavit_generated
      comment: "Whether a broadcast affidavit was generated for this event."
  measures:
    - name: "total_playout_events"
      expr: COUNT(1)
      comment: "Total number of playout events. Baseline for broadcast volume and operational throughput."
    - name: "failover_event_count"
      expr: COUNT(CASE WHEN failover_activated = TRUE THEN 1 END)
      comment: "Number of playout events where failover was activated. Directly measures transmission reliability and on-air incident frequency."
    - name: "failover_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN failover_activated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events requiring failover. Key operational reliability KPI; elevated rates signal infrastructure or content delivery issues."
    - name: "affidavit_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events with affidavits generated. Measures broadcast verification completeness for billing and regulatory compliance."
    - name: "simulcast_event_count"
      expr: COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END)
      comment: "Number of events delivered via simulcast. Tracks multi-platform distribution execution."
    - name: "simulcast_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events simulcast across platforms. Measures multi-platform reach execution rate."
    - name: "dai_eligible_event_count"
      expr: COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END)
      comment: "Number of playout events eligible for dynamic ad insertion. Quantifies addressable advertising inventory in playout."
    - name: "substitution_event_count"
      expr: COUNT(CASE WHEN substitution_reason IS NOT NULL THEN 1 END)
      comment: "Number of playout events with content substitutions. Elevated counts indicate scheduling or rights clearance issues."
    - name: "substitution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events requiring content substitution. Measures schedule integrity and rights clearance effectiveness."
    - name: "blackout_event_count"
      expr: COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END)
      comment: "Number of playout events subject to blackout. Quantifies audience reach lost to rights-based restrictions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_program_rundown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program rundown production readiness and rights clearance metrics. Tracks approval rates, rights clearance status, DAI eligibility, and simulcast readiness to ensure on-air delivery quality."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`program_rundown`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Broadcast date for daily rundown readiness trending."
    - name: "rundown_status"
      expr: rundown_status
      comment: "Current status of the rundown (e.g., draft, approved, transmitted) for workflow stage analysis."
    - name: "rundown_type"
      expr: rundown_type
      comment: "Type of rundown (e.g., live, pre-recorded, news) for content category segmentation."
    - name: "rights_clearance_status"
      expr: rights_clearance_status
      comment: "Rights clearance status for the rundown, critical for on-air compliance."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the rundown is eligible for dynamic ad insertion."
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether the rundown is flagged for simulcast delivery."
    - name: "live_flag"
      expr: live_flag
      comment: "Whether the rundown is a live broadcast, affecting scheduling risk and operational complexity."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether the rundown is subject to blackout restrictions."
    - name: "emergency_alert_ready"
      expr: emergency_alert_ready
      comment: "Whether the rundown is configured for emergency alert system readiness."
    - name: "production_format"
      expr: production_format
      comment: "Production format (e.g., HD, SD, 4K) for technical quality segmentation."
  measures:
    - name: "total_rundowns"
      expr: COUNT(1)
      comment: "Total number of program rundowns. Baseline for production volume and scheduling throughput."
    - name: "approved_rundown_count"
      expr: COUNT(CASE WHEN approved_by IS NOT NULL THEN 1 END)
      comment: "Number of rundowns that have been formally approved. Measures production readiness pipeline health."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approved_by IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rundowns with formal approval. Low rates signal production bottlenecks that risk on-air delivery."
    - name: "rights_cleared_rundown_count"
      expr: COUNT(CASE WHEN rights_clearance_status = 'CLEARED' THEN 1 END)
      comment: "Number of rundowns with cleared rights. Tracks content rights compliance readiness for broadcast."
    - name: "rights_clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rights_clearance_status = 'CLEARED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rundowns with rights cleared. A declining rate signals legal exposure and potential on-air rights violations."
    - name: "transmitted_rundown_count"
      expr: COUNT(CASE WHEN transmitted_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of rundowns successfully transmitted to air. Measures end-to-end broadcast execution completeness."
    - name: "transmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transmitted_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rundowns successfully transmitted. Core operational KPI for broadcast delivery reliability."
    - name: "emergency_alert_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_alert_ready = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rundowns configured for emergency alert readiness. Public safety compliance metric."
    - name: "live_rundown_count"
      expr: COUNT(CASE WHEN live_flag = TRUE THEN 1 END)
      comment: "Number of live broadcast rundowns. Tracks live programming volume, which carries higher operational risk and audience value."
    - name: "dai_eligible_rundown_count"
      expr: COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END)
      comment: "Number of rundowns eligible for dynamic ad insertion. Quantifies addressable advertising inventory in the production pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_epg_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Electronic Program Guide (EPG) content quality and distribution metrics. Tracks new episode volume, live programming, simulcast reach, HDR adoption, and closed captioning compliance to steer content scheduling and audience engagement."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`epg_entry`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Broadcast date for EPG content trending and scheduling analysis."
    - name: "genre_primary"
      expr: genre_primary
      comment: "Primary genre of the EPG entry for content mix and audience targeting analysis."
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution (e.g., HD, 4K, SD) for quality tier distribution analysis."
    - name: "is_live"
      expr: is_live
      comment: "Whether the EPG entry is a live broadcast, a key driver of audience tune-in."
    - name: "is_new_episode"
      expr: is_new_episode
      comment: "Whether the entry is a new episode premiere, critical for audience acquisition and ratings."
    - name: "is_simulcast"
      expr: is_simulcast
      comment: "Whether the entry is simulcast across platforms for multi-platform reach analysis."
    - name: "is_blackout"
      expr: is_blackout
      comment: "Whether the entry is subject to blackout restrictions."
    - name: "is_hdr"
      expr: is_hdr
      comment: "Whether the entry is delivered in HDR, tracking premium content quality adoption."
    - name: "is_closed_caption"
      expr: is_closed_caption
      comment: "Whether closed captioning is available, relevant for accessibility compliance."
    - name: "distribution_window"
      expr: distribution_window
      comment: "Distribution window (e.g., first-run, repeat, library) for content lifecycle analysis."
  measures:
    - name: "total_epg_entries"
      expr: COUNT(1)
      comment: "Total number of EPG entries. Baseline for schedule density and content volume."
    - name: "new_episode_count"
      expr: COUNT(CASE WHEN is_new_episode = TRUE THEN 1 END)
      comment: "Number of new episode premieres in the EPG. Directly tied to audience acquisition, ratings performance, and content investment ROI."
    - name: "new_episode_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_new_episode = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries that are new episode premieres. Measures content freshness and programming investment effectiveness."
    - name: "live_programming_count"
      expr: COUNT(CASE WHEN is_live = TRUE THEN 1 END)
      comment: "Number of live programming entries. Live content drives appointment viewing and premium ad rates."
    - name: "live_programming_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_live = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries that are live broadcasts. Tracks live programming strategy execution."
    - name: "simulcast_entry_count"
      expr: COUNT(CASE WHEN is_simulcast = TRUE THEN 1 END)
      comment: "Number of EPG entries delivered via simulcast. Measures multi-platform content distribution reach."
    - name: "closed_caption_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed_caption = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries with closed captioning. FCC accessibility compliance KPI; low rates indicate regulatory risk."
    - name: "hdr_content_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hdr = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries delivered in HDR. Tracks premium content quality adoption and viewer experience investment."
    - name: "blackout_entry_count"
      expr: COUNT(CASE WHEN is_blackout = TRUE THEN 1 END)
      comment: "Number of EPG entries subject to blackout. Quantifies audience reach impact from rights-based content restrictions."
    - name: "unique_program_count"
      expr: COUNT(DISTINCT program_title)
      comment: "Number of distinct program titles in the EPG. Measures content variety and scheduling diversity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_schedule_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule slot utilization and content delivery metrics. Tracks live, simulcast, repeat, and blackout slot distribution alongside must-carry compliance to optimize schedule composition and rights utilization."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`schedule_slot`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Broadcast date for daily slot utilization trending."
    - name: "program_title"
      expr: program_title
      comment: "Title of the program scheduled in the slot for content performance analysis."
    - name: "resolution"
      expr: resolution
      comment: "Video resolution of the slot content for quality tier analysis."
    - name: "is_live"
      expr: is_live
      comment: "Whether the slot contains live programming."
    - name: "is_simulcast"
      expr: is_simulcast
      comment: "Whether the slot is simulcast across platforms."
    - name: "is_repeat"
      expr: is_repeat
      comment: "Whether the slot contains repeat programming, relevant for content freshness analysis."
    - name: "is_blackout"
      expr: is_blackout
      comment: "Whether the slot is subject to blackout restrictions."
    - name: "must_carry_flag"
      expr: must_carry_flag
      comment: "Whether the slot is subject to must-carry regulatory obligations."
    - name: "closed_caption_flag"
      expr: closed_caption_flag
      comment: "Whether closed captioning is enabled for the slot, relevant for accessibility compliance."
    - name: "schedule_version"
      expr: schedule_version
      comment: "Version of the schedule for change management and audit tracking."
  measures:
    - name: "total_schedule_slots"
      expr: COUNT(1)
      comment: "Total number of schedule slots. Baseline for schedule capacity and utilization analysis."
    - name: "live_slot_count"
      expr: COUNT(CASE WHEN is_live = TRUE THEN 1 END)
      comment: "Number of live programming slots. Live content commands premium ad rates and drives appointment viewing."
    - name: "repeat_slot_count"
      expr: COUNT(CASE WHEN is_repeat = TRUE THEN 1 END)
      comment: "Number of repeat programming slots. High repeat rates may signal content acquisition gaps."
    - name: "repeat_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule slots containing repeat programming. Elevated rates indicate content library dependency and potential audience fatigue."
    - name: "simulcast_slot_count"
      expr: COUNT(CASE WHEN is_simulcast = TRUE THEN 1 END)
      comment: "Number of simulcast slots. Measures multi-platform content distribution execution."
    - name: "blackout_slot_count"
      expr: COUNT(CASE WHEN is_blackout = TRUE THEN 1 END)
      comment: "Number of slots subject to blackout. Quantifies audience reach lost to rights restrictions."
    - name: "blackout_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_blackout = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule slots subject to blackout. High rates indicate rights clearance issues impacting audience reach."
    - name: "must_carry_slot_count"
      expr: COUNT(CASE WHEN must_carry_flag = TRUE THEN 1 END)
      comment: "Number of slots subject to must-carry obligations. Tracks regulatory compliance in schedule composition."
    - name: "closed_caption_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_caption_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule slots with closed captioning enabled. FCC accessibility compliance KPI."
    - name: "avg_aspect_ratio"
      expr: AVG(CAST(aspect_ratio AS DOUBLE))
      comment: "Average aspect ratio across schedule slots. Tracks widescreen/HD format adoption across the schedule."
$$;