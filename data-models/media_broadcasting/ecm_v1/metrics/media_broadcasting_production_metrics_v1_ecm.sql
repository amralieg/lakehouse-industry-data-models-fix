-- Metric views for domain: production | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial view for production budgets"
  source: "`media_broadcasting_ecm`.`production`.`budget`"
  dimensions:
    - name: "production_project_id"
      expr: production_project_id
      comment: "Identifier of the production project"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., Q1, Q2)"
    - name: "production_phase"
      expr: production_phase
      comment: "Phase of production (pre, principal, post)"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the budget"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget amounts"
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget amount across selected scope"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred"
    - name: "total_budget_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between approved and actual cost"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial transactions related to production costs"
  source: "`media_broadcasting_ecm`.`production`.`cost_transaction`"
  dimensions:
    - name: "production_project_id"
      expr: production_project_id
      comment: "Production project linked to the transaction"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center charged"
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type/category of transaction"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Sum of all transaction amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts across transactions"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts after tax"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_broadcast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational view of broadcast occurrences"
  source: "`media_broadcasting_ecm`.`production`.`broadcast`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Distribution platform (e.g., linear, streaming)"
    - name: "broadcast_status"
      expr: broadcast_status
      comment: "Current status of the broadcast"
    - name: "broadcast_date"
      expr: broadcast_date
      comment: "Date of the broadcast"
  measures:
    - name: "broadcast_count"
      expr: COUNT(1)
      comment: "Number of broadcast events"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_daily_production_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily operational efficiency metrics for production"
  source: "`media_broadcasting_ecm`.`production`.`daily_production_report`"
  dimensions:
    - name: "production_project_id"
      expr: production_project_id
      comment: "Production project identifier"
    - name: "report_date"
      expr: report_date
      comment: "Date of the daily report"
    - name: "production_unit"
      expr: production_unit
      comment: "Production unit or department"
    - name: "location_id"
      expr: location_id
      comment: "Location where reporting took place"
  measures:
    - name: "total_crew_hours"
      expr: SUM(CAST(total_crew_hours AS DOUBLE))
      comment: "Aggregate crew hours logged per day"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Aggregate overtime hours logged per day"
    - name: "total_digital_media_consumed_tb"
      expr: SUM(CAST(digital_media_consumed_tb AS DOUBLE))
      comment: "Total digital media consumed (TB)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_episode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance per production episode"
  source: "`media_broadcasting_ecm`.`production`.`production_episode`"
  dimensions:
    - name: "title_id"
      expr: title_id
      comment: "Title identifier for the episode"
    - name: "production_status"
      expr: production_status
      comment: "Current production status of the episode"
    - name: "first_air_date"
      expr: first_air_date
      comment: "First air date of the episode"
    - name: "content_type"
      expr: content_type
      comment: "Type of content (e.g., series, special)"
  measures:
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost for episodes"
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved budget for episodes"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`production_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level financial health of production projects"
  source: "`media_broadcasting_ecm`.`production`.`project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project (e.g., feature, series)"
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the project"
    - name: "greenlight_status"
      expr: greenlight_status
      comment: "Current greenlight status"
    - name: "target_delivery_date"
      expr: target_delivery_date
      comment: "Planned delivery date for the project"
  measures:
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend_usd AS DOUBLE))
      comment: "Total actual spend for the project"
    - name: "total_approved_budget_usd"
      expr: SUM(CAST(approved_budget_usd AS DOUBLE))
      comment: "Total approved budget for the project"
$$;