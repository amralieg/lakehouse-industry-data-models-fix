-- Metric views for domain: network | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_connectivity_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key operational metrics for network connectivity events"
  source: "`payments_fintech_ecm`.`network`.`connectivity_event`"
  dimensions:
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the connectivity event"
    - name: "event_type"
      expr: event_type
      comment: "Type of connectivity event (e.g., handshake, data transfer)"
    - name: "protocol"
      expr: protocol
      comment: "Network protocol used (e.g., TLS, HTTP)"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Identifier of the card/payment scheme"
    - name: "endpoint_id"
      expr: endpoint_id
      comment: "Endpoint involved in the event"
    - name: "certificate_status"
      expr: certificate_status
      comment: "Status of the TLS certificate at event time"
    - name: "is_successful"
      expr: is_successful
      comment: "Boolean flag indicating if the event succeeded"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of connectivity events recorded"
    - name: "total_affected_volume"
      expr: SUM(CAST(affected_transaction_volume AS DOUBLE))
      comment: "Sum of transaction volume impacted by connectivity events"
    - name: "successful_events"
      expr: SUM(CASE WHEN is_successful THEN 1 ELSE 0 END)
      comment: "Count of events that completed successfully"
    - name: "failed_events"
      expr: SUM(CASE WHEN NOT is_successful THEN 1 ELSE 0 END)
      comment: "Count of events that failed"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_endpoint_health`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health and performance metrics for network endpoints"
  source: "`payments_fintech_ecm`.`network`.`endpoint`"
  dimensions:
    - name: "endpoint_status"
      expr: endpoint_status
      comment: "Operational status of the endpoint"
    - name: "is_primary"
      expr: is_primary
      comment: "Indicates if the endpoint is the primary node"
    - name: "is_tls_mutual"
      expr: is_tls_mutual
      comment: "Indicates if mutual TLS is enabled"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Associated scheme identifier"
    - name: "region_id"
      expr: region_id
      comment: "Geographic region of the endpoint"
    - name: "data_center_location"
      expr: data_center_location
      comment: "Physical data‑center location"
    - name: "health_status"
      expr: health_status
      comment: "Current health status reported by monitoring"
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total number of endpoints defined"
    - name: "avg_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average latency in milliseconds across endpoints"
    - name: "total_throughput_tps"
      expr: SUM(CAST(throughput_tps AS DOUBLE))
      comment: "Aggregate throughput (transactions per second) across all endpoints"
    - name: "compliant_iso20022_endpoints"
      expr: SUM(CASE WHEN compliance_iso_20022 THEN 1 ELSE 0 END)
      comment: "Count of endpoints compliant with ISO 20022"
    - name: "compliant_pci_dss_endpoints"
      expr: SUM(CASE WHEN compliance_pci_dss THEN 1 ELSE 0 END)
      comment: "Count of endpoints PCI DSS compliant"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_sla_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA performance and penalty metrics for network services"
  source: "`payments_fintech_ecm`.`network`.`sla`"
  dimensions:
    - name: "sla_category"
      expr: sla_category
      comment: "Category of SLA (e.g., latency, availability)"
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme associated with the SLA"
    - name: "endpoint_identifier"
      expr: endpoint_identifier
      comment: "Identifier of the endpoint covered by the SLA"
    - name: "effective_from"
      expr: effective_from
      comment: "Start date of SLA effectiveness"
    - name: "effective_until"
      expr: effective_until
      comment: "End date of SLA effectiveness"
  measures:
    - name: "total_slas"
      expr: COUNT(1)
      comment: "Total SLA records defined"
    - name: "sla_penalty_total"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties across SLAs"
    - name: "avg_actual_uptime_pct"
      expr: AVG(CAST(actual_uptime_percentage AS DOUBLE))
      comment: "Average actual uptime percentage"
    - name: "avg_target_uptime_pct"
      expr: AVG(CAST(target_uptime_percentage AS DOUBLE))
      comment: "Average target uptime percentage"
    - name: "met_sla_count"
      expr: SUM(CASE WHEN actual_uptime_percentage >= target_uptime_percentage THEN 1 ELSE 0 END)
      comment: "Count of SLAs where actual uptime met or exceeded target"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_volume_limit_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization of transaction volume limits across schemes"
  source: "`payments_fintech_ecm`.`network`.`volume_limit`"
  dimensions:
    - name: "limit_type"
      expr: limit_type
      comment: "Type of limit (e.g., daily, monthly)"
    - name: "limit_scope"
      expr: limit_scope
      comment: "Scope of the limit (e.g., merchant, transaction)"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Associated scheme identifier"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Transaction type the limit applies to"
    - name: "effective_from"
      expr: effective_from
      comment: "Date when the limit becomes effective"
    - name: "effective_until"
      expr: effective_until
      comment: "Date when the limit expires"
  measures:
    - name: "total_limits"
      expr: COUNT(1)
      comment: "Number of volume limit definitions"
    - name: "total_limit_value"
      expr: SUM(CAST(limit_value AS DOUBLE))
      comment: "Aggregate of defined limit values"
    - name: "total_usage_amount"
      expr: SUM(CAST(usage_amount AS DOUBLE))
      comment: "Aggregate of usage amounts against limits"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_message_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and risk metrics derived from network message logs"
  source: "`payments_fintech_ecm`.`network`.`message_log`"
  dimensions:
    - name: "message_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the message event"
    - name: "message_type_indicator"
      expr: message_type_indicator
      comment: "Message type indicator (e.g., 0100, 0200)"
    - name: "message_direction"
      expr: message_direction
      comment: "Direction of the message (inbound/outbound)"
    - name: "network_scheme"
      expr: network_scheme
      comment: "Scheme associated with the message"
    - name: "network_status"
      expr: network_status
      comment: "Processing status of the message"
    - name: "source_ip"
      expr: source_ip
      comment: "Source IP address"
    - name: "destination_ip"
      expr: destination_ip
      comment: "Destination IP address"
  measures:
    - name: "total_messages"
      expr: COUNT(1)
      comment: "Total number of network messages logged"
    - name: "total_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of monetary amount across messages"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score for messages"
    - name: "test_message_count"
      expr: SUM(CASE WHEN is_test_message THEN 1 ELSE 0 END)
      comment: "Count of test messages"
    - name: "failed_message_count"
      expr: SUM(CASE WHEN authorization_status <> 'APPROVED' THEN 1 ELSE 0 END)
      comment: "Count of messages that were not approved"
$$;