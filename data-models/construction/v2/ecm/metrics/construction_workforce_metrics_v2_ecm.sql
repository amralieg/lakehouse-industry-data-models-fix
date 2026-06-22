-- Metric views for domain: workforce | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor cost and hours KPIs at the timesheet line level — the most granular fact for workforce cost control, productivity analysis, and payroll validation across projects, WBS elements, and cost codes."
  source: "`vibe_construction_v1`.`workforce`.`timesheet_line`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date the work was performed — enables daily, weekly, and monthly labor trend analysis."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft trade code on the line — supports labor mix and trade-level cost breakdown."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift identifier — allows comparison of productivity and cost across day, night, and weekend shifts."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the timesheet line — critical for identifying unapproved labor costs before payroll close."
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the labor hours are billable to the client — drives revenue recognition and billing accuracy."
    - name: "is_rework"
      expr: is_rework
      comment: "Flag indicating rework hours — key quality and cost-of-poor-quality indicator."
    - name: "union_local_code"
      expr: union_local_code
      comment: "Union local associated with the line — supports union labor compliance and cost reporting."
    - name: "work_location_code"
      expr: work_location_code
      comment: "Physical work location code — enables site-level labor cost and hours analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition recorded on the line — supports analysis of weather-related productivity impacts."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours worked — baseline measure for workforce utilization and schedule adherence."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours — high overtime signals schedule pressure, cost overrun risk, and potential safety concerns."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours — premium labor cost indicator used to assess weekend and holiday work exposure."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours across all pay types — primary workforce volume metric for project labor tracking."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost charged on timesheet lines — core financial KPI for job cost control and budget variance."
    - name: "avg_labor_cost_per_hour"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per timesheet line — proxy for blended labor rate; deviations signal rate or mix issues."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total units of work produced — numerator for productivity rate calculations and earned-value analysis."
    - name: "total_rework_hours"
      expr: SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END)
      comment: "Hours spent on rework — direct measure of quality failure cost; high values trigger quality intervention."
    - name: "total_billable_hours"
      expr: SUM(CASE WHEN is_billable = TRUE THEN total_hours ELSE 0 END)
      comment: "Billable hours — drives revenue recognition and client billing accuracy."
    - name: "total_non_billable_hours"
      expr: SUM(CASE WHEN is_billable = FALSE THEN total_hours ELSE 0 END)
      comment: "Non-billable hours — overhead and indirect labor cost that erodes project margin."
    - name: "overtime_hours_ratio_numerator"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Numerator for overtime ratio (overtime hours / total hours) — combine with total_hours_worked in BI to compute overtime intensity percentage."
    - name: "rework_hours_ratio_numerator"
      expr: SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END)
      comment: "Numerator for rework ratio — divide by total_hours_worked in BI to derive rework percentage, a key quality KPI."
    - name: "distinct_craft_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of unique craft workers with recorded hours — measures active workforce size on the project."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timesheet-level workforce KPIs for payroll validation, labor cost management, and approval cycle performance across projects and cost codes."
  source: "`vibe_construction_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of the timesheet — enables daily and weekly labor trend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the timesheet — identifies bottlenecks in the payroll approval workflow."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day/night/weekend) — supports shift-level cost and productivity comparison."
    - name: "craft_classification"
      expr: craft_classification
      comment: "Craft trade classification — enables labor mix analysis and trade-level cost reporting."
    - name: "is_billable"
      expr: is_billable
      comment: "Billable flag — separates direct project labor from overhead for margin analysis."
    - name: "work_classification"
      expr: work_classification
      comment: "Work classification (direct, indirect, overhead) — supports cost allocation and project profitability analysis."
    - name: "union_local"
      expr: union_local
      comment: "Union local — supports union labor compliance reporting and certified payroll obligations."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition — enables analysis of weather-driven productivity loss and delay claims."
  measures:
    - name: "total_timesheets_submitted"
      expr: COUNT(1)
      comment: "Total timesheets submitted — baseline volume metric for payroll processing workload."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours across all timesheets — primary labor volume KPI."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours — cost overrun and schedule pressure indicator."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours — premium labor cost exposure metric."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours across all pay types — aggregate workforce effort metric."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost on timesheets — core job cost control KPI for budget vs. actual analysis."
    - name: "avg_labor_cost_per_timesheet"
      expr: AVG(CAST(labor_cost_amount AS DOUBLE))
      comment: "Average labor cost per timesheet — blended rate proxy; significant deviations indicate rate or classification anomalies."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production quantity recorded — supports earned-value and productivity rate calculations."
    - name: "distinct_workers_on_timesheets"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Unique craft workers with submitted timesheets — active headcount metric for workforce planning."
    - name: "unapproved_timesheets"
      expr: COUNT(CASE WHEN approval_status NOT IN ('APPROVED','POSTED') THEN 1 END)
      comment: "Count of timesheets not yet approved — payroll close risk indicator; high values require management escalation."
    - name: "overtime_hours_pct_numerator"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Numerator for overtime percentage (overtime / total hours) — combine with total_hours_worked in BI to compute overtime intensity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_production_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew and craft productivity KPIs measuring actual vs. planned production rates, earned hours, and variance — essential for schedule performance and cost-at-completion forecasting."
  source: "`vibe_construction_v1`.`workforce`.`production_rate`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date of the production record — enables daily and weekly productivity trend analysis."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade category (civil, structural, MEP, etc.) — supports trade-level productivity benchmarking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for production quantity — ensures apples-to-apples comparison across work types."
    - name: "shift"
      expr: shift
      comment: "Shift identifier — enables shift-level productivity comparison."
    - name: "site_condition"
      expr: site_condition
      comment: "Site condition at time of recording — supports analysis of condition-driven productivity impacts."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition — quantifies weather-related productivity loss for delay claim support."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Rework indicator — isolates rework-driven productivity loss from normal production."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Safety incident flag — correlates safety events with productivity drops."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome — links quality failures to productivity and rework costs."
    - name: "activity_code"
      expr: activity_code
      comment: "Schedule activity code — enables activity-level productivity tracking against the baseline."
  measures:
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total units of work actually completed — primary production output metric."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total units of work planned — baseline for production variance analysis."
    - name: "total_quantity_variance"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total production quantity variance (actual minus planned) — negative values indicate underperformance requiring intervention."
    - name: "total_earned_hours"
      expr: SUM(CAST(earned_hours AS DOUBLE))
      comment: "Total earned hours — EVM productivity metric; compares to expended hours to derive efficiency."
    - name: "total_expended_hours"
      expr: SUM(CAST(expended_hours AS DOUBLE))
      comment: "Total hours actually expended — denominator for labor efficiency ratio."
    - name: "total_hours_variance"
      expr: SUM(CAST(variance_hours AS DOUBLE))
      comment: "Total hours variance (earned minus expended) — negative values signal labor cost overrun."
    - name: "avg_actual_production_rate"
      expr: AVG(CAST(actual_production_rate AS DOUBLE))
      comment: "Average actual production rate across records — benchmarking metric for crew performance."
    - name: "avg_planned_production_rate"
      expr: AVG(CAST(planned_production_rate AS DOUBLE))
      comment: "Average planned production rate — baseline for production rate variance analysis."
    - name: "avg_productivity_factor"
      expr: AVG(CAST(productivity_factor AS DOUBLE))
      comment: "Average productivity factor (actual/planned ratio) — values below 1.0 indicate underperformance; drives corrective action."
    - name: "rework_records_count"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Count of production records flagged as rework — quality failure frequency metric."
    - name: "safety_incident_records_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Count of production records with associated safety incidents — safety-productivity correlation metric."
    - name: "labor_efficiency_ratio_numerator"
      expr: SUM(CAST(earned_hours AS DOUBLE))
      comment: "Numerator for labor efficiency ratio (earned hours / expended hours) — combine with total_expended_hours in BI to compute efficiency percentage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew deployment and assignment KPIs measuring workforce allocation, mobilization status, and labor cost across projects, activities, and WBS elements."
  source: "`vibe_construction_v1`.`workforce`.`crew_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the crew assignment — tracks active, pending, and completed deployments."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (direct, indirect, standby) — supports labor cost classification."
    - name: "craft_type"
      expr: craft_type
      comment: "Craft trade type — enables trade-level workforce allocation analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type — supports shift-level crew deployment analysis."
    - name: "is_billable"
      expr: billable_flag
      comment: "Billable flag — separates revenue-generating assignments from overhead deployments."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Overtime eligibility — identifies workforce segments with premium cost exposure."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation — supports union labor compliance and certified payroll reporting."
    - name: "assignment_start_date"
      expr: assignment_start_date
      comment: "Assignment start date — enables cohort analysis of workforce ramp-up patterns."
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total crew assignments — baseline workforce deployment volume metric."
    - name: "active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'ACTIVE' THEN 1 END)
      comment: "Currently active crew assignments — real-time workforce deployment count for site management."
    - name: "total_labor_rate_cost"
      expr: SUM(CAST(labor_rate AS DOUBLE))
      comment: "Sum of labor rates across assignments — aggregate labor cost commitment metric."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate across assignments — blended rate metric for budget benchmarking."
    - name: "total_per_diem_cost"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem costs across assignments — indirect labor cost component for project budget control."
    - name: "distinct_workers_assigned"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Unique craft workers assigned — active headcount metric for workforce planning and site capacity."
    - name: "distinct_crews_deployed"
      expr: COUNT(DISTINCT crew_id)
      comment: "Unique crews deployed — crew utilization metric for resource management."
    - name: "hse_orientation_completion_rate_numerator"
      expr: COUNT(CASE WHEN hse_orientation_completed_flag = TRUE THEN 1 END)
      comment: "Numerator for HSE orientation completion rate — divide by total_assignments in BI to compute compliance percentage; critical safety KPI."
    - name: "ppe_issued_rate_numerator"
      expr: COUNT(CASE WHEN ppe_issued_flag = TRUE THEN 1 END)
      comment: "Numerator for PPE issuance rate — divide by total_assignments in BI; low values indicate safety compliance gaps."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor mobilization cost and logistics KPIs tracking workforce deployment costs, per diem exposure, and mobilization cycle efficiency across projects."
  source: "`vibe_construction_v1`.`workforce`.`labor_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current mobilization status — tracks workforce in transit, on-site, and demobilized."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilization (initial, transfer, demobilization) — supports lifecycle cost analysis."
    - name: "travel_mode"
      expr: travel_mode
      comment: "Mode of travel — enables cost comparison across air, road, and rail mobilization."
    - name: "mobilization_date"
      expr: mobilization_date
      comment: "Mobilization date — enables ramp-up curve analysis and workforce availability tracking."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "HSE orientation completion — safety compliance gate metric for mobilized workers."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Per diem eligibility — identifies cost exposure for remote and fly-in/fly-out workforce."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Accommodation requirement flag — drives camp and accommodation cost forecasting."
  measures:
    - name: "total_mobilizations"
      expr: COUNT(1)
      comment: "Total mobilization events — baseline metric for workforce deployment activity volume."
    - name: "total_mobilization_cost"
      expr: SUM(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Total mobilization cost — direct project cost KPI; high values relative to contract value indicate logistics inefficiency."
    - name: "total_travel_cost_estimate"
      expr: SUM(CAST(travel_cost_estimate AS DOUBLE))
      comment: "Total estimated travel costs — component of mobilization cost for budget vs. actual analysis."
    - name: "total_accommodation_cost_estimate"
      expr: SUM(CAST(accommodation_cost_estimate AS DOUBLE))
      comment: "Total estimated accommodation costs — camp and housing cost exposure metric."
    - name: "total_per_diem_days"
      expr: SUM(CAST(per_diem_duration_days AS DOUBLE))
      comment: "Total per diem days across all mobilizations — drives per diem cost accrual and budget forecasting."
    - name: "total_per_diem_cost"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem rate cost — indirect labor cost component for project budget control."
    - name: "avg_mobilization_cost"
      expr: AVG(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Average cost per mobilization event — benchmarking metric for logistics efficiency."
    - name: "hse_orientation_pending_count"
      expr: COUNT(CASE WHEN hse_orientation_completed_flag = FALSE THEN 1 END)
      comment: "Workers mobilized without completed HSE orientation — safety compliance risk indicator requiring immediate action."
    - name: "distinct_workers_mobilized"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Unique craft workers mobilized — net workforce deployment headcount metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning KPIs comparing planned headcount and labor hours against actuals — essential for resource adequacy, peak demand management, and project staffing strategy."
  source: "`vibe_construction_v1`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the staffing plan (draft, approved, active, closed) — tracks planning maturity."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of staffing plan (baseline, revised, forecast) — supports version comparison."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy (direct hire, agency, subcontract) — drives make-vs-buy workforce decisions."
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start of the planning period — enables time-phased headcount analysis."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End of the planning period — supports rolling forecast and look-ahead planning."
    - name: "baseline_flag"
      expr: baseline_flag
      comment: "Baseline plan indicator — separates approved baseline from revised forecasts for variance analysis."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Accommodation requirement — drives camp capacity planning and logistics cost forecasting."
    - name: "transportation_required_flag"
      expr: transportation_required_flag
      comment: "Transportation requirement — identifies plans with significant logistics cost exposure."
  measures:
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(total_planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across staffing plans — primary workforce demand metric for resource planning."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours — actuals vs. plan comparison drives staffing adequacy assessment."
    - name: "total_labor_hours_variance"
      expr: SUM(CAST(labor_hours_variance AS DOUBLE))
      comment: "Total labor hours variance (actual minus planned) — negative values indicate understaffing; positive values indicate overstaffing."
    - name: "avg_peak_headcount"
      expr: AVG(CAST(peak_headcount AS DOUBLE))
      comment: "Average peak headcount across plans — site capacity and accommodation planning metric."
    - name: "total_staffing_plans"
      expr: COUNT(1)
      comment: "Total staffing plans — planning activity volume metric."
    - name: "approved_staffing_plans"
      expr: COUNT(CASE WHEN plan_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved staffing plans — governance metric ensuring workforce plans are formally sanctioned before execution."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance KPIs tracking certification coverage, expiry risk, and regulatory compliance — critical for site access, safety, and contractual obligations."
  source: "`vibe_construction_v1`.`workforce`.`craft_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (OSHA, trade license, first aid, etc.) — enables compliance gap analysis by certification category."
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level (entry, journeyman, master) — supports skill tier analysis."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Certifying authority — tracks compliance with specific regulatory body requirements."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country of issuance — supports multi-jurisdiction compliance reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certification — unverified certifications represent compliance and safety risk."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Regulatory compliance indicator — flags certifications required by law vs. project-specific requirements."
    - name: "site_access_required_flag"
      expr: site_access_required_flag
      comment: "Site access requirement flag — certifications gating site entry are highest priority for compliance monitoring."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Renewal requirement flag — identifies certifications with ongoing maintenance obligations."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Certification expiry date — enables proactive renewal management and expiry risk reporting."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records — baseline compliance coverage metric."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of expired certifications — immediate compliance risk; workers with expired certs must be stood down from regulated activities."
    - name: "expiring_within_30_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 END)
      comment: "Certifications expiring within 30 days — proactive renewal pipeline metric to prevent compliance gaps."
    - name: "unverified_certifications"
      expr: COUNT(CASE WHEN verification_status NOT IN ('VERIFIED','CONFIRMED') THEN 1 END)
      comment: "Count of unverified certifications — fraud and compliance risk indicator; unverified certs must be validated before site access."
    - name: "distinct_certified_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Unique workers with at least one certification record — certified workforce coverage metric."
    - name: "avg_training_hours_required"
      expr: AVG(CAST(training_hours_required AS DOUBLE))
      comment: "Average training hours required per certification — workforce development investment planning metric."
    - name: "site_access_cert_compliance_numerator"
      expr: COUNT(CASE WHEN site_access_required_flag = TRUE AND verification_status IN ('VERIFIED','CONFIRMED') AND expiry_date >= CURRENT_DATE() THEN 1 END)
      comment: "Numerator for site-access certification compliance rate — divide by total site-access-required certs in BI to compute compliance percentage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_agency_labor_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency labor procurement KPIs tracking order fulfillment, cost rates, and workforce sourcing performance — essential for managing contingent labor spend and agency performance."
  source: "`vibe_construction_v1`.`workforce`.`agency_labor_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the agency labor order — tracks open, fulfilled, cancelled, and closed orders."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level requested — enables demand analysis by workforce tier."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft trade code — supports trade-level agency labor demand and cost analysis."
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed — enables lead time and fulfillment cycle analysis."
    - name: "required_start_date"
      expr: required_start_date
      comment: "Required start date — supports workforce availability and scheduling analysis."
    - name: "union_affiliation_required_flag"
      expr: union_affiliation_required_flag
      comment: "Union affiliation requirement — separates union and non-union agency labor demand."
    - name: "hse_orientation_required_flag"
      expr: hse_orientation_required_flag
      comment: "HSE orientation requirement — identifies orders with mandatory safety onboarding."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order — supports multi-currency agency labor cost reporting."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total agency labor orders — baseline contingent workforce demand metric."
    - name: "total_bill_rate_cost"
      expr: SUM(CAST(bill_rate AS DOUBLE))
      comment: "Total bill rate across orders — aggregate agency labor cost commitment metric."
    - name: "total_pay_rate_cost"
      expr: SUM(CAST(pay_rate AS DOUBLE))
      comment: "Total pay rate across orders — worker compensation component of agency labor cost."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average agency markup percentage — agency margin metric; high values indicate renegotiation opportunity."
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate per order — benchmarking metric for agency rate competitiveness."
    - name: "fulfilled_orders"
      expr: COUNT(CASE WHEN order_status = 'FULFILLED' THEN 1 END)
      comment: "Count of fulfilled orders — agency performance metric; low fulfillment rates signal supply chain risk."
    - name: "cancelled_orders"
      expr: COUNT(CASE WHEN order_status = 'CANCELLED' THEN 1 END)
      comment: "Count of cancelled orders — demand volatility and planning accuracy indicator."
    - name: "fulfillment_rate_numerator"
      expr: COUNT(CASE WHEN order_status = 'FULFILLED' THEN 1 END)
      comment: "Numerator for agency fulfillment rate — divide by total_orders in BI to compute fulfillment percentage; key agency performance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor rate structure KPIs for cost estimation accuracy, prevailing wage compliance, and loaded rate benchmarking across projects, trades, and jurisdictions."
  source: "`vibe_construction_v1`.`workforce`.`labor_rate`"
  dimensions:
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level tier — enables rate comparison across apprentice, journeyman, and foreman classifications."
    - name: "trade_classification"
      expr: trade_classification
      comment: "Trade classification — supports trade-level rate benchmarking and budget development."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction — critical for prevailing wage compliance and multi-region rate management."
    - name: "union_local"
      expr: union_local
      comment: "Union local — supports union rate schedule compliance and certified payroll reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code — enables multi-currency rate analysis for international projects."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Rate effective start date — supports rate escalation analysis and historical rate comparison."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Rate effective end date — identifies rates approaching expiry that require renewal."
    - name: "travel_zone"
      expr: travel_zone
      comment: "Travel zone — supports zone-based rate differential analysis for remote project locations."
  measures:
    - name: "avg_base_hourly_rate"
      expr: AVG(CAST(base_hourly_rate AS DOUBLE))
      comment: "Average base hourly rate — benchmark for labor cost estimation and budget development."
    - name: "avg_total_loaded_hourly_rate"
      expr: AVG(CAST(total_loaded_hourly_rate AS DOUBLE))
      comment: "Average fully loaded hourly rate (base + burden + fringe) — true cost of labor for project profitability analysis."
    - name: "avg_overtime_hourly_rate"
      expr: AVG(CAST(overtime_hourly_rate AS DOUBLE))
      comment: "Average overtime hourly rate — premium cost exposure metric for schedule risk quantification."
    - name: "avg_payroll_burden_percentage"
      expr: AVG(CAST(payroll_burden_percentage AS DOUBLE))
      comment: "Average payroll burden percentage — indirect labor cost ratio for overhead allocation and bid pricing."
    - name: "avg_fringe_benefit_rate"
      expr: AVG(CAST(fringe_benefit_rate AS DOUBLE))
      comment: "Average fringe benefit rate — benefits cost component for total compensation benchmarking."
    - name: "avg_per_diem_rate"
      expr: AVG(CAST(per_diem_rate AS DOUBLE))
      comment: "Average per diem rate — remote workforce cost component for project budget development."
    - name: "total_rate_records"
      expr: COUNT(1)
      comment: "Total labor rate records — rate schedule coverage metric ensuring all trades and jurisdictions are priced."
    - name: "avg_overhead_percentage"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage — indirect cost loading metric for bid pricing and project cost control."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_site_access_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site access and workforce presence KPIs tracking headcount on site, access compliance, HSE screening, and security — essential for safety management and site control."
  source: "`vibe_construction_v1`.`workforce`.`site_access_record`"
  dimensions:
    - name: "access_direction"
      expr: access_direction
      comment: "Access direction (entry/exit) — enables net headcount calculation and presence tracking."
    - name: "access_zone"
      expr: access_zone
      comment: "Site zone accessed — supports zone-level headcount and access control analysis."
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification (direct, subcontractor, visitor) — enables workforce composition analysis."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Authorization status — identifies unauthorized access attempts requiring security escalation."
    - name: "ppe_compliance_status"
      expr: ppe_compliance_status
      comment: "PPE compliance status at entry — non-compliant entries are a leading safety indicator."
    - name: "health_screening_status"
      expr: health_screening_status
      comment: "Health screening outcome — tracks workforce health compliance for site safety protocols."
    - name: "induction_status"
      expr: induction_status
      comment: "Site induction status — workers without completed induction represent a safety and liability risk."
    - name: "access_method"
      expr: access_method
      comment: "Access method (badge, biometric, manual) — supports access control technology effectiveness analysis."
  measures:
    - name: "total_access_events"
      expr: COUNT(1)
      comment: "Total site access events — baseline site traffic metric for security and workforce management."
    - name: "distinct_workers_on_site"
      expr: COUNT(DISTINCT primary_site_craft_worker_id)
      comment: "Unique workers accessing the site — net headcount metric for site capacity and safety muster planning."
    - name: "avg_duration_on_site_minutes"
      expr: AVG(CAST(duration_on_site_minutes AS DOUBLE))
      comment: "Average time spent on site per access event — productivity and shift adherence indicator."
    - name: "total_duration_on_site_minutes"
      expr: SUM(CAST(duration_on_site_minutes AS DOUBLE))
      comment: "Total worker-minutes on site — aggregate presence metric for workforce utilization analysis."
    - name: "ppe_non_compliance_events"
      expr: COUNT(CASE WHEN ppe_compliance_status NOT IN ('COMPLIANT','PASS') THEN 1 END)
      comment: "PPE non-compliance events at site entry — leading safety indicator; high values require immediate HSE intervention."
    - name: "access_denial_events"
      expr: COUNT(CASE WHEN authorization_status = 'DENIED' THEN 1 END)
      comment: "Count of denied access events — security and compliance metric; patterns indicate systemic credential or induction issues."
    - name: "induction_incomplete_entries"
      expr: COUNT(CASE WHEN induction_status NOT IN ('COMPLETE','COMPLETED') THEN 1 END)
      comment: "Site entries without completed induction — safety compliance gap metric requiring corrective action."
    - name: "avg_temperature_reading"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature reading at site entry — health screening metric for workforce wellness monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_apprenticeship_progression`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Apprenticeship program KPIs tracking workforce development pipeline, DOL compliance, OJT hours accumulation, and journeyman conversion rates — essential for workforce sustainability and regulatory compliance."
  source: "`vibe_construction_v1`.`workforce`.`apprenticeship_progression`"
  dimensions:
    - name: "apprenticeship_status"
      expr: apprenticeship_status
      comment: "Current status of the apprenticeship (active, completed, suspended, cancelled) — tracks program pipeline health."
    - name: "apprenticeship_level"
      expr: apprenticeship_level
      comment: "Apprenticeship level (year 1-4, period) — enables cohort progression analysis."
    - name: "apprenticeship_type"
      expr: apprenticeship_type
      comment: "Type of apprenticeship (trade, technical, hybrid) — supports program mix analysis."
    - name: "apprenticeship_program_name"
      expr: apprenticeship_program_name
      comment: "Program name — enables program-level performance comparison."
    - name: "dol_compliance_flag"
      expr: dol_compliance_flag
      comment: "DOL compliance indicator — non-compliant apprenticeships represent regulatory risk and potential penalties."
    - name: "state_apprenticeship_compliance_flag"
      expr: state_apprenticeship_compliance_flag
      comment: "State-level compliance flag — supports multi-jurisdiction apprenticeship compliance reporting."
    - name: "certification_earned_flag"
      expr: certification_earned_flag
      comment: "Certification earned indicator — tracks successful program completions."
    - name: "union_local"
      expr: union_local
      comment: "Union local — supports JATC program compliance and union apprenticeship ratio reporting."
  measures:
    - name: "total_apprenticeships"
      expr: COUNT(1)
      comment: "Total apprenticeship records — workforce development pipeline size metric."
    - name: "active_apprenticeships"
      expr: COUNT(CASE WHEN apprenticeship_status = 'ACTIVE' THEN 1 END)
      comment: "Currently active apprenticeships — pipeline health metric for workforce sustainability planning."
    - name: "total_ojt_hours_accumulated"
      expr: SUM(CAST(ojt_hours_accumulated AS DOUBLE))
      comment: "Total on-the-job training hours accumulated — workforce development investment metric and DOL compliance indicator."
    - name: "total_technical_instruction_hours"
      expr: SUM(CAST(technical_instruction_hours AS DOUBLE))
      comment: "Total technical instruction hours completed — classroom training investment metric."
    - name: "avg_apprentice_to_journeyman_ratio"
      expr: AVG(CAST(apprentice_to_journeyman_ratio AS DOUBLE))
      comment: "Average apprentice-to-journeyman ratio — DOL and union compliance metric; ratios outside allowed range trigger regulatory action."
    - name: "certifications_earned"
      expr: COUNT(CASE WHEN certification_earned_flag = TRUE THEN 1 END)
      comment: "Count of certifications earned through apprenticeship — program effectiveness and workforce development ROI metric."
    - name: "dol_non_compliant_count"
      expr: COUNT(CASE WHEN dol_compliance_flag = FALSE THEN 1 END)
      comment: "Count of DOL non-compliant apprenticeships — regulatory risk metric requiring immediate remediation to avoid penalties."
    - name: "avg_ojt_hours_accumulated"
      expr: AVG(CAST(ojt_hours_accumulated AS DOUBLE))
      comment: "Average OJT hours per apprentice — progression pace metric; low averages indicate program delivery issues."
    - name: "ojt_completion_rate_numerator"
      expr: SUM(CAST(ojt_hours_accumulated AS DOUBLE))
      comment: "Numerator for OJT completion rate — divide by SUM(apprenticeship_hours_required) in BI to compute OJT progress percentage."
    - name: "total_apprenticeship_hours_required"
      expr: SUM(CAST(apprenticeship_hours_required AS DOUBLE))
      comment: "Total OJT hours required across all apprenticeships — denominator for OJT completion rate and program scope metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_carbon_reduction_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce sustainability KPIs measuring craft worker participation in carbon reduction initiatives — supports ESG reporting, sustainability targets, and green workforce development."
  source: "`vibe_construction_v1`.`workforce`.`carbon_reduction_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Status of the participation record (enrolled, active, completed, withdrawn) — tracks initiative engagement pipeline."
    - name: "participation_role"
      expr: participation_role
      comment: "Role of the worker in the initiative — enables contribution analysis by role type."
    - name: "is_certified"
      expr: is_certified
      comment: "Certification flag — identifies workers with formally certified carbon reduction contributions."
    - name: "is_verified"
      expr: is_verified
      comment: "Verification flag — ensures carbon savings are independently verified for ESG reporting integrity."
    - name: "training_completed"
      expr: training_completed
      comment: "Training completion flag — tracks workforce readiness for carbon reduction activities."
    - name: "recognition_awarded"
      expr: recognition_awarded
      comment: "Recognition awarded flag — supports workforce engagement and sustainability culture metrics."
    - name: "enrolled_date"
      expr: enrolled_date
      comment: "Enrollment date — enables cohort analysis of participation ramp-up over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code — supports multi-currency incentive cost reporting."
  measures:
    - name: "total_participations"
      expr: COUNT(1)
      comment: "Total participation records — baseline workforce sustainability engagement metric."
    - name: "distinct_participating_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Unique craft workers participating in carbon reduction initiatives — workforce sustainability coverage metric for ESG reporting."
    - name: "total_carbon_saved_kgco2e"
      expr: SUM(CAST(carbon_saved_kgco2e AS DOUBLE))
      comment: "Total verified carbon savings in kgCO2e — primary ESG outcome metric for workforce sustainability reporting."
    - name: "total_estimated_carbon_saved_kgco2e"
      expr: SUM(CAST(estimated_carbon_saved_kgco2e AS DOUBLE))
      comment: "Total estimated carbon savings — forward-looking sustainability target tracking metric."
    - name: "total_hours_contributed"
      expr: SUM(CAST(hours_contributed AS DOUBLE))
      comment: "Total hours contributed to carbon reduction activities — workforce investment in sustainability metric."
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive payments for carbon reduction participation — sustainability program cost metric."
    - name: "avg_contribution_score"
      expr: AVG(CAST(contribution_score AS DOUBLE))
      comment: "Average contribution score — workforce sustainability performance benchmarking metric."
    - name: "verified_participation_rate_numerator"
      expr: COUNT(CASE WHEN is_verified = TRUE THEN 1 END)
      comment: "Numerator for verified participation rate — divide by total_participations in BI to compute verification coverage percentage for ESG audit integrity."
    - name: "avg_carbon_saved_per_worker"
      expr: AVG(CAST(carbon_saved_kgco2e AS DOUBLE))
      comment: "Average carbon saved per participation record — per-worker sustainability impact metric for program effectiveness evaluation."
$$;