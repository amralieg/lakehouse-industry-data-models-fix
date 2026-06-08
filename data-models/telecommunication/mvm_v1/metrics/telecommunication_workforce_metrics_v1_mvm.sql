-- Metric views for domain: workforce | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_technician`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core technician performance and workforce quality metrics including productivity, customer satisfaction, and operational efficiency KPIs that drive workforce planning and performance management decisions."
  source: "`telecommunication_ecm`.`workforce`.`technician`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status of the technician (active, inactive, terminated, etc.)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (full-time, part-time, contractor, etc.)"
    - name: "skill_level"
      expr: skill_level
      comment: "Technician skill level classification (trainee, competent, expert, etc.)"
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status of the technician"
    - name: "current_performance_rating"
      expr: current_performance_rating
      comment: "Most recent performance rating assigned to the technician"
    - name: "service_zone"
      expr: service_zone
      comment: "Geographic service zone assigned to the technician"
    - name: "workforce_classification"
      expr: workforce_classification
      comment: "Workforce classification category for the technician"
    - name: "improvement_plan_flag"
      expr: improvement_plan_flag
      comment: "Indicates whether technician is on a performance improvement plan"
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates whether technician is a union member"
  measures:
    - name: "total_technicians"
      expr: COUNT(DISTINCT technician_id)
      comment: "Total count of unique technicians - key workforce capacity metric for resource planning"
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score across technicians - critical quality and customer experience KPI"
    - name: "avg_first_time_fix_rate"
      expr: AVG(CAST(first_time_fix_rate AS DOUBLE))
      comment: "Average first-time fix rate - key operational efficiency metric indicating technician effectiveness and training quality"
    - name: "avg_sla_compliance_rate"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate - critical service delivery metric for contract adherence and customer commitments"
    - name: "avg_attendance_rate"
      expr: AVG(CAST(attendance_rate AS DOUBLE))
      comment: "Average attendance rate - workforce reliability metric impacting capacity planning and scheduling"
    - name: "avg_work_orders_per_day"
      expr: AVG(CAST(work_orders_per_day AS DOUBLE))
      comment: "Average work orders completed per day per technician - key productivity metric for workforce efficiency"
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average mean time to repair across technicians - critical operational efficiency metric for service delivery speed"
    - name: "avg_safety_compliance_score"
      expr: AVG(CAST(safety_compliance_score AS DOUBLE))
      comment: "Average safety compliance score - critical risk management and regulatory compliance metric"
    - name: "avg_training_hours_ytd"
      expr: AVG(CAST(training_hours_ytd AS DOUBLE))
      comment: "Average year-to-date training hours per technician - workforce development investment metric"
    - name: "total_training_hours_ytd"
      expr: SUM(CAST(training_hours_ytd AS DOUBLE))
      comment: "Total year-to-date training hours across all technicians - aggregate workforce development investment"
    - name: "technicians_on_improvement_plan"
      expr: SUM(CASE WHEN improvement_plan_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of technicians currently on performance improvement plans - workforce quality and HR intervention metric"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution and service delivery metrics including completion rates, SLA performance, labor efficiency, and material costs that drive operational excellence and cost management decisions."
  source: "`telecommunication_ecm`.`workforce`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (open, in progress, completed, cancelled, etc.)"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type classification of the work order (installation, repair, maintenance, upgrade, etc.)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the work order (critical, high, medium, low)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the work order has been escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the work order breached its SLA target"
    - name: "first_time_fix_flag"
      expr: first_time_fix_flag
      comment: "Indicates whether the work order was resolved on the first visit"
    - name: "repeat_visit_flag"
      expr: repeat_visit_flag
      comment: "Indicates whether the work order required a repeat visit"
    - name: "customer_signature_captured"
      expr: customer_signature_captured
      comment: "Indicates whether customer signature was captured upon completion"
    - name: "resolution_code"
      expr: resolution_code
      comment: "Code indicating how the work order was resolved"
    - name: "escalation_reason"
      expr: escalation_reason
      comment: "Reason for work order escalation if applicable"
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the work order"
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date for the work order"
  measures:
    - name: "total_work_orders"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Total count of unique work orders - fundamental volume metric for capacity planning and demand forecasting"
    - name: "total_labor_hours"
      expr: SUM(CAST(total_labor_hours AS DOUBLE))
      comment: "Total labor hours consumed across all work orders - critical cost and resource utilization metric"
    - name: "avg_labor_hours_per_work_order"
      expr: AVG(CAST(total_labor_hours AS DOUBLE))
      comment: "Average labor hours per work order - operational efficiency metric for workforce productivity benchmarking"
    - name: "total_material_cost"
      expr: SUM(CAST(total_material_cost AS DOUBLE))
      comment: "Total material cost across all work orders - key cost management and inventory planning metric"
    - name: "avg_material_cost_per_work_order"
      expr: AVG(CAST(total_material_cost AS DOUBLE))
      comment: "Average material cost per work order - cost efficiency metric for procurement and inventory optimization"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders that breached SLA - critical service quality and contract compliance metric"
    - name: "first_time_fix_count"
      expr: SUM(CASE WHEN first_time_fix_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders resolved on first visit - key operational efficiency and customer satisfaction driver"
    - name: "repeat_visit_count"
      expr: SUM(CASE WHEN repeat_visit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of work orders requiring repeat visits - quality metric indicating rework and inefficiency"
    - name: "escalation_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated work orders - service quality and complexity metric for resource planning"
    - name: "completed_work_orders"
      expr: SUM(CASE WHEN work_order_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed work orders - throughput metric for operational performance tracking"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across work orders - service commitment baseline for performance evaluation"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_dispatch_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispatch and field service execution metrics including response times, arrival performance, SLA compliance, and emergency handling that drive real-time operational decisions and customer experience."
  source: "`telecommunication_ecm`.`workforce`.`dispatch_event`"
  dimensions:
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the dispatch event (dispatched, acknowledged, en route, arrived, completed, cancelled)"
    - name: "dispatch_type"
      expr: dispatch_type
      comment: "Type classification of the dispatch (scheduled, emergency, reactive, proactive, etc.)"
    - name: "dispatch_priority"
      expr: dispatch_priority
      comment: "Priority level assigned to the dispatch (critical, high, medium, low)"
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Indicates whether the dispatch is classified as an emergency"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the dispatch breached its SLA target"
    - name: "after_hours_flag"
      expr: after_hours_flag
      comment: "Indicates whether the dispatch occurred outside normal business hours"
    - name: "customer_notification_sent_flag"
      expr: customer_notification_sent_flag
      comment: "Indicates whether customer notification was sent for the dispatch"
    - name: "dispatch_channel"
      expr: dispatch_channel
      comment: "Channel through which the dispatch was initiated (automated, manual, IVR, mobile app, etc.)"
    - name: "dispatch_reason_code"
      expr: dispatch_reason_code
      comment: "Code indicating the reason for the dispatch"
    - name: "dispatch_zone_code"
      expr: dispatch_zone_code
      comment: "Geographic zone code for the dispatch location"
    - name: "dispatch_source_system"
      expr: dispatch_source_system
      comment: "Source system that originated the dispatch event"
  measures:
    - name: "total_dispatch_events"
      expr: COUNT(DISTINCT dispatch_event_id)
      comment: "Total count of unique dispatch events - fundamental volume metric for field service demand and capacity planning"
    - name: "emergency_dispatch_count"
      expr: SUM(CASE WHEN emergency_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of emergency dispatches - critical service urgency metric for resource allocation and risk management"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dispatches that breached SLA - critical service quality and customer commitment metric"
    - name: "after_hours_dispatch_count"
      expr: SUM(CASE WHEN after_hours_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of after-hours dispatches - cost driver metric for overtime and premium labor planning"
    - name: "completed_dispatch_count"
      expr: SUM(CASE WHEN dispatch_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed dispatches - throughput metric for operational performance tracking"
    - name: "cancelled_dispatch_count"
      expr: SUM(CASE WHEN dispatch_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled dispatches - efficiency metric indicating wasted capacity and scheduling issues"
    - name: "avg_reassignment_count"
      expr: AVG(CAST(reassignment_count AS DOUBLE))
      comment: "Average number of reassignments per dispatch - operational efficiency metric indicating scheduling and skill-matching quality"
    - name: "avg_dispatch_latitude"
      expr: AVG(CAST(dispatch_latitude AS DOUBLE))
      comment: "Average dispatch latitude - geographic distribution metric for territory planning"
    - name: "avg_dispatch_longitude"
      expr: AVG(CAST(dispatch_longitude AS DOUBLE))
      comment: "Average dispatch longitude - geographic distribution metric for territory planning"
    - name: "avg_target_site_latitude"
      expr: AVG(CAST(target_site_latitude AS DOUBLE))
      comment: "Average target site latitude - geographic distribution metric for service coverage analysis"
    - name: "avg_target_site_longitude"
      expr: AVG(CAST(target_site_longitude AS DOUBLE))
      comment: "Average target site longitude - geographic distribution metric for service coverage analysis"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_route_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route planning and optimization metrics including travel efficiency, schedule adherence, fuel consumption, and SLA compliance that drive logistics optimization and cost reduction decisions."
  source: "`telecommunication_ecm`.`workforce`.`route_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the route plan (draft, published, in progress, completed, cancelled)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift for the route plan (day, evening, night, weekend, etc.)"
    - name: "route_priority"
      expr: route_priority
      comment: "Priority level assigned to the route plan"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the route plan met SLA commitments"
    - name: "optimization_algorithm"
      expr: optimization_algorithm
      comment: "Algorithm used to optimize the route plan"
    - name: "service_region_code"
      expr: service_region_code
      comment: "Service region code for the route plan"
    - name: "traffic_conditions_considered"
      expr: traffic_conditions_considered
      comment: "Indicates whether traffic conditions were factored into route planning"
    - name: "weather_conditions_considered"
      expr: weather_conditions_considered
      comment: "Indicates whether weather conditions were factored into route planning"
    - name: "plan_date"
      expr: plan_date
      comment: "Date for which the route plan was created"
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the route plan"
  measures:
    - name: "total_route_plans"
      expr: COUNT(DISTINCT route_plan_id)
      comment: "Total count of unique route plans - fundamental volume metric for logistics planning and optimization"
    - name: "total_distance_km"
      expr: SUM(CAST(total_distance_km AS DOUBLE))
      comment: "Total planned distance in kilometers - key logistics cost and environmental impact metric"
    - name: "avg_distance_km_per_route"
      expr: AVG(CAST(total_distance_km AS DOUBLE))
      comment: "Average planned distance per route - route efficiency metric for optimization benchmarking"
    - name: "total_actual_distance_km"
      expr: SUM(CAST(actual_distance_km AS DOUBLE))
      comment: "Total actual distance traveled in kilometers - realized logistics cost metric for variance analysis"
    - name: "avg_actual_distance_km_per_route"
      expr: AVG(CAST(actual_distance_km AS DOUBLE))
      comment: "Average actual distance per route - realized route efficiency metric"
    - name: "total_fuel_estimate_liters"
      expr: SUM(CAST(fuel_estimate_liters AS DOUBLE))
      comment: "Total estimated fuel consumption in liters - critical cost and environmental sustainability metric"
    - name: "avg_fuel_estimate_liters_per_route"
      expr: AVG(CAST(fuel_estimate_liters AS DOUBLE))
      comment: "Average estimated fuel per route - fuel efficiency metric for cost optimization"
    - name: "avg_optimization_score"
      expr: AVG(CAST(optimization_score AS DOUBLE))
      comment: "Average route optimization score - algorithm effectiveness metric for continuous improvement"
    - name: "avg_deviation_percentage"
      expr: AVG(CAST(deviation_percentage AS DOUBLE))
      comment: "Average deviation from planned route - execution quality metric indicating planning accuracy"
    - name: "sla_compliant_routes"
      expr: SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of routes that met SLA commitments - service quality and customer commitment metric"
    - name: "completed_route_plans"
      expr: SUM(CASE WHEN plan_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed route plans - throughput metric for operational performance"
    - name: "cancelled_route_plans"
      expr: SUM(CASE WHEN plan_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled route plans - efficiency metric indicating planning waste and disruption"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification and compliance metrics including certification status, expiry tracking, cost, and regulatory compliance that drive workforce readiness and risk management decisions."
  source: "`telecommunication_ecm`.`workforce`.`certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (active, expired, pending, suspended, etc.)"
    - name: "certification_level"
      expr: certification_level
      comment: "Level or tier of the certification (basic, intermediate, advanced, expert, etc.)"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority or organization that issued the certification"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor name for vendor-specific certifications"
    - name: "vendor_specific_flag"
      expr: vendor_specific_flag
      comment: "Indicates whether the certification is vendor-specific"
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether the certification is mandated by regulation"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the certification is currently in compliance"
    - name: "verification_status"
      expr: verification_status
      comment: "Status of certification verification (verified, pending, failed, etc.)"
    - name: "reimbursement_status"
      expr: reimbursement_status
      comment: "Status of cost reimbursement for the certification"
    - name: "work_type_eligibility"
      expr: work_type_eligibility
      comment: "Types of work the certification qualifies the technician to perform"
    - name: "issue_date"
      expr: issue_date
      comment: "Date the certification was issued"
    - name: "expiry_date"
      expr: expiry_date
      comment: "Date the certification expires"
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total count of unique certifications - workforce capability and compliance coverage metric"
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications - workforce development investment metric for budget planning"
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification - cost efficiency metric for training investment optimization"
    - name: "total_cpd_hours_earned"
      expr: SUM(CAST(cpd_hours_earned AS DOUBLE))
      comment: "Total continuing professional development hours earned - workforce development and compliance metric"
    - name: "avg_cpd_hours_per_certification"
      expr: AVG(CAST(cpd_hours_earned AS DOUBLE))
      comment: "Average CPD hours per certification - professional development intensity metric"
    - name: "active_certifications"
      expr: SUM(CASE WHEN certification_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active certifications - current workforce capability and readiness metric"
    - name: "expired_certifications"
      expr: SUM(CASE WHEN certification_status = 'expired' THEN 1 ELSE 0 END)
      comment: "Count of expired certifications - compliance risk and workforce capability gap metric"
    - name: "regulatory_mandated_certifications"
      expr: SUM(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of regulatory-mandated certifications - compliance obligation and risk management metric"
    - name: "compliant_certifications"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certifications currently in compliance - regulatory adherence and risk mitigation metric"
    - name: "vendor_specific_certifications"
      expr: SUM(CASE WHEN vendor_specific_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendor-specific certifications - technology partnership and capability specialization metric"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_field_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field vehicle fleet management metrics including utilization, maintenance costs, fuel efficiency, and compliance that drive fleet optimization and cost reduction decisions."
  source: "`telecommunication_ecm`.`workforce`.`field_vehicle`"
  dimensions:
    - name: "vehicle_status"
      expr: vehicle_status
      comment: "Current operational status of the vehicle (active, maintenance, retired, etc.)"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type classification of the vehicle (van, truck, car, specialized, etc.)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel used by the vehicle (diesel, petrol, electric, hybrid, etc.)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model for the vehicle (owned, leased, rented, etc.)"
    - name: "make"
      expr: make
      comment: "Vehicle manufacturer make"
    - name: "model"
      expr: model
      comment: "Vehicle model"
    - name: "model_year"
      expr: model_year
      comment: "Year the vehicle model was manufactured"
    - name: "gps_tracking_enabled"
      expr: gps_tracking_enabled
      comment: "Indicates whether GPS tracking is enabled on the vehicle"
    - name: "current_assignment_type"
      expr: current_assignment_type
      comment: "Type of current vehicle assignment (dedicated, pool, temporary, etc.)"
    - name: "acquisition_date"
      expr: acquisition_date
      comment: "Date the vehicle was acquired"
  measures:
    - name: "total_field_vehicles"
      expr: COUNT(DISTINCT field_vehicle_id)
      comment: "Total count of unique field vehicles - fleet size metric for capacity planning and asset management"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fleet - capital investment metric for financial planning and asset valuation"
    - name: "avg_acquisition_cost_per_vehicle"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per vehicle - procurement efficiency metric for fleet investment optimization"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost across fleet - critical operating expense metric for cost management and budgeting"
    - name: "avg_maintenance_cost_per_vehicle"
      expr: AVG(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Average maintenance cost per vehicle - fleet reliability and cost efficiency metric for lifecycle management"
    - name: "avg_odometer_reading"
      expr: AVG(CAST(odometer_reading AS DOUBLE))
      comment: "Average odometer reading across fleet - utilization and age metric for replacement planning"
    - name: "avg_fuel_consumption_per_100km"
      expr: AVG(CAST(average_fuel_consumption_per_100km AS DOUBLE))
      comment: "Average fuel consumption per 100km - fuel efficiency metric for cost optimization and environmental impact"
    - name: "avg_load_capacity_kg"
      expr: AVG(CAST(load_capacity_kg AS DOUBLE))
      comment: "Average load capacity in kilograms - fleet capability metric for operational planning"
    - name: "avg_gross_vehicle_weight_kg"
      expr: AVG(CAST(gross_vehicle_weight_kg AS DOUBLE))
      comment: "Average gross vehicle weight in kilograms - fleet composition metric for regulatory compliance"
    - name: "active_vehicles"
      expr: SUM(CASE WHEN vehicle_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active vehicles - available fleet capacity metric for operational readiness"
    - name: "gps_enabled_vehicles"
      expr: SUM(CASE WHEN gps_tracking_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of GPS-enabled vehicles - fleet visibility and management capability metric"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`workforce_technician_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Technician scheduling and labor utilization metrics including planned vs actual hours, overtime, leave patterns, and schedule adherence that drive workforce optimization and cost control decisions."
  source: "`telecommunication_ecm`.`workforce`.`technician_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the schedule (draft, published, confirmed, completed, cancelled)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift scheduled (day, evening, night, weekend, on-call, etc.)"
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave if applicable (vacation, sick, personal, training, etc.)"
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Indicates whether the schedule is eligible for overtime pay"
    - name: "overtime_pay_classification"
      expr: overtime_pay_classification
      comment: "Classification for overtime pay calculation (1.5x, 2x, etc.)"
    - name: "overtime_reason_code"
      expr: overtime_reason_code
      comment: "Reason code for overtime work"
    - name: "dispatch_system_sync_flag"
      expr: dispatch_system_sync_flag
      comment: "Indicates whether schedule is synced with dispatch system"
    - name: "payroll_system_sync_flag"
      expr: payroll_system_sync_flag
      comment: "Indicates whether schedule is synced with payroll system"
    - name: "schedule_change_reason"
      expr: schedule_change_reason
      comment: "Reason for schedule change if applicable"
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date for which the schedule applies"
  measures:
    - name: "total_schedules"
      expr: COUNT(DISTINCT technician_schedule_id)
      comment: "Total count of unique technician schedules - workforce planning volume metric"
    - name: "total_planned_work_hours"
      expr: SUM(CAST(planned_work_hours AS DOUBLE))
      comment: "Total planned work hours - workforce capacity planning and labor budget metric"
    - name: "avg_planned_work_hours"
      expr: AVG(CAST(planned_work_hours AS DOUBLE))
      comment: "Average planned work hours per schedule - standard workload metric for scheduling optimization"
    - name: "total_actual_work_hours"
      expr: SUM(CAST(actual_work_hours AS DOUBLE))
      comment: "Total actual work hours - realized labor utilization and payroll cost metric"
    - name: "avg_actual_work_hours"
      expr: AVG(CAST(actual_work_hours AS DOUBLE))
      comment: "Average actual work hours per schedule - realized workload and productivity metric"
    - name: "total_planned_overtime_hours"
      expr: SUM(CAST(planned_overtime_hours AS DOUBLE))
      comment: "Total planned overtime hours - anticipated premium labor cost metric for budget planning"
    - name: "avg_planned_overtime_hours"
      expr: AVG(CAST(planned_overtime_hours AS DOUBLE))
      comment: "Average planned overtime per schedule - overtime intensity metric for cost management"
    - name: "total_actual_overtime_hours"
      expr: SUM(CAST(actual_overtime_hours AS DOUBLE))
      comment: "Total actual overtime hours - realized premium labor cost and capacity constraint metric"
    - name: "avg_actual_overtime_hours"
      expr: AVG(CAST(actual_overtime_hours AS DOUBLE))
      comment: "Average actual overtime per schedule - realized overtime intensity and cost driver"
    - name: "avg_shift_duration_hours"
      expr: AVG(CAST(shift_duration_hours AS DOUBLE))
      comment: "Average shift duration in hours - workforce scheduling pattern metric"
    - name: "confirmed_schedules"
      expr: SUM(CASE WHEN schedule_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Count of confirmed schedules - workforce commitment and planning certainty metric"
    - name: "cancelled_schedules"
      expr: SUM(CASE WHEN schedule_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled schedules - scheduling disruption and inefficiency metric"
$$;