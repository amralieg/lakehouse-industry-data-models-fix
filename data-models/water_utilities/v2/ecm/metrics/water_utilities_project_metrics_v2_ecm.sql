-- Metric views for domain: project | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-19 23:41:31

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_asset_handover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset handover financial summary"
  source: "`vibe_water_utilities_v1`.`project`.`asset_handover`"
  dimensions:
    - name: "handover_status"
      expr: handover_status
      comment: "Current status of the handover"
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Classification code of the asset"
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location of the asset"
    - name: "handover_month"
      expr: DATE_TRUNC('month', handover_date)
      comment: "Month the handover occurred"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of asset handover records"
    - name: "total_installed_cost_amount"
      expr: SUM(CAST(installed_cost_amount AS DOUBLE))
      comment: "Total installed cost amount for handed over assets"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order financial impact and status"
  source: "`vibe_water_utilities_v1`.`project`.`change_order`"
  dimensions:
    - name: "change_order_status"
      expr: change_order_status
      comment: "Current approval/status of the change order"
    - name: "change_order_type"
      expr: change_order_type
      comment: "Type of change order (e.g., scope addition, deletion)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the change order"
    - name: "approval_year"
      expr: DATE_TRUNC('year', approval_date)
      comment: "Year the change order was approved"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of change orders"
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Aggregate cost impact of all change orders"
    - name: "total_cumulative_change_order_value"
      expr: SUM(CAST(cumulative_change_order_value AS DOUBLE))
      comment: "Cumulative monetary value of change orders"
    - name: "average_cost_impact_amount"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_commissioning_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and performance verification during commissioning"
  source: "`vibe_water_utilities_v1`.`project`.`commissioning_activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the commissioning activity"
    - name: "activity_type"
      expr: activity_type
      comment: "Type/category of the activity"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the activity"
    - name: "regulatory_approval_year"
      expr: DATE_TRUNC('year', regulatory_approval_date)
      comment: "Year of regulatory approval"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of commissioning activities recorded"
    - name: "total_flow_test_result_gpm"
      expr: SUM(CAST(flow_test_result_gpm AS DOUBLE))
      comment: "Aggregate flow test results (gallons per minute)"
    - name: "total_pressure_test_result_psi"
      expr: SUM(CAST(pressure_test_result_psi AS DOUBLE))
      comment: "Aggregate pressure test results (psi)"
    - name: "average_disinfection_contact_time_minutes"
      expr: AVG(CAST(disinfection_contact_time_minutes AS DOUBLE))
      comment: "Average disinfection contact time in minutes"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Issue tracking with cost implications"
  source: "`vibe_water_utilities_v1`.`project`.`issue`"
  dimensions:
    - name: "issue_status"
      expr: issue_status
      comment: "Current status of the issue"
    - name: "issue_type"
      expr: issue_type
      comment: "Category of the issue (e.g., safety, environmental)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the issue"
    - name: "identified_year"
      expr: DATE_TRUNC('year', date_identified)
      comment: "Year the issue was identified"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of issues logged"
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Aggregate cost impact of all issues"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Milestone schedule performance and financial impact"
  source: "`vibe_water_utilities_v1`.`project`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Classification of milestone (e.g., regulatory, construction)"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating if milestone is on the critical path"
    - name: "actual_date_month"
      expr: DATE_TRUNC('month', actual_date)
      comment: "Month the milestone was actually completed"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of milestones recorded"
    - name: "total_budget_impact_amount"
      expr: SUM(CAST(budget_impact_amount AS DOUBLE))
      comment: "Sum of budget impact amounts associated with milestones"
    - name: "average_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial budgeting and execution at the project level"
  source: "`vibe_water_utilities_v1`.`project`.`project_budget`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget line (e.g., equipment, labor)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year associated with the budget"
    - name: "phase"
      expr: phase
      comment: "Project phase (e.g., planning, construction)"
    - name: "owner"
      expr: owner
      comment: "Owner or sponsor of the budget"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of budget records"
    - name: "total_capex_amount"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Total capital expenditures budgeted"
    - name: "total_opex_amount"
      expr: SUM(CAST(opex_amount AS DOUBLE))
      comment: "Total operating expenditures budgeted"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Actual expenditures recorded to date"
    - name: "total_encumbered_amount"
      expr: SUM(CAST(encumbered_amount AS DOUBLE))
      comment: "Total amount encumbered (committed) in the budget"
$$;