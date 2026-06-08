-- Metric views for domain: workforce | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core work order performance and cost metrics"
  source: "`telecommunication_ecm`.`workforce`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Category/type of work order"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the work order"
    - name: "depot_id"
      expr: depot_id
      comment: "Depot responsible for the work order"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the work order was created"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_labor_hours"
      expr: SUM(CAST(total_labor_hours AS DOUBLE))
      comment: "Sum of labor hours across all work orders"
    - name: "average_labor_hours"
      expr: AVG(CAST(total_labor_hours AS DOUBLE))
      comment: "Average labor hours per work order"
    - name: "total_material_cost"
      expr: SUM(CAST(total_material_cost AS DOUBLE))
      comment: "Total material cost incurred by work orders"
    - name: "first_time_fix_count"
      expr: SUM(CASE WHEN first_time_fix_flag THEN 1 ELSE 0 END)
      comment: "Count of work orders fixed on first attempt"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_dispatch_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispatch efficiency and SLA adherence metrics"
  source: "`telecommunication_ecm`.`workforce`.`dispatch_event`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the dispatch"
    - name: "dispatch_type"
      expr: dispatch_type
      comment: "Type of dispatch (e.g., routine, urgent)"
    - name: "after_hours_flag"
      expr: after_hours_flag
      comment: "Whether dispatch occurred after regular hours"
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Whether dispatch was marked as emergency"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the dispatch event was created"
  measures:
    - name: "total_dispatches"
      expr: COUNT(1)
      comment: "Total number of dispatch events"
    - name: "average_dispatch_delay_minutes"
      expr: AVG(CAST((unix_timestamp(dispatch_timestamp) - unix_timestamp(created_timestamp)) AS DOUBLE))
      comment: "Average time between creation and dispatch in minutes"
    - name: "on_time_dispatch_count"
      expr: SUM(CASE WHEN NOT sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of dispatches that met SLA"
    - name: "emergency_dispatch_count"
      expr: SUM(CASE WHEN emergency_flag THEN 1 ELSE 0 END)
      comment: "Count of emergency dispatches"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_technician_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for field technicians"
  source: "`telecommunication_ecm`.`workforce`.`technician`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the technician"
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level classification"
    - name: "workforce_classification"
      expr: workforce_classification
      comment: "Broad workforce classification (e.g., field, support)"
  measures:
    - name: "average_sla_compliance_rate"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate for technicians"
    - name: "average_first_time_fix_rate"
      expr: AVG(CAST(first_time_fix_rate AS DOUBLE))
      comment: "Average first‑time fix rate across technicians"
    - name: "average_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score for technicians"
    - name: "average_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate"
    - name: "average_work_orders_per_day"
      expr: AVG(CAST(work_orders_per_day AS DOUBLE))
      comment: "Average number of work orders completed per day per technician"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety incident volume and cost impact"
  source: "`telecommunication_ecm`.`workforce`.`safety_incident`"
  dimensions:
    - name: "incident_severity"
      expr: incident_severity
      comment: "Severity level of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Category/type of safety incident"
    - name: "incident_state"
      expr: incident_state
      comment: "Geographic state where incident occurred"
    - name: "incident_date"
      expr: DATE_TRUNC('day', incident_date)
      comment: "Date of the incident"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents recorded"
    - name: "total_incident_cost"
      expr: SUM(CAST(incident_cost_estimate AS DOUBLE))
      comment: "Aggregate estimated cost of safety incidents"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_field_vehicle_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle fleet efficiency and cost metrics"
  source: "`telecommunication_ecm`.`workforce`.`field_vehicle`"
  dimensions:
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Classification of vehicle (e.g., truck, van)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used by the vehicle"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (owned, leased)"
    - name: "depot_id"
      expr: depot_id
      comment: "Depot where the vehicle is based"
  measures:
    - name: "total_vehicles"
      expr: COUNT(1)
      comment: "Total number of field vehicles"
    - name: "average_fuel_consumption_per_100km"
      expr: AVG(CAST(average_fuel_consumption_per_100km AS DOUBLE))
      comment: "Average fuel consumption per 100km"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Sum of maintenance costs for all vehicles"
    - name: "average_vehicle_age_years"
      expr: AVG(CAST(DATEDIFF(current_date(), acquisition_date) AS DOUBLE) / 365)
      comment: "Average age of vehicles in years"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic workforce capacity and budgeting metrics"
  source: "`telecommunication_ecm`.`workforce`.`workforce_capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of plan (e.g., annual, quarterly)"
    - name: "depot_id"
      expr: depot_id
      comment: "Depot associated with the plan"
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('day', planning_period_start_date)
      comment: "Start date of the planning period"
  measures:
    - name: "total_plans"
      expr: COUNT(1)
      comment: "Number of capacity plans recorded"
    - name: "average_attrition_rate_pct"
      expr: AVG(CAST(attrition_rate_pct AS DOUBLE))
      comment: "Average attrition rate percentage across plans"
    - name: "average_utilization_target_pct"
      expr: AVG(CAST(utilization_target_pct AS DOUBLE))
      comment: "Average target utilization percentage"
    - name: "average_budget_allocated_amount"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per plan"
$$;