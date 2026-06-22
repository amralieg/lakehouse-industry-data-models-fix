-- Metric views for domain: housekeeping | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for housekeeping room assignments — tracks assignment throughput, room credit yield, inspection outcomes, and service quality indicators used by Housekeeping Managers and Directors of Rooms to steer daily operations and labor planning."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`"
  dimensions:
    - name: "assignment_date"
      expr: assignment_date
      comment: "Calendar date of the housekeeping assignment — primary time dimension for daily operational trending."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of housekeeping assignment (e.g., stayover, departure, deep clean) — used to segment workload mix."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the assignment (e.g., completed, incomplete, skipped) — key dimension for SLA and throughput analysis."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the post-cleaning inspection (e.g., pass, fail, reclean) — drives quality KPI segmentation."
    - name: "room_status_after"
      expr: room_status_after
      comment: "Room status recorded after assignment completion — used to track room readiness and inventory availability."
    - name: "priority_level"
      expr: priority_level
      comment: "Numeric priority level assigned to the housekeeping task — enables high-priority SLA monitoring."
    - name: "dnd_flag"
      expr: dnd_flag
      comment: "Do Not Disturb flag — identifies assignments blocked by guest DND, impacting service delivery rates."
    - name: "linen_change_flag"
      expr: linen_change_flag
      comment: "Indicates whether a linen change was performed — used for linen cost and sustainability tracking."
    - name: "maintenance_request_flag"
      expr: maintenance_request_flag
      comment: "Indicates whether a maintenance request was raised during the assignment — links housekeeping to maintenance workload."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates whether a formal inspection was required for this assignment — used to measure inspection coverage."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of housekeeping assignments — baseline throughput KPI for staffing and capacity planning."
    - name: "completed_assignments"
      expr: COUNT(CASE WHEN completion_status = 'completed' THEN 1 END)
      comment: "Count of assignments with a completed status — numerator for assignment completion rate."
    - name: "assignment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completion_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of housekeeping assignments completed — core operational SLA metric used by Housekeeping Directors to assess daily service delivery."
    - name: "total_room_credits"
      expr: SUM(CAST(room_credits AS DOUBLE))
      comment: "Total room credits earned across all assignments — primary labor productivity measure used to validate staffing levels against credit targets."
    - name: "avg_room_credits_per_assignment"
      expr: AVG(CAST(room_credits AS DOUBLE))
      comment: "Average room credits per assignment — benchmarked against target credits to identify over- or under-loaded attendants."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of inspected assignments that passed — key quality KPI tied to brand standards and guest satisfaction scores."
    - name: "reclean_required_assignments"
      expr: COUNT(CASE WHEN inspection_result = 'reclean' THEN 1 END)
      comment: "Count of assignments requiring a reclean after inspection — directly measures first-time quality failure rate and drives labor cost overruns."
    - name: "maintenance_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_request_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments that generated a maintenance request — leading indicator of property condition and preventive maintenance gaps."
    - name: "dnd_blocked_assignments"
      expr: COUNT(CASE WHEN dnd_flag = TRUE THEN 1 END)
      comment: "Count of assignments blocked by guest Do Not Disturb — used to track missed service opportunities and adjust scheduling."
    - name: "reassignment_count_total"
      expr: COUNT(CASE WHEN reassignment_count IS NOT NULL THEN 1 END)
      comment: "Count of assignments that were reassigned — proxy for scheduling instability and attendant availability issues."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_cleaning_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Task-level KPIs for housekeeping cleaning activities — measures task execution efficiency, SLA compliance, supply consumption, and quality checkpoint performance. Used by Housekeeping Supervisors and Operations Managers for granular service delivery oversight."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task`"
  dimensions:
    - name: "task_type"
      expr: task_type
      comment: "Category of cleaning task (e.g., room clean, turndown, deep clean) — primary segmentation for workload analysis."
    - name: "task_status"
      expr: task_status
      comment: "Current status of the cleaning task (e.g., pending, in-progress, completed) — used for real-time operational dashboards."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the task (e.g., stayover, departure, VIP) — enables service-tier performance segmentation."
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the cleaning task — used to monitor high-priority task completion rates."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Indicates whether the task was completed within the defined SLA window — core compliance dimension."
    - name: "exception_flag"
      expr: exception_flag
      comment: "Flags tasks that encountered an exception during execution — used to identify operational disruptions."
    - name: "guest_request_flag"
      expr: guest_request_flag
      comment: "Indicates whether the task was triggered by a guest request — used to measure guest-driven service demand."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Indicates whether a formal inspection is required upon task completion — used to track inspection coverage."
    - name: "is_quality_checkpoint"
      expr: is_quality_checkpoint
      comment: "Flags tasks designated as quality checkpoints — used to monitor brand standard compliance touchpoints."
    - name: "scheduled_start_date"
      expr: DATE(scheduled_start_time)
      comment: "Date portion of the scheduled start time — primary time dimension for daily task volume trending."
  measures:
    - name: "total_cleaning_tasks"
      expr: COUNT(1)
      comment: "Total number of cleaning tasks executed — baseline throughput measure for operational capacity planning."
    - name: "sla_compliant_tasks"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Count of tasks completed within SLA — numerator for SLA compliance rate calculation."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cleaning tasks completed within SLA targets — primary service delivery KPI reported to hotel GM and brand auditors."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks that encountered an exception — operational risk indicator used to identify systemic service disruptions."
    - name: "total_supply_quantity_used"
      expr: SUM(CAST(supply_quantity_used AS DOUBLE))
      comment: "Total supply units consumed across all cleaning tasks — drives supply chain replenishment decisions and cost-per-clean analysis."
    - name: "avg_supply_quantity_per_task"
      expr: AVG(CAST(supply_quantity_used AS DOUBLE))
      comment: "Average supply units consumed per cleaning task — benchmarked against standard usage to detect waste or shortage patterns."
    - name: "total_credit_weight"
      expr: SUM(CAST(credit_weight AS DOUBLE))
      comment: "Total credit weight of all cleaning tasks — used to validate labor credit allocation against scheduled targets."
    - name: "avg_credit_weight_per_task"
      expr: AVG(CAST(credit_weight AS DOUBLE))
      comment: "Average credit weight per cleaning task — used to assess task complexity distribution and fair workload allocation."
    - name: "guest_request_task_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_request_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks initiated by guest requests — measures reactive vs. proactive service demand ratio."
    - name: "maintenance_request_generated_count"
      expr: COUNT(CASE WHEN maintenance_request_generated = TRUE THEN 1 END)
      comment: "Count of cleaning tasks that generated a maintenance request — leading indicator of property defect discovery rate during housekeeping rounds."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality assurance KPIs for housekeeping inspections — measures cleanliness scores, deficiency rates, reclean requirements, and room release efficiency. Used by Quality Assurance Managers, Directors of Rooms, and Brand Standards teams to maintain property quality benchmarks."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., supervisor spot-check, full inspection, VIP pre-arrival) — used to segment quality results by inspection rigor."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., completed, pending, in-progress) — used for real-time quality pipeline monitoring."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the inspection (e.g., pass, fail, reclean required) — primary quality result dimension."
    - name: "reclean_required_flag"
      expr: reclean_required_flag
      comment: "Indicates whether a reclean was required after inspection — key first-time quality failure indicator."
    - name: "maintenance_issue_flag"
      expr: maintenance_issue_flag
      comment: "Flags inspections that identified a maintenance issue — links quality inspection to maintenance workload generation."
    - name: "room_release_flag"
      expr: room_release_flag
      comment: "Indicates whether the room was released to inventory after inspection — directly impacts room availability and RevPAR."
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date of the inspection — primary time dimension for daily quality trending."
    - name: "linen_quality_flag"
      expr: linen_quality_flag
      comment: "Indicates whether linen quality met standards during inspection — used for linen vendor and laundry quality monitoring."
    - name: "bathroom_quality_flag"
      expr: bathroom_quality_flag
      comment: "Indicates whether bathroom cleanliness met standards — one of the highest-weighted brand standard criteria."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted — baseline volume measure for quality program coverage."
    - name: "avg_cleanliness_score"
      expr: AVG(CAST(cleanliness_score AS DOUBLE))
      comment: "Average cleanliness score across all inspections — primary quality KPI benchmarked against brand standards and used in GM performance reviews."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average overall quality score per inspection — composite quality indicator used in brand audit reporting and QA dashboards."
    - name: "reclean_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reclean_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring a reclean — direct measure of first-time clean quality failure rate; drives attendant coaching and training decisions."
    - name: "room_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN room_release_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in room release to inventory — measures inspection-to-availability pipeline efficiency, directly impacting check-in readiness."
    - name: "maintenance_issue_detection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_issue_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that identified a maintenance issue — measures housekeeping's role as a first-line property condition sensor."
    - name: "total_inspections_with_critical_deficiency"
      expr: COUNT(CASE WHEN critical_deficiency_count IS NOT NULL AND critical_deficiency_count != '0' THEN 1 END)
      comment: "Count of inspections with at least one critical deficiency recorded — high-severity quality signal used to trigger immediate corrective action."
    - name: "linen_quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN linen_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections where linen quality met standards — used to monitor laundry vendor performance and linen replacement cycles."
    - name: "bathroom_quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bathroom_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections where bathroom cleanliness met standards — highest-weighted brand standard criterion; directly correlated with guest satisfaction scores."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_maintenance_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance request KPIs for the housekeeping domain — measures request volume, resolution cycle times, cost efficiency, and safety hazard rates. Used by Engineering Directors, Facilities Managers, and GMs to manage property condition and maintenance spend."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of maintenance request (e.g., plumbing, electrical, HVAC) — used to segment maintenance workload by trade category."
    - name: "maintenance_request_status"
      expr: maintenance_request_status
      comment: "Current status of the maintenance request (e.g., open, in-progress, closed) — primary dimension for backlog and pipeline monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the maintenance request (e.g., emergency, high, routine) — used to monitor SLA adherence by urgency tier."
    - name: "category"
      expr: category
      comment: "Maintenance category (e.g., preventive, corrective, guest-reported) — used to segment planned vs. reactive maintenance spend."
    - name: "safety_hazard_flag"
      expr: safety_hazard_flag
      comment: "Indicates whether the request involves a safety hazard — critical risk dimension for liability and compliance reporting."
    - name: "guest_impact_flag"
      expr: guest_impact_flag
      comment: "Indicates whether the maintenance issue impacted a guest — used to correlate maintenance failures with guest satisfaction and compensation costs."
    - name: "room_out_of_order_flag"
      expr: room_out_of_order_flag
      comment: "Indicates whether the room was placed out of order due to the maintenance issue — directly impacts room inventory and RevPAR."
    - name: "recurring_issue_flag"
      expr: recurring_issue_flag
      comment: "Flags requests that represent a recurring issue — used to identify systemic property defects requiring capital investment."
    - name: "reported_date"
      expr: DATE(reported_timestamp)
      comment: "Date the maintenance request was reported — primary time dimension for request volume trending."
  measures:
    - name: "total_maintenance_requests"
      expr: COUNT(1)
      comment: "Total number of maintenance requests — baseline volume KPI for engineering workload and staffing planning."
    - name: "open_maintenance_requests"
      expr: COUNT(CASE WHEN maintenance_request_status NOT IN ('closed', 'completed') THEN 1 END)
      comment: "Count of maintenance requests not yet closed — measures active backlog size; used by Engineering Directors to manage resource allocation."
    - name: "safety_hazard_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_hazard_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of maintenance requests flagged as safety hazards — critical risk KPI for liability management and regulatory compliance."
    - name: "guest_impacted_request_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of maintenance requests that impacted a guest — measures maintenance-driven guest experience degradation; linked to compensation and review scores."
    - name: "room_out_of_order_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN room_out_of_order_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of maintenance requests that resulted in a room being placed out of order — directly measures revenue impact of maintenance failures."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of all maintenance requests — primary maintenance spend KPI used in budget variance analysis and capital planning."
    - name: "avg_actual_cost_per_request"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per maintenance request — benchmarked against estimated cost to identify cost overrun patterns by category."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all maintenance requests — used to monitor engineering labor spend and identify overtime drivers."
    - name: "total_materials_cost"
      expr: SUM(CAST(materials_cost_amount AS DOUBLE))
      comment: "Total materials cost across all maintenance requests — used for supply chain and procurement cost management."
    - name: "recurring_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurring_issue_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of maintenance requests flagged as recurring issues — identifies systemic property defects requiring capital remediation investment."
    - name: "cost_overrun_requests"
      expr: COUNT(CASE WHEN actual_cost_amount > estimated_cost_amount THEN 1 END)
      comment: "Count of maintenance requests where actual cost exceeded estimated cost — measures budget estimation accuracy and cost control effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_hk_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor planning and scheduling KPIs for housekeeping — measures schedule adherence, labor budget utilization, credit-per-occupied-room targets, and overtime risk. Used by Housekeeping Directors and HR Business Partners for workforce planning and cost control."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the housekeeping schedule — primary time dimension for labor planning trend analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift scheduled (e.g., AM, PM, split) — used to analyze labor distribution across shift types."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule (e.g., draft, published, finalized) — used to monitor schedule readiness and publication timeliness."
    - name: "section_code"
      expr: section_code
      comment: "Housekeeping section code — enables section-level labor and credit performance analysis."
    - name: "turndown_service_flag"
      expr: turndown_service_flag
      comment: "Indicates whether turndown service is scheduled — used to track turndown coverage rates and associated labor costs."
    - name: "pip_compliance_flag"
      expr: pip_compliance_flag
      comment: "Indicates whether the schedule meets Property Improvement Plan compliance requirements — used for brand standard and franchise compliance reporting."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign rooms to attendants (e.g., manual, automated, zone-based) — used to evaluate scheduling efficiency by method."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of housekeeping schedules created — baseline volume measure for scheduling activity."
    - name: "total_labor_budget_amount"
      expr: SUM(CAST(labor_budget_amount AS DOUBLE))
      comment: "Total labor budget allocated across all schedules — primary cost planning KPI used in P&L and departmental budget reviews."
    - name: "avg_labor_budget_per_schedule"
      expr: AVG(CAST(labor_budget_amount AS DOUBLE))
      comment: "Average labor budget per schedule — used to benchmark daily labor spend against occupancy-adjusted targets."
    - name: "total_section_credit_value"
      expr: SUM(CAST(section_credit_value AS DOUBLE))
      comment: "Total credit value assigned across all scheduled sections — measures total planned workload in credit units for labor adequacy assessment."
    - name: "avg_cpor_target"
      expr: AVG(CAST(cpor_target AS DOUBLE))
      comment: "Average credits-per-occupied-room target across schedules — key labor productivity benchmark used to set staffing ratios and evaluate efficiency."
    - name: "avg_overtime_threshold_hours"
      expr: AVG(CAST(overtime_threshold_hours AS DOUBLE))
      comment: "Average overtime threshold hours configured in schedules — used to monitor overtime risk exposure and labor cost control."
    - name: "pip_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pip_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules meeting PIP compliance requirements — brand standard compliance KPI reported to franchise and ownership groups."
    - name: "turndown_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN turndown_service_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedules that include turndown service — measures turndown program coverage rate against hotel service tier commitments."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_attendant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce KPIs for housekeeping attendants — measures productivity, performance ratings, credit attainment, and workforce composition. Used by Housekeeping Directors and HR to manage attendant performance, retention, and labor compliance."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`attendant`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status of the attendant (e.g., full-time, part-time, on-leave) — used to segment workforce composition and availability."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the attendant (e.g., room attendant, houseperson, supervisor) — used to analyze productivity and credit attainment by role."
    - name: "shift_assignment"
      expr: shift_assignment
      comment: "Shift assigned to the attendant (e.g., AM, PM, overnight) — used to analyze productivity and staffing distribution by shift."
    - name: "section_assignment"
      expr: section_assignment
      comment: "Section of the property assigned to the attendant — enables section-level productivity benchmarking."
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Indicates whether the attendant is a union member — used for labor relations reporting and compliance monitoring."
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates whether the attendant is currently active — used to filter active workforce for productivity analysis."
    - name: "ada_accommodation_flag"
      expr: ada_accommodation_flag
      comment: "Indicates whether the attendant has an ADA accommodation — used for workforce equity and compliance reporting."
    - name: "hire_date"
      expr: hire_date
      comment: "Date the attendant was hired — used for tenure-based productivity and retention analysis."
  measures:
    - name: "total_active_attendants"
      expr: COUNT(CASE WHEN active_flag = TRUE THEN 1 END)
      comment: "Count of currently active housekeeping attendants — baseline workforce capacity measure for staffing adequacy analysis."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average performance rating across all attendants — primary workforce quality KPI used in performance management and coaching prioritization."
    - name: "avg_credits_per_shift"
      expr: AVG(CAST(average_credits_per_shift AS DOUBLE))
      comment: "Average credits earned per shift across all attendants — measures actual labor productivity against target credit benchmarks."
    - name: "avg_target_credits_per_shift"
      expr: AVG(CAST(target_credits_per_shift AS DOUBLE))
      comment: "Average target credits per shift — used as the productivity benchmark denominator for credit attainment rate calculation."
    - name: "credit_attainment_rate_pct"
      expr: ROUND(100.0 * AVG(CAST(average_credits_per_shift AS DOUBLE)) / NULLIF(AVG(CAST(target_credits_per_shift AS DOUBLE)), 0), 2)
      comment: "Ratio of average actual credits per shift to average target credits per shift — measures workforce productivity attainment against labor standards; key KPI for staffing model validation."
    - name: "union_member_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_member_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendants who are union members — used for labor relations planning, contract compliance, and collective bargaining analysis."
    - name: "attendants_below_target_credits"
      expr: COUNT(CASE WHEN average_credits_per_shift < target_credits_per_shift THEN 1 END)
      comment: "Count of attendants whose average credits per shift fall below their target — identifies underperforming staff requiring coaching or workload rebalancing."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_lost_and_found`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lost and found KPIs for the housekeeping domain — measures item recovery rates, claim resolution efficiency, high-value item handling, and guest notification performance. Used by Front Office Managers and Housekeeping Directors to manage guest property liability and service recovery."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found`"
  dimensions:
    - name: "lost_and_found_status"
      expr: lost_and_found_status
      comment: "Current status of the lost and found item (e.g., found, claimed, disposed) — primary dimension for item lifecycle tracking."
    - name: "claim_status"
      expr: claim_status
      comment: "Status of the guest claim for the item (e.g., pending, verified, returned) — used to monitor claim resolution pipeline."
    - name: "disposition_type"
      expr: disposition_type
      comment: "How the item was ultimately disposed of (e.g., returned to guest, donated, discarded) — used to measure return-to-guest success rates."
    - name: "item_category"
      expr: item_category
      comment: "Category of the lost item (e.g., electronics, clothing, documents) — used to identify high-frequency loss categories and storage requirements."
    - name: "discovery_location_type"
      expr: discovery_location_type
      comment: "Type of location where the item was discovered (e.g., guest room, restaurant, pool) — used to identify high-loss areas."
    - name: "is_high_value_item"
      expr: is_high_value_item
      comment: "Indicates whether the item is classified as high value — used to ensure proper handling protocols and liability management."
    - name: "guest_notification_status"
      expr: guest_notification_status
      comment: "Status of guest notification for the found item — used to monitor notification SLA compliance."
    - name: "discovery_date"
      expr: discovery_date
      comment: "Date the item was discovered — primary time dimension for lost and found volume trending."
    - name: "requires_special_handling"
      expr: requires_special_handling
      comment: "Indicates whether the item requires special handling (e.g., perishables, medications) — used to ensure compliance with handling protocols."
  measures:
    - name: "total_lost_and_found_items"
      expr: COUNT(1)
      comment: "Total number of lost and found items logged — baseline volume measure for program activity and storage capacity planning."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value_amount AS DOUBLE))
      comment: "Total estimated value of all lost and found items — measures total liability exposure from unclaimed guest property."
    - name: "avg_estimated_value_per_item"
      expr: AVG(CAST(estimated_value_amount AS DOUBLE))
      comment: "Average estimated value per lost and found item — used to assess average liability per item and prioritize high-value item handling."
    - name: "high_value_item_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_high_value_item = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lost and found items classified as high value — used to assess liability concentration and ensure premium handling protocol compliance."
    - name: "item_return_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition_type = 'returned' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lost items successfully returned to guests — primary service recovery KPI for lost and found program effectiveness."
    - name: "guest_notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN guest_notification_status = 'notified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of found items where the guest was successfully notified — measures proactive service recovery and notification SLA adherence."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost incurred for returning lost items to guests — measures operational cost of the lost and found return program."
    - name: "unclaimed_items_count"
      expr: COUNT(CASE WHEN claim_status IS NULL OR claim_status = 'unclaimed' THEN 1 END)
      comment: "Count of items with no active claim — used to manage retention expiry, storage capacity, and disposition scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`housekeeping_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution KPIs for the housekeeping domain — measures work order completion rates, inspection scores, labor and supply costs, and room status impact. Used by Engineering Managers and Directors of Operations to manage maintenance execution quality and cost."
  source: "`vibe_travel_hospitality_v1`.`housekeeping`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g., preventive maintenance, corrective, guest request) — primary segmentation for workload and cost analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g., open, in-progress, completed, cancelled) — used for backlog and pipeline monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order (e.g., emergency, high, routine) — used to monitor SLA adherence by urgency tier."
    - name: "room_status_after"
      expr: room_status_after
      comment: "Room status after work order completion — measures work order impact on room inventory availability."
    - name: "linen_change_required"
      expr: linen_change_required
      comment: "Indicates whether a linen change was required as part of the work order — used for linen cost attribution."
    - name: "maintenance_handoff_required"
      expr: maintenance_handoff_required
      comment: "Indicates whether the work order required a handoff to the maintenance team — used to measure cross-department coordination volume."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date of the work order — primary time dimension for work order volume trending."
    - name: "amenity_replenishment_required"
      expr: amenity_replenishment_required
      comment: "Indicates whether amenity replenishment was required — used to track amenity supply demand driven by work orders."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders created — baseline throughput measure for engineering and housekeeping operational workload."
    - name: "completed_work_orders"
      expr: COUNT(CASE WHEN work_order_status = 'completed' THEN 1 END)
      comment: "Count of completed work orders — numerator for work order completion rate."
    - name: "work_order_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN work_order_status = 'completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders completed — primary execution efficiency KPI used by Engineering Directors to assess team throughput."
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average inspection score across completed work orders — measures quality of work order execution against brand and safety standards."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all work orders — primary cost KPI for engineering labor spend management and budget variance analysis."
    - name: "total_supply_cost"
      expr: SUM(CAST(supply_cost_amount AS DOUBLE))
      comment: "Total supply cost across all work orders — used for materials spend management and procurement planning."
    - name: "avg_labor_cost_per_work_order"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per work order — benchmarked by work order type to identify cost efficiency opportunities."
    - name: "maintenance_handoff_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN maintenance_handoff_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders requiring a maintenance handoff — measures cross-functional coordination burden and identifies complex issue patterns."
$$;