-- Metric views for domain: production | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production work order KPIs tracking order fulfillment, cost efficiency, and delivery performance across factories and styles"
  source: "`apparel_fashion_ecm`.`production`.`work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g., planned, in_progress, completed, cancelled)"
    - name: "work_order_number"
      expr: work_order_number
      comment: "Unique work order identifier for tracking"
    - name: "priority"
      expr: priority
      comment: "Work order priority level for capacity planning and scheduling"
    - name: "cmt_type"
      expr: cmt_type
      comment: "Cut-Make-Trim production type (e.g., CMT, FOB, FPP)"
    - name: "shipping_mode"
      expr: shipping_mode
      comment: "Shipping method (air, sea, express) impacting lead time and cost"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade compliance and logistics planning"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome (passed, failed, pending)"
    - name: "aql_level"
      expr: aql_level
      comment: "Acceptable Quality Limit level applied to the work order"
    - name: "compliance_certification_required"
      expr: compliance_certification_required
      comment: "Whether compliance certification is required for this order"
    - name: "production_year"
      expr: YEAR(production_start_date)
      comment: "Year of production start for trend analysis"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_start_date)
      comment: "Month of production start for seasonal planning"
    - name: "requested_delivery_year"
      expr: YEAR(requested_delivery_date)
      comment: "Year of requested delivery for demand forecasting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost and pricing analysis"
  measures:
    - name: "total_work_orders"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Total number of unique work orders for volume tracking"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total units ordered across all work orders"
    - name: "total_produced_quantity"
      expr: SUM(CAST(produced_quantity AS DOUBLE))
      comment: "Total units produced across all work orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total units confirmed for production"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total units rejected due to quality issues"
    - name: "total_production_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total production cost across all work orders for budget tracking"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost per unit for cost efficiency analysis"
    - name: "production_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(produced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity successfully produced, key production efficiency KPI"
    - name: "quality_rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced units rejected, critical quality performance indicator"
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_ex_factory_date <= target_ex_factory_date THEN 1 END)
      comment: "Count of work orders delivered on or before target ex-factory date"
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_ex_factory_date > target_ex_factory_date THEN 1 END)
      comment: "Count of work orders delivered after target ex-factory date"
    - name: "avg_production_lead_time_days"
      expr: AVG(DATEDIFF(production_end_date, production_start_date))
      comment: "Average number of days from production start to end, key cycle time metric"
    - name: "avg_delivery_variance_days"
      expr: AVG(DATEDIFF(actual_ex_factory_date, target_ex_factory_date))
      comment: "Average days variance between actual and target ex-factory date (negative = early, positive = late)"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production lot-level quality, yield, and efficiency metrics for operational control and continuous improvement"
  source: "`apparel_fashion_ecm`.`production`.`lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the production lot (e.g., in_progress, completed, on_hold)"
    - name: "lot_number"
      expr: lot_number
      comment: "Unique lot identifier for traceability"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of production lot (e.g., regular, rework, sample)"
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the lot"
    - name: "aql_level"
      expr: aql_level
      comment: "Acceptable Quality Limit level applied to the lot"
    - name: "cmt_type"
      expr: cmt_type
      comment: "Cut-Make-Trim production type for the lot"
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift for labor efficiency analysis"
    - name: "fabric_shade_lot_number"
      expr: fabric_shade_lot_number
      comment: "Fabric shade lot for color consistency tracking"
    - name: "compliance_certification_required"
      expr: compliance_certification_required
      comment: "Whether compliance certification is required for this lot"
    - name: "production_year"
      expr: YEAR(production_start_date)
      comment: "Year of lot production start"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_start_date)
      comment: "Month of lot production start for trend analysis"
    - name: "cut_year"
      expr: YEAR(cut_date)
      comment: "Year of cutting operation"
  measures:
    - name: "total_lots"
      expr: COUNT(DISTINCT lot_id)
      comment: "Total number of unique production lots"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total units planned across all lots"
    - name: "total_produced_quantity"
      expr: SUM(CAST(produced_quantity AS DOUBLE))
      comment: "Total units produced across all lots"
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total units accepted after quality inspection"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total units rejected due to quality defects"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total units requiring rework to meet quality standards"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total units scrapped as unrecoverable waste"
    - name: "total_critical_defects"
      expr: SUM(CAST(critical_defect_count AS DOUBLE))
      comment: "Total critical defects across all lots"
    - name: "total_major_defects"
      expr: SUM(CAST(major_defect_count AS DOUBLE))
      comment: "Total major defects across all lots"
    - name: "total_minor_defects"
      expr: SUM(CAST(minor_defect_count AS DOUBLE))
      comment: "Total minor defects across all lots"
    - name: "lot_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced units accepted, critical yield efficiency KPI"
    - name: "lot_rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced units rejected, key quality performance indicator"
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced units requiring rework, efficiency loss indicator"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(produced_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of produced units scrapped, waste and cost impact metric"
    - name: "plan_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(produced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity actually produced, production planning accuracy KPI"
    - name: "avg_lot_cycle_time_days"
      expr: AVG(DATEDIFF(production_end_date, production_start_date))
      comment: "Average days from lot start to completion, throughput efficiency metric"
    - name: "avg_sew_cycle_time_days"
      expr: AVG(DATEDIFF(sew_end_date, sew_start_date))
      comment: "Average days for sewing operation, bottleneck identification metric"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_work_order_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operation-level efficiency, labor productivity, and quality metrics for granular production control and continuous improvement"
  source: "`apparel_fashion_ecm`.`production`.`work_order_operation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Current status of the operation (e.g., planned, in_progress, completed, on_hold)"
    - name: "operation_code"
      expr: operation_code
      comment: "Standard operation code for benchmarking and routing"
    - name: "operation_description"
      expr: operation_description
      comment: "Human-readable description of the operation"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality outcome of the operation (passed, failed, pending)"
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether quality inspection is required for this operation"
    - name: "control_key"
      expr: control_key
      comment: "Control key defining operation behavior (e.g., internal, external, rework)"
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift for labor productivity analysis"
    - name: "factory_location_code"
      expr: factory_location_code
      comment: "Factory location for multi-site performance comparison"
    - name: "production_line"
      expr: production_line
      comment: "Production line identifier for line-level efficiency tracking"
    - name: "operation_year"
      expr: YEAR(planned_start_date)
      comment: "Year of planned operation start"
    - name: "operation_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned operation start for trend analysis"
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency for operation cost analysis"
  measures:
    - name: "total_operations"
      expr: COUNT(DISTINCT work_order_operation_id)
      comment: "Total number of unique operations executed"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total units planned across all operations"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total units confirmed as completed"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total units requiring rework at operation level"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total units scrapped at operation level"
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed across all operations"
    - name: "total_machine_hours"
      expr: SUM(CAST(machine_hours AS DOUBLE))
      comment: "Total machine hours consumed across all operations"
    - name: "total_setup_time_minutes"
      expr: SUM(CAST(setup_time_minutes AS DOUBLE))
      comment: "Total setup time in minutes, non-value-added time metric"
    - name: "total_teardown_time_minutes"
      expr: SUM(CAST(teardown_time_minutes AS DOUBLE))
      comment: "Total teardown time in minutes, non-value-added time metric"
    - name: "total_actual_duration_minutes"
      expr: SUM(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Total actual operation duration in minutes"
    - name: "total_operation_cost"
      expr: SUM(CAST(operation_cost_amount AS DOUBLE))
      comment: "Total cost incurred across all operations for budget tracking"
    - name: "avg_efficiency_percentage"
      expr: AVG(CAST(efficiency_percentage AS DOUBLE))
      comment: "Average operation efficiency percentage, key productivity KPI"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average operation yield percentage, quality and waste metric"
    - name: "operation_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity confirmed, operation execution accuracy KPI"
    - name: "operation_rework_rate"
      expr: ROUND(100.0 * SUM(CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(confirmed_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of confirmed units requiring rework, quality issue indicator"
    - name: "operation_scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(confirmed_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of confirmed units scrapped, waste and cost impact metric"
    - name: "labor_productivity_units_per_hour"
      expr: ROUND(SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(labor_hours AS DOUBLE)), 0), 2)
      comment: "Units produced per labor hour, critical labor efficiency KPI"
    - name: "machine_productivity_units_per_hour"
      expr: ROUND(SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(machine_hours AS DOUBLE)), 0), 2)
      comment: "Units produced per machine hour, equipment utilization KPI"
    - name: "avg_cost_per_unit"
      expr: ROUND(SUM(CAST(operation_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(confirmed_quantity AS DOUBLE)), 0), 2)
      comment: "Average cost per unit produced, cost efficiency metric"
    - name: "setup_time_percentage"
      expr: ROUND(100.0 * SUM(CAST(setup_time_minutes AS DOUBLE)) / NULLIF(SUM(CAST(actual_duration_minutes AS DOUBLE)), 0), 2)
      comment: "Setup time as percentage of total duration, changeover efficiency metric"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_factory_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Factory capacity planning and utilization metrics for strategic resource allocation and bottleneck identification"
  source: "`apparel_fashion_ecm`.`production`.`factory_capacity`"
  dimensions:
    - name: "capacity_status"
      expr: capacity_status
      comment: "Current capacity status (e.g., available, fully_booked, overbooked)"
    - name: "booking_status"
      expr: booking_status
      comment: "Booking status for capacity planning (e.g., open, closed, restricted)"
    - name: "planning_period_type"
      expr: planning_period_type
      comment: "Type of planning period (e.g., weekly, monthly, quarterly)"
    - name: "department_code"
      expr: department_code
      comment: "Department code for departmental capacity analysis"
    - name: "capacity_allocation_priority"
      expr: capacity_allocation_priority
      comment: "Priority level for capacity allocation decisions"
    - name: "capacity_unit_of_measure"
      expr: capacity_unit_of_measure
      comment: "Unit of measure for capacity (e.g., units, hours, pieces)"
    - name: "is_active"
      expr: is_active
      comment: "Whether the capacity record is currently active"
    - name: "planning_year"
      expr: YEAR(planning_period_start_date)
      comment: "Year of planning period start"
    - name: "planning_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Month of planning period start for seasonal capacity planning"
  measures:
    - name: "total_capacity_records"
      expr: COUNT(DISTINCT factory_capacity_id)
      comment: "Total number of capacity planning records"
    - name: "total_capacity_units"
      expr: SUM(CAST(total_capacity_units AS DOUBLE))
      comment: "Total capacity units available across all factories and periods"
    - name: "total_allocated_capacity_units"
      expr: SUM(CAST(allocated_capacity_units AS DOUBLE))
      comment: "Total capacity units allocated to work orders"
    - name: "total_available_capacity_units"
      expr: SUM(CAST(available_capacity_units AS DOUBLE))
      comment: "Total capacity units still available for booking"
    - name: "total_reserved_capacity_units"
      expr: SUM(CAST(reserved_capacity_units AS DOUBLE))
      comment: "Total capacity units reserved for future orders"
    - name: "total_available_labor_hours"
      expr: SUM(CAST(available_labor_hours AS DOUBLE))
      comment: "Total labor hours available for production"
    - name: "total_available_machine_hours"
      expr: SUM(CAST(available_machine_hours AS DOUBLE))
      comment: "Total machine hours available for production"
    - name: "total_overtime_hours_available"
      expr: SUM(CAST(overtime_hours_available AS DOUBLE))
      comment: "Total overtime hours available for surge capacity"
    - name: "total_planned_downtime_hours"
      expr: SUM(CAST(planned_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours for maintenance and holidays"
    - name: "avg_utilization_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average capacity utilization rate, critical resource efficiency KPI"
    - name: "avg_efficiency_rate_percent"
      expr: AVG(CAST(efficiency_rate_percent AS DOUBLE))
      comment: "Average factory efficiency rate, productivity benchmark metric"
    - name: "capacity_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(allocated_capacity_units AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_units AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity allocated, strategic capacity planning KPI"
    - name: "capacity_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(available_capacity_units AS DOUBLE)) / NULLIF(SUM(CAST(total_capacity_units AS DOUBLE)), 0), 2)
      comment: "Percentage of total capacity still available for booking"
    - name: "avg_capacity_buffer_percent"
      expr: AVG(CAST(capacity_buffer_percent AS DOUBLE))
      comment: "Average capacity buffer percentage for risk management"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for capacity booking"
    - name: "avg_workforce_headcount"
      expr: AVG(CAST(workforce_headcount AS DOUBLE))
      comment: "Average workforce headcount for labor planning"
    - name: "avg_machine_count"
      expr: AVG(CAST(machine_count AS DOUBLE))
      comment: "Average machine count for equipment planning"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production schedule adherence and on-time performance metrics for operational excellence and customer satisfaction"
  source: "`apparel_fashion_ecm`.`production`.`schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current schedule status (e.g., planned, active, completed, delayed)"
    - name: "schedule_number"
      expr: schedule_number
      comment: "Unique schedule identifier for tracking"
    - name: "priority_level"
      expr: priority_level
      comment: "Schedule priority level for resource allocation"
    - name: "production_type"
      expr: production_type
      comment: "Type of production (e.g., make_to_order, make_to_stock)"
    - name: "production_method"
      expr: production_method
      comment: "Production method (e.g., batch, continuous, lean)"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Whether this schedule is on the critical path for delivery"
    - name: "otif_target_flag"
      expr: otif_target_flag
      comment: "Whether this schedule is targeted for on-time-in-full delivery"
    - name: "planning_group"
      expr: planning_group
      comment: "Planning group for organizational segmentation"
    - name: "change_reason"
      expr: change_reason
      comment: "Reason for schedule change (e.g., material_delay, capacity_constraint)"
    - name: "schedule_year"
      expr: YEAR(planned_sew_start_date)
      comment: "Year of planned sew start"
    - name: "schedule_month"
      expr: DATE_TRUNC('MONTH', planned_sew_start_date)
      comment: "Month of planned sew start for seasonal analysis"
  measures:
    - name: "total_schedules"
      expr: COUNT(DISTINCT schedule_id)
      comment: "Total number of production schedules"
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total units scheduled for production"
    - name: "avg_factory_capacity_utilization_pct"
      expr: AVG(CAST(factory_capacity_utilization_pct AS DOUBLE))
      comment: "Average factory capacity utilization percentage, resource efficiency KPI"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days from schedule to delivery"
    - name: "on_time_cut_count"
      expr: COUNT(CASE WHEN actual_cut_date <= planned_cut_date THEN 1 END)
      comment: "Count of schedules where cutting was completed on or before plan"
    - name: "late_cut_count"
      expr: COUNT(CASE WHEN actual_cut_date > planned_cut_date THEN 1 END)
      comment: "Count of schedules where cutting was delayed"
    - name: "on_time_sew_start_count"
      expr: COUNT(CASE WHEN actual_sew_start_date <= planned_sew_start_date THEN 1 END)
      comment: "Count of schedules where sewing started on or before plan"
    - name: "on_time_sew_end_count"
      expr: COUNT(CASE WHEN actual_sew_end_date <= planned_sew_end_date THEN 1 END)
      comment: "Count of schedules where sewing completed on or before plan"
    - name: "on_time_finishing_count"
      expr: COUNT(CASE WHEN actual_finishing_date <= planned_finishing_date THEN 1 END)
      comment: "Count of schedules where finishing completed on or before plan"
    - name: "on_time_ex_factory_count"
      expr: COUNT(CASE WHEN actual_ex_factory_date <= planned_ex_factory_date THEN 1 END)
      comment: "Count of schedules shipped on or before planned ex-factory date, critical OTIF KPI"
    - name: "late_ex_factory_count"
      expr: COUNT(CASE WHEN actual_ex_factory_date > planned_ex_factory_date THEN 1 END)
      comment: "Count of schedules shipped after planned ex-factory date, delivery failure metric"
    - name: "avg_cut_variance_days"
      expr: AVG(DATEDIFF(actual_cut_date, planned_cut_date))
      comment: "Average days variance for cutting operation (negative = early, positive = late)"
    - name: "avg_sew_start_variance_days"
      expr: AVG(DATEDIFF(actual_sew_start_date, planned_sew_start_date))
      comment: "Average days variance for sew start (negative = early, positive = late)"
    - name: "avg_sew_end_variance_days"
      expr: AVG(DATEDIFF(actual_sew_end_date, planned_sew_end_date))
      comment: "Average days variance for sew end (negative = early, positive = late)"
    - name: "avg_finishing_variance_days"
      expr: AVG(DATEDIFF(actual_finishing_date, planned_finishing_date))
      comment: "Average days variance for finishing (negative = early, positive = late)"
    - name: "avg_ex_factory_variance_days"
      expr: AVG(DATEDIFF(actual_ex_factory_date, planned_ex_factory_date))
      comment: "Average days variance for ex-factory shipment, key delivery performance metric"
    - name: "avg_total_cycle_time_days"
      expr: AVG(DATEDIFF(actual_ex_factory_date, actual_sew_start_date))
      comment: "Average total production cycle time from sew start to ex-factory"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_pp_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre-production sample approval and quality metrics for product development cycle time and first-time-right performance"
  source: "`apparel_fashion_ecm`.`production`.`pp_sample`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Overall sample approval status (e.g., approved, rejected, pending, conditional)"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample (e.g., proto, fit, PP, TOP, SMS)"
    - name: "sample_number"
      expr: sample_number
      comment: "Unique sample identifier for tracking"
    - name: "revision_round"
      expr: revision_round
      comment: "Sample revision round number (1st, 2nd, 3rd, etc.)"
    - name: "fabric_approval_status"
      expr: fabric_approval_status
      comment: "Fabric approval status for material quality tracking"
    - name: "fit_approval_status"
      expr: fit_approval_status
      comment: "Fit approval status for pattern accuracy tracking"
    - name: "construction_approval_status"
      expr: construction_approval_status
      comment: "Construction approval status for workmanship quality"
    - name: "trim_approval_status"
      expr: trim_approval_status
      comment: "Trim approval status for accessory quality"
    - name: "labeling_approval_status"
      expr: labeling_approval_status
      comment: "Labeling approval status for compliance and branding"
    - name: "packaging_approval_status"
      expr: packaging_approval_status
      comment: "Packaging approval status for presentation quality"
    - name: "critical_issue_flag"
      expr: critical_issue_flag
      comment: "Whether the sample has critical issues requiring immediate attention"
    - name: "issue_severity"
      expr: issue_severity
      comment: "Severity level of sample issues (e.g., critical, major, minor)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of issue resolution (e.g., resolved, pending, escalated)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of sample submission"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of sample submission for cycle time analysis"
  measures:
    - name: "total_samples"
      expr: COUNT(DISTINCT pp_sample_id)
      comment: "Total number of pre-production samples submitted"
    - name: "approved_samples_count"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END)
      comment: "Count of samples approved on submission"
    - name: "rejected_samples_count"
      expr: COUNT(CASE WHEN approval_status = 'rejected' THEN 1 END)
      comment: "Count of samples rejected requiring resubmission"
    - name: "pending_samples_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN 1 END)
      comment: "Count of samples pending review"
    - name: "critical_issue_samples_count"
      expr: COUNT(CASE WHEN critical_issue_flag = true THEN 1 END)
      comment: "Count of samples with critical issues"
    - name: "first_time_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' AND revision_round = '1' THEN 1 END) / NULLIF(COUNT(CASE WHEN revision_round = '1' THEN 1 END), 0), 2)
      comment: "Percentage of samples approved on first submission, critical product development efficiency KPI"
    - name: "fabric_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fabric_approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(DISTINCT pp_sample_id), 0), 2)
      comment: "Percentage of samples with approved fabric, material quality indicator"
    - name: "fit_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fit_approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(DISTINCT pp_sample_id), 0), 2)
      comment: "Percentage of samples with approved fit, pattern accuracy indicator"
    - name: "construction_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN construction_approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(DISTINCT pp_sample_id), 0), 2)
      comment: "Percentage of samples with approved construction, workmanship quality indicator"
    - name: "trim_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN trim_approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(DISTINCT pp_sample_id), 0), 2)
      comment: "Percentage of samples with approved trim, accessory quality indicator"
    - name: "avg_approval_cycle_time_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average days from sample submission to approval, product development speed metric"
    - name: "avg_review_cycle_time_days"
      expr: AVG(DATEDIFF(review_due_date, submission_date))
      comment: "Average days allocated for sample review"
    - name: "avg_time_to_production_days"
      expr: AVG(DATEDIFF(target_production_date, approval_date))
      comment: "Average days from sample approval to target production start"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`production_bulk_fabric_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fabric receipt quality, variance, and inspection metrics for material quality control and supplier performance"
  source: "`apparel_fashion_ecm`.`production`.`bulk_fabric_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of fabric receipt (e.g., received, inspected, approved, rejected)"
    - name: "receipt_number"
      expr: receipt_number
      comment: "Unique receipt identifier for traceability"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status (e.g., passed, failed, pending)"
    - name: "aql_inspection_result"
      expr: aql_inspection_result
      comment: "AQL inspection result (e.g., accept, reject, conditional)"
    - name: "aql_level"
      expr: aql_level
      comment: "Acceptable Quality Limit level applied"
    - name: "color_fastness_result"
      expr: color_fastness_result
      comment: "Color fastness test result for fabric quality"
    - name: "shrinkage_test_result"
      expr: shrinkage_test_result
      comment: "Shrinkage test result for fabric stability"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of fabric defect identified (e.g., weaving, dyeing, finishing)"
    - name: "shade_lot_number"
      expr: shade_lot_number
      comment: "Shade lot number for color consistency tracking"
    - name: "batch_number"
      expr: batch_number
      comment: "Fabric batch number for quality traceability"
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location for inventory management"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for fabric quantity (e.g., yards, meters, kg)"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year of fabric receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of fabric receipt for trend analysis"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of quality inspection"
  measures:
    - name: "total_receipts"
      expr: COUNT(DISTINCT bulk_fabric_receipt_id)
      comment: "Total number of fabric receipts"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total fabric quantity ordered"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total fabric quantity received"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total fabric quantity variance (received minus ordered)"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total fabric defects identified across all receipts"
    - name: "total_roll_count"
      expr: SUM(CAST(roll_count AS DOUBLE))
      comment: "Total number of fabric rolls received"
    - name: "avg_shrinkage_percentage_length"
      expr: AVG(CAST(shrinkage_percentage_length AS DOUBLE))
      comment: "Average fabric shrinkage percentage in length direction"
    - name: "avg_shrinkage_percentage_width"
      expr: AVG(CAST(shrinkage_percentage_width AS DOUBLE))
      comment: "Average fabric shrinkage percentage in width direction"
    - name: "receipt_accuracy_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received, supplier delivery accuracy KPI"
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN aql_inspection_result = 'accept' THEN 1 END) / NULLIF(COUNT(DISTINCT bulk_fabric_receipt_id), 0), 2)
      comment: "Percentage of receipts passing AQL inspection, critical material quality KPI"
    - name: "inspection_fail_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN aql_inspection_result = 'reject' THEN 1 END) / NULLIF(COUNT(DISTINCT bulk_fabric_receipt_id), 0), 2)
      comment: "Percentage of receipts failing AQL inspection, supplier quality issue indicator"
    - name: "color_fastness_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN color_fastness_result = 'pass' THEN 1 END) / NULLIF(COUNT(DISTINCT bulk_fabric_receipt_id), 0), 2)
      comment: "Percentage of receipts passing color fastness test"
    - name: "shrinkage_test_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN shrinkage_test_result = 'pass' THEN 1 END) / NULLIF(COUNT(DISTINCT bulk_fabric_receipt_id), 0), 2)
      comment: "Percentage of receipts passing shrinkage test"
    - name: "avg_defect_rate_per_receipt"
      expr: AVG(CAST(defect_count AS DOUBLE))
      comment: "Average number of defects per fabric receipt"
    - name: "avg_delivery_variance_days"
      expr: AVG(DATEDIFF(receipt_date, expected_delivery_date))
      comment: "Average days variance between actual and expected delivery (negative = early, positive = late)"
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN receipt_date <= expected_delivery_date THEN 1 END)
      comment: "Count of receipts delivered on or before expected date"
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN receipt_date > expected_delivery_date THEN 1 END)
      comment: "Count of receipts delivered after expected date"
$$;