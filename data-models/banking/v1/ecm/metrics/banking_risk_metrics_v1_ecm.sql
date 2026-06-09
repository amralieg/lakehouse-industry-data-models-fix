-- Metric views for domain: risk | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_credit_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core credit exposure KPIs for monitoring portfolio size, credit quality and risk amounts"
  source: "`banking_ecm`.`risk`.`credit_exposure`"
  dimensions:
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of the exposure measurement"
    - name: "country_id"
      expr: country_id
      comment: "Country identifier of the exposure"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier of the exposure"
    - name: "counterparty_type"
      expr: counterparty_type
      comment: "Classification of the counterparty"
    - name: "product_type"
      expr: product_type
      comment: "Product type of the exposure"
  measures:
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure AS DOUBLE))
      comment: "Total current credit exposure across all records"
    - name: "average_pd"
      expr: AVG(CAST(pd AS DOUBLE))
      comment: "Average probability of default for the credit portfolio"
    - name: "exposure_record_count"
      expr: COUNT(1)
      comment: "Number of credit exposure records"
    - name: "total_ead"
      expr: SUM(CAST(ead AS DOUBLE))
      comment: "Total exposure at default amount"
    - name: "total_lgd"
      expr: SUM(CAST(lgd AS DOUBLE))
      comment: "Total loss given default amount"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key risk limit metrics to track capacity, usage and breaches"
  source: "`banking_ecm`.`risk`.`risk_limit`"
  dimensions:
    - name: "limit_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the limit became effective"
    - name: "limit_type"
      expr: limit_type
      comment: "Type/category of the risk limit"
    - name: "regulatory_capital_flag"
      expr: regulatory_capital_flag
      comment: "Indicates if the limit is regulatory capital"
    - name: "currency"
      expr: currency
      comment: "Currency of the limit amount"
    - name: "lob_code"
      expr: lob_code
      comment: "Line‑of‑business code associated with the limit"
  measures:
    - name: "total_limit_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Aggregate limit amount across all risk limits"
    - name: "total_utilization_amount"
      expr: SUM(CAST(current_utilization_amount AS DOUBLE))
      comment: "Total amount currently utilized against limits"
    - name: "average_utilization_pct"
      expr: AVG(CAST(utilization_pct AS DOUBLE))
      comment: "Average utilization percentage across limits"
    - name: "breached_limit_count"
      expr: COUNT(CASE WHEN utilization_pct > 100 THEN 1 END)
      comment: "Count of limits where utilization exceeds 100%"
    - name: "risk_limit_record_count"
      expr: COUNT(1)
      comment: "Number of risk limit records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_liquidity_metric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity health indicators for regulatory compliance and funding stability"
  source: "`banking_ecm`.`risk`.`liquidity_metric`"
  dimensions:
    - name: "metric_month"
      expr: DATE_TRUNC('month', metric_date)
      comment: "Month of the liquidity metric"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity identifier"
    - name: "metric_type"
      expr: metric_type
      comment: "Type of liquidity metric (e.g., LCR, NSFR)"
  measures:
    - name: "average_lcr_ratio"
      expr: AVG(CAST(lcr_ratio AS DOUBLE))
      comment: "Average Liquidity Coverage Ratio"
    - name: "average_nsfr_ratio"
      expr: AVG(CAST(nsfr_ratio AS DOUBLE))
      comment: "Average Net Stable Funding Ratio"
    - name: "total_available_stable_funding"
      expr: SUM(CAST(available_stable_funding_amount AS DOUBLE))
      comment: "Total amount of available stable funding"
    - name: "total_required_stable_funding"
      expr: SUM(CAST(required_stable_funding_amount AS DOUBLE))
      comment: "Total amount of required stable funding"
    - name: "lcr_breach_count"
      expr: COUNT(CASE WHEN lcr_ratio < lcr_regulatory_minimum THEN 1 END)
      comment: "Count of LCR breaches below regulatory minimum"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_kri_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key Risk Indicator (KRI) performance metrics for monitoring risk appetite and control effectiveness"
  source: "`banking_ecm`.`risk`.`kri_measurement`"
  dimensions:
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of the KRI measurement"
    - name: "legal_entity"
      expr: legal_entity
      comment: "Legal entity associated with the KRI"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the KRI"
    - name: "kri_name"
      expr: kri_name
      comment: "Name of the Key Risk Indicator"
  measures:
    - name: "average_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value reported for the KRI"
    - name: "kri_breach_count"
      expr: COUNT(CASE WHEN breach_status = 'Breached' THEN 1 END)
      comment: "Number of KRI records that are in breach"
    - name: "kri_measurement_count"
      expr: COUNT(1)
      comment: "Total number of KRI measurements recorded"
    - name: "average_green_threshold"
      expr: AVG(CAST(green_threshold AS DOUBLE))
      comment: "Average green threshold across KRIs"
    - name: "average_red_threshold"
      expr: AVG(CAST(red_threshold AS DOUBLE))
      comment: "Average red threshold across KRIs"
$$;