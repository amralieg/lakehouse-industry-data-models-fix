-- Metric views for domain: asset | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the asset registry — covers asset portfolio value, replacement exposure, condition health, and lifecycle status for capital planning and risk management decisions."
  source: "`vibe_water_utilities_v1`.`asset`.`registry`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High-level asset category (e.g., Pipe, Pump, Meter) used to segment portfolio analysis."
    - name: "asset_type"
      expr: asset_type
      comment: "Specific asset type within a category, enabling granular capital planning segmentation."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Asset criticality tier (e.g., High, Medium, Low) for risk-weighted investment prioritization."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Current condition grade of the asset (e.g., A–F or 1–5 scale) for rehabilitation prioritization."
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Hydraulic pressure zone where the asset resides, supporting zone-level infrastructure analysis."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material composition of pipe assets (e.g., Cast Iron, PVC, Ductile Iron) for material risk analysis."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Asset manufacturer for vendor performance and warranty tracking."
    - name: "is_lead_service_line"
      expr: is_lead_service_line
      comment: "Flag indicating whether the asset is a lead service line, critical for LCRR regulatory compliance tracking."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the asset was installed, used for age-cohort analysis and renewal forecasting."
    - name: "condition_assessment_year"
      expr: YEAR(condition_assessment_date)
      comment: "Year of the most recent condition assessment, used to identify assets with stale assessments."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of registered assets in the portfolio. Baseline KPI for portfolio size tracking."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of all registered assets. Represents the gross book value of the asset portfolio for capital accounting."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total current replacement cost of all registered assets. Key input for capital improvement planning and insurance valuation."
    - name: "avg_replacement_cost_per_asset"
      expr: AVG(CAST(replacement_cost AS DOUBLE))
      comment: "Average replacement cost per asset. Used to benchmark asset renewal unit costs across categories and pressure zones."
    - name: "total_rated_capacity"
      expr: SUM(CAST(rated_capacity AS DOUBLE))
      comment: "Total rated operational capacity across assets. Supports capacity planning and system adequacy assessments."
    - name: "avg_diameter_mm"
      expr: AVG(CAST(diameter_mm AS DOUBLE))
      comment: "Average pipe diameter in millimeters. Used for hydraulic modeling and infrastructure sizing analysis."
    - name: "lead_service_line_count"
      expr: COUNT(CASE WHEN is_lead_service_line = TRUE THEN 1 END)
      comment: "Count of assets identified as lead service lines. Critical regulatory KPI for LCRR compliance and public health risk management."
    - name: "avg_asset_age_years"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), installation_date) AS DOUBLE) / 365.25)
      comment: "Average age of assets in years since installation. Core lifecycle metric for renewal prioritization and capital forecasting."
    - name: "assets_past_useful_life"
      expr: COUNT(CASE WHEN DATEDIFF(CURRENT_DATE(), installation_date) / 365.25 > CAST(expected_useful_life_years AS DOUBLE) THEN 1 END)
      comment: "Number of assets that have exceeded their expected useful life. Drives urgent renewal and risk mitigation investment decisions."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power rating in kilowatts across electro-mechanical assets. Supports energy management and operational cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for work order execution — covers cost performance, labor efficiency, schedule adherence, and compliance for maintenance and capital work management."
  source: "`vibe_water_utilities_v1`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g., Preventive, Corrective, Emergency, Capital) for maintenance strategy analysis."
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g., Open, In Progress, Closed) for backlog and throughput tracking."
    - name: "priority"
      expr: priority
      comment: "Work order priority level (e.g., Emergency, High, Medium, Low) for resource allocation decisions."
    - name: "assigned_to"
      expr: assigned_to
      comment: "Technician or crew assigned to the work order, enabling individual and team productivity analysis."
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code associated with the work order, used for failure pattern analysis and preventive strategy refinement."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the work order is tied to a regulatory compliance requirement, critical for audit and reporting."
    - name: "warranty_claim"
      expr: warranty_claim
      comment: "Flag indicating whether a warranty claim was filed, used to track warranty recovery value."
    - name: "reported_year"
      expr: YEAR(reported_date)
      comment: "Year the work order was reported, used for annual trend and budget variance analysis."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the work order was reported, used for monthly operational performance tracking."
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the work order was scheduled to start, used for planning adherence analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders. Baseline volume KPI for maintenance workload and capacity planning."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all work orders. Primary maintenance expenditure KPI for budget management and cost control."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all work orders. Used as the budget baseline for cost variance analysis."
    - name: "avg_actual_cost_per_work_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per work order. Benchmarks unit maintenance cost efficiency across work types and crews."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours expended. Core workforce productivity and capacity utilization KPI."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours planned. Used as the labor budget baseline for variance analysis."
    - name: "avg_downtime_duration_hours"
      expr: AVG(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Average asset downtime per work order in hours. Directly measures service reliability impact of maintenance activities."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours across all work orders. Aggregate service disruption KPI for reliability and customer impact reporting."
    - name: "warranty_claim_work_orders"
      expr: COUNT(CASE WHEN warranty_claim = TRUE THEN 1 END)
      comment: "Number of work orders with an active warranty claim. Tracks warranty recovery opportunities and vendor accountability."
    - name: "regulatory_compliance_work_orders"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of work orders tied to regulatory compliance requirements. Critical for compliance program completeness reporting."
    - name: "emergency_work_orders"
      expr: COUNT(CASE WHEN work_order_type = 'Emergency' THEN 1 END)
      comment: "Count of emergency work orders. High emergency rates signal reactive maintenance posture and elevated operational risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_condition_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset health and risk KPIs derived from condition assessments — supports rehabilitation prioritization, risk-based asset management, and regulatory compliance for infrastructure renewal programs."
  source: "`vibe_water_utilities_v1`.`asset`.`condition_assessment`"
  dimensions:
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade assigned during assessment (e.g., 1–5 or A–F scale) for portfolio health segmentation."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of condition assessment performed (e.g., Visual, CCTV, Acoustic) for method effectiveness analysis."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Specific inspection method used, enabling comparison of assessment quality and cost across techniques."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment record (e.g., Pending, Completed, Reviewed) for workflow management."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended remediation action (e.g., Repair, Replace, Monitor) for capital program planning."
    - name: "recommended_action_priority"
      expr: recommended_action_priority
      comment: "Priority level of the recommended action, used to triage rehabilitation investments."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the assessed asset, enabling risk-weighted condition analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the assessment satisfies a regulatory compliance requirement."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the condition assessment was performed, used for annual inspection program tracking."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of assessment for seasonal inspection pattern analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of condition assessments performed. Baseline KPI for inspection program throughput."
    - name: "avg_condition_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across assessed assets. Portfolio-level health index for executive reporting and trend monitoring."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across assessed assets. Drives risk-based maintenance prioritization and capital investment decisions."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years across assessed assets. Core input for long-range capital renewal forecasting."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost across all assessed assets. Quantifies the near-term rehabilitation investment requirement."
    - name: "total_estimated_replacement_cost"
      expr: SUM(CAST(estimated_replacement_cost AS DOUBLE))
      comment: "Total estimated replacement cost across all assessed assets. Represents the maximum capital exposure for full asset renewal."
    - name: "avg_structural_integrity_score"
      expr: AVG(CAST(structural_integrity_score AS DOUBLE))
      comment: "Average structural integrity score across assessments. Indicates physical safety and failure risk of the infrastructure portfolio."
    - name: "avg_failure_probability"
      expr: AVG(CAST(failure_probability AS DOUBLE))
      comment: "Average probability of failure across assessed assets. Key risk metric for prioritizing proactive intervention before service disruption."
    - name: "assets_with_critical_defects"
      expr: COUNT(CASE WHEN recommended_action_priority = 'Critical' THEN 1 END)
      comment: "Number of assets assessed with critical-priority recommended actions. Drives urgent capital program mobilization."
    - name: "regulatory_compliant_assessments"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of assessments that satisfy regulatory compliance requirements. Tracks inspection program compliance rate for regulatory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_failure_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset reliability and failure impact KPIs — measures failure frequency, downtime, cost, and regulatory exposure to drive reliability-centered maintenance and risk mitigation strategies."
  source: "`vibe_water_utilities_v1`.`asset`.`failure_record`"
  dimensions:
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode classification (e.g., Corrosion, Mechanical, Electrical) for root cause pattern analysis."
    - name: "failure_cause"
      expr: failure_cause
      comment: "Root cause of the failure, used to identify systemic issues and inform preventive maintenance strategies."
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity classification of the failure (e.g., Minor, Major, Critical) for risk prioritization."
    - name: "failure_status"
      expr: failure_status
      comment: "Current resolution status of the failure record (e.g., Open, Resolved) for backlog management."
    - name: "affected_system"
      expr: affected_system
      comment: "Water system component affected by the failure (e.g., Distribution, Treatment, Transmission) for system-level reliability analysis."
    - name: "service_interruption_flag"
      expr: service_interruption_flag
      comment: "Indicates whether the failure caused a customer service interruption, linking asset reliability to customer experience."
    - name: "regulatory_notification_required_flag"
      expr: regulatory_notification_required_flag
      comment: "Indicates whether the failure triggered a regulatory notification requirement, critical for compliance risk tracking."
    - name: "cso_event_flag"
      expr: cso_event_flag
      comment: "Indicates whether the failure resulted in a Combined Sewer Overflow event, a key environmental compliance indicator."
    - name: "sso_event_flag"
      expr: sso_event_flag
      comment: "Indicates whether the failure resulted in a Sanitary Sewer Overflow event, a key environmental and regulatory indicator."
    - name: "failure_year"
      expr: YEAR(failure_date)
      comment: "Year the failure occurred, used for annual reliability trend analysis and MTBF benchmarking."
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_date)
      comment: "Month of failure occurrence for seasonal failure pattern analysis."
  measures:
    - name: "total_failures"
      expr: COUNT(1)
      comment: "Total number of recorded asset failures. Baseline reliability KPI for trend monitoring and MTBF calculation inputs."
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual cost to repair failed assets. Primary unplanned maintenance expenditure KPI for budget impact assessment."
    - name: "avg_actual_repair_cost"
      expr: AVG(CAST(actual_repair_cost AS DOUBLE))
      comment: "Average repair cost per failure event. Benchmarks unit failure cost across asset types and failure modes."
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_duration_hours AS DOUBLE))
      comment: "Total asset downtime hours resulting from failures. Aggregate service reliability impact KPI for executive reporting."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time to Repair in hours. Core reliability engineering KPI measuring maintenance responsiveness and crew efficiency."
    - name: "total_production_loss_mgd"
      expr: SUM(CAST(production_loss_mgd AS DOUBLE))
      comment: "Total production loss in million gallons per day attributable to failures. Directly quantifies operational capacity impact of asset failures."
    - name: "total_overflow_volume_gallons"
      expr: SUM(CAST(overflow_volume_gallons AS DOUBLE))
      comment: "Total overflow volume in gallons from CSO/SSO events. Critical environmental compliance and regulatory reporting KPI."
    - name: "service_interruption_failures"
      expr: COUNT(CASE WHEN service_interruption_flag = TRUE THEN 1 END)
      comment: "Number of failures that caused customer service interruptions. Directly links asset reliability to customer satisfaction and regulatory compliance."
    - name: "regulatory_notification_failures"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of failures requiring regulatory notification. Tracks regulatory exposure and compliance risk from asset failures."
    - name: "root_cause_analysis_completed"
      expr: COUNT(CASE WHEN root_cause_analysis_completed_flag = TRUE THEN 1 END)
      comment: "Number of failures where root cause analysis was completed. Measures quality of failure investigation program and continuous improvement maturity."
    - name: "avg_pressure_drop_psi"
      expr: AVG(CAST(pressure_drop_psi AS DOUBLE))
      comment: "Average pressure drop in PSI associated with failure events. Hydraulic impact indicator used for system performance and loss analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance program KPIs — measures PM schedule coverage, cost planning, compliance, and labor resource requirements to optimize maintenance strategy and regulatory adherence."
  source: "`vibe_water_utilities_v1`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the PM schedule (e.g., Active, Inactive, Suspended) for program coverage analysis."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order generated by the PM schedule (e.g., Preventive, Inspection) for maintenance strategy segmentation."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of PM frequency (e.g., Days, Months, Hours) for schedule cadence analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "PM trigger type (e.g., Calendar, Meter, Condition-Based) for maintenance strategy maturity assessment."
    - name: "asset_criticality_rating"
      expr: asset_criticality_rating
      comment: "Criticality rating of the asset covered by the PM schedule, enabling risk-weighted PM investment analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the PM schedule is required for regulatory compliance, critical for compliance program completeness."
    - name: "seasonal_schedule_flag"
      expr: seasonal_schedule_flag
      comment: "Indicates whether the PM schedule is seasonal, used for resource planning and scheduling optimization."
    - name: "downtime_required_flag"
      expr: downtime_required_flag
      comment: "Indicates whether the PM task requires asset downtime, used for outage planning and customer impact minimization."
    - name: "next_due_year"
      expr: YEAR(next_due_date)
      comment: "Year the next PM is due, used for forward-looking workload and budget planning."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the PM schedule became effective, used for program age and coverage trend analysis."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of active PM schedules. Baseline KPI for preventive maintenance program coverage and scope."
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated annual labor cost across all PM schedules. Core input for maintenance budget planning and workforce sizing."
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules. Drives procurement planning and spare parts inventory investment decisions."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours required across all PM schedules. Workforce capacity planning KPI for maintenance resource management."
    - name: "avg_estimated_downtime_hours"
      expr: AVG(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Average estimated downtime per PM task. Used to minimize service disruption through optimized maintenance scheduling."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours across all PM schedules. Aggregate planned outage exposure KPI for service reliability planning."
    - name: "regulatory_compliance_schedules"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of PM schedules tied to regulatory compliance requirements. Tracks mandatory maintenance program completeness for regulatory audits."
    - name: "auto_generate_work_order_schedules"
      expr: COUNT(CASE WHEN auto_generate_work_order_flag = TRUE THEN 1 END)
      comment: "Number of PM schedules configured for automatic work order generation. Measures maintenance automation maturity and reduces manual scheduling overhead."
    - name: "avg_meter_threshold"
      expr: AVG(CAST(meter_threshold AS DOUBLE))
      comment: "Average meter-based trigger threshold across condition-based PM schedules. Supports optimization of condition-based maintenance trigger points."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`asset_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital acquisition KPIs — tracks asset procurement spend, capitalization, warranty coverage, and funding sources to support capital program governance and financial reporting."
  source: "`vibe_water_utilities_v1`.`asset`.`acquisition`"
  dimensions:
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (e.g., Purchase, Construction, Donation, Transfer) for capital program categorization."
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition (e.g., Pending, Approved, Commissioned) for capital project pipeline tracking."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category of the acquired asset for capital spend analysis by infrastructure type."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the acquisition (e.g., Rate Revenue, Grant, Bond) for capital financing analysis."
    - name: "grant_program_name"
      expr: grant_program_name
      comment: "Name of the grant program funding the acquisition, used for grant utilization and compliance reporting."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the acquired asset (e.g., Straight-Line, MACRS) for financial reporting segmentation."
    - name: "capitalization_threshold_met_flag"
      expr: capitalization_threshold_met_flag
      comment: "Indicates whether the acquisition cost met the capitalization threshold, distinguishing capital from expense items."
    - name: "initial_condition_grade"
      expr: initial_condition_grade
      comment: "Condition grade of the asset at acquisition, used to assess procurement quality and vendor performance."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition for annual capital spend trend analysis and CIP program tracking."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the acquired asset was commissioned into service, used for capital activation lag analysis."
  measures:
    - name: "total_acquisitions"
      expr: COUNT(1)
      comment: "Total number of asset acquisitions. Baseline KPI for capital program activity volume."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total capital expenditure across all acquisitions. Primary CIP spend KPI for capital budget management and rate case support."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per acquisition. Benchmarks unit capital cost across asset categories and funding sources."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value across acquired assets. Input for net book value calculations and depreciation schedule planning."
    - name: "total_capitalized_acquisitions"
      expr: COUNT(CASE WHEN capitalization_threshold_met_flag = TRUE THEN 1 END)
      comment: "Number of acquisitions that met the capitalization threshold. Tracks capital vs. expense classification for financial reporting accuracy."
    - name: "avg_warranty_duration_months"
      expr: AVG(CAST(warranty_duration_months AS DOUBLE))
      comment: "Average warranty duration in months across acquired assets. Measures warranty coverage quality and vendor contract performance."
    - name: "total_capitalization_threshold_amount"
      expr: SUM(CAST(capitalization_threshold_amount AS DOUBLE))
      comment: "Sum of capitalization threshold amounts across acquisitions. Used for financial policy compliance and audit verification."
    - name: "grant_funded_acquisitions"
      expr: COUNT(CASE WHEN grant_program_name IS NOT NULL AND grant_program_name <> '' THEN 1 END)
      comment: "Number of acquisitions funded through grant programs. Tracks grant utilization effectiveness and external funding leverage for capital programs."
$$;