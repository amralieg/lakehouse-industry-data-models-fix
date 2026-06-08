-- Metric views for domain: partner | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_acquisition_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status metrics for acquisition deals"
  source: "`media_broadcasting_ecm`.`partner`.`acquisition_deal`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of acquisition deal (e.g., license, co‑production)"
  measures:
    - name: "total_deal_value"
      expr: SUM(CAST(deal_value_amount AS DOUBLE))
      comment: "Total monetary value of acquisition deals"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_distribution_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial exposure from carriage fee commitments"
  source: "`media_broadcasting_ecm`.`partner`.`distribution_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Distribution agreement type (e.g., linear, streaming)"
  measures:
    - name: "total_carriage_fee"
      expr: SUM(CAST(carriage_fee_amount AS DOUBLE))
      comment: "Total carriage fees across distribution agreements"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall financial commitment from partner agreements"
  source: "`media_broadcasting_ecm`.`partner`.`partner_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of partner agreement (e.g., master, affiliate)"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total contract value across partner agreements"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_payment_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow commitment from payment schedules"
  source: "`media_broadcasting_ecm`.`partner`.`payment_schedule`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., ACH, wire)"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payments scheduled"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`partner_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of renewals"
  source: "`media_broadcasting_ecm`.`partner`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal"
  measures:
    - name: "total_original_deal_value"
      expr: SUM(CAST(original_deal_value_amount AS DOUBLE))
      comment: "Total original deal value for renewals"
$$;