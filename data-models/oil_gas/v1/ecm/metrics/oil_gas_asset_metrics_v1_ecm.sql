-- Metric views for domain: asset | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_overview`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level view of asset financials and risk"
  source: "`oil_gas_ecm`.`asset`.`asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Classification of the asset (e.g., facility, equipment)"
    - name: "asset_status"
      expr: asset_status
      comment: "Operational status of the asset"
    - name: "asset_category_code"
      expr: asset_category_code
      comment: "Business category code for the asset"
    - name: "is_critical_asset"
      expr: is_critical_asset
      comment: "Boolean flag indicating criticality"
    - name: "created_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the asset record was created"
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of asset records"
    - name: "total_capital_expenditure"
      expr: SUM(CAST(capital_expenditure AS DOUBLE))
      comment: "Sum of capital expenditure for assets"
    - name: "avg_capital_expenditure"
      expr: AVG(CAST(capital_expenditure AS DOUBLE))
      comment: "Average capital expenditure per asset"
    - name: "total_current_value"
      expr: SUM(CAST(current_value AS DOUBLE))
      comment: "Aggregate current book value of assets"
    - name: "avg_current_value"
      expr: AVG(CAST(current_value AS DOUBLE))
      comment: "Average current book value per asset"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across assets"
    - name: "count_critical_assets"
      expr: SUM(CASE WHEN is_critical_asset THEN 1 ELSE 0 END)
      comment: "Number of assets flagged as critical"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_abandonment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and status metrics for abandonment planning"
  source: "`oil_gas_ecm`.`asset`.`abandonment_plan`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset subject to abandonment"
    - name: "abandonment_method"
      expr: abandonment_method
      comment: "Method used for abandonment"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the abandonment plan"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval state"
    - name: "actual_abandonment_year"
      expr: DATE_TRUNC('year', actual_abandonment_date)
      comment: "Year of actual abandonment"
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Total abandonment plans"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Sum of estimated abandonment cost in USD"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Sum of actual abandonment cost in USD"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average estimated abandonment cost"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual abandonment cost"
    - name: "total_aro_liability"
      expr: SUM(CAST(aro_liability_usd AS DOUBLE))
      comment: "Total ARO liability amount"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_equipment_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance and cost metrics for equipment assets"
  source: "`oil_gas_ecm`.`asset`.`equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Category of equipment (e.g., pump, valve)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status"
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Safety‑critical flag"
    - name: "is_environmental_critical"
      expr: is_environmental_critical
      comment: "Environmental‑critical flag"
    - name: "created_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year equipment record was created"
  measures:
    - name: "total_equipment"
      expr: COUNT(1)
      comment: "Total equipment records"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Sum of acquisition cost for equipment"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair"
    - name: "count_safety_critical"
      expr: SUM(CASE WHEN is_safety_critical THEN 1 ELSE 0 END)
      comment: "Number of equipment flagged as safety‑critical"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_failure_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational impact metrics from failure reports"
  source: "`oil_gas_ecm`.`asset`.`failure_report`"
  dimensions:
    - name: "failure_status"
      expr: failure_status
      comment: "Current status of the failure report"
    - name: "failure_type"
      expr: failure_type
      comment: "High‑level type of failure"
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause description"
    - name: "failure_date_year"
      expr: DATE_TRUNC('year', failure_date)
      comment: "Year the failure occurred"
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Total number of failure reports"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Aggregate downtime hours caused by failures"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime per failure"
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Sum of repair costs for failures"
    - name: "avg_repair_cost"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per failure"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_pipeline_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk and cost overview for pipeline segments"
  source: "`oil_gas_ecm`.`asset`.`pipeline_segment`"
  dimensions:
    - name: "country_code"
      expr: country_code
      comment: "Country where the segment is located"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the segment"
    - name: "risk_score_bucket"
      expr: CASE WHEN risk_score >= 80 THEN 'High' WHEN risk_score >= 50 THEN 'Medium' ELSE 'Low' END
      comment: "Risk score categorisation"
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total pipeline segments"
    - name: "total_length_miles"
      expr: SUM(CAST(segment_length_miles AS DOUBLE))
      comment: "Aggregate length of pipeline segments in miles"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across segments"
    - name: "max_risk_score"
      expr: MAX(risk_score)
      comment: "Maximum risk score observed"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Sum of acquisition cost for pipeline segments"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_well_asset_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and production potential metrics for well assets"
  source: "`oil_gas_ecm`.`asset`.`well_asset`"
  dimensions:
    - name: "well_type"
      expr: well_type
      comment: "Classification of well (e.g., development, exploration)"
    - name: "well_status"
      expr: well_status
      comment: "Current operational status of the well"
    - name: "spud_year"
      expr: DATE_TRUNC('year', spud_date)
      comment: "Year the well was spudded"
  measures:
    - name: "total_wells"
      expr: COUNT(1)
      comment: "Total well assets"
    - name: "total_capex"
      expr: SUM(CAST(total_capex_usd AS DOUBLE))
      comment: "Sum of total capital expenditure for wells"
    - name: "avg_capex"
      expr: AVG(CAST(total_capex_usd AS DOUBLE))
      comment: "Average capital expenditure per well"
    - name: "total_estimated_ultimate_recovery"
      expr: SUM(CAST(estimated_ultimate_recovery_boe AS DOUBLE))
      comment: "Aggregate estimated ultimate recovery (BOE)"
    - name: "avg_estimated_ultimate_recovery"
      expr: AVG(CAST(estimated_ultimate_recovery_boe AS DOUBLE))
      comment: "Average estimated ultimate recovery per well"
    - name: "count_active_wells"
      expr: SUM(CASE WHEN well_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of wells currently active"
$$;