-- Metric views for domain: site | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_crew_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for crew deployment events on construction sites, covering labour productivity, overtime exposure, schedule adherence, and HSE compliance across shifts and work fronts."
  source: "`construction_ecm`.`site`.`crew_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Calendar date of the crew deployment, used for daily and weekly trend analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g. Day, Night, Swing) enabling shift-pattern productivity comparisons."
    - name: "crew_type"
      expr: crew_type
      comment: "Classification of the crew (e.g. Civil, Structural, MEP) for trade-level performance analysis."
    - name: "crew_size"
      expr: crew_size
      comment: "Size band of the deployed crew, supporting workforce scaling analysis."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment record (e.g. Active, Completed, Cancelled) for pipeline health monitoring."
    - name: "is_subcontractor_crew"
      expr: is_subcontractor_crew
      comment: "Flag indicating whether the crew is a subcontractor, enabling direct vs. subcontract labour split analysis."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Flag indicating whether the deployment included overtime, used for cost and fatigue risk monitoring."
    - name: "is_weather_impacted"
      expr: is_weather_impacted
      comment: "Flag indicating weather-related disruption to the deployment, supporting delay root-cause analysis."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for any deployment delay, enabling systematic delay categorisation and trend analysis."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilisation readiness status of the crew deployment, used to track site readiness."
    - name: "ppe_compliance"
      expr: ppe_compliance
      comment: "Boolean indicating whether PPE compliance was confirmed for the deployment, a leading HSE indicator."
    - name: "hse_toolbox_meeting_held"
      expr: hse_toolbox_meeting_held
      comment: "Boolean indicating whether a toolbox meeting was conducted prior to deployment, a mandatory HSE control."
    - name: "production_unit_of_measure"
      expr: production_unit_of_measure
      comment: "Unit of measure for production quantities (e.g. m3, LM, EA), enabling cross-activity normalisation."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Prevailing weather condition during the deployment, used for weather-impact correlation analysis."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual labour hours expended across all crew deployments. Core input to cost and productivity reporting."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned labour hours scheduled across all crew deployments. Baseline for schedule adherence measurement."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime signals cost overrun risk and workforce fatigue exposure."
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity delivered by deployed crews. Primary output volume KPI."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity for deployed crews. Denominator for production achievement rate."
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate (output per labour hour) across deployments. Key efficiency KPI for crew performance benchmarking."
    - name: "overtime_hours_ratio"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total actual hours. Sustained values above threshold trigger workforce and cost management intervention."
    - name: "production_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned production. Core schedule performance indicator for site leadership."
    - name: "hours_variance"
      expr: SUM((actual_hours) - (planned_hours))
      comment: "Difference between actual and planned labour hours. Positive values indicate over-run; negative values indicate under-utilisation."
    - name: "ppe_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ppe_compliance = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments where PPE compliance was confirmed. A mandatory HSE leading indicator tracked by site safety managers."
    - name: "toolbox_meeting_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hse_toolbox_meeting_held = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments where a toolbox meeting was held. Regulatory and contractual HSE compliance KPI."
    - name: "weather_impacted_deployment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_weather_impacted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments impacted by weather. Informs schedule risk and contingency planning decisions."
    - name: "subcontractor_deployment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_subcontractor_crew = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments using subcontractor crews. Tracks subcontract dependency and associated cost/risk exposure."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_daily_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site-level daily operational KPIs derived from daily construction logs, covering production volumes, delay events, safety observations, and site status for project oversight and executive reporting."
  source: "`construction_ecm`.`site`.`daily_log`"
  dimensions:
    - name: "log_date"
      expr: log_date
      comment: "Date of the daily log entry, the primary time dimension for daily operational trend analysis."
    - name: "log_status"
      expr: log_status
      comment: "Approval/workflow status of the daily log (e.g. Draft, Submitted, Approved), used to assess data completeness."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type recorded in the daily log (e.g. Day, Night), enabling shift-level performance comparison."
    - name: "overall_site_status"
      expr: overall_site_status
      comment: "Overall site operational status for the day (e.g. Normal, Delayed, Shutdown), a key executive dashboard dimension."
    - name: "site_access_status"
      expr: site_access_status
      comment: "Site access condition for the day (e.g. Open, Restricted, Closed), used for delay and productivity analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Prevailing weather condition recorded in the daily log, used for weather-impact correlation."
    - name: "has_delay_event"
      expr: has_delay_event
      comment: "Boolean flag indicating whether a delay event was recorded on this day, used for delay frequency trending."
    - name: "has_safety_observation"
      expr: has_safety_observation
      comment: "Boolean flag indicating whether a safety observation was recorded, a leading HSE indicator."
    - name: "lti_occurred_flag"
      expr: lti_occurred_flag
      comment: "Boolean flag indicating a Lost Time Injury occurred on this day. Critical safety lagging indicator."
    - name: "ncr_raised_flag"
      expr: ncr_raised_flag
      comment: "Boolean flag indicating a Non-Conformance Report was raised, used for quality performance monitoring."
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Boolean flag indicating a Toolbox Meeting was conducted, a mandatory HSE compliance control."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating a cost impact event was recorded in the daily log."
    - name: "eot_impact_flag"
      expr: eot_impact_flag
      comment: "Boolean flag indicating an Extension of Time impact was recorded, used for contract and schedule risk tracking."
  measures:
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured (cubic metres) across daily logs. Core production output KPI for structural and civil works."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved (cubic metres). Key production KPI for civil and bulk earthworks projects."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across daily logs. Directly impacts schedule performance and EOT claims."
    - name: "avg_delay_duration_hrs"
      expr: AVG(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Average delay duration per daily log entry. Indicates typical disruption severity for schedule risk assessment."
    - name: "total_precipitation_mm"
      expr: SUM(CAST(precipitation_mm AS DOUBLE))
      comment: "Total precipitation recorded across log days. Used to correlate weather events with productivity and delay impacts."
    - name: "avg_temperature_high_c"
      expr: AVG(CAST(temperature_high_c AS DOUBLE))
      comment: "Average daily high temperature. Informs heat management planning and worker safety compliance obligations."
    - name: "delay_day_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN has_delay_event = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of logged days with at least one delay event. A key schedule risk indicator for project leadership."
    - name: "lti_frequency_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lti_occurred_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of logged days with a Lost Time Injury. Critical safety lagging KPI reported to executives and regulators."
    - name: "ncr_raise_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ncr_raised_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of logged days with an NCR raised. Tracks quality non-conformance frequency for quality management reporting."
    - name: "tbm_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tbm_conducted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of logged days where a Toolbox Meeting was conducted. Mandatory HSE compliance KPI."
    - name: "eot_impact_day_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN eot_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of logged days with an EOT impact recorded. Informs contract administration and claims management decisions."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_equipment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilisation, productivity, and cost KPIs derived from equipment deployment records on construction sites, enabling fleet performance management and cost control decisions."
  source: "`construction_ecm`.`site`.`equipment_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of the equipment deployment, the primary time dimension for fleet utilisation trending."
    - name: "shift_date"
      expr: shift_date
      comment: "Shift date associated with the equipment deployment, used for shift-level fleet analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type/category of equipment deployed (e.g. Excavator, Crane, Compactor), enabling fleet-type performance benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (e.g. Day, Night) for shift-level equipment utilisation analysis."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the equipment deployment record (e.g. Active, Released, Cancelled)."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Equipment ownership classification (e.g. Owned, Rented, Hired) for cost structure and fleet strategy analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used by the equipment, relevant for sustainability and cost reporting."
    - name: "breakdown_flag"
      expr: breakdown_flag
      comment: "Boolean flag indicating a breakdown occurred during the deployment. Key fleet reliability indicator."
    - name: "pre_start_check_flag"
      expr: pre_start_check_flag
      comment: "Boolean flag indicating a pre-start safety inspection was completed. Mandatory HSE compliance control."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the deployment, used for weather-impact correlation on equipment productivity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the hourly rate and cost calculations, required for multi-currency project reporting."
    - name: "production_unit_of_measure"
      expr: production_unit_of_measure
      comment: "Unit of measure for production quantities, enabling cross-equipment productivity normalisation."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours across all equipment deployments. Primary fleet utilisation volume KPI."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across equipment deployments. High idle hours indicate inefficient fleet deployment and wasted cost."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours. Standby costs are typically charged at a reduced rate; tracking this informs contract cost management."
    - name: "total_breakdown_hours"
      expr: SUM(CAST(breakdown_hours AS DOUBLE))
      comment: "Total hours lost to equipment breakdowns. Directly impacts schedule and triggers maintenance strategy review."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across all equipment deployments. Key input to operational cost and carbon emissions reporting."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total actual production quantity delivered by deployed equipment. Core output volume KPI."
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production quantity for deployed equipment. Denominator for equipment production achievement rate."
    - name: "equipment_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(operating_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(idle_hours AS DOUBLE)) + SUM(CAST(standby_hours AS DOUBLE)) + SUM(CAST(breakdown_hours AS DOUBLE)), 0), 2)
      comment: "Operating hours as a percentage of total available hours (operating + idle + standby + breakdown). Core fleet efficiency KPI for asset management decisions."
    - name: "breakdown_rate"
      expr: ROUND(100.0 * SUM(CAST(breakdown_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(idle_hours AS DOUBLE)) + SUM(CAST(standby_hours AS DOUBLE)) + SUM(CAST(breakdown_hours AS DOUBLE)), 0), 2)
      comment: "Breakdown hours as a percentage of total available hours. Elevated values trigger maintenance programme review and fleet replacement decisions."
    - name: "production_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(production_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_quantity AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned production for equipment. Measures equipment productivity against schedule targets."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across equipment deployments. Used for fleet cost benchmarking and hire vs. own decisions."
    - name: "pre_start_check_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pre_start_check_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment deployments with a completed pre-start safety check. Mandatory HSE compliance KPI."
    - name: "breakdown_deployment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN breakdown_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment deployments that experienced a breakdown. Fleet reliability KPI for maintenance and procurement decisions."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_field_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field progress measurement KPIs tracking installed quantities, percent complete, earned value, and schedule performance across construction activities and work fronts."
  source: "`construction_ecm`.`site`.`field_progress`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the field progress measurement, the primary time dimension for progress trending."
    - name: "data_date"
      expr: data_date
      comment: "Data date (cut-off date) for the progress snapshot, used for period-over-period progress comparison."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of construction activity (e.g. Earthworks, Concrete, Structural Steel), enabling trade-level progress analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the progress measurement (e.g. Submitted, Approved, Rejected), used for data quality and payment milestone tracking."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress (e.g. Physical Measurement, Milestone, Weighted Steps), relevant for measurement governance."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type of the measurement (e.g. Daily, Weekly, Monthly), used for reporting cadence analysis."
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for installed quantities, required for cross-activity normalisation."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Boolean flag indicating whether the activity is on the critical path. Critical path progress is the primary schedule risk indicator."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Boolean flag indicating whether the progress entry relates to a project milestone."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of measurement, used for weather-impact correlation on progress."
    - name: "crew_size"
      expr: crew_size
      comment: "Crew size associated with the progress entry, used for productivity benchmarking."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total cumulative installed quantity across all progress entries. Primary physical progress volume KPI."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in the current measurement period. Used for period-on-period production rate analysis."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all progress entries. Denominator for progress achievement rate calculations."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value). Core earned value management KPI for project financial performance."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion across all progress entries. Baseline for earned value and cost performance index calculations."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours associated with field progress entries. Used for equipment productivity and cost allocation analysis."
    - name: "avg_reported_percent_complete"
      expr: AVG(CAST(reported_percent_complete AS DOUBLE))
      comment: "Average reported percent complete across all progress entries. High-level progress indicator for executive dashboards."
    - name: "avg_progress_delta"
      expr: AVG(CAST(progress_delta AS DOUBLE))
      comment: "Average period-over-period progress increment. Declining deltas signal slowing production rates requiring management intervention."
    - name: "quantity_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Installed quantity as a percentage of planned quantity. Core schedule performance KPI for site and project management."
    - name: "earned_value_performance_index"
      expr: ROUND(SUM(CAST(bcwp AS DOUBLE)) / NULLIF(SUM(CAST(budget_at_completion AS DOUBLE)), 0), 4)
      comment: "Ratio of earned value (BCWP) to budget at completion. Values below 1.0 indicate cost or schedule underperformance requiring executive attention."
    - name: "critical_path_progress_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_path = TRUE THEN installed_quantity ELSE 0 END) / NULLIF(SUM(CASE WHEN is_critical_path = TRUE THEN planned_quantity ELSE 0 END), 0), 2)
      comment: "Progress achievement rate specifically for critical path activities. The single most important schedule performance KPI for project delivery."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_material_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material delivery performance KPIs covering delivery volumes, acceptance rates, schedule adherence, and quality compliance for construction site supply chain management."
  source: "`construction_ecm`.`site`.`material_delivery`"
  dimensions:
    - name: "delivery_date"
      expr: delivery_date
      comment: "Actual date of material delivery to site, the primary time dimension for supply chain performance trending."
    - name: "expected_delivery_date"
      expr: expected_delivery_date
      comment: "Originally scheduled delivery date, used to calculate delivery schedule variance."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery (e.g. Received, Partial, Rejected, Pending), used for supply chain pipeline monitoring."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Condition of materials upon receipt (e.g. Good, Damaged, Incomplete), used for quality and supplier performance analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for delivered quantities, required for cross-material normalisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the delivery value, required for multi-currency procurement reporting."
    - name: "hazardous_material"
      expr: hazardous_material
      comment: "Boolean flag indicating whether the delivered material is hazardous, used for HSE compliance and storage management."
    - name: "temperature_sensitive"
      expr: temperature_sensitive
      comment: "Boolean flag indicating temperature-sensitive materials, used for cold-chain compliance monitoring."
    - name: "laydown_zone"
      expr: laydown_zone
      comment: "Site laydown zone where materials were stored upon delivery, used for site logistics and space management."
  measures:
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of materials delivered to site. Primary supply chain volume KPI."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity of delivered materials accepted after inspection. Measures effective supply chain throughput."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of materials rejected upon delivery. High rejection volumes signal supplier quality issues requiring procurement action."
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value AS DOUBLE))
      comment: "Total value of materials delivered to site. Key input to committed cost and cash flow reporting."
    - name: "material_acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_accepted AS DOUBLE)) / NULLIF(SUM(CAST(quantity_delivered AS DOUBLE)), 0), 2)
      comment: "Percentage of delivered quantity accepted after inspection. Core supplier quality KPI; low rates trigger supplier performance reviews."
    - name: "material_rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_rejected AS DOUBLE)) / NULLIF(SUM(CAST(quantity_delivered AS DOUBLE)), 0), 2)
      comment: "Percentage of delivered quantity rejected. Elevated rejection rates directly impact schedule and cost through rework and reorder cycles."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_date <= expected_delivery_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries received on or before the expected delivery date. Critical supply chain schedule adherence KPI."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate of delivered materials. Used for cost benchmarking against budget unit rates and market pricing."
    - name: "hazardous_material_delivery_count"
      expr: SUM(CASE WHEN hazardous_material = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hazardous material deliveries. Required for HSE compliance reporting and regulatory obligations."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_production_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production performance KPIs from site production entries, covering installed quantities, labour and equipment hours, productivity rates, and budget adherence for construction output management."
  source: "`construction_ecm`.`site`.`production_entry`"
  dimensions:
    - name: "entry_date"
      expr: entry_date
      comment: "Date of the production entry, the primary time dimension for production rate trending."
    - name: "entry_status"
      expr: entry_status
      comment: "Workflow status of the production entry (e.g. Draft, Submitted, Approved), used for data completeness monitoring."
    - name: "production_type"
      expr: production_type
      comment: "Type of production activity (e.g. Earthworks, Concrete, Piling), enabling trade-level productivity benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (e.g. Day, Night) for shift-level production analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantities, required for cross-activity normalisation."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the production entry period, used for weather-impact correlation."
    - name: "is_rework"
      expr: is_rework
      comment: "Boolean flag indicating whether the production entry represents rework. Rework volume is a key quality and cost KPI."
    - name: "is_baseline_revision"
      expr: is_baseline_revision
      comment: "Boolean flag indicating a baseline revision entry, used for change management and scope tracking."
    - name: "crew_size"
      expr: crew_size
      comment: "Crew size associated with the production entry, used for labour productivity benchmarking."
    - name: "work_front_location"
      expr: work_front_location
      comment: "Physical location description of the work front, used for spatial production analysis."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed across all production entries. Primary physical output KPI for construction progress reporting."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity across production entries. Denominator for production budget achievement rate."
    - name: "total_cumulative_quantity"
      expr: SUM(CAST(cumulative_quantity AS DOUBLE))
      comment: "Total cumulative quantity installed to date. Used for overall project completion tracking."
    - name: "total_labour_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours expended on production activities. Core input to unit rate and productivity calculations."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours associated with production entries. Used for equipment cost allocation and utilisation analysis."
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate AS DOUBLE))
      comment: "Average production rate (output per unit time) across entries. Key efficiency KPI for benchmarking against budgeted production rates."
    - name: "avg_budgeted_production_rate"
      expr: AVG(CAST(budgeted_production_rate AS DOUBLE))
      comment: "Average budgeted production rate across entries. Baseline for production rate variance analysis."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across production entries. High-level progress indicator for executive reporting."
    - name: "production_budget_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_quantity AS DOUBLE)), 0), 2)
      comment: "Installed quantity as a percentage of budgeted quantity. Measures production performance against the project budget baseline."
    - name: "production_rate_efficiency"
      expr: ROUND(100.0 * AVG(CAST(production_rate AS DOUBLE)) / NULLIF(AVG(CAST(budgeted_production_rate AS DOUBLE)), 0), 2)
      comment: "Actual production rate as a percentage of budgeted production rate. Values below 100% indicate productivity underperformance requiring management intervention."
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_rework = TRUE THEN installed_quantity ELSE 0 END) / NULLIF(SUM(CAST(installed_quantity AS DOUBLE)), 0), 2)
      comment: "Rework quantity as a percentage of total installed quantity. Elevated rework rates signal quality management failures with direct cost and schedule consequences."
    - name: "labour_productivity_index"
      expr: ROUND(SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(labor_hours AS DOUBLE)), 0), 4)
      comment: "Installed quantity per labour hour. Core labour productivity KPI used to benchmark crews, trades, and projects against industry norms."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level operational KPIs from shift reports covering production output, labour hours, equipment utilisation, delay duration, and safety compliance for daily site management and executive oversight."
  source: "`construction_ecm`.`site`.`shift_report`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift, the primary time dimension for shift-level performance trending."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g. Day, Night, Swing), enabling shift-pattern performance comparison."
    - name: "report_status"
      expr: report_status
      comment: "Approval status of the shift report (e.g. Draft, Submitted, Approved), used for data completeness monitoring."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition recorded in the shift report, used for weather-impact correlation."
    - name: "delay_cause"
      expr: delay_cause
      comment: "Root cause of any delay recorded in the shift, used for systematic delay analysis and mitigation planning."
    - name: "lti_flag"
      expr: lti_flag
      comment: "Boolean flag indicating a Lost Time Injury occurred during the shift. Critical safety lagging indicator."
    - name: "ncr_raised_flag"
      expr: ncr_raised_flag
      comment: "Boolean flag indicating an NCR was raised during the shift, used for quality performance monitoring."
    - name: "tbm_conducted_flag"
      expr: tbm_conducted_flag
      comment: "Boolean flag indicating a Toolbox Meeting was conducted at shift start. Mandatory HSE compliance control."
    - name: "production_unit"
      expr: production_unit
      comment: "Unit of measure for shift production quantities, required for cross-shift normalisation."
  measures:
    - name: "total_labour_hours"
      expr: SUM(CAST(total_labour_hours AS DOUBLE))
      comment: "Total labour hours worked across all shifts. Core workforce utilisation and cost input KPI."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total actual production quantity delivered across shifts. Primary output volume KPI for shift performance reporting."
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production quantity across shifts. Denominator for shift production achievement rate."
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across shifts. Directly impacts schedule performance and informs delay claim management."
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured across shifts. Key production output KPI for structural and civil works."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume moved across shifts. Key production KPI for bulk earthworks projects."
    - name: "avg_equipment_utilisation_pct"
      expr: AVG(CAST(equipment_utilisation_pct AS DOUBLE))
      comment: "Average equipment utilisation percentage across shifts. Core fleet efficiency KPI for asset management decisions."
    - name: "shift_production_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(production_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_quantity AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned production per shift. Primary shift performance KPI for site supervisors and project managers."
    - name: "lti_shift_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lti_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts with a Lost Time Injury. Critical safety lagging KPI reported to executives and regulators."
    - name: "tbm_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN tbm_conducted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shifts where a Toolbox Meeting was conducted. Mandatory HSE compliance KPI tracked by safety managers."
    - name: "delay_intensity_rate"
      expr: ROUND(100.0 * SUM(CAST(delay_duration_hrs AS DOUBLE)) / NULLIF(SUM(CAST(total_labour_hours AS DOUBLE)), 0), 2)
      comment: "Delay hours as a percentage of total labour hours. Measures the proportion of productive time lost to delays, a key schedule efficiency indicator."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site mobilisation KPIs tracking cost performance, schedule adherence, and readiness milestones for construction site setup and demobilisation, enabling project start-up risk management."
  source: "`construction_ecm`.`site`.`site_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current mobilisation status (e.g. Planned, In Progress, Complete, Demobilised), the primary pipeline dimension for site readiness tracking."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilisation (e.g. Initial, Remobilisation, Partial), used for mobilisation pattern analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the site is located, used for geographic portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of mobilisation costs, required for multi-currency portfolio reporting."
    - name: "hse_plan_approved"
      expr: hse_plan_approved
      comment: "Boolean flag indicating whether the HSE plan was approved prior to mobilisation. Mandatory regulatory compliance gate."
    - name: "environmental_permit_obtained"
      expr: environmental_permit_obtained
      comment: "Boolean flag indicating whether the environmental permit was obtained. Regulatory compliance gate for site commencement."
    - name: "access_road_established"
      expr: access_road_established
      comment: "Boolean flag indicating whether site access roads were established. Key physical readiness milestone."
    - name: "laydown_area_established"
      expr: laydown_area_established
      comment: "Boolean flag indicating whether the laydown area was established. Critical logistics readiness milestone."
    - name: "site_office_established"
      expr: site_office_established
      comment: "Boolean flag indicating whether the site office was established. Operational readiness milestone."
    - name: "site_fencing_complete"
      expr: site_fencing_complete
      comment: "Boolean flag indicating whether site fencing was completed. HSE and security compliance milestone."
    - name: "temporary_utilities_connected"
      expr: temporary_utilities_connected
      comment: "Boolean flag indicating whether temporary utilities (power, water) were connected. Operational readiness milestone."
    - name: "leed_certification_target"
      expr: leed_certification_target
      comment: "Target LEED certification level for the site, used for sustainability portfolio reporting."
    - name: "planned_mobilization_date"
      expr: planned_mobilization_date
      comment: "Planned mobilisation date, used for schedule variance analysis."
    - name: "actual_mobilization_date"
      expr: actual_mobilization_date
      comment: "Actual mobilisation date, used to calculate mobilisation schedule variance."
  measures:
    - name: "total_mobilization_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual mobilisation cost across all site mobilisations. Core cost performance KPI for project start-up budget management."
    - name: "total_mobilization_cost_budget"
      expr: SUM(CAST(cost_budget AS DOUBLE))
      comment: "Total budgeted mobilisation cost. Denominator for mobilisation cost performance index."
    - name: "total_site_area_sqm"
      expr: SUM(CAST(site_area_sqm AS DOUBLE))
      comment: "Total site area (square metres) across mobilisations. Used for site capacity and resource density analysis."
    - name: "mobilization_cost_performance_index"
      expr: ROUND(SUM(CAST(cost_budget AS DOUBLE)) / NULLIF(SUM(CAST(cost_actual AS DOUBLE)), 0), 4)
      comment: "Budget divided by actual mobilisation cost. Values below 1.0 indicate cost overrun on site setup, triggering project controls review."
    - name: "mobilization_cost_variance"
      expr: SUM((cost_budget) - (cost_actual))
      comment: "Difference between budgeted and actual mobilisation cost. Negative values indicate cost overrun requiring executive attention."
    - name: "avg_mobilization_schedule_variance_days"
      expr: AVG(DATEDIFF(actual_mobilization_date, planned_mobilization_date))
      comment: "Average number of days between planned and actual mobilisation date. Positive values indicate late mobilisation, a leading indicator of project schedule risk."
    - name: "hse_plan_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hse_plan_approved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations with an approved HSE plan. Mandatory regulatory compliance KPI tracked by HSE and project leadership."
    - name: "environmental_permit_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN environmental_permit_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations with an environmental permit obtained. Regulatory compliance KPI with direct legal and reputational risk implications."
    - name: "full_readiness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN access_road_established = TRUE AND laydown_area_established = TRUE AND site_office_established = TRUE AND temporary_utilities_connected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of mobilisations achieving all four core physical readiness milestones (access road, laydown area, site office, utilities). Composite site readiness KPI for project start-up management."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level site KPIs covering site status, mobilisation readiness, geographic distribution, and inspection compliance across the construction site portfolio."
  source: "`construction_ecm`.`site`.`site_site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the site (e.g. Active, Mobilising, Demobilised, Closed), the primary portfolio pipeline dimension."
    - name: "site_type"
      expr: site_type
      comment: "Type of construction site (e.g. Highway, Bridge, Building, Power Plant), used for portfolio segmentation."
    - name: "site_category"
      expr: site_category
      comment: "Category classification of the site, used for portfolio risk and resource allocation analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the site is located, used for geographic portfolio analysis and regional reporting."
    - name: "region"
      expr: region
      comment: "Geographic region of the site, used for regional performance benchmarking."
    - name: "state"
      expr: state
      comment: "State or province of the site, used for sub-regional analysis."
    - name: "is_mobilized"
      expr: is_mobilized
      comment: "Boolean flag indicating whether the site is currently mobilised. Used for active site portfolio tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status of the site (e.g. Passed, Failed, Pending), used for compliance portfolio monitoring."
    - name: "mobilization_date"
      expr: mobilization_date
      comment: "Date the site was mobilised, used for site age and lifecycle analysis."
    - name: "start_date"
      expr: start_date
      comment: "Planned start date of site operations, used for schedule adherence analysis."
    - name: "end_date"
      expr: end_date
      comment: "Planned end date of site operations, used for project completion forecasting."
  measures:
    - name: "total_site_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total site area in square feet across the portfolio. Used for capacity planning and resource density benchmarking."
    - name: "active_site_count"
      expr: SUM(CASE WHEN is_mobilized = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently mobilised and active sites. Core portfolio health KPI for executive dashboards."
    - name: "mobilized_site_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mobilized = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites in the portfolio that are currently mobilised. Indicates portfolio activation level and pipeline conversion."
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_status = 'Passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN inspection_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of inspected sites that passed their most recent inspection. Regulatory compliance KPI with direct legal and contractual implications."
    - name: "avg_site_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average site area in square feet. Used for portfolio scale benchmarking and resource planning norms."
    - name: "permit_expiry_risk_count"
      expr: SUM(CASE WHEN permit_expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND permit_expiry_date >= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of sites with permits expiring within the next 30 days. Proactive compliance risk KPI that triggers permit renewal actions."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_work_front`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work front performance KPIs covering production achievement, schedule adherence, critical path exposure, and HSE risk across active construction work fronts."
  source: "`construction_ecm`.`site`.`work_front`"
  dimensions:
    - name: "front_status"
      expr: front_status
      comment: "Current status of the work front (e.g. Active, Suspended, Complete, Planned), the primary pipeline dimension."
    - name: "front_type"
      expr: front_type
      comment: "Type of work front (e.g. Earthworks, Structural, MEP, Finishing), used for trade-level performance analysis."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Zone classification of the work front (e.g. Restricted, General, Hazardous), used for HSE risk and access management."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk level assigned to the work front (e.g. Low, Medium, High, Critical), used for safety resource allocation decisions."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Boolean flag indicating whether the work front is on the critical path. Critical path fronts receive priority resource allocation."
    - name: "is_subcontracted"
      expr: is_subcontracted
      comment: "Boolean flag indicating whether the work front is subcontracted, used for direct vs. subcontract performance comparison."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern operating on the work front (e.g. Single, Double, 24hr), used for productivity and cost analysis."
    - name: "environmental_sensitivity"
      expr: environmental_sensitivity
      comment: "Environmental sensitivity classification of the work front location, used for environmental compliance monitoring."
    - name: "weather_sensitivity"
      expr: weather_sensitivity
      comment: "Weather sensitivity of the work front activities, used for schedule risk and contingency planning."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the work front, used for schedule adherence analysis."
    - name: "actual_start_date"
      expr: actual_start_date
      comment: "Actual start date of the work front, used to calculate start date variance."
    - name: "planned_finish_date"
      expr: planned_finish_date
      comment: "Planned finish date of the work front, used for completion forecasting."
    - name: "production_unit"
      expr: production_unit
      comment: "Unit of measure for work front production quantities, required for cross-front normalisation."
  measures:
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity delivered across all work fronts. Primary output volume KPI for site production management."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity across work fronts. Denominator for production achievement rate."
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total area (square metres) covered by work fronts. Used for spatial production density and resource allocation analysis."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percent complete across all work fronts. High-level portfolio progress indicator for executive dashboards."
    - name: "production_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned production across work fronts. Core schedule performance KPI for site and project management."
    - name: "critical_path_front_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_path = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work fronts on the critical path. High values indicate concentrated schedule risk requiring priority resource allocation."
    - name: "subcontracted_front_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_subcontracted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work fronts that are subcontracted. Tracks subcontract dependency and associated performance and cost risk."
    - name: "high_risk_front_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hse_risk_level IN ('High', 'Critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work fronts classified as High or Critical HSE risk. Informs safety resource deployment and executive risk reporting."
    - name: "start_date_variance_days"
      expr: AVG(DATEDIFF(actual_start_date, planned_start_date))
      comment: "Average days between planned and actual start date across work fronts. Positive values indicate late starts, a leading schedule risk indicator."
    - name: "avg_elevation_m"
      expr: AVG(CAST(elevation_m AS DOUBLE))
      comment: "Average elevation (metres) of work fronts. Used for high-altitude work planning, HSE risk classification, and logistics cost analysis."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`site_instruction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site instruction KPIs tracking cost and time impact exposure, contractor response compliance, dispute rates, and urgency distribution for contract administration and project controls."
  source: "`construction_ecm`.`site`.`instruction`"
  dimensions:
    - name: "instruction_status"
      expr: instruction_status
      comment: "Current status of the instruction (e.g. Issued, Acknowledged, Disputed, Closed), used for instruction pipeline management."
    - name: "instruction_type"
      expr: instruction_type
      comment: "Type of instruction (e.g. Variation, Direction, Clarification, Hold), used for instruction category analysis."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency level of the instruction (e.g. Routine, Urgent, Emergency), used for prioritisation and response time analysis."
    - name: "issue_date"
      expr: issue_date
      comment: "Date the instruction was issued, the primary time dimension for instruction volume trending."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Boolean flag indicating the instruction has a cost impact, used for cost exposure monitoring."
    - name: "time_impact_flag"
      expr: time_impact_flag
      comment: "Boolean flag indicating the instruction has a time/schedule impact, used for EOT exposure monitoring."
    - name: "hse_implication_flag"
      expr: hse_implication_flag
      comment: "Boolean flag indicating HSE implications, used for safety-critical instruction tracking."
    - name: "contractor_dispute_flag"
      expr: contractor_dispute_flag
      comment: "Boolean flag indicating the contractor has disputed the instruction, used for contract dispute risk monitoring."
    - name: "quality_hold_required"
      expr: quality_hold_required
      comment: "Boolean flag indicating a quality hold is required, used for quality management and ITP compliance tracking."
    - name: "issuing_authority_role"
      expr: issuing_authority_role
      comment: "Role of the authority issuing the instruction (e.g. Superintendent, Engineer, Client), used for instruction source analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimated cost impact, required for multi-currency contract reporting."
  measures:
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact of all instructions. Core contract administration KPI for cost exposure and variation management."
    - name: "cost_impact_instruction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cost_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instructions with a cost impact. Elevated rates signal scope creep and contract cost risk requiring executive attention."
    - name: "time_impact_instruction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN time_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instructions with a schedule/time impact. Directly informs EOT claim exposure and programme risk reporting."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN contractor_dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instructions that have been disputed by the contractor. Elevated dispute rates signal contract relationship deterioration and legal risk."
    - name: "avg_contractor_response_days"
      expr: AVG(DATEDIFF(contractor_response_date, issue_date))
      comment: "Average days from instruction issue to contractor response. Measures contractor responsiveness against contractual response obligations."
    - name: "overdue_response_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN contractor_response_date > contractor_response_due_date THEN 1 ELSE 0 END) / NULLIF(COUNT(CASE WHEN contractor_response_date IS NOT NULL AND contractor_response_due_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of instructions where the contractor response was received after the due date. Contractual compliance KPI for project administration."
    - name: "hse_critical_instruction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hse_implication_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of instructions with HSE implications. Used by safety managers and executives to monitor safety-critical instruction exposure."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per instruction. Used for benchmarking instruction cost exposure and variation order sizing."
$$;