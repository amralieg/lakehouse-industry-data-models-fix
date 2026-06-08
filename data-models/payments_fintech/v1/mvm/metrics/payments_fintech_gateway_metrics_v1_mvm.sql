-- Metric views for domain: gateway | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key request activity metrics for the gateway"
  source: "`payments_fintech_ecm`.`gateway`.`request`"
  dimensions:
    - name: "request_date"
      expr: DATE_TRUNC('day', request_timestamp)
      comment: "Date of the request"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Payment product identifier"
    - name: "http_method"
      expr: http_method
      comment: "HTTP method used"
    - name: "endpoint_path"
      expr: endpoint_path
      comment: "API endpoint path"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of gateway requests"
    - name: "total_request_volume_bytes"
      expr: SUM(CAST(size_bytes AS DOUBLE))
      comment: "Total request payload size in bytes"
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average request latency in milliseconds"
    - name: "rate_limited_requests"
      expr: SUM(CASE WHEN is_rate_limited THEN 1 ELSE 0 END)
      comment: "Number of requests that were rate limited"
    - name: "distinct_merchants"
      expr: COUNT(DISTINCT merchant_id)
      comment: "Count of distinct merchants making requests"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Response outcome and financial metrics"
  source: "`payments_fintech_ecm`.`gateway`.`response`"
  dimensions:
    - name: "response_date"
      expr: DATE_TRUNC('day', response_timestamp)
      comment: "Date of the response"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Transaction type"
    - name: "response_code"
      expr: response_code
      comment: "Response code from acquirer"
    - name: "is_test_transaction"
      expr: is_test_transaction
      comment: "Flag indicating test transaction"
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total number of gateway responses"
    - name: "total_amount_cents"
      expr: SUM(CAST(amount_cents AS DOUBLE))
      comment: "Sum of response amounts in cents"
    - name: "avg_amount_cents"
      expr: AVG(CAST(amount_cents AS DOUBLE))
      comment: "Average response amount in cents"
    - name: "fraud_flagged_responses"
      expr: SUM(CASE WHEN is_fraud_flag THEN 1 ELSE 0 END)
      comment: "Number of responses flagged as fraud"
    - name: "declined_responses"
      expr: SUM(CASE WHEN decline_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of declined responses"
    - name: "approved_responses"
      expr: SUM(CASE WHEN response_code = '00' THEN 1 ELSE 0 END)
      comment: "Number of approved responses (response_code = '00')"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_routing_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Routing decision performance and risk metrics"
  source: "`payments_fintech_ecm`.`gateway`.`routing_decision`"
  dimensions:
    - name: "decision_date"
      expr: DATE_TRUNC('day', decision_timestamp)
      comment: "Date of the routing decision"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier"
    - name: "acquirer_endpoint_id"
      expr: acquirer_endpoint_id
      comment: "Acquirer endpoint identifier used in decision"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the routing decision"
    - name: "routing_decision_status"
      expr: routing_decision_status
      comment: "Status of the routing decision record"
    - name: "failover_triggered"
      expr: failover_triggered
      comment: "Flag indicating whether failover was triggered"
  measures:
    - name: "total_decisions"
      expr: COUNT(1)
      comment: "Total number of routing decisions"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across routing decisions"
    - name: "failover_decisions"
      expr: SUM(CASE WHEN failover_triggered THEN 1 ELSE 0 END)
      comment: "Number of decisions that triggered a failover"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_sla_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement performance metrics"
  source: "`payments_fintech_ecm`.`gateway`.`sla_profile`"
  dimensions:
    - name: "sla_code"
      expr: sla_code
      comment: "SLA code identifier"
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., availability, latency)"
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Ecosystem partner associated with the SLA"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier linked to the SLA"
  measures:
    - name: "total_sla_profiles"
      expr: COUNT(1)
      comment: "Total number of SLA profiles"
    - name: "avg_error_rate_threshold_pct"
      expr: AVG(CAST(error_rate_threshold_pct AS DOUBLE))
      comment: "Average error rate threshold percentage across SLAs"
    - name: "avg_target_availability_pct"
      expr: AVG(CAST(target_availability_pct AS DOUBLE))
      comment: "Average target availability percentage across SLAs"
    - name: "avg_last_measured_availability_pct"
      expr: AVG(CAST(last_measured_availability_pct AS DOUBLE))
      comment: "Average of last measured availability percentages"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount across SLA breaches"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`gateway_rate_limit_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate limit policy capacity and usage metrics"
  source: "`payments_fintech_ecm`.`gateway`.`rate_limit_policy`"
  dimensions:
    - name: "policy_name"
      expr: policy_name
      comment: "Name of the rate limit policy"
    - name: "tier_name"
      expr: tier_name
      comment: "Tier name associated with the policy"
    - name: "policy_type"
      expr: policy_type
      comment: "Type/category of the policy"
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Ecosystem partner owning the policy"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of rate limit policies"
    - name: "avg_daily_cap"
      expr: AVG(CAST(daily_cap AS DOUBLE))
      comment: "Average daily request cap across policies"
    - name: "active_policies"
      expr: SUM(CASE WHEN rate_limit_policy_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of policies currently active"
$$;