-- Metric views for domain: housekeeping | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_hk_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for housekeeping assignments — measures assignment throughput, completion quality, reclean rates, credit productivity, and SLA adherence to steer daily housekeeping operations and labor efficiency."
  source: "`travel_hospitality_ecm`.`housekeeping`.`hk_assignment`"
  dimensions:
    - name: "assignment_date"
      expr: assignment_date
      comment: "Calendar date of the housekeeping assignment, used for daily and weekly trend analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of housekeeping assignment (e.g., stayover, departure, turndown, deep clean) for workload segmentation."
    - name: "completion_status"
      expr: completion_status
      comment: "Current completion status of the assignment (e.g., completed, pending, skipped) for operational monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the task, enabling triage and escalation analysis."
    - name: "room_status_before"
      expr: room_status_before
      comment: "Room status at the start of the assignment (e.g., dirty, vacant dirty) for workflow analysis."
    - name: "room_status_after"
      expr: room_status_after
      comment: "Room status after assignment completion (e.g., clean, inspected) to measure throughput outcomes."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the post-assignment inspection (e.g., pass, fail, reclean required) for quality tracking."
    - name: "dnd_flag"
      expr: dnd_flag
      comment: "Indicates whether the room had a Do Not Disturb flag active, affecting service delivery rates."
    - name: "linen_change_flag"
      expr: linen_change_flag
      comment: "Indicates whether linen was changed during the assignment, supporting sustainability and cost tracking."
    - name: "maintenance_request_flag"
      expr: maintenance_request_flag
      comment: "Indicates whether a maintenance request was generated during the assignment."
    - name: "special_cleaning_code"
      expr: special_cleaning_code
      comment: "Code identifying special cleaning protocols applied (e.g., VIP, allergy, deep clean)."
    - name: "shift_week"
      expr: DATE_TRUNC('week', assignment_date)
      comment: "ISO week bucket of the assignment date for weekly performance trending."
    - name: "shift_month"
      expr: DATE_TRUNC('month', assignment_date)
      comment: "Month bucket of the assignment date for monthly operational reporting."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of housekeeping assignments — baseline volume metric for staffing and workload planning."
    - name: "completed_assignments"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Count of assignments with a completed status — measures operational throughput."
    - name: "assignment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments completed vs. total assigned — key SLA and productivity KPI for housekeeping leadership."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of inspected assignments that passed quality inspection — directly tied to guest satisfaction and brand standards."
    - name: "reclean_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'reclean' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments requiring a reclean — a leading indicator of cleaning quality and attendant performance issues."
    - name: "maintenance_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_request_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments that generated a maintenance request — signals property condition trends and preventive maintenance needs."
    - name: "dnd_skip_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dnd_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments blocked by Do Not Disturb — impacts service delivery rates and room readiness planning."
    - name: "total_room_credits"
      expr: SUM(CAST(room_credits AS DOUBLE))
      comment: "Total room credits earned across all assignments — the primary labor productivity currency in housekeeping operations."
    - name: "avg_room_credits_per_assignment"
      expr: AVG(CAST(room_credits AS DOUBLE))
      comment: "Average room credits per assignment — measures attendant productivity relative to credit-weighted workload targets."
    - name: "linen_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN linen_change_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments where linen was changed — supports sustainability program tracking and cost-per-occupied-room analysis."
    - name: "reassignment_count_total"
      expr: COUNT(CASE WHEN reassignment_count IS NOT NULL AND reassignment_count != '0' THEN 1 END)
      comment: "Count of assignments that were reassigned at least once — indicates scheduling inefficiency or attendant availability issues."
    - name: "amenity_replenishment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amenity_replenishment_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments that included amenity replenishment — supports guest experience and supply cost management."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality assurance KPIs derived from room and space inspections — measures cleanliness scores, deficiency rates, reclean requirements, and inspection throughput to drive brand standard compliance and guest satisfaction."
  source: "`travel_hospitality_ecm`.`housekeeping`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., routine, VIP, pre-arrival, post-departure) for quality segmentation."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g., completed, pending, failed) for pipeline monitoring."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the inspection (e.g., pass, fail, reclean) — primary quality disposition dimension."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the inspection, enabling escalation and triage analysis."
    - name: "reclean_required_flag"
      expr: reclean_required_flag
      comment: "Indicates whether the inspection resulted in a reclean requirement — key quality failure indicator."
    - name: "maintenance_issue_flag"
      expr: maintenance_issue_flag
      comment: "Indicates whether a maintenance issue was identified during inspection."
    - name: "room_release_flag"
      expr: room_release_flag
      comment: "Indicates whether the room was released for sale following the inspection — impacts revenue availability."
    - name: "linen_quality_flag"
      expr: linen_quality_flag
      comment: "Indicates whether linen quality met standards during inspection."
    - name: "bathroom_quality_flag"
      expr: bathroom_quality_flag
      comment: "Indicates whether bathroom cleanliness met standards during inspection."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date of the inspection for daily and weekly quality trend analysis."
    - name: "scheduled_week"
      expr: DATE_TRUNC('week', scheduled_date)
      comment: "ISO week bucket of the scheduled inspection date for weekly quality trending."
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month bucket of the scheduled inspection date for monthly quality reporting."
    - name: "guest_arrival_date"
      expr: guest_arrival_date
      comment: "Guest arrival date associated with the inspection — enables pre-arrival quality analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted — baseline volume metric for quality program coverage."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score across all inspections — primary quality KPI tracked by housekeeping leadership and brand standards teams."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average overall quality score across inspections — composite quality indicator used in brand compliance reporting."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with a passing outcome — headline quality KPI for executive dashboards and brand audits."
    - name: "reclean_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reclean_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring a reclean — a leading indicator of cleaning quality failures and labor rework cost."
    - name: "maintenance_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_issue_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections identifying a maintenance issue — drives preventive maintenance investment decisions."
    - name: "room_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN room_release_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in room release for sale — directly impacts revenue availability and front desk operations."
    - name: "linen_quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN linen_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections where linen quality met standards — supports linen program quality and vendor management decisions."
    - name: "bathroom_quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bathroom_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections where bathroom cleanliness met standards — a top driver of guest satisfaction scores."
    - name: "critical_deficiency_inspection_count"
      expr: COUNT(CASE WHEN critical_deficiency_count IS NOT NULL AND critical_deficiency_count != '0' THEN 1 END)
      comment: "Count of inspections with at least one critical deficiency — flags high-severity quality failures requiring immediate management action."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_inspection_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deficiency-level quality KPIs — measures deficiency volume, severity distribution, resolution speed, escalation rates, and cost of remediation to drive root-cause elimination and brand standard compliance."
  source: "`travel_hospitality_ecm`.`housekeeping`.`inspection_deficiency`"
  dimensions:
    - name: "deficiency_category"
      expr: deficiency_category
      comment: "High-level category of the deficiency (e.g., cleanliness, linen, amenity, maintenance) for root-cause analysis."
    - name: "deficiency_subcategory"
      expr: deficiency_subcategory
      comment: "Subcategory of the deficiency for granular root-cause drill-down."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the deficiency (e.g., critical, major, minor) for prioritization and escalation."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the deficiency (e.g., open, in-progress, resolved) for operational pipeline monitoring."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the deficiency — enables systemic quality improvement initiatives."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the deficiency was escalated — signals high-impact quality failures."
    - name: "guest_impacting_flag"
      expr: guest_impacting_flag
      comment: "Indicates whether the deficiency directly impacted a guest — highest-priority quality dimension."
    - name: "blocks_room_sale_flag"
      expr: blocks_room_sale_flag
      comment: "Indicates whether the deficiency blocked the room from being sold — directly impacts revenue availability."
    - name: "recurring_deficiency_flag"
      expr: recurring_deficiency_flag
      comment: "Indicates whether this is a recurring deficiency — identifies systemic quality failures requiring process intervention."
    - name: "priority_flag"
      expr: priority_flag
      comment: "Indicates whether the deficiency was flagged as high priority for immediate resolution."
    - name: "identified_date"
      expr: DATE_TRUNC('day', identified_timestamp)
      comment: "Day the deficiency was identified — for daily deficiency volume trending."
    - name: "identified_week"
      expr: DATE_TRUNC('week', identified_timestamp)
      comment: "ISO week the deficiency was identified — for weekly quality trend analysis."
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_timestamp)
      comment: "Month the deficiency was identified — for monthly quality reporting and trend analysis."
  measures:
    - name: "total_deficiencies"
      expr: COUNT(1)
      comment: "Total number of deficiencies identified — baseline volume metric for quality program monitoring."
    - name: "guest_impacting_deficiency_count"
      expr: COUNT(CASE WHEN guest_impacting_flag = TRUE THEN 1 END)
      comment: "Count of deficiencies that directly impacted guests — highest-priority quality KPI linked to guest satisfaction scores and service recovery costs."
    - name: "guest_impacting_deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_impacting_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deficiencies that impacted guests — executive-level quality risk indicator."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deficiencies that were escalated — measures severity of quality failures and management intervention frequency."
    - name: "recurring_deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurring_deficiency_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deficiencies that are recurring — identifies systemic process failures requiring root-cause investment."
    - name: "room_blocking_deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN blocks_room_sale_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deficiencies that blocked room sales — directly quantifies revenue impact of quality failures."
    - name: "total_resolution_cost"
      expr: SUM(CAST(resolution_cost_amount AS DOUBLE))
      comment: "Total cost incurred to resolve deficiencies — measures financial impact of quality failures and drives cost-of-quality analysis."
    - name: "avg_resolution_cost"
      expr: AVG(CAST(resolution_cost_amount AS DOUBLE))
      comment: "Average cost to resolve a deficiency — benchmarks remediation efficiency and informs quality investment decisions."
    - name: "open_deficiency_count"
      expr: COUNT(CASE WHEN resolution_status != 'resolved' AND resolution_status IS NOT NULL THEN 1 END)
      comment: "Count of deficiencies not yet resolved — operational backlog metric for housekeeping and engineering management."
    - name: "critical_deficiency_count"
      expr: COUNT(CASE WHEN severity_level = 'critical' THEN 1 END)
      comment: "Count of critical-severity deficiencies — highest-priority quality alert metric for executive and brand compliance reporting."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_cleaning_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Task-level operational KPIs for housekeeping cleaning activities — measures task completion rates, SLA compliance, quality scores, supply consumption, and exception rates to optimize attendant productivity and service delivery."
  source: "`travel_hospitality_ecm`.`housekeeping`.`cleaning_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of cleaning task (e.g., full clean, touch-up, turndown, deep clean) for workload and productivity segmentation."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the cleaning task (e.g., completed, in-progress, skipped) for operational pipeline monitoring."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the task (e.g., stayover, departure, VIP) for demand analysis."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task for triage and scheduling optimization."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the task was completed within SLA target time — key operational performance indicator."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates whether an exception occurred during the task — flags operational disruptions."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Indicates whether the task requires a post-completion inspection."
    - name: "guest_request_flag"
      expr: guest_request_flag
      comment: "Indicates whether the task was triggered by a guest request — measures demand-driven workload."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the task is mandatory per brand or regulatory standards."
    - name: "skip_reason_code"
      expr: skip_reason_code
      comment: "Reason code for skipped tasks — enables analysis of service delivery gaps."
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('day', scheduled_start_time)
      comment: "Day the task was scheduled to start — for daily task volume and SLA trending."
    - name: "scheduled_start_week"
      expr: DATE_TRUNC('week', scheduled_start_time)
      comment: "ISO week the task was scheduled — for weekly productivity analysis."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('month', scheduled_start_time)
      comment: "Month the task was scheduled — for monthly operational reporting."
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total number of cleaning tasks — baseline volume metric for workload planning and staffing decisions."
    - name: "task_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks completed vs. total assigned — primary operational throughput KPI for housekeeping management."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks completed within SLA target time — measures service delivery speed and brand standard adherence."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks with exceptions — identifies operational disruption frequency and root causes."
    - name: "guest_request_task_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_request_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks triggered by guest requests — measures demand-driven workload and guest service responsiveness."
    - name: "total_supply_quantity_used"
      expr: SUM(CAST(supply_quantity_used AS DOUBLE))
      comment: "Total supply quantity consumed across all cleaning tasks — drives supply chain planning and cost-per-occupied-room analysis."
    - name: "avg_supply_quantity_per_task"
      expr: AVG(CAST(supply_quantity_used AS DOUBLE))
      comment: "Average supply quantity used per task — benchmarks supply consumption efficiency and identifies waste."
    - name: "total_credit_weight"
      expr: SUM(CAST(credit_weight AS DOUBLE))
      comment: "Total credit weight earned across all tasks — measures aggregate labor productivity in credit-weighted terms."
    - name: "avg_credit_weight_per_task"
      expr: AVG(CAST(credit_weight AS DOUBLE))
      comment: "Average credit weight per task — benchmarks task complexity and attendant productivity against targets."
    - name: "skipped_task_count"
      expr: COUNT(CASE WHEN task_status = 'skipped' THEN 1 END)
      comment: "Count of skipped tasks — measures service delivery gaps that may impact guest satisfaction and brand compliance."
    - name: "maintenance_request_generated_count"
      expr: COUNT(CASE WHEN maintenance_request_generated = TRUE THEN 1 END)
      comment: "Count of tasks that generated a maintenance request — quantifies property condition issues discovered during cleaning operations."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_attendant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce KPIs for housekeeping attendants — measures productivity against credit targets, workforce composition, and performance ratings to support labor planning, performance management, and union compliance."
  source: "`travel_hospitality_ecm`.`housekeeping`.`attendant`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status of the attendant (e.g., active, terminated, on-leave) for workforce composition analysis."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the attendant (e.g., room attendant, houseperson, inspector) for workforce segmentation."
    - name: "shift_assignment"
      expr: shift_assignment
      comment: "Shift assignment of the attendant (e.g., AM, PM, overnight) for shift-level productivity analysis."
    - name: "section_assignment"
      expr: section_assignment
      comment: "Section or floor assignment of the attendant for geographic workload distribution analysis."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates whether the attendant is a union member — required for labor compliance and contract reporting."
    - name: "union_classification"
      expr: union_classification
      comment: "Union classification of the attendant for labor agreement compliance tracking."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the attendant (e.g., exceeds, meets, below expectations) for talent management analysis."
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates whether the attendant is currently active — for active workforce headcount reporting."
    - name: "ada_accommodation_flag"
      expr: ada_accommodation_flag
      comment: "Indicates whether the attendant has an ADA accommodation — required for HR compliance reporting."
    - name: "hire_month"
      expr: DATE_TRUNC('month', hire_date)
      comment: "Month of hire for cohort-based tenure and retention analysis."
    - name: "seniority_month"
      expr: DATE_TRUNC('month', seniority_date)
      comment: "Month of seniority date for union seniority and scheduling priority analysis."
  measures:
    - name: "total_attendants"
      expr: COUNT(1)
      comment: "Total number of attendant records — baseline headcount metric for workforce planning."
    - name: "active_attendant_count"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Count of currently active attendants — operational headcount for scheduling and capacity planning."
    - name: "union_member_count"
      expr: COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END)
      comment: "Count of union member attendants — required for labor contract compliance and collective bargaining reporting."
    - name: "union_membership_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN active_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active attendants who are union members — labor relations KPI for HR and legal compliance."
    - name: "avg_credits_per_shift"
      expr: AVG(CAST(average_credits_per_shift AS DOUBLE))
      comment: "Average credits earned per shift across all attendants — measures workforce-level productivity against credit-based labor standards."
    - name: "total_target_credits_per_shift"
      expr: SUM(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Sum of target credits per shift across all attendants — aggregate productivity target for capacity and scheduling planning."
    - name: "avg_target_credits_per_shift"
      expr: AVG(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Average target credits per shift — benchmark for individual attendant productivity goal-setting."
    - name: "credit_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(average_credits_per_shift AS DOUBLE)) / NULLIF(SUM(CAST(target_credits_per_shift AS DOUBLE)), 0), 2)
      comment: "Ratio of average credits earned to target credits per shift — measures workforce productivity attainment against labor standards; a core housekeeping efficiency KPI."
    - name: "ada_accommodation_count"
      expr: COUNT(CASE WHEN ada_accommodation_flag = TRUE THEN 1 END)
      comment: "Count of attendants with ADA accommodations — required for HR compliance, scheduling, and legal reporting."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_hk_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule-level planning and efficiency KPIs — measures headcount planning accuracy, credit targets, overtime thresholds, and schedule adherence to optimize labor deployment and cost-per-occupied-room performance."
  source: "`travel_hospitality_ecm`.`housekeeping`.`hk_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the housekeeping schedule — primary time dimension for daily labor planning analysis."
    - name: "schedule_week"
      expr: DATE_TRUNC('week', schedule_date)
      comment: "ISO week of the schedule date for weekly labor planning and cost trending."
    - name: "schedule_month"
      expr: DATE_TRUNC('month', schedule_date)
      comment: "Month of the schedule date for monthly labor cost and headcount reporting."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule (e.g., draft, published, finalized) for schedule management workflow tracking."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift scheduled (e.g., AM, PM, split) for shift-level labor analysis."
    - name: "section_code"
      expr: section_code
      comment: "Section or floor code for the schedule — enables geographic labor distribution analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign attendants to sections (e.g., manual, automated, seniority-based) for process efficiency analysis."
    - name: "turndown_service_flag"
      expr: turndown_service_flag
      comment: "Indicates whether turndown service is scheduled — impacts evening labor demand planning."
    - name: "pip_compliance_flag"
      expr: pip_compliance_flag
      comment: "Indicates whether the schedule meets brand Performance Improvement Plan compliance requirements."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of schedule records — baseline volume for schedule management reporting."
    - name: "total_cpor_target"
      expr: SUM(CAST(cpor_target AS DOUBLE))
      comment: "Sum of cost-per-occupied-room targets across all schedules — aggregate labor cost target for financial planning."
    - name: "avg_cpor_target"
      expr: AVG(CAST(cpor_target AS DOUBLE))
      comment: "Average cost-per-occupied-room target — the primary labor cost efficiency benchmark in hotel housekeeping operations."
    - name: "total_section_credit_value"
      expr: SUM(CAST(section_credit_value AS DOUBLE))
      comment: "Total credit value assigned across all scheduled sections — measures aggregate productivity capacity planned for the period."
    - name: "avg_section_credit_value"
      expr: AVG(CAST(section_credit_value AS DOUBLE))
      comment: "Average credit value per scheduled section — benchmarks section workload balance and scheduling equity."
    - name: "avg_overtime_threshold_hours"
      expr: AVG(CAST(overtime_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours across schedules — monitors labor cost risk from overtime exposure."
    - name: "pip_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pip_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules meeting brand PIP compliance requirements — brand standard adherence KPI for operations leadership."
    - name: "turndown_service_schedule_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN turndown_service_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules that include turndown service — measures premium service delivery coverage and associated labor cost."
    - name: "published_schedule_count"
      expr: COUNT(CASE WHEN schedule_status = 'published' THEN 1 END)
      comment: "Count of published schedules — measures scheduling process timeliness and operational readiness."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_supply_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain and cost KPIs for housekeeping consumables — measures consumption volumes, cost efficiency, PAR level variance, waste rates, and replenishment triggers to optimize supply spend and sustainability performance."
  source: "`travel_hospitality_ecm`.`housekeeping`.`supply_consumption`"
  dimensions:
    - name: "consumption_date"
      expr: consumption_date
      comment: "Date of supply consumption — primary time dimension for daily and weekly supply cost trending."
    - name: "consumption_week"
      expr: DATE_TRUNC('week', consumption_date)
      comment: "ISO week of consumption date for weekly supply cost analysis."
    - name: "consumption_month"
      expr: DATE_TRUNC('month', consumption_date)
      comment: "Month of consumption date for monthly supply budget reporting."
    - name: "consumption_reason"
      expr: consumption_reason
      comment: "Reason for supply consumption (e.g., routine cleaning, guest request, replenishment) for demand driver analysis."
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Occupancy status of the room at time of consumption (e.g., occupied, vacant) for consumption rate normalization."
    - name: "replenishment_action"
      expr: replenishment_action
      comment: "Action taken for replenishment (e.g., reorder, transfer, none) for supply chain responsiveness analysis."
    - name: "waste_indicator"
      expr: waste_indicator
      comment: "Indicates whether the consumption was classified as waste — supports sustainability and cost reduction programs."
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Indicates whether the supply item is sustainability certified — tracks green procurement program adoption."
    - name: "guest_charged_indicator"
      expr: guest_charged_indicator
      comment: "Indicates whether the supply cost was charged to the guest — for revenue recovery and cost allocation analysis."
    - name: "reorder_triggered"
      expr: reorder_triggered
      comment: "Indicates whether a reorder was triggered by this consumption event — for supply chain responsiveness monitoring."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade of the supply item consumed — for quality-cost tradeoff analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which the supply was consumed — for shift-level consumption pattern analysis."
  measures:
    - name: "total_supply_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of supplies consumed — primary supply chain cost KPI for budget management and cost-per-occupied-room analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of supplies consumed — benchmarks procurement efficiency and vendor pricing performance."
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total quantity of supplies consumed — volume metric for supply chain planning and PAR level calibration."
    - name: "avg_quantity_consumed_per_event"
      expr: AVG(CAST(quantity_consumed AS DOUBLE))
      comment: "Average quantity consumed per consumption event — benchmarks per-room or per-task supply usage efficiency."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total amount charged to guests for supply consumption — measures revenue recovery from guest-chargeable supplies."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consumption events classified as waste — sustainability and cost efficiency KPI for green operations programs."
    - name: "sustainability_certified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sustainability_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consumption events using sustainability-certified supplies — measures green procurement program adoption and ESG reporting."
    - name: "avg_par_level"
      expr: AVG(CAST(par_level AS DOUBLE))
      comment: "Average PAR level across consumption events — baseline for supply inventory adequacy assessment."
    - name: "total_variance_from_par"
      expr: SUM(CAST(variance_from_par AS DOUBLE))
      comment: "Total variance from PAR level across all consumption events — measures cumulative supply over- or under-consumption vs. standard."
    - name: "avg_variance_from_par"
      expr: AVG(CAST(variance_from_par AS DOUBLE))
      comment: "Average variance from PAR level per consumption event — identifies systematic over- or under-stocking patterns."
    - name: "total_replenishment_quantity"
      expr: SUM(CAST(replenishment_quantity AS DOUBLE))
      comment: "Total quantity replenished across all events — measures supply chain responsiveness and inventory turnover."
    - name: "reorder_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reorder_triggered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consumption events that triggered a reorder — measures supply depletion frequency and inventory management effectiveness."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_linen_management`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Linen inventory and cost KPIs — measures linen transaction volumes, unit and total costs, condition grading, and void rates to optimize linen lifecycle management, vendor performance, and sustainability compliance."
  source: "`travel_hospitality_ecm`.`housekeeping`.`linen_management`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the linen transaction — primary time dimension for daily and weekly linen cost trending."
    - name: "transaction_week"
      expr: DATE_TRUNC('week', transaction_date)
      comment: "ISO week of the linen transaction date for weekly cost analysis."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the linen transaction date for monthly budget reporting."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of linen transaction (e.g., issue, return, discard, laundry) for lifecycle stage analysis."
    - name: "item_type"
      expr: item_type
      comment: "Type of linen item (e.g., sheet, towel, pillowcase, tablecloth) for item-level cost and consumption analysis."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade of the linen item (e.g., new, good, worn, discard) for lifecycle and replacement planning."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the linen transaction (e.g., approved, pending, rejected) for procurement governance."
    - name: "is_voided"
      expr: is_voided
      comment: "Indicates whether the linen transaction was voided — for transaction integrity and audit reporting."
    - name: "shift"
      expr: shift
      comment: "Shift during which the linen transaction occurred — for shift-level consumption pattern analysis."
    - name: "section_code"
      expr: section_code
      comment: "Section or floor code for the linen transaction — enables geographic linen distribution analysis."
  measures:
    - name: "total_linen_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of linen transactions — primary linen program cost KPI for budget management and cost-per-occupied-room analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of linen items transacted — benchmarks procurement pricing and vendor performance."
    - name: "total_linen_transactions"
      expr: COUNT(1)
      comment: "Total number of linen transactions — baseline volume metric for linen program activity monitoring."
    - name: "voided_transaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_voided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of linen transactions that were voided — measures transaction quality and process control effectiveness."
    - name: "discard_transaction_count"
      expr: COUNT(CASE WHEN transaction_type = 'discard' THEN 1 END)
      comment: "Count of linen discard transactions — measures linen attrition rate and replacement cost drivers."
    - name: "total_discard_cost"
      expr: SUM(CASE WHEN transaction_type = 'discard' THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of discarded linen — quantifies linen replacement spend and informs lifecycle management investment decisions."
    - name: "approved_transaction_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of linen transactions that received approval — measures procurement governance compliance."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_lost_and_found`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost and found operational KPIs — measures item discovery volumes, claim rates, high-value item handling, estimated value exposure, and disposition outcomes to manage guest property liability and service recovery."
  source: "`travel_hospitality_ecm`.`housekeeping`.`lost_and_found`"
  dimensions:
    - name: "discovery_date"
      expr: discovery_date
      comment: "Date the lost item was discovered — primary time dimension for lost and found volume trending."
    - name: "discovery_week"
      expr: DATE_TRUNC('week', discovery_date)
      comment: "ISO week of item discovery for weekly volume analysis."
    - name: "discovery_month"
      expr: DATE_TRUNC('month', discovery_date)
      comment: "Month of item discovery for monthly reporting and trend analysis."
    - name: "discovery_location_type"
      expr: discovery_location_type
      comment: "Type of location where the item was discovered (e.g., guest room, lobby, pool, restaurant) for hotspot analysis."
    - name: "item_category"
      expr: item_category
      comment: "Category of the lost item (e.g., electronics, jewelry, clothing, documents) for inventory and liability analysis."
    - name: "lost_and_found_status"
      expr: lost_and_found_status
      comment: "Current status of the lost and found record (e.g., found, claimed, donated, discarded) for pipeline monitoring."
    - name: "claim_status"
      expr: claim_status
      comment: "Claim status of the item (e.g., claimed, unclaimed, pending) for guest service resolution tracking."
    - name: "disposition_type"
      expr: disposition_type
      comment: "Final disposition of the item (e.g., returned to guest, donated, discarded, held) for compliance and liability reporting."
    - name: "is_high_value_item"
      expr: is_high_value_item
      comment: "Indicates whether the item is classified as high value — triggers special handling protocols and management escalation."
    - name: "requires_special_handling"
      expr: requires_special_handling
      comment: "Indicates whether the item requires special handling (e.g., perishable, hazardous, identity document)."
    - name: "guest_notification_status"
      expr: guest_notification_status
      comment: "Status of guest notification for the lost item — measures service recovery responsiveness."
  measures:
    - name: "total_items_found"
      expr: COUNT(1)
      comment: "Total number of lost and found items recorded — baseline volume metric for lost and found program management."
    - name: "claim_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_status = 'claimed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of found items that were successfully claimed by guests — measures lost and found program effectiveness and guest service recovery."
    - name: "high_value_item_count"
      expr: COUNT(CASE WHEN is_high_value_item = TRUE THEN 1 END)
      comment: "Count of high-value items in lost and found — measures liability exposure and special handling workload."
    - name: "high_value_item_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_high_value_item = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of found items classified as high value — measures liability concentration and risk exposure."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value of all lost and found items — quantifies aggregate liability exposure for risk management and insurance reporting."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value_amount AS DOUBLE))
      comment: "Average estimated value per lost and found item — benchmarks typical liability exposure per incident."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost incurred to return items to guests — measures service recovery cost for lost and found operations."
    - name: "unclaimed_item_count"
      expr: COUNT(CASE WHEN claim_status = 'unclaimed' THEN 1 END)
      comment: "Count of unclaimed items — measures outstanding liability and triggers disposition decision-making per retention policy."
    - name: "guest_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_notification_status = 'notified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of found items where the guest was notified — measures service recovery responsiveness and compliance with guest communication standards."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`housekeeping_cleaning_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cleaning standard governance KPIs — measures standard cost estimates, compliance requirements, sustainability adoption, and inspection thresholds to govern brand standard quality and cost efficiency across property segments."
  source: "`travel_hospitality_ecm`.`housekeeping`.`cleaning_standard`"
  dimensions:
    - name: "cleaning_type"
      expr: cleaning_type
      comment: "Type of cleaning standard (e.g., departure, stayover, deep clean, turndown) for standard portfolio analysis."
    - name: "cleaning_standard_status"
      expr: cleaning_standard_status
      comment: "Status of the cleaning standard (e.g., active, expired, draft) for governance and lifecycle management."
    - name: "brand_compliance_required_flag"
      expr: brand_compliance_required_flag
      comment: "Indicates whether brand compliance is mandatory for this standard — for brand audit and compliance reporting."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Indicates whether attendant certification is required to execute this standard — for training compliance tracking."
    - name: "sustainability_compliance_flag"
      expr: sustainability_compliance_flag
      comment: "Indicates whether the standard meets sustainability compliance requirements — for ESG and green operations reporting."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the cleaning standard — for standard lifecycle and version management analysis."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the cleaning standard became effective — for standard adoption and rollout trend analysis."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Expiration date of the cleaning standard — for proactive standard renewal and compliance gap management."
  measures:
    - name: "total_active_standards"
      expr: COUNT(CASE WHEN cleaning_standard_status = 'active' THEN 1 END)
      comment: "Count of currently active cleaning standards — measures the breadth of the governed standard library."
    - name: "avg_cost_per_execution_estimate"
      expr: AVG(CAST(cost_per_execution_estimate AS DOUBLE))
      comment: "Average estimated cost per cleaning execution across all standards — benchmarks cleaning cost efficiency and informs cost-per-occupied-room targets."
    - name: "avg_labor_cost_estimate"
      expr: AVG(CAST(labor_cost_estimate AS DOUBLE))
      comment: "Average estimated labor cost per standard execution — measures labor cost component of cleaning standards for workforce planning."
    - name: "avg_supply_cost_estimate"
      expr: AVG(CAST(supply_cost_estimate AS DOUBLE))
      comment: "Average estimated supply cost per standard execution — benchmarks supply spend efficiency across cleaning standard types."
    - name: "avg_inspection_pass_threshold"
      expr: AVG(CAST(inspection_pass_threshold_score AS DOUBLE))
      comment: "Average inspection pass threshold score across all standards — measures the rigor of quality bar set by brand standards."
    - name: "sustainability_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sustainability_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN cleaning_standard_status = 'active' THEN 1 END), 0), 2)
      comment: "Percentage of active cleaning standards that meet sustainability compliance requirements — ESG and green operations KPI for executive reporting."
    - name: "brand_compliance_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN brand_compliance_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cleaning standards requiring brand compliance — measures the proportion of standards subject to brand audit scrutiny."
    - name: "certification_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cleaning standards requiring attendant certification — drives training program investment and compliance planning."
$$;