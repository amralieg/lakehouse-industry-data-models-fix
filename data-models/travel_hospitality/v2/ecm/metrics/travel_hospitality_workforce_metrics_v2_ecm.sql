-- Metric views for domain: workforce | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce headcount and employment status metrics. Provides executives with visibility into active headcount, hiring trends, and workforce composition by property and job title."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_employee`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the employee is assigned — enables property-level headcount analysis."
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (e.g. Active, Terminated, On Leave) — key dimension for workforce segmentation."
    - name: "job_title"
      expr: job_title
      comment: "Employee job title — enables role-level workforce distribution analysis."
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire — supports cohort and tenure analysis."
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire — supports monthly hiring trend analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the employee record is currently active."
  measures:
    - name: "total_headcount"
      expr: COUNT(1)
      comment: "Total number of employee records. Baseline headcount KPI used in workforce planning and capacity reviews."
    - name: "active_headcount"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active employees. Core metric for operational staffing capacity and labor cost forecasting."
    - name: "inactive_headcount"
      expr: COUNT(CASE WHEN is_active = FALSE THEN 1 END)
      comment: "Count of inactive employees. Tracks attrition volume and supports turnover rate calculations."
    - name: "distinct_properties_staffed"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with at least one employee. Indicates workforce geographic spread."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce scheduling efficiency and labor hour metrics. Enables operations leaders to monitor scheduled labor hours, shift utilization, and scheduling coverage by property and date."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`schedule`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the shift is scheduled — enables property-level labor planning analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule record (e.g. Confirmed, Pending, Cancelled) — key filter for active vs. draft schedules."
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the scheduled shift — primary time dimension for daily labor planning."
    - name: "shift_week"
      expr: DATE_TRUNC('WEEK', shift_date)
      comment: "Week of the scheduled shift — supports weekly labor hour aggregation."
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the scheduled shift — supports monthly labor cost and hour trend analysis."
  measures:
    - name: "total_scheduled_shifts"
      expr: COUNT(1)
      comment: "Total number of scheduled shifts. Baseline volume metric for scheduling operations."
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total labor hours scheduled across all shifts. Core input for labor cost budgeting and capacity planning."
    - name: "avg_scheduled_hours_per_shift"
      expr: AVG(CAST(scheduled_hours AS DOUBLE))
      comment: "Average hours per scheduled shift. Indicates shift length norms and flags anomalies in scheduling patterns."
    - name: "confirmed_shifts"
      expr: COUNT(CASE WHEN schedule_status = 'Confirmed' THEN 1 END)
      comment: "Number of confirmed shifts. Measures scheduling confirmation rate and operational readiness."
    - name: "total_confirmed_scheduled_hours"
      expr: SUM(CASE WHEN schedule_status = 'Confirmed' THEN scheduled_hours ELSE 0 END)
      comment: "Total confirmed scheduled hours. Represents committed labor capacity for operational planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position vacancy and FTE capacity metrics. Enables HR and finance leaders to track open positions, FTE budget utilization, and organizational capacity gaps."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_position`"
  dimensions:
    - name: "is_vacant"
      expr: is_vacant
      comment: "Boolean flag indicating whether the position is currently vacant — primary filter for open position analysis."
    - name: "position_title"
      expr: position_title
      comment: "Title of the position — enables role-level FTE and vacancy analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the position became effective — supports workforce planning timeline analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the position became effective — supports monthly position creation trend analysis."
  measures:
    - name: "total_positions"
      expr: COUNT(1)
      comment: "Total number of defined positions. Baseline metric for organizational structure sizing."
    - name: "vacant_positions"
      expr: COUNT(CASE WHEN is_vacant = TRUE THEN 1 END)
      comment: "Number of currently vacant positions. Critical KPI for talent acquisition prioritization and operational risk."
    - name: "filled_positions"
      expr: COUNT(CASE WHEN is_vacant = FALSE THEN 1 END)
      comment: "Number of currently filled positions. Measures staffing fulfillment against organizational design."
    - name: "total_fte_budget"
      expr: SUM(CAST(fte_count AS DOUBLE))
      comment: "Total FTE count across all positions. Represents the full authorized labor capacity of the organization."
    - name: "avg_fte_per_position"
      expr: AVG(CAST(fte_count AS DOUBLE))
      comment: "Average FTE count per position. Indicates whether positions are full-time, part-time, or shared-role structures."
    - name: "vacant_fte_count"
      expr: SUM(CASE WHEN is_vacant = TRUE THEN fte_count ELSE 0 END)
      comment: "Total FTE count associated with vacant positions. Quantifies the labor capacity gap requiring recruitment action."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_job_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline metrics. Enables HR and business leaders to monitor open requisitions, approval rates, and hiring pipeline velocity."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_job_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the job requisition (e.g. Open, Approved, Filled, Cancelled) — primary dimension for pipeline stage analysis."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating whether the requisition has been approved — key filter for active hiring pipeline."
    - name: "target_start_month"
      expr: DATE_TRUNC('MONTH', target_start_date)
      comment: "Target month for the new hire to start — supports hiring timeline and workforce planning."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the requisition was created — supports requisition volume trend analysis."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of job requisitions. Baseline metric for talent acquisition pipeline volume."
    - name: "approved_requisitions"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Number of approved requisitions. Measures how much of the hiring demand has cleared the approval gate."
    - name: "pending_approval_requisitions"
      expr: COUNT(CASE WHEN is_approved = FALSE THEN 1 END)
      comment: "Number of requisitions awaiting approval. Flags bottlenecks in the hiring authorization process."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions that have been approved. Measures hiring authorization efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_disciplinary_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations and disciplinary action metrics. Enables HR leadership to monitor disciplinary incident volume, severity distribution, and resolution rates — key inputs for workforce risk management."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_disciplinary_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of disciplinary action (e.g. Verbal Warning, Written Warning, Suspension, Termination) — primary dimension for severity analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the disciplinary action — enables risk-tiered workforce relations reporting."
    - name: "is_resolved"
      expr: is_resolved
      comment: "Boolean flag indicating whether the disciplinary action has been resolved — key filter for open vs. closed cases."
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month the disciplinary action occurred — supports trend analysis of employee relations incidents."
    - name: "action_year"
      expr: YEAR(action_date)
      comment: "Year the disciplinary action occurred — supports annual workforce relations benchmarking."
  measures:
    - name: "total_disciplinary_actions"
      expr: COUNT(1)
      comment: "Total number of disciplinary actions recorded. Baseline metric for workforce relations risk monitoring."
    - name: "resolved_actions"
      expr: COUNT(CASE WHEN is_resolved = TRUE THEN 1 END)
      comment: "Number of disciplinary actions that have been resolved. Measures HR case closure effectiveness."
    - name: "open_actions"
      expr: COUNT(CASE WHEN is_resolved = FALSE THEN 1 END)
      comment: "Number of unresolved disciplinary actions. Flags active employee relations risk requiring HR attention."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_resolved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disciplinary actions that have been resolved. Measures HR case management efficiency and risk clearance rate."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_compensation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure and cost metrics. Enables HR and finance leaders to analyze base salary budgets, bonus target exposure, and compensation plan activity."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the compensation plan — enables plan-level cost and structure comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the compensation plan — essential for multi-currency compensation analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the compensation plan is currently active — key filter for live vs. historical plans."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the compensation plan became effective — supports annual compensation cycle analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the compensation plan became effective — supports compensation cycle timing analysis."
  measures:
    - name: "total_compensation_plans"
      expr: COUNT(1)
      comment: "Total number of compensation plans. Baseline metric for compensation structure governance."
    - name: "active_compensation_plans"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active compensation plans. Measures live compensation structure breadth."
    - name: "total_base_salary_budget"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary amount across all compensation plans. Core input for labor cost budgeting and financial planning."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary amount across compensation plans. Benchmarks compensation levels for market competitiveness reviews."
    - name: "avg_bonus_target_pct"
      expr: AVG(CAST(bonus_target_pct AS DOUBLE))
      comment: "Average bonus target percentage across compensation plans. Measures variable pay exposure and incentive program design."
    - name: "total_bonus_target_exposure"
      expr: SUM(CAST(base_salary_amount AS DOUBLE) * CAST(bonus_target_pct AS DOUBLE) / 100.0)
      comment: "Total estimated bonus exposure (base salary × bonus target %). Quantifies maximum variable pay liability for financial risk planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_benefit_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee benefit plan cost and enrollment metrics. Enables HR and finance leaders to monitor benefit cost structure, employer vs. employee contribution split, and plan activity."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of benefit plan (e.g. Medical, Dental, Vision, Retirement) — primary dimension for benefit cost category analysis."
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the benefit plan — enables plan-level cost comparison."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the benefit plan is currently active — key filter for live vs. historical plans."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the benefit plan became effective — supports annual benefits cycle analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the benefit plan became effective — supports benefits renewal cycle timing analysis."
  measures:
    - name: "total_benefit_plans"
      expr: COUNT(1)
      comment: "Total number of benefit plans. Baseline metric for benefits portfolio governance."
    - name: "active_benefit_plans"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active benefit plans. Measures live benefits offering breadth."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Total employer contribution amount across all benefit plans. Core input for total compensation cost and benefits budget planning."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution_amount AS DOUBLE))
      comment: "Total employee contribution amount across all benefit plans. Measures employee cost-sharing in the benefits program."
    - name: "avg_employer_contribution"
      expr: AVG(CAST(employer_contribution_amount AS DOUBLE))
      comment: "Average employer contribution per benefit plan. Benchmarks employer benefit generosity for talent attraction strategy."
    - name: "employer_contribution_share_pct"
      expr: ROUND(100.0 * SUM(CAST(employer_contribution_amount AS DOUBLE)) / NULLIF(SUM(CAST(employer_contribution_amount AS DOUBLE)) + SUM(CAST(employee_contribution_amount AS DOUBLE)), 0), 2)
      comment: "Employer share of total benefit contributions as a percentage. Measures how much of benefit costs the organization absorbs vs. passes to employees — key for total rewards strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_learning_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning and development program metrics. Enables L&D and compliance leaders to monitor course portfolio health, training cost, compliance coverage, and certification issuance."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`learning_course`"
  dimensions:
    - name: "course_category"
      expr: course_category
      comment: "Category of the learning course (e.g. Safety, Leadership, Technical) — primary dimension for L&D portfolio analysis."
    - name: "course_type"
      expr: course_type
      comment: "Type of course (e.g. eLearning, Instructor-Led, Blended) — enables delivery modality analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method of the course — supports modality mix and cost-per-delivery analysis."
    - name: "course_status"
      expr: course_status
      comment: "Current status of the course (e.g. Active, Retired, Draft) — key filter for live vs. archived content."
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Boolean flag indicating whether the course is required for regulatory compliance — enables compliance training portfolio segmentation."
    - name: "certification_issued_flag"
      expr: certification_issued_flag
      comment: "Boolean flag indicating whether the course issues a certification upon completion."
    - name: "property_id"
      expr: property_id
      comment: "Property where the course is deployed — enables property-level L&D investment analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the course became effective — supports curriculum lifecycle analysis."
  measures:
    - name: "total_courses"
      expr: COUNT(1)
      comment: "Total number of learning courses in the catalog. Baseline metric for L&D portfolio size."
    - name: "active_courses"
      expr: COUNT(CASE WHEN course_status = 'Active' THEN 1 END)
      comment: "Number of currently active courses. Measures live training content availability."
    - name: "compliance_required_courses"
      expr: COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN 1 END)
      comment: "Number of courses required for regulatory compliance. Measures the compliance training obligation footprint."
    - name: "certification_issuing_courses"
      expr: COUNT(CASE WHEN certification_issued_flag = TRUE THEN 1 END)
      comment: "Number of courses that issue a certification. Measures the credentialing value of the training portfolio."
    - name: "total_cost_per_learner_budget"
      expr: SUM(CAST(cost_per_learner AS DOUBLE))
      comment: "Sum of per-learner costs across all courses. Proxy for total L&D investment exposure when multiplied by enrollment counts."
    - name: "avg_cost_per_learner"
      expr: AVG(CAST(cost_per_learner AS DOUBLE))
      comment: "Average cost per learner across all courses. Benchmarks training investment efficiency and informs L&D budget allocation."
    - name: "avg_course_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average course duration in hours. Measures training time investment per course and informs scheduling capacity planning."
    - name: "total_continuing_education_credits"
      expr: SUM(CAST(continuing_education_credits AS DOUBLE))
      comment: "Total continuing education credits available across all courses. Measures the professional development value of the training catalog."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational structure and unit metrics. Enables HR and operations leaders to monitor org unit health, hierarchy depth, and active organizational coverage by property."
  source: "`vibe_travel_hospitality_v1`.`workforce`.`workforce_org_unit`"
  dimensions:
    - name: "org_unit_type"
      expr: org_unit_type
      comment: "Type of organizational unit (e.g. Department, Division, Team) — primary dimension for org structure analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the org unit is currently active — key filter for live organizational structure."
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the org unit — enables property-level organizational structure analysis."
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the org unit was created — supports organizational growth and restructuring trend analysis."
  measures:
    - name: "total_org_units"
      expr: COUNT(1)
      comment: "Total number of organizational units. Baseline metric for organizational structure complexity."
    - name: "active_org_units"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active organizational units. Measures live organizational structure breadth."
    - name: "distinct_properties_with_org_units"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with defined organizational units. Measures organizational structure coverage across the portfolio."
    - name: "org_units_with_parent"
      expr: COUNT(CASE WHEN parent_org_unit_id IS NOT NULL THEN 1 END)
      comment: "Number of org units that have a parent unit (i.e. are not top-level). Measures organizational hierarchy depth and reporting structure complexity."
$$;