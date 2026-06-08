-- Metric views for domain: maintenance | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core maintenance work order execution and cost metrics tracking labor, material, and total costs against estimates, downtime impact, and schedule adherence"
  source: "`chemical_mfg_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (preventive, corrective, breakdown, project)"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (open, in progress, completed, cancelled)"
    - name: "priority"
      expr: priority
      comment: "Work order priority level indicating urgency"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month when work order was scheduled to start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when work order actually started"
    - name: "downtime_required_flag"
      expr: downtime_required
      comment: "Whether the work order required equipment downtime"
    - name: "lockout_tagout_required_flag"
      expr: lockout_tagout_required
      comment: "Whether lockout/tagout safety procedures were required"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of equipment failure addressed by work order"
  measures:
    - name: "total_work_order_count"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost incurred across all work orders"
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost incurred across all work orders"
    - name: "total_work_order_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all work orders including labor, material, and external services"
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost for all work orders"
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost for all work orders"
    - name: "total_external_service_cost"
      expr: SUM(CAST(external_service_cost AS DOUBLE))
      comment: "Total cost of external services across all work orders"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total equipment downtime hours caused by maintenance work orders"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours spent on work orders"
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for work orders"
    - name: "avg_work_order_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average total cost per work order"
    - name: "avg_downtime_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime hours per work order"
    - name: "labor_cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_labor_cost AS DOUBLE)) - SUM(CAST(estimated_labor_cost AS DOUBLE))) / NULLIF(SUM(CAST(estimated_labor_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated labor costs (positive = over budget)"
    - name: "material_cost_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_material_cost AS DOUBLE)) - SUM(CAST(estimated_material_cost AS DOUBLE))) / NULLIF(SUM(CAST(estimated_material_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated material costs (positive = over budget)"
    - name: "labor_hours_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_labor_hours AS DOUBLE)) - SUM(CAST(estimated_labor_hours AS DOUBLE))) / NULLIF(SUM(CAST(estimated_labor_hours AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated labor hours (positive = over estimate)"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_breakdown_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unplanned equipment breakdown and failure metrics tracking frequency, duration, production impact, and safety incidents to drive reliability improvement"
  source: "`chemical_mfg_ecm`.`maintenance`.`breakdown_event`"
  dimensions:
    - name: "breakdown_status"
      expr: breakdown_status
      comment: "Current status of the breakdown event"
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code for the equipment failure"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of equipment failure"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level assigned to the breakdown"
    - name: "production_impact_severity"
      expr: production_impact_severity
      comment: "Severity level of production impact from breakdown"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the breakdown was detected"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether the breakdown resulted in a safety incident"
    - name: "environmental_release_flag"
      expr: environmental_release_flag
      comment: "Whether the breakdown caused an environmental release"
    - name: "psm_critical_flag"
      expr: psm_critical_flag
      comment: "Whether the breakdown involved PSM-covered critical equipment"
    - name: "moc_required_flag"
      expr: moc_required_flag
      comment: "Whether management of change is required for repair"
    - name: "breakdown_month"
      expr: DATE_TRUNC('MONTH', breakdown_start_timestamp)
      comment: "Month when the breakdown occurred"
  measures:
    - name: "total_breakdown_count"
      expr: COUNT(1)
      comment: "Total number of breakdown events"
    - name: "total_breakdown_duration_hours"
      expr: SUM(CAST(breakdown_duration_hours AS DOUBLE))
      comment: "Total duration of all breakdown events in hours"
    - name: "avg_breakdown_duration_hours"
      expr: AVG(CAST(breakdown_duration_hours AS DOUBLE))
      comment: "Average duration per breakdown event in hours"
    - name: "total_response_time_hours"
      expr: SUM(CAST(response_time_hours AS DOUBLE))
      comment: "Total response time from breakdown detection to repair start"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average response time per breakdown event in hours"
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated cost to repair all breakdowns"
    - name: "avg_estimated_repair_cost"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per breakdown"
    - name: "total_production_loss_quantity"
      expr: SUM(CAST(production_loss_quantity AS DOUBLE))
      comment: "Total production quantity lost due to breakdowns"
    - name: "safety_incident_count"
      expr: SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of breakdowns that resulted in safety incidents"
    - name: "environmental_release_count"
      expr: SUM(CASE WHEN environmental_release_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of breakdowns that caused environmental releases"
    - name: "psm_critical_breakdown_count"
      expr: SUM(CASE WHEN psm_critical_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of breakdowns involving PSM-critical equipment"
    - name: "safety_incident_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of breakdowns that resulted in safety incidents"
    - name: "mttr_hours"
      expr: AVG(CAST(breakdown_duration_hours AS DOUBLE))
      comment: "Mean Time To Repair - average breakdown duration representing repair efficiency"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument calibration compliance and quality metrics tracking pass/fail rates, out-of-tolerance conditions, and regulatory adherence for critical measurement equipment"
  source: "`chemical_mfg_ecm`.`maintenance`.`calibration_record`"
  dimensions:
    - name: "calibration_status"
      expr: calibration_status
      comment: "Status of the calibration record"
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Whether the calibration passed or failed acceptance criteria"
    - name: "out_of_tolerance_flag"
      expr: out_of_tolerance_flag
      comment: "Whether the instrument was found out of tolerance"
    - name: "adjustment_performed_flag"
      expr: adjustment_performed_flag
      comment: "Whether adjustment was performed during calibration"
    - name: "gmp_regulated_flag"
      expr: gmp_regulated_flag
      comment: "Whether the instrument is subject to GMP regulations"
    - name: "psm_critical_instrument_flag"
      expr: psm_critical_instrument_flag
      comment: "Whether the instrument is PSM-critical"
    - name: "calibration_month"
      expr: DATE_TRUNC('MONTH', calibration_date)
      comment: "Month when calibration was performed"
    - name: "calibration_due_month"
      expr: DATE_TRUNC('MONTH', calibration_due_date)
      comment: "Month when calibration is due"
  measures:
    - name: "total_calibration_count"
      expr: COUNT(1)
      comment: "Total number of calibration records"
    - name: "total_calibration_cost"
      expr: SUM(CAST(calibration_cost AS DOUBLE))
      comment: "Total cost of all calibrations performed"
    - name: "avg_calibration_cost"
      expr: AVG(CAST(calibration_cost AS DOUBLE))
      comment: "Average cost per calibration"
    - name: "out_of_tolerance_count"
      expr: SUM(CASE WHEN out_of_tolerance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calibrations where instrument was found out of tolerance"
    - name: "calibration_pass_count"
      expr: SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of calibrations that passed acceptance criteria"
    - name: "calibration_fail_count"
      expr: SUM(CASE WHEN pass_fail_status = 'Fail' THEN 1 ELSE 0 END)
      comment: "Number of calibrations that failed acceptance criteria"
    - name: "adjustment_performed_count"
      expr: SUM(CASE WHEN adjustment_performed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calibrations where adjustment was performed"
    - name: "out_of_tolerance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_tolerance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations where instrument was found out of tolerance - key quality indicator"
    - name: "calibration_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations that passed acceptance criteria - compliance metric"
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibrations - precision indicator"
    - name: "psm_critical_calibration_count"
      expr: SUM(CASE WHEN psm_critical_instrument_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calibrations on PSM-critical instruments"
    - name: "gmp_regulated_calibration_count"
      expr: SUM(CASE WHEN gmp_regulated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of calibrations on GMP-regulated instruments"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_pm_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance planning and scheduling effectiveness metrics tracking plan coverage, cycle adherence, and proactive maintenance strategy execution"
  source: "`chemical_mfg_ecm`.`maintenance`.`pm_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the PM plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of preventive maintenance plan"
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM plan"
    - name: "cycle_unit"
      expr: cycle_unit
      comment: "Unit of measure for maintenance cycle (days, hours, cycles)"
    - name: "auto_generate_work_order_flag"
      expr: auto_generate_work_order_flag
      comment: "Whether work orders are automatically generated from this plan"
    - name: "insurance_requirement_flag"
      expr: insurance_requirement_flag
      comment: "Whether the PM plan is required by insurance"
    - name: "moc_required_flag"
      expr: moc_required_flag
      comment: "Whether management of change is required for plan modifications"
    - name: "seasonal_adjustment_flag"
      expr: seasonal_adjustment_flag
      comment: "Whether the plan has seasonal scheduling adjustments"
    - name: "next_scheduled_month"
      expr: DATE_TRUNC('MONTH', next_scheduled_date)
      comment: "Month when next PM is scheduled"
  measures:
    - name: "total_pm_plan_count"
      expr: COUNT(1)
      comment: "Total number of preventive maintenance plans"
    - name: "active_pm_plan_count"
      expr: SUM(CASE WHEN plan_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active PM plans currently in effect"
    - name: "avg_cycle_length"
      expr: AVG(CAST(cycle_length AS DOUBLE))
      comment: "Average maintenance cycle length across all plans"
    - name: "avg_call_horizon_days"
      expr: AVG(CAST(call_horizon_days AS DOUBLE))
      comment: "Average call horizon in days for PM scheduling"
    - name: "insurance_required_plan_count"
      expr: SUM(CASE WHEN insurance_requirement_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of PM plans required by insurance"
    - name: "auto_generate_plan_count"
      expr: SUM(CASE WHEN auto_generate_work_order_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of plans with automatic work order generation enabled"
    - name: "distinct_equipment_count"
      expr: COUNT(DISTINCT equipment_id)
      comment: "Number of distinct equipment assets covered by PM plans"
    - name: "pm_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT equipment_id) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage representing PM plan coverage efficiency"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset inventory and criticality metrics tracking asset status, PSM coverage, calibration requirements, and maintenance strategy alignment"
  source: "`chemical_mfg_ecm`.`maintenance`.`equipment`"
  dimensions:
    - name: "equipment_status"
      expr: equipment_status
      comment: "Current operational status of the equipment"
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category classification of the equipment"
    - name: "equipment_class"
      expr: equipment_class
      comment: "Class of equipment"
    - name: "criticality_class"
      expr: criticality_class
      comment: "Criticality classification for maintenance prioritization"
    - name: "psm_covered"
      expr: psm_covered
      comment: "Whether equipment is covered under Process Safety Management"
    - name: "calibration_required"
      expr: calibration_required
      comment: "Whether equipment requires periodic calibration"
    - name: "hazardous_area_classification"
      expr: hazardous_area_classification
      comment: "Hazardous area classification for safety compliance"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Assigned maintenance strategy for the equipment"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year when equipment was commissioned"
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment assets"
    - name: "active_equipment_count"
      expr: SUM(CASE WHEN equipment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of equipment assets in active status"
    - name: "psm_covered_equipment_count"
      expr: SUM(CASE WHEN psm_covered = TRUE THEN 1 ELSE 0 END)
      comment: "Number of equipment assets covered under PSM regulations"
    - name: "calibration_required_equipment_count"
      expr: SUM(CASE WHEN calibration_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of equipment assets requiring calibration"
    - name: "avg_equipment_capacity"
      expr: AVG(CAST(capacity_value AS DOUBLE))
      comment: "Average capacity value across equipment assets"
    - name: "total_equipment_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of all equipment in kilograms"
    - name: "avg_design_pressure_kpa"
      expr: AVG(CAST(design_pressure_kpa AS DOUBLE))
      comment: "Average design pressure across pressure equipment"
    - name: "avg_design_temperature_c"
      expr: AVG(CAST(design_temperature_c AS DOUBLE))
      comment: "Average design temperature across equipment"
    - name: "psm_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN psm_covered = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment covered under PSM - regulatory compliance indicator"
    - name: "distinct_manufacturer_count"
      expr: COUNT(DISTINCT manufacturer_name)
      comment: "Number of distinct equipment manufacturers - supply chain diversity metric"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`maintenance_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level maintenance performance and reliability metrics tracking MTBF, MTTR, safety ratings, and certification status across manufacturing facilities"
  source: "`chemical_mfg_ecm`.`maintenance`.`maintenance_plant`"
  dimensions:
    - name: "plant_status"
      expr: plant_status
      comment: "Current operational status of the maintenance plant"
    - name: "plant_type"
      expr: plant_type
      comment: "Type classification of the plant"
    - name: "country_code"
      expr: country_code
      comment: "Country where the plant is located"
    - name: "is_certified_iso9001"
      expr: is_certified_iso9001
      comment: "Whether plant holds ISO 9001 quality certification"
    - name: "is_certified_iso14001"
      expr: is_certified_iso14001
      comment: "Whether plant holds ISO 14001 environmental certification"
    - name: "is_certified_ohsas18001"
      expr: is_certified_ohsas18001
      comment: "Whether plant holds OHSAS 18001 safety certification"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety performance rating of the plant"
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Current regulatory compliance status"
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Overall maintenance strategy employed at the plant"
  measures:
    - name: "total_plant_count"
      expr: COUNT(1)
      comment: "Total number of maintenance plants"
    - name: "active_plant_count"
      expr: SUM(CASE WHEN plant_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of plants in active operational status"
    - name: "total_plant_capacity_tons_per_year"
      expr: SUM(CAST(capacity_tons_per_year AS DOUBLE))
      comment: "Total production capacity across all plants in tons per year"
    - name: "avg_plant_capacity_tons_per_year"
      expr: AVG(CAST(capacity_tons_per_year AS DOUBLE))
      comment: "Average production capacity per plant in tons per year"
    - name: "total_plant_area_sq_m"
      expr: SUM(CAST(area_sq_m AS DOUBLE))
      comment: "Total plant area across all facilities in square meters"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures across plants - key reliability indicator"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair across plants - maintenance efficiency indicator"
    - name: "iso9001_certified_plant_count"
      expr: SUM(CASE WHEN is_certified_iso9001 = TRUE THEN 1 ELSE 0 END)
      comment: "Number of plants with ISO 9001 quality certification"
    - name: "iso14001_certified_plant_count"
      expr: SUM(CASE WHEN is_certified_iso14001 = TRUE THEN 1 ELSE 0 END)
      comment: "Number of plants with ISO 14001 environmental certification"
    - name: "ohsas18001_certified_plant_count"
      expr: SUM(CASE WHEN is_certified_ohsas18001 = TRUE THEN 1 ELSE 0 END)
      comment: "Number of plants with OHSAS 18001 safety certification"
    - name: "iso9001_certification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_certified_iso9001 = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plants with ISO 9001 certification - quality maturity indicator"
    - name: "reliability_ratio"
      expr: ROUND(AVG(CAST(mtbf_hours AS DOUBLE)) / NULLIF(AVG(CAST(mttr_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of MTBF to MTTR - higher values indicate better overall equipment reliability and maintenance efficiency"
$$;