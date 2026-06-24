-- Metric views for domain: workforce | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce headcount and compensation analytics. Provides executive-level visibility into workforce composition, compensation spend, and talent distribution across the organization."
  source: "`vibe_semiconductors_v1`.`workforce`.`employee`"
  dimensions:
    - name: "employment_type"
      expr: employment_type
      comment: "Full-time, part-time, or contract classification for workforce segmentation."
    - name: "department"
      expr: department
      comment: "Organizational department for headcount and cost analysis."
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-level workforce distribution analysis."
    - name: "location"
      expr: location
      comment: "Physical work location for geographic workforce distribution."
    - name: "employee_status"
      expr: employee_status
      comment: "Active, terminated, or on-leave status for workforce availability analysis."
    - name: "salary_grade"
      expr: salary_grade
      comment: "Salary grade band for compensation equity and budget analysis."
    - name: "organization_level"
      expr: organization_level
      comment: "Hierarchical level within the organization for span-of-control analysis."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year of hire for tenure cohort and attrition trend analysis."
    - name: "education_level"
      expr: education_level
      comment: "Highest education attained for talent pipeline and skills gap analysis."
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total number of distinct employees. Primary workforce sizing KPI used in capacity planning and budget allocation."
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employee_status = 'Active' THEN employee_id END)
      comment: "Count of currently active employees. Drives operational capacity and resource availability decisions."
    - name: "total_compensation_spend"
      expr: SUM(CAST(compensation_amount AS DOUBLE))
      comment: "Total compensation spend across all employees. Core financial KPI for workforce cost management and budget forecasting."
    - name: "avg_compensation_per_employee"
      expr: AVG(CAST(compensation_amount AS DOUBLE))
      comment: "Average compensation per employee. Used for compensation benchmarking and equity analysis across departments and grades."
    - name: "overtime_eligible_headcount"
      expr: COUNT(DISTINCT CASE WHEN overtime_eligible = TRUE THEN employee_id END)
      comment: "Number of employees eligible for overtime. Informs labor cost risk and scheduling decisions."
    - name: "union_member_headcount"
      expr: COUNT(DISTINCT CASE WHEN union_member_flag = TRUE THEN employee_id END)
      comment: "Count of union-member employees. Critical for labor relations, contract negotiations, and compliance tracking."
    - name: "itar_eligible_headcount"
      expr: COUNT(DISTINCT CASE WHEN itar_eligibility = TRUE THEN employee_id END)
      comment: "Count of ITAR-eligible employees. Directly governs which employees can work on export-controlled semiconductor programs."
    - name: "ear_eligible_headcount"
      expr: COUNT(DISTINCT CASE WHEN ear_eligibility = TRUE THEN employee_id END)
      comment: "Count of EAR-eligible employees. Governs access to export-controlled technology and informs compliance risk posture."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation structure and spend analytics. Enables executives to monitor total compensation cost, bonus accruals, equity grants, and pay equity across the workforce."
  source: "`vibe_semiconductors_v1`.`workforce`.`compensation`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (base, bonus, equity) for spend category analysis."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification for compensation cost segmentation."
    - name: "department_code"
      expr: department_code
      comment: "Department for compensation cost allocation and budget variance analysis."
    - name: "pay_grade"
      expr: pay_grade
      comment: "Pay grade band for compensation equity and market benchmarking."
    - name: "pay_frequency"
      expr: pay_frequency
      comment: "Payroll frequency (monthly, bi-weekly) for cash flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency compensation cost consolidation."
    - name: "compensation_status"
      expr: compensation_status
      comment: "Status of the compensation record for active vs. historical analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Effective year for compensation trend and annual review cycle analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type for shift-differential cost analysis in fab operations."
  measures:
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary_amount AS DOUBLE))
      comment: "Total base salary spend. Primary fixed labor cost KPI for budget planning and headcount ROI analysis."
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary_amount AS DOUBLE))
      comment: "Average base salary per compensation record. Used for pay equity analysis and market benchmarking."
    - name: "total_bonus_accrual"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus accrual across all employees. Drives variable compensation budget and P&L impact forecasting."
    - name: "avg_bonus_target_percent"
      expr: AVG(CAST(bonus_target_percent AS DOUBLE))
      comment: "Average bonus target as a percentage of base. Benchmarks incentive plan competitiveness across grades and departments."
    - name: "total_equity_grant_value"
      expr: SUM(CAST(equity_grant_amount AS DOUBLE))
      comment: "Total equity grant value issued. Key retention and long-term incentive cost metric for executive compensation review."
    - name: "total_shift_differential_cost"
      expr: SUM(CAST(shift_differential_amount AS DOUBLE))
      comment: "Total shift differential pay. Quantifies the premium cost of running 24/7 fab operations across multiple shifts."
    - name: "total_variable_compensation_actual"
      expr: SUM(CAST(variable_compensation_actual AS DOUBLE))
      comment: "Total actual variable compensation paid. Compared against target to assess incentive plan payout efficiency."
    - name: "total_variable_compensation_target"
      expr: SUM(CAST(variable_compensation_target AS DOUBLE))
      comment: "Total targeted variable compensation. Used as denominator for payout ratio analysis against actual variable pay."
    - name: "equity_eligible_headcount"
      expr: COUNT(DISTINCT CASE WHEN equity_grant_eligibility = TRUE THEN compensation_employee_id END)
      comment: "Number of employees eligible for equity grants. Informs retention risk and long-term incentive program scope."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labor hours and cost analytics for workforce productivity and billing. Provides operational visibility into regular, overtime, and billable hours to drive scheduling efficiency and cost control."
  source: "`vibe_semiconductors_v1`.`workforce`.`time_entry`"
  dimensions:
    - name: "labor_category"
      expr: labor_category
      comment: "Labor category (direct, indirect, R&D) for cost allocation and project charging."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for labor cost allocation to financial reporting units."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift identifier for shift-level productivity and overtime analysis."
    - name: "time_entry_type"
      expr: time_entry_type
      comment: "Type of time entry (regular, overtime, absence) for workforce availability analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for identifying unapproved time that may affect payroll accuracy."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status for tracking billable vs. non-billable labor cost recovery."
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence for workforce availability and leave liability analysis."
    - name: "work_date_month"
      expr: DATE_TRUNC('MONTH', work_date)
      comment: "Month of work for trend analysis of labor hours and costs."
    - name: "labor_grade"
      expr: labor_grade
      comment: "Labor grade for cost rate analysis and workforce mix optimization."
  measures:
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked across all employees. Primary workforce productivity and capacity utilization KPI."
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Total regular (non-overtime) hours. Baseline for workforce capacity planning and scheduling efficiency."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours logged. Signals workforce strain, scheduling gaps, and incremental labor cost risk."
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime as a percentage of total hours worked. Key efficiency KPI — high rates indicate understaffing or demand spikes in fab operations."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_amount AS DOUBLE))
      comment: "Total labor cost across all time entries. Core financial KPI for workforce cost management and project profitability."
    - name: "avg_labor_rate"
      expr: AVG(CAST(labor_rate AS DOUBLE))
      comment: "Average labor rate per hour. Used for cost benchmarking and workforce mix optimization decisions."
    - name: "total_absence_hours"
      expr: SUM(CAST(absence_duration_hours AS DOUBLE))
      comment: "Total hours lost to absence. Drives workforce availability planning and absence management interventions."
    - name: "total_shift_differential_hours"
      expr: SUM(CAST(shift_differential_hours AS DOUBLE))
      comment: "Total hours attracting shift differential pay. Quantifies the operational cost premium of running multi-shift fab operations."
    - name: "billable_hours"
      expr: SUM(CASE WHEN is_billable = TRUE THEN hours_worked ELSE 0 END)
      comment: "Total billable hours. Drives revenue recognition for NRE and customer-funded programs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, compliance, and effectiveness analytics. Tracks mandatory training adherence, assessment performance, and workforce skill development critical for fab safety and regulatory compliance."
  source: "`vibe_semiconductors_v1`.`workforce`.`training`"
  dimensions:
    - name: "training_category"
      expr: training_category
      comment: "Training category (safety, technical, compliance) for program effectiveness analysis."
    - name: "training_status"
      expr: training_status
      comment: "Completion status for identifying training gaps and compliance risk."
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Delivery method (in-person, e-learning, OJT) for training effectiveness benchmarking."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome for identifying training effectiveness and retraining needs."
    - name: "compliance_requirement"
      expr: compliance_requirement
      comment: "Regulatory or policy requirement driving the training for compliance gap analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for training pipeline and capacity planning."
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of completion for training throughput trend analysis."
  measures:
    - name: "total_training_enrollments"
      expr: COUNT(DISTINCT training_id)
      comment: "Total training enrollments. Baseline for training program reach and workforce development investment."
    - name: "mandatory_training_completions"
      expr: COUNT(DISTINCT CASE WHEN mandatory_flag = TRUE AND training_status = 'Completed' THEN training_id END)
      comment: "Count of completed mandatory training records. Critical compliance KPI — gaps expose the organization to regulatory and safety risk."
    - name: "mandatory_training_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mandatory_flag = TRUE AND training_status = 'Completed' THEN training_id END) / NULLIF(COUNT(DISTINCT CASE WHEN mandatory_flag = TRUE THEN training_id END), 0), 2)
      comment: "Percentage of mandatory training records completed. Executive compliance KPI — below threshold triggers regulatory risk escalation."
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across training completions. Measures training effectiveness and knowledge retention."
    - name: "training_pass_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail_status = 'Pass' THEN training_id END) / NULLIF(COUNT(DISTINCT training_id), 0), 2)
      comment: "Percentage of training attempts that result in a pass. Identifies courses with high failure rates requiring curriculum redesign."
    - name: "overdue_mandatory_training_count"
      expr: COUNT(DISTINCT CASE WHEN mandatory_flag = TRUE AND training_status != 'Completed' AND compliance_deadline < CURRENT_DATE() THEN training_id END)
      comment: "Count of overdue mandatory training records. Immediate action trigger for compliance remediation and audit risk mitigation."
    - name: "avg_assessment_pass_threshold"
      expr: AVG(CAST(assessment_pass_threshold AS DOUBLE))
      comment: "Average passing threshold across training programs. Benchmarks rigor of training standards across the organization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_safety_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workplace safety incident analytics for fab operations. Tracks incident rates, severity, and investigation status to drive safety culture improvements and OSHA compliance."
  source: "`vibe_semiconductors_v1`.`workforce`.`safety_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of safety event (injury, near-miss, chemical exposure) for risk categorization."
    - name: "incident_type"
      expr: incident_type
      comment: "Specific incident classification for root cause and prevention analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level for prioritizing corrective actions and resource allocation."
    - name: "incident_status"
      expr: incident_status
      comment: "Investigation and resolution status for open incident tracking."
    - name: "cleanroom_zone"
      expr: cleanroom_zone
      comment: "Cleanroom zone where the incident occurred for location-based safety risk analysis."
    - name: "injury_type"
      expr: injury_type
      comment: "Type of injury for ergonomic and safety program targeting."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause classification for systemic safety improvement programs."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of event for safety trend analysis and seasonal risk identification."
    - name: "regulatory_reporting_status"
      expr: regulatory_reporting_status
      comment: "OSHA/regulatory reporting status for compliance obligation tracking."
  measures:
    - name: "total_safety_incidents"
      expr: COUNT(DISTINCT safety_event_id)
      comment: "Total safety incidents recorded. Primary safety performance KPI used in executive safety dashboards and regulatory reporting."
    - name: "osha_recordable_incidents"
      expr: COUNT(DISTINCT CASE WHEN osha_recordable_flag = TRUE THEN safety_event_id END)
      comment: "Count of OSHA-recordable incidents. Directly drives OSHA 300 log compliance and regulatory filing obligations."
    - name: "near_miss_incidents"
      expr: COUNT(DISTINCT CASE WHEN near_miss_flag = TRUE THEN safety_event_id END)
      comment: "Count of near-miss events. Leading indicator of safety culture health — high near-miss reporting signals proactive safety behavior."
    - name: "total_incident_cost"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of safety incidents. Quantifies financial impact of safety failures for insurance and risk management decisions."
    - name: "avg_incident_cost"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average cost per safety incident. Benchmarks incident severity and informs safety investment ROI calculations."
    - name: "open_investigations_count"
      expr: COUNT(DISTINCT CASE WHEN investigation_status != 'Closed' THEN safety_event_id END)
      comment: "Count of incidents with open investigations. Operational KPI for safety team workload and regulatory response timeliness."
    - name: "osha_recordable_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN osha_recordable_flag = TRUE THEN safety_event_id END) / NULLIF(COUNT(DISTINCT safety_event_id), 0), 2)
      comment: "Percentage of incidents that are OSHA-recordable. Tracks severity profile of the incident portfolio over time."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_talent_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition pipeline and recruiting effectiveness analytics. Tracks open requisitions, time-to-fill, and recruiting spend to optimize workforce growth and critical role fulfillment."
  source: "`vibe_semiconductors_v1`.`workforce`.`talent_acquisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (open, filled, cancelled) for pipeline health monitoring."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (backfill, new headcount, contractor conversion) for workforce planning analysis."
    - name: "talent_acquisition_status"
      expr: talent_acquisition_status
      comment: "Overall acquisition status for funnel conversion analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Recruiting source channel for cost-per-hire and channel effectiveness analysis."
    - name: "priority"
      expr: priority
      comment: "Requisition priority for resource allocation and time-to-fill SLA management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency recruiting budget analysis."
    - name: "posted_month"
      expr: DATE_TRUNC('MONTH', posted_timestamp)
      comment: "Month requisition was posted for recruiting pipeline trend analysis."
    - name: "job_profile_name"
      expr: job_profile_name
      comment: "Job profile for role-level hiring velocity and market availability analysis."
  measures:
    - name: "total_open_requisitions"
      expr: COUNT(DISTINCT CASE WHEN requisition_status = 'Open' THEN talent_acquisition_id END)
      comment: "Total open job requisitions. Primary talent pipeline KPI — high open counts signal capacity risk for fab operations."
    - name: "total_requisitions"
      expr: COUNT(DISTINCT talent_acquisition_id)
      comment: "Total requisitions across all statuses. Baseline for recruiting volume and workforce growth rate analysis."
    - name: "total_recruiting_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total recruiting budget allocated. Drives cost-per-hire analysis and recruiting investment efficiency."
    - name: "avg_recruiting_budget_per_req"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average recruiting budget per requisition. Benchmarks recruiting investment by role type and priority."
    - name: "confidential_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN is_confidential = TRUE THEN talent_acquisition_id END)
      comment: "Count of confidential requisitions. Tracks sensitive executive and strategic hiring activity requiring restricted access."
    - name: "fill_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN requisition_status = 'Filled' THEN talent_acquisition_id END) / NULLIF(COUNT(DISTINCT talent_acquisition_id), 0), 2)
      comment: "Percentage of requisitions successfully filled. Core recruiting effectiveness KPI for workforce planning and capacity management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce certification and qualification compliance analytics. Tracks active certifications, expiry risk, and regulatory mandate coverage critical for fab operator compliance and audit readiness."
  source: "`vibe_semiconductors_v1`.`workforce`.`workforce_qualification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (safety, technical, regulatory) for compliance coverage analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status for active vs. expired certification tracking."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Certifying authority for credential validity and renewal source analysis."
    - name: "workforce_qualification_status"
      expr: workforce_qualification_status
      comment: "Overall record status for active qualification portfolio management."
    - name: "scope"
      expr: scope
      comment: "Scope of qualification (process, equipment, safety) for coverage gap analysis."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year of expiry for renewal pipeline planning and compliance risk forecasting."
  measures:
    - name: "active_qualifications"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN workforce_qualification_id END)
      comment: "Count of currently active qualifications. Baseline for workforce compliance coverage and audit readiness."
    - name: "expiring_qualifications_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN workforce_qualification_id END)
      comment: "Qualifications expiring within 90 days. Proactive compliance risk KPI — triggers renewal workflows before regulatory gaps occur."
    - name: "expired_qualifications"
      expr: COUNT(DISTINCT CASE WHEN expiry_date < CURRENT_DATE() AND is_active = TRUE THEN workforce_qualification_id END)
      comment: "Count of expired but still-active qualifications. Critical compliance gap metric requiring immediate remediation."
    - name: "regulatory_mandate_qualifications"
      expr: COUNT(DISTINCT CASE WHEN regulatory_mandate_flag = TRUE THEN workforce_qualification_id END)
      comment: "Count of qualifications driven by regulatory mandate. Scopes the compliance obligation portfolio for audit and regulatory reporting."
    - name: "renewal_required_count"
      expr: COUNT(DISTINCT CASE WHEN renewal_required = TRUE THEN workforce_qualification_id END)
      comment: "Count of qualifications requiring renewal. Drives renewal workload planning and training resource allocation."
    - name: "qualification_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_active = TRUE AND expiry_date >= CURRENT_DATE() THEN workforce_qualification_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_active = TRUE THEN workforce_qualification_id END), 0), 2)
      comment: "Percentage of active qualifications that are current (not expired). Executive compliance health KPI for regulatory audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_fab_operator_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fab operator qualification and tool certification analytics. Tracks operator readiness, qualification coverage, and expiry risk for critical fab equipment to ensure production continuity and safety compliance."
  source: "`vibe_semiconductors_v1`.`workforce`.`fab_operator_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (qualified, suspended, expired) for operator readiness analysis."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (initial, requalification, cross-training) for training program analysis."
    - name: "qualification_level"
      expr: qualification_level
      comment: "Proficiency level for operator capability tiering and advanced task assignment."
    - name: "equipment_group"
      expr: equipment_group
      comment: "Equipment group for cross-training coverage and single-point-of-failure risk analysis."
    - name: "skill_category"
      expr: skill_category
      comment: "Skill category for workforce capability gap analysis by process area."
    - name: "process_step_code"
      expr: process_step_code
      comment: "Process step for operator coverage analysis at critical fab process steps."
    - name: "shift_qualification"
      expr: shift_qualification
      comment: "Shift for which the operator is qualified — critical for 24/7 fab coverage planning."
    - name: "certified_year"
      expr: DATE_TRUNC('YEAR', certified_date)
      comment: "Year of certification for qualification cohort and renewal cycle analysis."
  measures:
    - name: "total_qualified_operators"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' AND is_active = TRUE THEN employee_id END)
      comment: "Total currently qualified and active fab operators. Primary production capacity KPI — insufficient qualified operators halt fab operations."
    - name: "suspended_operator_count"
      expr: COUNT(DISTINCT CASE WHEN suspension_flag = TRUE THEN fab_operator_qualification_id END)
      comment: "Count of suspended operator qualifications. Operational risk KPI — suspended operators reduce available capacity and may signal safety issues."
    - name: "expiring_qualifications_60_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 60) THEN fab_operator_qualification_id END)
      comment: "Operator qualifications expiring within 60 days. Proactive capacity risk KPI — triggers requalification scheduling before production impact."
    - name: "total_qualification_records"
      expr: COUNT(DISTINCT fab_operator_qualification_id)
      comment: "Total operator qualification records. Baseline for qualification portfolio size and cross-training coverage analysis."
    - name: "active_qualification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_active = TRUE THEN fab_operator_qualification_id END) / NULLIF(COUNT(DISTINCT fab_operator_qualification_id), 0), 2)
      comment: "Percentage of qualification records that are currently active. Tracks qualification portfolio health and requalification program effectiveness."
    - name: "overdue_requalification_count"
      expr: COUNT(DISTINCT CASE WHEN requalification_due_date < CURRENT_DATE() AND is_active = TRUE THEN fab_operator_qualification_id END)
      comment: "Count of overdue requalifications. Critical compliance and safety KPI — overdue requalifications expose the fab to audit findings and safety risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and labor cost analytics for fab operations. Tracks scheduled hours, overtime authorization, and labor cost by shift to optimize 24/7 fab staffing efficiency."
  source: "`vibe_semiconductors_v1`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, swing, night) for shift-level cost and productivity analysis."
    - name: "shift_schedule_status"
      expr: shift_schedule_status
      comment: "Schedule status for active vs. cancelled shift tracking."
    - name: "work_area"
      expr: work_area
      comment: "Work area within the fab for area-level staffing coverage analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for shift labor cost allocation to financial reporting."
    - name: "schedule_month"
      expr: DATE_TRUNC('MONTH', schedule_date)
      comment: "Month of schedule for labor cost trend and staffing level analysis."
  measures:
    - name: "total_scheduled_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total scheduled labor cost across all shifts. Core fab operations cost KPI for budget variance and workforce cost management."
    - name: "avg_labor_cost_per_shift"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per shift schedule record. Benchmarks shift cost efficiency and informs staffing model optimization."
    - name: "total_overtime_hours_scheduled"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours scheduled. Signals chronic understaffing or demand spikes requiring headcount or scheduling intervention."
    - name: "overtime_authorized_shifts"
      expr: COUNT(DISTINCT CASE WHEN overtime_authorized = TRUE THEN shift_schedule_id END)
      comment: "Count of shifts with authorized overtime. Tracks management-approved overtime for budget accountability and labor cost control."
    - name: "overtime_authorization_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN overtime_authorized = TRUE THEN shift_schedule_id END) / NULLIF(COUNT(DISTINCT shift_schedule_id), 0), 2)
      comment: "Percentage of shifts with authorized overtime. High rates indicate structural understaffing requiring headcount investment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_cleanroom_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cleanroom access control and compliance analytics. Tracks active access grants, export control compliance, and safety induction status to manage fab security and regulatory obligations."
  source: "`vibe_semiconductors_v1`.`workforce`.`cleanroom_access`"
  dimensions:
    - name: "access_level"
      expr: access_level
      comment: "Access level granted for tiered cleanroom access management."
    - name: "cleanroom_access_status"
      expr: cleanroom_access_status
      comment: "Current access status (active, revoked, expired) for access portfolio management."
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom class for access control by contamination sensitivity."
    - name: "zone"
      expr: zone
      comment: "Cleanroom zone for granular access control and occupancy analysis."
    - name: "export_control_category"
      expr: export_control_category
      comment: "Export control classification for ITAR/EAR access restriction compliance."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status for access eligibility compliance tracking."
    - name: "granted_year"
      expr: DATE_TRUNC('YEAR', granted_date)
      comment: "Year access was granted for access lifecycle and renewal trend analysis."
  measures:
    - name: "active_access_grants"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN cleanroom_access_id END)
      comment: "Total active cleanroom access grants. Primary security KPI for access portfolio management and audit compliance."
    - name: "temporary_access_grants"
      expr: COUNT(DISTINCT CASE WHEN is_temporary = TRUE AND is_active = TRUE THEN cleanroom_access_id END)
      comment: "Count of active temporary access grants. Tracks short-term access risk and ensures timely revocation of temporary permissions."
    - name: "foreign_national_access_count"
      expr: COUNT(DISTINCT CASE WHEN foreign_national = TRUE AND is_active = TRUE THEN cleanroom_access_id END)
      comment: "Count of active access grants for foreign nationals. Critical export control compliance KPI for ITAR/EAR technology access management."
    - name: "ehs_cleared_access_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ehs_clearance_status = TRUE AND is_active = TRUE THEN cleanroom_access_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_active = TRUE THEN cleanroom_access_id END), 0), 2)
      comment: "Percentage of active access holders with current EHS clearance. Safety compliance KPI — below 100% indicates uncleared personnel with active fab access."
    - name: "safety_induction_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN safety_induction_completed = TRUE AND is_active = TRUE THEN cleanroom_access_id END) / NULLIF(COUNT(DISTINCT CASE WHEN is_active = TRUE THEN cleanroom_access_id END), 0), 2)
      comment: "Percentage of active access holders who have completed safety induction. Regulatory compliance KPI for fab safety program adherence."
    - name: "expiring_access_30_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_timestamp BETWEEN CURRENT_TIMESTAMP() AND TIMESTAMPADD(DAY, 30, CURRENT_TIMESTAMP()) AND is_active = TRUE THEN cleanroom_access_id END)
      comment: "Access grants expiring within 30 days. Proactive security KPI to prevent unauthorized access lapses or unplanned production disruptions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_employment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce movement and attrition analytics. Tracks hiring, termination, promotion, and transfer events to measure organizational agility, attrition risk, and compensation change velocity."
  source: "`vibe_semiconductors_v1`.`workforce`.`employment_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of employment event (hire, termination, promotion, transfer) for workforce movement analysis."
    - name: "event_status"
      expr: event_status
      comment: "Processing status of the event for workflow completion tracking."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the event — critical for voluntary vs. involuntary termination analysis."
    - name: "new_organization"
      expr: new_organization
      comment: "Destination organization for transfer and promotion flow analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for compensation change amount analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of event for workforce movement trend and attrition rate analysis."
  measures:
    - name: "total_employment_events"
      expr: COUNT(DISTINCT employment_event_id)
      comment: "Total employment events processed. Baseline for workforce movement volume and HR operational workload."
    - name: "termination_events"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Termination' THEN employment_event_id END)
      comment: "Count of termination events. Primary attrition KPI — high termination counts in critical fab roles signal retention risk."
    - name: "promotion_events"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Promotion' THEN employment_event_id END)
      comment: "Count of promotion events. Tracks internal career mobility and talent development program effectiveness."
    - name: "total_compensation_change_value"
      expr: SUM(CAST(compensation_change_amount AS DOUBLE))
      comment: "Total compensation change amount across all employment events. Quantifies the financial impact of workforce movements on the compensation budget."
    - name: "avg_compensation_change_per_event"
      expr: AVG(CAST(compensation_change_amount AS DOUBLE))
      comment: "Average compensation change per employment event. Benchmarks the magnitude of compensation adjustments for budget forecasting."
    - name: "hire_events"
      expr: COUNT(DISTINCT CASE WHEN event_type = 'Hire' THEN employment_event_id END)
      comment: "Count of new hire events. Tracks workforce growth rate and recruiting pipeline conversion effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_contractor_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor workforce cost and compliance analytics. Tracks contractor spend, engagement status, and compliance obligations to manage contingent workforce risk and cost in fab operations."
  source: "`vibe_semiconductors_v1`.`workforce`.`contractor_engagement`"
  dimensions:
    - name: "contractor_type"
      expr: contractor_type
      comment: "Type of contractor (staff augmentation, SOW, consulting) for spend category analysis."
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current engagement status for active contractor portfolio management."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Engagement model for contract structure and billing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency contractor spend consolidation."
    - name: "export_control_status"
      expr: export_control_status
      comment: "Export control compliance status for ITAR/EAR contractor access management."
    - name: "nda_status"
      expr: nda_status
      comment: "NDA execution status for IP protection compliance tracking."
    - name: "engagement_start_month"
      expr: DATE_TRUNC('MONTH', engagement_start_date)
      comment: "Month engagement started for contractor pipeline and spend trend analysis."
  measures:
    - name: "total_contractor_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contracted value across all contractor engagements. Core contingent workforce spend KPI for budget management and make-vs-buy decisions."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate_usd AS DOUBLE))
      comment: "Average contractor hourly rate in USD. Benchmarks contractor cost competitiveness and informs rate negotiation strategies."
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate across contractor engagements. Used for contractor cost benchmarking and agency rate management."
    - name: "active_contractor_engagements"
      expr: COUNT(DISTINCT CASE WHEN engagement_status = 'Active' THEN contractor_engagement_id END)
      comment: "Count of active contractor engagements. Tracks contingent workforce size for capacity planning and compliance scope."
    - name: "ear_contract_count"
      expr: COUNT(DISTINCT CASE WHEN is_ear_contract = TRUE THEN contractor_engagement_id END)
      comment: "Count of EAR-regulated contractor engagements. Scopes export control compliance obligations for the contingent workforce."
    - name: "itar_contract_count"
      expr: COUNT(DISTINCT CASE WHEN is_it_ar_contract = TRUE THEN contractor_engagement_id END)
      comment: "Count of ITAR-regulated contractor engagements. Critical compliance KPI for technology access control and export license management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`workforce_export_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export control compliance analytics for the workforce. Tracks ITAR/EAR eligibility, screening status, and authorization coverage to manage technology access risk in semiconductor operations."
  source: "`vibe_semiconductors_v1`.`workforce`.`export_control`"
  dimensions:
    - name: "export_control_status"
      expr: export_control_status
      comment: "Overall export control status for workforce compliance portfolio management."
    - name: "classification"
      expr: classification
      comment: "Export control classification for technology access tier analysis."
    - name: "itar_authorization_status"
      expr: itar_authorization_status
      comment: "ITAR authorization status for controlled technology access compliance."
    - name: "ear_license_status"
      expr: ear_license_status
      comment: "EAR license status for export-controlled technology access management."
    - name: "nationality"
      expr: nationality
      comment: "Employee nationality for export control jurisdiction and license requirement analysis."
    - name: "visa_type"
      expr: visa_type
      comment: "Visa type for deemed export compliance and technology access restriction analysis."
    - name: "screening_year"
      expr: DATE_TRUNC('YEAR', screening_date)
      comment: "Year of screening for rescreening cycle compliance tracking."
  measures:
    - name: "total_screened_employees"
      expr: COUNT(DISTINCT export_employee_id)
      comment: "Total employees with export control screening records. Baseline for export control program coverage and compliance scope."
    - name: "itar_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN itar_eligible_flag = TRUE THEN export_employee_id END)
      comment: "Count of ITAR-eligible employees. Governs which employees can access ITAR-controlled semiconductor technology and programs."
    - name: "ear_license_required_count"
      expr: COUNT(DISTINCT CASE WHEN ear_license_required = TRUE THEN export_employee_id END)
      comment: "Count of employees requiring EAR licenses. Scopes the license management workload and compliance obligation portfolio."
    - name: "overdue_rescreening_count"
      expr: COUNT(DISTINCT CASE WHEN periodic_rescreening_due_date < CURRENT_DATE() THEN export_employee_id END)
      comment: "Count of employees overdue for periodic rescreening. Critical compliance risk KPI — overdue screenings expose the organization to export violation liability."
    - name: "itar_eligible_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN itar_eligible_flag = TRUE THEN export_employee_id END) / NULLIF(COUNT(DISTINCT export_employee_id), 0), 2)
      comment: "Percentage of screened employees who are ITAR-eligible. Tracks the available pool for ITAR-controlled program staffing."
$$;