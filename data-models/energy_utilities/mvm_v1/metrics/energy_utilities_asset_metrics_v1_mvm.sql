-- Metric views for domain: asset | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and schedule performance metrics for capital projects."
  source: "`energy_utilities_ecm`.`asset`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the capital project."
    - name: "project_type"
      expr: project_type
      comment: "Category or type of the capital project."
    - name: "service_territory"
      expr: service_territory
      comment: "Geographic service territory of the project."
    - name: "planning_period_id"
      expr: planning_period_id
      comment: "Planning period identifier linked to the project."
    - name: "actual_start_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month when the project actually started."
  measures:
    - name: "total_capex_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual capital expenditure spent to date."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_capex_budget AS DOUBLE))
      comment: "Total approved capital budget for projects."
    - name: "budget_variance"
      expr: SUM(CAST(variance_to_budget AS DOUBLE))
      comment: "Sum of variance between actual spend and approved budget."
    - name: "average_project_duration_days"
      expr: AVG(DATEDIFF(actual_completion_date, actual_start_date))
      comment: "Average duration of projects in days."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of capital projects."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_failure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational reliability and impact metrics for asset failure events."
  source: "`energy_utilities_ecm`.`asset`.`failure_event`"
  dimensions:
    - name: "failure_type"
      expr: failure_type
      comment: "Classification of the failure (e.g., mechanical, electrical)."
    - name: "failure_status"
      expr: failure_status
      comment: "Current status of the failure event."
    - name: "nerc_reportable_flag"
      expr: nerc_reportable_flag
      comment: "Indicates if the failure is reportable to NERC."
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Code describing the root cause of the failure."
    - name: "failure_month"
      expr: DATE_TRUNC('month', failure_timestamp)
      comment: "Month of the failure occurrence."
  measures:
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Total minutes of outage across all failure events."
    - name: "total_energy_not_supplied_mwh"
      expr: SUM(CAST(energy_not_supplied_mwh AS DOUBLE))
      comment: "Total megawatt‑hours of energy not supplied due to failures."
    - name: "failure_event_count"
      expr: COUNT(1)
      comment: "Number of recorded failure events."
    - name: "average_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration per failure event."
    - name: "distinct_failure_cause_count"
      expr: COUNT(DISTINCT failure_cause_code)
      comment: "Count of unique failure cause codes."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and execution metrics for asset work orders."
  source: "`energy_utilities_ecm`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the work order."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type/category of the work order."
    - name: "capex_flag"
      expr: capex_flag
      comment: "Indicates if the work order is capital expenditure."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Flag for regulatory reporting requirement."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month when the work order was scheduled to start."
  measures:
    - name: "total_work_order_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost incurred for work orders."
    - name: "total_equipment_cost"
      expr: SUM(CAST(equipment_cost AS DOUBLE))
      comment: "Sum of equipment costs across work orders."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Sum of labor costs across work orders."
    - name: "average_labor_hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order."
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Number of work orders recorded."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial valuation metrics for regulated assets."
  source: "`energy_utilities_ecm`.`asset`.`valuation`"
  dimensions:
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (e.g., regulatory, internal)."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Current status of the valuation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for valuation amounts."
    - name: "valuation_year"
      expr: DATE_TRUNC('year', valuation_date)
      comment: "Fiscal year of the valuation."
    - name: "rate_case_id"
      expr: rate_case_id
      comment: "Associated rate case identifier."
  measures:
    - name: "total_fair_market_value"
      expr: SUM(CAST(fair_market_value AS DOUBLE))
      comment: "Aggregate fair market value of assets."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Aggregate net book value of assets."
    - name: "average_depreciation_rate_percent"
      expr: AVG(CAST(depreciation_rate_percent AS DOUBLE))
      comment: "Average depreciation rate percent across valuations."
    - name: "valuation_count"
      expr: COUNT(1)
      comment: "Number of valuation records."
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_depreciation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation accounting metrics for asset capital projects."
  source: "`energy_utilities_ecm`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for depreciation (e.g., straight‑line)."
    - name: "depreciation_status"
      expr: depreciation_status
      comment: "Current status of the depreciation schedule."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the depreciation entry."
    - name: "depreciation_start_year"
      expr: DATE_TRUNC('year', depreciation_start_date)
      comment: "Year when depreciation started."
    - name: "capital_project_id"
      expr: capital_project_id
      comment: "Capital project linked to the depreciation schedule."
  measures:
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across schedules."
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Sum of original cost bases for depreciable assets."
    - name: "average_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years for assets."
    - name: "depreciation_schedule_count"
      expr: COUNT(1)
      comment: "Number of depreciation schedule records."
$$;