-- Metric views for domain: site | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for concrete pours at sites."
  source: "`construction_ecm`.`site`.`concrete_pour`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Identifier of the construction project."
    - name: "pour_date"
      expr: pour_date
      comment: "Date of the concrete pour."
    - name: "batch_plant_name"
      expr: batch_plant_name
      comment: "Name of the concrete batch plant."
    - name: "mix_design_code"
      expr: mix_design_code
      comment: "Mix design code used for the pour."
    - name: "curing_method"
      expr: curing_method
      comment: "Curing method applied to the concrete."
    - name: "pour_type"
      expr: pour_type
      comment: "Type of pour (e.g., slab, column)."
    - name: "qc_inspector"
      expr: qc_inspector
      comment: "Quality control inspector for the pour."
  measures:
    - name: "total_volume_poured_m3"
      expr: SUM(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Total concrete volume poured (cubic meters) for the selected scope."
    - name: "pour_count"
      expr: COUNT(1)
      comment: "Number of concrete pour events."
    - name: "average_slump_mm"
      expr: AVG(CAST(slump_test_result_mm AS DOUBLE))
      comment: "Average slump test result (mm) across pours."
    - name: "slump_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN slump_compliant THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours that met slump compliance."
    - name: "average_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature (C) during pours."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_crew_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Productivity and labor utilization metrics for crew deployments."
  source: "`construction_ecm`.`site`.`crew_deployment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier."
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date the crew was deployed."
    - name: "crew_type"
      expr: crew_type
      comment: "Type/category of the crew (e.g., concrete, formwork)."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, night, etc.)."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front identifier where crew operated."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual crew hours worked."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours logged by crews."
    - name: "average_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate reported for crew deployments."
    - name: "crew_deployment_count"
      expr: COUNT(1)
      comment: "Number of crew deployment records."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_daily_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational performance snapshot from site daily logs."
  source: "`construction_ecm`.`site`.`daily_log`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier."
    - name: "log_date"
      expr: log_date
      comment: "Date of the daily log."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the log (e.g., day, night)."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition reported for the day."
  measures:
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume recorded in daily logs."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume recorded in daily logs."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Aggregate delay duration (hours) across daily logs."
    - name: "delay_event_count"
      expr: SUM(CASE WHEN has_delay_event THEN 1 ELSE 0 END)
      comment: "Count of daily logs that reported a delay event."
    - name: "safety_incident_count"
      expr: SUM(CASE WHEN lti_occurred_flag THEN 1 ELSE 0 END)
      comment: "Count of daily logs with a lost‑time incident."
    - name: "daily_log_count"
      expr: COUNT(1)
      comment: "Number of daily log entries."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_production_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production performance and progress metrics."
  source: "`construction_ecm`.`site`.`production_entry`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier."
    - name: "entry_date"
      expr: entry_date
      comment: "Date of the production entry."
    - name: "crew_id"
      expr: crew_id
      comment: "Crew identifier associated with the entry."
    - name: "work_front_id"
      expr: work_front_id
      comment: "Work front identifier."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the entry."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed (units) across production entries."
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate AS DOUBLE))
      comment: "Average production rate reported."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours recorded."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours recorded."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete for tracked items."
    - name: "production_entry_count"
      expr: COUNT(1)
      comment: "Number of production entry records."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_material_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery performance and timeliness metrics for site materials."
  source: "`construction_ecm`.`site`.`material_delivery`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier."
    - name: "delivery_date"
      expr: delivery_date
      comment: "Actual delivery date."
    - name: "material_category"
      expr: material_category
      comment: "Category of material delivered."
  measures:
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Number of material delivery records."
    - name: "avg_delivery_delay_days"
      expr: AVG(DATEDIFF(delivery_date, expected_delivery_date))
      comment: "Average delivery delay in days (positive = late)."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of material delivered."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity of material accepted after inspection."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_date <= expected_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries arriving on or before the expected date."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_lift_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crane lift utilization and safety metrics."
  source: "`construction_ecm`.`site`.`lift_plan`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier."
    - name: "lift_date"
      expr: lift_date
      comment: "Date of the lift operation."
    - name: "crane_type"
      expr: crane_type
      comment: "Type/model of crane used."
    - name: "lift_type"
      expr: lift_type
      comment: "Classification of lift (e.g., heavy, routine)."
  measures:
    - name: "lift_count"
      expr: COUNT(1)
      comment: "Number of lift plan records (lifts executed)."
    - name: "total_load_weight_t"
      expr: SUM(CAST(load_weight_t AS DOUBLE))
      comment: "Total load weight lifted (tonnes)."
    - name: "avg_capacity_utilisation_pct"
      expr: AVG(CAST(capacity_utilisation_pct AS DOUBLE))
      comment: "Average crane capacity utilisation percentage."
    - name: "avg_load_weight_t"
      expr: AVG(CAST(load_weight_t AS DOUBLE))
      comment: "Average load weight per lift (tonnes)."
$$;