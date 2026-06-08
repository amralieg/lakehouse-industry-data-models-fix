-- Metric views for domain: usage | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:31:09

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_aggregated_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated Usage business metrics"
  source: "`telecommunication_ecm`.`usage`.`aggregated_usage`"
  dimensions:
    - name: "Aggregation End Timestamp"
      expr: aggregation_end_timestamp
    - name: "Aggregation Period Type"
      expr: aggregation_period_type
    - name: "Aggregation Start Timestamp"
      expr: aggregation_start_timestamp
    - name: "Aggregation Status"
      expr: aggregation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fair Use Policy Threshold Exceeded"
      expr: fair_use_policy_threshold_exceeded
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Mediation Source System"
      expr: mediation_source_system
    - name: "Revenue Assurance Flag"
      expr: revenue_assurance_flag
    - name: "Roaming Country Code"
      expr: roaming_country_code
    - name: "Roaming Partner Network Code"
      expr: roaming_partner_network_code
    - name: "Throttling Applied"
      expr: throttling_applied
    - name: "Unique Cell Tower Count"
      expr: unique_cell_tower_count
    - name: "Aggregation End Timestamp Month"
      expr: DATE_TRUNC('MONTH', aggregation_end_timestamp)
    - name: "Aggregation Start Timestamp Month"
      expr: DATE_TRUNC('MONTH', aggregation_start_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aggregated Usage"
      expr: COUNT(DISTINCT aggregated_usage_id)
    - name: "Total Content Streaming Hours"
      expr: SUM(content_streaming_hours)
    - name: "Average Content Streaming Hours"
      expr: AVG(content_streaming_hours)
    - name: "Total Data Volume Mb 2g"
      expr: SUM(data_volume_mb_2g)
    - name: "Average Data Volume Mb 2g"
      expr: AVG(data_volume_mb_2g)
    - name: "Total Data Volume Mb 3g"
      expr: SUM(data_volume_mb_3g)
    - name: "Average Data Volume Mb 3g"
      expr: AVG(data_volume_mb_3g)
    - name: "Total Data Volume Mb 4g Lte"
      expr: SUM(data_volume_mb_4g_lte)
    - name: "Average Data Volume Mb 4g Lte"
      expr: AVG(data_volume_mb_4g_lte)
    - name: "Total Data Volume Mb 5g"
      expr: SUM(data_volume_mb_5g)
    - name: "Average Data Volume Mb 5g"
      expr: AVG(data_volume_mb_5g)
    - name: "Total Data Volume Mb Roaming"
      expr: SUM(data_volume_mb_roaming)
    - name: "Average Data Volume Mb Roaming"
      expr: AVG(data_volume_mb_roaming)
    - name: "Total Data Volume Mb Wifi Offload"
      expr: SUM(data_volume_mb_wifi_offload)
    - name: "Average Data Volume Mb Wifi Offload"
      expr: AVG(data_volume_mb_wifi_offload)
    - name: "Total Dpi Category Gaming Mb"
      expr: SUM(dpi_category_gaming_mb)
    - name: "Average Dpi Category Gaming Mb"
      expr: AVG(dpi_category_gaming_mb)
    - name: "Total Dpi Category Other Mb"
      expr: SUM(dpi_category_other_mb)
    - name: "Average Dpi Category Other Mb"
      expr: AVG(dpi_category_other_mb)
    - name: "Total Dpi Category Social Media Mb"
      expr: SUM(dpi_category_social_media_mb)
    - name: "Average Dpi Category Social Media Mb"
      expr: AVG(dpi_category_social_media_mb)
    - name: "Total Dpi Category Video Streaming Mb"
      expr: SUM(dpi_category_video_streaming_mb)
    - name: "Average Dpi Category Video Streaming Mb"
      expr: AVG(dpi_category_video_streaming_mb)
    - name: "Total Iptv Viewing Hours"
      expr: SUM(iptv_viewing_hours)
    - name: "Average Iptv Viewing Hours"
      expr: AVG(iptv_viewing_hours)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_anomaly`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anomaly business metrics"
  source: "`telecommunication_ecm`.`usage`.`anomaly`"
  dimensions:
    - name: "Affected Record Reference"
      expr: affected_record_reference
    - name: "Anomaly Type"
      expr: anomaly_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Detection Source System"
      expr: detection_source_system
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Investigation Status"
      expr: investigation_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Recurrence Flag"
      expr: recurrence_flag
    - name: "Reference Number"
      expr: reference_number
    - name: "Resolution Action"
      expr: resolution_action
    - name: "Resolution Timestamp"
      expr: resolution_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Anomaly"
      expr: COUNT(DISTINCT anomaly_id)
    - name: "Total Actual Value"
      expr: SUM(actual_value)
    - name: "Average Actual Value"
      expr: AVG(actual_value)
    - name: "Total Deviation Percentage"
      expr: SUM(deviation_percentage)
    - name: "Average Deviation Percentage"
      expr: AVG(deviation_percentage)
    - name: "Total Expected Value"
      expr: SUM(expected_value)
    - name: "Average Expected Value"
      expr: AVG(expected_value)
    - name: "Total Revenue Impact Amount"
      expr: SUM(revenue_impact_amount)
    - name: "Average Revenue Impact Amount"
      expr: AVG(revenue_impact_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Balance business metrics"
  source: "`telecommunication_ecm`.`usage`.`balance`"
  dimensions:
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Balance Status"
      expr: balance_status
    - name: "Balance Type"
      expr: balance_type
    - name: "Charging System Source"
      expr: charging_system_source
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fair Usage Policy Flag"
      expr: fair_usage_policy_flag
    - name: "Group Code"
      expr: group_code
    - name: "Last Consumption Timestamp"
      expr: last_consumption_timestamp
    - name: "Last Top Up Timestamp"
      expr: last_top_up_timestamp
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Network Type"
      expr: network_type
    - name: "Overage Flag"
      expr: overage_flag
    - name: "Period End Timestamp"
      expr: period_end_timestamp
    - name: "Period Start Timestamp"
      expr: period_start_timestamp
    - name: "Priority Level"
      expr: priority_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Balance"
      expr: COUNT(DISTINCT balance_id)
    - name: "Total Consumed Quantity"
      expr: SUM(consumed_quantity)
    - name: "Average Consumed Quantity"
      expr: AVG(consumed_quantity)
    - name: "Total Consumption Percentage"
      expr: SUM(consumption_percentage)
    - name: "Average Consumption Percentage"
      expr: AVG(consumption_percentage)
    - name: "Total Fair Usage Threshold"
      expr: SUM(fair_usage_threshold)
    - name: "Average Fair Usage Threshold"
      expr: AVG(fair_usage_threshold)
    - name: "Total Initial Balance Quantity"
      expr: SUM(initial_balance_quantity)
    - name: "Average Initial Balance Quantity"
      expr: AVG(initial_balance_quantity)
    - name: "Total Notification Threshold 1"
      expr: SUM(notification_threshold_1)
    - name: "Average Notification Threshold 1"
      expr: AVG(notification_threshold_1)
    - name: "Total Notification Threshold 2"
      expr: SUM(notification_threshold_2)
    - name: "Average Notification Threshold 2"
      expr: AVG(notification_threshold_2)
    - name: "Total Overage Quantity"
      expr: SUM(overage_quantity)
    - name: "Average Overage Quantity"
      expr: AVG(overage_quantity)
    - name: "Total Remaining Quantity"
      expr: SUM(remaining_quantity)
    - name: "Average Remaining Quantity"
      expr: AVG(remaining_quantity)
    - name: "Total Rollover Quantity"
      expr: SUM(rollover_quantity)
    - name: "Average Rollover Quantity"
      expr: AVG(rollover_quantity)
    - name: "Total Throttle Threshold Quantity"
      expr: SUM(throttle_threshold_quantity)
    - name: "Average Throttle Threshold Quantity"
      expr: AVG(throttle_threshold_quantity)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_cdr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cdr business metrics"
  source: "`telecommunication_ecm`.`usage`.`cdr`"
  dimensions:
    - name: "Bearer Service Code"
      expr: bearer_service_code
    - name: "Call Category"
      expr: call_category
    - name: "Call Direction"
      expr: call_direction
    - name: "Call Duration Seconds"
      expr: call_duration_seconds
    - name: "Call End Timestamp"
      expr: call_end_timestamp
    - name: "Call Start Timestamp"
      expr: call_start_timestamp
    - name: "Call Type"
      expr: call_type
    - name: "Charging Indicator"
      expr: charging_indicator
    - name: "Collection Timestamp"
      expr: collection_timestamp
    - name: "Correction Indicator"
      expr: correction_indicator
    - name: "Fraud Indicator"
      expr: fraud_indicator
    - name: "Imei"
      expr: imei
    - name: "Ingestion Timestamp"
      expr: ingestion_timestamp
    - name: "Location Area Code"
      expr: location_area_code
    - name: "Mediation Status"
      expr: mediation_status
    - name: "Mediation Timestamp"
      expr: mediation_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cdr"
      expr: COUNT(DISTINCT cdr_id)
    - name: "Total Data Volume Downlink Bytes"
      expr: SUM(data_volume_downlink_bytes)
    - name: "Average Data Volume Downlink Bytes"
      expr: AVG(data_volume_downlink_bytes)
    - name: "Total Data Volume Uplink Bytes"
      expr: SUM(data_volume_uplink_bytes)
    - name: "Average Data Volume Uplink Bytes"
      expr: AVG(data_volume_uplink_bytes)
    - name: "Total Record Sequence Number"
      expr: SUM(record_sequence_number)
    - name: "Average Record Sequence Number"
      expr: AVG(record_sequence_number)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_data_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data Session business metrics"
  source: "`telecommunication_ecm`.`usage`.`data_session`"
  dimensions:
    - name: "Apn"
      expr: apn
    - name: "Charging Characteristics"
      expr: charging_characteristics
    - name: "Charging Reference"
      expr: charging_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Five Qi"
      expr: five_qi
    - name: "Home Plmn Code"
      expr: home_plmn_code
    - name: "Imei"
      expr: imei
    - name: "Location Area Code"
      expr: location_area_code
    - name: "Mediation Timestamp"
      expr: mediation_timestamp
    - name: "Msisdn"
      expr: msisdn
    - name: "Pdn Type"
      expr: pdn_type
    - name: "Pgw Address"
      expr: pgw_address
    - name: "Qci"
      expr: qci
    - name: "Rat Type"
      expr: rat_type
    - name: "Rating Group"
      expr: rating_group
    - name: "Record Closing Time"
      expr: record_closing_time
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Data Session"
      expr: COUNT(DISTINCT data_session_id)
    - name: "Total Downlink Bytes"
      expr: SUM(downlink_bytes)
    - name: "Average Downlink Bytes"
      expr: AVG(downlink_bytes)
    - name: "Total Peak Downlink Throughput Kbps"
      expr: SUM(peak_downlink_throughput_kbps)
    - name: "Average Peak Downlink Throughput Kbps"
      expr: AVG(peak_downlink_throughput_kbps)
    - name: "Total Peak Uplink Throughput Kbps"
      expr: SUM(peak_uplink_throughput_kbps)
    - name: "Average Peak Uplink Throughput Kbps"
      expr: AVG(peak_uplink_throughput_kbps)
    - name: "Total Record Sequence Number"
      expr: SUM(record_sequence_number)
    - name: "Average Record Sequence Number"
      expr: AVG(record_sequence_number)
    - name: "Total Session Duration Seconds"
      expr: SUM(session_duration_seconds)
    - name: "Average Session Duration Seconds"
      expr: AVG(session_duration_seconds)
    - name: "Total Total Bytes"
      expr: SUM(total_bytes)
    - name: "Average Total Bytes"
      expr: AVG(total_bytes)
    - name: "Total Uplink Bytes"
      expr: SUM(uplink_bytes)
    - name: "Average Uplink Bytes"
      expr: AVG(uplink_bytes)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_mediation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mediation Event business metrics"
  source: "`telecommunication_ecm`.`usage`.`mediation_event`"
  dimensions:
    - name: "Acknowledgement Timestamp"
      expr: acknowledgement_timestamp
    - name: "Apn"
      expr: apn
    - name: "Called Party"
      expr: called_party
    - name: "Calling Party"
      expr: calling_party
    - name: "Collection Timestamp"
      expr: collection_timestamp
    - name: "Delivery Acknowledgement Flag"
      expr: delivery_acknowledgement_flag
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Downstream System Code"
      expr: downstream_system_code
    - name: "Duration Seconds"
      expr: duration_seconds
    - name: "Enrichment Timestamp"
      expr: enrichment_timestamp
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Imei"
      expr: imei
    - name: "Location Area Code"
      expr: location_area_code
    - name: "Manual Review Queue"
      expr: manual_review_queue
    - name: "Mediation Node Code"
      expr: mediation_node_code
    - name: "Msisdn"
      expr: msisdn
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mediation Event"
      expr: COUNT(DISTINCT mediation_event_id)
    - name: "Total Data Volume Bytes"
      expr: SUM(data_volume_bytes)
    - name: "Average Data Volume Bytes"
      expr: AVG(data_volume_bytes)
    - name: "Total Download Bytes"
      expr: SUM(download_bytes)
    - name: "Average Download Bytes"
      expr: AVG(download_bytes)
    - name: "Total Upload Bytes"
      expr: SUM(upload_bytes)
    - name: "Average Upload Bytes"
      expr: AVG(upload_bytes)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_roaming_file`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roaming File business metrics"
  source: "`telecommunication_ecm`.`usage`.`roaming_file`"
  dimensions:
    - name: "Acknowledgement Timestamp"
      expr: acknowledgement_timestamp
    - name: "Clearing House Name"
      expr: clearing_house_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason Code"
      expr: dispute_reason_code
    - name: "File Available Timestamp"
      expr: file_available_timestamp
    - name: "File Checksum"
      expr: file_checksum
    - name: "File Compression Type"
      expr: file_compression_type
    - name: "File Generation Timestamp"
      expr: file_generation_timestamp
    - name: "File Status"
      expr: file_status
    - name: "File Type Code"
      expr: file_type_code
    - name: "Iot Tariff Applied"
      expr: iot_tariff_applied
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Processing Notes"
      expr: processing_notes
    - name: "Rap File Generated Flag"
      expr: rap_file_generated_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Roaming File"
      expr: COUNT(DISTINCT roaming_file_id)
    - name: "Total Call Event Count"
      expr: SUM(call_event_count)
    - name: "Average Call Event Count"
      expr: AVG(call_event_count)
    - name: "Total Data Event Count"
      expr: SUM(data_event_count)
    - name: "Average Data Event Count"
      expr: AVG(data_event_count)
    - name: "Total File Sequence Number"
      expr: SUM(file_sequence_number)
    - name: "Average File Sequence Number"
      expr: AVG(file_sequence_number)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
    - name: "Total Sms Event Count"
      expr: SUM(sms_event_count)
    - name: "Average Sms Event Count"
      expr: AVG(sms_event_count)
    - name: "Total Total Charge Amount"
      expr: SUM(total_charge_amount)
    - name: "Average Total Charge Amount"
      expr: AVG(total_charge_amount)
    - name: "Total Total Discount Amount"
      expr: SUM(total_discount_amount)
    - name: "Average Total Discount Amount"
      expr: AVG(total_discount_amount)
    - name: "Total Total Record Count"
      expr: SUM(total_record_count)
    - name: "Average Total Record Count"
      expr: AVG(total_record_count)
    - name: "Total Total Tax Amount"
      expr: SUM(total_tax_amount)
    - name: "Average Total Tax Amount"
      expr: AVG(total_tax_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`usage_sms_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sms Record business metrics"
  source: "`telecommunication_ecm`.`usage`.`sms_record`"
  dimensions:
    - name: "Cdr Sequence Number"
      expr: cdr_sequence_number
    - name: "Charging Indicator"
      expr: charging_indicator
    - name: "Content Class"
      expr: content_class
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Coding Scheme"
      expr: data_coding_scheme
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Fraud Flag"
      expr: fraud_flag
    - name: "Home Network Code"
      expr: home_network_code
    - name: "Imei"
      expr: imei
    - name: "Mediation Status"
      expr: mediation_status
    - name: "Mediation Timestamp"
      expr: mediation_timestamp
    - name: "Message Reference"
      expr: message_reference
    - name: "Message Segment Count"
      expr: message_segment_count
    - name: "Message Size Bytes"
      expr: message_size_bytes
    - name: "Message Timestamp"
      expr: message_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sms Record"
      expr: COUNT(DISTINCT sms_record_id)
    - name: "Total Rated Amount"
      expr: SUM(rated_amount)
    - name: "Average Rated Amount"
      expr: AVG(rated_amount)
    - name: "Total Spam Score"
      expr: SUM(spam_score)
    - name: "Average Spam Score"
      expr: AVG(spam_score)
$$;