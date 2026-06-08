-- Metric views for domain: asset | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`asset_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the asset registry — tracks portfolio size, capital value, condition health, and replacement liability across the water utility asset base."
  source: "`water_utilities_ecm`.`asset`.`registry`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High-level asset category (e.g., Pipe, Pump, Valve, Meter) used to segment portfolio analysis."
    - name: "asset_type"
      expr: asset_type
      comment: "Specific asset type within a category, enabling granular drill-down on portfolio composition."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the asset (e.g., Active, Inactive, Decommissioned) — critical for active fleet sizing."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Asset criticality tier (e.g., Critical, High, Medium, Low) used to prioritize capital investment and maintenance."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Latest condition grade assigned to the asset, used to identify assets approaching end-of-life."
    - name: "pressure_zone"
      expr: pressure_zone
      comment: "Hydraulic pressure zone where the asset resides — supports zone-level risk and investment planning."
    - name: "maintenance_strategy"
      expr: maintenance_strategy
      comment: "Maintenance strategy applied to the asset (e.g., Preventive, Corrective, Predictive) for strategy mix analysis."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Pipe material type (e.g., Cast Iron, PVC, Ductile Iron) — key dimension for lead service line and renewal planning."
    - name: "is_lead_service_line"
      expr: is_lead_service_line
      comment: "Flag indicating whether the asset is a lead service line, required for LCRR regulatory compliance tracking."
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the asset was installed — used for age cohort analysis and renewal wave planning."
    - name: "condition_assessment_year"
      expr: YEAR(condition_assessment_date)
      comment: "Year of the most recent condition assessment, used to identify assets with stale assessments."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of assets in the registry — baseline measure for portfolio sizing and trend tracking."
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all assets in USD — represents the historical capital investment in the asset base."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total current replacement cost of all assets in USD — key input for capital planning and insurance valuation."
    - name: "avg_replacement_cost_usd"
      expr: AVG(CAST(replacement_cost AS DOUBLE))
      comment: "Average replacement cost per asset — used to benchmark unit renewal costs across asset categories."
    - name: "avg_rated_capacity"
      expr: AVG(CAST(rated_capacity AS DOUBLE))
      comment: "Average rated capacity across assets in the selected segment — supports capacity adequacy analysis."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating (kW) of assets — used for energy consumption planning and efficiency benchmarking."
    - name: "total_power_rating_kw"
      expr: SUM(CAST(power_rating_kw AS DOUBLE))
      comment: "Total installed power capacity (kW) across the asset fleet — informs energy demand and sustainability targets."
    - name: "avg_diameter_mm"
      expr: AVG(CAST(diameter_mm AS DOUBLE))
      comment: "Average pipe diameter (mm) — used for hydraulic capacity and renewal sizing analysis."
    - name: "distinct_pressure_zones"
      expr: COUNT(DISTINCT pressure_zone)
      comment: "Number of distinct pressure zones represented in the asset segment — indicates geographic/hydraulic spread."
    - name: "lead_service_line_count"
      expr: COUNT(CASE WHEN is_lead_service_line = TRUE THEN 1 END)
      comment: "Count of confirmed lead service lines — critical LCRR compliance KPI tracked by regulators and executives."
    - name: "assets_past_warranty"
      expr: COUNT(CASE WHEN warranty_expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of assets whose warranty has expired — identifies exposure to uninsured repair costs."
    - name: "assets_decommissioned"
      expr: COUNT(CASE WHEN decommission_date IS NOT NULL THEN 1 END)
      comment: "Count of decommissioned assets — tracks retirement activity and portfolio shrinkage over time."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`asset_criticality_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset risk and criticality KPI layer — quantifies consequence of failure, likelihood of failure, financial exposure, and service disruption risk to support risk-based capital investment prioritization."
  source: "`water_utilities_ecm`.`asset`.`criticality_rating`"
  dimensions:
    - name: "criticality_tier"
      expr: criticality_tier
      comment: "Criticality tier assigned to the asset (e.g., Tier 1 Critical, Tier 2 High, Tier 3 Medium) — primary risk segmentation dimension."
    - name: "rating_status"
      expr: rating_status
      comment: "Current status of the criticality rating (e.g., Active, Expired, Under Review) — used to ensure rating currency."
    - name: "cip_eligibility_flag"
      expr: cip_eligibility_flag
      comment: "Indicates whether the asset is eligible for Capital Improvement Program (CIP) funding — links risk to capital planning."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether failure would cause environmental impact — used for environmental risk portfolio analysis."
    - name: "public_health_impact_flag"
      expr: public_health_impact_flag
      comment: "Indicates whether failure would impact public health — highest-priority risk dimension for water utilities."
    - name: "safety_impact_flag"
      expr: safety_impact_flag
      comment: "Indicates whether failure would create a safety hazard — used for safety risk prioritization."
    - name: "regulatory_consequence_flag"
      expr: regulatory_consequence_flag
      comment: "Indicates whether failure would trigger regulatory consequences — used to track regulatory risk exposure."
    - name: "redundancy_available_flag"
      expr: redundancy_available_flag
      comment: "Indicates whether redundant infrastructure exists — used to adjust risk scores and prioritize single-point-of-failure assets."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the criticality assessment was performed — used for annual refresh tracking and rating currency analysis."
    - name: "capital_renewal_priority_rank"
      expr: capital_renewal_priority_rank
      comment: "Capital renewal priority rank assigned to the asset — used to sequence CIP project investment decisions."
  measures:
    - name: "total_rated_assets"
      expr: COUNT(1)
      comment: "Total number of assets with a criticality rating — measures coverage of the risk assessment program."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across rated assets — executive KPI for portfolio-level risk posture."
    - name: "avg_consequence_of_failure_score"
      expr: AVG(CAST(consequence_of_failure_score AS DOUBLE))
      comment: "Average consequence of failure score — measures the potential impact severity across the asset portfolio."
    - name: "avg_likelihood_of_failure_score"
      expr: AVG(CAST(likelihood_of_failure_score AS DOUBLE))
      comment: "Average likelihood of failure score — measures the probability of failure across the asset portfolio."
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of failure across all rated assets — quantifies the financial risk liability."
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average estimated financial impact per asset failure — used to prioritize high-consequence assets for investment."
    - name: "total_service_disruption_hours"
      expr: SUM(CAST(service_disruption_duration_hours AS DOUBLE))
      comment: "Total estimated service disruption hours if all rated assets failed — quantifies customer impact exposure."
    - name: "avg_service_disruption_hours"
      expr: AVG(CAST(service_disruption_duration_hours AS DOUBLE))
      comment: "Average estimated service disruption duration per asset — used to prioritize assets by customer impact."
    - name: "public_health_risk_assets"
      expr: COUNT(CASE WHEN public_health_impact_flag = TRUE THEN 1 END)
      comment: "Count of assets whose failure would impact public health — highest-priority risk cohort for water utilities."
    - name: "no_redundancy_critical_assets"
      expr: COUNT(CASE WHEN redundancy_available_flag = FALSE AND criticality_tier = 'Critical' THEN 1 END)
      comment: "Count of critical assets with no redundancy — identifies single-points-of-failure requiring urgent investment."
    - name: "cip_eligible_assets"
      expr: COUNT(CASE WHEN cip_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of assets eligible for CIP funding — quantifies the capital program pipeline driven by risk assessments."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance program KPI layer — tracks PM schedule coverage, cost estimates, compliance alignment, and schedule health to optimize the preventive maintenance strategy."
  source: "`water_utilities_ecm`.`asset`.`pm_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule (e.g., Active, Inactive, Suspended) — used to assess active PM program coverage."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order generated by the PM schedule (e.g., Preventive, Inspection, Lubrication) — used for PM type mix analysis."
    - name: "trigger_type"
      expr: trigger_type
      comment: "PM trigger type (e.g., Calendar, Meter-Based, Condition-Based) — used to analyze PM strategy sophistication."
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of PM frequency (e.g., Days, Weeks, Months) — used to segment schedules by maintenance cadence."
    - name: "asset_criticality_rating"
      expr: asset_criticality_rating
      comment: "Criticality rating of the asset covered by the PM schedule — used to ensure PM coverage aligns with asset risk."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the PM schedule is tied to a regulatory compliance requirement — tracks compliance-driven PM burden."
    - name: "seasonal_schedule_flag"
      expr: seasonal_schedule_flag
      comment: "Indicates whether the PM schedule is seasonal — used for seasonal workload planning."
    - name: "auto_generate_work_order_flag"
      expr: auto_generate_work_order_flag
      comment: "Indicates whether work orders are auto-generated from this schedule — measures automation coverage of PM program."
    - name: "downtime_required_flag"
      expr: downtime_required_flag
      comment: "Indicates whether the PM task requires asset downtime — used to plan maintenance windows and minimize service disruption."
    - name: "priority"
      expr: priority
      comment: "Priority level of the PM schedule — used to sequence maintenance execution under resource constraints."
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of PM schedules defined — baseline measure for PM program scope and coverage."
    - name: "total_estimated_labor_cost_usd"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Total estimated annual labor cost across all PM schedules — key input for maintenance budget planning."
    - name: "total_estimated_material_cost_usd"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all PM schedules — used for supply chain and procurement planning."
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours across all PM schedules — used for workforce capacity planning."
    - name: "avg_estimated_labor_hours"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per PM schedule — benchmarks task complexity and crew sizing requirements."
    - name: "total_estimated_downtime_hours"
      expr: SUM(CAST(estimated_downtime_hours AS DOUBLE))
      comment: "Total estimated downtime hours from PM activities — used to plan maintenance windows and minimize service disruption."
    - name: "regulatory_pm_schedules"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of PM schedules tied to regulatory requirements — tracks compliance-driven maintenance obligations."
    - name: "auto_generated_pm_schedules"
      expr: COUNT(CASE WHEN auto_generate_work_order_flag = TRUE THEN 1 END)
      comment: "Count of PM schedules with automatic work order generation — measures PM automation maturity."
    - name: "overdue_pm_schedules"
      expr: COUNT(CASE WHEN next_due_date < CURRENT_DATE() AND schedule_status = 'Active' THEN 1 END)
      comment: "Count of active PM schedules past their next due date — critical KPI for PM compliance and backlog management."
    - name: "distinct_assets_with_pm"
      expr: COUNT(DISTINCT registry_id)
      comment: "Number of distinct assets covered by at least one PM schedule — measures PM program asset coverage."
$$;