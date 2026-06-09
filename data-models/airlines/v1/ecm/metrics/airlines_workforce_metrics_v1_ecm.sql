-- Metric views for domain: workforce | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee headcount, tenure, and workforce composition metrics for strategic workforce planning and organizational health monitoring."
  source: "`airlines_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (Active, Terminated, On Leave, etc.) for workforce segmentation"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (Full-Time, Part-Time, Contract, etc.) for workforce composition analysis"
    - name: "department_code"
      expr: department_code
      comment: "Department code for organizational unit analysis"
    - name: "home_base_airport_code"
      expr: home_base_airport_code
      comment: "Home base airport code for geographic workforce distribution analysis"
    - name: "salary_grade"
      expr: salary_grade
      comment: "Salary grade for compensation structure analysis"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Most recent performance rating for talent management analysis"
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Union membership status for labor relations analysis"
    - name: "nationality"
      expr: nationality
      comment: "Employee nationality for diversity and compliance reporting"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort and retention analysis"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for hiring trend analysis"
    - name: "medical_certificate_status"
      expr: medical_certificate_status
      comment: "Medical certificate status for crew readiness monitoring"
    - name: "work_permit_status"
      expr: work_permit_status
      comment: "Work permit status for compliance and workforce planning"
  measures:
    - name: "total_employees"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total distinct employee count - primary headcount metric for workforce planning and budgeting"
    - name: "avg_tenure_years"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date) / 365.25)
      comment: "Average employee tenure in years - key retention and organizational stability metric"
    - name: "union_membership_rate"
      expr: AVG(CASE WHEN union_membership_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of employees with union membership - critical for labor relations strategy"
    - name: "medical_compliance_rate"
      expr: AVG(CASE WHEN medical_certificate_status = 'Valid' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of employees with valid medical certificates - operational readiness KPI for crew scheduling"
    - name: "work_permit_compliance_rate"
      expr: AVG(CASE WHEN work_permit_status = 'Valid' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of employees with valid work permits - regulatory compliance metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`workforce_absence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Absence and leave metrics for workforce availability, operational impact, and employee wellbeing monitoring."
  source: "`airlines_ecm`.`workforce`.`absence_record`"
  dimensions:
    - name: "absence_category"
      expr: absence_category
      comment: "High-level absence category for strategic absence pattern analysis"
    - name: "absence_type_code"
      expr: absence_type_code
      comment: "Detailed absence type code for granular absence analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for absence management workflow monitoring"
    - name: "crew_availability_impact_flag"
      expr: crew_availability_impact_flag
      comment: "Flag indicating impact on crew availability for operational planning"
    - name: "fdp_impact_flag"
      expr: fdp_impact_flag
      comment: "Flag indicating impact on flight duty period for regulatory compliance"
    - name: "medical_certificate_required_flag"
      expr: medical_certificate_required_flag
      comment: "Flag indicating medical certificate requirement for compliance tracking"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Flag indicating regulatory reporting requirement for compliance management"
    - name: "absence_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of absence start for seasonal and trend analysis"
    - name: "absence_start_year"
      expr: YEAR(start_date)
      comment: "Year of absence start for year-over-year comparison"
  measures:
    - name: "total_absence_records"
      expr: COUNT(DISTINCT absence_record_id)
      comment: "Total distinct absence records - volume metric for absence management workload"
    - name: "total_absence_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total absence days - primary metric for workforce availability and productivity impact"
    - name: "total_absence_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total absence hours - granular metric for operational scheduling impact"
    - name: "avg_absence_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average absence duration in days - indicator of absence severity and employee health trends"
    - name: "crew_impact_absence_rate"
      expr: AVG(CASE WHEN crew_availability_impact_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of absences impacting crew availability - critical operational readiness metric"
    - name: "fdp_impact_absence_rate"
      expr: AVG(CASE WHEN fdp_impact_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of absences impacting flight duty periods - regulatory compliance and safety metric"
    - name: "medical_certificate_compliance_rate"
      expr: AVG(CASE WHEN medical_certificate_required_flag = TRUE AND medical_certificate_received_flag = TRUE THEN 1.0 WHEN medical_certificate_required_flag = TRUE THEN 0.0 ELSE NULL END)
      comment: "Proportion of required medical certificates received - compliance and process efficiency metric"
    - name: "avg_pay_percentage"
      expr: AVG(CAST(pay_percentage AS DOUBLE))
      comment: "Average pay percentage during absence - financial impact metric for payroll planning"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`workforce_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training completion, compliance, and investment metrics for workforce development, regulatory compliance, and capability building."
  source: "`airlines_ecm`.`workforce`.`training_record`"
  dimensions:
    - name: "training_status"
      expr: training_status
      comment: "Training status for completion tracking and compliance monitoring"
    - name: "training_type"
      expr: training_type
      comment: "Training type for program portfolio analysis"
    - name: "training_result"
      expr: training_result
      comment: "Training result (Pass/Fail) for quality and effectiveness analysis"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Training delivery method for cost and efficiency analysis"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Mandatory training flag for compliance prioritization"
    - name: "recurrent_flag"
      expr: recurrent_flag
      comment: "Recurrent training flag for ongoing compliance tracking"
    - name: "external_provider_flag"
      expr: external_provider_flag
      comment: "External provider flag for vendor management and cost analysis"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority for compliance reporting segmentation"
    - name: "aircraft_type_code"
      expr: aircraft_type_code
      comment: "Aircraft type code for fleet-specific training analysis"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month of training completion for trend and capacity analysis"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of training completion for annual planning and budgeting"
  measures:
    - name: "total_training_records"
      expr: COUNT(DISTINCT training_record_id)
      comment: "Total distinct training records - volume metric for training program scale and administration workload"
    - name: "total_training_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total training hours delivered - primary metric for workforce development investment and capacity utilization"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total training cost - financial metric for L&D budget management and ROI analysis"
    - name: "avg_training_cost_per_record"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average training cost per record - efficiency metric for cost benchmarking and vendor negotiation"
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average training duration in hours - efficiency metric for program design and scheduling"
    - name: "training_completion_rate"
      expr: AVG(CASE WHEN training_status = 'Completed' THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of training records completed - compliance and program effectiveness metric"
    - name: "training_pass_rate"
      expr: AVG(CASE WHEN training_result = 'Pass' THEN 1.0 WHEN training_result = 'Fail' THEN 0.0 ELSE NULL END)
      comment: "Proportion of completed training passed - quality and effectiveness metric for program design"
    - name: "avg_training_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average training score - quality metric for learner performance and program effectiveness"
    - name: "mandatory_training_compliance_rate"
      expr: AVG(CASE WHEN mandatory_flag = TRUE AND training_status = 'Completed' THEN 1.0 WHEN mandatory_flag = TRUE THEN 0.0 ELSE NULL END)
      comment: "Proportion of mandatory training completed - critical regulatory compliance metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`workforce_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll cost, compensation structure, and labor expense metrics for financial planning, budgeting, and cost management."
  source: "`airlines_ecm`.`workforce`.`payslip`"
  dimensions:
    - name: "payslip_status"
      expr: payslip_status
      comment: "Payslip status for payroll processing monitoring"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for disbursement efficiency analysis"
    - name: "employee_type"
      expr: employee_type
      comment: "Employee type for labor cost segmentation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency payroll analysis"
    - name: "pay_period_month"
      expr: DATE_TRUNC('MONTH', pay_period_end_date)
      comment: "Pay period month for monthly labor cost trending"
    - name: "pay_period_year"
      expr: YEAR(pay_period_end_date)
      comment: "Pay period year for annual budgeting and forecasting"
  measures:
    - name: "total_payslips"
      expr: COUNT(DISTINCT payslip_id)
      comment: "Total distinct payslips - volume metric for payroll processing workload"
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay AS DOUBLE))
      comment: "Total gross pay - primary labor cost metric for financial planning and budgeting"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay AS DOUBLE))
      comment: "Total net pay - cash disbursement metric for treasury and liquidity management"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Total base salary - fixed labor cost metric for structural cost analysis"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_pay AS DOUBLE))
      comment: "Total overtime pay - variable labor cost metric for operational efficiency and scheduling optimization"
    - name: "total_bonus"
      expr: SUM(CAST(bonus AS DOUBLE))
      comment: "Total bonus payments - incentive compensation metric for performance management and cost control"
    - name: "total_flying_pay"
      expr: SUM(CAST(flying_pay AS DOUBLE))
      comment: "Total flying pay - aviation-specific variable compensation metric for crew cost management"
    - name: "total_per_diem"
      expr: SUM(CAST(per_diem AS DOUBLE))
      comment: "Total per diem payments - travel allowance metric for operational cost analysis"
    - name: "total_deductions"
      expr: SUM(CAST(total_deductions AS DOUBLE))
      comment: "Total deductions - compliance and benefits administration metric"
    - name: "total_employer_payroll_tax"
      expr: SUM(CAST(employer_payroll_tax AS DOUBLE))
      comment: "Total employer payroll tax - statutory labor cost metric for tax planning and compliance"
    - name: "total_employer_pension_contribution"
      expr: SUM(CAST(employer_pension_contribution AS DOUBLE))
      comment: "Total employer pension contributions - retirement benefits cost metric for long-term liability management"
    - name: "avg_gross_pay"
      expr: AVG(CAST(gross_pay AS DOUBLE))
      comment: "Average gross pay per payslip - compensation benchmarking metric for market competitiveness"
    - name: "avg_overtime_hours"
      expr: AVG(CAST(overtime_hours AS DOUBLE))
      comment: "Average overtime hours per payslip - operational efficiency metric for workforce planning"
    - name: "avg_block_hours"
      expr: AVG(CAST(block_hours AS DOUBLE))
      comment: "Average block hours per payslip - crew utilization metric for productivity and scheduling efficiency"
    - name: "overtime_pay_ratio"
      expr: SUM(CAST(overtime_pay AS DOUBLE)) / NULLIF(SUM(CAST(gross_pay AS DOUBLE)), 0)
      comment: "Overtime pay as proportion of gross pay - cost structure metric for operational efficiency assessment"
    - name: "employer_burden_rate"
      expr: (SUM(CAST(employer_payroll_tax AS DOUBLE)) + SUM(CAST(employer_pension_contribution AS DOUBLE)) + SUM(CAST(employer_health_contribution AS DOUBLE))) / NULLIF(SUM(CAST(gross_pay AS DOUBLE)), 0)
      comment: "Employer burden as proportion of gross pay - total labor cost metric for financial modeling and pricing"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`workforce_recruitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruitment pipeline, hiring velocity, and talent acquisition effectiveness metrics for workforce planning and TA operations."
  source: "`airlines_ecm`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Requisition status for pipeline stage analysis"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Requisition type (New Hire, Replacement, etc.) for demand driver analysis"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type for workforce mix planning"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource allocation and SLA management"
    - name: "recruitment_channel"
      expr: recruitment_channel
      comment: "Recruitment channel for sourcing effectiveness analysis"
    - name: "diversity_initiative_flag"
      expr: diversity_initiative_flag
      comment: "Diversity initiative flag for DEI program tracking"
    - name: "external_posting_flag"
      expr: external_posting_flag
      comment: "External posting flag for internal vs external hiring analysis"
    - name: "relocation_assistance_flag"
      expr: relocation_assistance_flag
      comment: "Relocation assistance flag for cost and geographic mobility analysis"
    - name: "remote_work_eligible_flag"
      expr: remote_work_eligible_flag
      comment: "Remote work eligibility flag for flexible work program analysis"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_start_date)
      comment: "Month of posting start for hiring demand trending"
    - name: "posting_year"
      expr: YEAR(posting_start_date)
      comment: "Year of posting start for annual hiring planning"
  measures:
    - name: "total_requisitions"
      expr: COUNT(DISTINCT recruitment_requisition_id)
      comment: "Total distinct requisitions - hiring demand volume metric for capacity planning"
    - name: "total_vacancies"
      expr: SUM(CAST(number_of_vacancies AS DOUBLE))
      comment: "Total number of vacancies - headcount gap metric for workforce planning and budgeting"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved recruitment budget - financial commitment metric for TA investment planning"
    - name: "avg_approved_budget_per_requisition"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per requisition - cost benchmarking metric for budget allocation"
    - name: "diversity_initiative_rate"
      expr: AVG(CASE WHEN diversity_initiative_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of requisitions tied to diversity initiatives - DEI program effectiveness metric"
    - name: "external_posting_rate"
      expr: AVG(CASE WHEN external_posting_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of requisitions posted externally - internal mobility vs external hiring metric"
    - name: "relocation_assistance_rate"
      expr: AVG(CASE WHEN relocation_assistance_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of requisitions offering relocation - geographic mobility and cost metric"
    - name: "remote_work_eligible_rate"
      expr: AVG(CASE WHEN remote_work_eligible_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of requisitions eligible for remote work - flexible work program adoption metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance management, talent assessment, and development planning metrics for organizational capability and succession planning."
  source: "`airlines_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_status"
      expr: review_status
      comment: "Review status for performance cycle completion tracking"
    - name: "review_cycle_type"
      expr: review_cycle_type
      comment: "Review cycle type (Annual, Mid-Year, Probation, etc.) for program segmentation"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating for talent distribution analysis"
    - name: "promotion_recommendation_flag"
      expr: promotion_recommendation_flag
      comment: "Promotion recommendation flag for succession planning and talent pipeline"
    - name: "performance_improvement_plan_flag"
      expr: performance_improvement_plan_flag
      comment: "Performance improvement plan flag for underperformance management"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Dispute flag for employee relations and process quality monitoring"
    - name: "employee_acknowledgement_flag"
      expr: employee_acknowledgement_flag
      comment: "Employee acknowledgement flag for process compliance tracking"
    - name: "promotion_readiness_timeline"
      expr: promotion_readiness_timeline
      comment: "Promotion readiness timeline for succession planning horizon"
    - name: "staff_category"
      expr: staff_category
      comment: "Staff category for workforce segment analysis"
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month of review for performance cycle tracking"
    - name: "review_year"
      expr: YEAR(review_date)
      comment: "Year of review for annual talent assessment"
  measures:
    - name: "total_performance_reviews"
      expr: COUNT(DISTINCT performance_review_id)
      comment: "Total distinct performance reviews - volume metric for performance management program scale"
    - name: "avg_overall_rating_score"
      expr: AVG(CAST(overall_rating_score AS DOUBLE))
      comment: "Average overall rating score - aggregate performance metric for organizational capability assessment"
    - name: "avg_objective_achievement_score"
      expr: AVG(CAST(objective_achievement_score AS DOUBLE))
      comment: "Average objective achievement score - goal attainment metric for performance culture effectiveness"
    - name: "promotion_recommendation_rate"
      expr: AVG(CASE WHEN promotion_recommendation_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of reviews with promotion recommendation - talent pipeline health metric for succession planning"
    - name: "performance_improvement_plan_rate"
      expr: AVG(CASE WHEN performance_improvement_plan_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of reviews triggering performance improvement plans - underperformance prevalence metric"
    - name: "review_dispute_rate"
      expr: AVG(CASE WHEN dispute_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of reviews disputed - process quality and employee relations metric"
    - name: "employee_acknowledgement_rate"
      expr: AVG(CASE WHEN employee_acknowledgement_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of reviews acknowledged by employee - process compliance and engagement metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`workforce_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee relations, grievance resolution, and labor relations metrics for organizational health and risk management."
  source: "`airlines_ecm`.`workforce`.`grievance`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Grievance case status for resolution pipeline tracking"
    - name: "grievance_type"
      expr: grievance_type
      comment: "Grievance type for issue categorization and root cause analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for resource allocation and escalation management"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Resolution outcome for effectiveness and fairness analysis"
    - name: "union_representation_flag"
      expr: union_representation_flag
      comment: "Union representation flag for labor relations complexity analysis"
    - name: "arbitration_flag"
      expr: arbitration_flag
      comment: "Arbitration flag for escalation and legal risk tracking"
    - name: "legal_counsel_involved_flag"
      expr: legal_counsel_involved_flag
      comment: "Legal counsel involvement flag for legal risk and cost analysis"
    - name: "confidentiality_flag"
      expr: confidentiality_flag
      comment: "Confidentiality flag for sensitive case management"
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month of grievance filing for trend and seasonality analysis"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year of grievance filing for annual employee relations assessment"
  measures:
    - name: "total_grievances"
      expr: COUNT(DISTINCT grievance_id)
      comment: "Total distinct grievances - volume metric for employee relations health and organizational climate"
    - name: "total_financial_settlements"
      expr: SUM(CAST(financial_settlement_amount AS DOUBLE))
      comment: "Total financial settlement amounts - cost of grievances metric for risk management and budgeting"
    - name: "avg_financial_settlement"
      expr: AVG(CAST(financial_settlement_amount AS DOUBLE))
      comment: "Average financial settlement per grievance - cost severity metric for risk assessment"
    - name: "union_representation_rate"
      expr: AVG(CASE WHEN union_representation_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of grievances with union representation - labor relations complexity metric"
    - name: "arbitration_rate"
      expr: AVG(CASE WHEN arbitration_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of grievances escalated to arbitration - resolution effectiveness and legal risk metric"
    - name: "legal_counsel_involvement_rate"
      expr: AVG(CASE WHEN legal_counsel_involved_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of grievances involving legal counsel - legal risk and cost metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`workforce_type_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilot type rating currency, fleet qualification, and crew capability metrics for operational readiness and fleet planning."
  source: "`airlines_ecm`.`workforce`.`type_rating`"
  dimensions:
    - name: "validity_status"
      expr: validity_status
      comment: "Type rating validity status for crew scheduling eligibility"
    - name: "rating_category"
      expr: rating_category
      comment: "Rating category for qualification type analysis"
    - name: "crew_scheduling_eligible_flag"
      expr: crew_scheduling_eligible_flag
      comment: "Crew scheduling eligibility flag for operational capacity planning"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Issuing authority for regulatory compliance segmentation"
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Issuing country code for international operations analysis"
    - name: "fleet_transition_source_type"
      expr: fleet_transition_source_type
      comment: "Fleet transition source type for training program effectiveness"
    - name: "simulator_qualification_level"
      expr: simulator_qualification_level
      comment: "Simulator qualification level for training resource planning"
    - name: "initial_issue_year"
      expr: YEAR(initial_issue_date)
      comment: "Year of initial issue for cohort and retention analysis"
  measures:
    - name: "total_type_ratings"
      expr: COUNT(DISTINCT type_rating_id)
      comment: "Total distinct type ratings - crew qualification inventory metric for fleet capacity planning"
    - name: "total_pic_hours_on_type"
      expr: SUM(CAST(pic_hours_on_type AS DOUBLE))
      comment: "Total pilot-in-command hours on type - experience depth metric for safety and operational quality"
    - name: "total_flight_hours_on_type"
      expr: SUM(CAST(total_flight_hours_on_type AS DOUBLE))
      comment: "Total flight hours on type - aggregate experience metric for fleet capability assessment"
    - name: "avg_pic_hours_on_type"
      expr: AVG(CAST(pic_hours_on_type AS DOUBLE))
      comment: "Average pilot-in-command hours on type - crew experience metric for safety and quality benchmarking"
    - name: "avg_total_flight_hours_on_type"
      expr: AVG(CAST(total_flight_hours_on_type AS DOUBLE))
      comment: "Average total flight hours on type - crew proficiency metric for operational readiness"
    - name: "crew_scheduling_eligible_rate"
      expr: AVG(CASE WHEN crew_scheduling_eligible_flag = TRUE THEN 1.0 ELSE 0.0 END)
      comment: "Proportion of type ratings eligible for crew scheduling - operational capacity metric for flight planning"
    - name: "avg_transition_training_hours"
      expr: AVG(CAST(transition_training_hours AS DOUBLE))
      comment: "Average transition training hours - training efficiency metric for fleet transition planning"
$$;