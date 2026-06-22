-- Metric views for domain: housekeeping | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for housekeeping room assignments — tracks assignment volume, completion rates, VIP service delivery, linen/amenity activity, and labor efficiency across properties and shift types."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`"
  dimensions:
    - name: "assignment_date"
      expr: assignment_date
      comment: "Calendar date of the housekeeping assignment, used for daily and weekly trend analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., stayover, departure, turndown) for workload segmentation."
    - name: "completion_status"
      expr: completion_status
      comment: "Final completion status of the assignment (completed, skipped, reassigned) for SLA tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority tier of the assignment (VIP, standard, low) to assess service prioritization."
    - name: "vip_indicator"
      expr: vip_indicator
      comment: "Flag indicating whether the assignment was for a VIP guest, enabling VIP service performance analysis."
    - name: "dnd_flag"
      expr: dnd_flag
      comment: "Do-Not-Disturb flag indicating guest declined service, used to measure service refusal rates."
    - name: "linen_change_flag"
      expr: linen_change_flag
      comment: "Indicates whether linen was changed during the assignment, supporting sustainability and cost tracking."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether a quality inspection was required for this assignment."
    - name: "maintenance_request_flag"
      expr: maintenance_request_flag
      comment: "Whether a maintenance issue was identified and flagged during the assignment."
    - name: "room_status_before"
      expr: room_status_before
      comment: "Room status at the start of the assignment (dirty, vacant clean, etc.) for workflow analysis."
    - name: "room_status_after"
      expr: room_status_after
      comment: "Room status at the end of the assignment, confirming readiness for next guest."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of housekeeping assignments — baseline volume metric for staffing and scheduling decisions."
    - name: "completed_assignments"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Count of assignments successfully completed — core throughput KPI for housekeeping operations."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments completed vs. total assigned — primary SLA compliance indicator for housekeeping leadership."
    - name: "vip_assignment_count"
      expr: COUNT(CASE WHEN vip_indicator = TRUE THEN 1 END)
      comment: "Number of VIP guest assignments — tracks high-priority service delivery volume for guest experience management."
    - name: "maintenance_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_request_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments that generated a maintenance flag — signals property condition issues requiring engineering intervention."
    - name: "dnd_refusal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dnd_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments declined by guests (DND) — informs service delivery strategy and sustainability opt-out programs."
    - name: "linen_change_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN linen_change_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with linen changes — key sustainability and laundry cost driver metric."
    - name: "reassignment_count_total"
      expr: COUNT(CASE WHEN completion_status = 'reassigned' THEN 1 END)
      comment: "Total assignments that required reassignment — indicates scheduling inefficiency or attendant availability issues."
    - name: "total_room_credits"
      expr: SUM(CAST(room_credits AS DOUBLE))
      comment: "Total room credits earned across all assignments — used to measure attendant productivity and labor cost allocation."
    - name: "avg_room_credits_per_assignment"
      expr: AVG(CAST(room_credits AS DOUBLE))
      comment: "Average room credits per assignment — benchmarks workload intensity and informs credit-based compensation models."
    - name: "inspection_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments requiring quality inspection — reflects quality control intensity and brand standard compliance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality inspection KPIs measuring room and space cleanliness scores, deficiency rates, reclean requirements, and inspection pass/fail outcomes — core metrics for brand standard compliance and guest satisfaction management."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (arrival, departure, spot-check, VIP) for segmented quality analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (passed, failed, pending) for operational tracking."
    - name: "outcome"
      expr: outcome
      comment: "Final inspection outcome (pass, fail, reclean required) — primary quality disposition indicator."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the inspection, used to assess urgency-weighted quality performance."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether the inspection was for a VIP guest room — enables VIP quality tier analysis."
    - name: "reclean_required_flag"
      expr: reclean_required_flag
      comment: "Whether the room required a reclean after inspection — direct measure of first-pass quality failure."
    - name: "maintenance_issue_flag"
      expr: maintenance_issue_flag
      comment: "Whether a maintenance issue was identified during inspection — links quality and engineering workflows."
    - name: "room_release_flag"
      expr: room_release_flag
      comment: "Whether the room was released for guest occupancy after inspection — measures inventory readiness."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date of the inspection for time-series quality trend analysis."
    - name: "amenity_check_flag"
      expr: amenity_check_flag
      comment: "Whether amenity placement was verified during inspection — supports brand standard compliance tracking."
    - name: "linen_quality_flag"
      expr: linen_quality_flag
      comment: "Whether linen quality met standards during inspection — informs laundry vendor performance management."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted — baseline volume metric for quality program coverage."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that passed — primary brand standard compliance KPI reviewed at property and portfolio level."
    - name: "reclean_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reclean_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring a reclean — measures first-pass quality failure rate and drives labor cost impact analysis."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score across all inspections — headline quality KPI for executive dashboards and brand compliance reporting."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average overall quality score per inspection — composite quality indicator used in QBR and brand audit reporting."
    - name: "maintenance_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_issue_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections identifying a maintenance issue — key leading indicator for property condition and CapEx planning."
    - name: "vip_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_flag = TRUE AND outcome = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN vip_flag = TRUE THEN 1 END), 0), 2)
      comment: "Pass rate for VIP guest room inspections — critical guest experience KPI directly linked to loyalty retention and complaint risk."
    - name: "room_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN room_release_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspected rooms released for occupancy — measures inventory readiness and front-desk coordination efficiency."
    - name: "avg_inspection_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average inspection duration in minutes — labor efficiency metric for quality control staffing and scheduling optimization. Note: duration_minutes is stored as STRING and cast to DOUBLE for aggregation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_inspection_deficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deficiency tracking KPIs measuring severity, resolution speed, recurrence, and guest impact of housekeeping quality failures — enables root-cause analysis and continuous improvement programs."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency`"
  dimensions:
    - name: "deficiency_category"
      expr: deficiency_category
      comment: "High-level category of the deficiency (cleanliness, maintenance, amenity) for trend analysis."
    - name: "deficiency_subcategory"
      expr: deficiency_subcategory
      comment: "Detailed subcategory for granular root-cause analysis and corrective action targeting."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the deficiency (critical, major, minor) — drives prioritization and escalation decisions."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status (open, in-progress, resolved) for operational tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for systemic deficiency pattern analysis and process improvement."
    - name: "guest_impacting_flag"
      expr: guest_impacting_flag
      comment: "Whether the deficiency directly impacted a guest — links quality failures to guest satisfaction risk."
    - name: "blocks_room_sale_flag"
      expr: blocks_room_sale_flag
      comment: "Whether the deficiency prevents the room from being sold — directly impacts revenue availability."
    - name: "recurring_deficiency_flag"
      expr: recurring_deficiency_flag
      comment: "Whether this is a recurring deficiency — identifies chronic quality issues requiring systemic intervention."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the deficiency was escalated — measures severity of quality control failures requiring management attention."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a formal corrective action was required — links to compliance and quality management workflows."
  measures:
    - name: "total_deficiencies"
      expr: COUNT(1)
      comment: "Total number of deficiencies identified — baseline quality failure volume metric for trend and benchmarking analysis."
    - name: "guest_impacting_deficiency_count"
      expr: COUNT(CASE WHEN guest_impacting_flag = TRUE THEN 1 END)
      comment: "Number of deficiencies that directly impacted guests — highest-priority quality metric linked to satisfaction scores and complaint risk."
    - name: "guest_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_impacting_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deficiencies with guest impact — executive KPI linking housekeeping quality to guest experience outcomes."
    - name: "room_blocking_deficiency_count"
      expr: COUNT(CASE WHEN blocks_room_sale_flag = TRUE THEN 1 END)
      comment: "Number of deficiencies blocking room sales — directly quantifies revenue at risk from quality failures."
    - name: "recurring_deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurring_deficiency_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deficiencies that are recurring — key indicator of systemic quality issues requiring process redesign."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deficiencies escalated — measures severity distribution and management intervention frequency."
    - name: "total_resolution_cost"
      expr: SUM(CAST(resolution_cost_amount AS DOUBLE))
      comment: "Total cost incurred to resolve deficiencies — quantifies the financial impact of quality failures for budget and vendor management."
    - name: "avg_resolution_cost"
      expr: AVG(CAST(resolution_cost_amount AS DOUBLE))
      comment: "Average cost to resolve a deficiency — benchmarks remediation efficiency and informs quality investment decisions."
    - name: "open_deficiency_count"
      expr: COUNT(CASE WHEN resolution_status = 'open' THEN 1 END)
      comment: "Number of currently open (unresolved) deficiencies — operational backlog metric for daily management and SLA compliance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_cleaning_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cleaning task execution KPIs measuring task completion rates, SLA compliance, supply usage, and service quality — operational metrics for housekeeping productivity and cost management."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Type of cleaning task (room clean, turndown, deep clean) for workload segmentation."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task (pending, in-progress, completed, skipped) for operational tracking."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task for resource allocation and SLA management."
    - name: "service_type"
      expr: service_type
      comment: "Service type (stayover, departure, VIP) for service mix analysis."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the task was completed within SLA targets — primary operational efficiency indicator."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Whether an exception occurred during task execution — identifies operational disruptions."
    - name: "guest_request_flag"
      expr: guest_request_flag
      comment: "Whether the task was triggered by a guest request — measures demand-driven service volume."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Whether the task requires a quality inspection upon completion."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the task is mandatory per brand standards — ensures compliance coverage tracking."
    - name: "maintenance_request_generated"
      expr: maintenance_request_generated
      comment: "Whether the task generated a maintenance request — links cleaning operations to engineering workflows."
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total cleaning tasks scheduled — baseline volume metric for staffing and scheduling decisions."
    - name: "completed_tasks"
      expr: COUNT(CASE WHEN task_status = 'completed' THEN 1 END)
      comment: "Number of tasks successfully completed — core throughput KPI for housekeeping operations management."
    - name: "task_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN task_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks completed — primary SLA and productivity KPI for housekeeping leadership."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks completed within SLA targets — operational efficiency KPI tied to guest satisfaction and brand standards."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks with exceptions — measures operational disruption frequency for process improvement targeting."
    - name: "maintenance_generation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_request_generated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cleaning tasks that generated a maintenance request — leading indicator of property condition deterioration."
    - name: "total_supply_quantity_used"
      expr: SUM(CAST(supply_quantity_used AS DOUBLE))
      comment: "Total supply quantity consumed across all cleaning tasks — drives procurement planning and cost-per-room calculations."
    - name: "avg_supply_quantity_per_task"
      expr: AVG(CAST(supply_quantity_used AS DOUBLE))
      comment: "Average supply quantity used per task — benchmarks consumption efficiency and identifies waste or over-use patterns."
    - name: "total_task_credits"
      expr: SUM(CAST(credit_weight AS DOUBLE))
      comment: "Total credit weight earned across all tasks — used for attendant productivity measurement and credit-based compensation."
    - name: "avg_credit_weight_per_task"
      expr: AVG(CAST(credit_weight AS DOUBLE))
      comment: "Average credit weight per task — measures task complexity distribution and informs workload balancing decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_maintenance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance request KPIs measuring volume, cost, resolution speed, safety risk, and guest impact — critical metrics for property condition management, CapEx planning, and guest satisfaction protection."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`"
  dimensions:
    - name: "maintenance_request_category"
      expr: maintenance_request_category
      comment: "Category of the maintenance issue (plumbing, electrical, HVAC, FF&E) for asset management analysis."
    - name: "request_type"
      expr: request_type
      comment: "Type of maintenance request (corrective, preventive, emergency) for workload classification."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (open, in-progress, completed) for operational backlog management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the request (emergency, high, medium, low) for resource allocation decisions."
    - name: "safety_hazard_flag"
      expr: safety_hazard_flag
      comment: "Whether the request involves a safety hazard — highest-priority flag for risk management and compliance."
    - name: "guest_impact_flag"
      expr: guest_impact_flag
      comment: "Whether the maintenance issue impacted a guest — links property condition to guest satisfaction outcomes."
    - name: "room_out_of_order_flag"
      expr: room_out_of_order_flag
      comment: "Whether the issue caused the room to go out of order — directly quantifies revenue impact of maintenance failures."
    - name: "recurring_issue_flag"
      expr: recurring_issue_flag
      comment: "Whether this is a recurring issue — identifies chronic asset failures requiring capital investment."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether a warranty claim was filed — tracks warranty recovery opportunities and vendor accountability."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether a post-repair inspection is required — ensures quality verification before room release."
  measures:
    - name: "total_maintenance_requests"
      expr: COUNT(1)
      comment: "Total maintenance requests submitted — baseline property condition metric for engineering and asset management."
    - name: "open_request_count"
      expr: COUNT(CASE WHEN request_status = 'open' THEN 1 END)
      comment: "Number of currently open maintenance requests — operational backlog KPI for engineering team management."
    - name: "safety_hazard_count"
      expr: COUNT(CASE WHEN safety_hazard_flag = TRUE THEN 1 END)
      comment: "Number of requests involving safety hazards — critical risk management KPI requiring immediate executive visibility."
    - name: "guest_impacting_request_count"
      expr: COUNT(CASE WHEN guest_impact_flag = TRUE THEN 1 END)
      comment: "Number of maintenance issues that impacted guests — links property condition to guest satisfaction and complaint risk."
    - name: "room_out_of_order_count"
      expr: COUNT(CASE WHEN room_out_of_order_flag = TRUE THEN 1 END)
      comment: "Number of requests causing rooms to go out of order — directly quantifies revenue at risk from maintenance failures."
    - name: "recurring_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurring_issue_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recurring maintenance issues — key indicator for CapEx investment decisions and asset replacement planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of maintenance work completed — primary financial metric for engineering budget management and owner reporting."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost for maintenance requests — enables labor vs. materials cost split analysis for budget optimization."
    - name: "total_materials_cost"
      expr: SUM(CAST(materials_cost_amount AS DOUBLE))
      comment: "Total materials cost for maintenance requests — drives procurement planning and vendor spend management."
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average cost per maintenance request — benchmarks repair efficiency and informs make-vs-buy decisions for asset management."
    - name: "cost_variance_total"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total variance between actual and estimated maintenance costs — measures estimation accuracy and budget control effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_supply_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply consumption KPIs measuring housekeeping supply usage, cost efficiency, PAR level adherence, and sustainability compliance — drives procurement planning, cost-per-room analysis, and waste reduction programs."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption`"
  dimensions:
    - name: "consumption_date"
      expr: consumption_date
      comment: "Date of supply consumption for daily and weekly trend analysis."
    - name: "amenity_type"
      expr: amenity_type
      comment: "Type of amenity or supply consumed (toiletries, linen, cleaning chemicals) for category-level cost analysis."
    - name: "consumption_reason"
      expr: consumption_reason
      comment: "Reason for consumption (standard service, guest request, waste) for demand driver analysis."
    - name: "room_type_code"
      expr: room_type_code
      comment: "Room type associated with the consumption — enables cost-per-room-type benchmarking."
    - name: "guest_segment"
      expr: guest_segment
      comment: "Guest segment associated with the consumption — links supply costs to revenue-generating segments."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift during which consumption occurred — identifies shift-level consumption patterns and waste."
    - name: "reorder_triggered"
      expr: reorder_triggered
      comment: "Whether the consumption triggered a reorder — measures PAR level management effectiveness."
    - name: "waste_indicator"
      expr: waste_indicator
      comment: "Whether the consumption was classified as waste — key sustainability and cost reduction metric."
    - name: "sustainability_certified"
      expr: sustainability_certified
      comment: "Whether the supply item is sustainability certified — tracks green procurement compliance."
    - name: "guest_charged_indicator"
      expr: guest_charged_indicator
      comment: "Whether the supply cost was charged to the guest — enables revenue recovery analysis."
  measures:
    - name: "total_quantity_consumed"
      expr: SUM(CAST(quantity_consumed AS DOUBLE))
      comment: "Total supply quantity consumed — primary volume metric for procurement planning and PAR level management."
    - name: "total_supply_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of supplies consumed — headline financial metric for housekeeping cost-per-occupied-room analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of supplies consumed — benchmarks procurement efficiency and vendor pricing performance."
    - name: "total_replenishment_quantity"
      expr: SUM(CAST(replenishment_quantity AS DOUBLE))
      comment: "Total quantity replenished — measures inventory restocking activity and supply chain responsiveness."
    - name: "avg_variance_from_par"
      expr: AVG(CAST(variance_from_par AS DOUBLE))
      comment: "Average variance from PAR level — measures inventory management precision and identifies chronic over/under-stocking."
    - name: "waste_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consumption records classified as waste — sustainability and cost efficiency KPI for green operations programs."
    - name: "reorder_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reorder_triggered = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consumption events triggering a reorder — measures PAR level adequacy and procurement responsiveness."
    - name: "sustainability_certified_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sustainability_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supply consumption from sustainability-certified products — tracks green procurement compliance for ESG reporting."
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total amount charged to guests for supplies — measures revenue recovery from supply consumption and informs pricing strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_attendant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attendant workforce KPIs measuring productivity, performance ratings, credit achievement, and workforce composition — enables labor planning, performance management, and staffing optimization."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`attendant`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on-leave) for workforce composition analysis."
    - name: "role_type"
      expr: role_type
      comment: "Role classification of the attendant (room attendant, supervisor, inspector) for workforce segmentation."
    - name: "shift_assignment"
      expr: shift_assignment
      comment: "Shift assignment (AM, PM, overnight) for shift-level productivity analysis."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Whether the attendant is a union member — impacts labor cost modeling and scheduling constraints."
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the attendant is currently active — used to filter active workforce for capacity planning."
    - name: "ada_accommodation_flag"
      expr: ada_accommodation_flag
      comment: "Whether the attendant has an ADA accommodation — informs assignment planning and compliance tracking."
    - name: "section_assignment"
      expr: section_assignment
      comment: "Floor or section assigned to the attendant — enables section-level productivity benchmarking."
  measures:
    - name: "total_attendants"
      expr: COUNT(1)
      comment: "Total number of attendant records — baseline workforce size metric for capacity planning."
    - name: "active_attendant_count"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Number of currently active attendants — operational headcount metric for daily scheduling and capacity management."
    - name: "avg_credits_per_shift"
      expr: AVG(CAST(average_credits_per_shift AS DOUBLE))
      comment: "Average credits earned per shift across attendants — primary productivity benchmark for performance management and compensation."
    - name: "avg_target_credits_per_shift"
      expr: AVG(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Average target credits per shift — establishes productivity baseline for performance gap analysis."
    - name: "credit_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(average_credits_per_shift AS DOUBLE)) / NULLIF(SUM(CAST(target_credits_per_shift AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to target credits per shift — measures workforce productivity attainment against standards for performance reviews."
    - name: "union_member_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants who are union members — informs labor relations strategy and cost modeling."
    - name: "ada_accommodation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ada_accommodation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants with ADA accommodations — supports compliance reporting and inclusive workforce planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_laundry_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laundry operations KPIs measuring order volume, cost efficiency, turnaround time, SLA compliance, and vendor performance — drives laundry vendor management and linen cost optimization."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of laundry order (guest laundry, linen, uniform) for cost category analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the laundry order (submitted, processing, returned) for operational tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the order (rush, standard) for SLA and cost analysis."
    - name: "pricing_method"
      expr: pricing_method
      comment: "Pricing method used (per item, per pound) for cost structure analysis."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the order was returned within SLA — primary vendor performance KPI."
    - name: "processing_location"
      expr: processing_location
      comment: "Location where laundry was processed (on-site, off-site vendor) for make-vs-buy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the laundry order cost for multi-property financial reporting."
  measures:
    - name: "total_laundry_orders"
      expr: COUNT(1)
      comment: "Total laundry orders submitted — baseline volume metric for laundry operations capacity planning."
    - name: "total_laundry_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all laundry orders — primary financial metric for laundry budget management and vendor spend analysis."
    - name: "avg_cost_per_order"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per laundry order — benchmarks laundry efficiency and informs vendor contract negotiations."
    - name: "avg_cost_per_pound"
      expr: AVG(CAST(cost_per_pound AS DOUBLE))
      comment: "Average cost per pound of laundry — standard industry efficiency metric for laundry vendor benchmarking."
    - name: "avg_cost_per_item"
      expr: AVG(CAST(cost_per_item AS DOUBLE))
      comment: "Average cost per laundry item — enables item-level cost analysis for linen lifecycle management."
    - name: "total_weight_processed_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight of laundry processed in pounds — capacity utilization metric for laundry operations planning."
    - name: "avg_turnaround_hours"
      expr: AVG(CAST(turnaround_time_hours AS DOUBLE))
      comment: "Average turnaround time in hours — primary vendor SLA performance metric for laundry contract management."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of laundry orders returned within SLA — vendor performance KPI used in contract reviews and renewal decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_deep_clean_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deep clean program KPIs measuring plan completion rates, labor efficiency, cost performance, and PIP compliance — supports asset management, brand standard compliance, and capital planning."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan`"
  dimensions:
    - name: "deep_clean_plan_status"
      expr: deep_clean_plan_status
      comment: "Current status of the deep clean plan (scheduled, in-progress, completed, cancelled) for program tracking."
    - name: "area_type"
      expr: area_type
      comment: "Type of area being deep cleaned (guest room, public area, spa, F&B) for scope analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the deep clean plan for resource allocation decisions."
    - name: "pip_compliance_flag"
      expr: pip_compliance_flag
      comment: "Whether the deep clean is required for PIP (Property Improvement Plan) compliance — links to brand standard and franchise obligations."
    - name: "rotation_cycle"
      expr: rotation_cycle
      comment: "Rotation cycle of the deep clean (quarterly, semi-annual, annual) for scheduling analysis."
    - name: "maintenance_issues_identified"
      expr: maintenance_issues_identified
      comment: "Whether maintenance issues were identified during the deep clean — links to CapEx and engineering workflows."
    - name: "ffe_inspection_performed"
      expr: ffe_inspection_performed
      comment: "Whether FF&E inspection was performed — tracks asset condition assessment coverage."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether a quality inspection is required upon completion — ensures brand standard verification."
    - name: "planned_date"
      expr: planned_date
      comment: "Planned date of the deep clean for schedule adherence analysis."
  measures:
    - name: "total_deep_clean_plans"
      expr: COUNT(1)
      comment: "Total deep clean plans created — baseline program volume metric for asset maintenance coverage tracking."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deep_clean_plan_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deep clean plans completed — primary program execution KPI for brand standard and PIP compliance."
    - name: "pip_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pip_compliance_flag = TRUE AND deep_clean_plan_status = 'completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN pip_compliance_flag = TRUE THEN 1 END), 0), 2)
      comment: "Completion rate for PIP-required deep cleans — critical franchise compliance KPI with direct brand standard implications."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all deep clean plans — primary cost metric for housekeeping budget management."
    - name: "total_supply_cost"
      expr: SUM(CAST(supply_cost AS DOUBLE))
      comment: "Total supply cost for deep clean plans — drives procurement planning for deep clean programs."
    - name: "total_deep_clean_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total all-in cost of deep clean plans — headline financial metric for asset maintenance budget reporting."
    - name: "avg_labor_hours_actual"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per deep clean — benchmarks labor efficiency against estimates for scheduling optimization."
    - name: "avg_labor_hours_estimated"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per deep clean — establishes planning baseline for labor budget accuracy analysis."
    - name: "labor_hour_variance"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE) - CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total variance between actual and estimated labor hours — measures planning accuracy and identifies scope creep in deep clean programs."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all active deep clean plans — measures in-progress program execution for operational oversight."
    - name: "maintenance_issue_discovery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_issues_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deep cleans that identified maintenance issues — measures deep clean effectiveness as a property condition assessment tool."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Housekeeping schedule KPIs measuring labor budget adherence, staffing levels, occupancy-driven planning, and schedule efficiency — enables labor cost management and demand-responsive staffing decisions."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the housekeeping schedule for daily and weekly labor planning analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule (draft, published, executed) for schedule management tracking."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (AM, PM, overnight) for shift-level labor analysis."
    - name: "section_code"
      expr: section_code
      comment: "Section or floor code for geographic labor distribution analysis."
    - name: "turndown_service_flag"
      expr: turndown_service_flag
      comment: "Whether turndown service is scheduled — impacts evening labor requirements and guest experience delivery."
    - name: "pip_compliance_flag"
      expr: pip_compliance_flag
      comment: "Whether the schedule meets PIP staffing requirements — tracks brand standard compliance in labor planning."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign rooms (manual, automated, hybrid) for scheduling efficiency analysis."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total schedule records — baseline volume metric for schedule management coverage."
    - name: "total_labor_budget_amount"
      expr: SUM(CAST(labor_budget_amount AS DOUBLE))
      comment: "Total labor budget allocated across all schedules — primary financial metric for housekeeping labor cost management."
    - name: "avg_labor_budget_per_schedule"
      expr: AVG(CAST(labor_budget_amount AS DOUBLE))
      comment: "Average labor budget per schedule day — benchmarks daily labor spend for budget variance analysis."
    - name: "avg_cpor_target"
      expr: AVG(CAST(cpor_target AS DOUBLE))
      comment: "Average cost-per-occupied-room target — key efficiency benchmark for housekeeping labor cost management and owner reporting."
    - name: "avg_occupancy_forecast_tier"
      expr: AVG(CAST(occupancy_forecast_tier AS DOUBLE))
      comment: "Average occupancy forecast tier used for scheduling — measures demand-responsive staffing accuracy."
    - name: "avg_section_credit_value"
      expr: AVG(CAST(section_credit_value AS DOUBLE))
      comment: "Average credit value per section — benchmarks workload distribution and informs section assignment optimization."
    - name: "avg_overtime_threshold_hours"
      expr: AVG(CAST(overtime_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours across schedules — monitors overtime risk exposure for labor cost control."
    - name: "turndown_service_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN turndown_service_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules including turndown service — measures premium service delivery frequency for guest experience and cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_lost_and_found`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost and found KPIs measuring item recovery rates, claim resolution, high-value item handling, and guest notification effectiveness — supports guest satisfaction, privacy compliance, and operational accountability."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found`"
  dimensions:
    - name: "lost_and_found_status"
      expr: lost_and_found_status
      comment: "Current status of the lost and found item (found, claimed, donated, discarded) for case management tracking."
    - name: "item_category"
      expr: item_category
      comment: "Category of the lost item (electronics, clothing, documents, jewelry) for inventory and risk analysis."
    - name: "discovery_location_type"
      expr: discovery_location_type
      comment: "Type of location where item was found (guest room, public area, F&B outlet) for operational pattern analysis."
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the item was ultimately disposed of (returned to guest, donated, discarded) for program effectiveness analysis."
    - name: "is_high_value_item"
      expr: is_high_value_item
      comment: "Whether the item is classified as high value — drives special handling protocols and risk management."
    - name: "requires_special_handling"
      expr: requires_special_handling
      comment: "Whether the item requires special handling (hazmat, legal documents) for compliance tracking."
    - name: "guest_notification_status"
      expr: guest_notification_status
      comment: "Status of guest notification (notified, not notified, no contact info) for service recovery tracking."
    - name: "discovery_date"
      expr: discovery_date
      comment: "Date item was discovered for trend and seasonality analysis."
  measures:
    - name: "total_items_found"
      expr: COUNT(1)
      comment: "Total lost and found items recorded — baseline volume metric for program management and staffing."
    - name: "claim_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN claim_status = 'claimed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of found items successfully claimed by guests — measures lost and found program effectiveness and guest communication quality."
    - name: "high_value_item_count"
      expr: COUNT(CASE WHEN is_high_value_item = TRUE THEN 1 END)
      comment: "Number of high-value items in lost and found — risk management metric requiring executive visibility for liability and insurance purposes."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value of all lost and found items — quantifies financial liability exposure for risk management and insurance reporting."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping costs incurred to return items to guests — operational cost metric for lost and found program budget management."
    - name: "avg_estimated_value_per_item"
      expr: AVG(CAST(estimated_value_amount AS DOUBLE))
      comment: "Average estimated value per lost item — benchmarks item value profile for risk assessment and handling protocol calibration."
    - name: "unclaimed_item_count"
      expr: COUNT(CASE WHEN lost_and_found_status NOT IN ('claimed', 'returned') THEN 1 END)
      comment: "Number of items not yet claimed — operational backlog metric for storage management and retention policy compliance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order KPIs measuring completion rates, labor and supply costs, inspection outcomes, and service quality — operational metrics for housekeeping and engineering coordination and cost management."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (cleaning, maintenance, amenity replenishment) for workload classification."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (open, in-progress, completed, cancelled) for operational tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order for resource allocation and SLA management."
    - name: "vip_service"
      expr: vip_service
      comment: "Whether the work order is for a VIP guest — enables VIP service quality tracking."
    - name: "linen_change_required"
      expr: linen_change_required
      comment: "Whether linen change is required — links to laundry cost and sustainability tracking."
    - name: "amenity_replenishment_required"
      expr: amenity_replenishment_required
      comment: "Whether amenity replenishment is required — tracks amenity service delivery volume."
    - name: "maintenance_handoff_required"
      expr: maintenance_handoff_required
      comment: "Whether a maintenance handoff is required — measures cross-department coordination frequency."
    - name: "room_status_before"
      expr: room_status_before
      comment: "Room status before work order execution for workflow analysis."
    - name: "room_status_after"
      expr: room_status_after
      comment: "Room status after work order completion — confirms inventory readiness outcomes."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date for time-series work order volume analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total work orders created — baseline operational volume metric for housekeeping and engineering management."
    - name: "completed_work_orders"
      expr: COUNT(CASE WHEN work_order_status = 'completed' THEN 1 END)
      comment: "Number of completed work orders — core throughput KPI for operational efficiency measurement."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN work_order_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders completed — primary SLA compliance KPI for housekeeping operations management."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all work orders — primary financial metric for housekeeping labor budget management."
    - name: "total_supply_cost"
      expr: SUM(CAST(supply_cost_amount AS DOUBLE))
      comment: "Total supply cost across all work orders — drives procurement planning and cost-per-room analysis."
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average inspection score for completed work orders — quality outcome metric for service standard compliance."
    - name: "vip_work_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_service = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders for VIP guests — measures premium service delivery volume and resource allocation to high-value guests."
    - name: "maintenance_handoff_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_handoff_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders requiring maintenance handoff — measures cross-department coordination frequency and property condition signal."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion KPIs measuring certification attainment, compliance rates, and skill qualification levels for housekeeping attendants — supports workforce readiness, brand standard compliance, and regulatory safety requirements."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of the training completion (completed, in-progress, failed, expired) for compliance tracking."
    - name: "bloodborne_pathogen_certified_flag"
      expr: bloodborne_pathogen_certified_flag
      comment: "Whether the attendant is certified for bloodborne pathogen handling — mandatory safety compliance indicator."
    - name: "chemical_handling_certified_flag"
      expr: chemical_handling_certified_flag
      comment: "Whether the attendant is certified for chemical handling — OSHA compliance and safety risk management indicator."
    - name: "vip_certified_flag"
      expr: vip_certified_flag
      comment: "Whether the attendant is VIP-certified — measures premium service capability across the workforce."
    - name: "suite_qualified_flag"
      expr: suite_qualified_flag
      comment: "Whether the attendant is qualified to service suites — measures high-value room service capacity."
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Whether a formal certificate was issued upon completion — tracks credentialing program outcomes."
    - name: "completion_date"
      expr: completion_date
      comment: "Date training was completed for compliance deadline tracking and recertification planning."
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date of training enrollment for time-to-completion analysis."
  measures:
    - name: "total_training_completions"
      expr: COUNT(1)
      comment: "Total training completion records — baseline workforce development volume metric."
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of training enrollments successfully completed — primary workforce readiness KPI for compliance and brand standard management."
    - name: "bloodborne_pathogen_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bloodborne_pathogen_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants with bloodborne pathogen certification — mandatory OSHA compliance KPI with direct regulatory risk implications."
    - name: "chemical_handling_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chemical_handling_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants certified for chemical handling — safety compliance KPI required for regulatory audits and insurance."
    - name: "vip_certified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants VIP-certified — measures premium service delivery capacity for high-value guest management."
    - name: "suite_qualified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN suite_qualified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants qualified for suite service — measures high-revenue room service capacity for staffing optimization."
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training assessment score — measures workforce knowledge attainment and training program effectiveness."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed across all attendants — measures workforce development investment for HR and compliance reporting."
    - name: "avg_training_hours_per_completion"
      expr: AVG(CAST(training_hours_completed AS DOUBLE))
      comment: "Average training hours per completion record — benchmarks training intensity and informs program design decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_maintenance_handoff`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance handoff metrics tracking issue identification, resolution time, and cross-functional coordination"
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff`"
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