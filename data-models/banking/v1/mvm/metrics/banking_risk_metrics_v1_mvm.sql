-- Metric views for domain: risk | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core risk‑limit KPIs used by senior risk officers to monitor limit usage and breaches"
  source: "`banking_ecm`.`risk`.`risk_limit`"
  dimensions:
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Jurisdiction of the legal entity"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Identifier of the legal entity subject to the limit"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of limit effectiveness"
  measures:
    - name: "total_current_utilization_amount"
      expr: SUM(CAST(current_utilization_amount AS DOUBLE))
      comment: "Aggregate of current utilization against limits"
    - name: "limit_count"
      expr: COUNT(1)
      comment: "Number of risk limit records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_credit_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit exposure KPIs that inform capital allocation and credit risk monitoring"
  source: "`banking_ecm`.`risk`.`credit_exposure`"
  dimensions:
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity bearing the exposure"
    - name: "counterparty_type"
      expr: counterparty_type
      comment: "Classification of the counterparty (e.g., Corporate, Retail)"
    - name: "exposure_month"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of the exposure measurement"
  measures:
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure AS DOUBLE))
      comment: "Total current credit exposure across the portfolio"
    - name: "total_ead"
      expr: SUM(CAST(ead AS DOUBLE))
      comment: "Sum of Exposure‑At‑Default values"
    - name: "total_lgd"
      expr: SUM(CAST(lgd AS DOUBLE))
      comment: "Sum of Loss‑Given‑Default amounts"
    - name: "average_pd"
      expr: AVG(CAST(pd AS DOUBLE))
      comment: "Average Probability of Default across exposures"
    - name: "pd_weighted_ead"
      expr: SUM(pd * ead)
      comment: "PD‑weighted EAD, useful for risk‑adjusted exposure calculations"
    - name: "exposure_record_count"
      expr: COUNT(1)
      comment: "Number of credit exposure records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_liquidity_metric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity health metrics used by treasury and risk leadership to ensure regulatory compliance"
  source: "`banking_ecm`.`risk`.`liquidity_metric`"
  dimensions:
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Jurisdiction for the liquidity metric"
    - name: "metric_type"
      expr: metric_type
      comment: "Type of liquidity metric (e.g., LCR, NSFR)"
    - name: "metric_month"
      expr: DATE_TRUNC('month', metric_date)
      comment: "Month of the metric observation"
  measures:
    - name: "average_lcr_ratio"
      expr: AVG(CAST(lcr_ratio AS DOUBLE))
      comment: "Average Liquidity Coverage Ratio across the selected set"
    - name: "average_nsfr_ratio"
      expr: AVG(CAST(nsfr_ratio AS DOUBLE))
      comment: "Average Net Stable Funding Ratio"
    - name: "total_available_stable_funding"
      expr: SUM(CAST(available_stable_funding_amount AS DOUBLE))
      comment: "Total amount of stable funding available"
    - name: "total_required_stable_funding"
      expr: SUM(CAST(required_stable_funding_amount AS DOUBLE))
      comment: "Total amount of stable funding required"
    - name: "liquidity_breach_count"
      expr: SUM(CASE WHEN is_breach THEN 1 ELSE 0 END)
      comment: "Count of liquidity metric records flagged as a breach"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_market_risk_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market risk position KPIs for senior market‑risk oversight and capital planning"
  source: "`banking_ecm`.`risk`.`market_risk_position`"
  dimensions:
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity owning the position"
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of financial instrument"
    - name: "position_month"
      expr: DATE_TRUNC('month', position_date)
      comment: "Month of the position snapshot"
  measures:
    - name: "total_mtm_value"
      expr: SUM(CAST(mtm_value AS DOUBLE))
      comment: "Aggregate mark‑to‑market value of market risk positions"
    - name: "total_var_1d_99"
      expr: SUM(CAST(var_1d_99 AS DOUBLE))
      comment: "Sum of 1‑day 99% VaR across positions"
    - name: "total_expected_shortfall"
      expr: SUM(CAST(expected_shortfall AS DOUBLE))
      comment: "Sum of Expected Shortfall (ES) across positions"
    - name: "position_record_count"
      expr: COUNT(1)
      comment: "Number of market risk position records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`risk_kri_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KRI measurement KPIs that surface risk‑control performance to executive risk committees"
  source: "`banking_ecm`.`risk`.`kri_measurement`"
  dimensions:
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity associated with the KRI"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the KRI"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_date)
      comment: "Month of the KRI measurement"
  measures:
    - name: "kri_breach_count"
      expr: SUM(CASE WHEN breach_status = 'Breached' THEN 1 ELSE 0 END)
      comment: "Count of Key Risk Indicator breaches"
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of actual KRI values across measurements"
    - name: "kri_measurement_record_count"
      expr: COUNT(1)
      comment: "Number of KRI measurement records"
$$;