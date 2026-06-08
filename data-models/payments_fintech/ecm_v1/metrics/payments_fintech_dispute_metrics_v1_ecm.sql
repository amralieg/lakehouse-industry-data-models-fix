-- Metric views for domain: dispute | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback performance metrics"
  source: "`payments_fintech_ecm`.`dispute`.`chargeback`"
  dimensions:
    - name: "month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of chargeback creation"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme identifier"
  measures:
    - name: "total_chargeback_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total chargeback amount in original currency"
    - name: "avg_chargeback_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average chargeback amount per chargeback"
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Number of chargebacks"
    - name: "distinct_merchant_count"
      expr: COUNT(DISTINCT merchant_id)
      comment: "Number of distinct merchants with chargebacks"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core dispute case metrics for executive oversight"
  source: "`payments_fintech_ecm`.`dispute`.`dispute_case`"
  dimensions:
    - name: "month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of dispute case creation"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g., card‑present, card‑not‑present)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the dispute"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the dispute"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the dispute case"
  measures:
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total amount disputed"
    - name: "avg_dispute_amount"
      expr: AVG(CAST(dispute_amount AS DOUBLE))
      comment: "Average dispute amount per case"
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Number of dispute cases"
    - name: "high_priority_dispute_count"
      expr: SUM(CASE WHEN priority_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high‑priority disputes"
    - name: "regulatory_reported_dispute_count"
      expr: SUM(CASE WHEN regulatory_reporting_flag THEN 1 ELSE 0 END)
      comment: "Count of disputes flagged for regulatory reporting"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee and waiver metrics to monitor cost and revenue impact"
  source: "`payments_fintech_ecm`.`dispute`.`fee`"
  dimensions:
    - name: "month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of fee assessment"
    - name: "fee_type"
      expr: fee_type
      comment: "Classification of the fee"
    - name: "fee_status"
      expr: fee_status
      comment: "Current status of the fee (e.g., posted, pending)"
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total fee amount assessed"
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total amount waived from fees"
    - name: "net_fee_amount"
      expr: SUM(amount - waiver_amount)
      comment: "Net fee amount after waivers"
    - name: "fee_count"
      expr: COUNT(1)
      comment: "Number of fee records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_financial_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial adjustment KPIs for risk and accounting oversight"
  source: "`payments_fintech_ecm`.`dispute`.`financial_adjustment`"
  dimensions:
    - name: "month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of adjustment creation"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type/category of the financial adjustment"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme linked to the adjustment"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates if the adjustment is a reversal"
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total amount of financial adjustments"
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average adjustment amount per record"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of financial adjustment records"
    - name: "reversal_adjustment_count"
      expr: SUM(CASE WHEN reversal_flag THEN 1 ELSE 0 END)
      comment: "Count of adjustments that are reversals"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_merchant_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchant response effectiveness metrics"
  source: "`payments_fintech_ecm`.`dispute`.`merchant_response`"
  dimensions:
    - name: "month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of merchant response"
    - name: "response_status"
      expr: response_status
      comment: "Status of the merchant response"
    - name: "merchant_id"
      expr: merchant_id
      comment: "Merchant identifier"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Scheme associated with the response"
  measures:
    - name: "total_liability_acceptance_amount"
      expr: SUM(CAST(liability_acceptance_amount AS DOUBLE))
      comment: "Total amount of liability accepted by merchants"
    - name: "avg_response_confidence_score"
      expr: AVG(CAST(response_confidence_score AS DOUBLE))
      comment: "Average confidence score of merchant responses"
    - name: "response_count"
      expr: COUNT(1)
      comment: "Number of merchant response records"
    - name: "rejected_response_count"
      expr: SUM(CASE WHEN response_status = 'Rejected' THEN 1 ELSE 0 END)
      comment: "Count of merchant responses that were rejected"
$$;