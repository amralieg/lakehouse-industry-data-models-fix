-- Metric views for domain: gateway | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core request activity metrics for monitoring gateway load and performance"
  source: "`payments_fintech_ecm`.`gateway`.`request`"
  dimensions:
    - name: "merchant_id"
      expr: merchant_id
      comment: "Identifier of the merchant initiating the request"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Payment product used for the request"
    - name: "protocol"
      expr: protocol
      comment: "Protocol used (e.g., HTTP, HTTPS)"
    - name: "http_method"
      expr: http_method
      comment: "HTTP method of the request"
    - name: "request_date"
      expr: DATE_TRUNC('day', request_timestamp)
      comment: "Date of the request (day bucket)"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of API requests received"
    - name: "total_latency_ms"
      expr: SUM(CAST(latency_ms AS DOUBLE))
      comment: "Sum of request latency in milliseconds"
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average request latency in milliseconds"
    - name: "total_bytes"
      expr: SUM(CAST(size_bytes AS DOUBLE))
      comment: "Total payload size in bytes across all requests"
    - name: "rate_limited_requests"
      expr: SUM(CASE WHEN is_rate_limited THEN 1 ELSE 0 END)
      comment: "Count of requests that were rate‑limited"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Response‑level financial and risk metrics"
  source: "`payments_fintech_ecm`.`gateway`.`response`"
  dimensions:
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant receiving the response"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Payment product associated with the response"
    - name: "response_code"
      expr: response_code
      comment: "Gateway response code (e.g., 200, 402)"
    - name: "response_date"
      expr: DATE_TRUNC('day', response_timestamp)
      comment: "Date of the response (day bucket)"
    - name: "card_scheme_id"
      expr: card_scheme_id
      comment: "Card scheme identifier (e.g., Visa, MC)"
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total number of gateway responses generated"
    - name: "total_amount_cents"
      expr: SUM(CAST(amount_cents AS DOUBLE))
      comment: "Sum of transaction amounts (in cents) across all responses"
    - name: "avg_amount_cents"
      expr: AVG(CAST(amount_cents AS DOUBLE))
      comment: "Average transaction amount (in cents) per response"
    - name: "fraud_response_count"
      expr: SUM(CASE WHEN is_fraud_flag THEN 1 ELSE 0 END)
      comment: "Number of responses flagged as potential fraud"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_endpoint_health`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational health monitoring of acquirer endpoints"
  source: "`payments_fintech_ecm`.`gateway`.`endpoint_health`"
  dimensions:
    - name: "acquirer_endpoint_id"
      expr: acquirer_endpoint_id
      comment: "Acquirer endpoint being monitored"
    - name: "health_check_type"
      expr: health_check_type
      comment: "Type of health check performed"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the endpoint"
    - name: "health_check_date"
      expr: DATE_TRUNC('day', check_timestamp)
      comment: "Date of the health check (day bucket)"
  measures:
    - name: "total_health_checks"
      expr: COUNT(1)
      comment: "Total health‑check records captured"
    - name: "unhealthy_check_count"
      expr: SUM(CASE WHEN endpoint_health_status = 'UNHEALTHY' THEN 1 ELSE 0 END)
      comment: "Count of health checks reporting UNHEALTHY status"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_sla_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key SLA performance indicators"
  source: "`payments_fintech_ecm`.`gateway`.`sla_measurement`"
  dimensions:
    - name: "sla_profile_id"
      expr: sla_profile_id
      comment: "SLA profile linked to the measurement"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of the SLA measurement (day bucket)"
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source system that reported the SLA measurement"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total SLA measurement records collected"
    - name: "avg_latency_p50_ms"
      expr: AVG(CAST(latency_p50_ms AS DOUBLE))
      comment: "Average 50th percentile latency (ms) across measurements"
    - name: "avg_error_rate_percent"
      expr: AVG(CAST(error_rate_percent AS DOUBLE))
      comment: "Average error‑rate percentage across measurements"
    - name: "total_tps"
      expr: SUM(CAST(tps AS DOUBLE))
      comment: "Total transactions‑per‑second observed across all measurements"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_failover_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational impact metrics for gateway failover events"
  source: "`payments_fintech_ecm`.`gateway`.`failover_event`"
  dimensions:
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant affected by the failover"
    - name: "network_name"
      expr: network_name
      comment: "Network on which the failover occurred"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the failover"
    - name: "failover_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the failover event (day bucket)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction impacted"
  measures:
    - name: "total_failovers"
      expr: COUNT(1)
      comment: "Total number of failover events recorded"
    - name: "total_affected_amount"
      expr: SUM(CAST(affected_transaction_amount AS DOUBLE))
      comment: "Sum of transaction amounts impacted by failovers"
    - name: "total_affected_volume"
      expr: SUM(CAST(affected_transaction_volume AS DOUBLE))
      comment: "Total number of transactions impacted by failovers"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of failover events that triggered an SLA breach"
$$;