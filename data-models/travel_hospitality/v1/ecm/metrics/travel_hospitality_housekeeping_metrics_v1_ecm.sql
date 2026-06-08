-- Metric views for domain: housekeeping | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_cleaning_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core housekeeping task execution metrics tracking productivity, quality, and operational efficiency"
  source: "`travel_hospitality_ecm`.`housekeeping`.`cleaning_task`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the cleaning task (completed, in-progress, pending, cancelled)"
    - name: "task_type"
      expr: task_type
      comment: "Type of cleaning task (standard clean, deep clean, turndown, special request)"
    - name: "service_type"
      expr: service_type
      comment: "Service type classification for the task"
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task (high, medium, low)"
    - name: "room_type_code"
      expr: room_type_code
      comment: "Room type code for segmentation analysis"
    - name: "task_date"
      expr: DATE_TRUNC('day', scheduled_start_time)
      comment: "Date of the scheduled task for time-series analysis"
    - name: "task_month"
      expr: DATE_TRUNC('month', scheduled_start_time)
      comment: "Month of the scheduled task for trend analysis"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether the task had exceptions or deviations from standard"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the task met SLA targets"
    - name: "guest_request_flag"
      expr: guest_request_flag
      comment: "Whether the task was triggered by a guest request"
    - name: "inspection_required"
      expr: inspection_required
      comment: "Whether quality inspection is required for this task"
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total number of cleaning tasks executed"
    - name: "total_task_credits"
      expr: SUM(CAST(credit_weight AS DOUBLE))
      comment: "Total credit weight earned across all tasks for productivity measurement"
    - name: "avg_task_credits"
      expr: AVG(CAST(credit_weight AS DOUBLE))
      comment: "Average credit weight per task"
    - name: "total_supply_quantity_used"
      expr: SUM(CAST(supply_quantity_used AS DOUBLE))
      comment: "Total quantity of supplies consumed across tasks"
    - name: "avg_supply_quantity_per_task"
      expr: AVG(CAST(supply_quantity_used AS DOUBLE))
      comment: "Average supply quantity used per task"
    - name: "sla_compliant_tasks"
      expr: COUNT(CASE WHEN sla_compliance_flag = True THEN 1 END)
      comment: "Number of tasks that met SLA targets"
    - name: "exception_tasks"
      expr: COUNT(CASE WHEN exception_flag = True THEN 1 END)
      comment: "Number of tasks with exceptions or deviations"
    - name: "guest_request_tasks"
      expr: COUNT(CASE WHEN guest_request_flag = True THEN 1 END)
      comment: "Number of tasks triggered by guest requests"
    - name: "maintenance_requests_generated"
      expr: COUNT(CASE WHEN maintenance_request_generated = True THEN 1 END)
      comment: "Number of tasks that generated maintenance requests"
    - name: "unique_attendants"
      expr: COUNT(DISTINCT attendant_id)
      comment: "Number of unique attendants who performed tasks"
    - name: "unique_rooms_serviced"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of unique rooms serviced"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality inspection metrics tracking cleanliness standards, deficiency rates, and inspection outcomes"
  source: "`travel_hospitality_ecm`.`housekeeping`.`inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (completed, pending, in-progress)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (routine, spot-check, pre-arrival, post-departure)"
    - name: "outcome"
      expr: outcome
      comment: "Inspection outcome (pass, fail, conditional pass)"
    - name: "inspection_date"
      expr: DATE_TRUNC('day', scheduled_date)
      comment: "Date of the scheduled inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled inspection for trend analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the inspection"
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether the inspection is for a VIP room"
    - name: "reclean_required_flag"
      expr: reclean_required_flag
      comment: "Whether the room requires re-cleaning"
    - name: "maintenance_issue_flag"
      expr: maintenance_issue_flag
      comment: "Whether maintenance issues were identified"
    - name: "room_status_before"
      expr: room_status_before
      comment: "Room status before inspection"
    - name: "room_status_after"
      expr: room_status_after
      comment: "Room status after inspection"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of quality inspections performed"
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score across inspections"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average overall quality score across inspections"
    - name: "total_deficiencies"
      expr: SUM(CAST(deficiency_count AS BIGINT))
      comment: "Total number of deficiencies identified across all inspections"
    - name: "total_critical_deficiencies"
      expr: SUM(CAST(critical_deficiency_count AS BIGINT))
      comment: "Total number of critical deficiencies identified"
    - name: "avg_deficiencies_per_inspection"
      expr: AVG(CAST(deficiency_count AS DOUBLE))
      comment: "Average number of deficiencies per inspection"
    - name: "inspections_requiring_reclean"
      expr: COUNT(CASE WHEN reclean_required_flag = True THEN 1 END)
      comment: "Number of inspections that required re-cleaning"
    - name: "inspections_with_maintenance_issues"
      expr: COUNT(CASE WHEN maintenance_issue_flag = True THEN 1 END)
      comment: "Number of inspections that identified maintenance issues"
    - name: "vip_inspections"
      expr: COUNT(CASE WHEN vip_flag = True THEN 1 END)
      comment: "Number of inspections for VIP rooms"
    - name: "rooms_released"
      expr: COUNT(CASE WHEN room_release_flag = True THEN 1 END)
      comment: "Number of rooms released for sale after inspection"
    - name: "unique_rooms_inspected"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of unique rooms inspected"
    - name: "unique_inspectors"
      expr: COUNT(DISTINCT inspector_employee_id)
      comment: "Number of unique inspectors who performed inspections"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_inspection_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deficiency tracking metrics for root cause analysis, resolution efficiency, and quality improvement"
  source: "`travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency`"
  dimensions:
    - name: "deficiency_category"
      expr: deficiency_category
      comment: "High-level category of the deficiency (cleanliness, maintenance, amenity, safety)"
    - name: "deficiency_subcategory"
      expr: deficiency_subcategory
      comment: "Detailed subcategory of the deficiency"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the deficiency (critical, major, minor)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status (open, in-progress, resolved, closed)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for deficiency analysis"
    - name: "deficiency_date"
      expr: DATE_TRUNC('day', identified_timestamp)
      comment: "Date when the deficiency was identified"
    - name: "deficiency_month"
      expr: DATE_TRUNC('month', identified_timestamp)
      comment: "Month when the deficiency was identified"
    - name: "guest_impacting_flag"
      expr: guest_impacting_flag
      comment: "Whether the deficiency impacts guest experience"
    - name: "blocks_room_sale_flag"
      expr: blocks_room_sale_flag
      comment: "Whether the deficiency blocks the room from being sold"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the deficiency was escalated"
    - name: "recurring_deficiency_flag"
      expr: recurring_deficiency_flag
      comment: "Whether this is a recurring deficiency"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Whether the deficiency is marked as priority"
  measures:
    - name: "total_deficiencies"
      expr: COUNT(1)
      comment: "Total number of deficiencies identified"
    - name: "total_resolution_cost"
      expr: SUM(CAST(resolution_cost_amount AS DOUBLE))
      comment: "Total cost to resolve all deficiencies"
    - name: "avg_resolution_cost"
      expr: AVG(CAST(resolution_cost_amount AS DOUBLE))
      comment: "Average cost to resolve a deficiency"
    - name: "guest_impacting_deficiencies"
      expr: COUNT(CASE WHEN guest_impacting_flag = True THEN 1 END)
      comment: "Number of deficiencies that impact guest experience"
    - name: "room_blocking_deficiencies"
      expr: COUNT(CASE WHEN blocks_room_sale_flag = True THEN 1 END)
      comment: "Number of deficiencies that block room sales"
    - name: "escalated_deficiencies"
      expr: COUNT(CASE WHEN escalation_flag = True THEN 1 END)
      comment: "Number of deficiencies that were escalated"
    - name: "recurring_deficiencies"
      expr: COUNT(CASE WHEN recurring_deficiency_flag = True THEN 1 END)
      comment: "Number of recurring deficiencies indicating systemic issues"
    - name: "priority_deficiencies"
      expr: COUNT(CASE WHEN priority_flag = True THEN 1 END)
      comment: "Number of priority deficiencies requiring immediate attention"
    - name: "unique_rooms_with_deficiencies"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of unique rooms with identified deficiencies"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_attendant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Housekeeping attendant workforce metrics tracking productivity, performance, and staffing levels"
  source: "`travel_hospitality_ecm`.`housekeeping`.`attendant`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status of the attendant (active, on-leave, terminated)"
    - name: "role_type"
      expr: role_type
      comment: "Role type of the attendant (room attendant, supervisor, inspector)"
    - name: "shift_assignment"
      expr: shift_assignment
      comment: "Shift assignment (morning, afternoon, evening, overnight)"
    - name: "section_assignment"
      expr: section_assignment
      comment: "Section or floor assignment"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the attendant"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the attendant is currently active"
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Whether the attendant is a union member"
    - name: "ada_accommodation_flag"
      expr: ada_accommodation_flag
      comment: "Whether the attendant has ADA accommodations"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the attendant was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('month', hire_date)
      comment: "Month the attendant was hired"
  measures:
    - name: "total_attendants"
      expr: COUNT(1)
      comment: "Total number of housekeeping attendants"
    - name: "active_attendants"
      expr: COUNT(CASE WHEN active_flag = True THEN 1 END)
      comment: "Number of active attendants available for scheduling"
    - name: "avg_credits_per_shift"
      expr: AVG(CAST(average_credits_per_shift AS DOUBLE))
      comment: "Average productivity credits earned per shift across all attendants"
    - name: "total_target_credits"
      expr: SUM(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Total target credits across all attendants for capacity planning"
    - name: "avg_target_credits_per_shift"
      expr: AVG(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Average target credits per shift for performance benchmarking"
    - name: "union_members"
      expr: COUNT(CASE WHEN union_member_flag = True THEN 1 END)
      comment: "Number of union member attendants"
    - name: "attendants_with_ada_accommodation"
      expr: COUNT(CASE WHEN ada_accommodation_flag = True THEN 1 END)
      comment: "Number of attendants with ADA accommodations"
    - name: "unique_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with attendants"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_maintenance_handoff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance handoff metrics tracking issue identification, resolution time, and cross-functional coordination"
  source: "`travel_hospitality_ecm`.`housekeeping`.`maintenance_handoff`"
  dimensions:
    - name: "handoff_status"
      expr: handoff_status
      comment: "Current status of the maintenance handoff (open, assigned, in-progress, completed, closed)"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect or maintenance issue identified"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level of the maintenance issue (critical, high, medium, low)"
    - name: "room_status_impact"
      expr: room_status_impact
      comment: "Impact on room status (out-of-order, out-of-service, available with restrictions)"
    - name: "ffe_category"
      expr: ffe_category
      comment: "Furniture, fixtures, and equipment category"
    - name: "reported_date"
      expr: DATE_TRUNC('day', reported_timestamp)
      comment: "Date when the maintenance issue was reported"
    - name: "reported_month"
      expr: DATE_TRUNC('month', reported_timestamp)
      comment: "Month when the maintenance issue was reported"
    - name: "guest_impacted"
      expr: guest_impacted
      comment: "Whether the issue impacted a guest"
    - name: "safety_hazard"
      expr: safety_hazard
      comment: "Whether the issue is a safety hazard"
    - name: "ada_compliance_issue"
      expr: ada_compliance_issue
      comment: "Whether the issue relates to ADA compliance"
    - name: "requires_vendor"
      expr: requires_vendor
      comment: "Whether external vendor is required for resolution"
    - name: "warranty_applicable"
      expr: warranty_applicable
      comment: "Whether warranty coverage applies"
  measures:
    - name: "total_handoffs"
      expr: COUNT(1)
      comment: "Total number of maintenance handoffs from housekeeping"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost for all maintenance handoffs"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for completed maintenance handoffs"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per maintenance handoff"
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per completed maintenance handoff"
    - name: "guest_impacted_handoffs"
      expr: COUNT(CASE WHEN guest_impacted = True THEN 1 END)
      comment: "Number of maintenance issues that impacted guests"
    - name: "safety_hazard_handoffs"
      expr: COUNT(CASE WHEN safety_hazard = True THEN 1 END)
      comment: "Number of maintenance issues classified as safety hazards"
    - name: "ada_compliance_handoffs"
      expr: COUNT(CASE WHEN ada_compliance_issue = True THEN 1 END)
      comment: "Number of maintenance issues related to ADA compliance"
    - name: "vendor_required_handoffs"
      expr: COUNT(CASE WHEN requires_vendor = True THEN 1 END)
      comment: "Number of maintenance issues requiring external vendor"
    - name: "warranty_applicable_handoffs"
      expr: COUNT(CASE WHEN warranty_applicable = True THEN 1 END)
      comment: "Number of maintenance issues covered by warranty"
    - name: "compensation_offered_handoffs"
      expr: COUNT(CASE WHEN compensation_offered = True THEN 1 END)
      comment: "Number of maintenance issues where guest compensation was offered"
    - name: "unique_rooms_with_issues"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of unique rooms with maintenance issues"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_supply_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply and amenity consumption metrics for inventory management, cost control, and waste reduction"
  source: "`travel_hospitality_ecm`.`housekeeping`.`supply_consumption`"
  dimensions:
    - name: "amenity_type"
      expr: amenity_type
      comment: "Type of amenity or supply consumed"
    - name: "consumption_reason"
      expr: consumption_reason
      comment: "Reason for consumption (standard service, guest request, replenishment, waste)"
    - name: "room_type_code"
      expr: room_type_code
      comment: "Room type code for consumption pattern analysis"
    - name: "guest_segment"
      expr: guest_segment
      comment: "Guest segment for targeted amenity analysis"
    - name: "consumption_date"
      expr: DATE_TRUNC('day', consumption_date)
      comment: "Date of consumption"
    - name: "consumption_month"
      expr: DATE_TRUNC('month', consumption_date)
      comment: "Month of consumption for trend analysis"
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which consumption occurred"
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Occupancy status of the room at time of consumption"
    - name: "guest_charged_indicator"
      expr: guest_charged_indicator
      comment: "Whether the guest was charged for the consumption"
    - name: "waste_indicator"
      expr: waste_indicator
      comment: "Whether the consumption represents waste"
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Whether the supply is sustainability certified"
    - name: "reorder_triggered"
      expr: reorder_triggered
      comment: "Whether consumption triggered a reorder"
  measures:
    - name: "total_consumption_events"
      expr: COUNT(1)
      comment: "Total number of supply consumption events"
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total quantity of supplies consumed"
    - name: "total_consumption_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all supply consumption"
    - name: "avg_consumption_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per consumption event"
    - name: "total_guest_charges"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total amount charged to guests for supply consumption"
    - name: "avg_quantity_per_event"
      expr: AVG(CAST(quantity_consumed AS DOUBLE))
      comment: "Average quantity consumed per event"
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance from par levels indicating over/under stocking"
    - name: "waste_events"
      expr: COUNT(CASE WHEN waste_indicator = True THEN 1 END)
      comment: "Number of consumption events classified as waste"
    - name: "guest_charged_events"
      expr: COUNT(CASE WHEN guest_charged_indicator = True THEN 1 END)
      comment: "Number of consumption events charged to guests"
    - name: "reorder_triggered_events"
      expr: COUNT(CASE WHEN reorder_triggered = True THEN 1 END)
      comment: "Number of consumption events that triggered reorders"
    - name: "sustainability_certified_events"
      expr: COUNT(CASE WHEN sustainability_certified = True THEN 1 END)
      comment: "Number of consumption events using sustainability certified supplies"
    - name: "unique_rooms_serviced"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of unique rooms with supply consumption"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_laundry_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laundry operations metrics tracking order volume, turnaround time, cost efficiency, and vendor performance"
  source: "`travel_hospitality_ecm`.`housekeeping`.`laundry_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the laundry order (submitted, in-process, completed, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of laundry order (guest, house, event, spa)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order (rush, standard, bulk)"
    - name: "processing_location"
      expr: processing_location
      comment: "Location where laundry is processed (on-site, off-site vendor)"
    - name: "pricing_method"
      expr: pricing_method
      comment: "Pricing method (per-item, per-pound, flat-rate)"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection status (passed, failed, pending)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the order"
    - name: "submission_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date when the order was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month when the order was submitted"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the order met SLA turnaround time"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of laundry orders processed"
    - name: "total_laundry_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all laundry orders"
    - name: "avg_order_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per laundry order"
    - name: "total_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight of laundry processed in pounds"
    - name: "avg_weight_per_order"
      expr: AVG(CAST(total_weight_lbs AS DOUBLE))
      comment: "Average weight per laundry order in pounds"
    - name: "total_item_count"
      expr: SUM(CAST(total_item_count AS BIGINT))
      comment: "Total number of items processed across all orders"
    - name: "avg_items_per_order"
      expr: AVG(CAST(total_item_count AS DOUBLE))
      comment: "Average number of items per order"
    - name: "avg_turnaround_time_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours from submission to return"
    - name: "avg_cost_per_pound"
      expr: AVG(CAST(cost_per_pound AS DOUBLE))
      comment: "Average cost per pound of laundry"
    - name: "avg_cost_per_item"
      expr: AVG(CAST(cost_per_item AS DOUBLE))
      comment: "Average cost per item processed"
    - name: "sla_compliant_orders"
      expr: COUNT(CASE WHEN sla_compliance_flag = True THEN 1 END)
      comment: "Number of orders that met SLA turnaround time"
    - name: "unique_vendors"
      expr: COUNT(DISTINCT processing_vendor_id)
      comment: "Number of unique vendors processing laundry"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_deep_clean_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deep cleaning program metrics tracking execution, labor efficiency, cost management, and quality compliance"
  source: "`travel_hospitality_ecm`.`housekeeping`.`deep_clean_plan`"
  dimensions:
    - name: "deep_clean_plan_status"
      expr: deep_clean_plan_status
      comment: "Current status of the deep clean plan (scheduled, in-progress, completed, cancelled)"
    - name: "area_type"
      expr: area_type
      comment: "Type of area being deep cleaned (guest room, public area, back-of-house, function space)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the deep clean plan"
    - name: "rotation_cycle"
      expr: rotation_cycle
      comment: "Rotation cycle for the deep clean (quarterly, semi-annual, annual)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status after deep clean completion"
    - name: "planned_date"
      expr: DATE_TRUNC('day', planned_date)
      comment: "Planned date for the deep clean"
    - name: "planned_month"
      expr: DATE_TRUNC('month', planned_date)
      comment: "Planned month for the deep clean"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether quality inspection is required"
    - name: "maintenance_issues_identified"
      expr: maintenance_issues_identified
      comment: "Whether maintenance issues were identified during deep clean"
    - name: "pip_compliance_flag"
      expr: pip_compliance_flag
      comment: "Whether the deep clean complies with property improvement plan"
    - name: "ffe_inspection_performed"
      expr: ffe_inspection_performed
      comment: "Whether furniture, fixtures, and equipment inspection was performed"
  measures:
    - name: "total_deep_clean_plans"
      expr: COUNT(1)
      comment: "Total number of deep clean plans scheduled or executed"
    - name: "total_deep_clean_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all deep cleaning activities"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for deep cleaning"
    - name: "total_supply_cost"
      expr: SUM(CAST(supply_cost AS DOUBLE))
      comment: "Total supply cost for deep cleaning"
    - name: "avg_deep_clean_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per deep clean plan"
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours for all deep clean plans"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours spent on deep cleaning"
    - name: "avg_estimated_labor_hours"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per deep clean plan"
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per deep clean plan"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all deep clean plans"
    - name: "plans_with_maintenance_issues"
      expr: COUNT(CASE WHEN maintenance_issues_identified = True THEN 1 END)
      comment: "Number of deep clean plans that identified maintenance issues"
    - name: "pip_compliant_plans"
      expr: COUNT(CASE WHEN pip_compliance_flag = True THEN 1 END)
      comment: "Number of deep clean plans compliant with property improvement plan"
    - name: "unique_rooms_deep_cleaned"
      expr: COUNT(DISTINCT room_id)
      comment: "Number of unique rooms that received deep cleaning"
$$;