-- Metric views for domain: asset | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance health and upcoming obligations"
  source: "`energy_utilities_ecm`.`asset`.`asset_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., Compliant, Non‑Compliant)"
    - name: "applicability_year"
      expr: YEAR(applicability_determination_date)
      comment: "Year the compliance applicability was determined"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for the compliance item"
  measures:
    - name: "total_compliance_records"
      expr: COUNT(1)
      comment: "Total number of compliance records"
    - name: "compliance_due_soon_count"
      expr: SUM(CASE WHEN next_compliance_due_date <= DATEADD(day, 30, CURRENT_DATE) THEN 1 ELSE 0 END)
      comment: "Count of compliance items with due date within next 30 days"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key risk assessment performance indicators"
  source: "`energy_utilities_ecm`.`asset`.`asset_risk_assessment`"
  dimensions:
    - name: "risk_band"
      expr: risk_band
      comment: "Risk band classification (e.g., Low, Medium, High)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was performed"
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments performed"
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessments"
    - name: "avg_probability_of_failure_score"
      expr: AVG(CAST(probability_of_failure_score AS DOUBLE))
      comment: "Average probability of failure score"
    - name: "high_risk_assessment_count"
      expr: SUM(CASE WHEN overall_risk_score >= 80 THEN 1 ELSE 0 END)
      comment: "Count of assessments with high overall risk (score >= 80)"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and schedule health of capital projects"
  source: "`energy_utilities_ecm`.`asset`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project (e.g., Planned, In‑Progress, Completed)"
    - name: "project_type"
      expr: project_type
      comment: "Type of project (e.g., New Build, Upgrade, Replacement)"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Planned start year of the project"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of capital projects"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Cumulative actual spend to date across projects"
    - name: "avg_project_duration_days"
      expr: AVG(DATEDIFF(day, actual_start_date, actual_completion_date))
      comment: "Average project duration in days (actual start to actual completion)"
    - name: "projects_over_budget_count"
      expr: SUM(CASE WHEN actual_spend_to_date > approved_capex_budget THEN 1 ELSE 0 END)
      comment: "Count of projects where actual spend exceeds approved CAPEX budget"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_failure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure event impact and severity metrics"
  source: "`energy_utilities_ecm`.`asset`.`failure_event`"
  dimensions:
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Code describing the root cause of the failure"
    - name: "failure_status"
      expr: failure_status
      comment: "Current status of the failure event"
    - name: "failure_year"
      expr: YEAR(failure_timestamp)
      comment: "Year the failure occurred"
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Total number of failure events recorded"
    - name: "total_energy_not_supplied_mwh"
      expr: SUM(CAST(energy_not_supplied_mwh AS DOUBLE))
      comment: "Total energy not supplied due to failures (MWh)"
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration per failure (minutes)"
    - name: "high_severity_failure_count"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high‑severity failure events"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and cost of work orders"
  source: "`energy_utilities_ecm`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the work order"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_date)
      comment: "Month of the scheduled start date"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders created"
    - name: "total_work_order_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Aggregate cost of all work orders"
    - name: "avg_labor_hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per work order"
    - name: "overdue_work_order_count"
      expr: SUM(CASE WHEN scheduled_completion_date < CURRENT_DATE AND work_order_status != 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of work orders past scheduled completion and not closed"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`asset_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inventory valuation and criticality overview"
  source: "`energy_utilities_ecm`.`asset`.`registry`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Classification of asset (e.g., Transformer, Substation)"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class grouping"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset"
    - name: "service_territory"
      expr: service_territory
      comment: "Geographic service territory"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of assets in the registry"
    - name: "total_book_value"
      expr: SUM(CAST(book_value AS DOUBLE))
      comment: "Aggregate book value of all assets"
    - name: "avg_rated_capacity_mw"
      expr: AVG(CAST(rated_capacity AS DOUBLE))
      comment: "Average rated capacity (MW) across assets"
    - name: "critical_asset_count"
      expr: SUM(CASE WHEN criticality_score = 'High' THEN 1 ELSE 0 END)
      comment: "Count of assets with high criticality score"
$$;