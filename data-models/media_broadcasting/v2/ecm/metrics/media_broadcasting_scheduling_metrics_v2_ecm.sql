-- Metric views for domain: scheduling | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel portfolio health and monetisation metrics — tracks active channel inventory, ad load capacity, carriage fee revenue potential, and DAI/DRM enablement rates to guide channel strategy and distribution investment decisions."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of channel (linear, OTT, FAST, etc.) for segmenting performance by distribution model."
    - name: "network_name"
      expr: network_name
      comment: "Network brand name for grouping channels by parent network."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for geographic segmentation of channel portfolio."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary broadcast language for audience and regulatory segmentation."
    - name: "transmission_standard"
      expr: transmission_standard
      comment: "Transmission standard (ATSC, DVB, etc.) for technical infrastructure grouping."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether dynamic ad insertion is enabled — key for programmatic revenue segmentation."
    - name: "drm_enabled"
      expr: drm_enabled
      comment: "Whether DRM is active on the channel — relevant for premium content distribution analysis."
    - name: "must_carry_status"
      expr: must_carry_status
      comment: "Must-carry regulatory status — affects carriage negotiation strategy."
    - name: "launch_date"
      expr: DATE_TRUNC('year', launch_date)
      comment: "Year of channel launch for cohort analysis of channel maturity."
  measures:
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of channels in the portfolio — baseline inventory count for capacity planning."
    - name: "dai_enabled_channels"
      expr: COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END)
      comment: "Number of channels with DAI enabled — directly tied to programmatic ad revenue potential."
    - name: "dai_enablement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with DAI enabled — KPI for programmatic monetisation readiness across the portfolio."
    - name: "avg_max_ad_load_pct"
      expr: AVG(CAST(max_ad_load_pct AS DOUBLE))
      comment: "Average maximum ad load percentage across channels — informs ad inventory capacity and yield optimisation."
    - name: "total_carriage_fee_usd"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fee revenue across all channels — key revenue line for distribution deal negotiations."
    - name: "avg_carriage_fee_usd"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per channel — benchmark for evaluating individual channel distribution economics."
    - name: "drm_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN drm_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels with DRM active — security and premium content compliance indicator."
    - name: "must_carry_channels"
      expr: COUNT(CASE WHEN must_carry_status = TRUE THEN 1 END)
      comment: "Number of must-carry channels — regulatory obligation count affecting carriage negotiation leverage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_ad_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad break monetisation and inventory utilisation metrics — measures sold vs available ad inventory, CPM yield, GRP delivery, and DAI eligibility to drive ad revenue optimisation and traffic management decisions."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`ad_break`"
  dimensions:
    - name: "broadcast_date"
      expr: DATE_TRUNC('week', broadcast_date)
      comment: "Broadcast week for trending ad break performance over time."
    - name: "break_type"
      expr: break_type
      comment: "Type of ad break (commercial, promo, PSA) for inventory mix analysis."
    - name: "break_position"
      expr: break_position
      comment: "Position of break within program (pre-roll, mid-roll, post-roll) for yield analysis by placement."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the break is eligible for dynamic ad insertion — segments programmatic vs linear inventory."
    - name: "simulcast_eligible"
      expr: simulcast_eligible
      comment: "Whether the break is eligible for simulcast — affects multi-platform reach calculations."
    - name: "makegood_required"
      expr: makegood_required
      comment: "Whether a makegood is required — flags under-delivery situations requiring remediation."
    - name: "blackout_restricted"
      expr: blackout_restricted
      comment: "Whether the break is subject to blackout restrictions — affects effective inventory availability."
  measures:
    - name: "total_ad_breaks"
      expr: COUNT(1)
      comment: "Total number of ad breaks scheduled — baseline inventory volume metric."
    - name: "total_grp_target"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Total GRP target across all ad breaks — audience delivery commitment baseline for advertiser guarantees."
    - name: "avg_grp_target"
      expr: AVG(CAST(grp_target AS DOUBLE))
      comment: "Average GRP target per ad break — benchmark for audience delivery expectations per break."
    - name: "total_nielsen_program_rating"
      expr: SUM(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Sum of Nielsen program ratings across breaks — proxy for total audience exposure inventory."
    - name: "avg_nielsen_program_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating per break — indicates average audience quality of ad inventory."
    - name: "total_rate_card_cpm_usd"
      expr: SUM(CAST(rate_card_cpm AS DOUBLE))
      comment: "Total rate card CPM value across all breaks — upper bound on ad revenue potential from scheduled inventory."
    - name: "avg_rate_card_cpm_usd"
      expr: AVG(CAST(rate_card_cpm AS DOUBLE))
      comment: "Average CPM rate across ad breaks — pricing benchmark for yield management and rate negotiation."
    - name: "dai_eligible_breaks"
      expr: COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END)
      comment: "Number of DAI-eligible breaks — programmatic inventory volume available for addressable advertising."
    - name: "dai_eligibility_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ad breaks eligible for DAI — measures programmatic monetisation readiness of the schedule."
    - name: "makegood_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN makegood_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaks requiring makegoods — under-delivery rate KPI that triggers advertiser remediation workflows."
    - name: "affidavit_generated_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breaks with affidavits generated — proof-of-performance compliance rate for political and direct-response advertisers."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_playout_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Playout execution quality and compliance metrics — tracks on-air delivery accuracy, failover incidents, blackout enforcement, DAI eligibility, and affidavit generation to drive operational excellence in broadcast transmission."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`playout_event`"
  dimensions:
    - name: "broadcast_date"
      expr: DATE_TRUNC('week', broadcast_date)
      comment: "Broadcast week for trending playout performance over time."
    - name: "automation_mode"
      expr: automation_mode
      comment: "Automation mode (fully automated, semi-manual, manual) for operational efficiency segmentation."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the playout event was DAI-eligible — segments programmatic vs traditional linear events."
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether the event was simulcast — for multi-platform reach and rights compliance analysis."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether a blackout was enforced — rights compliance execution indicator."
    - name: "failover_activated"
      expr: failover_activated
      comment: "Whether failover was activated during the event — operational resilience and SLA breach indicator."
    - name: "must_carry_flag"
      expr: must_carry_flag
      comment: "Whether the event was a must-carry obligation — regulatory compliance segmentation."
  measures:
    - name: "total_playout_events"
      expr: COUNT(1)
      comment: "Total playout events executed — baseline transmission volume for operational capacity analysis."
    - name: "failover_activation_count"
      expr: COUNT(CASE WHEN failover_activated = TRUE THEN 1 END)
      comment: "Number of playout events where failover was activated — direct measure of transmission reliability incidents."
    - name: "failover_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN failover_activated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events requiring failover — broadcast reliability KPI that triggers infrastructure investment decisions."
    - name: "blackout_enforcement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events with blackout enforced — rights compliance execution rate for territory restriction obligations."
    - name: "affidavit_generated_count"
      expr: COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END)
      comment: "Number of playout events with affidavits generated — proof-of-performance documentation volume for billing and compliance."
    - name: "affidavit_generation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN affidavit_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events with affidavits generated — billing completeness and compliance rate."
    - name: "dai_eligible_events"
      expr: COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END)
      comment: "Number of DAI-eligible playout events — programmatic ad inventory volume delivered on-air."
    - name: "simulcast_event_count"
      expr: COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END)
      comment: "Number of simulcast playout events — multi-platform distribution reach indicator."
    - name: "simulcast_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of playout events that were simulcast — multi-platform distribution penetration rate."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_program_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program schedule quality, compliance, and operational readiness metrics — tracks schedule completeness, FCC compliance, simulcast coverage, and ad inventory loading to support scheduling operations and regulatory reporting."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`program_schedule`"
  dimensions:
    - name: "broadcast_date"
      expr: DATE_TRUNC('week', broadcast_date)
      comment: "Broadcast week for trending schedule quality over time."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (OTA, cable, satellite, OTT) for segmenting schedule performance by distribution platform."
    - name: "schedule_source"
      expr: schedule_source
      comment: "Source system that generated the schedule (WideOrbit, Dalet, MediaFirst) for operational provenance analysis."
    - name: "simulcast_flag"
      expr: simulcast_flag
      comment: "Whether the schedule includes simulcast programming — multi-platform distribution indicator."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether the schedule has blackout restrictions — rights compliance flag for schedule review."
    - name: "fcc_children_programming_compliant"
      expr: fcc_children_programming_compliant
      comment: "FCC children's programming compliance status — regulatory obligation tracking."
    - name: "emergency_alert_ready"
      expr: emergency_alert_ready
      comment: "Whether the schedule is configured for emergency alert insertion — public safety readiness indicator."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total program schedules created — baseline scheduling volume for operational capacity planning."
    - name: "fcc_compliant_schedules"
      expr: COUNT(CASE WHEN fcc_children_programming_compliant = TRUE THEN 1 END)
      comment: "Number of schedules meeting FCC children's programming requirements — regulatory compliance count."
    - name: "fcc_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fcc_children_programming_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules compliant with FCC children's programming rules — regulatory risk KPI that triggers license renewal risk assessment."
    - name: "emergency_alert_ready_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN emergency_alert_ready = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules configured for emergency alert — public safety readiness compliance rate."
    - name: "simulcast_schedule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN simulcast_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules with simulcast enabled — multi-platform distribution coverage rate."
    - name: "as_run_confirmed_schedules"
      expr: COUNT(CASE WHEN as_run_confirmed_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of schedules with as-run confirmation — billing and affidavit readiness count."
    - name: "as_run_confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN as_run_confirmed_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules with as-run confirmation — operational completeness rate critical for advertiser billing and FCC logging."
    - name: "must_carry_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN must_carry_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules meeting must-carry obligations — cable/satellite regulatory compliance rate."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_daypart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daypart audience and pricing performance metrics — measures CPM rates, GRP indices, HUT levels, and audience delivery by daypart to drive ad sales pricing strategy and programming investment decisions."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`daypart`"
  dimensions:
    - name: "daypart_name"
      expr: daypart_name
      comment: "Daypart name (Prime, Late Night, Morning, etc.) for standard broadcast daypart segmentation."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Target demographic for the daypart — key dimension for ad sales audience guarantee analysis."
    - name: "dai_eligible"
      expr: dai_eligible
      comment: "Whether the daypart is eligible for DAI — programmatic revenue potential segmentation."
    - name: "upfront_eligible"
      expr: upfront_eligible
      comment: "Whether the daypart is eligible for upfront sales — critical for annual ad sales planning."
    - name: "scatter_eligible"
      expr: scatter_eligible
      comment: "Whether the daypart is eligible for scatter market sales — short-term inventory monetisation indicator."
    - name: "makegood_eligible"
      expr: makegood_eligible
      comment: "Whether the daypart supports makegoods — under-delivery remediation capability flag."
    - name: "sweeps_period_flag"
      expr: sweeps_period_flag
      comment: "Whether the daypart falls within a sweeps period — premium pricing and ratings measurement indicator."
    - name: "coppa_restricted"
      expr: coppa_restricted
      comment: "Whether the daypart has COPPA restrictions — regulatory compliance dimension for children's advertising."
    - name: "effective_from"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Quarter when the daypart definition became effective — for tracking pricing and audience changes over time."
  measures:
    - name: "total_dayparts"
      expr: COUNT(1)
      comment: "Total number of defined dayparts — inventory structure baseline for ad sales planning."
    - name: "avg_base_cpm_usd"
      expr: AVG(CAST(base_cpm_usd AS DOUBLE))
      comment: "Average base CPM rate across dayparts — pricing benchmark for ad sales rate card management."
    - name: "total_base_cpm_usd"
      expr: SUM(CAST(base_cpm_usd AS DOUBLE))
      comment: "Total base CPM value across all dayparts — aggregate rate card value for portfolio pricing analysis."
    - name: "avg_audience_000"
      expr: AVG(CAST(avg_audience_000 AS DOUBLE))
      comment: "Average audience in thousands across dayparts — audience delivery baseline for guarantee setting and upfront negotiations."
    - name: "avg_grp_index"
      expr: AVG(CAST(grp_index AS DOUBLE))
      comment: "Average GRP index across dayparts — relative audience delivery efficiency indicator for media planning."
    - name: "avg_hut_level"
      expr: AVG(CAST(hut_level AS DOUBLE))
      comment: "Average Households Using Television level — market viewing activity indicator for competitive daypart positioning."
    - name: "avg_rate_multiplier"
      expr: AVG(CAST(rate_multiplier AS DOUBLE))
      comment: "Average rate multiplier across dayparts — premium pricing factor analysis for yield management."
    - name: "upfront_eligible_dayparts"
      expr: COUNT(CASE WHEN upfront_eligible = TRUE THEN 1 END)
      comment: "Number of dayparts eligible for upfront sales — annual ad sales inventory planning metric."
    - name: "dai_eligible_dayparts"
      expr: COUNT(CASE WHEN dai_eligible = TRUE THEN 1 END)
      comment: "Number of dayparts eligible for DAI — programmatic ad inventory availability count."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign channel allocation delivery and budget utilisation metrics — measures GRP delivery vs target, budget spend, and spot execution to evaluate campaign performance and drive makegood or reallocation decisions."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_allocation`"
  dimensions:
    - name: "flight_start_date"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Campaign flight month for trending allocation performance over time."
    - name: "daypart_mix"
      expr: daypart_mix
      comment: "Daypart mix strategy for the allocation — for analysing performance by scheduling approach."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total channel allocations — baseline campaign distribution volume."
    - name: "total_allocated_budget_usd"
      expr: SUM(CAST(allocated_budget_amount AS DOUBLE))
      comment: "Total budget allocated across channel campaigns — financial commitment baseline for revenue forecasting."
    - name: "avg_allocated_budget_usd"
      expr: AVG(CAST(allocated_budget_amount AS DOUBLE))
      comment: "Average budget per channel allocation — benchmark for campaign sizing and channel investment analysis."
    - name: "total_grp_target"
      expr: SUM(CAST(target_grp AS DOUBLE))
      comment: "Total GRP target across all channel allocations — aggregate audience delivery commitment."
    - name: "total_grp_delivered"
      expr: SUM(CAST(actual_grp_delivered AS DOUBLE))
      comment: "Total GRP actually delivered across all channel allocations — actual audience delivery for guarantee reconciliation."
    - name: "grp_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_grp_delivered AS DOUBLE)) / NULLIF(SUM(CAST(target_grp AS DOUBLE)), 0), 2)
      comment: "GRP delivery rate (actual vs target) — campaign under/over-delivery KPI that triggers makegood or bonus spot decisions."
    - name: "avg_grp_delivery_rate"
      expr: AVG(ROUND(100.0 * actual_grp_delivered / NULLIF(target_grp, 0), 2))
      comment: "Average per-allocation GRP delivery rate — distribution of delivery performance across individual channel buys."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_carriage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel carriage agreement economics and feature enablement metrics — tracks carriage fee revenue, DAI and simulcast enablement rates, and contract coverage to support distribution deal negotiations and platform strategy."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_carriage`"
  dimensions:
    - name: "contract_start_date"
      expr: DATE_TRUNC('year', contract_start_date)
      comment: "Contract start year for cohort analysis of carriage agreement vintages."
    - name: "dai_enabled_flag"
      expr: dai_enabled_flag
      comment: "Whether DAI is enabled on this carriage agreement — programmatic revenue capability segmentation."
    - name: "simulcast_enabled"
      expr: simulcast_enabled
      comment: "Whether simulcast is enabled — multi-platform distribution reach indicator."
    - name: "epg_sync_enabled"
      expr: epg_sync_enabled
      comment: "Whether EPG sync is enabled — data quality and viewer experience indicator for platform partners."
  measures:
    - name: "total_carriage_agreements"
      expr: COUNT(1)
      comment: "Total active carriage agreements — distribution footprint baseline."
    - name: "total_carriage_fee_usd"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fee revenue across all platform agreements — key distribution revenue line for financial planning."
    - name: "avg_carriage_fee_usd"
      expr: AVG(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Average carriage fee per agreement — benchmark for evaluating individual platform deal economics."
    - name: "dai_enabled_carriage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriage agreements with DAI enabled — programmatic monetisation penetration across distribution partners."
    - name: "simulcast_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN simulcast_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriage agreements with simulcast enabled — multi-platform reach coverage rate."
    - name: "distinct_platforms"
      expr: COUNT(DISTINCT ott_platform_id)
      comment: "Number of distinct OTT platforms carrying the channel — distribution breadth metric for platform strategy."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel content licensing economics and utilisation metrics — tracks license fee investment, run utilisation rates, and exclusivity coverage to optimise content licensing spend and scheduling rights management."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_license`"
  dimensions:
    - name: "license_start_date"
      expr: DATE_TRUNC('year', license_start_date)
      comment: "License start year for cohort analysis of content licensing vintages."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the license is exclusive — premium content investment segmentation."
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total channel content licenses — content rights portfolio size."
    - name: "total_license_fee_usd"
      expr: SUM(CAST(license_fee_usd AS DOUBLE))
      comment: "Total license fee investment across all channel content licenses — content cost baseline for P&L management."
    - name: "avg_license_fee_usd"
      expr: AVG(CAST(license_fee_usd AS DOUBLE))
      comment: "Average license fee per content agreement — benchmark for content acquisition cost efficiency."
    - name: "exclusive_license_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses that are exclusive — premium content differentiation rate affecting competitive positioning."
    - name: "distinct_licensed_titles"
      expr: COUNT(DISTINCT title_id)
      comment: "Number of distinct titles licensed for channel broadcast — content breadth metric for programming strategy."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_blackout_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blackout rule coverage and rights compliance metrics — tracks the volume, scope, and configuration of blackout rules to ensure rights obligations are enforced and retransmission consent requirements are met."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`scheduling_blackout_rule`"
  dimensions:
    - name: "enforcement_scope"
      expr: enforcement_scope
      comment: "Scope of blackout enforcement (national, regional, DMA) for geographic rights compliance analysis."
    - name: "simulcast_blackout_flag"
      expr: simulcast_blackout_flag
      comment: "Whether the blackout applies to simulcast streams — multi-platform rights enforcement indicator."
    - name: "retransmission_consent_flag"
      expr: retransmission_consent_flag
      comment: "Whether the rule is tied to retransmission consent — regulatory obligation classification."
    - name: "dai_override_flag"
      expr: dai_override_flag
      comment: "Whether DAI is overridden during blackout — programmatic ad substitution capability indicator."
    - name: "epg_suppression_flag"
      expr: epg_suppression_flag
      comment: "Whether EPG data is suppressed during blackout — viewer experience and rights compliance indicator."
    - name: "must_carry_exempt_flag"
      expr: must_carry_exempt_flag
      comment: "Whether the rule is exempt from must-carry obligations — regulatory exception tracking."
  measures:
    - name: "total_blackout_rules"
      expr: COUNT(1)
      comment: "Total active blackout rules — rights enforcement infrastructure volume."
    - name: "retransmission_consent_rules"
      expr: COUNT(CASE WHEN retransmission_consent_flag = TRUE THEN 1 END)
      comment: "Number of blackout rules tied to retransmission consent — regulatory obligation count for compliance reporting."
    - name: "retransmission_consent_rule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN retransmission_consent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of blackout rules driven by retransmission consent — regulatory obligation proportion of rights enforcement workload."
    - name: "simulcast_blackout_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN simulcast_blackout_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of blackout rules applying to simulcast — multi-platform rights enforcement coverage rate."
    - name: "dai_override_enabled_rules"
      expr: COUNT(CASE WHEN dai_override_flag = TRUE THEN 1 END)
      comment: "Number of blackout rules with DAI override enabled — programmatic ad substitution capability during blackouts."
    - name: "distinct_restricted_territories"
      expr: COUNT(DISTINCT restricted_territory_code_id)
      comment: "Number of distinct restricted territories covered by blackout rules — geographic rights enforcement breadth."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_simulcast_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Simulcast configuration coverage and feature enablement metrics — tracks DAI, DRM, watermarking, and closed caption passthrough rates across simulcast configurations to ensure multi-platform delivery quality and compliance."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`simulcast_config`"
  dimensions:
    - name: "distribution_platform"
      expr: distribution_platform
      comment: "Distribution platform (OTT, cable, satellite) for segmenting simulcast configuration by delivery channel."
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether DAI is enabled in this simulcast config — programmatic monetisation capability indicator."
    - name: "drm_scheme"
      expr: drm_scheme
      comment: "DRM scheme used (Widevine, PlayReady, FairPlay) for content protection technology analysis."
    - name: "failover_mode"
      expr: failover_mode
      comment: "Failover mode configured — operational resilience strategy segmentation."
    - name: "watermark_enabled"
      expr: watermark_enabled
      comment: "Whether watermarking is enabled — content protection and anti-piracy compliance indicator."
    - name: "must_carry_compliant"
      expr: must_carry_compliant
      comment: "Whether the simulcast config meets must-carry requirements — regulatory compliance flag."
    - name: "effective_from"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Quarter when the simulcast config became effective — for tracking configuration evolution over time."
  measures:
    - name: "total_simulcast_configs"
      expr: COUNT(1)
      comment: "Total simulcast configurations — multi-platform distribution infrastructure count."
    - name: "dai_enabled_configs"
      expr: COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END)
      comment: "Number of simulcast configs with DAI enabled — programmatic ad revenue capability across simulcast streams."
    - name: "dai_enablement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dai_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of simulcast configs with DAI enabled — programmatic monetisation readiness across multi-platform distribution."
    - name: "watermark_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN watermark_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of simulcast configs with watermarking enabled — content protection and anti-piracy coverage rate."
    - name: "closed_caption_passthrough_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN closed_caption_passthrough = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of simulcast configs passing through closed captions — accessibility compliance rate across multi-platform streams."
    - name: "scte35_passthrough_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN scte35_cue_passthrough = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of simulcast configs with SCTE-35 cue passthrough — ad insertion signal integrity rate for programmatic monetisation."
    - name: "must_carry_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN must_carry_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of simulcast configs meeting must-carry requirements — regulatory compliance rate for cable/satellite distribution."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_channel_targeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel audience targeting effectiveness metrics — measures guaranteed GRP commitments, rate multipliers, and target rating achievement by demographic segment to optimise ad sales targeting strategy and upfront guarantee setting."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`channel_targeting`"
  dimensions:
    - name: "is_primary_target"
      expr: is_primary_target
      comment: "Whether this is the primary target demographic for the channel — primary vs secondary audience segmentation."
    - name: "daypart_strategy"
      expr: daypart_strategy
      comment: "Daypart strategy applied for this targeting configuration — scheduling approach for audience delivery."
    - name: "effective_from"
      expr: DATE_TRUNC('quarter', effective_from)
      comment: "Quarter when targeting became effective — for tracking audience strategy evolution."
  measures:
    - name: "total_targeting_configs"
      expr: COUNT(1)
      comment: "Total channel targeting configurations — audience strategy breadth indicator."
    - name: "total_guaranteed_grp"
      expr: SUM(CAST(guaranteed_grp AS DOUBLE))
      comment: "Total GRP guaranteed across all channel targeting agreements — aggregate audience delivery commitment for upfront sales."
    - name: "avg_guaranteed_grp"
      expr: AVG(CAST(guaranteed_grp AS DOUBLE))
      comment: "Average guaranteed GRP per targeting configuration — benchmark for audience delivery commitment sizing."
    - name: "avg_target_rating"
      expr: AVG(CAST(target_rating AS DOUBLE))
      comment: "Average target rating across channel targeting configurations — audience quality benchmark for ad sales pricing."
    - name: "avg_rate_multiplier"
      expr: AVG(CAST(rate_multiplier AS DOUBLE))
      comment: "Average rate multiplier for targeted inventory — premium pricing factor for demographic-targeted ad sales."
    - name: "distinct_demographic_segments"
      expr: COUNT(DISTINCT demographic_segment_id)
      comment: "Number of distinct demographic segments targeted — audience targeting breadth for ad sales portfolio analysis."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_epg_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EPG data quality and content feature coverage metrics — tracks live, HDR, closed caption, simulcast, and new episode rates across the electronic programme guide to ensure viewer experience quality and platform compliance."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`epg_entry`"
  dimensions:
    - name: "broadcast_date"
      expr: DATE_TRUNC('week', broadcast_date)
      comment: "Broadcast week for trending EPG quality over time."
    - name: "genre_primary"
      expr: genre_primary
      comment: "Primary genre for content mix analysis in the EPG."
    - name: "is_live"
      expr: is_live
      comment: "Whether the EPG entry is a live event — live vs recorded content segmentation."
    - name: "is_new_episode"
      expr: is_new_episode
      comment: "Whether the entry is a new episode — premiere vs repeat content segmentation."
    - name: "is_hdr"
      expr: is_hdr
      comment: "Whether the content is in HDR — premium video quality indicator."
    - name: "is_simulcast"
      expr: is_simulcast
      comment: "Whether the entry is a simulcast — multi-platform distribution indicator."
    - name: "is_closed_caption"
      expr: is_closed_caption
      comment: "Whether closed captions are available — accessibility compliance indicator."
    - name: "video_resolution"
      expr: video_resolution
      comment: "Video resolution (SD, HD, 4K) for content quality tier analysis."
  measures:
    - name: "total_epg_entries"
      expr: COUNT(1)
      comment: "Total EPG entries — programme guide completeness baseline."
    - name: "live_content_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_live = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries that are live events — live programming mix rate affecting viewer engagement and ad premium pricing."
    - name: "new_episode_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_new_episode = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries that are new episodes — original/premiere content rate affecting tune-in and ratings performance."
    - name: "hdr_content_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hdr = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries in HDR — premium video quality coverage rate for platform differentiation."
    - name: "closed_caption_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed_caption = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries with closed captions — FCC accessibility compliance rate."
    - name: "blackout_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_blackout = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries subject to blackout — rights restriction impact on viewer-facing programme guide."
    - name: "simulcast_entry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_simulcast = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EPG entries that are simulcast — multi-platform distribution coverage rate in the programme guide."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_scte_marker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SCTE-35 signal quality and ad insertion readiness metrics — tracks signal detection, blackout enforcement, encryption, and out-of-network rates to ensure ad insertion infrastructure reliability and programmatic revenue delivery."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`scte_marker`"
  dimensions:
    - name: "splice_command_type"
      expr: splice_command_type
      comment: "SCTE-35 splice command type for categorising signal types in ad insertion analysis."
    - name: "segmentation_type_label"
      expr: segmentation_type_label
      comment: "Segmentation type label for classifying SCTE-35 signal purpose (program start, ad break, etc.)."
    - name: "out_of_network"
      expr: out_of_network
      comment: "Whether the marker signals an out-of-network insertion — local ad avail indicator."
    - name: "blackout_flag"
      expr: blackout_flag
      comment: "Whether the marker triggers a blackout — rights enforcement signal indicator."
    - name: "encrypted_packet"
      expr: encrypted_packet
      comment: "Whether the SCTE-35 packet is encrypted — signal security indicator."
    - name: "splice_immediate"
      expr: splice_immediate
      comment: "Whether the splice is immediate — live event and breaking news insertion capability indicator."
  measures:
    - name: "total_scte_markers"
      expr: COUNT(1)
      comment: "Total SCTE-35 markers processed — ad insertion signal volume baseline for infrastructure capacity planning."
    - name: "out_of_network_markers"
      expr: COUNT(CASE WHEN out_of_network = TRUE THEN 1 END)
      comment: "Number of out-of-network SCTE-35 markers — local ad avail signal count for affiliate revenue analysis."
    - name: "out_of_network_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_network = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SCTE-35 markers that are out-of-network — local ad insertion opportunity rate."
    - name: "blackout_marker_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN blackout_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SCTE-35 markers triggering blackouts — rights enforcement signal proportion."
    - name: "total_splice_event_numbers"
      expr: COUNT(DISTINCT splice_event_number)
      comment: "Number of distinct splice events — unique ad insertion event count for inventory reconciliation."
    - name: "avg_pts_time"
      expr: AVG(CAST(pts_time AS DOUBLE))
      comment: "Average PTS (Presentation Timestamp) value — signal timing baseline for playout synchronisation quality analysis."
    - name: "avg_segmentation_upid_value"
      expr: AVG(CAST(segmentation_upid_value AS DOUBLE))
      comment: "Average segmentation UPID value — content identification signal quality metric for ad targeting accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_local_avail_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Local advertising avail inventory utilisation and revenue metrics — tracks sellout rates, rate performance, and available vs sold seconds for affiliate station local ad inventory management and revenue optimisation."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`scheduling_local_avail_inventory`"
  dimensions:
    - name: "avail_date"
      expr: DATE_TRUNC('week', avail_date)
      comment: "Avail week for trending local inventory performance over time."
    - name: "avail_window"
      expr: avail_window
      comment: "Avail window (morning, afternoon, prime, late) for daypart-level local inventory analysis."
  measures:
    - name: "total_avail_records"
      expr: COUNT(1)
      comment: "Total local avail inventory records — baseline inventory volume for affiliate station ad sales planning."
    - name: "total_rate_amount_usd"
      expr: SUM(CAST(rate_amount AS DOUBLE))
      comment: "Total rate card value of local avail inventory — revenue potential baseline for affiliate station ad sales."
    - name: "avg_rate_amount_usd"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average rate per local avail record — pricing benchmark for local ad inventory yield management."
    - name: "avg_sellout_percentage"
      expr: AVG(CAST(sellout_percentage AS DOUBLE))
      comment: "Average sellout percentage across local avail inventory — inventory utilisation rate KPI for affiliate revenue management."
    - name: "total_sellout_percentage"
      expr: SUM(CAST(sellout_percentage AS DOUBLE))
      comment: "Sum of sellout percentages — aggregate inventory utilisation for portfolio-level local ad sales analysis."
    - name: "fully_sold_avails"
      expr: COUNT(CASE WHEN sellout_percentage >= 100.0 THEN 1 END)
      comment: "Number of avail windows that are fully sold out — demand saturation indicator triggering rate card review."
    - name: "full_sellout_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sellout_percentage >= 100.0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of avail windows fully sold — local inventory demand health KPI for pricing and capacity decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`scheduling_network_clearance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network clearance rate and affiliate compensation metrics — tracks program clearance percentages, preemption rates, and compensation amounts to manage affiliate network relationships and content distribution effectiveness."
  source: "`vibe_media_broadcasting_v1`.`scheduling`.`network_clearance`"
  dimensions:
    - name: "scheduled_air_date"
      expr: DATE_TRUNC('month', scheduled_air_date)
      comment: "Month of scheduled air date for trending clearance performance over time."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Clearance status (cleared, preempted, delayed) for categorising affiliate compliance."
    - name: "clearance_type"
      expr: clearance_type
      comment: "Type of clearance (full, partial, delayed) for granular affiliate performance analysis."
    - name: "preempted_flag"
      expr: preempted_flag
      comment: "Whether the program was preempted — affiliate non-compliance indicator."
    - name: "delayed_broadcast_flag"
      expr: delayed_broadcast_flag
      comment: "Whether the broadcast was delayed — time-shifted clearance indicator."
    - name: "substitute_program_flag"
      expr: substitute_program_flag
      comment: "Whether a substitute program was aired — affiliate programming decision indicator."
  measures:
    - name: "total_clearance_records"
      expr: COUNT(1)
      comment: "Total network clearance records — affiliate program distribution volume baseline."
    - name: "avg_clearance_percentage"
      expr: AVG(CAST(clearance_percentage AS DOUBLE))
      comment: "Average clearance percentage across affiliate stations — network distribution effectiveness KPI for affiliate relations management."
    - name: "total_compensation_amount_usd"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation paid to affiliates for clearance — affiliate network cost baseline for distribution economics."
    - name: "avg_compensation_amount_usd"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per clearance record — per-program affiliate cost benchmark."
    - name: "preemption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preempted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs preempted by affiliates — network distribution reliability KPI that triggers affiliate relationship interventions."
    - name: "delayed_broadcast_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN delayed_broadcast_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs broadcast on a delayed basis — time-shifted clearance rate affecting live ratings and ad delivery."
    - name: "distinct_affiliate_stations"
      expr: COUNT(DISTINCT affiliate_station_id)
      comment: "Number of distinct affiliate stations with clearance records — network distribution footprint breadth."
$$;