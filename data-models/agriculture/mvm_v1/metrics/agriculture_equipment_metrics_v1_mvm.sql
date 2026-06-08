-- Metric views for domain: equipment | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the equipment asset master. Tracks fleet composition, financial value, utilization indicators, and lifecycle health to support capital planning, depreciation management, and fleet renewal decisions."
  source: "`agriculture_ecm`.`equipment`.`asset`"
  dimensions:
    - name: "asset_lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the asset (e.g., Active, Idle, Decommissioned) — used to segment fleet health and retirement pipeline."
    - name: "asset_operational_status"
      expr: operational_status
      comment: "Operational readiness status of the asset — key dimension for availability and downtime analysis."
    - name: "asset_fuel_type"
      expr: fuel_type
      comment: "Fuel type of the asset (e.g., Diesel, Electric, Hybrid) — supports sustainability and cost-of-operation segmentation."
    - name: "asset_ownership_type"
      expr: ownership_type
      comment: "Ownership classification (e.g., Owned, Leased, Rented) — critical for capital vs. operating expense analysis."
    - name: "asset_depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset — used for financial reporting and book value accuracy reviews."
    - name: "asset_make"
      expr: make
      comment: "Manufacturer/make of the asset — supports vendor performance and fleet standardization analysis."
    - name: "asset_model_year"
      expr: model_year
      comment: "Model year of the asset — used for fleet age analysis and renewal prioritization."
    - name: "asset_gps_rtk_enabled"
      expr: gps_rtk_enabled
      comment: "Indicates whether the asset has GPS/RTK precision guidance enabled — supports precision agriculture adoption tracking."
    - name: "asset_vra_controller_enabled"
      expr: vra_controller_enabled
      comment: "Indicates whether variable-rate application (VRA) controller is enabled — supports precision ag technology adoption KPIs."
    - name: "asset_acquisition_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of asset acquisition — used for cohort-based fleet age and capital spend trend analysis."
  measures:
    - name: "total_fleet_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Total number of distinct assets in the fleet — baseline fleet size KPI for capacity and capital planning."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital invested in the fleet at acquisition cost — key input for capital expenditure and ROI analysis."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current net book value of all assets — reflects remaining financial value of the fleet for balance sheet and impairment reviews."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value across the fleet — used in depreciation planning and end-of-life asset disposition decisions."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset — benchmarks capital intensity per unit for procurement and budgeting decisions."
    - name: "avg_current_book_value"
      expr: AVG(CAST(current_book_value AS DOUBLE))
      comment: "Average current book value per asset — indicates average remaining financial value across the fleet."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(acquisition_cost AS DOUBLE) - CAST(current_book_value AS DOUBLE))
      comment: "Total accumulated depreciation across the fleet (acquisition cost minus current book value) — measures how much capital value has been consumed."
    - name: "avg_engine_hours"
      expr: AVG(CAST(engine_hours AS DOUBLE))
      comment: "Average engine hours per asset — proxy for utilization intensity and maintenance scheduling urgency."
    - name: "total_engine_hours"
      expr: SUM(CAST(engine_hours AS DOUBLE))
      comment: "Total engine hours accumulated across the fleet — fleet-wide utilization indicator for maintenance planning."
    - name: "avg_odometer_km"
      expr: AVG(CAST(odometer_km AS DOUBLE))
      comment: "Average odometer reading in kilometers per asset — supports fleet age and wear assessment."
    - name: "avg_engine_power_kw"
      expr: AVG(CAST(engine_power_kw AS DOUBLE))
      comment: "Average engine power (kW) across the fleet — used for fleet capability and task-matching analysis."
    - name: "book_value_to_acquisition_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(current_book_value AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Ratio of total current book value to total acquisition cost (%) — measures remaining useful value of the fleet; declining ratio signals accelerating fleet aging and renewal need."
    - name: "precision_ag_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gps_rtk_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_id), 0), 2)
      comment: "Percentage of fleet assets with GPS/RTK precision guidance enabled — tracks precision agriculture technology adoption across the fleet."
    - name: "vra_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vra_controller_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_id), 0), 2)
      comment: "Percentage of fleet assets with VRA controller enabled — measures variable-rate application technology penetration for precision ag strategy."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPI layer over equipment work orders. Tracks maintenance cost, labor efficiency, downtime impact, and work order throughput to support maintenance strategy, budget control, and asset reliability decisions."
  source: "`agriculture_ecm`.`equipment`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: order_type
      comment: "Type of work order (e.g., Preventive, Corrective, Emergency) — primary dimension for maintenance strategy analysis."
    - name: "work_order_status"
      expr: order_status
      comment: "Current status of the work order (e.g., Open, In Progress, Completed, Cancelled) — used for backlog and throughput analysis."
    - name: "work_order_priority"
      expr: priority_code
      comment: "Priority classification of the work order — used to assess urgency distribution and resource allocation alignment."
    - name: "work_order_breakdown_indicator"
      expr: breakdown_indicator
      comment: "Flags whether the work order was triggered by an unplanned breakdown — key dimension for reactive vs. proactive maintenance ratio."
    - name: "work_order_safety_permit_required"
      expr: safety_permit_required
      comment: "Indicates whether a safety permit was required for the work order — supports safety compliance tracking."
    - name: "work_order_currency_code"
      expr: currency_code
      comment: "Currency in which work order costs are denominated — required for multi-currency financial reporting."
    - name: "work_order_planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned work order start — used for maintenance scheduling trend and seasonality analysis."
    - name: "work_order_actual_start_month"
      expr: DATE_TRUNC('MONTH', CAST(actual_start_timestamp AS DATE))
      comment: "Month of actual work order start — used to compare planned vs. actual maintenance execution timing."
  measures:
    - name: "total_work_orders"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Total number of work orders — baseline throughput KPI for maintenance operations capacity and backlog management."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost across all work orders — primary financial KPI for maintenance budget control and cost-of-ownership analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost incurred on work orders — supports workforce cost allocation and make-vs-buy maintenance decisions."
    - name: "total_external_service_cost"
      expr: SUM(CAST(external_service_cost AS DOUBLE))
      comment: "Total external/vendor service cost on work orders — tracks outsourced maintenance spend for vendor management and insourcing decisions."
    - name: "avg_maintenance_cost_per_work_order"
      expr: AVG(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Average total maintenance cost per work order — benchmarks cost efficiency of maintenance execution."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across work orders — measures workforce utilization in maintenance operations."
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across work orders — baseline for labor planning accuracy and capacity forecasting."
    - name: "labor_hours_variance"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE) - CAST(planned_labor_hours AS DOUBLE))
      comment: "Total variance between actual and planned labor hours — positive values indicate over-run; negative values indicate efficiency gains. Key input for maintenance planning accuracy improvement."
    - name: "labor_efficiency_ratio"
      expr: ROUND(100.0 * SUM(CAST(planned_labor_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_labor_hours AS DOUBLE)), 0), 2)
      comment: "Ratio of planned to actual labor hours (%) — values above 100% indicate under-run (efficient); below 100% indicate over-run. Drives maintenance planning and workforce sizing decisions."
    - name: "total_equipment_downtime_hours"
      expr: SUM(CAST(equipment_downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours attributed to work orders — directly measures operational impact of maintenance events on farm productivity."
    - name: "avg_equipment_downtime_hours"
      expr: AVG(CAST(equipment_downtime_hours AS DOUBLE))
      comment: "Average equipment downtime hours per work order — benchmarks the operational disruption per maintenance event."
    - name: "breakdown_work_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN breakdown_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT work_order_id), 0), 2)
      comment: "Percentage of work orders triggered by unplanned breakdowns — high values signal reactive maintenance culture and drive investment in preventive maintenance programs."
    - name: "external_service_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(external_service_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_maintenance_cost AS DOUBLE)), 0), 2)
      comment: "External service cost as a percentage of total maintenance cost — tracks outsourcing dependency and informs make-vs-buy maintenance strategy."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_fault`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability and risk KPI layer over equipment fault records. Tracks fault frequency, severity, financial impact, downtime, and warranty recovery to support asset reliability improvement, safety risk management, and maintenance prioritization."
  source: "`agriculture_ecm`.`equipment`.`fault`"
  dimensions:
    - name: "fault_category"
      expr: fault_category
      comment: "Category of the fault (e.g., Mechanical, Electrical, Hydraulic) — primary dimension for root cause and reliability trend analysis."
    - name: "fault_severity_level"
      expr: severity_level
      comment: "Severity classification of the fault — used to prioritize response and assess safety and operational risk."
    - name: "fault_status"
      expr: fault_status
      comment: "Current resolution status of the fault (e.g., Open, In Progress, Resolved) — used for backlog and mean-time-to-repair analysis."
    - name: "fault_detection_source"
      expr: detection_source
      comment: "Source that detected the fault (e.g., Telematics, Operator, Inspection) — supports detection effectiveness and proactive monitoring investment decisions."
    - name: "fault_equipment_type"
      expr: equipment_type
      comment: "Type of equipment on which the fault occurred — enables fault rate benchmarking by equipment class."
    - name: "fault_root_cause_code"
      expr: root_cause_code
      comment: "Root cause code of the fault — used for systemic failure pattern analysis and corrective action prioritization."
    - name: "fault_is_safety_critical"
      expr: is_safety_critical
      comment: "Flags whether the fault is safety-critical — essential dimension for safety compliance and risk management reporting."
    - name: "fault_is_warranty_claim"
      expr: is_warranty_claim
      comment: "Flags whether the fault is covered under warranty — used to track warranty recovery and vendor accountability."
    - name: "fault_detection_month"
      expr: DATE_TRUNC('MONTH', CAST(detection_timestamp AS DATE))
      comment: "Month of fault detection — used for fault frequency trend analysis and seasonal reliability patterns."
  measures:
    - name: "total_faults"
      expr: COUNT(DISTINCT fault_id)
      comment: "Total number of distinct fault events — baseline fleet reliability KPI; rising counts signal deteriorating asset health."
    - name: "total_safety_critical_faults"
      expr: SUM(CASE WHEN is_safety_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of safety-critical fault events — directly informs safety risk exposure and regulatory compliance posture."
    - name: "safety_critical_fault_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_safety_critical = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT fault_id), 0), 2)
      comment: "Percentage of faults classified as safety-critical — high values trigger immediate safety intervention and fleet grounding decisions."
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost_usd AS DOUBLE))
      comment: "Total actual repair cost across all faults (USD) — primary financial KPI for unplanned maintenance spend and cost-of-unreliability."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost_usd AS DOUBLE))
      comment: "Total estimated repair cost across all faults — used for maintenance budget forecasting and cost variance analysis."
    - name: "repair_cost_variance"
      expr: SUM(CAST(actual_repair_cost_usd AS DOUBLE) - CAST(estimated_repair_cost_usd AS DOUBLE))
      comment: "Total variance between actual and estimated repair costs — positive values indicate cost overruns; drives estimation accuracy improvement."
    - name: "avg_actual_repair_cost"
      expr: AVG(CAST(actual_repair_cost_usd AS DOUBLE))
      comment: "Average actual repair cost per fault event — benchmarks cost intensity of fault resolution for budget planning."
    - name: "total_yield_impact_bu"
      expr: SUM(CAST(yield_impact_bu AS DOUBLE))
      comment: "Total yield impact in bushels attributed to equipment faults — directly links equipment reliability to crop revenue outcomes."
    - name: "total_acres_lost"
      expr: SUM(CAST(acres_lost AS DOUBLE))
      comment: "Total acres lost due to equipment faults — measures operational land productivity impact of equipment failures."
    - name: "warranty_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_warranty_claim = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT fault_id), 0), 2)
      comment: "Percentage of faults covered by warranty claims — tracks warranty recovery effectiveness and vendor accountability."
    - name: "avg_engine_hours_at_fault"
      expr: AVG(CAST(engine_hours_at_fault AS DOUBLE))
      comment: "Average engine hours at time of fault occurrence — indicates mean time to failure in operational hours; key input for predictive maintenance interval setting."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_asset_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Utilization and efficiency KPI layer over equipment asset assignments. Tracks planned vs. actual utilization, area coverage, cost efficiency, and compliance to support fleet deployment optimization, operator management, and custom hire decisions."
  source: "`agriculture_ecm`.`equipment`.`asset_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the asset assignment (e.g., Planned, Active, Completed, Cancelled) — used for deployment pipeline and completion rate analysis."
    - name: "assignment_purpose"
      expr: assignment_purpose
      comment: "Purpose of the assignment (e.g., Planting, Harvesting, Spraying) — enables utilization analysis by operational activity type."
    - name: "assigned_to_entity_type"
      expr: assigned_to_entity_type
      comment: "Type of entity the asset is assigned to (e.g., Field, Crew, Farm Unit) — supports deployment pattern analysis."
    - name: "assignment_custom_hire_flag"
      expr: custom_hire_flag
      comment: "Flags whether the assignment involves custom hire (external contractor) — used to track outsourced vs. owned equipment utilization."
    - name: "assignment_precision_ag_hardware_flag"
      expr: precision_ag_hardware_flag
      comment: "Flags whether precision ag hardware was used in the assignment — tracks precision technology deployment rates."
    - name: "assignment_gap_compliance_flag"
      expr: gap_compliance_flag
      comment: "Flags whether the assignment met GAP (Good Agricultural Practice) compliance requirements — supports regulatory and certification reporting."
    - name: "assignment_currency_code"
      expr: currency_code
      comment: "Currency code for assignment cost reporting — required for multi-currency financial analysis."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of assignment start — used for seasonal utilization trend analysis and capacity planning."
  measures:
    - name: "total_assignments"
      expr: COUNT(DISTINCT asset_assignment_id)
      comment: "Total number of asset assignments — baseline fleet deployment activity KPI."
    - name: "total_actual_utilization_hours"
      expr: SUM(CAST(actual_utilization_hours AS DOUBLE))
      comment: "Total actual utilization hours across all assignments — primary fleet productivity KPI; directly measures how much productive work the fleet delivered."
    - name: "total_planned_utilization_hours"
      expr: SUM(CAST(planned_utilization_hours AS DOUBLE))
      comment: "Total planned utilization hours across all assignments — baseline for utilization planning accuracy and capacity forecasting."
    - name: "utilization_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_utilization_hours AS DOUBLE)) / NULLIF(SUM(CAST(planned_utilization_hours AS DOUBLE)), 0), 2)
      comment: "Actual utilization hours as a percentage of planned utilization hours — measures fleet deployment execution effectiveness; below 100% signals underutilization or scheduling failures."
    - name: "total_actual_area_hectares"
      expr: SUM(CAST(actual_area_hectares AS DOUBLE))
      comment: "Total actual area covered in hectares across all assignments — measures fleet land productivity output."
    - name: "total_planned_area_hectares"
      expr: SUM(CAST(planned_area_hectares AS DOUBLE))
      comment: "Total planned area in hectares across all assignments — baseline for area coverage planning accuracy."
    - name: "area_coverage_achievement_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_area_hectares AS DOUBLE)) / NULLIF(SUM(CAST(planned_area_hectares AS DOUBLE)), 0), 2)
      comment: "Actual area covered as a percentage of planned area (%) — measures field operation execution completeness; below 100% signals capacity or scheduling gaps."
    - name: "total_assignment_cost"
      expr: SUM(CAST(total_assignment_cost AS DOUBLE))
      comment: "Total cost across all asset assignments — primary financial KPI for equipment deployment cost management."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate charged or incurred per assignment — benchmarks equipment cost rates for custom hire pricing and budget setting."
    - name: "cost_per_actual_hectare"
      expr: ROUND(SUM(CAST(total_assignment_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_area_hectares AS DOUBLE)), 0), 2)
      comment: "Total assignment cost per actual hectare covered — measures equipment cost efficiency per unit of land worked; key input for crop enterprise budget validation."
    - name: "gap_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gap_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_assignment_id), 0), 2)
      comment: "Percentage of assignments meeting GAP compliance requirements — tracks regulatory compliance posture across field operations."
    - name: "custom_hire_assignment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN custom_hire_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_assignment_id), 0), 2)
      comment: "Percentage of assignments fulfilled via custom hire (external contractors) — informs make-vs-buy fleet strategy and outsourcing dependency."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_field_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency KPI layer over field operations. Tracks area coverage, equipment utilization, fuel consumption, input application accuracy, and compliance to support agronomic decision-making, cost control, and precision agriculture performance."
  source: "`agriculture_ecm`.`equipment`.`field_operation`"
  dimensions:
    - name: "field_operation_type"
      expr: operation_type
      comment: "Type of field operation (e.g., Planting, Spraying, Tillage, Harvesting) — primary dimension for operational activity analysis."
    - name: "field_operation_status"
      expr: operation_status
      comment: "Current status of the field operation (e.g., Planned, In Progress, Completed) — used for operational pipeline and completion rate tracking."
    - name: "field_operation_phi_compliant"
      expr: phi_compliant
      comment: "Flags whether the operation met Pre-Harvest Interval (PHI) compliance requirements — critical for food safety and regulatory reporting."
    - name: "field_operation_rei_compliant"
      expr: rei_compliant
      comment: "Flags whether the operation met Re-Entry Interval (REI) compliance requirements — critical for worker safety and regulatory compliance."
    - name: "field_operation_spray_window_compliant"
      expr: spray_window_compliant
      comment: "Flags whether spray operations were conducted within the approved spray window — supports environmental compliance and efficacy tracking."
    - name: "field_operation_application_rate_uom"
      expr: application_rate_uom
      comment: "Unit of measure for application rate — used to normalize input application analysis across different product types."
    - name: "field_operation_month"
      expr: DATE_TRUNC('MONTH', operation_date)
      comment: "Month of field operation — used for seasonal operational activity trend analysis and resource planning."
    - name: "field_operation_source_system"
      expr: source_system
      comment: "Source system that recorded the field operation (e.g., FMIS, Manual, Telematics) — used for data quality and system adoption analysis."
  measures:
    - name: "total_field_operations"
      expr: COUNT(DISTINCT field_operation_id)
      comment: "Total number of distinct field operations executed — baseline operational throughput KPI."
    - name: "total_area_covered_acres"
      expr: SUM(CAST(area_covered_acres AS DOUBLE))
      comment: "Total area covered in acres across all field operations — primary land productivity output KPI."
    - name: "total_target_area_acres"
      expr: SUM(CAST(target_area_acres AS DOUBLE))
      comment: "Total target area in acres planned for field operations — baseline for area coverage planning accuracy."
    - name: "area_coverage_completion_rate"
      expr: ROUND(100.0 * SUM(CAST(area_covered_acres AS DOUBLE)) / NULLIF(SUM(CAST(target_area_acres AS DOUBLE)), 0), 2)
      comment: "Actual area covered as a percentage of target area (%) — measures field operation execution completeness; below 100% signals capacity or weather-related gaps."
    - name: "total_equipment_hours_used"
      expr: SUM(CAST(equipment_hours_used AS DOUBLE))
      comment: "Total equipment hours consumed across field operations — measures fleet utilization intensity in productive field work."
    - name: "total_fuel_consumed_gal"
      expr: SUM(CAST(fuel_consumed_gal AS DOUBLE))
      comment: "Total fuel consumed in gallons across field operations — key input for fuel cost management, carbon footprint, and sustainability reporting."
    - name: "fuel_efficiency_gal_per_acre"
      expr: ROUND(SUM(CAST(fuel_consumed_gal AS DOUBLE)) / NULLIF(SUM(CAST(area_covered_acres AS DOUBLE)), 0), 4)
      comment: "Fuel consumed per acre covered (gallons/acre) — measures operational fuel efficiency; drives equipment selection and route optimization decisions."
    - name: "avg_pass_efficiency_pct"
      expr: AVG(CAST(pass_efficiency_pct AS DOUBLE))
      comment: "Average pass efficiency percentage across field operations — measures GPS-guided field coverage quality; low values indicate overlap waste and precision ag improvement opportunities."
    - name: "total_product_used"
      expr: SUM(CAST(total_product_used AS DOUBLE))
      comment: "Total input product used across field operations — measures input consumption volume for cost and agronomic compliance analysis."
    - name: "avg_application_rate"
      expr: AVG(CAST(application_rate AS DOUBLE))
      comment: "Average application rate per field operation — used to assess input application consistency and compliance with agronomic prescriptions."
    - name: "phi_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN phi_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT field_operation_id), 0), 2)
      comment: "Percentage of field operations meeting Pre-Harvest Interval compliance — critical food safety KPI; non-compliance triggers regulatory and market access risk."
    - name: "rei_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rei_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT field_operation_id), 0), 2)
      comment: "Percentage of field operations meeting Re-Entry Interval compliance — worker safety KPI; non-compliance triggers regulatory penalties and liability."
    - name: "avg_speed_mph"
      expr: AVG(CAST(speed_avg_mph AS DOUBLE))
      comment: "Average operating speed in mph across field operations — used to assess operational throughput and equipment performance benchmarking."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_asset_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and quality KPI layer over equipment asset inspections. Tracks inspection outcomes, deficiency rates, regulatory compliance, and corrective action requirements to support safety governance, regulatory reporting, and asset risk management."
  source: "`agriculture_ecm`.`equipment`.`asset_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection conducted (e.g., Regulatory, Preventive, Safety) — primary dimension for compliance and maintenance inspection analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Scheduled, Completed, Overdue) — used for inspection backlog and compliance gap analysis."
    - name: "inspection_overall_result"
      expr: overall_result
      comment: "Overall pass/fail result of the inspection — primary outcome dimension for fleet compliance health assessment."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used to conduct the inspection (e.g., Visual, Diagnostic, Third-Party) — used to assess inspection rigor and consistency."
    - name: "inspection_inspector_type"
      expr: inspector_type
      comment: "Type of inspector (e.g., Internal, External, Regulatory) — used to segment compliance results by inspection authority."
    - name: "inspection_corrective_action_required"
      expr: corrective_action_required
      comment: "Flags whether a corrective action was required following the inspection — key dimension for deficiency severity and follow-up tracking."
    - name: "inspection_critical_deficiency_flag"
      expr: critical_deficiency_flag
      comment: "Flags whether a critical deficiency was identified — used to prioritize safety-critical remediation actions."
    - name: "inspection_osha_compliance_verified"
      expr: osha_compliance_verified
      comment: "Flags whether OSHA compliance was verified during the inspection — supports regulatory compliance reporting."
    - name: "inspection_epa_compliance_verified"
      expr: epa_compliance_verified
      comment: "Flags whether EPA compliance was verified during the inspection — supports environmental regulatory reporting."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection — used for inspection frequency trend analysis and compliance calendar management."
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT asset_inspection_id)
      comment: "Total number of asset inspections conducted — baseline compliance activity KPI."
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_result = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_inspection_id), 0), 2)
      comment: "Percentage of inspections with a passing overall result — primary fleet compliance health KPI; declining rates signal systemic maintenance or safety issues."
    - name: "critical_deficiency_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_deficiency_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_inspection_id), 0), 2)
      comment: "Percentage of inspections identifying a critical deficiency — high values trigger immediate safety intervention and asset grounding decisions."
    - name: "corrective_action_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_inspection_id), 0), 2)
      comment: "Percentage of inspections requiring corrective action — measures the deficiency burden on maintenance operations and compliance remediation workload."
    - name: "asset_grounded_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN asset_grounded_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_inspection_id), 0), 2)
      comment: "Percentage of inspections resulting in asset grounding — directly measures fleet availability impact from safety and compliance failures."
    - name: "osha_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN osha_compliance_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_inspection_id), 0), 2)
      comment: "Percentage of inspections with OSHA compliance verified — tracks regulatory compliance posture for worker safety governance."
    - name: "epa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN epa_compliance_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_inspection_id), 0), 2)
      comment: "Percentage of inspections with EPA compliance verified — tracks environmental regulatory compliance posture."
    - name: "regulatory_certificate_issuance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_certificate_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT asset_inspection_id), 0), 2)
      comment: "Percentage of inspections resulting in regulatory certificate issuance — measures successful compliance certification rate for the fleet."
    - name: "avg_asset_hours_at_inspection"
      expr: AVG(CAST(asset_hours_at_inspection AS DOUBLE))
      comment: "Average engine hours on assets at time of inspection — used to assess whether inspection intervals are being maintained relative to usage."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_parts_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain and inventory KPI layer over equipment parts inventory. Tracks stock levels, inventory value, reorder health, and criticality coverage to support maintenance readiness, procurement decisions, and working capital optimization."
  source: "`agriculture_ecm`.`equipment`.`parts_inventory`"
  dimensions:
    - name: "parts_inventory_status"
      expr: inventory_status
      comment: "Current inventory status of the part (e.g., Active, Obsolete, On Order) — primary dimension for stock health analysis."
    - name: "parts_criticality_classification"
      expr: criticality_classification
      comment: "Criticality classification of the part (e.g., Critical, Non-Critical) — used to prioritize stock management and safety stock decisions."
    - name: "parts_abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value, B=medium, C=low) — used for inventory management prioritization and working capital optimization."
    - name: "parts_category"
      expr: part_category
      comment: "Category of the part (e.g., Engine, Hydraulic, Electrical) — used for category-level inventory analysis and procurement planning."
    - name: "parts_type"
      expr: part_type
      comment: "Type classification of the part — supports inventory segmentation for maintenance planning."
    - name: "parts_valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g., FIFO, LIFO, Average Cost) — required for financial reporting accuracy."
    - name: "parts_hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flags whether the part is a hazardous material — used for safety compliance and storage regulation tracking."
    - name: "parts_currency_code"
      expr: currency_code
      comment: "Currency in which part costs are denominated — required for multi-currency financial reporting."
  measures:
    - name: "total_distinct_parts"
      expr: COUNT(DISTINCT parts_inventory_id)
      comment: "Total number of distinct parts in inventory — measures parts catalog breadth and maintenance coverage."
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of parts inventory on hand — primary working capital KPI for inventory investment management."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per part — benchmarks parts pricing for procurement negotiation and cost control."
    - name: "total_stock_quantity"
      expr: SUM(CAST(stock_quantity AS DOUBLE))
      comment: "Total quantity of parts in stock — measures overall inventory volume for maintenance readiness assessment."
    - name: "below_reorder_point_count"
      expr: SUM(CASE WHEN CAST(stock_quantity AS DOUBLE) < CAST(reorder_point AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Number of parts with stock quantity below reorder point — directly measures procurement urgency and maintenance disruption risk from stockouts."
    - name: "below_safety_stock_count"
      expr: SUM(CASE WHEN CAST(stock_quantity AS DOUBLE) < CAST(safety_stock_quantity AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Number of parts with stock quantity below safety stock level — measures critical inventory risk exposure; high values signal imminent maintenance readiness failures."
    - name: "stockout_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(stock_quantity AS DOUBLE) < CAST(reorder_point AS DOUBLE) THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT parts_inventory_id), 0), 2)
      comment: "Percentage of parts below reorder point — measures overall inventory health and procurement responsiveness; high values risk maintenance delays."
    - name: "total_annual_consumption_quantity"
      expr: SUM(CAST(annual_consumption_quantity AS DOUBLE))
      comment: "Total annual consumption quantity across all parts — used for demand forecasting and reorder quantity optimization."
    - name: "avg_stock_coverage_ratio"
      expr: ROUND(AVG(CAST(stock_quantity AS DOUBLE) / NULLIF(CAST(reorder_quantity AS DOUBLE), 0)), 2)
      comment: "Average ratio of current stock quantity to reorder quantity — measures how many reorder cycles of stock are on hand; values below 1.0 indicate urgent replenishment need."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_telematics_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time and historical equipment telemetry KPI layer. Tracks fuel consumption, engine performance, application accuracy, and operational efficiency from telematics data to support predictive maintenance, fuel cost management, and precision agriculture optimization."
  source: "`agriculture_ecm`.`equipment`.`telematics_reading`"
  dimensions:
    - name: "telematics_operational_status"
      expr: operational_status
      comment: "Operational status of the asset at time of reading (e.g., Working, Idle, Transport) — used to segment productive vs. non-productive time analysis."
    - name: "telematics_reading_quality_flag"
      expr: reading_quality_flag
      comment: "Quality flag of the telematics reading (e.g., Good, Suspect, Invalid) — used to filter analysis to reliable data and assess telematics data quality."
    - name: "telematics_rtk_correction_status"
      expr: rtk_correction_status
      comment: "RTK GPS correction status at time of reading — used to assess precision guidance quality and its impact on application accuracy."
    - name: "telematics_dtc_severity"
      expr: dtc_severity
      comment: "Severity of any Diagnostic Trouble Code (DTC) active at time of reading — used for early fault detection and predictive maintenance analysis."
    - name: "telematics_pto_engaged"
      expr: pto_engaged
      comment: "Flags whether the Power Take-Off (PTO) was engaged at time of reading — used to identify implement-active working time vs. transport time."
    - name: "telematics_field_boundary_match"
      expr: field_boundary_match
      comment: "Flags whether the asset GPS position matched the assigned field boundary — used to detect off-field operations and GPS accuracy issues."
    - name: "telematics_reading_month"
      expr: DATE_TRUNC('MONTH', CAST(reading_timestamp AS DATE))
      comment: "Month of telematics reading — used for temporal trend analysis of equipment performance and fuel consumption."
    - name: "telematics_data_source"
      expr: data_source
      comment: "Source system of the telematics reading (e.g., JD Operations Center, CNH AFS, Generic CAN) — used for data quality and system coverage analysis."
  measures:
    - name: "total_telematics_readings"
      expr: COUNT(1)
      comment: "Total number of telematics readings — measures telematics data volume and device coverage for fleet monitoring completeness."
    - name: "avg_fuel_consumption_rate_lph"
      expr: AVG(CAST(fuel_consumption_rate_lph AS DOUBLE))
      comment: "Average fuel consumption rate in liters per hour — primary fuel efficiency KPI; drives fuel cost forecasting and equipment efficiency benchmarking."
    - name: "avg_fuel_level_pct"
      expr: AVG(CAST(fuel_level_pct AS DOUBLE))
      comment: "Average fuel level percentage across readings — used for fuel logistics planning and refueling schedule optimization."
    - name: "avg_engine_load_pct"
      expr: AVG(CAST(engine_load_pct AS DOUBLE))
      comment: "Average engine load percentage — measures how hard engines are working; consistently high values indicate overloading risk and accelerated wear."
    - name: "avg_ground_speed_kph"
      expr: AVG(CAST(ground_speed_kph AS DOUBLE))
      comment: "Average ground speed in km/h — used to assess operational throughput and compliance with agronomic speed prescriptions."
    - name: "application_rate_accuracy_pct"
      expr: ROUND(100.0 * AVG(CAST(application_rate_actual AS DOUBLE)) / NULLIF(AVG(CAST(application_rate_target AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to target application rate (%) — measures precision agriculture application accuracy; deviations from 100% indicate input waste or under-application risk."
    - name: "avg_coolant_temp_c"
      expr: AVG(CAST(coolant_temp_c AS DOUBLE))
      comment: "Average engine coolant temperature in Celsius — used for engine health monitoring; elevated averages signal cooling system issues and overheating risk."
    - name: "avg_implement_depth_cm"
      expr: AVG(CAST(implement_depth_cm AS DOUBLE))
      comment: "Average implement depth in centimeters — measures tillage and seeding depth consistency; deviations from target depth impact crop establishment and yield."
    - name: "dtc_fault_reading_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dtc_code IS NOT NULL AND dtc_code != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of telematics readings with an active Diagnostic Trouble Code — measures real-time fault prevalence across the fleet; rising rates trigger predictive maintenance interventions."
    - name: "avg_ndvi_reading"
      expr: AVG(CAST(ndvi_reading AS DOUBLE))
      comment: "Average NDVI (Normalized Difference Vegetation Index) reading from equipment sensors — links equipment field coverage to crop health monitoring for variable-rate application decisions."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_rental_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and portfolio KPI layer over equipment rental and lease agreements. Tracks agreement value, coverage, cost structure, and portfolio composition to support lease-vs-buy decisions, custom hire strategy, and equipment financing governance."
  source: "`agriculture_ecm`.`equipment`.`rental_lease`"
  dimensions:
    - name: "rental_lease_agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., Operating Lease, Finance Lease, Custom Hire, Rental) — primary dimension for portfolio composition and financial classification analysis."
    - name: "rental_lease_agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., Active, Expired, Terminated) — used for active portfolio management and renewal pipeline analysis."
    - name: "rental_lease_equipment_category"
      expr: equipment_category
      comment: "Category of equipment covered by the agreement — used to analyze rental/lease portfolio by equipment type."
    - name: "rental_lease_rate_structure"
      expr: rate_structure
      comment: "Rate structure of the agreement (e.g., Fixed, Per Acre, Per Hour) — used to analyze cost structure and pricing model distribution."
    - name: "rental_lease_payment_frequency"
      expr: payment_frequency
      comment: "Payment frequency of the agreement (e.g., Monthly, Quarterly, Annual) — used for cash flow planning and payment schedule management."
    - name: "rental_lease_purchase_option"
      expr: purchase_option
      comment: "Flags whether the agreement includes a purchase option — used to identify lease-to-own opportunities in the portfolio."
    - name: "rental_lease_renewal_option"
      expr: renewal_option
      comment: "Flags whether the agreement includes a renewal option — used for lease renewal pipeline and fleet continuity planning."
    - name: "rental_lease_currency_code"
      expr: currency_code
      comment: "Currency of the agreement — required for multi-currency financial reporting."
    - name: "rental_lease_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of agreement start — used for portfolio vintage analysis and seasonal equipment demand trends."
  measures:
    - name: "total_agreements"
      expr: COUNT(DISTINCT rental_lease_id)
      comment: "Total number of rental and lease agreements — baseline portfolio size KPI."
    - name: "total_agreement_value"
      expr: SUM(CAST(total_agreement_value AS DOUBLE))
      comment: "Total contracted value across all rental and lease agreements — primary financial commitment KPI for equipment financing portfolio management."
    - name: "avg_agreement_value"
      expr: AVG(CAST(total_agreement_value AS DOUBLE))
      comment: "Average agreement value per rental/lease contract — benchmarks deal size for negotiation and portfolio risk assessment."
    - name: "total_acreage_covered"
      expr: SUM(CAST(total_acreage_covered AS DOUBLE))
      comment: "Total acreage covered under rental and lease agreements — measures the land area serviced by externally sourced equipment."
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held across agreements — measures working capital tied up in rental/lease security obligations."
    - name: "total_early_termination_penalty_exposure"
      expr: SUM(CAST(early_termination_penalty AS DOUBLE))
      comment: "Total early termination penalty exposure across active agreements — measures financial risk of fleet restructuring or agreement cancellation."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average rate amount per agreement — benchmarks equipment rental/lease pricing for market comparison and negotiation."
    - name: "purchase_option_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN purchase_option = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT rental_lease_id), 0), 2)
      comment: "Percentage of agreements with a purchase option — measures lease-to-own opportunity pipeline in the equipment portfolio."
    - name: "total_purchase_option_value"
      expr: SUM(CAST(purchase_option_price AS DOUBLE))
      comment: "Total value of purchase options across agreements — measures potential capital commitment if all purchase options are exercised; informs capital planning."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`equipment_maintenance_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance governance KPI layer over maintenance plans. Tracks plan coverage, cost estimates, compliance requirements, and scheduling health to support maintenance strategy effectiveness, regulatory compliance, and budget planning."
  source: "`agriculture_ecm`.`equipment`.`maintenance_plan`"
  dimensions:
    - name: "maintenance_plan_status"
      expr: plan_status
      comment: "Current status of the maintenance plan (e.g., Active, Draft, Expired) — used to assess active maintenance coverage and plan lifecycle management."
    - name: "maintenance_plan_strategy_type"
      expr: strategy_type
      comment: "Maintenance strategy type (e.g., Preventive, Predictive, Condition-Based) — primary dimension for maintenance strategy mix analysis."
    - name: "maintenance_plan_season_type"
      expr: season_type
      comment: "Season type associated with the maintenance plan (e.g., Pre-Season, Post-Season, Year-Round) — used for seasonal maintenance scheduling analysis."
    - name: "maintenance_plan_seasonal_flag"
      expr: seasonal_flag
      comment: "Flags whether the maintenance plan is seasonal — used to segment year-round vs. seasonal maintenance coverage."
    - name: "maintenance_plan_osha_compliance_required"
      expr: osha_compliance_required
      comment: "Flags whether OSHA compliance is required for this maintenance plan — used for regulatory compliance coverage analysis."
    - name: "maintenance_plan_epa_compliance_required"
      expr: epa_compliance_required
      comment: "Flags whether EPA compliance is required for this maintenance plan — used for environmental regulatory coverage analysis."
    - name: "maintenance_plan_auto_wo_generation"
      expr: auto_wo_generation
      comment: "Flags whether work orders are automatically generated from this plan — measures automation adoption in maintenance scheduling."
    - name: "maintenance_plan_cycle_unit"
      expr: maintenance_cycle_unit
      comment: "Unit of the maintenance cycle (e.g., Days, Hours, Kilometers) — used to segment plans by trigger type for scheduling analysis."
  measures:
    - name: "total_maintenance_plans"
      expr: COUNT(DISTINCT maintenance_plan_id)
      comment: "Total number of maintenance plans — measures breadth of preventive maintenance program coverage."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated labor cost across all maintenance plans — primary input for maintenance labor budget planning."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours across all maintenance plans — used for maintenance workforce capacity planning."
    - name: "avg_maintenance_cycle_value"
      expr: AVG(CAST(maintenance_cycle_value AS DOUBLE))
      comment: "Average maintenance cycle interval value — benchmarks maintenance frequency across the plan portfolio for interval optimization."
    - name: "overdue_plan_count"
      expr: SUM(CASE WHEN next_due_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active maintenance plans with a next due date in the past — directly measures maintenance compliance backlog and asset reliability risk."
    - name: "overdue_plan_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN next_due_date < CURRENT_DATE() AND plan_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN plan_status = 'Active' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of active maintenance plans that are overdue — measures preventive maintenance compliance rate; high values signal deteriorating maintenance discipline and rising breakdown risk."
    - name: "auto_wo_generation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_wo_generation = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT maintenance_plan_id), 0), 2)
      comment: "Percentage of maintenance plans with automatic work order generation enabled — measures maintenance scheduling automation adoption."
    - name: "avg_estimated_labor_hours_per_plan"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per maintenance plan — benchmarks maintenance task complexity and resource requirements per plan."
$$;