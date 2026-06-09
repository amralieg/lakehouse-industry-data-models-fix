-- Metric views for domain: usage | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_aggregated_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated usage metrics at billing cycle level."
  source: "`telecommunication_ecm`.`usage`.`aggregated_usage`"
  dimensions:
    - name: "subscriber_id"
      expr: subscriber_id
      comment: "Subscriber identifier."
    - name: "aggregation_period_type"
      expr: aggregation_period_type
      comment: "Period type of aggregation (e.g., monthly, daily)."
    - name: "billing_cycle_id"
      expr: billing_cycle_id
      comment: "Billing cycle identifier."
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Number of aggregated usage records."
    - name: "total_data_volume_mb"
      expr: SUM(COALESCE(data_volume_mb_2g,0) + COALESCE(data_volume_mb_3g,0) + COALESCE(data_volume_mb_4g_lte,0) + COALESCE(data_volume_mb_5g,0) + COALESCE(data_volume_mb_roaming,0) + COALESCE(data_volume_mb_wifi_offload,0))
      comment: "Total data volume across all technologies (MB)."
    - name: "total_content_streaming_hours"
      expr: SUM(CAST(content_streaming_hours AS DOUBLE))
      comment: "Total content streaming hours."
    - name: "total_overage_data_mb"
      expr: SUM(CAST(overage_data_mb AS DOUBLE))
      comment: "Total overage data volume (MB)."
    - name: "avg_peak_usage_mb"
      expr: AVG(CAST(peak_usage_mb AS DOUBLE))
      comment: "Average peak usage per record (MB)."
    - name: "total_iptv_viewing_hours"
      expr: SUM(CAST(iptv_viewing_hours AS DOUBLE))
      comment: "Total IPTV viewing hours."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_cdr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Call Detail Record (CDR) metrics."
  source: "`telecommunication_ecm`.`usage`.`cdr`"
  dimensions:
    - name: "subscriber_id"
      expr: subscriber_id
      comment: "Subscriber identifier."
    - name: "call_type"
      expr: call_type
      comment: "Type of call (e.g., voice, video)."
    - name: "call_direction"
      expr: call_direction
      comment: "Call direction (incoming/outgoing)."
    - name: "mediation_status"
      expr: mediation_status
      comment: "Mediation processing status."
    - name: "network_operator_carrier_id"
      expr: network_operator_carrier_id
      comment: "Carrier that operated the network."
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Number of CDR records."
    - name: "total_data_volume_bytes"
      expr: SUM(COALESCE(data_volume_downlink_bytes,0) + COALESCE(data_volume_uplink_bytes,0))
      comment: "Total data volume transferred (bytes)."
    - name: "fraud_event_count"
      expr: SUM(CASE WHEN fraud_indicator THEN 1 ELSE 0 END)
      comment: "Number of fraud‑flagged CDRs."
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers represented in CDRs."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_data_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data session usage metrics."
  source: "`telecommunication_ecm`.`usage`.`data_session`"
  dimensions:
    - name: "subscriber_id"
      expr: subscriber_id
      comment: "Subscriber identifier."
    - name: "rat_type"
      expr: rat_type
      comment: "Radio Access Technology type (e.g., LTE, 5G)."
    - name: "roaming_indicator"
      expr: roaming_indicator
      comment: "Indicates if session occurred while roaming."
    - name: "network_qos_profile_id"
      expr: network_qos_profile_id
      comment: "QoS profile applied to the session."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Number of data sessions."
    - name: "total_bytes"
      expr: SUM(CAST(total_bytes AS DOUBLE))
      comment: "Total bytes transferred in all sessions."
    - name: "total_downlink_bytes"
      expr: SUM(CAST(downlink_bytes AS DOUBLE))
      comment: "Total downlink bytes transferred."
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(session_duration_seconds AS DOUBLE))
      comment: "Average session duration (seconds)."
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers with data sessions."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_content_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Content consumption (OTT) metrics."
  source: "`telecommunication_ecm`.`usage`.`content_consumption`"
  dimensions:
    - name: "subscriber_id"
      expr: subscriber_id
      comment: "Subscriber identifier."
    - name: "ott_platform_id"
      expr: ott_platform_id
      comment: "OTT platform identifier."
    - name: "stream_quality"
      expr: stream_quality
      comment: "Streaming quality (e.g., HD, SD)."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for consumption."
    - name: "network_type"
      expr: network_type
      comment: "Network type (e.g., Wi‑Fi, LTE)."
    - name: "zero_rated_flag"
      expr: zero_rated_flag
      comment: "Flag indicating zero‑rated content."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Number of content consumption sessions."
    - name: "total_bytes_consumed"
      expr: SUM(CAST(bytes_consumed AS DOUBLE))
      comment: "Total bytes consumed across all sessions."
    - name: "total_rated_amount"
      expr: SUM(CAST(rated_amount AS DOUBLE))
      comment: "Total monetary amount charged for content."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average content completion percentage."
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(session_duration_seconds AS DOUBLE))
      comment: "Average session duration (seconds)."
    - name: "zero_rated_sessions"
      expr: SUM(CASE WHEN zero_rated_flag THEN 1 ELSE 0 END)
      comment: "Count of zero‑rated (free) sessions."
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers consuming content."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_sms_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SMS messaging metrics."
  source: "`telecommunication_ecm`.`usage`.`sms_record`"
  dimensions:
    - name: "subscriber_id"
      expr: subscriber_id
      comment: "Subscriber identifier."
    - name: "message_type"
      expr: message_type
      comment: "SMS message type (e.g., text, binary)."
    - name: "roaming_indicator"
      expr: roaming_indicator
      comment: "Indicates if SMS was sent/received while roaming."
    - name: "service_code"
      expr: service_code
      comment: "Service code associated with the SMS."
  measures:
    - name: "total_sms_records"
      expr: COUNT(1)
      comment: "Number of SMS records."
    - name: "total_rated_amount"
      expr: SUM(CAST(rated_amount AS DOUBLE))
      comment: "Total amount charged for SMS messages."
    - name: "avg_spam_score"
      expr: AVG(CAST(spam_score AS DOUBLE))
      comment: "Average spam score across SMS messages."
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers sending/receiving SMS."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_volte_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VoLTE session quality and revenue metrics."
  source: "`telecommunication_ecm`.`usage`.`volte_session`"
  dimensions:
    - name: "subscriber_id"
      expr: subscriber_id
      comment: "Subscriber identifier."
    - name: "call_type"
      expr: call_type
      comment: "Type of VoLTE call."
    - name: "call_direction"
      expr: call_direction
      comment: "Call direction (incoming/outgoing)."
    - name: "roaming_flag"
      expr: roaming_flag
      comment: "Indicates if the call was made while roaming."
    - name: "rat_type"
      expr: rat_type
      comment: "Radio Access Technology type for the call."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Number of VoLTE sessions."
    - name: "total_charged_amount"
      expr: SUM(CAST(charged_amount AS DOUBLE))
      comment: "Total amount charged for VoLTE sessions."
    - name: "avg_mos_score"
      expr: AVG(CAST(mos_score AS DOUBLE))
      comment: "Average Mean Opinion Score (voice quality)."
    - name: "avg_packet_loss_percent"
      expr: AVG(CAST(packet_loss_percent AS DOUBLE))
      comment: "Average packet loss percentage."
    - name: "total_jitter_ms"
      expr: SUM(CAST(jitter_ms AS DOUBLE))
      comment: "Total jitter in milliseconds across sessions."
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Distinct subscribers with VoLTE sessions."
$$;