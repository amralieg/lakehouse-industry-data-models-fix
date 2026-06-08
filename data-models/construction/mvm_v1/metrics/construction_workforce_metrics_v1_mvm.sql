-- Metric views for domain: workforce | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_timesheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core labor productivity and cost metrics derived from approved timesheets. Enables project managers and finance leaders to track labor spend, overtime exposure, billable utilization, and production output across projects, crews, and cost codes."
  source: "`construction_ecm`.`workforce`.`timesheet`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Calendar date the work was performed, enabling daily and weekly labor trend analysis."
    - name: "payroll_period"
      expr: payroll_period
      comment: "Payroll period identifier for aligning labor costs to pay cycles and financial reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Timesheet approval state (e.g. Approved, Pending, Rejected) for governance and payroll readiness tracking."
    - name: "craft_classification"
      expr: craft_classification
      comment: "Craft or trade classification of the worker (e.g. Ironworker, Electrician) for trade-level labor analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift designation (Day, Night, Swing) to analyze labor distribution and shift premium exposure."
    - name: "work_classification"
      expr: work_classification
      comment: "Nature of work performed (e.g. Direct, Indirect, Rework) for productivity and quality cost analysis."
    - name: "pay_type"
      expr: pay_type
      comment: "Pay type (e.g. Regular, Overtime, Double-Time) for compensation structure analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating whether the labor hours are billable to the client, enabling billable utilization tracking."
    - name: "location_code"
      expr: location_code
      comment: "Site or location code where work was performed for geographic labor distribution analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which labor costs are denominated for multi-currency project reporting."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total straight-time hours worked across all timesheets. Core input for labor productivity and schedule performance analysis."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked. Elevated overtime signals schedule pressure, resource shortfalls, or cost overrun risk."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours worked. High double-time exposure directly inflates labor cost and indicates critical schedule stress."
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours worked including regular, overtime, and double-time. Primary labor volume KPI for project tracking."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost amount recorded on timesheets. Directly drives project cost performance and budget variance analysis."
    - name: "avg_labor_cost_per_hour"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Blended average labor cost per hour. Tracks effective labor rate trends and identifies cost escalation across trades or projects."
    - name: "overtime_hours_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Overtime hours as a percentage of total hours. A leading indicator of schedule pressure and labor cost overrun risk; typically managed below 10-15%."
    - name: "billable_hours_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_billable = TRUE THEN total_hours ELSE 0 END) / NULLIF(SUM(CAST(total_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of total hours that are billable to the client. Low billable utilization signals indirect cost leakage and revenue recovery risk."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output quantity recorded on timesheets. Combined with total hours, enables unit productivity rate calculations."
    - name: "approved_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN timesheet_id END)
      comment: "Count of approved timesheets. Tracks payroll readiness and approval cycle efficiency."
    - name: "pending_timesheet_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN timesheet_id END)
      comment: "Count of timesheets awaiting approval. High pending counts risk payroll delays and inaccurate cost accruals."
    - name: "distinct_workers_on_timesheets"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers with timesheet entries. Measures active workforce size on the project for headcount tracking."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_timesheet_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular labor cost and productivity metrics at the timesheet line level, enabling cost code, WBS, and activity-level labor analysis. Supports job cost posting validation, rework cost quantification, and billable labor recovery."
  source: "`construction_ecm`.`workforce`.`timesheet_line`"
  dimensions:
    - name: "work_date"
      expr: work_date
      comment: "Date the work was performed at line level for daily labor cost tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the timesheet line for payroll and job cost posting governance."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft trade code for the line item, enabling trade-level cost and productivity analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for the line item to analyze shift-based labor cost distribution."
    - name: "is_billable"
      expr: is_billable
      comment: "Indicates whether the line item hours are billable to the client."
    - name: "is_rework"
      expr: is_rework
      comment: "Flags rework labor lines, enabling cost of quality and rework rate analysis."
    - name: "posted_to_job_cost_flag"
      expr: posted_to_job_cost_flag
      comment: "Indicates whether the line has been posted to the job cost system, tracking financial close completeness."
    - name: "posted_to_payroll_flag"
      expr: posted_to_payroll_flag
      comment: "Indicates whether the line has been posted to payroll, tracking payroll processing completeness."
    - name: "work_location_code"
      expr: work_location_code
      comment: "Location code for the work performed, enabling site-level labor cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the labor cost amount for multi-currency reporting."
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular hours at line level. Foundational measure for WBS and cost code labor tracking."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours at line level. Enables overtime cost attribution to specific WBS elements and cost codes."
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Total double-time hours at line level for premium pay cost attribution."
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Total hours at line level across all pay types. Primary labor volume measure for cost code and activity analysis."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost at line level. Enables precise cost attribution to WBS elements, activities, and cost codes."
    - name: "rework_labor_cost"
      expr: SUM(CASE WHEN is_rework = TRUE THEN labor_cost_amount ELSE 0 END)
      comment: "Total labor cost attributed to rework activities. A key cost-of-quality metric; high rework cost signals quality management failures."
    - name: "rework_hours"
      expr: SUM(CASE WHEN is_rework = TRUE THEN total_hours ELSE 0 END)
      comment: "Total hours spent on rework. Directly measures productivity loss from quality failures."
    - name: "rework_cost_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_rework = TRUE THEN labor_cost_amount ELSE 0 END) / NULLIF(SUM(CAST(labor_cost_amount AS DOUBLE)), 0), 2)
      comment: "Rework labor cost as a percentage of total labor cost. A critical quality and efficiency KPI; industry benchmark is typically below 5%."
    - name: "unposted_job_cost_hours"
      expr: SUM(CASE WHEN posted_to_job_cost_flag = FALSE THEN total_hours ELSE 0 END)
      comment: "Hours not yet posted to the job cost system. High unposted hours indicate financial close risk and inaccurate project cost reporting."
    - name: "billable_labor_cost"
      expr: SUM(CASE WHEN is_billable = TRUE THEN labor_cost_amount ELSE 0 END)
      comment: "Total billable labor cost. Directly ties to revenue recovery and client invoicing accuracy."
    - name: "total_production_quantity"
      expr: SUM(CAST(production_quantity AS DOUBLE))
      comment: "Total production output at line level for unit productivity rate analysis by cost code and activity."
    - name: "avg_cost_per_production_unit"
      expr: ROUND(SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(production_quantity AS DOUBLE)), 0), 2)
      comment: "Average labor cost per unit of production. A key productivity efficiency metric for benchmarking against estimates and industry norms."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_craft_worker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce composition, cost, and compliance metrics at the craft worker level. Enables HR, project, and compliance teams to track workforce demographics, labor rates, union exposure, OSHA compliance, and mobilization status."
  source: "`construction_ecm`.`workforce`.`craft_worker`"
  dimensions:
    - name: "worker_status"
      expr: worker_status
      comment: "Current employment status of the craft worker (e.g. Active, Terminated, On Leave) for workforce availability analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (e.g. Direct Hire, Agency, Subcontractor) for workforce sourcing strategy analysis."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill proficiency level (e.g. Apprentice, Journeyman, Master) for workforce capability and succession planning."
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current mobilization state of the worker (e.g. Mobilized, Demobilized, Pending) for site headcount management."
    - name: "union_affiliation_flag"
      expr: union_affiliation_flag
      comment: "Indicates union membership, enabling union vs. non-union workforce composition and cost analysis."
    - name: "union_name"
      expr: union_name
      comment: "Name of the union the worker is affiliated with for union jurisdiction and labor relations management."
    - name: "supervisory_role_flag"
      expr: supervisory_role_flag
      comment: "Indicates whether the worker holds a supervisory role for span-of-control and supervision ratio analysis."
    - name: "osha_certification_flag"
      expr: osha_certification_flag
      comment: "Indicates OSHA certification status for safety compliance workforce tracking."
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level for workers on sensitive or government projects."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the worker's rates are denominated."
  measures:
    - name: "active_worker_count"
      expr: COUNT(CASE WHEN worker_status = 'Active' THEN craft_worker_id END)
      comment: "Count of currently active craft workers. Primary workforce headcount KPI for project staffing and resource management."
    - name: "total_worker_count"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Total distinct craft workers in the workforce registry. Measures total workforce pool size."
    - name: "avg_hourly_base_rate"
      expr: ROUND(AVG(CAST(hourly_base_rate AS DOUBLE)), 2)
      comment: "Average base hourly rate across craft workers. Tracks labor cost benchmarks and rate escalation trends."
    - name: "total_hourly_base_rate_cost_exposure"
      expr: SUM(CAST(hourly_base_rate AS DOUBLE))
      comment: "Sum of all base hourly rates representing total rate exposure. Used for workforce cost modeling and budget planning."
    - name: "union_worker_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN union_affiliation_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of workforce with union affiliation. Drives labor relations strategy, prevailing wage compliance, and collective bargaining exposure."
    - name: "osha_certified_worker_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN osha_certification_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of craft workers with valid OSHA certification. A critical safety compliance KPI; low rates signal regulatory risk and site access issues."
    - name: "supervisory_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN supervisory_role_flag = TRUE THEN craft_worker_id END) / NULLIF(COUNT(DISTINCT craft_worker_id), 0), 2)
      comment: "Percentage of workforce in supervisory roles. Informs span-of-control adequacy and supervision cost as a share of total labor."
    - name: "mobilized_worker_count"
      expr: COUNT(CASE WHEN mobilization_status = 'Mobilized' THEN craft_worker_id END)
      comment: "Count of workers currently mobilized on site. Tracks actual site headcount against staffing plan targets."
    - name: "avg_overtime_rate_multiplier"
      expr: ROUND(AVG(CAST(overtime_rate_multiplier AS DOUBLE)), 4)
      comment: "Average overtime rate multiplier across the workforce. Higher multipliers increase overtime cost exposure and inform shift scheduling decisions."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_crew_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew deployment, assignment efficiency, and compliance metrics. Enables project and workforce managers to track assignment utilization, HSE orientation compliance, per diem exposure, and billable assignment rates across projects and phases."
  source: "`construction_ecm`.`workforce`.`crew_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the crew assignment (e.g. Active, Completed, Cancelled) for deployment pipeline management."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g. Permanent, Temporary, Emergency) for workforce flexibility analysis."
    - name: "craft_type"
      expr: craft_type
      comment: "Craft trade type for the assignment, enabling trade-level deployment and utilization analysis."
    - name: "crew_role"
      expr: crew_role
      comment: "Role of the worker within the crew (e.g. Lead, Member, Foreman) for crew composition analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for the assignment to analyze shift coverage and premium pay exposure."
    - name: "billable_flag"
      expr: billable_flag
      comment: "Indicates whether the assignment is billable to the client for revenue recovery tracking."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Indicates overtime eligibility for the assignment, informing overtime cost risk management."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Indicates per diem eligibility, enabling per diem cost exposure analysis."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "Indicates whether HSE site orientation was completed before assignment start — a critical safety compliance gate."
    - name: "union_affiliation"
      expr: union_affiliation
      comment: "Union affiliation for the assignment for labor relations and prevailing wage compliance tracking."
  measures:
    - name: "total_assignments"
      expr: COUNT(DISTINCT crew_assignment_id)
      comment: "Total crew assignments. Baseline measure for deployment volume and workforce utilization tracking."
    - name: "active_assignment_count"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN crew_assignment_id END)
      comment: "Count of currently active crew assignments. Measures live workforce deployment on projects."
    - name: "hse_orientation_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hse_orientation_completed_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments where HSE orientation was completed. A non-negotiable safety compliance KPI; any gap represents regulatory and incident risk."
    - name: "billable_assignment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billable_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments flagged as billable. Tracks revenue recovery efficiency and non-billable labor exposure."
    - name: "per_diem_eligible_assignment_count"
      expr: COUNT(CASE WHEN per_diem_eligible_flag = TRUE THEN crew_assignment_id END)
      comment: "Count of assignments with per diem eligibility. Drives per diem cost forecasting and budget management."
    - name: "total_per_diem_cost_exposure"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Sum of per diem rates across all assignments. Quantifies total per diem cost exposure for budget and cash flow planning."
    - name: "avg_per_diem_rate"
      expr: ROUND(AVG(CAST(per_diem_rate AS DOUBLE)), 2)
      comment: "Average per diem rate across eligible assignments. Benchmarks per diem spend against contract allowances and industry norms."
    - name: "overtime_eligible_assignment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overtime_eligible_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments eligible for overtime. High rates signal elevated overtime cost risk and schedule pressure."
    - name: "ppe_issued_assignment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppe_issued_flag = TRUE THEN crew_assignment_id END) / NULLIF(COUNT(DISTINCT crew_assignment_id), 0), 2)
      comment: "Percentage of assignments where PPE was issued. Tracks safety equipment compliance and site readiness."
    - name: "distinct_workers_assigned"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers with active or historical assignments. Measures workforce deployment breadth."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_labor_mobilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor mobilization cost, efficiency, and compliance metrics. Enables project and logistics teams to track mobilization spend, per diem exposure, accommodation costs, HSE orientation compliance, and site access readiness across projects."
  source: "`construction_ecm`.`workforce`.`labor_mobilization`"
  dimensions:
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of the mobilization event (e.g. Planned, In Progress, Completed, Cancelled) for pipeline management."
    - name: "mobilization_type"
      expr: mobilization_type
      comment: "Type of mobilization (e.g. Initial, Remobilization, Demobilization) for cost pattern analysis."
    - name: "mobilization_reason"
      expr: mobilization_reason
      comment: "Business reason driving the mobilization event for root cause and cost attribution analysis."
    - name: "travel_mode"
      expr: travel_mode
      comment: "Mode of travel used for mobilization (e.g. Air, Road, Rail) for travel cost optimization."
    - name: "hse_orientation_completed_flag"
      expr: hse_orientation_completed_flag
      comment: "Indicates whether HSE orientation was completed as part of the mobilization process — a mandatory safety gate."
    - name: "per_diem_eligible_flag"
      expr: per_diem_eligible_flag
      comment: "Indicates per diem eligibility for the mobilization event."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Indicates whether accommodation was required, enabling accommodation cost planning and vendor management."
    - name: "site_access_badge_issued_flag"
      expr: site_access_badge_issued_flag
      comment: "Indicates whether a site access badge was issued, tracking site readiness compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of mobilization costs for multi-currency project reporting."
    - name: "craft_code"
      expr: craft_code
      comment: "Craft trade code for the mobilized worker, enabling trade-level mobilization cost analysis."
  measures:
    - name: "total_mobilization_cost"
      expr: SUM(CAST(total_mobilization_cost AS DOUBLE))
      comment: "Total mobilization cost across all events. A direct project cost driver; high mobilization costs signal logistics inefficiency or excessive workforce churn."
    - name: "avg_mobilization_cost"
      expr: ROUND(AVG(CAST(total_mobilization_cost AS DOUBLE)), 2)
      comment: "Average cost per mobilization event. Benchmarks mobilization efficiency and identifies outlier high-cost events."
    - name: "total_travel_cost_estimate"
      expr: SUM(CAST(travel_cost_estimate AS DOUBLE))
      comment: "Total estimated travel costs across mobilization events. Enables travel budget management and mode optimization."
    - name: "total_accommodation_cost_estimate"
      expr: SUM(CAST(accommodation_cost_estimate AS DOUBLE))
      comment: "Total estimated accommodation costs. Tracks camp and lodging spend as a component of total mobilization cost."
    - name: "total_per_diem_cost_exposure"
      expr: SUM(CAST(per_diem_rate AS DOUBLE))
      comment: "Sum of per diem rates across all mobilization events. Quantifies per diem liability for budget and cash flow planning."
    - name: "hse_orientation_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hse_orientation_completed_flag = TRUE THEN labor_mobilization_id END) / NULLIF(COUNT(DISTINCT labor_mobilization_id), 0), 2)
      comment: "Percentage of mobilization events where HSE orientation was completed. Non-compliance is a regulatory and safety incident risk."
    - name: "site_badge_issuance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN site_access_badge_issued_flag = TRUE THEN labor_mobilization_id END) / NULLIF(COUNT(DISTINCT labor_mobilization_id), 0), 2)
      comment: "Percentage of mobilizations where site access badges were issued. Tracks site readiness and access control compliance."
    - name: "accommodation_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accommodation_required_flag = TRUE THEN labor_mobilization_id END) / NULLIF(COUNT(DISTINCT labor_mobilization_id), 0), 2)
      comment: "Percentage of mobilizations requiring accommodation. Informs camp capacity planning and accommodation vendor management."
    - name: "total_mobilization_events"
      expr: COUNT(DISTINCT labor_mobilization_id)
      comment: "Total count of mobilization events. Baseline volume metric for mobilization pipeline and logistics capacity planning."
    - name: "travel_cost_as_pct_of_total_mobilization"
      expr: ROUND(100.0 * SUM(CAST(travel_cost_estimate AS DOUBLE)) / NULLIF(SUM(CAST(total_mobilization_cost AS DOUBLE)), 0), 2)
      comment: "Travel cost as a percentage of total mobilization cost. Identifies travel as a cost driver and informs mode-shift decisions."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_staffing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce planning and labor hours variance metrics. Enables project and workforce planning teams to track planned vs. actual labor hours, staffing plan approval status, and labor hours variance across projects, phases, and planning periods."
  source: "`construction_ecm`.`workforce`.`staffing_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Approval and lifecycle status of the staffing plan (e.g. Draft, Approved, Superseded) for governance tracking."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of staffing plan (e.g. Baseline, Revised, Forecast) for version and scenario analysis."
    - name: "plan_version"
      expr: plan_version
      comment: "Version identifier of the staffing plan for change management and baseline comparison."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Workforce sourcing approach (e.g. Direct Hire, Agency, Subcontract) for make-vs-buy analysis."
    - name: "baseline_flag"
      expr: baseline_flag
      comment: "Indicates whether this is the approved baseline plan for earned value and variance analysis."
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start date of the planning period for time-phased workforce demand analysis."
    - name: "planning_period_end_date"
      expr: planning_period_end_date
      comment: "End date of the planning period for workforce demand horizon analysis."
    - name: "accommodation_required_flag"
      expr: accommodation_required_flag
      comment: "Indicates whether accommodation is required for the planned workforce, driving camp and logistics planning."
    - name: "transportation_required_flag"
      expr: transportation_required_flag
      comment: "Indicates whether transportation is required for the planned workforce, driving logistics cost planning."
  measures:
    - name: "total_planned_labor_hours"
      expr: SUM(CAST(total_planned_labor_hours AS DOUBLE))
      comment: "Total planned labor hours across all staffing plans. Primary workforce demand KPI for resource planning and budget development."
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours recorded against staffing plans. Enables planned vs. actual labor hours performance tracking."
    - name: "total_labor_hours_variance"
      expr: SUM(CAST(labor_hours_variance AS DOUBLE))
      comment: "Total variance between planned and actual labor hours. Negative variance indicates overrun; positive indicates underrun. Critical for project cost control."
    - name: "labor_hours_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_hours_variance AS DOUBLE)) / NULLIF(SUM(CAST(total_planned_labor_hours AS DOUBLE)), 0), 2)
      comment: "Labor hours variance as a percentage of planned hours. Normalizes variance for cross-project benchmarking and trend analysis."
    - name: "avg_planned_labor_hours_per_plan"
      expr: ROUND(AVG(CAST(total_planned_labor_hours AS DOUBLE)), 2)
      comment: "Average planned labor hours per staffing plan. Benchmarks plan scale and informs resource allocation norms."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN staffing_plan_id END)
      comment: "Count of approved staffing plans. Tracks planning governance maturity and approval pipeline health."
    - name: "total_staffing_plans"
      expr: COUNT(DISTINCT staffing_plan_id)
      comment: "Total count of staffing plans. Baseline measure for planning activity volume across projects."
    - name: "plans_requiring_accommodation_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accommodation_required_flag = TRUE THEN staffing_plan_id END) / NULLIF(COUNT(DISTINCT staffing_plan_id), 0), 2)
      comment: "Percentage of staffing plans requiring accommodation. Drives camp capacity planning and accommodation cost forecasting."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_craft_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification compliance, expiry risk, and regulatory readiness metrics. Enables HSE, compliance, and project teams to track certification coverage, expiry exposure, regulatory compliance rates, and site access readiness across the craft workforce."
  source: "`construction_ecm`.`workforce`.`craft_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. OSHA, First Aid, Trade License) for compliance category analysis."
    - name: "certification_level"
      expr: certification_level
      comment: "Proficiency level of the certification (e.g. Basic, Advanced, Master) for workforce capability assessment."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification for regulatory authority tracking."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country of certification issuance for international workforce compliance management."
    - name: "verification_status"
      expr: verification_status
      comment: "Current verification state of the certification (e.g. Verified, Pending, Failed) for compliance assurance."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the certification satisfies a regulatory compliance requirement."
    - name: "project_requirement_flag"
      expr: project_requirement_flag
      comment: "Indicates whether the certification is required for project site access."
    - name: "site_access_required_flag"
      expr: site_access_required_flag
      comment: "Indicates whether the certification is required for site access, enabling access control compliance tracking."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates whether the certification requires periodic renewal for expiry risk management."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT craft_certification_id)
      comment: "Total count of craft certifications in the registry. Baseline measure for certification portfolio size."
    - name: "distinct_certified_workers"
      expr: COUNT(DISTINCT craft_worker_id)
      comment: "Count of distinct craft workers holding at least one certification. Measures certified workforce coverage."
    - name: "regulatory_compliance_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN craft_certification_id END) / NULLIF(COUNT(DISTINCT craft_certification_id), 0), 2)
      comment: "Percentage of certifications meeting regulatory compliance requirements. A critical compliance KPI; gaps expose the organization to regulatory penalties and project shutdowns."
    - name: "verified_certification_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN craft_certification_id END) / NULLIF(COUNT(DISTINCT craft_certification_id), 0), 2)
      comment: "Percentage of certifications with verified status. Unverified certifications represent compliance and site access risk."
    - name: "site_access_required_certification_count"
      expr: COUNT(CASE WHEN site_access_required_flag = TRUE THEN craft_certification_id END)
      comment: "Count of certifications required for site access. Tracks the volume of access-critical credentials that must be maintained current."
    - name: "renewal_required_certification_count"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN craft_certification_id END)
      comment: "Count of certifications requiring renewal. Drives proactive renewal scheduling to prevent compliance lapses."
    - name: "total_training_hours_required"
      expr: SUM(CAST(training_hours_required AS DOUBLE))
      comment: "Total training hours required across all certifications. Informs training program capacity planning and workforce development investment."
    - name: "avg_training_hours_per_certification"
      expr: ROUND(AVG(CAST(training_hours_required AS DOUBLE)), 2)
      comment: "Average training hours required per certification. Benchmarks training investment per credential type for workforce development budgeting."
    - name: "project_required_certification_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN project_requirement_flag = TRUE THEN craft_certification_id END) / NULLIF(COUNT(DISTINCT craft_certification_id), 0), 2)
      comment: "Percentage of certifications that are project-mandated. High rates indicate stringent project compliance requirements and workforce readiness risk."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`workforce_labor_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor rate structure, cost burden, and prevailing wage compliance metrics. Enables finance, procurement, and project controls teams to analyze loaded labor rates, overtime and fringe benefit exposure, profit margins, and certified payroll obligations across projects and jurisdictions."
  source: "`construction_ecm`.`workforce`.`labor_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Classification of the labor rate (e.g. Union, Non-Union, Prevailing Wage) for rate structure analysis."
    - name: "rate_status"
      expr: rate_status
      comment: "Lifecycle status of the rate (e.g. Active, Expired, Pending) for rate governance and validity tracking."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level associated with the rate for rate-by-skill-tier analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic or regulatory jurisdiction for the rate, enabling prevailing wage and union jurisdiction compliance analysis."
    - name: "travel_zone"
      expr: travel_zone
      comment: "Travel zone classification affecting subsistence and travel allowances."
    - name: "certified_payroll_required_flag"
      expr: certified_payroll_required_flag
      comment: "Indicates whether certified payroll reporting is required, flagging Davis-Bacon and prevailing wage compliance obligations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the labor rates for multi-currency project analysis."
    - name: "union_local"
      expr: union_local
      comment: "Union local associated with the rate for union jurisdiction and collective bargaining analysis."
  measures:
    - name: "avg_base_hourly_rate"
      expr: ROUND(AVG(CAST(base_hourly_rate AS DOUBLE)), 2)
      comment: "Average base hourly rate across all active rate records. Benchmarks labor cost baseline for estimating and budget development."
    - name: "avg_total_loaded_hourly_rate"
      expr: ROUND(AVG(CAST(total_loaded_hourly_rate AS DOUBLE)), 2)
      comment: "Average fully loaded hourly rate including burden, fringe, and overhead. The true cost of labor per hour for project cost modeling."
    - name: "avg_overtime_hourly_rate"
      expr: ROUND(AVG(CAST(overtime_hourly_rate AS DOUBLE)), 2)
      comment: "Average overtime hourly rate. Quantifies overtime cost premium for schedule risk and cost contingency planning."
    - name: "avg_double_time_hourly_rate"
      expr: ROUND(AVG(CAST(double_time_hourly_rate AS DOUBLE)), 2)
      comment: "Average double-time hourly rate. Quantifies maximum labor cost exposure under extreme schedule pressure scenarios."
    - name: "avg_payroll_burden_pct"
      expr: ROUND(AVG(CAST(payroll_burden_percentage AS DOUBLE)), 2)
      comment: "Average payroll burden percentage across rate records. Tracks total employer cost above base wages for budget and bid development."
    - name: "avg_fringe_benefit_rate"
      expr: ROUND(AVG(CAST(fringe_benefit_rate AS DOUBLE)), 2)
      comment: "Average fringe benefit rate. Quantifies benefits cost as a component of total labor cost for workforce cost modeling."
    - name: "avg_profit_margin_pct"
      expr: ROUND(AVG(CAST(profit_margin_percentage AS DOUBLE)), 2)
      comment: "Average profit margin percentage embedded in labor rates. Tracks margin adequacy and rate competitiveness for bid strategy."
    - name: "loaded_rate_premium_over_base"
      expr: ROUND(AVG(CAST(total_loaded_hourly_rate AS DOUBLE)) - AVG(CAST(base_hourly_rate AS DOUBLE)), 2)
      comment: "Average premium of loaded rate over base rate. Quantifies total burden, overhead, and margin loading per hour for cost transparency."
    - name: "certified_payroll_rate_count"
      expr: COUNT(CASE WHEN certified_payroll_required_flag = TRUE THEN labor_rate_id END)
      comment: "Count of rate records requiring certified payroll reporting. Tracks prevailing wage compliance obligation volume."
    - name: "avg_overhead_percentage"
      expr: ROUND(AVG(CAST(overhead_percentage AS DOUBLE)), 2)
      comment: "Average overhead percentage applied to labor rates. Informs overhead recovery analysis and rate competitiveness assessment."
$$;