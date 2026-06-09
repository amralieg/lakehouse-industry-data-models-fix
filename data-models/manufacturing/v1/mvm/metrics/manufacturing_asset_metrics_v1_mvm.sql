-- Metric views for domain: asset | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for asset downtime events — tracks production loss, financial impact, OEE availability degradation, and repeat-failure rates to steer maintenance investment and reliability improvement programs."
  source: "`manufacturing_ecm`.`asset`.`asset_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "High-level category of the downtime event (e.g. mechanical, electrical, process) used to prioritise improvement initiatives."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime (planned vs unplanned) enabling separation of scheduled maintenance from unexpected failures."
    - name: "failure_class"
      expr: failure_class
      comment: "Classification of the failure mode to support FMEA and reliability-centred maintenance analysis."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance response triggered (corrective, preventive, predictive) to evaluate maintenance strategy effectiveness."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Coded root cause of the downtime event enabling Pareto analysis of failure drivers."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the downtime occurred for site-level benchmarking."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the downtime event (open, closed, under investigation) for workload management."
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Flag indicating whether this is a recurrence of a previously resolved failure, highlighting chronic reliability issues."
    - name: "is_safety_incident"
      expr: is_safety_incident
      comment: "Flag indicating whether the downtime event involved a safety incident, critical for EHS reporting."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Flag indicating environmental impact associated with the downtime event for sustainability reporting."
    - name: "downtime_event_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the downtime event started, enabling trend analysis over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which financial loss estimates are denominated."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events recorded. Baseline volume metric for reliability trend monitoring."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total cumulative downtime duration in minutes. Directly measures lost production capacity and is a primary input to OEE availability calculations."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per downtime event in minutes. Indicates typical severity of failures and effectiveness of rapid-response maintenance."
    - name: "total_estimated_loss_cost"
      expr: SUM(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Total estimated financial loss from downtime events. Key financial KPI for quantifying the cost of unreliability and justifying maintenance investment."
    - name: "avg_estimated_loss_cost_per_event"
      expr: AVG(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Average financial loss per downtime event. Enables prioritisation of high-cost failure modes for targeted reliability improvement."
    - name: "total_estimated_production_loss_units"
      expr: SUM(CAST(estimated_production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime. Directly links asset reliability to production throughput and customer delivery performance."
    - name: "total_repair_time_minutes"
      expr: SUM(CAST(repair_time_minutes AS DOUBLE))
      comment: "Total time spent on repairs across all downtime events. Measures maintenance labour burden and informs workforce planning."
    - name: "avg_repair_time_minutes"
      expr: AVG(CAST(repair_time_minutes AS DOUBLE))
      comment: "Average repair time per event (proxy for Mean Time To Repair). A core maintenance efficiency KPI tracked by reliability engineers and operations leadership."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average time from failure detection to maintenance response. Measures maintenance team responsiveness and SLA adherence."
    - name: "avg_oee_availability_impact_pct"
      expr: AVG(CAST(oee_availability_impact_pct AS DOUBLE))
      comment: "Average OEE availability impact percentage per downtime event. Directly quantifies the drag on Overall Equipment Effectiveness from unplanned stoppages."
    - name: "repeat_failure_event_count"
      expr: COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END)
      comment: "Number of downtime events that are repeat failures. High repeat failure counts signal inadequate root-cause resolution and drive CAPA escalation."
    - name: "repeat_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that are repeat failures. A strategic reliability KPI — high rates indicate systemic maintenance quality issues requiring leadership intervention."
    - name: "safety_incident_event_count"
      expr: COUNT(CASE WHEN is_safety_incident = TRUE THEN 1 END)
      comment: "Number of downtime events associated with safety incidents. Zero-tolerance KPI monitored at board level for EHS compliance and risk management."
    - name: "unplanned_downtime_event_count"
      expr: COUNT(CASE WHEN downtime_type = 'Unplanned' THEN 1 END)
      comment: "Count of unplanned downtime events. Separates reactive maintenance burden from planned activities, a key input to maintenance strategy reviews."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance work order performance KPIs — tracks cost variance, schedule adherence, labour efficiency, and backlog to steer maintenance operations and capital planning."
  source: "`manufacturing_ecm`.`asset`.`asset_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (open, in-progress, completed, cancelled) for backlog and throughput analysis."
    - name: "work_order_source"
      expr: work_order_source
      comment: "Origin of the work order (PM schedule, breakdown, inspection, operator request) to understand demand drivers."
    - name: "asset_criticality"
      expr: asset_criticality
      comment: "Criticality classification of the asset being maintained, enabling risk-based prioritisation of work order backlog."
    - name: "priority"
      expr: priority
      comment: "Work order priority level to assess whether high-priority maintenance is being executed on schedule."
    - name: "craft_type"
      expr: craft_type
      comment: "Trade or craft type required (electrical, mechanical, instrumentation) for workforce capacity planning."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar associated with the work order for TPM programme performance tracking."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "CAPEX vs OPEX classification for financial reporting and budget management."
    - name: "is_production_impacting"
      expr: is_production_impacting
      comment: "Flag indicating whether the work order caused production impact, linking maintenance execution to operational performance."
    - name: "work_order_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the work order was reported, enabling trend analysis of maintenance demand over time."
    - name: "currency_code_wo"
      expr: currency_code
      comment: "Currency in which work order costs are denominated."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline volume metric for maintenance demand and backlog management."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labour cost across all work orders. Core maintenance cost KPI for budget tracking and variance analysis."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost across all work orders. Tracks spare parts and consumables spend for inventory and procurement decisions."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labour hours expended. Measures maintenance workforce utilisation and informs headcount planning."
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labour hours across work orders. Baseline for schedule adherence and resource planning."
    - name: "labor_hours_variance"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE) - CAST(planned_labor_hours AS DOUBLE))
      comment: "Total variance between actual and planned labour hours. Positive variance indicates scope creep or underestimation; negative indicates efficiency gains."
    - name: "total_planned_material_cost"
      expr: SUM(CAST(planned_material_cost AS DOUBLE))
      comment: "Total planned material cost. Used alongside actual material cost to compute cost variance and improve estimating accuracy."
    - name: "material_cost_variance"
      expr: SUM(CAST(actual_material_cost AS DOUBLE) - CAST(planned_material_cost AS DOUBLE))
      comment: "Total variance between actual and planned material costs. Highlights procurement inefficiencies or scope changes in maintenance execution."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all work orders. Used for maintenance budget forecasting and CAPEX/OPEX planning."
    - name: "avg_downtime_duration_hours_per_wo"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime duration per work order in hours. Measures the operational impact of maintenance activities on production availability."
    - name: "total_downtime_duration_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total downtime hours caused by maintenance work orders. Directly quantifies the production availability cost of the maintenance programme."
    - name: "production_impacting_wo_count"
      expr: COUNT(CASE WHEN is_production_impacting = TRUE THEN 1 END)
      comment: "Number of work orders that caused production impact. High counts signal maintenance scheduling issues requiring operational alignment."
    - name: "production_impacting_wo_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_production_impacting = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders that caused production impact. Strategic KPI for assessing how well maintenance is decoupled from production operations."
    - name: "avg_labor_cost_per_work_order"
      expr: AVG(CAST(actual_labor_cost AS DOUBLE))
      comment: "Average labour cost per work order. Benchmarking metric for maintenance cost efficiency across plants, asset types, and craft groups."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_equipment_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset fleet health and lifecycle KPIs — tracks fleet composition, replacement value, condition grades, MTBF/MTTR performance, and maintenance strategy coverage to inform capital investment and reliability strategy decisions."
  source: "`manufacturing_ecm`.`asset`.`equipment_register`"
  dimensions:
    - name: "equipment_class"
      expr: equipment_class
      comment: "Equipment class (e.g. rotating, static, electrical) for fleet segmentation and class-level reliability benchmarking."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for portfolio-level analysis and capital planning."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset (active, standby, decommissioned) for fleet availability reporting."
    - name: "criticality_ranking"
      expr: criticality_ranking
      comment: "Asset criticality ranking (critical, major, minor) for risk-based maintenance prioritisation."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Current condition grade of the asset for capital replacement planning and risk assessment."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy assigned to the asset (preventive, predictive, run-to-failure) for strategy mix analysis."
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the asset for EHS compliance and risk management reporting."
    - name: "functional_location"
      expr: functional_location
      comment: "Functional location code for hierarchical plant/area/unit analysis of asset performance."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the asset was commissioned, enabling fleet age analysis and capital replacement forecasting."
    - name: "currency_code_er"
      expr: currency_code
      comment: "Currency in which asset replacement values are denominated."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of registered assets in the fleet. Baseline fleet size metric for capacity and investment planning."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of currently active assets. Measures productive fleet size and informs capacity utilisation analysis."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total current replacement value of the asset fleet. Core capital planning KPI used by CFOs and asset managers to size insurance, depreciation, and reinvestment budgets."
    - name: "avg_replacement_value"
      expr: AVG(CAST(replacement_value AS DOUBLE))
      comment: "Average replacement value per asset. Enables benchmarking of asset value concentration and informs risk-based maintenance investment decisions."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across the asset fleet in hours. Primary reliability KPI — higher MTBF indicates better asset health and maintenance effectiveness."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across the asset fleet in hours. Measures maintenance responsiveness and repair efficiency — a key input to availability calculations."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating of assets in kilowatts. Supports energy management and electrification planning decisions."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power capacity of the asset fleet in kilowatts. Key metric for energy strategy, grid capacity planning, and electrification investment."
    - name: "assets_past_warranty_expiry"
      expr: COUNT(CASE WHEN warranty_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets whose warranty has expired. Highlights fleet exposure to uninsured repair costs and informs procurement of extended service agreements."
    - name: "assets_due_for_maintenance"
      expr: COUNT(CASE WHEN next_maintenance_due_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of assets where next scheduled maintenance is due or overdue. Operational KPI for maintenance backlog management and compliance with PM schedules."
    - name: "critical_asset_count"
      expr: COUNT(CASE WHEN criticality_ranking = 'Critical' THEN 1 END)
      comment: "Number of assets classified as critical. Drives risk-based maintenance investment decisions and business continuity planning."
    - name: "avg_rated_capacity"
      expr: AVG(CAST(rated_capacity AS DOUBLE))
      comment: "Average rated capacity of assets. Supports production capacity planning and identification of bottleneck assets."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure analysis KPIs — tracks failure frequency, downtime impact, repair costs, MTBF contributions, and safety/environmental incidents to drive reliability improvement and risk reduction programmes."
  source: "`manufacturing_ecm`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_class_code"
      expr: failure_class_code
      comment: "Failure class code for Pareto analysis of failure types driving the most downtime and cost."
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Failure mode code enabling FMEA-aligned analysis of recurring failure patterns."
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code for failure events, supporting RCA and CAPA programme prioritisation."
    - name: "failure_impact_type"
      expr: failure_impact_type
      comment: "Type of operational impact caused by the failure (production stop, quality degradation, safety) for consequence-based prioritisation."
    - name: "maintenance_type_fr"
      expr: maintenance_type
      comment: "Maintenance type associated with the failure response for strategy effectiveness analysis."
    - name: "plant_code_fr"
      expr: plant_code
      comment: "Plant where the failure occurred for site-level reliability benchmarking."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag indicating whether the failure involved a safety incident — zero-tolerance KPI for EHS governance."
    - name: "environmental_incident_flag"
      expr: environmental_incident_flag
      comment: "Flag indicating environmental impact from the failure for sustainability and regulatory reporting."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating whether a Corrective and Preventive Action is required, tracking quality system response to failures."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month of failure occurrence for trend analysis and seasonality detection."
    - name: "record_status"
      expr: record_status
      comment: "Status of the failure record (open, closed, under investigation) for workload and closure rate tracking."
  measures:
    - name: "total_failure_events"
      expr: COUNT(1)
      comment: "Total number of failure events recorded. Baseline reliability metric — rising counts signal deteriorating fleet health."
    - name: "total_downtime_duration_minutes_fr"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime duration caused by failures in minutes. Directly quantifies the production availability cost of asset failures."
    - name: "avg_downtime_duration_minutes_fr"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime per failure event in minutes. Measures typical failure severity and effectiveness of rapid-response maintenance."
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total repair cost across all failure events. Core financial KPI for maintenance cost management and reliability investment justification."
    - name: "avg_repair_cost_per_failure"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per failure event. Enables cost-of-failure analysis by failure mode, asset class, and plant for targeted reliability investment."
    - name: "total_production_units_lost"
      expr: SUM(CAST(production_units_lost AS DOUBLE))
      comment: "Total production units lost due to failures. Links asset reliability directly to revenue and customer delivery performance."
    - name: "total_mtbf_contribution_hours"
      expr: SUM(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Total operating hours contributed to MTBF calculations across all failure records. Supports fleet-level reliability modelling and maintenance interval optimisation."
    - name: "avg_mtbf_contribution_hours"
      expr: AVG(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Average MTBF contribution hours per failure record. Proxy for inter-failure interval — a primary reliability engineering KPI."
    - name: "safety_incident_failure_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of failures involving safety incidents. Board-level EHS KPI with zero-tolerance threshold in most industrial manufacturing organisations."
    - name: "capa_required_failure_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of failures requiring CAPA. Measures the volume of systemic quality issues requiring formal corrective action."
    - name: "avg_asset_operating_hours_at_failure"
      expr: AVG(CAST(asset_operating_hours_at_failure AS DOUBLE))
      comment: "Average asset operating hours at time of failure. Key input to age-based reliability modelling and preventive maintenance interval setting."
    - name: "spare_part_consumed_failure_count"
      expr: COUNT(CASE WHEN spare_part_consumed_flag = TRUE THEN 1 END)
      comment: "Number of failures that consumed spare parts. Drives spare parts inventory planning and critical spares stocking decisions."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance programme KPIs — tracks PM schedule coverage, compliance, cost estimates, safety-critical task volumes, and overdue schedules to steer maintenance strategy and regulatory compliance."
  source: "`manufacturing_ecm`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (active, inactive, suspended) for programme coverage analysis."
    - name: "maintenance_type_pm"
      expr: maintenance_type
      comment: "Type of maintenance activity scheduled (preventive, predictive, condition-based) for strategy mix reporting."
    - name: "trigger_type"
      expr: trigger_type
      comment: "PM trigger mechanism (time-based, meter-based, condition-based) for maintenance strategy effectiveness analysis."
    - name: "tpm_pillar_pm"
      expr: tpm_pillar
      comment: "TPM pillar associated with the PM schedule for Total Productive Maintenance programme tracking."
    - name: "priority_pm"
      expr: priority
      comment: "Priority level of the PM schedule for backlog prioritisation and resource allocation."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flag indicating safety-critical PM tasks — compliance with these schedules is a regulatory and EHS requirement."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Flag indicating regulatory-mandated PM tasks for compliance reporting to governing bodies."
    - name: "shutdown_required_pm"
      expr: shutdown_required
      comment: "Flag indicating whether the PM task requires a production shutdown, enabling outage planning and coordination."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of PM frequency (days, hours, cycles) for schedule density analysis."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month when PM tasks are next due, enabling forward-looking maintenance workload forecasting."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules defined. Baseline metric for PM programme coverage and scope."
    - name: "active_pm_schedule_count"
      expr: COUNT(CASE WHEN schedule_status = 'Active' THEN 1 END)
      comment: "Number of currently active PM schedules. Measures the live maintenance programme scope and coverage."
    - name: "overdue_pm_schedule_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status = 'Active' THEN 1 END)
      comment: "Number of active PM schedules that are past their next due date. Critical compliance KPI — high overdue counts indicate PM backlog and regulatory risk."
    - name: "pm_overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status = 'Active' THEN 1 END) / NULLIF(COUNT(CASE WHEN schedule_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active PM schedules that are overdue. Strategic compliance KPI — targets are typically set at <5% overdue for world-class maintenance organisations."
    - name: "safety_critical_pm_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Number of safety-critical PM schedules. Compliance with these tasks is non-negotiable and monitored at executive level for EHS governance."
    - name: "regulatory_required_pm_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END)
      comment: "Number of regulatory-mandated PM schedules. Non-compliance exposes the organisation to regulatory penalties and audit findings."
    - name: "total_estimated_material_cost_pm"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules. Drives spare parts procurement planning and maintenance budget forecasting."
    - name: "total_estimated_downtime_hours_pm"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours required to execute all PM schedules. Enables production planning teams to schedule maintenance windows without impacting output targets."
    - name: "avg_estimated_duration_hours_pm"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM task in hours. Informs maintenance crew scheduling and shift planning."
    - name: "shutdown_required_pm_count"
      expr: COUNT(CASE WHEN shutdown_required = TRUE THEN 1 END)
      comment: "Number of PM schedules requiring production shutdown. Critical input to annual outage planning and production capacity management."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument calibration quality and compliance KPIs — tracks calibration pass/fail rates, measurement accuracy, out-of-service instruments, and overdue calibrations to ensure measurement integrity and regulatory compliance."
  source: "`manufacturing_ecm`.`asset`.`calibration_record`"
  dimensions:
    - name: "calibration_status"
      expr: calibration_status
      comment: "Outcome status of the calibration (pass, fail, adjusted) for compliance rate analysis."
    - name: "calibration_type"
      expr: calibration_type
      comment: "Type of calibration performed (in-house, external, field) for cost and quality benchmarking."
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of instrument calibrated (pressure, temperature, flow) for instrument class performance analysis."
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Physical parameter being measured (pressure, temperature, voltage) for measurement system analysis."
    - name: "adjustment_made"
      expr: adjustment_made
      comment: "Flag indicating whether an adjustment was required during calibration — high adjustment rates signal instrument drift or poor maintenance."
    - name: "out_of_service"
      expr: out_of_service
      comment: "Flag indicating the instrument is out of service following calibration — impacts production measurement capability."
    - name: "calibration_lab"
      expr: calibration_lab
      comment: "Laboratory performing the calibration for vendor quality benchmarking."
    - name: "calibration_month"
      expr: DATE_TRUNC('MONTH', calibration_date)
      comment: "Month of calibration for trend analysis of calibration workload and compliance rates."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the calibrated instrument, enabling measurement system analysis by parameter type."
  measures:
    - name: "total_calibration_records"
      expr: COUNT(1)
      comment: "Total number of calibration records. Baseline metric for calibration programme activity and instrument fleet coverage."
    - name: "calibration_pass_count"
      expr: COUNT(CASE WHEN calibration_status = 'Pass' THEN 1 END)
      comment: "Number of calibrations that passed without adjustment. High pass rates indicate good instrument health and maintenance effectiveness."
    - name: "calibration_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN calibration_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations passing first-time. Strategic quality KPI — low pass rates indicate systemic instrument reliability issues requiring investment in replacement or improved maintenance."
    - name: "adjustment_required_count"
      expr: COUNT(CASE WHEN adjustment_made = TRUE THEN 1 END)
      comment: "Number of calibrations requiring adjustment. High counts indicate instrument drift and potential measurement integrity risk in production processes."
    - name: "adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations requiring adjustment. Measures instrument fleet health — high rates may indicate inadequate calibration intervals or poor instrument quality."
    - name: "out_of_service_instrument_count"
      expr: COUNT(CASE WHEN out_of_service = TRUE THEN 1 END)
      comment: "Number of instruments currently out of service. Directly impacts production measurement capability and may trigger regulatory non-conformance."
    - name: "overdue_calibration_count"
      expr: COUNT(CASE WHEN calibration_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of instruments with overdue calibration. Regulatory compliance KPI — overdue calibrations can invalidate production measurements and trigger audit findings."
    - name: "avg_as_found_error"
      expr: AVG(CAST(as_found_error AS DOUBLE))
      comment: "Average as-found measurement error across calibrated instruments. Measures the typical drift of instruments between calibration cycles — informs calibration interval optimisation."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibration records. Quantifies the quality of the measurement system — critical for process control and product quality assurance."
    - name: "avg_as_left_error"
      expr: AVG(CAST(as_left_error AS DOUBLE))
      comment: "Average as-left measurement error after calibration adjustment. Measures calibration effectiveness — should be significantly lower than as-found error for well-executed calibrations."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_inspection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection programme KPIs — tracks inspection outcomes, corrective action rates, critical findings, regulatory compliance, and overdue inspections to manage asset integrity and regulatory risk."
  source: "`manufacturing_ecm`.`asset`.`inspection_event`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (statutory, condition-based, pre-commissioning) for programme coverage analysis."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the inspection (pass, fail, conditional pass) for compliance rate reporting."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (completed, in-progress, overdue) for workload management."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the inspection finding (high, medium, low) for risk-based prioritisation of corrective actions."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the inspection for compliance reporting by jurisdiction."
    - name: "regulatory_standard"
      expr: regulatory_standard
      comment: "Regulatory standard against which the inspection was conducted for compliance programme management."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether corrective action is required following the inspection — drives maintenance work order generation."
    - name: "downtime_caused_by_inspection"
      expr: downtime_caused
      comment: "Flag indicating whether the inspection caused asset downtime, linking inspection programme to production availability."
    - name: "plant_code_ie"
      expr: plant_code
      comment: "Plant where the inspection was conducted for site-level compliance benchmarking."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis of inspection programme activity and compliance rates."
  measures:
    - name: "total_inspection_events"
      expr: COUNT(1)
      comment: "Total number of inspection events. Baseline metric for inspection programme activity and asset coverage."
    - name: "inspection_pass_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'Pass' THEN 1 END)
      comment: "Number of inspections with a passing outcome. Measures asset integrity compliance across the fleet."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passing. Strategic asset integrity KPI — declining pass rates signal deteriorating fleet condition requiring capital investment."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections generating corrective action requirements. Drives maintenance work order backlog and capital repair planning."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective action. High rates indicate fleet condition deterioration and signal need for increased maintenance investment."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets with overdue inspections. Regulatory compliance KPI — overdue statutory inspections expose the organisation to legal liability and regulatory penalties."
    - name: "certificate_issued_count"
      expr: COUNT(CASE WHEN certificate_issued = TRUE THEN 1 END)
      comment: "Number of inspections resulting in a compliance certificate. Measures regulatory certification coverage of the asset fleet."
    - name: "certificate_issuance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_issued = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in a compliance certificate. Regulatory compliance KPI for statutory inspection programmes."
    - name: "unique_assets_inspected"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets that have been inspected. Measures inspection programme coverage across the asset fleet — low coverage indicates compliance risk."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_condition_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Condition monitoring and predictive maintenance KPIs — tracks sensor reading volumes, threshold breach rates, alert severity distribution, and data quality to support predictive maintenance programmes and early failure detection."
  source: "`manufacturing_ecm`.`asset`.`condition_reading`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement being monitored (vibration, temperature, pressure, current) for condition monitoring programme analysis."
    - name: "reading_type"
      expr: reading_type
      comment: "Classification of the reading (normal, alarm, trip) for alert management and escalation analysis."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert generated by the reading (critical, warning, informational) for maintenance prioritisation."
    - name: "asset_operating_state"
      expr: asset_operating_state
      comment: "Operating state of the asset at time of reading (running, standby, shutdown) for context-aware condition analysis."
    - name: "equipment_class_cr"
      expr: equipment_class
      comment: "Equipment class of the monitored asset for class-level condition benchmarking."
    - name: "reading_status"
      expr: reading_status
      comment: "Status of the condition reading (valid, suspect, rejected) for data quality management."
    - name: "threshold_breached"
      expr: threshold_breached
      comment: "Flag indicating whether the reading exceeded a defined threshold — the primary trigger for predictive maintenance intervention."
    - name: "reading_source"
      expr: reading_source
      comment: "Source of the reading (IoT sensor, manual, SCADA) for data provenance and quality analysis."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the condition reading for trend analysis of asset health over time."
  measures:
    - name: "total_condition_readings"
      expr: COUNT(1)
      comment: "Total number of condition readings recorded. Baseline metric for condition monitoring programme coverage and sensor data volume."
    - name: "threshold_breach_count"
      expr: COUNT(CASE WHEN threshold_breached = TRUE THEN 1 END)
      comment: "Number of readings that breached defined thresholds. Primary predictive maintenance trigger metric — high breach counts signal deteriorating asset health requiring intervention."
    - name: "threshold_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN threshold_breached = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of condition readings breaching thresholds. Strategic asset health KPI — rising breach rates indicate fleet-wide condition deterioration and predict future failures."
    - name: "avg_reading_value"
      expr: AVG(CAST(reading_value AS DOUBLE))
      comment: "Average condition reading value across all monitored assets. Baseline for fleet-level condition benchmarking and trend analysis."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of condition readings. Measures the reliability of the condition monitoring data pipeline — low scores undermine predictive maintenance effectiveness."
    - name: "avg_load_percentage"
      expr: AVG(CAST(load_percentage AS DOUBLE))
      comment: "Average asset load percentage at time of reading. Enables load-normalised condition analysis and identification of overloaded assets at risk of premature failure."
    - name: "unique_assets_monitored"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets with condition monitoring readings. Measures condition monitoring programme coverage — low coverage indicates predictive maintenance blind spots."
    - name: "pm_trigger_reading_count"
      expr: COUNT(CASE WHEN pm_trigger_flag = TRUE THEN 1 END)
      comment: "Number of condition readings that triggered a PM work order. Measures the effectiveness of condition-based maintenance triggers in converting sensor data into maintenance actions."
    - name: "avg_delta_value"
      expr: AVG(CAST(delta_value AS DOUBLE))
      comment: "Average rate of change in condition readings. Accelerating delta values indicate rapid asset degradation and are a leading indicator of imminent failure."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`asset_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory and procurement KPIs — tracks inventory value, criticality coverage, procurement costs, and stock policy compliance to optimise spare parts investment and ensure maintenance readiness."
  source: "`manufacturing_ecm`.`asset`.`spare_part`"
  dimensions:
    - name: "criticality_class"
      expr: criticality_class
      comment: "Criticality classification of the spare part (critical, essential, desirable) for risk-based inventory investment decisions."
    - name: "abc_class"
      expr: abc_class
      comment: "ABC inventory classification (A=high value, B=medium, C=low) for inventory management prioritisation."
    - name: "part_type"
      expr: part_type
      comment: "Type of spare part (OEM, generic, consumable) for procurement strategy analysis."
    - name: "part_status"
      expr: part_status
      comment: "Current status of the spare part (active, obsolete, superseded) for inventory rationalisation."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement method (stock, non-stock, direct purchase) for supply chain strategy analysis."
    - name: "equipment_class_code"
      expr: equipment_class_code
      comment: "Equipment class the spare part supports for asset-aligned inventory analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating hazardous material classification for EHS compliance and storage management."
    - name: "maintenance_strategy_sp"
      expr: maintenance_strategy
      comment: "Maintenance strategy the spare part supports (preventive, corrective, predictive) for strategy-aligned inventory planning."
    - name: "currency_code_sp"
      expr: currency_code
      comment: "Currency in which spare part costs are denominated."
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of spare part records. Baseline metric for spare parts catalogue size and inventory scope."
    - name: "total_standard_cost_inventory"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost value of the spare parts catalogue. Core inventory investment KPI for working capital management and insurance valuation."
    - name: "avg_standard_cost_per_part"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per spare part. Enables benchmarking of inventory cost concentration and identification of high-value parts requiring special management."
    - name: "total_last_purchase_price_value"
      expr: SUM(CAST(last_purchase_price AS DOUBLE))
      comment: "Total last purchase price value across all spare parts. Measures actual procurement spend and enables comparison against standard cost for variance analysis."
    - name: "avg_annual_consumption_value"
      expr: AVG(CAST(average_annual_consumption AS DOUBLE))
      comment: "Average annual consumption quantity per spare part. Drives reorder point calculations and safety stock policy optimisation."
    - name: "total_annual_consumption_value"
      expr: SUM(CAST(average_annual_consumption AS DOUBLE))
      comment: "Total annual consumption across all spare parts. Measures overall spare parts demand volume for procurement planning and supplier capacity management."
    - name: "critical_spare_part_count"
      expr: COUNT(CASE WHEN criticality_class = 'Critical' THEN 1 END)
      comment: "Number of spare parts classified as critical. Ensures critical spares are stocked and available to prevent extended downtime on critical assets."
    - name: "obsolete_part_count"
      expr: COUNT(CASE WHEN part_status = 'Obsolete' THEN 1 END)
      comment: "Number of obsolete spare parts in the catalogue. High obsolete counts indicate inventory rationalisation opportunities and potential write-off exposure."
    - name: "parts_past_warranty_expiry"
      expr: COUNT(CASE WHEN warranty_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of spare parts whose warranty has expired. Highlights procurement risk and potential quality issues with aged inventory."
    - name: "hazardous_material_part_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN 1 END)
      comment: "Number of spare parts classified as hazardous materials. Drives EHS compliance requirements for storage, handling, and disposal management."
$$;