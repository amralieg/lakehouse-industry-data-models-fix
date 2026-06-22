-- Metric views for domain: workforce | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core labor productivity and cost metrics derived from approved timesheet records. Enables project managers and finance leaders to track labor hours, cost burn, overtime exposure, and billable utilization across projects, crews, and cost codes."
  source: "`vibe_construction_v1`.`workforce`.`timesheet`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Calendar date on which the work was performed. Used for daily, weekly, and monthly trend analysis of labor activity."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project. Enables project-level labor cost and hours analysis."
    - name: "craft_classification"
      expr: craft_classification
      comment: "Trade or craft classification of the worker (e.g., Ironworker, Electrician, Carpenter). Supports workforce composition and cost analysis by trade."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the timesheet (e.g., Approved, Pending, Rejected). Used to filter for payroll-ready records and identify bottlenecks."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift worked (e.g., Day, Night, Swing). Supports shift-based cost and productivity analysis."
    - name: "work_classification"
      expr: work_classification
      comment: "Classification of work performed (e.g., Direct, Indirect, Rework). Enables productive vs. non-productive labor analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the hours are billable to the client. Drives billable utilization rate calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which labor costs are denominated. Required for multi-currency project cost reporting."
    - name: "project_site_id"
      expr: project_site_id
      comment: "Foreign key to the project site. Enables site-level labor cost and hours breakdown."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition recorded at time of work. Supports analysis of weather-related productivity impacts and delays."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours worked across all timesheets. Core measure of productive labor input and workforce deployment."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. High overtime signals schedule pressure, crew fatigue risk, and cost overrun exposure."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked. Indicates extreme schedule pressure and premium labor cost exposure."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked including regular, overtime, and double-time. Primary measure of overall labor volume on a project."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost amount recorded on timesheets. Core financial KPI for project cost control and budget variance tracking."
    - name: "avg_labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Average blended labor cost per hour. Tracks effective labor rate trends and identifies cost escalation by trade, project, or period."
    - name: "overtime_hours_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours. A leading indicator of schedule stress; high values trigger crew augmentation or schedule re-sequencing decisions."
    - name: "billable_hours_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_billable = TRUE THEN total_hours ELSE 0 END) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are billable to the client. Directly impacts revenue recognition and project margin; low values indicate unbillable overhead or rework."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total units of production recorded on timesheets. Combined with total hours, enables labor productivity (units per hour) analysis by trade and project."
    - name: "distinct_workers_count"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of unique craft workers with timesheet entries in the period. Measures active workforce size and supports headcount planning."
    - name: "approved_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN timesheet_id END)
      comment: "Number of approved timesheets. Tracks payroll readiness and approval workflow throughput; low approval rates delay payroll and cost reporting."
    - name: "avg_hours_per_worker"
      expr: ROUND(SUM(CAST(total_hours AS DOUBLE)) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Average total hours worked per unique worker in the period. Indicates workforce utilization intensity and helps identify under- or over-deployed workers."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_timesheet_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular labor cost and productivity metrics at the timesheet line level. Enables cost code-level analysis of direct vs. rework labor, billable utilization, and production efficiency — critical for earned value management and job cost control."
  source: "`vibe_construction_v1`.`workforce`.`timesheet_line`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date the work was performed at the line level. Enables daily granularity for labor cost and productivity trending."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project. Supports project-level drill-down from timesheet line data."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft trade code at the line level. Enables trade-specific labor cost and productivity analysis within a project."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the individual timesheet line. Used to isolate approved vs. pending labor costs for payroll and cost reporting."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the line item hours are billable to the client. Drives billable vs. non-billable cost segregation."
    - name: "is_rework"
      expr: is_rework
      comment: "Flags whether the work performed is rework (correcting defects). Rework hours and cost are a key quality and efficiency KPI."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for the line item. Supports shift-differential cost analysis and shift productivity comparisons."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the labor cost amount on this line. Required for multi-currency project cost consolidation."
    - name: "work_location_code"
      expr: work_location_code
      comment: "Location code where the work was performed. Enables site and zone-level labor cost analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of work. Supports correlation analysis between weather and labor productivity or rework rates."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours at the line level. Foundational measure for cost code-level labor input tracking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours at the line level. Enables cost code-level overtime exposure analysis."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours at the line level. Identifies cost codes driving premium labor cost."
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours at the line level. Used as the denominator for productivity and cost-per-hour calculations."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost at the line level. Enables cost code-level job cost control and budget variance analysis."
    - name: "rework_hours"
      expr: SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END)
      comment: "Total hours spent on rework activities. A direct quality KPI — high rework hours indicate quality failures driving cost overruns."
    - name: "rework_cost"
      expr: SUM(CASE WHEN is_rework = TRUE THEN labor_cost_amount ELSE 0 END)
      comment: "Total labor cost attributable to rework. Quantifies the financial impact of quality failures; used to justify quality investment and track improvement."
    - name: "rework_hours_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Rework hours as a percentage of total hours. A leading quality KPI — values above threshold trigger quality intervention and root cause analysis."
    - name: "billable_cost"
      expr: SUM(CASE WHEN is_billable = TRUE THEN labor_cost_amount ELSE 0 END)
      comment: "Total billable labor cost. Directly tied to revenue recognition; gap between billable and total cost reveals margin leakage."
    - name: "avg_cost_per_production_unit"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(production_quantity AS DOUBLE)), 0), 2)
      comment: "Average labor cost per unit of production. Core productivity KPI for earned value management — compares actual vs. budgeted unit cost."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production units recorded at the line level. Used with hours to compute labor productivity rates by cost code and trade."
    - name: "distinct_workers_count"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of unique workers with line-level entries. Measures active headcount at cost code granularity for resource allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_worker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce composition, cost structure, and mobilization metrics for craft workers. Enables HR and project leadership to manage headcount, labor cost rates, union exposure, and workforce readiness across projects."
  source: "`vibe_construction_v1`.`workforce`.`craft_worker`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project. Enables project-level workforce headcount and cost rate analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (e.g., Direct Hire, Subcontract, Temporary). Drives workforce strategy and risk decisions."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level of the craft worker (e.g., Apprentice, Journeyman, Foreman). Supports workforce capability and succession planning."
    - name: "worker_status"
      expr: worker_status
      comment: "Current status of the worker (e.g., Active, Terminated, On Leave). Used to track active headcount and attrition."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Mobilization status of the worker (e.g., Mobilized, Demobilized, Pending). Tracks workforce deployment readiness."
    - name: "union_affiliation_flag"
      expr: union_affiliation_flag
      comment: "Indicates whether the worker is union-affiliated. Drives union vs. open-shop workforce composition analysis."
    - name: "supervisory_role_flag"
      expr: supervisory_role_flag
      comment: "Indicates whether the worker holds a supervisory role. Supports span-of-control and leadership ratio analysis."
    - name: "osha_certification_flag"
      expr: osha_certification_flag
      comment: "Indicates whether the worker holds a valid OSHA certification. Tracks safety compliance at the workforce level."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the worker's compensation rates. Required for multi-currency labor cost analysis."
  measures:
    - name: "active_worker_count"
      expr: COUNT(CASE WHEN worker_status = 'Active' THEN craft_worker_id END)
      comment: "Number of currently active craft workers. Primary headcount KPI for workforce capacity planning and project staffing decisions."
    - name: "total_worker_count"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Total distinct craft workers in the workforce pool. Measures overall workforce size including all statuses."
    - name: "avg_hourly_base_rate"
      expr: ROUND(AVG(CAST(hourly_base_rate AS DOUBLE)), 2)
      comment: "Average base hourly rate across craft workers. Tracks labor cost structure and rate inflation trends; informs bid pricing and budget forecasting."
    - name: "total_hourly_base_rate_budget"
      expr: SUM(CAST(hourly_base_rate AS DOUBLE))
      comment: "Sum of all base hourly rates for active workforce. Provides a proxy for total labor rate exposure when combined with planned hours."
    - name: "union_worker_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_affiliation_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of workforce that is union-affiliated. Tracks union labor exposure, which affects wage rates, work rules, and labor relations risk."
    - name: "osha_certified_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_certification_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of workers with valid OSHA certification. A safety compliance KPI — values below threshold trigger mandatory training and may halt site access."
    - name: "supervisory_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN supervisory_role_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of workforce in supervisory roles. Tracks span-of-control ratios; imbalances indicate over- or under-supervision risk."
    - name: "avg_overtime_rate_multiplier"
      expr: ROUND(AVG(CAST(overtime_rate_multiplier AS DOUBLE)), 4)
      comment: "Average overtime rate multiplier across the workforce. Tracks blended overtime cost exposure; higher values indicate premium labor cost risk."
    - name: "mobilized_worker_count"
      expr: COUNT(CASE WHEN mobilization_status = 'Mobilized' THEN craft_worker_id END)
      comment: "Number of workers currently mobilized to a project site. Tracks active deployment and supports site capacity management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew-level productivity, safety, and cost efficiency metrics. Enables project managers to evaluate crew performance, safety compliance, and cost rates — driving decisions on crew composition, redeployment, and demobilization."
  source: "`vibe_construction_v1`.`workforce`.`crew`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project. Enables project-level crew performance benchmarking."
    - name: "crew_type"
      expr: crew_type
      comment: "Type of crew (e.g., Concrete, Steel, MEP). Supports trade-specific crew performance analysis."
    - name: "crew_status"
      expr: crew_status
      comment: "Current operational status of the crew (e.g., Active, Demobilized, Standby). Tracks active crew deployment."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type assigned to the crew (e.g., Day, Night). Supports shift-based productivity and cost comparison."
    - name: "is_union_crew"
      expr: is_union_crew
      comment: "Indicates whether the crew operates under a union agreement. Drives union vs. open-shop cost and productivity analysis."
    - name: "project_site_id"
      expr: project_site_id
      comment: "Foreign key to the project site. Enables site-level crew deployment and performance analysis."
  measures:
    - name: "active_crew_count"
      expr: COUNT(CASE WHEN crew_status = 'Active' THEN crew_id END)
      comment: "Number of currently active crews. Primary measure of deployed crew capacity across projects and sites."
    - name: "avg_crew_hourly_rate"
      expr: ROUND(AVG(CAST(average_hourly_rate AS DOUBLE)), 2)
      comment: "Average blended hourly rate across crews. Tracks crew cost structure and informs budget forecasting and bid pricing."
    - name: "avg_crew_productivity_rate"
      expr: ROUND(AVG(CAST(productivity_rate AS DOUBLE)), 4)
      comment: "Average productivity rate across crews (units per hour or similar UOM). Core operational KPI for comparing crew efficiency and identifying underperforming crews."
    - name: "union_crew_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_union_crew = TRUE THEN crew_id END) / NULLIF(COUNT(DISTINCT crew_id), 0), 2)
      comment: "Percentage of crews operating under union agreements. Tracks union labor exposure and informs labor relations and cost planning."
    - name: "total_crew_count"
      expr: COUNT(DISTINCT crew_id)
      comment: "Total number of distinct crews. Measures overall crew deployment scale across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew assignment lifecycle, compliance, and cost metrics. Tracks worker deployment against projects, HSE orientation compliance, per diem exposure, and assignment utilization — enabling project controls and HSE teams to manage workforce deployment risk."
  source: "`vibe_construction_v1`.`workforce`.`crew_assignment`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project. Enables project-level assignment volume and compliance analysis."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the crew assignment (e.g., Active, Completed, Cancelled). Tracks assignment lifecycle and workforce deployment."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., Primary, Supplemental, Temporary). Supports workforce deployment strategy analysis."
    - name: "crew_role"
      expr: crew_role
      comment: "Role of the worker within the crew (e.g., Foreman, Journeyman, Helper). Enables role-based cost and headcount analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the assignment. Supports shift-differential cost and scheduling analysis."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the assignment is billable to the client. Drives billable headcount and revenue recognition analysis."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Indicates whether the worker is eligible for overtime on this assignment. Tracks overtime cost exposure at the assignment level."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Indicates whether the worker is eligible for per diem on this assignment. Tracks per diem cost exposure for remote or travel-based assignments."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "Indicates whether HSE site orientation has been completed. A safety compliance gate — workers without orientation cannot legally access the site."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation recorded on the assignment. Supports union labor tracking and compliance reporting."
  measures:
    - name: "active_assignment_count"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN crew_assignment_id END)
      comment: "Number of currently active crew assignments. Primary measure of deployed workforce size; drives site capacity and resource planning."
    - name: "total_assignment_count"
      expr: COUNT(DISTINCT crew_assignment_id)
      comment: "Total crew assignments in the period. Measures workforce deployment volume and assignment throughput."
    - name: "hse_orientation_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hse_orientation_completed_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments where HSE orientation has been completed. A critical safety compliance KPI — non-compliance is a regulatory violation and site access risk."
    - name: "avg_labor_rate"
      expr: ROUND(AVG(CAST(labor_rate AS DOUBLE)), 2)
      comment: "Average labor rate across crew assignments. Tracks blended labor cost rate trends and informs project cost forecasting."
    - name: "total_per_diem_exposure"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Total per diem rate exposure across eligible assignments. Quantifies the per diem cost burden for remote or travel-based workforce deployments."
    - name: "per_diem_eligible_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN per_diem_eligible_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments eligible for per diem. Tracks remote workforce cost exposure; high values indicate significant travel and subsistence cost burden."
    - name: "billable_assignment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billable_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments that are billable to the client. Tracks billable utilization of deployed workforce; low values indicate unbillable overhead or scope gaps."
    - name: "distinct_workers_assigned"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of unique workers with active or historical assignments. Measures workforce deployment breadth across projects and crews."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_craft_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance and expiry risk metrics. Enables HSE, project controls, and HR teams to track certification coverage, regulatory compliance, and renewal risk — preventing site access violations and regulatory penalties."
  source: "`vibe_construction_v1`.`workforce`.`craft_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., OSHA 30, First Aid, Rigging). Enables compliance tracking by certification category."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of the certification (e.g., Basic, Advanced, Master). Supports workforce capability and qualification analysis."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification. Tracks certification source credibility and regulatory recognition."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country of certification issuance. Supports multi-jurisdiction compliance tracking."
    - name: "verification_status"
      expr: verification_status
      comment: "Status of certification verification (e.g., Verified, Pending, Failed). Tracks verification workflow completion."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the certification satisfies a regulatory requirement. Drives regulatory compliance reporting and audit readiness."
    - name: "project_requirement_flag"
      expr: project_requirement_flag
      comment: "Indicates whether the certification is required for project site access. Tracks project-specific compliance gaps."
    - name: "site_access_required_flag"
      expr: site_access_required_flag
      comment: "Indicates whether the certification is required for site access. A hard gate — workers without required certs cannot access the site."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether the certification requires periodic renewal. Drives proactive renewal tracking and expiry risk management."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT craft_certification_id)
      comment: "Total number of certifications on record. Measures overall certification portfolio size and coverage."
    - name: "verified_certification_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN craft_certification_id END) / NULLIF(COUNT(DISTINCT craft_certification_id), 0), 2)
      comment: "Percentage of certifications that have been verified. Tracks verification compliance; unverified certifications represent regulatory and site access risk."
    - name: "regulatory_compliant_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN craft_certification_id END) / NULLIF(COUNT(DISTINCT craft_certification_id), 0), 2)
      comment: "Percentage of certifications meeting regulatory compliance requirements. A critical compliance KPI — non-compliance triggers regulatory penalties and project shutdowns."
    - name: "expiring_within_30_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN craft_certification_id END)
      comment: "Number of certifications expiring within the next 30 days. A leading risk indicator — enables proactive renewal to prevent site access disruptions."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE THEN craft_certification_id END)
      comment: "Number of certifications that have already expired. Represents immediate compliance risk — expired certifications must be renewed or workers removed from site."
    - name: "avg_training_hours_required"
      expr: ROUND(AVG(CAST(training_hours_required AS DOUBLE)), 2)
      comment: "Average training hours required per certification. Informs training program planning, scheduling, and cost estimation for workforce upskilling."
    - name: "total_training_hours_required"
      expr: SUM(CAST(training_hours_required AS DOUBLE))
      comment: "Total training hours required across all certifications. Quantifies the training investment needed to maintain workforce compliance and capability."
    - name: "distinct_certified_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Number of unique workers holding at least one certification. Measures certified workforce coverage and identifies uncertified worker populations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`workforce_labor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor rate structure and cost burden metrics. Enables finance, project controls, and procurement teams to analyze blended labor rates, overtime and fringe cost exposure, and prevailing wage compliance across projects and jurisdictions."
  source: "`vibe_construction_v1`.`workforce`.`labor_rate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project. Enables project-level labor rate analysis and comparison."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level associated with the labor rate (e.g., Apprentice, Journeyman, Foreman). Supports rate-by-skill analysis for workforce cost modeling."
    - name: "trade_classification"
      expr: trade_classification
      comment: "Trade classification for the labor rate (e.g., Electrician, Pipefitter). Enables trade-specific rate benchmarking and cost planning."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal or geographic jurisdiction governing the labor rate. Critical for prevailing wage compliance and multi-jurisdiction project cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the labor rate. Required for multi-currency project cost consolidation."
    - name: "travel_zone"
      expr: travel_zone
      comment: "Travel zone associated with the labor rate. Supports travel and subsistence cost analysis for remote project sites."
    - name: "union_local"
      expr: union_local
      comment: "Union local associated with the labor rate. Enables union-specific rate tracking and collective bargaining agreement compliance."
  measures:
    - name: "avg_base_hourly_rate"
      expr: ROUND(AVG(CAST(base_hourly_rate AS DOUBLE)), 2)
      comment: "Average base hourly rate across labor rate records. Tracks labor cost baseline trends by trade, jurisdiction, and project for bid and budget accuracy."
    - name: "avg_total_loaded_hourly_rate"
      expr: ROUND(AVG(CAST(total_loaded_hourly_rate AS DOUBLE)), 2)
      comment: "Average fully loaded hourly rate including burden, fringe, and overhead. The true all-in labor cost rate used for project cost forecasting and margin analysis."
    - name: "avg_overtime_hourly_rate"
      expr: ROUND(AVG(CAST(overtime_hourly_rate AS DOUBLE)), 2)
      comment: "Average overtime hourly rate. Quantifies overtime cost premium; used to model schedule acceleration cost and evaluate overtime vs. crew augmentation trade-offs."
    - name: "avg_fringe_benefit_rate"
      expr: ROUND(AVG(CAST(fringe_benefit_rate AS DOUBLE)), 2)
      comment: "Average fringe benefit rate across labor rate records. Tracks benefits cost burden; significant driver of total loaded rate and project cost."
    - name: "avg_payroll_burden_pct"
      expr: ROUND(AVG(CAST(payroll_burden_percentage AS DOUBLE)), 2)
      comment: "Average payroll burden percentage. Measures the overhead cost multiplier on base wages; high values indicate significant indirect labor cost exposure."
    - name: "avg_overhead_pct"
      expr: ROUND(AVG(CAST(overhead_percentage AS DOUBLE)), 2)
      comment: "Average overhead percentage applied to labor rates. Tracks overhead cost allocation trends and informs project pricing and margin management."
    - name: "loaded_vs_base_rate_premium"
      expr: ROUND(AVG(CAST(total_loaded_hourly_rate AS DOUBLE)) - AVG(CAST(base_hourly_rate AS DOUBLE)), 2)
      comment: "Average premium of loaded rate over base rate. Quantifies the total burden, fringe, and overhead cost added on top of base wages — a key cost structure KPI."
    - name: "avg_per_diem_rate"
      expr: ROUND(AVG(CAST(per_diem_rate AS DOUBLE)), 2)
      comment: "Average per diem rate across labor rate records. Tracks subsistence cost exposure for remote and travel-based project assignments."
    - name: "distinct_rate_records"
      expr: COUNT(DISTINCT labor_rate_id)
      comment: "Total distinct labor rate records. Measures rate schedule complexity and coverage across projects, trades, and jurisdictions."
$$;