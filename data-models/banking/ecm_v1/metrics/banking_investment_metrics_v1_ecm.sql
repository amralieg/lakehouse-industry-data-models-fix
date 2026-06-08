-- Metric views for domain: investment | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core deal performance metrics for investment banking"
  source: "`banking_ecm`.`investment`.`deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the deal (e.g., pending, closed)"
  measures:
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Number of deals recorded"
    - name: "total_deal_size"
      expr: SUM(CAST(size AS DOUBLE))
      comment: "Aggregate deal size across all deals"
    - name: "average_deal_size"
      expr: AVG(CAST(size AS DOUBLE))
      comment: "Average deal size per deal"
    - name: "total_expected_fee"
      expr: SUM(CAST(expected_fee_amount AS DOUBLE))
      comment: "Sum of expected fees for all deals"
    - name: "average_fee_rate_bps"
      expr: AVG(CAST(fee_rate_bps AS DOUBLE))
      comment: "Average fee rate in basis points"
    - name: "weighted_expected_fee"
      expr: SUM(CAST(expected_fee_amount * pipeline_probability_pct / 100.0 AS DOUBLE))
      comment: "Expected fee weighted by pipeline probability"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation outcomes used for deal pricing and investment decisions"
  source: "`banking_ecm`.`investment`.`investment_valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation (e.g., final, draft)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction being valued"
  measures:
    - name: "valuation_count"
      expr: COUNT(1)
      comment: "Number of valuation records"
    - name: "average_enterprise_value_high"
      expr: AVG(CAST(enterprise_value_high AS DOUBLE))
      comment: "Average high end of enterprise value range"
    - name: "average_enterprise_value_low"
      expr: AVG(CAST(enterprise_value_low AS DOUBLE))
      comment: "Average low end of enterprise value range"
    - name: "average_net_debt"
      expr: AVG(CAST(net_debt AS DOUBLE))
      comment: "Average net debt across valuations"
    - name: "average_wacc"
      expr: AVG(CAST(wacc AS DOUBLE))
      comment: "Average weighted average cost of capital"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_mandate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mandate-level financial commitments and expectations"
  source: "`banking_ecm`.`investment`.`investment_mandate`"
  dimensions:
    - name: "investment_mandate_status"
      expr: investment_mandate_status
      comment: "Current status of the mandate"
    - name: "mandate_type"
      expr: mandate_type
      comment: "Classification of the mandate (e.g., advisory, financing)"
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating whether the mandate is exclusive"
  measures:
    - name: "mandate_count"
      expr: COUNT(1)
      comment: "Number of investment mandates"
    - name: "total_estimated_deal_size"
      expr: SUM(CAST(estimated_deal_size AS DOUBLE))
      comment: "Sum of estimated deal sizes across mandates"
    - name: "average_estimated_deal_size"
      expr: AVG(CAST(estimated_deal_size AS DOUBLE))
      comment: "Average estimated deal size per mandate"
    - name: "average_minimum_fee"
      expr: AVG(CAST(minimum_fee_amount AS DOUBLE))
      comment: "Average minimum fee amount stipulated in mandates"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_syndication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key syndication financing metrics"
  source: "`banking_ecm`.`investment`.`investment_syndication`"
  dimensions:
    - name: "syndication_status"
      expr: syndication_status
      comment: "Current status of the syndication (e.g., active, closed)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the facility"
  measures:
    - name: "syndication_count"
      expr: COUNT(1)
      comment: "Number of syndication transactions"
    - name: "total_facility_amount"
      expr: SUM(CAST(total_facility_amount AS DOUBLE))
      comment: "Aggregate facility amount across syndications"
    - name: "average_oversubscription_amount"
      expr: AVG(CAST(oversubscription_amount AS DOUBLE))
      comment: "Average oversubscription amount per syndication"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_fee_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee arrangement financial terms and performance"
  source: "`banking_ecm`.`investment`.`fee_arrangement`"
  dimensions:
    - name: "fee_type"
      expr: fee_type
      comment: "Classification of the fee (e.g., advisory, underwriting)"
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the fee arrangement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fee"
  measures:
    - name: "fee_arrangement_count"
      expr: COUNT(1)
      comment: "Number of fee arrangement records"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount across arrangements"
    - name: "average_fee_rate_bps"
      expr: AVG(CAST(fee_rate_bps AS DOUBLE))
      comment: "Average fee rate in basis points"
    - name: "average_bank_fee_share_pct"
      expr: AVG(CAST(bank_fee_share_pct AS DOUBLE))
      comment: "Average bank fee share percentage"
$$;