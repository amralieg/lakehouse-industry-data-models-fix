-- Metric views for domain: treasury | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_capital_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key capital planning KPIs used by treasury leadership to monitor issuance/redemption targets and CET1 coverage"
  source: "`banking_ecm`.`treasury`.`capital_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capital plan (e.g., Draft, Approved, Executed)"
    - name: "planning_month"
      expr: DATE_TRUNC('month', planning_horizon_start_date)
      comment: "Month of the planning horizon start date"
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Regulatory jurisdiction identifier"
  measures:
    - name: "total_planned_issuance_amount"
      expr: SUM(CAST(planned_capital_issuance_amount AS DOUBLE))
      comment: "Total amount of capital planned to be issued in the period"
    - name: "total_planned_redemption_amount"
      expr: SUM(CAST(planned_capital_redemption_amount AS DOUBLE))
      comment: "Total amount of capital planned to be redeemed in the period"
    - name: "average_target_cet1_ratio"
      expr: AVG(CAST(alco_approved_target_cet1_ratio AS DOUBLE))
      comment: "Average target CET1 ratio across all capital plans"
    - name: "plan_record_count"
      expr: COUNT(1)
      comment: "Number of capital plan records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_capital_ratio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory capital adequacy metrics for monitoring CET1 and RWA levels"
  source: "`banking_ecm`.`treasury`.`capital_ratio`"
  dimensions:
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month of the reporting date"
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Regulatory jurisdiction identifier"
    - name: "scenario_type"
      expr: scenario_type
      comment: "Stress scenario or baseline reporting type"
  measures:
    - name: "total_capital_amount"
      expr: SUM(CAST(total_capital_amount AS DOUBLE))
      comment: "Sum of total capital amount reported"
    - name: "total_rwa_amount"
      expr: SUM(CAST(total_rwa_amount AS DOUBLE))
      comment: "Sum of total risk‑weighted assets"
    - name: "average_cet1_ratio"
      expr: AVG(CAST(cet1_ratio AS DOUBLE))
      comment: "Average CET1 ratio across reporting entities"
    - name: "capital_ratio_record_count"
      expr: COUNT(1)
      comment: "Number of capital ratio records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash‑flow forecasting KPIs to assess liquidity expectations by business line and category"
  source: "`banking_ecm`.`treasury`.`cash_flow_forecast`"
  dimensions:
    - name: "forecast_month"
      expr: DATE_TRUNC('month', forecast_date)
      comment: "Month of the cash‑flow forecast"
    - name: "business_line"
      expr: business_line
      comment: "Business line associated with the forecast"
    - name: "cash_flow_category"
      expr: cash_flow_category
      comment: "Category of cash flow (e.g., Operational, Investment)"
  measures:
    - name: "total_net_cash_flow_amount"
      expr: SUM(CAST(net_cash_flow_amount AS DOUBLE))
      comment: "Sum of net cash flow amounts across forecasts"
    - name: "total_behavioral_inflow_amount"
      expr: SUM(CAST(behavioral_inflow_amount AS DOUBLE))
      comment: "Sum of behavioral inflow amounts"
    - name: "total_contractual_inflow_amount"
      expr: SUM(CAST(contractual_inflow_amount AS DOUBLE))
      comment: "Sum of contractual inflow amounts"
    - name: "total_behavioral_outflow_amount"
      expr: SUM(CAST(behavioral_outflow_amount AS DOUBLE))
      comment: "Sum of behavioral outflow amounts"
    - name: "total_contractual_outflow_amount"
      expr: SUM(CAST(contractual_outflow_amount AS DOUBLE))
      comment: "Sum of contractual outflow amounts"
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of cash‑flow forecast records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_liquidity_ratio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidity coverage metrics used for regulatory and internal funding stability monitoring"
  source: "`banking_ecm`.`treasury`.`liquidity_ratio`"
  dimensions:
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_date)
      comment: "Month of the reporting date"
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Regulatory jurisdiction identifier"
  measures:
    - name: "total_available_stable_funding_amount"
      expr: SUM(CAST(available_stable_funding_amount AS DOUBLE))
      comment: "Total amount of stable funding available"
    - name: "total_required_stable_funding_amount"
      expr: SUM(CAST(required_stable_funding_amount AS DOUBLE))
      comment: "Total amount of stable funding required"
    - name: "average_buffer_percentage"
      expr: AVG(CAST(buffer_percentage AS DOUBLE))
      comment: "Average liquidity buffer percentage"
    - name: "liquidity_ratio_record_count"
      expr: COUNT(1)
      comment: "Number of liquidity ratio records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`treasury_repo_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Repo market exposure KPIs for monitoring funding cost and maturity profile"
  source: "`banking_ecm`.`treasury`.`repo_position`"
  dimensions:
    - name: "maturity_month"
      expr: DATE_TRUNC('month', maturity_date)
      comment: "Month of repo maturity"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for the repo position"
  measures:
    - name: "total_principal_amount"
      expr: SUM(CAST(principal_amount AS DOUBLE))
      comment: "Total principal amount of repo positions"
    - name: "average_repo_rate"
      expr: AVG(CAST(repo_rate AS DOUBLE))
      comment: "Average repo rate across positions"
    - name: "repo_position_record_count"
      expr: COUNT(1)
      comment: "Number of repo position records"
$$;