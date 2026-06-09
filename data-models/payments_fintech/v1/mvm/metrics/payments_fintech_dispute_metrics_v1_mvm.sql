-- Metric views for domain: dispute | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and fraud metrics derived from the chargeback fact table"
  source: "`payments_fintech_ecm`.`dispute`.`chargeback`"
  dimensions:
    - name: "scheme_id"
      expr: scheme_id
      comment: "Identifier of the payment scheme"
    - name: "card_program_id"
      expr: card_program_id
      comment: "Card program associated with the chargeback"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Payment product used in the transaction"
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback"
    - name: "card_scheme"
      expr: card_scheme
      comment: "Card scheme name (e.g., Visa, MC)"
    - name: "currency"
      expr: currency
      comment: "Currency code of the chargeback amount"
    - name: "fraud_indicator"
      expr: fraud_indicator
      comment: "Boolean flag indicating fraud suspicion"
    - name: "is_partial_chargeback"
      expr: is_partial_chargeback
      comment: "Indicates if the chargeback is partial"
    - name: "liability_party"
      expr: liability_party
      comment: "Party held liable for the chargeback"
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the underlying transaction"
  measures:
    - name: "total_chargeback_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of all chargeback monetary amounts"
    - name: "average_chargeback_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average chargeback amount per record"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of all adjustment amounts linked to chargebacks"
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Number of chargeback records"
    - name: "fraud_chargeback_count"
      expr: SUM(CASE WHEN fraud_indicator THEN 1 ELSE 0 END)
      comment: "Count of chargebacks flagged as fraud"
    - name: "average_days_to_arbitration"
      expr: AVG(DATEDIFF(arbitration_deadline, created_timestamp))
      comment: "Average number of days between chargeback creation and arbitration deadline"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core dispute performance and outcome metrics"
  source: "`payments_fintech_ecm`.`dispute`.`dispute_case`"
  dimensions:
    - name: "scheme_id"
      expr: scheme_id
      comment: "Payment scheme identifier"
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Payment product involved"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type/category of the dispute"
    - name: "dispute_channel"
      expr: dispute_channel
      comment: "Channel through which the dispute was filed"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the dispute case"
    - name: "liability_party"
      expr: liability_party
      comment: "Party held liable for the dispute"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority assigned to the dispute"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates if the dispute is subject to regulatory reporting"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the dispute"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the dispute was created"
  measures:
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total monetary value of disputes"
    - name: "average_dispute_amount"
      expr: AVG(CAST(dispute_amount AS DOUBLE))
      comment: "Average dispute amount per case"
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Number of dispute cases"
    - name: "merchant_favorable_count"
      expr: SUM(CASE WHEN resolution_outcome = 'Merchant Favorable' THEN 1 ELSE 0 END)
      comment: "Count of disputes resolved in merchant's favor"
    - name: "average_resolution_time_days"
      expr: AVG(DATEDIFF(close_timestamp, created_timestamp))
      comment: "Average days from dispute creation to closure"
    - name: "total_interchange_fee"
      expr: SUM(CAST(interchange_fee_amount AS DOUBLE))
      comment: "Sum of interchange fees associated with disputes"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of fees associated with disputes"
  source: "`payments_fintech_ecm`.`dispute`.`fee`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Classification of the fee (e.g., arbitration, processing)"
    - name: "fee_status"
      expr: fee_status
      comment: "Current status of the fee"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating regulatory reporting relevance"
    - name: "due_date"
      expr: due_date
      comment: "Date the fee is due"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the fee record was created"
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total fee amount in original currency"
    - name: "total_fee_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total fee amount converted to USD"
    - name: "average_fee_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average fee amount per fee record"
    - name: "fee_count"
      expr: COUNT(1)
      comment: "Number of fee records"
    - name: "waived_fee_amount"
      expr: SUM(CASE WHEN waiver_flag THEN waiver_amount ELSE 0 END)
      comment: "Sum of fee amounts that were waived"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_financial_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on financial adjustments tied to disputes"
  source: "`payments_fintech_ecm`.`dispute`.`financial_adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of financial adjustment"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Payment scheme associated with the adjustment"
    - name: "liability_party"
      expr: liability_party
      comment: "Party liable for the adjustment"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates regulatory reporting relevance"
    - name: "posting_date"
      expr: posting_date
      comment: "Date the adjustment was posted"
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Sum of all financial adjustment amounts"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of financial adjustment records"
    - name: "average_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average adjustment amount per record"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`dispute_representment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance metrics for dispute representments"
  source: "`payments_fintech_ecm`.`dispute`.`representment`"
  dimensions:
    - name: "scheme_id"
      expr: scheme_id
      comment: "Payment scheme identifier"
    - name: "representment_type"
      expr: representment_type
      comment: "Type/category of the representment"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the representment"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the underlying dispute"
    - name: "response_deadline"
      expr: response_deadline
      comment: "Date by which a response is required"
    - name: "submission_date"
      expr: submission_date
      comment: "Date the representment was submitted"
    - name: "deadline_compliant"
      expr: deadline_compliant
      comment: "Boolean flag indicating if the representment met its deadline"
  measures:
    - name: "total_representment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary amount of representments"
    - name: "representment_count"
      expr: COUNT(1)
      comment: "Number of representment records"
    - name: "average_days_to_response_deadline"
      expr: AVG(DATEDIFF(response_deadline, CAST(created_timestamp AS DATE)))
      comment: "Average days from representment creation to response deadline"
$$;