-- Metric views for domain: maintenance | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core work order execution metrics covering cost performance, labour efficiency, schedule adherence, and work order throughput. Primary KPI layer for maintenance execution governance."
  source: "`mining_ecm`.`maintenance`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g. corrective, preventive, shutdown) enabling cost and volume analysis by maintenance strategy type."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current lifecycle status of the work order (e.g. open, in-progress, completed, cancelled) for pipeline and backlog analysis."
    - name: "priority"
      expr: priority
      comment: "Work order priority classification (e.g. emergency, high, medium, low) for triage and resource allocation analysis."
    - name: "work_centre"
      expr: work_centre
      comment: "Maintenance work centre responsible for execution, enabling performance benchmarking across organisational units."
    - name: "trade_craft_required"
      expr: trade_craft_required
      comment: "Trade or craft skill required for the work order, supporting workforce planning and skills gap analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the work order, used to identify bottlenecks in the authorisation pipeline."
    - name: "shutdown_flag"
      expr: shutdown_flag
      comment: "Indicates whether the work order requires a plant or equipment shutdown, critical for production impact planning."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode classification associated with the work order, enabling reliability-centred maintenance analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of the planned start date for trend analysis of work order scheduling volumes."
    - name: "originating_source"
      expr: originating_source
      comment: "Source that triggered the work order (e.g. PM schedule, breakdown, inspection) for root cause and demand analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline volume metric for maintenance workload and backlog management."
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual maintenance spend across all work orders. Primary cost governance metric for maintenance budget control."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all work orders. Used as denominator for cost variance and budget accuracy analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Aggregate cost variance (actual minus estimated) across work orders. Negative variance indicates over-run; positive indicates under-run."
    - name: "total_actual_labour_hours"
      expr: SUM(CAST(actual_labour_hours AS DOUBLE))
      comment: "Total actual labour hours consumed across all work orders. Key input for workforce utilisation and productivity analysis."
    - name: "total_estimated_labour_hours"
      expr: SUM(CAST(estimated_labour_hours AS DOUBLE))
      comment: "Total planned labour hours across all work orders. Used as denominator for labour efficiency ratio calculations."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours attributed to work orders. Directly linked to production loss and availability KPIs."
    - name: "total_parts_materials_cost"
      expr: SUM(CAST(parts_materials_cost AS DOUBLE))
      comment: "Total parts and materials cost across work orders. Supports spare parts spend analysis and inventory optimisation decisions."
    - name: "total_contractor_cost"
      expr: SUM(CAST(contractor_cost AS DOUBLE))
      comment: "Total contractor spend across work orders. Enables make-vs-buy and contractor performance cost analysis."
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total internal labour cost across work orders. Used to split maintenance spend between internal and external resources."
    - name: "avg_actual_cost_per_work_order"
      expr: AVG(CAST(total_actual_cost AS DOUBLE))
      comment: "Average actual cost per work order. Benchmarking metric for cost efficiency across work centres and asset classes."
    - name: "avg_actual_labour_hours_per_work_order"
      expr: AVG(CAST(actual_labour_hours AS DOUBLE))
      comment: "Average actual labour hours per work order. Indicates task complexity and workforce efficiency trends."
    - name: "distinct_assets_maintained"
      expr: COUNT(DISTINCT asset_id)
      comment: "Count of distinct assets with active work orders. Measures breadth of maintenance activity across the asset fleet."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_equipment_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment availability and downtime analytics covering duration, cost, production impact, and response performance. Critical for asset reliability and OEE governance."
  source: "`mining_ecm`.`maintenance`.`equipment_downtime`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "High-level category of downtime (e.g. planned, unplanned, operational) for availability classification."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime event enabling granular root cause and trend analysis."
    - name: "cause_code"
      expr: cause_code
      comment: "Coded cause of the downtime event. Used in Pareto analysis to identify dominant failure drivers."
    - name: "primary_failure_code"
      expr: primary_failure_code
      comment: "Primary failure code classification for reliability engineering and FMEA validation."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for the downtime event, enabling accountability and performance management."
    - name: "shift"
      expr: shift
      comment: "Operational shift during which the downtime occurred. Supports shift-level performance benchmarking."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority assigned to the downtime event, reflecting urgency and production criticality."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether the downtime event was associated with a safety incident, for HSE-linked reliability analysis."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Flags downtime events with environmental impact, supporting regulatory and ESG reporting."
    - name: "downtime_start_month"
      expr: DATE_TRUNC('month', CAST(downtime_start_timestamp AS DATE))
      comment: "Month bucket of downtime start for trend analysis of downtime frequency and duration over time."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events. Baseline frequency metric for reliability and availability tracking."
    - name: "total_downtime_duration_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total hours of equipment downtime. Primary availability metric directly impacting production throughput and OEE."
    - name: "avg_downtime_duration_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime duration per event. Proxy for Mean Time To Repair (MTTR) at the event level."
    - name: "total_production_impact_tonnes"
      expr: SUM(CAST(production_impact_tonnes AS DOUBLE))
      comment: "Total production loss in tonnes attributable to downtime events. Directly quantifies revenue impact of equipment failures."
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual cost of repairs associated with downtime events. Core maintenance cost governance metric."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across downtime events. Used as denominator for repair cost accuracy analysis."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average time from downtime event detection to maintenance response. Key SLA and maintenance readiness KPI."
    - name: "avg_repair_time_minutes"
      expr: AVG(CAST(repair_time_minutes AS DOUBLE))
      comment: "Average repair duration in minutes per downtime event. Operational MTTR proxy for maintenance efficiency benchmarking."
    - name: "distinct_assets_with_downtime"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets that experienced downtime. Measures fleet-wide reliability exposure."
    - name: "unplanned_downtime_events"
      expr: COUNT(CASE WHEN downtime_category = 'Unplanned' THEN 1 END)
      comment: "Count of unplanned downtime events. Critical reliability KPI — high unplanned downtime signals deteriorating asset health."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_failure_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure analysis and reliability metrics covering failure modes, severity, production loss, RCA completion, and repeat failure rates. Drives reliability improvement and FMEA governance."
  source: "`mining_ecm`.`maintenance`.`failure_report`"
  dimensions:
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode classification (e.g. fatigue, corrosion, wear) for reliability-centred maintenance analysis."
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Coded failure mode for systematic FMEA and reliability database integration."
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code of the failure, enabling Pareto analysis of dominant failure drivers across the asset fleet."
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity classification of the failure (e.g. critical, major, minor) for risk-based prioritisation."
    - name: "event_classification"
      expr: event_classification
      comment: "Classification of the failure event type for regulatory and insurance reporting purposes."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the failure was detected (e.g. condition monitoring, operator observation, inspection) for PF-interval analysis."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the failure report (e.g. open, under investigation, closed) for backlog management."
    - name: "rca_performed_flag"
      expr: rca_performed_flag
      comment: "Indicates whether a Root Cause Analysis was performed. Used to track RCA compliance against governance targets."
    - name: "repeat_failure_flag"
      expr: repeat_failure_flag
      comment: "Flags repeat failures on the same asset/component. High repeat rate signals ineffective corrective actions."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether the failure resulted in a safety incident, for HSE-linked reliability governance."
    - name: "failure_month"
      expr: DATE_TRUNC('month', CAST(failure_timestamp AS DATE))
      comment: "Month bucket of failure occurrence for trend analysis of failure frequency and severity over time."
  measures:
    - name: "total_failure_reports"
      expr: COUNT(1)
      comment: "Total number of failure reports. Baseline reliability metric for fleet-wide failure frequency tracking."
    - name: "total_failure_cost"
      expr: SUM(CAST(failure_cost AS DOUBLE))
      comment: "Total financial cost of failures including repair, production loss, and consequential costs. Primary reliability cost KPI."
    - name: "total_production_loss_tonnes"
      expr: SUM(CAST(production_loss_tonnes AS DOUBLE))
      comment: "Total production loss in tonnes attributable to failures. Directly quantifies revenue impact of reliability events."
    - name: "avg_estimated_mtbf_gain_hours"
      expr: AVG(CAST(estimated_mtbf_gain_hours AS DOUBLE))
      comment: "Average estimated MTBF improvement from corrective actions taken. Measures effectiveness of reliability improvement initiatives."
    - name: "repeat_failure_count"
      expr: COUNT(CASE WHEN repeat_failure_flag = TRUE THEN 1 END)
      comment: "Count of repeat failures. High repeat failure count indicates systemic issues with corrective action effectiveness."
    - name: "rca_completed_count"
      expr: COUNT(CASE WHEN rca_performed_flag = TRUE THEN 1 END)
      comment: "Count of failure reports where RCA was completed. Measures governance compliance with RCA policy for critical failures."
    - name: "safety_related_failures"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of failures with associated safety incidents. Critical HSE governance metric for zero-harm programmes."
    - name: "distinct_assets_with_failures"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets with recorded failures. Measures breadth of reliability exposure across the fleet."
    - name: "avg_failure_cost"
      expr: AVG(CAST(failure_cost AS DOUBLE))
      comment: "Average cost per failure event. Benchmarking metric for failure severity and cost-of-unreliability analysis."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule compliance and planning metrics. Tracks PM programme health, overdue schedules, cost estimates, and safety-critical coverage."
  source: "`mining_ecm`.`maintenance`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (e.g. active, overdue, suspended) for compliance and backlog management."
    - name: "frequency_type"
      expr: frequency_type
      comment: "Frequency type of the PM schedule (e.g. calendar, meter-based, condition-based) for strategy mix analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority classification of the PM schedule for resource allocation and scheduling optimisation."
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Indicates safety-critical PM schedules requiring mandatory compliance for regulatory and HSE governance."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Flags PM schedules with environmental compliance obligations, supporting regulatory reporting."
    - name: "shutdown_required_flag"
      expr: shutdown_required_flag
      comment: "Indicates PM tasks requiring equipment shutdown, critical for production planning and outage scheduling."
    - name: "isolation_required_flag"
      expr: isolation_required_flag
      comment: "Flags PM schedules requiring energy isolation, supporting safety permit planning."
    - name: "next_due_date_month"
      expr: DATE_TRUNC('month', next_due_date)
      comment: "Month bucket of next PM due date for forward workload planning and scheduling horizon analysis."
    - name: "interval_unit"
      expr: interval_unit
      comment: "Unit of the PM interval (e.g. days, hours, cycles) for schedule type and frequency analysis."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules in the programme. Baseline metric for PM programme scope and coverage."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all PM schedules. Primary input for maintenance budget planning and OPEX forecasting."
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated labour hours across all PM schedules. Drives workforce capacity planning for the PM programme."
    - name: "avg_compliance_target_percentage"
      expr: AVG(CAST(compliance_target_percentage AS DOUBLE))
      comment: "Average PM compliance target percentage across schedules. Governance benchmark for PM programme performance expectations."
    - name: "avg_estimated_cost_per_schedule"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per PM schedule. Used for cost benchmarking and identifying high-cost PM tasks for optimisation."
    - name: "safety_critical_pm_count"
      expr: COUNT(CASE WHEN safety_critical_flag = TRUE THEN 1 END)
      comment: "Count of safety-critical PM schedules. Mandatory governance metric ensuring safety-critical maintenance coverage is maintained."
    - name: "overdue_pm_count"
      expr: COUNT(CASE WHEN schedule_status = 'Overdue' THEN 1 END)
      comment: "Count of overdue PM schedules. Critical compliance KPI — high overdue count signals risk to asset reliability and regulatory compliance."
    - name: "shutdown_required_pm_count"
      expr: COUNT(CASE WHEN shutdown_required_flag = TRUE THEN 1 END)
      comment: "Count of PM schedules requiring equipment shutdown. Key input for outage planning and production impact assessment."
    - name: "distinct_assets_on_pm"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets covered by PM schedules. Measures PM programme fleet coverage breadth."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_work_order_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular maintenance cost analytics by cost type, GL account, and approval status. Supports financial governance, AISC allocation, and cost variance management."
  source: "`mining_ecm`.`maintenance`.`work_order_cost`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost record (e.g. labour, materials, contractor, equipment hire) for spend category analysis."
    - name: "cost_status"
      expr: cost_status
      comment: "Processing status of the cost record (e.g. posted, pending, reversed) for financial close and accrual management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the cost record, identifying bottlenecks in financial authorisation."
    - name: "aisc_allocation_flag"
      expr: aisc_allocation_flag
      comment: "Indicates whether the cost is allocated to All-In Sustaining Cost (AISC). Critical for mining cost reporting to investors."
    - name: "c1_allocation_flag"
      expr: c1_allocation_flag
      comment: "Indicates whether the cost is allocated to C1 cash cost. Key metric for mining industry cost competitiveness benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost record for multi-currency operations and FX exposure analysis."
    - name: "cost_posting_date_month"
      expr: DATE_TRUNC('month', cost_posting_date)
      comment: "Month bucket of cost posting date for period-over-period maintenance spend trend analysis."
  measures:
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual maintenance cost posted. Primary financial governance metric for maintenance spend control."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated maintenance cost. Used as denominator for cost accuracy and variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Aggregate cost variance (actual vs estimated) across all cost records. Negative values indicate budget over-run."
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total labour cost component of maintenance spend. Supports workforce cost analysis and make-vs-buy decisions."
    - name: "total_parts_materials_cost"
      expr: SUM(CAST(parts_materials_cost AS DOUBLE))
      comment: "Total parts and materials cost. Drives spare parts inventory investment and procurement strategy decisions."
    - name: "total_contractor_cost"
      expr: SUM(CAST(contractor_cost AS DOUBLE))
      comment: "Total contractor cost. Enables contractor spend governance and insource-vs-outsource strategic analysis."
    - name: "total_equipment_hire_cost"
      expr: SUM(CAST(equipment_hire_cost AS DOUBLE))
      comment: "Total equipment hire cost. Informs decisions on owned vs hired equipment for maintenance activities."
    - name: "avg_cost_variance_percentage"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage per cost record. Measures estimating accuracy and budget discipline across the maintenance programme."
    - name: "aisc_allocated_cost"
      expr: SUM(CASE WHEN aisc_allocation_flag = TRUE THEN CAST(total_actual_cost AS DOUBLE) ELSE 0 END)
      comment: "Total maintenance cost allocated to AISC. Critical for mining investor reporting and cost-per-ounce/tonne calculations."
    - name: "c1_allocated_cost"
      expr: SUM(CASE WHEN c1_allocation_flag = TRUE THEN CAST(total_actual_cost AS DOUBLE) ELSE 0 END)
      comment: "Total maintenance cost allocated to C1 cash cost. Key input for mining industry cost competitiveness benchmarking."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_shutdown_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shutdown and major maintenance outage performance metrics covering cost, duration, schedule adherence, and production impact. Supports capital project governance and outage optimisation."
  source: "`mining_ecm`.`maintenance`.`shutdown_plan`"
  dimensions:
    - name: "shutdown_type"
      expr: shutdown_type
      comment: "Type of shutdown (e.g. annual, statutory, emergency, campaign) for outage category analysis and planning."
    - name: "shutdown_status"
      expr: shutdown_status
      comment: "Current lifecycle status of the shutdown plan (e.g. planning, in-progress, completed) for programme governance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the shutdown plan, tracking governance compliance in the authorisation process."
    - name: "contractor_involvement_flag"
      expr: contractor_involvement_flag
      comment: "Indicates whether contractors are involved in the shutdown, for contractor management and cost planning."
    - name: "environmental_permit_required_flag"
      expr: environmental_permit_required_flag
      comment: "Flags shutdowns requiring environmental permits, supporting regulatory compliance planning."
    - name: "safety_permit_required_flag"
      expr: safety_permit_required_flag
      comment: "Flags shutdowns requiring safety permits, ensuring HSE compliance in outage execution."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month bucket of planned shutdown start date for outage calendar and production planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of shutdown cost records for multi-currency financial reporting."
  measures:
    - name: "total_shutdowns"
      expr: COUNT(1)
      comment: "Total number of shutdown plans. Baseline metric for outage programme scope and frequency."
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual cost across all shutdowns. Primary capital and OPEX governance metric for outage spend control."
    - name: "total_planned_cost"
      expr: SUM(CAST(total_planned_cost AS DOUBLE))
      comment: "Total planned cost across all shutdowns. Used as denominator for shutdown cost performance analysis."
    - name: "total_actual_duration_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Total actual shutdown duration hours. Measures total production unavailability from planned outages."
    - name: "total_planned_duration_hours"
      expr: SUM(CAST(planned_duration_hours AS DOUBLE))
      comment: "Total planned shutdown duration hours. Used as denominator for schedule performance index calculations."
    - name: "total_production_loss_tonnes"
      expr: SUM(CAST(production_loss_tonnes AS DOUBLE))
      comment: "Total production loss in tonnes from shutdowns. Directly quantifies revenue opportunity cost of planned outages."
    - name: "total_actual_labour_hours"
      expr: SUM(CAST(total_actual_labour_hours AS DOUBLE))
      comment: "Total actual labour hours consumed across shutdowns. Key workforce productivity and resource utilisation metric."
    - name: "total_planned_labour_hours"
      expr: SUM(CAST(total_planned_labour_hours AS DOUBLE))
      comment: "Total planned labour hours across shutdowns. Used as denominator for labour productivity analysis."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average scope completion percentage across shutdowns. Measures execution effectiveness against planned scope."
    - name: "total_capex_amount"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Total capital expenditure component of shutdown costs. Supports CAPEX governance and fixed asset investment tracking."
    - name: "total_opex_amount"
      expr: SUM(CAST(opex_amount AS DOUBLE))
      comment: "Total operating expenditure component of shutdown costs. Supports OPEX budget management and period cost reporting."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_condition_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Condition monitoring and predictive maintenance analytics covering defect detection rates, alert levels, inspection compliance, and follow-up work order generation. Drives PdM programme effectiveness."
  source: "`mining_ecm`.`maintenance`.`condition_monitoring`"
  dimensions:
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of condition monitoring technique (e.g. vibration, thermography, oil analysis) for technology mix analysis."
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Current status of the monitoring activity (e.g. active, overdue, completed) for programme compliance tracking."
    - name: "alert_level"
      expr: alert_level
      comment: "Alert level triggered by the measurement (e.g. normal, warning, alarm) for risk prioritisation."
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity of defect identified during condition monitoring, for risk-based maintenance prioritisation."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of the measured parameter trend (e.g. increasing, stable, decreasing) for predictive failure analysis."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass/fail outcome of the inspection or measurement for compliance and asset health reporting."
    - name: "statutory_inspection_flag"
      expr: statutory_inspection_flag
      comment: "Indicates statutory/regulatory inspection requirements, critical for compliance and licence-to-operate governance."
    - name: "defect_identified_flag"
      expr: defect_identified_flag
      comment: "Flags monitoring records where a defect was identified, for defect detection rate analysis."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of monitoring (e.g. daily, weekly, monthly) for programme intensity and coverage analysis."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', CAST(measurement_timestamp AS DATE))
      comment: "Month bucket of measurement timestamp for trend analysis of condition monitoring activity and defect rates."
  measures:
    - name: "total_monitoring_records"
      expr: COUNT(1)
      comment: "Total condition monitoring measurements recorded. Baseline metric for PdM programme activity and coverage."
    - name: "defects_identified_count"
      expr: COUNT(CASE WHEN defect_identified_flag = TRUE THEN 1 END)
      comment: "Count of monitoring records where a defect was identified. Primary PdM effectiveness metric — measures early fault detection capability."
    - name: "follow_up_work_orders_raised"
      expr: COUNT(CASE WHEN follow_up_work_order_flag = TRUE THEN 1 END)
      comment: "Count of condition monitoring records that triggered a follow-up work order. Measures PdM-to-corrective action conversion rate."
    - name: "statutory_inspections_count"
      expr: COUNT(CASE WHEN statutory_inspection_flag = TRUE THEN 1 END)
      comment: "Count of statutory inspection records. Mandatory compliance metric for regulatory licence-to-operate obligations."
    - name: "alarm_threshold_exceedances"
      expr: COUNT(CASE WHEN alert_level = 'Alarm' THEN 1 END)
      comment: "Count of measurements exceeding alarm thresholds. Critical asset health KPI indicating imminent failure risk."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured parameter value across monitoring records. Baseline for trend analysis and threshold calibration."
    - name: "distinct_assets_monitored"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets under active condition monitoring. Measures PdM programme fleet coverage."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_parts_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts and materials consumption analytics covering spend, quantity, warranty claims, and rotable returns. Drives inventory optimisation and procurement strategy decisions."
  source: "`mining_ecm`.`maintenance`.`parts_consumption`"
  dimensions:
    - name: "opex_category"
      expr: opex_category
      comment: "OPEX category of the parts consumption for cost classification and financial reporting."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of parts transaction (e.g. issue, return, reversal) for inventory movement analysis."
    - name: "store_location_code"
      expr: store_location_code
      comment: "Store location from which parts were issued, for inventory distribution and logistics analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the parts transaction for multi-currency procurement and cost reporting."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Indicates whether a warranty claim was raised for the consumed part, for warranty recovery tracking."
    - name: "rotable_return_flag"
      expr: rotable_return_flag
      comment: "Indicates whether a rotable part was returned for repair/refurbishment, for rotable asset lifecycle management."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed transactions for data quality and inventory accuracy monitoring."
    - name: "aisc_allocation_flag"
      expr: aisc_allocation_flag
      comment: "Indicates AISC cost allocation for parts consumption, supporting mining industry cost reporting."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month bucket of parts issue date for consumption trend analysis and demand forecasting."
  measures:
    - name: "total_parts_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of parts and materials consumed. Primary inventory spend metric for maintenance cost management."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of parts issued. Baseline consumption volume metric for demand planning and reorder analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of parts consumed. Used for price trend analysis and procurement benchmarking."
    - name: "warranty_claims_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Count of parts transactions with warranty claims raised. Measures warranty recovery opportunity and supplier quality performance."
    - name: "distinct_spare_parts_consumed"
      expr: COUNT(DISTINCT spare_part_id)
      comment: "Number of distinct spare parts consumed. Measures parts catalogue utilisation and identifies slow-moving inventory."
    - name: "distinct_assets_with_parts_consumption"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets consuming parts. Measures breadth of maintenance parts demand across the fleet."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity of parts requested. Used as denominator for parts fill-rate analysis (issued vs requested)."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_labour_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance labour productivity and cost analytics covering hours worked, overtime, cost rates, and workforce utilisation. Supports workforce planning and labour cost governance."
  source: "`mining_ecm`.`maintenance`.`labour_record`"
  dimensions:
    - name: "trade_craft"
      expr: trade_craft
      comment: "Trade or craft classification of the worker (e.g. electrician, fitter, welder) for skills-based workforce analysis."
    - name: "source_type"
      expr: source_type
      comment: "Source of labour (e.g. internal, contractor) for make-vs-buy workforce cost analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the labour record for timesheet governance and payroll processing."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code during which labour was performed for shift-level productivity benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the labour cost record for multi-currency workforce cost reporting."
    - name: "work_date_month"
      expr: DATE_TRUNC('month', work_date)
      comment: "Month bucket of work date for period-over-period labour cost and hours trend analysis."
  measures:
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total maintenance labour cost. Primary workforce spend metric for maintenance cost governance and budget control."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours worked. Baseline workforce utilisation metric for capacity planning."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. High overtime signals under-resourcing or poor schedule adherence, driving workforce planning decisions."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked across all labour records. Comprehensive workforce utilisation metric for maintenance capacity analysis."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly labour rate. Benchmarking metric for workforce cost efficiency and contractor rate governance."
    - name: "distinct_workers"
      expr: COUNT(DISTINCT worker_name)
      comment: "Count of distinct workers with labour records. Measures active maintenance workforce size for capacity planning."
    - name: "distinct_work_orders_with_labour"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Count of distinct work orders with labour recorded. Measures labour programme breadth and timesheet coverage."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`maintenance_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance strategy portfolio analytics covering target reliability KPIs, cost estimates, strategy type mix, and RCM programme governance. Supports strategic asset management decisions."
  source: "`mining_ecm`.`maintenance`.`strategy`"
  dimensions:
    - name: "strategy_type"
      expr: strategy_type
      comment: "Type of maintenance strategy (e.g. RCM, TPM, run-to-failure, condition-based) for strategy mix analysis."
    - name: "strategy_status"
      expr: strategy_status
      comment: "Current status of the strategy (e.g. active, under review, superseded) for programme governance."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of assets covered by the strategy (e.g. A, B, C) for risk-based maintenance prioritisation."
    - name: "maintenance_philosophy"
      expr: maintenance_philosophy
      comment: "Overarching maintenance philosophy (e.g. preventive, predictive, reactive) for strategic alignment analysis."
    - name: "condition_monitoring_flag"
      expr: condition_monitoring_flag
      comment: "Indicates strategies incorporating condition monitoring, measuring PdM programme adoption."
    - name: "predictive_analytics_flag"
      expr: predictive_analytics_flag
      comment: "Indicates strategies using predictive analytics, measuring digital maintenance maturity."
    - name: "shutdown_strategy_flag"
      expr: shutdown_strategy_flag
      comment: "Flags strategies that include shutdown-based maintenance, for outage planning integration."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of strategy cost estimates for multi-currency financial planning."
  measures:
    - name: "total_strategies"
      expr: COUNT(1)
      comment: "Total number of maintenance strategies in the portfolio. Baseline metric for strategy programme scope."
    - name: "total_estimated_annual_cost"
      expr: SUM(CAST(estimated_annual_cost AS DOUBLE))
      comment: "Total estimated annual maintenance cost across all strategies. Primary input for long-range maintenance budget planning."
    - name: "avg_target_mtbf_hours"
      expr: AVG(CAST(target_mtbf_hours AS DOUBLE))
      comment: "Average target MTBF hours across strategies. Measures the reliability ambition of the maintenance programme."
    - name: "avg_target_mttr_hours"
      expr: AVG(CAST(target_mttr_hours AS DOUBLE))
      comment: "Average target MTTR hours across strategies. Measures the maintainability ambition and response capability targets."
    - name: "avg_target_oee_percent"
      expr: AVG(CAST(target_oee_percent AS DOUBLE))
      comment: "Average target OEE percentage across strategies. Directly links maintenance strategy to production efficiency targets."
    - name: "predictive_strategy_count"
      expr: COUNT(CASE WHEN predictive_analytics_flag = TRUE THEN 1 END)
      comment: "Count of strategies using predictive analytics. Measures digital maintenance maturity and PdM programme adoption."
    - name: "condition_monitoring_strategy_count"
      expr: COUNT(CASE WHEN condition_monitoring_flag = TRUE THEN 1 END)
      comment: "Count of strategies incorporating condition monitoring. Measures PdM coverage across the asset management programme."
$$;