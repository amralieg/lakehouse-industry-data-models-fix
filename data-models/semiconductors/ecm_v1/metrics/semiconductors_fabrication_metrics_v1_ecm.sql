-- Metric views for domain: fabrication | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 18:21:54

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_fab`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for fab facilities."
  source: "`semiconductors_ecm`.`fabrication`.`fab`"
  dimensions:
    - name: "fab_region"
      expr: fab_region
      comment: "Geographic region of the fab."
    - name: "fab_type"
      expr: fab_type
      comment: "Type of fab (e.g., front-end, back-end)."
    - name: "fab_status"
      expr: status
      comment: "Operational status of the fab."
    - name: "fab_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of record creation."
  measures:
    - name: "total_power_capacity_mw"
      expr: SUM(CAST(power_capacity_mw AS DOUBLE))
      comment: "Total power capacity across fabs (MW)."
    - name: "avg_water_usage_cubic_m_per_day"
      expr: AVG(CAST(water_usage_cubic_m_per_day AS DOUBLE))
      comment: "Average water usage per day (cubic meters)."
    - name: "avg_waste_treatment_capacity_kg_per_day"
      expr: AVG(CAST(waste_treatment_capacity_kg_per_day AS DOUBLE))
      comment: "Average waste treatment capacity per day (kg)."
    - name: "fab_count"
      expr: COUNT(1)
      comment: "Number of fab records."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_fab_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility-level environmental and energy KPIs."
  source: "`semiconductors_ecm`.`fabrication`.`fab_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Classification of facility (e.g., cleanroom, test)."
    - name: "country_code"
      expr: country_code
      comment: "Country where facility is located."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the facility."
  measures:
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption (MWh)."
    - name: "avg_carbon_footprint_kgco2e"
      expr: AVG(CAST(carbon_footprint_kgco2e AS DOUBLE))
      comment: "Average carbon footprint (kg CO2e)."
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated (tons)."
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Number of facilities."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_fab_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site-level capacity and resource utilization."
  source: "`semiconductors_ecm`.`fabrication`.`fab_site`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Region of the fab site."
    - name: "site_type"
      expr: site_type
      comment: "Type of site (e.g., main, satellite)."
    - name: "is_primary_site"
      expr: is_primary_site
      comment: "Flag indicating primary site."
    - name: "site_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of record creation."
  measures:
    - name: "total_power_capacity_mw"
      expr: SUM(CAST(power_capacity_mw AS DOUBLE))
      comment: "Total power capacity across sites (MW)."
    - name: "avg_water_capacity_m3_per_day"
      expr: AVG(CAST(water_capacity_m3_per_day AS DOUBLE))
      comment: "Average water capacity per day (m3)."
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of sites."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_equipment_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment group capability metrics."
  source: "`semiconductors_ecm`.`fabrication`.`equipment_group`"
  dimensions:
    - name: "group_type"
      expr: group_type
      comment: "Category of equipment group."
    - name: "process_technology"
      expr: process_technology
      comment: "Process technology associated with the group."
    - name: "status"
      expr: status
      comment: "Current status of the equipment group."
    - name: "equipment_group_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of record creation."
  measures:
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum operating temperature (C)."
    - name: "avg_voltage_rating_v"
      expr: AVG(CAST(voltage_rating_v AS DOUBLE))
      comment: "Average voltage rating (V)."
    - name: "equipment_group_count"
      expr: COUNT(1)
      comment: "Number of equipment groups."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_equipment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Run-level performance and efficiency."
  source: "`semiconductors_ecm`.`fabrication`.`equipment_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the equipment run."
    - name: "run_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of run."
  measures:
    - name: "total_run_duration_seconds"
      expr: SUM(CAST(run_duration_seconds AS DOUBLE))
      comment: "Total run duration (seconds)."
    - name: "avg_actual_temperature_celsius"
      expr: AVG(CAST(actual_temperature_celsius AS DOUBLE))
      comment: "Average actual temperature (C)."
    - name: "avg_target_temperature_celsius"
      expr: AVG(CAST(target_temperature_celsius AS DOUBLE))
      comment: "Average target temperature (C)."
    - name: "run_count"
      expr: COUNT(1)
      comment: "Number of equipment runs."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_fab_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield and quality metrics per fab facility."
  source: "`semiconductors_ecm`.`fabrication`.`fab_yield_record`"
  dimensions:
    - name: "fab_facility_id"
      expr: fab_facility_id
      comment: "Identifier of the fab facility."
  measures:
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage."
    - name: "total_yield_for_lot"
      expr: SUM(CAST(yield_for_lot AS DOUBLE))
      comment: "Total yield for lot (sum of lot yields)."
    - name: "yield_excursion_count"
      expr: SUM(CASE WHEN yield_excursion_flag THEN 1 ELSE 0 END)
      comment: "Count of yield excursions."
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Number of yield records."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow efficiency and target yield."
  source: "`semiconductors_ecm`.`fabrication`.`fabrication_process_flow`"
  dimensions:
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of the flow."
    - name: "flow_status"
      expr: flow_status
      comment: "Current status of the flow."
    - name: "flow_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of record."
  measures:
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time (days)."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percent."
    - name: "process_flow_count"
      expr: COUNT(1)
      comment: "Number of process flow records."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_process_step`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Step-level timing and cost metrics."
  source: "`semiconductors_ecm`.`fabrication`.`fabrication_process_step`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Operation type of the step."
    - name: "step_status"
      expr: step_status
      comment: "Current status of the step."
    - name: "critical_step_flag"
      expr: critical_step_flag
      comment: "Flag indicating critical step."
    - name: "step_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of record."
  measures:
    - name: "avg_target_cycle_time_minutes"
      expr: AVG(CAST(target_cycle_time_minutes AS DOUBLE))
      comment: "Average target cycle time (minutes)."
    - name: "avg_step_cost_per_wafer"
      expr: AVG(CAST(step_cost_per_wafer AS DOUBLE))
      comment: "Average cost per wafer for the step."
    - name: "critical_step_count"
      expr: SUM(CASE WHEN critical_step_flag THEN 1 ELSE 0 END)
      comment: "Count of critical steps."
    - name: "step_count"
      expr: COUNT(1)
      comment: "Number of process steps."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_process_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe quality and performance metrics."
  source: "`semiconductors_ecm`.`fabrication`.`fabrication_process_recipe`"
  dimensions:
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the recipe."
    - name: "recipe_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of record."
  measures:
    - name: "avg_defect_density_target_per_cm2"
      expr: AVG(CAST(defect_density_target_per_cm2 AS DOUBLE))
      comment: "Average defect density target (defects per cm2)."
    - name: "avg_power_settings_watts"
      expr: AVG(CAST(power_settings_watts AS DOUBLE))
      comment: "Average power settings (watts)."
    - name: "avg_yield_target_percent"
      expr: AVG(CAST(yield_target_percent AS DOUBLE))
      comment: "Average yield target percent."
    - name: "recipe_count"
      expr: COUNT(1)
      comment: "Number of recipes."
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer lot throughput and cycle metrics."
  source: "`semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`"
  dimensions:
    - name: "lot_type"
      expr: lot_type
      comment: "Type of wafer lot."
  measures:
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average cycle time (days) per lot."
    - name: "avg_process_time_hours"
      expr: AVG(CAST(process_time_hours AS DOUBLE))
      comment: "Average process time (hours) per lot."
    - name: "avg_queue_time_hours"
      expr: AVG(CAST(queue_time_hours AS DOUBLE))
      comment: "Average queue time (hours) per lot."
    - name: "wafer_lot_count"
      expr: COUNT(1)
      comment: "Number of wafer lot records."
$$;