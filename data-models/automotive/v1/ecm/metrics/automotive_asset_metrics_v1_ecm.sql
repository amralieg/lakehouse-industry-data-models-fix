-- Metric views for domain: asset | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key acquisition KPIs for capital planning and budgeting"
  source: "`automotive_ecm`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_year"
      expr: YEAR(acquisition_timestamp)
      comment: "Year of acquisition"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the acquired asset"
    - name: "asset_type"
      expr: asset_type
      comment: "Type of the acquired asset"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the asset"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the acquisition amounts"
  measures:
    - name: "acquisition_count"
      expr: COUNT(1)
      comment: "Number of asset acquisitions"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_acquisition_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial view of asset acquisitions for CFO and investment decisions"
  source: "`automotive_ecm`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_month"
      expr: DATE_TRUNC('month', acquisition_timestamp)
      comment: "Month of acquisition"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the acquired asset"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total acquisition cost (raw cost) across all assets"
    - name: "average_acquisition_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average acquisition cost per asset"
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Sum of gross amounts invoiced for acquisitions"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Sum of net amounts after discounts/taxes"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_equipment_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core equipment inventory and performance KPIs for operations leadership"
  source: "`automotive_ecm`.`asset`.`equipment_registry`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment (e.g., motor, pump)"
  measures:
    - name: "equipment_count"
      expr: COUNT(1)
      comment: "Number of equipment records"
    - name: "total_capital_expenditure"
      expr: SUM(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Total capital spend on equipment"
    - name: "average_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Mean Time Between Failures (hours) average across equipment"
    - name: "average_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Mean Time To Repair (hours) average across equipment"
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption of equipment (kWh)"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_equipment_registry_attributes`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dimensional view for slicing equipment KPIs"
  source: "`automotive_ecm`.`asset`.`equipment_registry`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Specific equipment type"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer"
    - name: "model_number"
      expr: model_number
      comment: "Model number of equipment"
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase"
    - name: "warranty_status"
      expr: warranty_status
      comment: "Warranty status of equipment"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
      comment: "Total rows"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_equipment_reliability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability and OEE KPIs used by plant managers and reliability engineers"
  source: "`automotive_ecm`.`asset`.`equipment_reliability`"
  dimensions:
    - name: "plant_location"
      expr: plant_location
      comment: "Plant location of the equipment"
    - name: "reliability_category"
      expr: reliability_category
      comment: "Reliability classification (e.g., critical, non‑critical)"
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting month"
  measures:
    - name: "equipment_reliability_record_count"
      expr: COUNT(1)
      comment: "Number of reliability records"
    - name: "average_availability_percentage"
      expr: AVG(CAST(availability_percentage AS DOUBLE))
      comment: "Average equipment availability percentage"
    - name: "average_overall_oee_percentage"
      expr: AVG(CAST(overall_oee_percentage AS DOUBLE))
      comment: "Average Overall OEE across equipment"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(total_downtime_minutes AS DOUBLE))
      comment: "Cumulative downtime minutes"
    - name: "total_uptime_minutes"
      expr: SUM(CAST(total_uptime_minutes AS DOUBLE))
      comment: "Cumulative uptime minutes"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_maintenance_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of maintenance activities for cost‑control and budgeting"
  source: "`automotive_ecm`.`asset`.`maintenance_cost`"
  dimensions:
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance (e.g., preventive, corrective)"
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category (e.g., labor, parts)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost amounts"
    - name: "maintenance_month"
      expr: DATE_TRUNC('month', maintenance_start_timestamp)
      comment: "Month when maintenance started"
  measures:
    - name: "maintenance_event_count"
      expr: COUNT(1)
      comment: "Number of maintenance cost events"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost incurred for maintenance"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Labor component of maintenance cost"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Material component of maintenance cost"
    - name: "average_labor_hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per maintenance event"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_equipment_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime impact metrics for production efficiency and loss analysis"
  source: "`automotive_ecm`.`asset`.`equipment_downtime`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g., mechanical, electrical)"
    - name: "cause_severity"
      expr: cause_severity
      comment: "Severity of the downtime cause"
    - name: "shift"
      expr: shift
      comment: "Shift during which downtime occurred"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center identifier"
  measures:
    - name: "downtime_event_count"
      expr: COUNT(1)
      comment: "Number of downtime events recorded"
    - name: "total_cost_of_downtime"
      expr: SUM(CAST(cost_of_downtime AS DOUBLE))
      comment: "Monetary cost associated with downtime"
    - name: "average_downtime_percentage"
      expr: AVG(CAST(downtime_percentage AS DOUBLE))
      comment: "Average downtime as a percentage of scheduled time"
    - name: "average_oee_impact_percentage"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average impact of downtime on OEE"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_condition_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real‑time condition monitoring KPIs for predictive maintenance decisions"
  source: "`automotive_ecm`.`asset`.`condition_monitoring`"
  dimensions:
    - name: "equipment_registry_id"
      expr: equipment_registry_id
      comment: "Identifier of the equipment being monitored"
    - name: "plant"
      expr: plant
      comment: "Plant where the equipment resides"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (e.g., temperature, vibration)"
    - name: "anomaly_detected"
      expr: anomaly_detected
      comment: "Flag indicating if an anomaly was detected"
  measures:
    - name: "condition_monitoring_record_count"
      expr: COUNT(1)
      comment: "Number of condition monitoring records"
    - name: "average_anomaly_score"
      expr: AVG(CAST(anomaly_score AS DOUBLE))
      comment: "Average anomaly score across monitored assets"
    - name: "average_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average sensor measurement value"
    - name: "average_predicted_time_to_failure_hours"
      expr: AVG(CAST(predicted_time_to_failure_hours AS DOUBLE))
      comment: "Average predicted time to failure (hours)"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`asset_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation KPIs for finance and asset management leadership"
  source: "`automotive_ecm`.`asset`.`asset_valuation`"
  dimensions:
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the valuation"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (e.g., fair market, book)"
    - name: "asset_valuation_status"
      expr: asset_valuation_status
      comment: "Status of the valuation record"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the valuation amounts"
  measures:
    - name: "asset_valuation_record_count"
      expr: COUNT(1)
      comment: "Number of asset valuation records"
    - name: "total_valuation_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total valuation amount across assets"
    - name: "total_book_value_before"
      expr: SUM(CAST(book_value_before_valuation AS DOUBLE))
      comment: "Aggregate book value before valuation"
    - name: "total_book_value_after"
      expr: SUM(CAST(book_value_after_valuation AS DOUBLE))
      comment: "Aggregate book value after valuation"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment amount recognized"
$$;