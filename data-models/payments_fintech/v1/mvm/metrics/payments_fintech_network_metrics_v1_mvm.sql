-- Metric views for domain: network | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key operational health and performance metrics for network endpoints"
  source: "`payments_fintech_ecm`.`network`.`endpoint`"
  dimensions:
    - name: "endpoint_status"
      expr: endpoint_status
      comment: "Current operational status of the endpoint (e.g., ACTIVE, INACTIVE)"
    - name: "connection_type"
      expr: connection_type
      comment: "Type of network connection (e.g., VPN, DIRECT)"
    - name: "data_center_location"
      expr: data_center_location
      comment: "Geographic location of the data center hosting the endpoint"
    - name: "is_primary"
      expr: is_primary
      comment: "Flag indicating if this endpoint is the primary endpoint for its partner"
    - name: "protocol_version"
      expr: protocol_version
      comment: "Version of the communication protocol used"
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total number of network endpoints"
    - name: "active_endpoint_count"
      expr: COUNT(CASE WHEN endpoint_status = 'ACTIVE' THEN 1 END)
      comment: "Count of endpoints currently active"
    - name: "average_latency_ms"
      expr: AVG(CAST(average_latency_ms AS DOUBLE))
      comment: "Average observed latency across endpoints (ms)"
    - name: "total_throughput_tps"
      expr: SUM(CAST(throughput_tps AS DOUBLE))
      comment: "Total transaction throughput across all endpoints (transactions per second)"
    - name: "pci_compliant_endpoint_count"
      expr: COUNT(CASE WHEN compliance_pci_dss = TRUE THEN 1 END)
      comment: "Number of endpoints that are PCI DSS compliant"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_scheme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for payment schemes influencing revenue and risk"
  source: "`payments_fintech_ecm`.`network`.`scheme`"
  dimensions:
    - name: "scheme_status"
      expr: scheme_status
      comment: "Operational status of the scheme (e.g., ACTIVE, RETIRED)"
    - name: "scheme_type"
      expr: scheme_type
      comment: "Classification of the scheme (e.g., CARD, ACCOUNT)"
    - name: "settlement_currency"
      expr: settlement_currency
      comment: "Currency used for settlement in the scheme"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Regions where the scheme is available"
  measures:
    - name: "total_schemes"
      expr: COUNT(1)
      comment: "Total number of payment schemes"
    - name: "average_interchange_fee_rate"
      expr: AVG(CAST(interchange_fee_rate AS DOUBLE))
      comment: "Average interchange fee rate across schemes"
    - name: "three_ds_supported_scheme_count"
      expr: COUNT(CASE WHEN three_ds_supported = TRUE THEN 1 END)
      comment: "Number of schemes that support 3‑Domain Secure (3DS)"
    - name: "tokenization_supported_scheme_count"
      expr: COUNT(CASE WHEN tokenization_supported = TRUE THEN 1 END)
      comment: "Number of schemes that support tokenization"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_scheme_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact metrics for scheme fee schedules"
  source: "`payments_fintech_ecm`.`network`.`scheme_fee_schedule`"
  dimensions:
    - name: "card_type"
      expr: card_type
      comment: "Card type the fee schedule applies to (e.g., CREDIT, DEBIT)"
    - name: "fee_type"
      expr: fee_type
      comment: "Classification of the fee (e.g., INTERCHANGE, SERVICE)"
    - name: "applicable_to_domestic"
      expr: applicable_to_domestic
      comment: "Indicates if the fee schedule applies to domestic transactions"
    - name: "applicable_to_international"
      expr: applicable_to_international
      comment: "Indicates if the fee schedule applies to international transactions"
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount across all fee schedules"
    - name: "average_fee_rate"
      expr: AVG(CAST(fee_rate AS DOUBLE))
      comment: "Average fee rate applied in fee schedules"
    - name: "cross_border_fee_schedule_count"
      expr: COUNT(CASE WHEN is_cross_border = TRUE THEN 1 END)
      comment: "Number of fee schedules that apply to cross‑border transactions"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_routing_table`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational cost and resilience metrics for routing tables"
  source: "`payments_fintech_ecm`.`network`.`routing_table`"
  dimensions:
    - name: "routing_type"
      expr: routing_type
      comment: "Type of routing (e.g., PRIMARY, SECONDARY)"
    - name: "processing_rail"
      expr: processing_rail
      comment: "Processing rail used for the routing entry"
    - name: "target_network"
      expr: target_network
      comment: "Destination network identifier"
  measures:
    - name: "total_fee_rate"
      expr: SUM(CAST(fee_rate AS DOUBLE))
      comment: "Sum of fee rates across routing table entries"
    - name: "average_surcharge_amount"
      expr: AVG(CAST(surcharge_amount AS DOUBLE))
      comment: "Average surcharge amount applied in routing rules"
    - name: "fallback_enabled_count"
      expr: COUNT(CASE WHEN is_fallback_enabled = TRUE THEN 1 END)
      comment: "Number of routing entries where fallback is enabled"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`network_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and risk metrics for service level agreements"
  source: "`payments_fintech_ecm`.`network`.`sla`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA (e.g., ACTIVE, EXPIRED)"
    - name: "sla_category"
      expr: sla_category
      comment: "Category of SLA (e.g., PERFORMANCE, AVAILABILITY)"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Identifier of the scheme the SLA is associated with"
  measures:
    - name: "total_sla_records"
      expr: COUNT(1)
      comment: "Total number of SLA records"
    - name: "average_actual_uptime_pct"
      expr: AVG(CAST(actual_uptime_percentage AS DOUBLE))
      comment: "Average actual uptime percentage across SLAs"
    - name: "average_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average monetary penalty applied for SLA breaches"
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN actual_uptime_percentage < target_uptime_percentage THEN 1 END)
      comment: "Count of SLA records where actual uptime fell below target"
$$;