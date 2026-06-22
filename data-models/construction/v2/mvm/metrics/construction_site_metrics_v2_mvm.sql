-- Metric views for domain: site | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_concrete_pour`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and quality KPIs for concrete pour activities on construction sites. Tracks volume throughput, slump compliance, temperature conditions, and QC hold rates to support pour quality governance and production reporting."
  source: "`vibe_construction_v1`.`site`.`concrete_pour`"
  dimensions:
    - name: "pour_date"
      expr: pour_date
      comment: "Date the concrete pour was executed, used for daily and period-based trend analysis."
    - name: "pour_type"
      expr: pour_type
      comment: "Classification of the pour (e.g. slab, column, footing) for structural element breakdown."
    - name: "pour_status"
      expr: pour_status
      comment: "Current status of the pour record (e.g. completed, in-progress, rejected) for pipeline monitoring."
    - name: "structure_element"
      expr: structure_element
      comment: "Structural element being poured (e.g. beam, wall, slab) for element-level quality tracking."
    - name: "placement_method"
      expr: placement_method
      comment: "Method used to place concrete (e.g. pump, crane bucket) for method-based performance comparison."
    - name: "curing_method"
      expr: curing_method
      comment: "Curing technique applied post-pour, relevant to strength outcome analysis."
    - name: "qc_hold_status"
      expr: qc_hold_status
      comment: "QC hold classification indicating whether the pour is under quality review or cleared."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Prevailing weather at time of pour, used to correlate environmental conditions with quality outcomes."
    - name: "slump_compliant"
      expr: slump_compliant
      comment: "Boolean flag indicating whether the slump test result met specification, for compliance filtering."
  measures:
    - name: "total_volume_poured_m3"
      expr: SUM(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Total concrete volume poured in cubic metres. Core production throughput KPI for site progress and schedule tracking."
    - name: "avg_volume_per_pour_m3"
      expr: AVG(CAST(volume_poured_m3 AS DOUBLE))
      comment: "Average concrete volume per pour event. Indicates pour batch sizing efficiency and planning accuracy."
    - name: "total_pour_count"
      expr: COUNT(1)
      comment: "Total number of concrete pour events recorded. Baseline activity volume metric for scheduling and resource planning."
    - name: "slump_compliant_pour_count"
      expr: COUNT(CASE WHEN slump_compliant = TRUE THEN 1 END)
      comment: "Number of pours where slump test result met specification. Numerator for slump compliance rate calculation."
    - name: "slump_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN slump_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours that passed slump compliance testing. Critical quality KPI — low rates trigger QC investigation and potential mix design review."
    - name: "qc_hold_pour_count"
      expr: COUNT(CASE WHEN qc_hold_status IS NOT NULL AND qc_hold_status != 'CLEARED' THEN 1 END)
      comment: "Number of pours currently under a QC hold. Elevated counts signal systemic quality issues requiring management intervention."
    - name: "avg_slump_test_result_mm"
      expr: AVG(CAST(slump_test_result_mm AS DOUBLE))
      comment: "Average slump test result in millimetres across all pours. Tracks concrete workability trends and mix design consistency."
    - name: "avg_specified_strength_mpa"
      expr: AVG(CAST(specified_strength_mpa AS DOUBLE))
      comment: "Average specified compressive strength in MPa across pour events. Indicates the structural demand profile of active works."
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at time of pour. Temperatures outside specification range risk strength loss and must be flagged for corrective action."
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during pour operations. Used to assess hot/cold weather concreting risk exposure."
    - name: "slump_exceedance_count"
      expr: COUNT(CASE WHEN slump_test_result_mm > slump_specified_max_mm THEN 1 END)
      comment: "Number of pours where slump exceeded the specified maximum. Exceedances indicate over-watered mixes and potential strength non-conformance."
    - name: "slump_deficiency_count"
      expr: COUNT(CASE WHEN slump_test_result_mm < slump_specified_min_mm THEN 1 END)
      comment: "Number of pours where slump fell below the specified minimum. Deficiencies indicate stiff mixes that may cause placement and compaction issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_crew_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce productivity and utilisation KPIs for crew deployment events. Tracks planned vs actual hours, overtime exposure, productivity rates, and weather impact to support labour cost control and operational efficiency decisions."
  source: "`vibe_construction_v1`.`site`.`crew_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of the crew deployment, used for daily and period-based workforce trend analysis."
    - name: "crew_type"
      expr: crew_type
      comment: "Classification of the crew (e.g. civil, structural, mechanical) for trade-level performance breakdown."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification (e.g. day, night, extended) for shift-pattern productivity comparison."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the deployment record for pipeline and completion tracking."
    - name: "is_subcontractor_crew"
      expr: is_subcontractor_crew
      comment: "Boolean flag distinguishing subcontractor from direct-hire crews for cost and performance segmentation."
    - name: "is_overtime"
      expr: is_overtime
      comment: "Boolean flag indicating whether the deployment included overtime, for overtime cost exposure analysis."
    - name: "is_weather_impacted"
      expr: is_weather_impacted
      comment: "Boolean flag indicating weather-related disruption to the deployment, for weather risk quantification."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Prevailing weather condition during deployment, for environmental impact correlation."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for any deployment delay, used to identify systemic productivity loss drivers."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilisation readiness status of the crew for deployment pipeline monitoring."
  measures:
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual labour hours worked across all crew deployments. Core workforce cost driver and schedule progress indicator."
    - name: "total_planned_hours"
      expr: SUM(CAST(planned_hours AS DOUBLE))
      comment: "Total planned labour hours across all crew deployments. Baseline for schedule adherence and resource planning."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred. Elevated overtime signals schedule pressure, resource shortfalls, or poor planning — a direct cost risk indicator."
    - name: "hours_variance"
      expr: SUM((CAST(actual_hours AS DOUBLE)) - (CAST(planned_hours AS DOUBLE)))
      comment: "Difference between actual and planned hours (positive = overrun). Measures labour schedule adherence and cost variance exposure."
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total actual hours. High rates indicate unsustainable work patterns and cost overrun risk."
    - name: "hours_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to planned hours expressed as a percentage. Values above 100% indicate overrun; below 100% may indicate underutilisation or delays."
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity delivered by deployed crews. Measures physical output against workforce investment."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity for deployed crews. Baseline for production schedule adherence."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned production. Core productivity KPI — values below 80% trigger management intervention."
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate across crew deployments. Tracks workforce efficiency trends and supports benchmarking between crews and trades."
    - name: "weather_impacted_deployment_count"
      expr: COUNT(CASE WHEN is_weather_impacted = TRUE THEN 1 END)
      comment: "Number of deployments disrupted by weather. High counts support EOT claims and resource reallocation decisions."
    - name: "total_deployment_count"
      expr: COUNT(1)
      comment: "Total number of crew deployment events. Baseline activity volume for workforce planning and reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_daily_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site-level daily operational KPIs derived from daily construction logs. Tracks delay exposure, safety events, NCR activity, weather impact, and production volumes to support site management and project controls decisions."
  source: "`vibe_construction_v1`.`site`.`daily_log`"
  dimensions:
    - name: "log_date"
      expr: log_date
      comment: "Date of the daily log entry, used for time-series trend analysis of site conditions."
    - name: "log_status"
      expr: log_status
      comment: "Approval status of the daily log (e.g. draft, approved, rejected) for data completeness monitoring."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification for the log period, enabling shift-pattern performance comparison."
    - name: "overall_site_status"
      expr: overall_site_status
      comment: "High-level site operational status for the day, used for executive dashboard roll-ups."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Prevailing weather condition recorded in the log, for weather impact correlation analysis."
    - name: "site_access_status"
      expr: site_access_status
      comment: "Site access condition for the day (e.g. open, restricted, closed) for delay root cause analysis."
    - name: "has_delay_event"
      expr: has_delay_event
      comment: "Boolean flag indicating whether a delay event was recorded, for delay frequency tracking."
    - name: "lti_occurred_flag"
      expr: lti_occurred_flag
      comment: "Boolean flag indicating a Lost Time Injury occurred, for safety performance monitoring."
    - name: "ncr_raised_flag"
      expr: ncr_raised_flag
      comment: "Boolean flag indicating a Non-Conformance Report was raised, for quality event tracking."
  measures:
    - name: "total_delay_duration_hrs"
      expr: SUM(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Total delay hours recorded across all daily logs. Core schedule risk KPI — high values directly support EOT claims and resource reallocation decisions."
    - name: "avg_daily_delay_hrs"
      expr: AVG(CAST(total_delay_duration_hrs AS DOUBLE))
      comment: "Average delay hours per daily log entry. Tracks chronic delay patterns that erode schedule float and increase cost."
    - name: "delay_day_count"
      expr: COUNT(CASE WHEN has_delay_event = TRUE THEN 1 END)
      comment: "Number of days on which at least one delay event was recorded. Measures delay frequency for schedule risk assessment."
    - name: "delay_frequency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN has_delay_event = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of logged days that experienced a delay event. High rates indicate systemic schedule risk requiring management escalation."
    - name: "lti_day_count"
      expr: COUNT(CASE WHEN lti_occurred_flag = TRUE THEN 1 END)
      comment: "Number of days on which a Lost Time Injury occurred. Critical safety KPI — any non-zero value triggers executive review and regulatory reporting."
    - name: "ncr_day_count"
      expr: COUNT(CASE WHEN ncr_raised_flag = TRUE THEN 1 END)
      comment: "Number of days on which a Non-Conformance Report was raised. Tracks quality event frequency for QA programme effectiveness assessment."
    - name: "total_concrete_volume_m3"
      expr: SUM(CAST(concrete_volume_m3 AS DOUBLE))
      comment: "Total concrete volume recorded in daily logs in cubic metres. Tracks daily concrete production throughput for schedule progress reporting."
    - name: "total_earthworks_volume_m3"
      expr: SUM(CAST(earthworks_volume_m3 AS DOUBLE))
      comment: "Total earthworks volume recorded in daily logs in cubic metres. Measures bulk earthworks progress against programme targets."
    - name: "total_precipitation_mm"
      expr: SUM(CAST(precipitation_mm AS DOUBLE))
      comment: "Total precipitation recorded across daily logs in millimetres. Quantifies weather exposure for EOT substantiation and risk reporting."
    - name: "safety_observation_day_count"
      expr: COUNT(CASE WHEN has_safety_observation = TRUE THEN 1 END)
      comment: "Number of days with at least one safety observation recorded. Tracks proactive safety culture engagement — low rates may indicate under-reporting."
    - name: "total_log_count"
      expr: COUNT(1)
      comment: "Total number of daily log entries. Baseline for site activity coverage and data completeness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_equipment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment utilisation, productivity, and cost KPIs for site equipment deployments. Tracks operating vs idle vs breakdown hours, fuel consumption, and production output to support fleet management and cost control decisions."
  source: "`vibe_construction_v1`.`site`.`equipment_deployment`"
  dimensions:
    - name: "deployment_date"
      expr: deployment_date
      comment: "Date of the equipment deployment, used for daily and period-based utilisation trend analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment deployed (e.g. excavator, crane, dozer) for fleet-level performance benchmarking."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification for the deployment, enabling shift-pattern utilisation comparison."
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current status of the equipment deployment record for fleet pipeline monitoring."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Equipment ownership classification (e.g. owned, rented, subcontractor) for cost structure analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used by the equipment, relevant for emissions reporting and fuel cost analysis."
    - name: "breakdown_flag"
      expr: breakdown_flag
      comment: "Boolean flag indicating a breakdown occurred during the deployment, for reliability tracking."
    - name: "pre_start_check_flag"
      expr: pre_start_check_flag
      comment: "Boolean flag indicating whether a pre-start safety check was completed, for HSE compliance monitoring."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during deployment, for environmental impact correlation with utilisation."
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total productive operating hours across all equipment deployments. Core fleet utilisation and cost recovery KPI."
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours across all equipment deployments. High idle hours represent direct cost waste and trigger fleet reallocation decisions."
    - name: "total_standby_hours"
      expr: SUM(CAST(standby_hours AS DOUBLE))
      comment: "Total standby hours across all equipment deployments. Standby costs are often contractually recoverable — tracking is essential for cost claims."
    - name: "total_breakdown_hours"
      expr: SUM(CAST(breakdown_hours AS DOUBLE))
      comment: "Total hours lost to equipment breakdowns. Directly impacts schedule and cost — high values trigger maintenance programme review."
    - name: "equipment_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(operating_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(idle_hours AS DOUBLE)) + SUM(CAST(standby_hours AS DOUBLE)) + SUM(CAST(breakdown_hours AS DOUBLE)), 0), 2)
      comment: "Operating hours as a percentage of total available hours (operating + idle + standby + breakdown). Core fleet efficiency KPI — industry benchmark is typically 70-80%."
    - name: "breakdown_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(breakdown_hours AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)) + SUM(CAST(idle_hours AS DOUBLE)) + SUM(CAST(standby_hours AS DOUBLE)) + SUM(CAST(breakdown_hours AS DOUBLE)), 0), 2)
      comment: "Breakdown hours as a percentage of total available hours. Elevated rates indicate fleet reliability issues requiring maintenance intervention."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed across all equipment deployments in litres. Key cost and emissions driver — tracked against budget and sustainability targets."
    - name: "avg_fuel_per_operating_hour"
      expr: ROUND(SUM(CAST(fuel_consumption_liters AS DOUBLE)) / NULLIF(SUM(CAST(operating_hours AS DOUBLE)), 0), 3)
      comment: "Average fuel consumption per operating hour in litres/hour. Efficiency benchmark for equipment type — deviations indicate mechanical issues or operator behaviour."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output quantity delivered by deployed equipment. Measures physical productivity against equipment investment."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(production_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_quantity AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned production for equipment deployments. Values below target trigger fleet reallocation or schedule revision."
    - name: "breakdown_deployment_count"
      expr: COUNT(CASE WHEN breakdown_flag = TRUE THEN 1 END)
      comment: "Number of deployment events that experienced a breakdown. Frequency metric for fleet reliability management."
    - name: "pre_start_check_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pre_start_check_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deployments where a pre-start safety check was completed. HSE compliance KPI — non-compliance is a regulatory and safety risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_field_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field progress measurement KPIs tracking physical completion, earned value, and schedule performance across construction activities. Supports project controls, earned value management, and milestone reporting decisions."
  source: "`vibe_construction_v1`.`site`.`field_progress`"
  dimensions:
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the field progress measurement, used for period-based progress trend analysis."
    - name: "data_date"
      expr: data_date
      comment: "Data cut-off date for the progress record, used for earned value reporting period alignment."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of construction activity being measured, for activity-level progress breakdown."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the progress measurement (e.g. approved, pending, rejected) for data quality monitoring."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure progress (e.g. survey, visual, BIM) for measurement quality assessment."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period classification (e.g. daily, weekly, monthly) for reporting cadence alignment."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Boolean flag indicating whether the activity is on the critical path, for schedule risk prioritisation."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Boolean flag indicating whether the measurement relates to a project milestone."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of measurement, for environmental impact correlation."
    - name: "quantity_unit_of_measure"
      expr: quantity_unit_of_measure
      comment: "Unit of measure for installed quantities, required for correct aggregation context."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total cumulative installed quantity across all field progress records. Core physical progress KPI for schedule and payment milestone tracking."
    - name: "total_period_installed_quantity"
      expr: SUM(CAST(period_installed_quantity AS DOUBLE))
      comment: "Total quantity installed in the current measurement period. Tracks production rate against programme to identify schedule slippage early."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across all field progress records. Baseline for physical progress schedule adherence."
    - name: "quantity_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Installed quantity as a percentage of planned quantity. Core physical progress KPI — values below 90% trigger schedule recovery planning."
    - name: "avg_reported_percent_complete"
      expr: AVG(CAST(reported_percent_complete AS DOUBLE))
      comment: "Average reported percentage complete across all measured activities. High-level progress indicator for executive dashboards and client reporting."
    - name: "avg_progress_delta"
      expr: AVG(CAST(progress_delta AS DOUBLE))
      comment: "Average period-on-period progress change. Tracks momentum — declining deltas signal slowing production rates requiring intervention."
    - name: "total_bcwp"
      expr: SUM(CAST(bcwp AS DOUBLE))
      comment: "Total Budgeted Cost of Work Performed (Earned Value) in currency. Core EVM KPI used to assess cost and schedule performance against budget."
    - name: "total_budget_at_completion"
      expr: SUM(CAST(budget_at_completion AS DOUBLE))
      comment: "Total Budget at Completion across all field progress records. Denominator for overall project completion percentage and cost performance assessment."
    - name: "earned_value_performance_pct"
      expr: ROUND(100.0 * SUM(CAST(bcwp AS DOUBLE)) / NULLIF(SUM(CAST(budget_at_completion AS DOUBLE)), 0), 2)
      comment: "BCWP as a percentage of Budget at Completion. Measures overall earned value performance — values below target indicate cost or schedule underperformance."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours recorded against field progress entries. Supports resource productivity analysis and cost allocation."
    - name: "critical_path_activity_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of field progress records on the critical path. Tracks critical path activity coverage for schedule risk management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_material_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material delivery performance and quality KPIs for site procurement and logistics. Tracks delivery accuracy, rejection rates, delivery value, and schedule adherence to support supply chain and cost control decisions."
  source: "`vibe_construction_v1`.`site`.`material_delivery`"
  dimensions:
    - name: "delivery_date"
      expr: delivery_date
      comment: "Actual date of material delivery, used for delivery schedule trend analysis."
    - name: "expected_delivery_date"
      expr: expected_delivery_date
      comment: "Originally planned delivery date, used to calculate delivery schedule variance."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. received, rejected, partial) for supply chain pipeline monitoring."
    - name: "material_category"
      expr: material_category
      comment: "Category of material delivered (e.g. structural steel, concrete, formwork) for category-level supply chain analysis."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Condition of materials upon receipt (e.g. good, damaged, non-conforming) for quality gate monitoring."
    - name: "hazardous_material"
      expr: hazardous_material
      comment: "Boolean flag indicating hazardous material, for HSE compliance and handling cost segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the delivery value, required for multi-currency financial aggregation context."
    - name: "laydown_zone"
      expr: laydown_zone
      comment: "Site laydown zone where materials were received, for logistics and storage planning."
  measures:
    - name: "total_delivery_value"
      expr: SUM(CAST(delivery_value AS DOUBLE))
      comment: "Total value of materials delivered to site. Core procurement spend KPI for cost control and budget tracking."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of materials delivered to site. Tracks supply volume against construction programme demand."
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity of delivered materials accepted after inspection. Measures effective supply receipt for production planning."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of delivered materials rejected. High rejection volumes indicate supplier quality issues and create supply chain risk."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_rejected AS DOUBLE)) / NULLIF(SUM(CAST(quantity_delivered AS DOUBLE)), 0), 2)
      comment: "Rejected quantity as a percentage of total delivered quantity. Critical supplier quality KPI — high rates trigger supplier performance reviews and potential contract action."
    - name: "acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity_accepted AS DOUBLE)) / NULLIF(SUM(CAST(quantity_delivered AS DOUBLE)), 0), 2)
      comment: "Accepted quantity as a percentage of total delivered quantity. Measures supply chain quality effectiveness for procurement governance."
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Total number of material delivery events. Baseline logistics activity volume for supply chain planning."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN delivery_date <= expected_delivery_date THEN 1 END)
      comment: "Number of deliveries received on or before the expected delivery date. Numerator for on-time delivery rate calculation."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_date <= expected_delivery_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries received on or before the expected date. Supplier schedule reliability KPI — low rates create downstream production risk."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across material deliveries. Tracks price trends and supports cost benchmarking against procurement budgets."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT primary_material_vendor_id)
      comment: "Number of distinct vendors supplying materials. Tracks supply chain concentration risk — over-reliance on few vendors increases disruption exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site permit portfolio KPIs tracking permit status, expiry risk, fee exposure, and compliance coverage. Supports regulatory compliance management, HSE governance, and project controls decisions."
  source: "`vibe_construction_v1`.`site`.`permit`"
  dimensions:
    - name: "application_date"
      expr: application_date
      comment: "Date the permit application was submitted, used for permit pipeline lead time analysis."
    - name: "approval_date"
      expr: approval_date
      comment: "Date the permit was approved, used to calculate approval lead time."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Permit expiry date, critical for proactive renewal management and compliance risk monitoring."
    - name: "permit_type"
      expr: permit_type
      comment: "Classification of the permit (e.g. environmental, building, access) for regulatory category analysis."
    - name: "site_permit_status"
      expr: site_permit_status
      comment: "Current status of the permit (e.g. active, expired, pending, revoked) for compliance portfolio monitoring."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory body or authority that issued the permit, for jurisdiction-level compliance tracking."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Boolean flag indicating safety-critical permits requiring heightened monitoring and renewal priority."
    - name: "is_environmental"
      expr: is_environmental
      comment: "Boolean flag indicating environmental permits, for environmental compliance portfolio segmentation."
    - name: "extension_requested"
      expr: extension_requested
      comment: "Boolean flag indicating a permit extension has been requested, for renewal pipeline tracking."
    - name: "fee_currency"
      expr: fee_currency
      comment: "Currency of the permit fee, required for multi-currency financial aggregation context."
  measures:
    - name: "total_permit_count"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio. Baseline regulatory compliance coverage metric."
    - name: "active_permit_count"
      expr: COUNT(CASE WHEN site_permit_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active permits. Tracks live regulatory authorisation coverage — gaps indicate compliance risk."
    - name: "expired_permit_count"
      expr: COUNT(CASE WHEN site_permit_status = 'EXPIRED' THEN 1 END)
      comment: "Number of expired permits. Any expired permit for active works is a regulatory non-compliance event requiring immediate escalation."
    - name: "safety_critical_permit_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Number of safety-critical permits in the portfolio. Tracks high-risk regulatory exposure requiring priority management attention."
    - name: "environmental_permit_count"
      expr: COUNT(CASE WHEN is_environmental = TRUE THEN 1 END)
      comment: "Number of environmental permits in the portfolio. Tracks environmental regulatory compliance coverage."
    - name: "total_permit_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total permit fee expenditure across the portfolio. Tracks regulatory cost exposure for budget management."
    - name: "extension_requested_count"
      expr: COUNT(CASE WHEN extension_requested = TRUE THEN 1 END)
      comment: "Number of permits with an extension request lodged. High counts indicate programme delays and regulatory timeline pressure."
    - name: "expiry_notice_sent_count"
      expr: COUNT(CASE WHEN expiration_notice_sent = TRUE THEN 1 END)
      comment: "Number of permits for which an expiry notice has been issued. Tracks proactive renewal management process compliance."
    - name: "permit_approval_lead_time_days"
      expr: AVG(DATEDIFF(approval_date, application_date))
      comment: "Average number of days from permit application to approval. Tracks regulatory processing efficiency — long lead times create schedule risk for dependent works."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_production_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production performance KPIs derived from site production entries. Tracks installed quantities, production rates, labour efficiency, and rework exposure to support daily production management and cost control decisions."
  source: "`vibe_construction_v1`.`site`.`production_entry`"
  dimensions:
    - name: "entry_date"
      expr: entry_date
      comment: "Date of the production entry, used for daily and period-based production trend analysis."
    - name: "entry_status"
      expr: entry_status
      comment: "Approval status of the production entry (e.g. approved, pending, rejected) for data quality monitoring."
    - name: "production_type"
      expr: production_type
      comment: "Classification of production activity type for category-level performance breakdown."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift classification for the production entry, enabling shift-pattern productivity comparison."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantities, required for correct aggregation context."
    - name: "is_rework"
      expr: is_rework
      comment: "Boolean flag indicating rework activity, for quality cost and rework rate analysis."
    - name: "is_baseline_revision"
      expr: is_baseline_revision
      comment: "Boolean flag indicating a baseline revision entry, for scope change tracking."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during production, for environmental impact correlation."
    - name: "cost_code"
      expr: cost_code
      comment: "Cost code associated with the production entry, for cost centre-level production analysis."
  measures:
    - name: "total_installed_quantity"
      expr: SUM(CAST(installed_quantity AS DOUBLE))
      comment: "Total quantity installed across all production entries. Core physical production throughput KPI for schedule progress and payment milestone tracking."
    - name: "total_budgeted_quantity"
      expr: SUM(CAST(budgeted_quantity AS DOUBLE))
      comment: "Total budgeted quantity across all production entries. Baseline for production schedule adherence and budget performance."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(installed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_quantity AS DOUBLE)), 0), 2)
      comment: "Installed quantity as a percentage of budgeted quantity. Core production performance KPI — values below 85% trigger schedule recovery planning."
    - name: "total_cumulative_quantity"
      expr: SUM(CAST(cumulative_quantity AS DOUBLE))
      comment: "Total cumulative installed quantity across all production entries. Tracks overall programme completion against total scope."
    - name: "avg_production_rate"
      expr: AVG(CAST(production_rate AS DOUBLE))
      comment: "Average production rate across all entries. Tracks workforce and equipment productivity trends for benchmarking and forecasting."
    - name: "avg_budgeted_production_rate"
      expr: AVG(CAST(budgeted_production_rate AS DOUBLE))
      comment: "Average budgeted production rate across all entries. Baseline for production rate variance analysis."
    - name: "production_rate_efficiency_pct"
      expr: ROUND(100.0 * AVG(CAST(production_rate AS DOUBLE)) / NULLIF(AVG(CAST(budgeted_production_rate AS DOUBLE)), 0), 2)
      comment: "Actual production rate as a percentage of budgeted rate. Measures workforce and equipment efficiency against plan — values below 80% trigger operational review."
    - name: "total_labour_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labour hours recorded against production entries. Core workforce cost driver for earned value and unit rate analysis."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours recorded against production entries. Supports fleet utilisation and cost allocation analysis."
    - name: "rework_entry_count"
      expr: COUNT(CASE WHEN is_rework = TRUE THEN 1 END)
      comment: "Number of production entries classified as rework. Rework volume directly impacts cost and schedule — high counts trigger quality programme review."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_rework = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production entries that are rework. Quality cost KPI — industry benchmark is typically below 5%; exceedances require management intervention."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average percentage complete across all production entries. High-level progress indicator for executive and client reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site portfolio KPIs tracking mobilisation status, geographic coverage, site area, and inspection compliance across the construction site estate. Supports portfolio management, resource allocation, and regulatory compliance decisions."
  source: "`vibe_construction_v1`.`site`.`site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Current operational status of the site (e.g. active, demobilised, on-hold) for portfolio pipeline monitoring."
    - name: "site_type"
      expr: site_type
      comment: "Classification of the site (e.g. civil, building, infrastructure) for portfolio segmentation."
    - name: "category"
      expr: category
      comment: "Site category for portfolio grouping and reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country where the site is located, for geographic portfolio analysis."
    - name: "region"
      expr: region
      comment: "Regional classification of the site, for regional portfolio performance comparison."
    - name: "is_mobilized"
      expr: is_mobilized
      comment: "Boolean flag indicating whether the site is currently mobilised, for active site portfolio tracking."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current inspection status of the site, for regulatory compliance monitoring."
    - name: "mobilization_date"
      expr: mobilization_date
      comment: "Date the site was mobilised, used for mobilisation lead time and portfolio ramp-up analysis."
  measures:
    - name: "total_site_count"
      expr: COUNT(1)
      comment: "Total number of sites in the portfolio. Baseline portfolio scale metric for resource planning and executive reporting."
    - name: "mobilized_site_count"
      expr: COUNT(CASE WHEN is_mobilized = TRUE THEN 1 END)
      comment: "Number of currently mobilised sites. Tracks active operational footprint for resource allocation and cost management decisions."
    - name: "mobilization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_mobilized = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of portfolio sites that are currently mobilised. Tracks programme ramp-up and wind-down pace for executive portfolio oversight."
    - name: "total_site_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total site area in square feet across the portfolio. Measures physical scale of operations for resource density and logistics planning."
    - name: "avg_site_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average site area in square feet. Supports site complexity benchmarking and resource allocation normalisation."
    - name: "distinct_country_count"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries in which sites are operating. Tracks geographic portfolio spread and multi-jurisdiction regulatory exposure."
    - name: "permit_expiry_risk_site_count"
      expr: COUNT(CASE WHEN permit_expiry_date IS NOT NULL AND permit_expiry_date <= DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Number of sites with a permit expiring within the next 30 days. Proactive compliance risk KPI — sites in this count require immediate renewal action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`site_work_front`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work front progress, productivity, and risk KPIs for construction work fronts. Tracks physical completion, production achievement, critical path exposure, and subcontractor performance to support site management and schedule control decisions."
  source: "`vibe_construction_v1`.`site`.`work_front`"
  dimensions:
    - name: "front_status"
      expr: front_status
      comment: "Current status of the work front (e.g. active, complete, on-hold) for portfolio pipeline monitoring."
    - name: "front_type"
      expr: front_type
      comment: "Classification of the work front type for category-level performance breakdown."
    - name: "zone_classification"
      expr: zone_classification
      comment: "Zone classification of the work front for spatial performance analysis."
    - name: "hse_risk_level"
      expr: hse_risk_level
      comment: "HSE risk level assigned to the work front, for safety risk portfolio monitoring."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Boolean flag indicating whether the work front is on the critical path, for schedule risk prioritisation."
    - name: "is_subcontracted"
      expr: is_subcontracted
      comment: "Boolean flag distinguishing subcontracted from self-performed work fronts for performance segmentation."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern operating on the work front, for resource intensity and productivity analysis."
    - name: "weather_sensitivity"
      expr: weather_sensitivity
      comment: "Weather sensitivity classification of the work front, for weather risk exposure assessment."
    - name: "environmental_sensitivity"
      expr: environmental_sensitivity
      comment: "Environmental sensitivity classification, for environmental compliance risk monitoring."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the work front, used for schedule adherence analysis."
    - name: "planned_finish_date"
      expr: planned_finish_date
      comment: "Planned finish date of the work front, used for schedule completion forecasting."
  measures:
    - name: "total_work_front_count"
      expr: COUNT(1)
      comment: "Total number of work fronts in the portfolio. Baseline operational scope metric for site management planning."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical percentage complete across all work fronts. High-level progress indicator for executive and client reporting."
    - name: "total_actual_production_qty"
      expr: SUM(CAST(actual_production_qty AS DOUBLE))
      comment: "Total actual production quantity delivered across all work fronts. Core physical throughput KPI for schedule progress tracking."
    - name: "total_planned_production_qty"
      expr: SUM(CAST(planned_production_qty AS DOUBLE))
      comment: "Total planned production quantity across all work fronts. Baseline for production schedule adherence."
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_qty AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_qty AS DOUBLE)), 0), 2)
      comment: "Actual production as a percentage of planned production across work fronts. Core schedule performance KPI — values below 85% trigger recovery planning."
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total area in square metres across all work fronts. Measures physical scope of active construction operations."
    - name: "critical_path_work_front_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of work fronts on the critical path. Tracks critical path exposure — high counts indicate schedule concentration risk."
    - name: "subcontracted_work_front_count"
      expr: COUNT(CASE WHEN is_subcontracted = TRUE THEN 1 END)
      comment: "Number of subcontracted work fronts. Tracks subcontractor dependency and associated performance management obligations."
    - name: "subcontracted_work_front_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_subcontracted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work fronts that are subcontracted. High percentages indicate significant subcontractor dependency and supply chain risk exposure."
    - name: "avg_elevation_m"
      expr: AVG(CAST(elevation_m AS DOUBLE))
      comment: "Average elevation in metres across work fronts. Supports logistics planning and HSE risk assessment for elevated works."
    - name: "high_hse_risk_work_front_count"
      expr: COUNT(CASE WHEN hse_risk_level = 'HIGH' THEN 1 END)
      comment: "Number of work fronts classified as high HSE risk. Critical safety portfolio KPI — high counts require enhanced safety supervision and resource allocation."
$$;