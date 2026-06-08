-- Metric views for domain: interchange | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`interchange_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial metrics derived from the billing fact table"
  source: "`payments_fintech_ecm`.`interchange`.`billing`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date when settlement occurred"
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
  measures:
    - name: "total_gross_interchange_amount"
      expr: SUM(CAST(gross_interchange_amount AS DOUBLE))
      comment: "Sum of gross interchange amount for billed transactions"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Sum of net settlement amount for billed transactions"
    - name: "total_transaction_count"
      expr: SUM(CAST(total_transaction_count AS DOUBLE))
      comment: "Total number of transactions billed"
    - name: "average_gross_interchange_amount"
      expr: AVG(CAST(gross_interchange_amount AS DOUBLE))
      comment: "Average gross interchange amount per billed transaction"
    - name: "billing_record_count"
      expr: COUNT(1)
      comment: "Count of billing records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`interchange_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute performance and financial impact metrics"
  source: "`payments_fintech_ecm`.`interchange`.`interchange_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type/category of the dispute"
    - name: "filing_date"
      expr: filing_date
      comment: "Date the dispute was filed"
  measures:
    - name: "total_claimed_interchange_amount"
      expr: SUM(CAST(claimed_interchange_amount AS DOUBLE))
      comment: "Sum of interchange amounts claimed in disputes"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Sum of amounts actually disputed"
    - name: "dispute_record_count"
      expr: COUNT(1)
      comment: "Number of dispute records"
    - name: "average_claimed_interchange_amount"
      expr: AVG(CAST(claimed_interchange_amount AS DOUBLE))
      comment: "Average claimed interchange amount per dispute"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`interchange_issuer_interchange_income`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and fee metrics for issuers"
  source: "`payments_fintech_ecm`.`interchange`.`issuer_interchange_income`"
  dimensions:
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date of settlement for the income record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the income amounts"
    - name: "card_brand"
      expr: card_brand
      comment: "Card brand associated with the income"
  measures:
    - name: "total_gross_interchange_earned"
      expr: SUM(CAST(gross_interchange_earned AS DOUBLE))
      comment: "Total gross interchange earned by issuers"
    - name: "total_net_interchange_income"
      expr: SUM(CAST(net_interchange_income AS DOUBLE))
      comment: "Total net interchange income after fees"
    - name: "total_processing_fee_amount"
      expr: SUM(CAST(processing_fee_amount AS DOUBLE))
      comment: "Sum of processing fees associated with interchange income"
    - name: "issuer_income_record_count"
      expr: COUNT(1)
      comment: "Count of issuer interchange income records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`interchange_cost_of_acceptance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of acceptance and related revenue metrics"
  source: "`payments_fintech_ecm`.`interchange`.`cost_of_acceptance`"
  dimensions:
    - name: "calculation_date"
      expr: calculation_date
      comment: "Date the cost of acceptance was calculated"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost and revenue amounts"
    - name: "durbin_regulated_flag"
      expr: durbin_regulated_flag
      comment: "Indicates if the cost is subject to Durbin regulation"
  measures:
    - name: "total_interchange_cost"
      expr: SUM(CAST(total_interchange_cost AS DOUBLE))
      comment: "Total interchange cost incurred"
    - name: "total_msf_revenue"
      expr: SUM(CAST(total_msf_revenue AS DOUBLE))
      comment: "Total MSF revenue associated with acceptance cost"
    - name: "total_scheme_fees"
      expr: SUM(CAST(total_scheme_fees AS DOUBLE))
      comment: "Total scheme fees incurred"
    - name: "average_mdr_percentage"
      expr: AVG(CAST(mdr_percentage AS DOUBLE))
      comment: "Average MDR percentage across records"
    - name: "cost_of_acceptance_record_count"
      expr: COUNT(1)
      comment: "Number of cost of acceptance records"
$$;