-- Metric views for domain: asset | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level financial and risk KPIs for assets"
  source: "`oil_gas_ecm`.`asset`.`asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Classification of the asset (e.g., facility, equipment)"
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of assets"
    - name: "total_capital_expenditure"
      expr: SUM(CAST(capital_expenditure AS DOUBLE))
      comment: "Sum of capital expenditure for assets"
    - name: "total_operational_expenditure"
      expr: SUM(CAST(operational_expenditure AS DOUBLE))
      comment: "Sum of operational expenditure for assets"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across assets"
    - name: "depreciation_to_current_ratio"
      expr: AVG(CAST(capital_expenditure AS DOUBLE) / NULLIF(CAST(current_value AS DOUBLE), 0))
      comment: "Average ratio of capital expenditure to current value (depreciation effectiveness)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and reliability KPIs for equipment"
  source: "`oil_gas_ecm`.`asset`.`equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type/category of equipment"
    - name: "installation_month"
      expr: DATE_TRUNC('month', installation_date)
      comment: "Month of equipment installation"
  measures:
    - name: "equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment records"
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Sum of acquisition cost in USD for equipment"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average mean time between failures (hours) for equipment"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair (hours) for equipment"
    - name: "percent_safety_critical"
      expr: AVG(CAST(is_safety_critical AS INT)) * 100
      comment: "Percentage of equipment flagged as safety‑critical"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_failure_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational impact and cost of asset failures"
  source: "`oil_gas_ecm`.`asset`.`failure_report`"
  dimensions:
    - name: "failure_status"
      expr: failure_status
      comment: "Current status of the failure report"
    - name: "failure_type"
      expr: failure_type
      comment: "Categorization of failure cause"
    - name: "failure_month"
      expr: DATE_TRUNC('month', failure_date)
      comment: "Month when the failure occurred"
  measures:
    - name: "failure_count"
      expr: COUNT(1)
      comment: "Number of failure reports"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours caused by failures"
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Sum of repair costs for failures"
    - name: "avg_production_impact_boe"
      expr: AVG(CAST(production_impact_boe AS DOUBLE))
      comment: "Average production impact (BOE) per failure"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average mean time to repair (hours) for failures"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection activity and cost KPIs"
  source: "`oil_gas_ecm`.`asset`.`inspection_event`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of the inspection"
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of inspections performed"
    - name: "total_inspection_cost"
      expr: SUM(CAST(inspection_cost AS DOUBLE))
      comment: "Sum of inspection costs"
    - name: "avg_inspection_duration_hours"
      expr: AVG(CAST(inspection_duration_hours AS DOUBLE))
      comment: "Average duration of inspections (hours)"
    - name: "avg_corrosion_rate_mm_per_year"
      expr: AVG(CAST(corrosion_rate_mm_per_year AS DOUBLE))
      comment: "Average measured corrosion rate"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_pipeline_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and risk KPIs for pipeline segments"
  source: "`oil_gas_ecm`.`asset`.`pipeline_segment`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the segment"
    - name: "country_code"
      expr: country_code
      comment: "Country where the segment is located"
    - name: "segment_type"
      expr: segment_type
      comment: "Classification of the pipeline segment"
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the segment was installed"
  measures:
    - name: "segment_count"
      expr: COUNT(1)
      comment: "Number of pipeline segments"
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Sum of acquisition cost (USD) for pipeline segments"
    - name: "total_book_value_usd"
      expr: SUM(CAST(book_value_usd AS DOUBLE))
      comment: "Sum of book value (USD) for pipeline segments"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across pipeline segments"
    - name: "total_segment_length_miles"
      expr: SUM(CAST(segment_length_miles AS DOUBLE))
      comment: "Total length of pipeline segments (miles)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_well_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and production potential KPIs for wells"
  source: "`oil_gas_ecm`.`asset`.`well_asset`"
  dimensions:
    - name: "well_status"
      expr: well_status
      comment: "Current status of the well"
    - name: "well_type"
      expr: well_type
      comment: "Type of well (e.g., production, injection)"
    - name: "spud_year"
      expr: DATE_TRUNC('year', spud_date)
      comment: "Year the well was spudded"
  measures:
    - name: "well_count"
      expr: COUNT(1)
      comment: "Total number of wells"
    - name: "total_capex_usd"
      expr: SUM(CAST(total_capex_usd AS DOUBLE))
      comment: "Sum of total capital expenditure (USD) for wells"
    - name: "avg_estimated_ultimate_recovery_boe"
      expr: AVG(CAST(estimated_ultimate_recovery_boe AS DOUBLE))
      comment: "Average estimated ultimate recovery (BOE) per well"
    - name: "avg_net_revenue_interest_pct"
      expr: AVG(CAST(net_revenue_interest_pct AS DOUBLE))
      comment: "Average net revenue interest percentage across wells"
    - name: "avg_total_depth_tvd"
      expr: AVG(CAST(total_depth_tvd AS DOUBLE))
      comment: "Average true vertical depth (feet) of wells"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost, efficiency, and safety KPIs for work orders"
  source: "`oil_gas_ecm`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the work order"
    - name: "work_type"
      expr: work_type
      comment: "Category of work performed"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the work order was created"
  measures:
    - name: "work_order_count"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_actual_contractor_cost"
      expr: SUM(CAST(actual_contractor_cost AS DOUBLE))
      comment: "Sum of actual contractor costs for work orders"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_hours AS DOUBLE))
      comment: "Average downtime hours per work order"
    - name: "avg_estimated_labor_hours"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per work order"
    - name: "percent_safety_incident"
      expr: AVG(CAST(safety_incident_flag AS INT)) * 100
      comment: "Percentage of work orders that resulted in a safety incident"
$$;