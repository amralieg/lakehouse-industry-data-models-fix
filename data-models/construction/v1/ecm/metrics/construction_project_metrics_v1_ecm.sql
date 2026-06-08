-- Metric views for domain: project | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_construction_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level view of construction project financial and schedule health"
  source: "`construction_ecm`.`project`.`construction_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project (e.g., Active, Completed, On Hold)"
    - name: "region"
      expr: region
      comment: "Geographic region of the project"
    - name: "project_type"
      expr: project_type
      comment: "Type of project (e.g., Infrastructure, Commercial, Residential)"
  measures:
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of construction projects"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Sum of contract values for all projects"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Sum of approved budgets across projects"
    - name: "average_physical_progress_pct"
      expr: AVG(CAST(physical_progress_pct AS DOUBLE))
      comment: "Average physical progress percentage across projects"
    - name: "average_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index (CPI) across projects"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_cost_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost accounting view for tracking spend and variance"
  source: "`construction_ecm`.`project`.`cost_account`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Classification of cost (e.g., Labor, Materials, Subcontract)"
    - name: "cost_account_code"
      expr: cost_account_code
      comment: "Cost account identifier"
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "Associated WBS element"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_period_date)
      comment: "Month of the reporting period"
  measures:
    - name: "cost_account_count"
      expr: COUNT(1)
      comment: "Number of cost accounts"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost_amount AS DOUBLE))
      comment: "Total committed cost"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Aggregate cost variance across accounts"
    - name: "average_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete for cost accounts"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_evm_period_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EVM performance metrics per reporting period"
  source: "`construction_ecm`.`project`.`evm_period_record`"
  dimensions:
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element linked to the EVM record"
    - name: "reporting_period_id"
      expr: reporting_period_id
      comment: "Identifier of the reporting period"
    - name: "data_month"
      expr: DATE_TRUNC('month', data_date)
      comment: "Month of the data point"
  measures:
    - name: "evm_record_count"
      expr: COUNT(1)
      comment: "Number of Earned Value Management records"
    - name: "total_acwp"
      expr: SUM(CAST(acwp AS DOUBLE))
      comment: "Aggregate Actual Cost of Work Performed"
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Aggregate Budgeted Cost of Work Performed"
    - name: "total_bcws"
      expr: SUM(CAST(bcws AS DOUBLE))
      comment: "Aggregate Budgeted Cost of Work Scheduled"
    - name: "average_cpi"
      expr: AVG(CAST(cpi AS DOUBLE))
      comment: "Average Cost Performance Index across periods"
    - name: "average_spi"
      expr: AVG(CAST(spi AS DOUBLE))
      comment: "Average Schedule Performance Index across periods"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone tracking for schedule and payment triggers"
  source: "`construction_ecm`.`project`.`project_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Classification of milestone (e.g., Design, Construction, Handover)"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating if milestone is on the critical path"
    - name: "planned_month"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned month for the milestone"
  measures:
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of project milestones"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Sum of payment amounts tied to milestones"
    - name: "delayed_milestone_count"
      expr: SUM(CASE WHEN CAST(schedule_variance_days AS DOUBLE) > 0 THEN 1 ELSE 0 END)
      comment: "Count of milestones that are behind schedule"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`project_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk register view for monitoring exposure and mitigation needs"
  source: "`construction_ecm`.`project`.`risk_register`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Business category of the risk (e.g., Financial, Safety, Schedule)"
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (Open, Closed, Mitigated)"
    - name: "risk_type"
      expr: risk_type
      comment: "Type of risk (e.g., Operational, Contractual)"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the risk was identified"
  measures:
    - name: "risk_count"
      expr: COUNT(1)
      comment: "Total number of registered risks"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all risks"
    - name: "total_contingency_cost"
      expr: SUM(CAST(contingency_cost_amount AS DOUBLE))
      comment: "Sum of contingency cost amounts allocated to risks"
    - name: "high_risk_count"
      expr: SUM(CASE WHEN risk_score >= 80 THEN 1 ELSE 0 END)
      comment: "Count of high‑severity risks (score >= 80)"
$$;