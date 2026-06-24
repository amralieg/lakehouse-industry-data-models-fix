-- Metric views for domain: asset | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for work order execution performance, cost control, and maintenance efficiency across the asset domain. Enables leadership to track maintenance spend, schedule adherence, downtime impact, and workforce productivity."
  source: "`vibe_manufacturing_v1`.`asset`.`asset_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current lifecycle status of the work order (e.g. Open, In Progress, Completed, Cancelled) — primary filter for backlog and completion analysis."
    - name: "work_order_type"
      expr: work_order_source
      comment: "Source or type of the work order (e.g. Preventive, Corrective, Emergency) — used to segment maintenance strategy effectiveness."
    - name: "priority"
      expr: priority
      comment: "Work order priority level (e.g. Critical, High, Medium, Low) — drives resource allocation and SLA compliance analysis."
    - name: "craft_type"
      expr: craft_type
      comment: "Trade or craft discipline assigned to the work order (e.g. Electrical, Mechanical) — used for workforce capacity planning."
    - name: "asset_criticality"
      expr: asset_criticality
      comment: "Criticality classification of the asset being maintained — enables risk-weighted maintenance prioritisation."
    - name: "capex_opex_classification"
      expr: capex_opex_classification
      comment: "Financial classification of the work order spend as capital expenditure or operational expenditure — critical for financial reporting."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar associated with the work order — supports TPM programme performance tracking."
    - name: "is_production_impacting"
      expr: is_production_impacting
      comment: "Boolean flag indicating whether the work order caused a production impact — used to quantify maintenance-driven production losses."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which costs are denominated — required for multi-currency financial consolidation."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month bucket of the planned start date — enables trend analysis of maintenance scheduling over time."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month bucket of the actual start date — used to track when maintenance work was actually executed vs planned."
    - name: "completion_code"
      expr: completion_code
      comment: "Standardised code describing how the work order was completed — supports quality and compliance reporting."
    - name: "failure_code"
      expr: failure_code
      comment: "Failure classification code associated with the work order — enables failure mode frequency analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders — baseline volume metric for maintenance workload and backlog management."
    - name: "total_actual_labor_cost"
      expr: SUM(CAST(actual_labor_cost AS DOUBLE))
      comment: "Total actual labor cost incurred across all work orders — directly informs maintenance budget performance and cost control decisions."
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost consumed across all work orders — key input for spare parts spend management and procurement planning."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours expended — used to assess workforce utilisation and capacity against planned hours."
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across all work orders — baseline for schedule adherence and resource planning."
    - name: "total_planned_material_cost"
      expr: SUM(CAST(planned_material_cost AS DOUBLE))
      comment: "Total planned material cost — used to compare against actuals for budget variance analysis."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all work orders — supports forward-looking maintenance budget forecasting."
    - name: "total_downtime_duration_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours attributed to work orders — directly linked to production loss and OEE availability impact."
    - name: "avg_downtime_duration_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average downtime duration per work order — indicates typical maintenance disruption severity for benchmarking and improvement targeting."
    - name: "labor_cost_variance"
      expr: SUM((CAST(actual_labor_cost AS DOUBLE)) - (CAST(planned_labor_hours AS DOUBLE)))
      comment: "Difference between total actual labor cost and total planned labor hours cost proxy — highlights systematic over/under-run in labor spend."
    - name: "labor_hours_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(planned_labor_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_labor_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of planned to actual labor hours expressed as a percentage — measures workforce scheduling accuracy; values below 100% indicate overruns requiring management attention."
    - name: "production_impacting_work_order_count"
      expr: COUNT(CASE WHEN is_production_impacting = TRUE THEN 1 END)
      comment: "Count of work orders that caused a production impact — key risk metric for operations leadership to track maintenance-driven production disruptions."
    - name: "safety_permit_required_count"
      expr: COUNT(CASE WHEN safety_permit_required = TRUE THEN 1 END)
      comment: "Count of work orders requiring a safety permit — supports HSE compliance monitoring and permit-to-work process governance."
    - name: "avg_actual_labor_cost_per_work_order"
      expr: AVG(CAST(actual_labor_cost AS DOUBLE))
      comment: "Average actual labor cost per work order — enables benchmarking of maintenance cost efficiency across asset types, plants, and craft groups."
    - name: "avg_actual_material_cost_per_work_order"
      expr: AVG(CAST(actual_material_cost AS DOUBLE))
      comment: "Average actual material cost per work order — supports spare parts consumption benchmarking and procurement strategy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for asset downtime analysis, production loss quantification, and reliability performance. Enables plant managers and executives to track OEE availability impact, repeat failures, and cost of downtime."
  source: "`vibe_manufacturing_v1`.`asset`.`downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "High-level category of the downtime event (e.g. Planned, Unplanned, External) — primary dimension for availability analysis."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Specific type of downtime (e.g. Mechanical Failure, Electrical Fault, Changeover) — enables granular root cause segmentation."
    - name: "failure_class"
      expr: failure_class
      comment: "Classification of the failure that caused the downtime — supports failure mode and effects analysis (FMEA) reporting."
    - name: "failure_code"
      expr: failure_code
      comment: "Standardised failure code — used for Pareto analysis of top failure causes driving downtime."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification code — enables systemic root cause analysis to drive corrective action prioritisation."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance response (e.g. Corrective, Emergency, Preventive) — used to assess reactive vs proactive maintenance balance."
    - name: "is_repeat_failure"
      expr: is_repeat_failure
      comment: "Boolean flag indicating whether this is a repeat failure on the same asset — critical indicator of unresolved root causes and CAPA effectiveness."
    - name: "is_safety_incident"
      expr: is_safety_incident
      comment: "Boolean flag indicating whether the downtime event involved a safety incident — mandatory for HSE reporting and regulatory compliance."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Boolean flag indicating environmental impact associated with the downtime event — required for environmental compliance and ESG reporting."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the downtime event record (e.g. Open, Closed, Under Investigation) — used to track resolution progress."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which estimated loss costs are denominated — required for multi-currency financial consolidation."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month bucket of the downtime event start — enables trend analysis of downtime frequency and duration over time."
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the failure was detected (e.g. Operator, Sensor, Inspection) — informs investment decisions in condition monitoring technology."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — baseline volume metric for reliability and availability performance tracking."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes — primary metric for OEE availability calculation and production loss quantification."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event in minutes — proxy for Mean Time To Repair (MTTR); lower values indicate faster maintenance response."
    - name: "total_estimated_loss_cost"
      expr: SUM(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Total estimated financial loss from downtime events — directly quantifies the business cost of unreliability for investment justification in maintenance programmes."
    - name: "avg_estimated_loss_cost_per_event"
      expr: AVG(CAST(estimated_loss_cost AS DOUBLE))
      comment: "Average estimated financial loss per downtime event — enables prioritisation of high-cost failure modes for targeted reliability improvement."
    - name: "total_estimated_production_loss_units"
      expr: SUM(CAST(estimated_production_loss_units AS DOUBLE))
      comment: "Total estimated production units lost due to downtime — directly links asset reliability to production throughput and revenue impact."
    - name: "total_repair_time_minutes"
      expr: SUM(CAST(repair_time_minutes AS DOUBLE))
      comment: "Total time spent on repairs across all downtime events — used to assess maintenance resource demand and MTTR trends."
    - name: "avg_repair_time_minutes"
      expr: AVG(CAST(repair_time_minutes AS DOUBLE))
      comment: "Average repair time per downtime event in minutes — key MTTR metric; reductions indicate improved maintenance effectiveness and spare parts availability."
    - name: "avg_response_time_minutes"
      expr: AVG(CAST(response_time_minutes AS DOUBLE))
      comment: "Average time to respond to a downtime event in minutes — measures maintenance team responsiveness; critical for SLA compliance and production recovery speed."
    - name: "avg_oee_availability_impact_pct"
      expr: AVG(CAST(oee_availability_impact_pct AS DOUBLE))
      comment: "Average OEE availability impact percentage per downtime event — directly feeds into OEE dashboard reporting for executive and plant manager review."
    - name: "repeat_failure_count"
      expr: COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END)
      comment: "Count of repeat failure events — high values indicate ineffective corrective actions and unresolved root causes; triggers CAPA escalation."
    - name: "repeat_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_repeat_failure = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that are repeat failures — strategic reliability KPI; high rates signal systemic maintenance quality issues requiring leadership intervention."
    - name: "safety_incident_count"
      expr: COUNT(CASE WHEN is_safety_incident = TRUE THEN 1 END)
      comment: "Count of downtime events involving a safety incident — mandatory HSE KPI reported to board level; zero-tolerance target drives safety investment decisions."
    - name: "unplanned_downtime_event_count"
      expr: COUNT(CASE WHEN downtime_category = 'Unplanned' THEN 1 END)
      comment: "Count of unplanned downtime events — key reliability metric; high unplanned rates indicate reactive maintenance culture and drive preventive maintenance investment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_equipment_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset fleet health, lifecycle, and financial KPIs for the equipment register. Enables asset managers and CFOs to track fleet composition, replacement value, warranty exposure, and maintenance performance by asset class and criticality."
  source: "`vibe_manufacturing_v1`.`asset`.`equipment_register`"
  dimensions:
    - name: "equipment_class"
      expr: equipment_class
      comment: "Classification of the equipment (e.g. Rotating, Static, Electrical) — primary dimension for fleet segmentation and maintenance strategy alignment."
    - name: "asset_category"
      expr: asset_category
      comment: "Business category of the asset — used for portfolio-level asset management reporting and capital planning."
    - name: "criticality_ranking"
      expr: criticality_ranking
      comment: "Criticality ranking of the equipment (e.g. Critical, Major, General) — drives maintenance strategy selection and risk-based inspection prioritisation."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Name of the equipment manufacturer — used for OEM performance benchmarking and vendor management decisions."
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the equipment — required for regulatory compliance reporting and safety-critical asset management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which asset values are denominated — required for multi-currency financial consolidation."
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month of equipment commissioning — enables fleet age analysis and capital investment trend reporting."
    - name: "next_maintenance_due_month"
      expr: DATE_TRUNC('MONTH', next_maintenance_due_date)
      comment: "Month when next maintenance is due — used for forward maintenance scheduling and resource planning."
    - name: "warranty_expiry_month"
      expr: DATE_TRUNC('MONTH', warranty_expiry_date)
      comment: "Month of warranty expiry — enables proactive warranty claim management and post-warranty cost planning."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Current condition grade of the equipment — key input for asset lifecycle decisions (repair vs replace) and capital budget planning."
    - name: "regulatory_certification"
      expr: regulatory_certification
      comment: "Regulatory certification status of the equipment — mandatory for compliance audits and operating licence maintenance."
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of registered equipment assets — baseline fleet size metric for asset management and capital planning."
    - name: "total_replacement_value"
      expr: SUM(CAST(replacement_value AS DOUBLE))
      comment: "Total replacement value of the asset fleet — critical financial metric for insurance, capital budgeting, and asset lifecycle investment decisions."
    - name: "avg_replacement_value"
      expr: AVG(CAST(replacement_value AS DOUBLE))
      comment: "Average replacement value per equipment asset — used for benchmarking asset investment levels across equipment classes and plants."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across the equipment fleet — primary reliability KPI; declining MTBF signals deteriorating fleet health requiring maintenance strategy review."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across the equipment fleet — measures maintenance responsiveness; high MTTR drives investment in spare parts availability and technician training."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power rating in kilowatts across the fleet — used for energy management, capacity planning, and sustainability reporting."
    - name: "avg_rated_capacity"
      expr: AVG(CAST(rated_capacity AS DOUBLE))
      comment: "Average rated capacity across equipment assets — supports production capacity planning and bottleneck identification."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of the equipment fleet in kilograms — used for logistics, structural load planning, and facility management decisions."
    - name: "equipment_with_expired_warranty_count"
      expr: COUNT(CASE WHEN warranty_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of equipment assets with expired warranties — highlights fleet exposure to uninsured repair costs; drives warranty renewal and maintenance budget decisions."
    - name: "critical_equipment_count"
      expr: COUNT(CASE WHEN criticality_ranking = 'Critical' THEN 1 END)
      comment: "Count of equipment classified as critical — used to size the critical asset management programme and prioritise maintenance investment."
    - name: "avg_mtbf_to_mttr_ratio"
      expr: ROUND(AVG(CAST(mean_time_between_failures AS DOUBLE)) / NULLIF(AVG(CAST(mean_time_to_repair AS DOUBLE)), 0), 2)
      comment: "Ratio of average MTBF to average MTTR — composite reliability index; higher values indicate a more reliable and maintainable fleet; used in executive reliability scorecards."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure analysis KPIs for root cause investigation, reliability engineering, and corrective action management. Enables reliability engineers and plant managers to track failure frequency, downtime cost, and CAPA compliance."
  source: "`vibe_manufacturing_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_mode_code"
      expr: failure_mode_code
      comment: "Standardised failure mode code — primary dimension for Pareto analysis of top failure modes driving downtime and repair cost."
    - name: "failure_class_code"
      expr: failure_class_code
      comment: "Classification code for the failure type — used to segment failures by category for reliability programme targeting."
    - name: "failure_cause_code"
      expr: failure_cause_code
      comment: "Root cause code for the failure — enables systemic root cause analysis and corrective action prioritisation."
    - name: "failure_impact_type"
      expr: failure_impact_type
      comment: "Type of business impact caused by the failure (e.g. Production Loss, Safety, Quality) — used to prioritise failure elimination by business consequence."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of maintenance response triggered by the failure — used to assess reactive vs proactive maintenance balance."
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the failure (e.g. from FMEA scale) — drives risk prioritisation and maintenance investment decisions."
    - name: "record_status"
      expr: record_status
      comment: "Current status of the failure record (e.g. Open, Closed, Under Review) — used to track investigation and resolution progress."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Boolean flag indicating whether a Corrective and Preventive Action is required — used to monitor CAPA compliance and quality management system adherence."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Boolean flag indicating whether the failure involved a safety incident — mandatory HSE KPI for board-level reporting."
    - name: "environmental_incident_flag"
      expr: environmental_incident_flag
      comment: "Boolean flag indicating environmental impact from the failure — required for environmental compliance and ESG reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which repair costs are denominated — required for multi-currency financial consolidation."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_datetime)
      comment: "Month bucket of the failure event — enables trend analysis of failure frequency and cost over time."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the failure occurred — enables plant-level reliability benchmarking and targeted improvement programmes."
  measures:
    - name: "total_failure_records"
      expr: COUNT(1)
      comment: "Total number of failure records — baseline failure frequency metric for reliability performance tracking and trend analysis."
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost AS DOUBLE))
      comment: "Total repair cost across all failure records — directly quantifies the financial cost of unreliability; key input for maintenance ROI and reliability investment decisions."
    - name: "avg_repair_cost_per_failure"
      expr: AVG(CAST(repair_cost AS DOUBLE))
      comment: "Average repair cost per failure event — enables benchmarking of failure cost by mode, class, and asset; drives targeted cost reduction programmes."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes attributed to failures — primary metric linking failure frequency to production availability loss."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average downtime duration per failure in minutes — proxy for MTTR at the failure record level; reductions indicate improved maintenance effectiveness."
    - name: "total_production_units_lost"
      expr: SUM(CAST(production_units_lost AS DOUBLE))
      comment: "Total production units lost due to failures — directly links asset reliability to production throughput and revenue impact for executive reporting."
    - name: "total_mtbf_contribution_hours"
      expr: SUM(CAST(mtbf_contribution_hours AS DOUBLE))
      comment: "Total MTBF contribution hours across all failure records — used to compute fleet-level MTBF for reliability engineering and maintenance strategy reviews."
    - name: "avg_asset_operating_hours_at_failure"
      expr: AVG(CAST(asset_operating_hours_at_failure AS DOUBLE))
      comment: "Average operating hours at time of failure — indicates typical asset life before failure; used to set preventive maintenance intervals and replacement schedules."
    - name: "capa_required_failure_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of failures requiring a Corrective and Preventive Action — monitors CAPA workload and quality management system compliance."
    - name: "safety_incident_failure_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of failures involving a safety incident — mandatory HSE KPI; zero-tolerance target drives safety-critical maintenance investment and process improvement."
    - name: "spare_part_consumed_failure_count"
      expr: COUNT(CASE WHEN spare_part_consumed_flag = TRUE THEN 1 END)
      comment: "Count of failures where spare parts were consumed — used to validate spare parts inventory strategy and reorder point adequacy."
    - name: "safety_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of failures that resulted in a safety incident — strategic HSE KPI for board and regulatory reporting; declining rate validates safety improvement programmes."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance programme KPIs covering schedule compliance, cost estimation, and safety-critical maintenance coverage. Enables maintenance managers and compliance officers to govern PM programme effectiveness and regulatory adherence."
  source: "`vibe_manufacturing_v1`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (e.g. Active, Inactive, Suspended) — primary filter for active programme coverage analysis."
    - name: "maintenance_type"
      expr: maintenance_type
      comment: "Type of preventive maintenance (e.g. Time-Based, Condition-Based, Meter-Based) — used to assess maintenance strategy mix and effectiveness."
    - name: "tpm_pillar"
      expr: tpm_pillar
      comment: "Total Productive Maintenance pillar associated with the schedule — supports TPM programme performance and maturity tracking."
    - name: "trigger_type"
      expr: trigger_type
      comment: "Trigger mechanism for the PM schedule (e.g. Calendar, Meter, Condition) — used to analyse maintenance strategy distribution across the asset fleet."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of the maintenance frequency (e.g. Days, Hours, Cycles) — used to segment schedules by maintenance interval type."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Boolean flag indicating whether the PM schedule is mandated by regulation — critical for compliance reporting and audit readiness."
    - name: "is_safety_critical"
      expr: is_safety_critical
      comment: "Boolean flag indicating whether the PM schedule covers safety-critical equipment — mandatory for HSE governance and regulatory compliance."
    - name: "shutdown_required"
      expr: shutdown_required
      comment: "Boolean flag indicating whether the PM requires a production shutdown — used for outage planning and production scheduling coordination."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which estimated costs are denominated — required for multi-currency financial consolidation."
    - name: "next_due_month"
      expr: DATE_TRUNC('MONTH', next_due_date)
      comment: "Month when the next PM is due — enables forward maintenance workload planning and resource scheduling."
    - name: "last_completion_month"
      expr: DATE_TRUNC('MONTH', last_completion_date)
      comment: "Month of the last PM completion — used to track PM execution cadence and identify overdue schedules."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules — baseline metric for preventive maintenance programme scope and coverage."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules — key input for annual maintenance budget planning and procurement forecasting."
    - name: "avg_estimated_material_cost"
      expr: AVG(CAST(estimated_material_cost AS DOUBLE))
      comment: "Average estimated material cost per PM schedule — used to benchmark PM cost levels across maintenance types and asset classes."
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated duration hours across all PM schedules — used for annual maintenance resource capacity planning and workforce scheduling."
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM schedule in hours — supports individual work order scheduling and crew size planning."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours from planned PM activities — used to quantify planned availability loss and coordinate with production scheduling."
    - name: "regulatory_required_pm_count"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END)
      comment: "Count of PM schedules mandated by regulation — monitors regulatory compliance coverage; gaps trigger immediate corrective action to avoid licence violations."
    - name: "safety_critical_pm_count"
      expr: COUNT(CASE WHEN is_safety_critical = TRUE THEN 1 END)
      comment: "Count of safety-critical PM schedules — mandatory HSE governance metric; ensures safety-critical maintenance is adequately resourced and executed on schedule."
    - name: "shutdown_required_pm_count"
      expr: COUNT(CASE WHEN shutdown_required = TRUE THEN 1 END)
      comment: "Count of PM schedules requiring a production shutdown — used to plan and minimise planned production outages in coordination with operations."
    - name: "avg_frequency_value"
      expr: AVG(CAST(frequency_value AS DOUBLE))
      comment: "Average maintenance frequency value across PM schedules — used to assess overall maintenance interval strategy and identify opportunities to extend intervals through reliability improvement."
    - name: "avg_condition_threshold_value"
      expr: AVG(CAST(condition_threshold_value AS DOUBLE))
      comment: "Average condition monitoring threshold value across condition-based PM schedules — used to calibrate condition-based maintenance trigger levels and optimise predictive maintenance programmes."
    - name: "regulatory_pm_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PM schedules that are regulatory-mandated — compliance coverage metric; used in regulatory audits and board-level compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_calibration_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instrument calibration quality and compliance KPIs. Enables quality managers and regulatory compliance officers to track calibration accuracy, out-of-tolerance rates, and certificate currency across the measurement equipment fleet."
  source: "`vibe_manufacturing_v1`.`asset`.`calibration_record`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of instrument being calibrated (e.g. Pressure Gauge, Thermocouple, Flow Meter) — primary dimension for calibration programme segmentation."
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Physical parameter being measured (e.g. Temperature, Pressure, Flow) — used to group calibration performance by measurement discipline."
    - name: "measurement_unit"
      expr: measurement_unit
      comment: "Unit of measurement for the calibrated parameter — used to ensure dimensional consistency in calibration accuracy analysis."
    - name: "external_lab_name"
      expr: external_lab_name
      comment: "Name of the external calibration laboratory — used to benchmark calibration quality and accreditation compliance across service providers."
    - name: "adjustment_made"
      expr: adjustment_made
      comment: "Boolean flag indicating whether an adjustment was made during calibration — high adjustment rates signal instrument drift and may trigger replacement decisions."
    - name: "out_of_service"
      expr: out_of_service
      comment: "Boolean flag indicating whether the instrument was taken out of service following calibration — used to track measurement equipment availability and compliance risk."
    - name: "capa_reference"
      expr: capa_reference
      comment: "Reference to a Corrective and Preventive Action raised following calibration — used to track quality non-conformance resolution."
    - name: "certificate_issue_month"
      expr: DATE_TRUNC('MONTH', certificate_issue_date)
      comment: "Month of calibration certificate issue — enables trend analysis of calibration activity volume and scheduling compliance."
  measures:
    - name: "total_calibration_records"
      expr: COUNT(1)
      comment: "Total number of calibration records — baseline metric for calibration programme activity volume and instrument fleet coverage."
    - name: "avg_as_found_error"
      expr: AVG(CAST(as_found_error AS DOUBLE))
      comment: "Average as-found measurement error across all calibrations — key quality metric; high values indicate systematic instrument drift requiring maintenance strategy review."
    - name: "avg_as_left_error"
      expr: AVG(CAST(as_left_error AS DOUBLE))
      comment: "Average as-left measurement error after calibration adjustment — measures calibration effectiveness; values approaching zero indicate high-quality calibration execution."
    - name: "avg_measurement_uncertainty"
      expr: AVG(CAST(measurement_uncertainty AS DOUBLE))
      comment: "Average measurement uncertainty across calibrated instruments — used to assess fitness-for-purpose of the measurement system and compliance with metrology standards."
    - name: "avg_calibration_interval_days"
      expr: AVG(CAST(calibration_interval_days AS DOUBLE))
      comment: "Average calibration interval in days across the instrument fleet — used to optimise calibration frequency, balancing compliance risk against calibration programme cost."
    - name: "adjustment_made_count"
      expr: COUNT(CASE WHEN adjustment_made = TRUE THEN 1 END)
      comment: "Count of calibrations where an adjustment was required — high counts indicate instrument fleet degradation and may trigger accelerated replacement or maintenance programmes."
    - name: "out_of_service_count"
      expr: COUNT(CASE WHEN out_of_service = TRUE THEN 1 END)
      comment: "Count of instruments taken out of service following calibration — measures calibration-driven equipment unavailability; high counts impact production measurement capability."
    - name: "adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_made = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calibrations requiring an adjustment — composite quality KPI; high rates signal systematic instrument drift and drive decisions on calibration interval reduction or fleet replacement."
    - name: "avg_tolerance_range"
      expr: AVG(CAST(tolerance_upper_limit AS DOUBLE) - CAST(tolerance_lower_limit AS DOUBLE))
      comment: "Average tolerance band width across calibrated instruments — used to assess measurement system capability and tighten quality control limits where required."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`asset_spare_part`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spare parts inventory strategy and cost KPIs. Enables supply chain managers and maintenance planners to optimise spare parts investment, reorder policies, and criticality-based stocking strategies."
  source: "`vibe_manufacturing_v1`.`asset`.`spare_part`"
  dimensions:
    - name: "criticality_class"
      expr: criticality_class
      comment: "Criticality classification of the spare part (e.g. Critical, Important, General) — primary dimension for risk-based inventory investment decisions."
    - name: "abc_class"
      expr: abc_class
      comment: "ABC classification of the spare part by consumption value (A=high value, C=low value) — used to differentiate inventory management policies by value tier."
    - name: "mro_category"
      expr: mro_category
      comment: "MRO category of the spare part (e.g. Mechanical, Electrical, Instrumentation) — used for category management and procurement strategy alignment."
    - name: "part_type"
      expr: part_type
      comment: "Type classification of the spare part (e.g. OEM, Generic, Consumable) — used to manage OEM vs alternative sourcing strategy decisions."
    - name: "part_status"
      expr: part_status
      comment: "Current status of the spare part (e.g. Active, Obsolete, Superseded) — used to manage fleet obsolescence and phase-out planning."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement strategy for the spare part (e.g. Stock, Non-Stock, Consignment) — used to optimise inventory holding vs on-demand procurement trade-offs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which part costs are denominated — required for multi-currency financial consolidation."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Boolean flag indicating whether the spare part is a hazardous material — required for HSE compliance, storage management, and regulatory reporting."
    - name: "capex_asset_flag"
      expr: capex_asset_flag
      comment: "Boolean flag indicating whether the spare part is classified as a capital asset — used for CAPEX vs OPEX financial classification and asset register management."
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group classification code — used for category-level spend analysis and procurement consolidation opportunities."
  measures:
    - name: "total_spare_parts"
      expr: COUNT(1)
      comment: "Total number of spare part records in the catalogue — baseline metric for spare parts portfolio size and management complexity."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost of the spare parts catalogue — measures total inventory investment value; key input for working capital management and inventory optimisation decisions."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per spare part — used to benchmark part cost levels across categories and identify high-value parts requiring tighter inventory control."
    - name: "total_safety_stock_value"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE) * CAST(standard_cost AS DOUBLE))
      comment: "Total value of safety stock holdings across all spare parts — measures the financial investment in buffer inventory; used to balance service level targets against working capital cost."
    - name: "avg_annual_consumption"
      expr: AVG(CAST(average_annual_consumption AS DOUBLE))
      comment: "Average annual consumption rate per spare part — used to validate reorder points and safety stock levels against actual demand patterns."
    - name: "total_reorder_point_value"
      expr: SUM(CAST(reorder_point AS DOUBLE) * CAST(standard_cost AS DOUBLE))
      comment: "Total value of inventory at reorder point thresholds — quantifies the minimum inventory investment required to maintain service levels; used in working capital planning."
    - name: "avg_last_purchase_price"
      expr: AVG(CAST(last_purchase_price AS DOUBLE))
      comment: "Average last purchase price across spare parts — used to track procurement cost trends and identify price variance against standard cost for supplier negotiation."
    - name: "critical_spare_count"
      expr: COUNT(CASE WHEN criticality_class = 'Critical' THEN 1 END)
      comment: "Count of spare parts classified as critical — used to size the critical spares programme and ensure adequate stocking of parts that could cause extended downtime if unavailable."
    - name: "obsolete_part_count"
      expr: COUNT(CASE WHEN part_status = 'Obsolete' THEN 1 END)
      comment: "Count of obsolete spare parts — measures catalogue hygiene and inventory write-off exposure; high counts trigger stock rationalisation and disposal programmes."
    - name: "price_variance_pct"
      expr: ROUND(100.0 * (AVG(CAST(last_purchase_price AS DOUBLE)) - AVG(CAST(standard_cost AS DOUBLE))) / NULLIF(AVG(CAST(standard_cost AS DOUBLE)), 0), 2)
      comment: "Percentage variance between average last purchase price and average standard cost — measures procurement cost performance against standard; negative values indicate favourable purchasing, positive values trigger supplier renegotiation."
$$;