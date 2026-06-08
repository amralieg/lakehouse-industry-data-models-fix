-- Metric views for domain: scheduling | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_ad_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for ad break revenue and audience impact"
  source: "`media_broadcasting_ecm`.`scheduling`.`ad_break`"
  dimensions:
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of the broadcast for the ad break"
    - name: "channel_id"
      expr: channel_id
      comment: "Identifier of the channel airing the ad break"
    - name: "daypart_id"
      expr: daypart_id
      comment: "Daypart identifier for scheduling context"
    - name: "break_type"
      expr: break_type
      comment: "Type of ad break (e.g., pre‑roll, mid‑roll, post‑roll)"
    - name: "break_status"
      expr: break_status
      comment: "Current status of the ad break (e.g., aired, cancelled)"
    - name: "revenue_stream_id"
      expr: revenue_stream_id
      comment: "Revenue stream linked to the ad break"
  measures:
    - name: "total_grp"
      expr: SUM(CAST(grp_target AS DOUBLE))
      comment: "Total Gross Rating Points (GRP) delivered across all ad breaks"
    - name: "total_ad_revenue_usd"
      expr: SUM(grp_target * rate_card_cpm / 1000.0)
      comment: "Total ad revenue calculated as GRP multiplied by CPM (cost per thousand impressions)"
    - name: "average_nielsen_program_rating"
      expr: AVG(CAST(nielsen_program_rating AS DOUBLE))
      comment: "Average Nielsen program rating for ad breaks"
    - name: "makegood_required_count"
      expr: SUM(CASE WHEN makegood_required THEN 1 ELSE 0 END)
      comment: "Number of ad breaks that required make‑good placements"
    - name: "ad_break_count"
      expr: COUNT(1)
      comment: "Count of ad break records"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`scheduling_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and capacity metrics at the channel level"
  source: "`media_broadcasting_ecm`.`scheduling`.`channel`"
  dimensions:
    - name: "network_name"
      expr: network_name
      comment: "Name of the broadcast network"
    - name: "channel_type"
      expr: channel_type
      comment: "Classification of the channel (e.g., linear, OTT)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the channel is licensed"
    - name: "broadcast_timezone"
      expr: broadcast_timezone
      comment: "Timezone used for the channel's schedule"
    - name: "dai_enabled"
      expr: dai_enabled
      comment: "Whether Dynamic Ad Insertion is enabled for the channel"
    - name: "scte35_enabled"
      expr: scte35_enabled
      comment: "Whether SCTE‑35 signaling is enabled"
  measures:
    - name: "total_carriage_fee_usd"
      expr: SUM(CAST(carriage_fee_usd AS DOUBLE))
      comment: "Total carriage fees collected for the channel"
    - name: "average_max_ad_load_pct"
      expr: AVG(CAST(max_ad_load_pct AS DOUBLE))
      comment: "Average maximum ad load percentage allowed on the channel"
    - name: "channel_count"
      expr: COUNT(1)
      comment: "Number of channel records"
$$;