-- Metric views for domain: asset | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for asset maintenance work orders — tracks cost performance, labor efficiency, downtime impact, and schedule adherence to steer maintenance investment decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current lifecycle status of the work order (Open, In Progress, Completed, Cancelled) — primary filter for operational dashboards."
    - name: "work_order_priority"
      expr: priority
      comment: "Priority classification (Critical, High, Medium, Low) — used to segment backlog and escalation analysis."
    - name: "work_order_source"
      expr: work_order_source
      comment: "Origin of the work order (Preventive, Corrective, Predictive, Breakdown) — key dimension for maintenance strategy analysis."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar classification — enables TPM programme performance tracking."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "CapEx vs OpEx classification — critical for financial reporting and budget allocation decisions."
    - name: "craft_type"
      expr: craft_type
      comment: "Trade or craft type assigned to the work order — used for workforce capacity planning."
    - name: "is_production_impacting"
      expr: is_production_impacting
      comment: "Flag indicating whether the work order caused production impact — used to quantify maintenance-driven production losses."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of planned start date — enables trend analysis of work order volume and cost over time."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders — baseline volume metric for maintenance workload assessment."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost across all work orders — direct input to maintenance cost management and budget variance analysis."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost across all work orders — tracks spare parts and consumables spend."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Sum of estimated costs for all work orders — used for budget forecasting and cost planning."
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per work order — measures workforce productivity and job complexity."
    - name: "total_downtime_duration_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours caused by work orders — directly linked to OEE availability losses and production impact."
    - name: "avg_downtime_duration_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime per work order — used to benchmark repair efficiency and identify chronic failure patterns."
    - name: "labor_cost_variance"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE) - CAST(planned_labor_hours AS DOUBLE))
      comment: "Aggregate variance between actual labor cost and planned labor hours (as cost proxy) — signals estimation accuracy and resource over/under-run."
    - name: "material_cost_variance"
      expr: SUM(CAST(actual_material_cost AS DOUBLE) - CAST(planned_material_cost AS DOUBLE))
      comment: "Aggregate variance between actual and planned material cost — highlights procurement and estimation gaps."
    - name: "production_impacting_work_order_count"
      expr: COUNT(CASE WHEN is_production_impacting = TRUE THEN 1 END)
      comment: "Count of work orders that caused production impact — key metric for quantifying maintenance-driven production losses."
    - name: "safety_permit_required_count"
      expr: COUNT(CASE WHEN safety_permit_required = TRUE THEN 1 END)
      comment: "Count of work orders requiring safety permits — used for HSE compliance tracking and permit-to-work programme management."
    - name: "distinct_equipment_maintained"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets that received work orders — measures maintenance coverage breadth across the asset fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset downtime KPIs tracking duration, frequency, financial impact, and OEE availability losses — core metrics for reliability-centred maintenance and production continuity decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "High-level category of downtime (Planned, Unplanned, External) — primary dimension for downtime root-cause analysis."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime event — enables granular classification for reliability improvement programmes."
    - name: "failure_class"
      expr: failure_class
      comment: "Failure classification code — used to identify dominant failure modes and prioritise corrective actions."
    - name: "failure_code"
      expr: failure_code
      comment: "Standardised failure code — enables cross-asset failure pattern analysis."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance response triggered (Corrective, Emergency, Preventive) — used to measure reactive vs proactive maintenance ratio."
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Flag for repeat failures on the same asset — critical for identifying chronic reliability issues requiring root-cause elimination."
    - name: "is_safety_incident"
      expr: is_safety_incident
      comment: "Flag indicating the downtime event involved a safety incident — used for HSE reporting and regulatory compliance."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month bucket of downtime event start — enables trend analysis of downtime frequency and duration over time."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the downtime event record — used to filter active vs closed events."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — baseline frequency metric for reliability benchmarking."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes — primary measure of availability loss across the asset fleet."
    - name: "avg_downtime_minutes_per_event"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event — proxy for Mean Time To Repair (MTTR) used in reliability benchmarking."
    - name: "total_repair_time_minutes"
      expr: SUM(CAST(repair_time_minutes AS DOUBLE))
      comment: "Total active repair time in minutes — distinguishes wrench time from total downtime for maintenance efficiency analysis."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average time from failure detection to maintenance response — measures maintenance team responsiveness and SLA adherence."
    - name: "total_estimated_production_loss_units"
      expr: SUM(CAST(estimated_production_loss_units AS DOUBLE))
      comment: "Total estimated production units lost due to downtime — directly quantifies the production impact of asset failures."
    - name: "total_estimated_loss_cost"
      expr: SUM(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Total estimated financial loss from downtime events — key input to asset criticality ranking and maintenance investment justification."
    - name: "avg_oee_availability_impact_pct"
      expr: AVG(CAST(oee_availability_impact_pct AS DOUBLE))
      comment: "Average OEE availability impact percentage per downtime event — directly feeds the OEE availability component calculation."
    - name: "repeat_failure_count"
      expr: COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END)
      comment: "Count of repeat failure events — measures effectiveness of corrective actions and root-cause elimination programmes."
    - name: "safety_incident_downtime_count"
      expr: COUNT(CASE WHEN is_safety_incident = TRUE THEN 1 END)
      comment: "Count of downtime events involving safety incidents — critical HSE KPI for regulatory reporting and safety culture assessment."
    - name: "distinct_assets_with_downtime"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets that experienced downtime — measures breadth of reliability issues across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance schedule KPIs tracking compliance, cost, and schedule adherence — enables proactive maintenance programme management and regulatory compliance oversight."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (Active, Inactive, Suspended) — primary filter for active maintenance programme analysis."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of preventive maintenance (Time-based, Condition-based, Meter-based) — used to analyse maintenance strategy mix."
    - name: "trigger_type"
      expr: trigger_type
      comment: "What triggers the PM (Calendar, Meter, Condition) — key dimension for maintenance strategy optimisation."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "TPM pillar classification — enables TPM programme performance tracking by pillar."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Flag for regulatory-mandated PM schedules — critical for compliance reporting and audit readiness."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Flag for safety-critical PM schedules — used to prioritise scheduling and resource allocation."
    - name: "shutdown_required"
      expr: shutdown_required
      comment: "Flag indicating whether the PM requires asset shutdown — used for production planning and outage scheduling."
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM schedule — used to manage scheduling conflicts and resource allocation."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of PM frequency (Days, Weeks, Months, Hours) — used to analyse maintenance interval distribution."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules — baseline measure of preventive maintenance programme scope."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules — key input to maintenance budget planning."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM task — used for workforce capacity planning and scheduling."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours from planned maintenance — used to quantify planned availability losses for OEE planning."
    - name: "avg_frequency_value"
      expr: AVG(CAST(frequency_value AS DOUBLE))
      comment: "Average PM frequency value — used to assess maintenance interval distribution and identify over/under-maintained assets."
    - name: "regulatory_required_pm_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END)
      comment: "Count of regulatory-mandated PM schedules — used for compliance programme scope assessment and audit preparation."
    - name: "safety_critical_pm_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Count of safety-critical PM schedules — used to ensure adequate resource allocation for safety-critical maintenance."
    - name: "shutdown_required_pm_count"
      expr: COUNT(CASE WHEN shutdown_required = TRUE THEN 1 END)
      comment: "Count of PM schedules requiring asset shutdown — used for production outage planning and coordination."
    - name: "distinct_assets_on_pm"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets covered by PM schedules — measures preventive maintenance programme coverage across the fleet."
    - name: "overdue_pm_count"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of PM schedules past their next due date — critical compliance and risk metric for maintenance backlog management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_reliability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset reliability KPIs including MTBF, MTTR, availability, and failure rates — core metrics for reliability-centred maintenance strategy and asset lifecycle investment decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`reliability_record`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class classification — primary dimension for fleet-level reliability benchmarking."
    - name: "reliability_tier"
      expr: reliability_tier
      comment: "Reliability tier classification (Tier 1 Critical, Tier 2, Tier 3) — used to prioritise maintenance investment and monitoring intensity."
    - name: "record_status"
      expr: record_status
      comment: "Status of the reliability record — used to filter active vs archived records."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Reliability trend direction (Improving, Stable, Degrading) — key executive indicator for fleet health trajectory."
    - name: "replacement_recommended"
      expr: replacement_recommended
      comment: "Flag indicating asset replacement is recommended — used to drive CapEx investment decisions."
    - name: "condition_monitoring_enabled"
      expr: condition_monitoring_enabled
      comment: "Flag for assets with active condition monitoring — used to measure predictive maintenance programme coverage."
    - name: "measurement_period_start_month"
      expr: DATE_TRUNC('MONTH', measurement_period_start)
      comment: "Month bucket of measurement period start — enables time-series reliability trend analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code — enables cross-site reliability benchmarking."
  measures:
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across assets in the measurement period — primary reliability KPI used to benchmark asset dependability and maintenance interval optimisation."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across assets — measures maintenance team effectiveness and spare parts availability impact on repair speed."
    - name: "avg_availability_pct"
      expr: AVG(CAST(availability_pct AS DOUBLE))
      comment: "Average asset availability percentage — directly feeds OEE availability component and production capacity planning."
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total downtime hours across all assets in the period — aggregate measure of fleet-wide availability loss."
    - name: "total_uptime_hours"
      expr: SUM(CAST(total_uptime_hours AS DOUBLE))
      comment: "Total uptime hours across all assets — used to calculate fleet-level availability and production capacity."
    - name: "total_downtime_cost"
      expr: SUM(CAST(downtime_cost_usd AS DOUBLE))
      comment: "Total financial cost of downtime across the fleet — key input to maintenance ROI and asset replacement justification."
    - name: "avg_asset_health_score"
      expr: AVG(CAST(asset_health_score AS DOUBLE))
      comment: "Average asset health score across the fleet — composite indicator used by asset managers to prioritise maintenance and replacement decisions."
    - name: "avg_failure_rate"
      expr: AVG(CAST(failure_rate AS DOUBLE))
      comment: "Average failure rate across assets — used to identify deteriorating assets and validate maintenance strategy effectiveness."
    - name: "replacement_recommended_count"
      expr: COUNT(CASE WHEN replacement_recommended = TRUE THEN 1 END)
      comment: "Count of assets flagged for replacement — directly drives CapEx budget requests and asset lifecycle planning."
    - name: "avg_oee_availability_component"
      expr: AVG(CAST(oee_availability_component AS DOUBLE))
      comment: "Average OEE availability component from reliability records — links asset reliability performance to overall equipment effectiveness."
    - name: "avg_mtbf_variance_pct"
      expr: AVG(CAST(mtbf_variance_pct AS DOUBLE))
      comment: "Average variance between actual and target MTBF — measures how well assets are performing against reliability targets."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_calibration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration compliance and measurement quality KPIs — tracks calibration status, out-of-tolerance rates, and overdue instruments to ensure measurement system integrity and regulatory compliance."
  source: "`vibe_manufacturing_v1`.`asset`.`calibration_record`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of instrument being calibrated — used to segment calibration compliance by instrument category."
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Physical parameter being measured (Temperature, Pressure, Flow, etc.) — used to analyse calibration performance by measurement type."
    - name: "out_of_service"
      expr: out_of_service
      comment: "Flag indicating the instrument is out of service due to calibration failure — critical compliance and operational risk indicator."
    - name: "adjustment_made"
      expr: adjustment_made
      comment: "Flag indicating a calibration adjustment was required — used to measure instrument drift frequency and maintenance needs."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement — used to group calibration performance by measurement domain."
    - name: "certificate_issue_month"
      expr: DATE_TRUNC('MONTH', certificate_issue_date)
      comment: "Month of calibration certificate issue — enables trend analysis of calibration activity volume."
  measures:
    - name: "total_calibration_records"
      expr: COUNT(1)
      comment: "Total number of calibration records — baseline measure of calibration programme activity."
    - name: "out_of_service_instrument_count"
      expr: COUNT(CASE WHEN out_of_service = TRUE THEN 1 END)
      comment: "Count of instruments currently out of service due to calibration issues — critical operational risk metric for quality and production management."
    - name: "adjustment_required_count"
      expr: COUNT(CASE WHEN adjustment_made = TRUE THEN 1 END)
      comment: "Count of calibrations requiring adjustment — measures instrument drift frequency and informs calibration interval optimisation."
    - name: "avg_as_found_error"
      expr: AVG(CAST(as_found_error AS DOUBLE))
      comment: "Average as-found measurement error — measures instrument drift magnitude and calibration interval adequacy."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibrated instruments — key quality metric for measurement system capability assessment."
    - name: "avg_environmental_temperature_c"
      expr: AVG(CAST(environmental_temperature_c AS DOUBLE))
      comment: "Average calibration environment temperature — used to assess whether calibration conditions meet laboratory standards."
    - name: "distinct_instruments_calibrated"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct instruments calibrated — measures calibration programme coverage across the instrument fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection KPIs tracking compliance rates, findings, and overdue inspections — enables regulatory compliance management and risk-based inspection programme optimisation."
  source: "`vibe_manufacturing_v1`.`asset`.`inspection_event`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Statutory, Preventive, Condition-based, Third-party) — primary dimension for inspection programme analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection event — used to track completion rates and open inspection backlogs."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Result of the inspection (Pass, Fail, Conditional Pass) — key quality and compliance indicator."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the inspection — used to prioritise follow-up actions and resource allocation."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating corrective action is required — used to track inspection-driven corrective action backlog."
    - name: "certificate_issued"
      expr: certificate_issued
      comment: "Flag indicating a certificate was issued following inspection — used for regulatory compliance tracking."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection — enables trend analysis of inspection activity and compliance rates over time."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code — enables cross-site inspection compliance benchmarking."
  measures:
    - name: "total_inspection_events"
      expr: COUNT(1)
      comment: "Total number of inspection events — baseline measure of inspection programme activity."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_outcome = 'Fail' THEN 1 END)
      comment: "Count of failed inspections — primary compliance risk metric driving corrective action and regulatory reporting."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of inspections requiring corrective action — measures open compliance risk exposure across the asset fleet."
    - name: "total_findings_count"
      expr: SUM(CAST(findings_count AS DOUBLE))
      comment: "Total number of inspection findings — aggregate measure of compliance gaps identified across the inspection programme."
    - name: "avg_inspection_duration_minutes"
      expr: AVG(CAST(inspection_duration_minutes AS DOUBLE))
      comment: "Average inspection duration — used for resource planning and identifying unusually complex or prolonged inspections."
    - name: "total_downtime_from_inspections_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime caused by inspection events — quantifies the production impact of the inspection programme."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of assets with overdue next inspection — critical regulatory compliance metric for audit readiness."
    - name: "distinct_assets_inspected"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets inspected — measures inspection programme coverage across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_failure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure analysis KPIs tracking failure modes, downtime costs, and repair performance — drives reliability improvement programmes and maintenance strategy optimisation."
  source: "`vibe_manufacturing_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_class_code"
      expr: failure_class_code
      comment: "Failure class code — primary dimension for failure mode analysis and reliability-centred maintenance (RCM) studies."
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Specific failure mode code — enables Pareto analysis of dominant failure modes for targeted corrective action."
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code of the failure — used to identify systemic causes and drive elimination programmes."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance response (Corrective, Emergency) — used to measure reactive maintenance burden."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Flag for failures involving safety incidents — critical HSE metric for regulatory reporting."
    - name: "environmental_incident_flag"
      expr: environmental_incident_flag
      comment: "Flag for failures with environmental impact — used for environmental compliance reporting."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating a CAPA is required — used to track quality system response to failures."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month of failure occurrence — enables trend analysis of failure frequency over time."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code — enables cross-site failure rate benchmarking."
  measures:
    - name: "total_failure_events"
      expr: COUNT(1)
      comment: "Total number of failure events — baseline frequency metric for fleet reliability assessment."
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total repair cost across all failure events — key input to maintenance cost management and asset replacement justification."
    - name: "avg_repair_cost"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per failure event — used to benchmark repair economics and identify high-cost failure modes."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime duration from failures — measures aggregate availability loss from unplanned failures."
    - name: "avg_downtime_minutes_per_failure"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime per failure event — proxy for MTTR used in reliability benchmarking."
    - name: "total_production_units_lost"
      expr: SUM(CAST(production_units_lost AS DOUBLE))
      comment: "Total production units lost due to failures — directly quantifies the production impact of asset unreliability."
    - name: "total_mtbf_contribution_hours"
      expr: SUM(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Total MTBF contribution hours — used to calculate fleet-level MTBF for reliability programme reporting."
    - name: "safety_incident_failure_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of failures involving safety incidents — critical HSE KPI for regulatory compliance and safety culture assessment."
    - name: "capa_required_failure_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of failures requiring CAPA — measures the volume of quality system actions driven by asset failures."
    - name: "distinct_assets_with_failures"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets with recorded failures — measures breadth of reliability issues across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_capex`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure asset KPIs tracking acquisition cost, depreciation, net book value, and disposal — core metrics for fixed asset management, financial reporting, and CapEx investment decisions."
  source: "`vibe_manufacturing_v1`.`asset`.`capex_asset_record`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category classification — primary dimension for CapEx portfolio analysis and budget allocation."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code — used for financial reporting and depreciation policy grouping."
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the asset (Active, Disposed, Under Construction) — used to filter active asset portfolio."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-line, Declining Balance, Units of Production) — used for financial reporting analysis."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating asset impairment — critical for financial reporting and asset write-down decisions."
    - name: "capitalization_date_month"
      expr: DATE_TRUNC('MONTH', capitalization_date)
      comment: "Month of asset capitalisation — enables trend analysis of CapEx investment timing."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code — enables cross-site CapEx portfolio analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of asset disposal (Sale, Scrap, Transfer) — used for disposal programme analysis and proceeds tracking."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all CapEx assets — primary measure of capital investment in the asset base."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of the asset portfolio — key balance sheet metric for financial reporting and asset base valuation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset portfolio — measures the consumed economic value of the asset base."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognised — critical financial reporting metric for asset write-down impact on P&L."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — used to measure asset disposal programme effectiveness and cash recovery."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of the asset portfolio — used in depreciation calculations and end-of-life planning."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets — used to assess asset age profile and plan replacement cycles."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Count of assets with impairment indicators — used to assess the scale of asset write-down exposure."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation adjustments to the asset portfolio — used for fair value accounting and asset base management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset warranty KPIs tracking coverage, claims activity, and financial exposure — enables warranty cost management, supplier accountability, and asset lifecycle planning."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_warranty`"
  dimensions:
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current status of the warranty (Active, Expired, Claimed, Voided) — primary filter for active warranty portfolio management."
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty (OEM, Extended, Service) — used to analyse warranty portfolio composition and cost exposure."
    - name: "labor_coverage_flag"
      expr: labor_coverage_flag
      comment: "Flag indicating labor is covered under warranty — used to quantify labor cost recovery potential."
    - name: "parts_coverage_flag"
      expr: parts_coverage_flag
      comment: "Flag indicating parts are covered under warranty — used to quantify parts cost recovery potential."
    - name: "rma_eligible_flag"
      expr: rma_eligible_flag
      comment: "Flag indicating the asset is eligible for return merchandise authorisation — used for warranty claim process management."
    - name: "usage_based_flag"
      expr: usage_based_flag
      comment: "Flag for usage-based warranties — used to identify warranties requiring meter-based tracking."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of warranty start — enables cohort analysis of warranty portfolio by activation period."
  measures:
    - name: "total_warranties"
      expr: COUNT(1)
      comment: "Total number of asset warranties — baseline measure of warranty portfolio scope."
    - name: "total_max_claim_value"
      expr: SUM(CAST(max_claim_value AS DOUBLE))
      comment: "Total maximum claim value across all active warranties — measures the financial ceiling of warranty recovery potential."
    - name: "total_claimed_amount"
      expr: SUM(CAST(total_claimed_amount AS DOUBLE))
      comment: "Total amount claimed under warranties — measures actual warranty cost recovery and supplier accountability."
    - name: "total_remaining_warranty_value"
      expr: SUM(CAST(remaining_warranty_value AS DOUBLE))
      comment: "Total remaining warranty value across the portfolio — measures unclaimed warranty recovery potential."
    - name: "avg_duration_months"
      expr: AVG(CAST(duration_months AS DOUBLE))
      comment: "Average warranty duration in months — used to assess warranty coverage adequacy across the asset fleet."
    - name: "total_claims_count"
      expr: SUM(CAST(total_claims_count AS DOUBLE))
      comment: "Total number of warranty claims filed — measures warranty utilisation and supplier quality performance."
    - name: "avg_usage_limit_value"
      expr: AVG(CAST(usage_limit_value AS DOUBLE))
      comment: "Average usage limit for usage-based warranties — used to assess remaining warranty coverage for high-utilisation assets."
    - name: "expiring_warranty_count"
      expr: COUNT(CASE WHEN expiration_date < 90 THEN 1 END)
      comment: "Count of warranties expiring within 90 days (using expiration_date numeric field) — drives proactive warranty renewal and claim submission actions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset regulatory compliance assessment KPIs tracking compliance scores, risk levels, and remediation requirements — enables regulatory risk management and compliance programme effectiveness measurement."
  source: "`vibe_manufacturing_v1`.`asset`.`compliance_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (Regulatory, Internal, Third-party) — primary dimension for compliance programme analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment — used to track assessment completion and open compliance gaps."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status (Compliant, Non-Compliant, Partially Compliant) — primary executive compliance indicator."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the compliance gap — used to prioritise remediation actions by risk exposure."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating corrective action is required — used to track open compliance remediation backlog."
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Flag indicating remediation is required — used to measure the scale of compliance remediation programme."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment — enables trend analysis of compliance performance over time."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments — baseline measure of compliance programme activity."
    - name: "non_compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of non-compliant assessments — primary regulatory risk metric driving executive escalation and remediation investment."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all assessments — composite indicator of overall regulatory compliance health."
    - name: "avg_score_percent"
      expr: AVG(CAST(score_percent AS DOUBLE))
      comment: "Average compliance score as a percentage — normalised compliance performance metric for cross-site benchmarking."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of assessments requiring corrective action — measures open compliance risk exposure requiring management attention."
    - name: "distinct_assets_assessed"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets assessed for compliance — measures compliance programme coverage across the asset fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_condition_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset condition monitoring KPIs tracking sensor readings, threshold breaches, and anomaly rates — enables predictive maintenance decisions and early failure detection."
  source: "`vibe_manufacturing_v1`.`asset`.`condition_reading`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement (Vibration, Temperature, Pressure, Current) — primary dimension for condition monitoring analysis by parameter."
    - name: "reading_type"
      expr: reading_type
      comment: "Classification of reading type (Automated, Manual, Calculated) — used to assess data quality and monitoring coverage."
    - name: "reading_status"
      expr: reading_status
      comment: "Status of the reading (Valid, Suspect, Invalid) — used to filter quality-assured data for analysis."
    - name: "threshold_breached"
      expr: threshold_breached
      comment: "Flag indicating the reading exceeded a defined threshold — primary trigger for predictive maintenance actions."
    - name: "asset_operating_state"
      expr: asset_operating_state
      comment: "Operating state of the asset at time of reading — used to contextualise readings and filter for comparable operating conditions."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flag for manually overridden readings — used to assess data integrity and operator intervention frequency."
    - name: "pm_trigger_flag"
      expr: pm_trigger_flag
      comment: "Flag indicating the reading triggered a PM work order — measures condition-based maintenance programme effectiveness."
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of condition reading — enables trend analysis of asset condition over time."
  measures:
    - name: "total_condition_readings"
      expr: COUNT(1)
      comment: "Total number of condition readings — baseline measure of condition monitoring programme activity and sensor coverage."
    - name: "threshold_breach_count"
      expr: COUNT(CASE WHEN threshold_breached = TRUE THEN 1 END)
      comment: "Count of readings that breached defined thresholds — primary predictive maintenance trigger metric indicating assets at risk."
    - name: "avg_reading_value"
      expr: AVG(CAST(reading_value AS DOUBLE))
      comment: "Average condition reading value — used to track parameter trends and identify gradual degradation patterns."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score of condition readings — measures sensor reliability and data integrity for predictive analytics."
    - name: "avg_load_percentage"
      expr: AVG(CAST(load_percentage AS DOUBLE))
      comment: "Average asset load percentage at time of reading — used to contextualise condition readings and identify overloading patterns."
    - name: "pm_triggered_reading_count"
      expr: COUNT(CASE WHEN pm_trigger_flag = TRUE THEN 1 END)
      comment: "Count of readings that triggered PM work orders — measures the effectiveness of condition-based maintenance triggers."
    - name: "distinct_assets_monitored"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets with condition readings — measures predictive maintenance programme coverage across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset certification compliance KPIs tracking certification status, expiry, costs, and regulatory coverage — enables statutory compliance management and certification renewal programme oversight."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (Pressure Vessel, Electrical, Lifting Equipment, etc.) — primary dimension for certification portfolio analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Valid, Expired, Suspended, Pending) — primary compliance indicator."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the certification — used to track compliance by regulatory body."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction of the certification — used for multi-jurisdiction compliance management."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating the certification is legally mandatory — used to prioritise renewal actions for statutory compliance."
    - name: "ce_marking_flag"
      expr: ce_marking_flag
      comment: "Flag for CE marking certification — used to track product conformity for EU market access."
    - name: "renewal_action_status"
      expr: renewal_action_status
      comment: "Status of the renewal action (Not Started, In Progress, Submitted, Approved) — used to manage certification renewal pipeline."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of certification expiry — enables proactive renewal planning and expiry risk management."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of asset certifications — baseline measure of certification portfolio scope."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Count of expired certifications — critical regulatory compliance risk metric requiring immediate management action."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of asset certifications — used for compliance budget management and cost benchmarking."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average certification cost — used to benchmark certification spend and identify cost optimisation opportunities."
    - name: "mandatory_certification_count"
      expr: COUNT(CASE WHEN mandatory_flag = TRUE THEN 1 END)
      comment: "Count of mandatory certifications — measures the scope of statutory compliance obligations across the asset fleet."
    - name: "avg_pressure_rating_psi"
      expr: AVG(CAST(pressure_rating_psi AS DOUBLE))
      comment: "Average pressure rating of certified pressure equipment — used for engineering and safety compliance analysis."
    - name: "avg_rated_load_kg"
      expr: AVG(CAST(rated_load_kg AS DOUBLE))
      comment: "Average rated load of certified lifting equipment — used for safety compliance and capacity management."
    - name: "distinct_assets_certified"
      expr: COUNT(DISTINCT equipment_register_id)
      comment: "Number of distinct assets with certifications — measures certification programme coverage across the fleet."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_capex_asset_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial overview of capital assets"
  source: "`vibe_manufacturing_v1`.`asset`.`capex_asset_record`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the asset is located"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the asset"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used for depreciation"
  measures:
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of capitalized assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost for all assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Sum of accumulated depreciation across assets"
    - name: "average_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value of assets"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_reliability_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability and availability KPIs for assets"
  source: "`vibe_manufacturing_v1`.`asset`.`reliability_record`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the asset"
    - name: "equipment_register_id"
      expr: equipment_register_id
      comment: "Equipment register identifier"
    - name: "asset_number"
      expr: asset_number
      comment: "Asset number"
    - name: "asset_class"
      expr: asset_class
      comment: "Class of the asset"
    - name: "record_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date of the reliability record"
  measures:
    - name: "reliability_record_count"
      expr: COUNT(1)
      comment: "Number of reliability records"
    - name: "average_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average Mean Time Between Failures (hours)"
    - name: "average_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average Mean Time To Repair (hours)"
    - name: "average_availability_pct"
      expr: AVG(CAST(availability_pct AS DOUBLE))
      comment: "Average asset availability percentage"
    - name: "total_downtime_hours"
      expr: SUM(CAST(total_downtime_hours AS DOUBLE))
      comment: "Total downtime hours recorded"
$$;