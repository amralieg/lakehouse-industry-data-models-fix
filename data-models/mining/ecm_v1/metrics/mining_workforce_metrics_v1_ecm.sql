-- Metric views for domain: workforce | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core employee workforce metrics including headcount, FTE capacity, and demographic composition for strategic workforce planning and diversity reporting."
  source: "`mining_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on leave) for workforce segmentation"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (permanent, casual, fixed-term) for workforce composition analysis"
    - name: "department"
      expr: department
      comment: "Department assignment for organizational structure analysis"
    - name: "job_title"
      expr: job_title
      comment: "Job title for role-based workforce analysis"
    - name: "gender"
      expr: gender
      comment: "Gender for diversity and inclusion reporting"
    - name: "site_assignment"
      expr: site_assignment
      comment: "Site assignment for geographic workforce distribution"
    - name: "union_membership"
      expr: union_membership
      comment: "Union membership flag for industrial relations analysis"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for tenure and retention cohort analysis"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for recruitment trend analysis"
    - name: "medical_fitness_status"
      expr: medical_fitness_status
      comment: "Medical fitness status for workforce readiness monitoring"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee headcount for workforce size tracking"
    - name: "total_fte"
      expr: SUM(CAST(fte AS DOUBLE))
      comment: "Total full-time equivalent capacity for workforce planning and budgeting"
    - name: "avg_fte_per_employee"
      expr: AVG(CAST(fte AS DOUBLE))
      comment: "Average FTE per employee for part-time vs full-time workforce mix analysis"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_payroll`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll and compensation metrics including gross pay, overtime, allowances, and deductions for labor cost management and compliance reporting."
  source: "`mining_ecm`.`workforce`.`payroll_record`"
  dimensions:
    - name: "pay_period_start"
      expr: pay_period_start_date
      comment: "Pay period start date for time-series payroll analysis"
    - name: "pay_period_end"
      expr: pay_period_end_date
      comment: "Pay period end date for payroll cycle tracking"
    - name: "payment_date"
      expr: payment_date
      comment: "Actual payment date for cash flow and disbursement analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (bank transfer, check) for payment operations analysis"
    - name: "payroll_status"
      expr: payroll_status
      comment: "Payroll processing status for operational monitoring"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency payroll reporting"
    - name: "pay_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment month for monthly labor cost trending"
    - name: "pay_quarter"
      expr: DATE_TRUNC('QUARTER', payment_date)
      comment: "Payment quarter for quarterly labor cost reporting"
  measures:
    - name: "total_gross_pay"
      expr: SUM(CAST(gross_pay_amount AS DOUBLE))
      comment: "Total gross pay before deductions for labor cost analysis and budgeting"
    - name: "total_net_pay"
      expr: SUM(CAST(net_pay_amount AS DOUBLE))
      comment: "Total net pay after deductions for actual cash disbursement tracking"
    - name: "total_base_pay"
      expr: SUM(CAST(base_pay_amount AS DOUBLE))
      comment: "Total base pay excluding allowances and overtime for core labor cost tracking"
    - name: "total_overtime_pay"
      expr: SUM(CAST(overtime_amount AS DOUBLE))
      comment: "Total overtime pay for overtime cost management and fatigue risk correlation"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours worked for productivity and fatigue management"
    - name: "total_hours_worked"
      expr: SUM(CAST(hours_worked AS DOUBLE))
      comment: "Total hours worked for labor productivity and utilization analysis"
    - name: "total_site_allowance"
      expr: SUM(CAST(site_allowance_amount AS DOUBLE))
      comment: "Total site allowance paid for remote work cost tracking"
    - name: "total_fifo_allowance"
      expr: SUM(CAST(fifo_allowance_amount AS DOUBLE))
      comment: "Total FIFO allowance paid for fly-in-fly-out workforce cost management"
    - name: "total_tax_withheld"
      expr: SUM(CAST(tax_withheld_amount AS DOUBLE))
      comment: "Total tax withheld for tax compliance and remittance tracking"
    - name: "total_superannuation"
      expr: SUM(CAST(superannuation_amount AS DOUBLE))
      comment: "Total superannuation contributions for retirement benefit cost tracking"
    - name: "avg_gross_pay_per_employee"
      expr: AVG(CAST(gross_pay_amount AS DOUBLE))
      comment: "Average gross pay per payroll record for compensation benchmarking"
    - name: "overtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime hours as percentage of total hours for overtime intensity monitoring"
    - name: "payroll_record_count"
      expr: COUNT(payroll_record_id)
      comment: "Total payroll records processed for payroll operations volume tracking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_shift_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift scheduling and production metrics including headcount utilization, production performance, and safety compliance for operational efficiency and workforce deployment."
  source: "`mining_ecm`.`workforce`.`shift_schedule`"
  dimensions:
    - name: "shift_date"
      expr: DATE_TRUNC('DAY', scheduled_start_datetime)
      comment: "Shift date for daily operational analysis"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_datetime)
      comment: "Shift month for monthly production trending"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (day, night, swing) for shift pattern analysis"
    - name: "shift_status"
      expr: shift_status
      comment: "Shift status (scheduled, completed, cancelled) for operational tracking"
    - name: "production_area"
      expr: production_area
      comment: "Production area for area-based performance analysis"
    - name: "fatigue_risk_level"
      expr: fatigue_risk_level
      comment: "Fatigue risk level for safety and fatigue management"
    - name: "shift_priority"
      expr: shift_priority
      comment: "Shift priority for critical operations identification"
    - name: "safety_briefing_completed"
      expr: safety_briefing_completed
      comment: "Safety briefing completion flag for safety compliance monitoring"
    - name: "fatigue_risk_assessment_completed"
      expr: fatigue_risk_assessment_completed
      comment: "Fatigue risk assessment completion flag for fatigue management compliance"
  measures:
    - name: "total_shifts"
      expr: COUNT(shift_schedule_id)
      comment: "Total number of shifts scheduled for operational volume tracking"
    - name: "total_production_tonnes"
      expr: SUM(CAST(actual_production_tonnes AS DOUBLE))
      comment: "Total actual production in tonnes for production performance tracking"
    - name: "total_production_target_tonnes"
      expr: SUM(CAST(production_target_tonnes AS DOUBLE))
      comment: "Total production target in tonnes for target vs actual analysis"
    - name: "production_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_production_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(production_target_tonnes AS DOUBLE)), 0), 2)
      comment: "Production achievement rate as percentage of target for operational performance measurement"
    - name: "avg_equipment_availability_pct"
      expr: AVG(CAST(equipment_availability_percent AS DOUBLE))
      comment: "Average equipment availability percentage for asset utilization and maintenance effectiveness"
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_duration_hours AS DOUBLE))
      comment: "Total scheduled shift hours for labor capacity planning"
    - name: "avg_scheduled_hours_per_shift"
      expr: AVG(CAST(scheduled_duration_hours AS DOUBLE))
      comment: "Average scheduled hours per shift for shift pattern analysis"
    - name: "total_incidents"
      expr: SUM(CAST(incident_count AS BIGINT))
      comment: "Total incidents reported during shifts for safety performance tracking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training and competency development metrics including completion rates, assessment scores, and compliance for workforce capability and regulatory compliance."
  source: "`mining_ecm`.`workforce`.`training_enrolment`"
  dimensions:
    - name: "enrolment_date"
      expr: enrolment_date
      comment: "Enrolment date for training demand analysis"
    - name: "scheduled_training_date"
      expr: scheduled_training_date
      comment: "Scheduled training date for training calendar management"
    - name: "completion_date"
      expr: completion_date
      comment: "Completion date for training completion tracking"
    - name: "enrolment_status"
      expr: enrolment_status
      comment: "Enrolment status (enrolled, completed, cancelled) for training pipeline management"
    - name: "training_outcome"
      expr: training_outcome
      comment: "Training outcome (pass, fail, incomplete) for training effectiveness analysis"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Delivery method (classroom, online, on-site) for training delivery optimization"
    - name: "mandatory_training_flag"
      expr: mandatory_training_flag
      comment: "Mandatory training flag for compliance tracking"
    - name: "certificate_issued_flag"
      expr: certificate_issued_flag
      comment: "Certificate issued flag for certification tracking"
    - name: "refresher_training_flag"
      expr: refresher_training_flag
      comment: "Refresher training flag for recertification management"
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Training completion month for monthly training activity trending"
  measures:
    - name: "total_enrolments"
      expr: COUNT(training_enrolment_id)
      comment: "Total training enrolments for training volume and demand tracking"
    - name: "total_training_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total training cost for training investment and budget management"
    - name: "avg_training_cost_per_enrolment"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average training cost per enrolment for cost efficiency benchmarking"
    - name: "total_training_hours_completed"
      expr: SUM(CAST(training_hours_completed AS DOUBLE))
      comment: "Total training hours completed for training effort and investment tracking"
    - name: "total_training_hours_required"
      expr: SUM(CAST(training_hours_required AS DOUBLE))
      comment: "Total training hours required for training capacity planning"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score for training quality and effectiveness measurement"
    - name: "avg_attendance_pct"
      expr: AVG(CAST(attendance_percentage AS DOUBLE))
      comment: "Average attendance percentage for training engagement tracking"
    - name: "training_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(training_hours_completed AS DOUBLE)) / NULLIF(SUM(CAST(training_hours_required AS DOUBLE)), 0), 2)
      comment: "Training completion rate as percentage of required hours for compliance and progress tracking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_fatigue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fatigue risk management metrics including risk scores, assessment outcomes, and corrective actions for safety and regulatory compliance."
  source: "`mining_ecm`.`workforce`.`fatigue_record`"
  dimensions:
    - name: "assessment_date"
      expr: DATE_TRUNC('DAY', assessment_datetime)
      comment: "Assessment date for daily fatigue monitoring"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_datetime)
      comment: "Assessment month for monthly fatigue trend analysis"
    - name: "fatigue_risk_level"
      expr: fatigue_risk_level
      comment: "Fatigue risk level (low, medium, high, critical) for risk segmentation"
    - name: "assessment_outcome"
      expr: assessment_outcome
      comment: "Assessment outcome (fit for work, restricted, unfit) for workforce readiness tracking"
    - name: "assessment_method"
      expr: assessment_method
      comment: "Assessment method for assessment process analysis"
    - name: "assessment_trigger"
      expr: assessment_trigger
      comment: "Assessment trigger (routine, incident, supervisor request) for trigger pattern analysis"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for regulatory compliance monitoring"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Follow-up required flag for case management tracking"
    - name: "time_of_day_category"
      expr: time_of_day_category
      comment: "Time of day category for circadian rhythm analysis"
  measures:
    - name: "total_assessments"
      expr: COUNT(fatigue_record_id)
      comment: "Total fatigue assessments conducted for fatigue management program activity tracking"
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score for overall workforce fatigue level monitoring"
    - name: "avg_cumulative_hours_worked"
      expr: AVG(CAST(cumulative_hours_worked AS DOUBLE))
      comment: "Average cumulative hours worked for workload intensity analysis"
    - name: "avg_sleep_opportunity_hours"
      expr: AVG(CAST(sleep_opportunity_hours AS DOUBLE))
      comment: "Average sleep opportunity hours for rest adequacy monitoring"
    - name: "total_cumulative_hours_worked"
      expr: SUM(CAST(cumulative_hours_worked AS DOUBLE))
      comment: "Total cumulative hours worked for aggregate workload tracking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_medical_fitness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical fitness and health surveillance metrics including fitness outcomes, test results, and compliance for workforce health and safety management."
  source: "`mining_ecm`.`workforce`.`medical_fitness`"
  dimensions:
    - name: "assessment_date"
      expr: assessment_date
      comment: "Assessment date for medical surveillance scheduling"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Assessment month for monthly health surveillance trending"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Assessment type (pre-employment, periodic, post-incident) for assessment program management"
    - name: "fitness_outcome"
      expr: fitness_outcome
      comment: "Fitness outcome (fit, fit with restrictions, unfit) for workforce readiness tracking"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for regulatory compliance monitoring"
    - name: "drug_alcohol_test_result"
      expr: drug_alcohol_test_result
      comment: "Drug and alcohol test result for substance testing program monitoring"
    - name: "restriction_category"
      expr: restriction_category
      comment: "Restriction category for work restriction management"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Follow-up required flag for case management tracking"
  measures:
    - name: "total_assessments"
      expr: COUNT(medical_fitness_id)
      comment: "Total medical fitness assessments conducted for health surveillance program activity tracking"
    - name: "drug_alcohol_test_count"
      expr: SUM(CASE WHEN drug_alcohol_test_conducted = TRUE THEN 1 ELSE 0 END)
      comment: "Total drug and alcohol tests conducted for substance testing program volume tracking"
    - name: "biological_monitoring_count"
      expr: SUM(CASE WHEN biological_monitoring_conducted = TRUE THEN 1 ELSE 0 END)
      comment: "Total biological monitoring tests conducted for exposure monitoring program tracking"
    - name: "respiratory_test_count"
      expr: SUM(CASE WHEN respiratory_function_test_conducted = TRUE THEN 1 ELSE 0 END)
      comment: "Total respiratory function tests conducted for respiratory health surveillance"
    - name: "vision_test_count"
      expr: SUM(CASE WHEN vision_test_conducted = TRUE THEN 1 ELSE 0 END)
      comment: "Total vision tests conducted for vision health surveillance"
    - name: "nihl_monitoring_count"
      expr: SUM(CASE WHEN nihl_monitoring_conducted = TRUE THEN 1 ELSE 0 END)
      comment: "Total noise-induced hearing loss monitoring tests conducted for hearing conservation program tracking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_mobilisation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce mobilisation and demobilisation metrics including travel costs, accommodation costs, and on-time performance for FIFO workforce logistics management."
  source: "`mining_ecm`.`workforce`.`mobilisation`"
  dimensions:
    - name: "scheduled_mobilisation_date"
      expr: scheduled_mobilisation_date
      comment: "Scheduled mobilisation date for mobilisation planning"
    - name: "scheduled_demobilisation_date"
      expr: scheduled_demobilisation_date
      comment: "Scheduled demobilisation date for demobilisation planning"
    - name: "mobilisation_month"
      expr: DATE_TRUNC('MONTH', scheduled_mobilisation_date)
      comment: "Mobilisation month for monthly mobilisation volume trending"
    - name: "mobilisation_status"
      expr: mobilisation_status
      comment: "Mobilisation status (scheduled, confirmed, completed, cancelled) for mobilisation tracking"
    - name: "mobilisation_type"
      expr: mobilisation_type
      comment: "Mobilisation type (standard, emergency, project) for mobilisation category analysis"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode (air, road, rail) for transport logistics analysis"
    - name: "accommodation_type"
      expr: accommodation_type
      comment: "Accommodation type for accommodation planning"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "No-show flag for mobilisation reliability tracking"
    - name: "manifest_confirmed"
      expr: manifest_confirmed
      comment: "Manifest confirmed flag for mobilisation confirmation tracking"
  measures:
    - name: "total_mobilisations"
      expr: COUNT(mobilisation_id)
      comment: "Total mobilisations for mobilisation volume tracking"
    - name: "total_mobilisation_cost"
      expr: SUM(CAST(total_mobilisation_cost_amount AS DOUBLE))
      comment: "Total mobilisation cost for mobilisation budget management"
    - name: "total_travel_cost"
      expr: SUM(CAST(travel_cost_amount AS DOUBLE))
      comment: "Total travel cost for travel budget management"
    - name: "total_accommodation_cost"
      expr: SUM(CAST(accommodation_cost_amount AS DOUBLE))
      comment: "Total accommodation cost for accommodation budget management"
    - name: "avg_mobilisation_cost"
      expr: AVG(CAST(total_mobilisation_cost_amount AS DOUBLE))
      comment: "Average mobilisation cost per mobilisation for cost benchmarking"
    - name: "avg_travel_cost"
      expr: AVG(CAST(travel_cost_amount AS DOUBLE))
      comment: "Average travel cost per mobilisation for travel cost benchmarking"
    - name: "avg_accommodation_cost"
      expr: AVG(CAST(accommodation_cost_amount AS DOUBLE))
      comment: "Average accommodation cost per mobilisation for accommodation cost benchmarking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_labour_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labour relations and industrial case metrics including case volumes, resolution times, and outcomes for industrial relations management and compliance."
  source: "`mining_ecm`.`workforce`.`labour_case`"
  dimensions:
    - name: "lodgement_date"
      expr: lodgement_date
      comment: "Case lodgement date for case intake tracking"
    - name: "lodgement_month"
      expr: DATE_TRUNC('MONTH', lodgement_date)
      comment: "Case lodgement month for monthly case volume trending"
    - name: "case_type"
      expr: case_type
      comment: "Case type (grievance, disciplinary, dispute) for case category analysis"
    - name: "case_category"
      expr: case_category
      comment: "Case category for detailed case classification"
    - name: "case_status"
      expr: case_status
      comment: "Case status (open, under investigation, resolved, closed) for case pipeline management"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level for case prioritization"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Resolution outcome for case outcome analysis"
    - name: "union_involvement_flag"
      expr: union_involvement_flag
      comment: "Union involvement flag for union relations tracking"
    - name: "legal_representation_flag"
      expr: legal_representation_flag
      comment: "Legal representation flag for legal risk tracking"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for case escalation management"
  measures:
    - name: "total_cases"
      expr: COUNT(labour_case_id)
      comment: "Total labour cases for case volume tracking and industrial relations health monitoring"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_competency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce competency and certification metrics including attainment rates, expiry tracking, and compliance for skills management and regulatory compliance."
  source: "`mining_ecm`.`workforce`.`competency`"
  dimensions:
    - name: "attainment_date"
      expr: attainment_date
      comment: "Competency attainment date for competency acquisition tracking"
    - name: "attainment_month"
      expr: DATE_TRUNC('MONTH', attainment_date)
      comment: "Attainment month for monthly competency development trending"
    - name: "expiry_date"
      expr: expiry_date
      comment: "Competency expiry date for renewal planning"
    - name: "competency_type"
      expr: competency_type
      comment: "Competency type for competency classification"
    - name: "competency_category"
      expr: competency_category
      comment: "Competency category for competency grouping"
    - name: "attainment_status"
      expr: attainment_status
      comment: "Attainment status (attained, expired, in progress) for competency status tracking"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Mandatory flag for compliance tracking"
    - name: "renewal_required"
      expr: renewal_required
      comment: "Renewal required flag for renewal management"
    - name: "site_specific_flag"
      expr: site_specific_flag
      comment: "Site-specific flag for site-based competency management"
  measures:
    - name: "total_competencies"
      expr: COUNT(competency_id)
      comment: "Total competencies recorded for competency inventory tracking"
    - name: "total_competency_cost"
      expr: SUM(CAST(cost_per_attainment AS DOUBLE))
      comment: "Total competency attainment cost for training investment tracking"
    - name: "avg_competency_cost"
      expr: AVG(CAST(cost_per_attainment AS DOUBLE))
      comment: "Average cost per competency attainment for cost benchmarking"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average competency assessment score for competency quality measurement"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours for competency development for training effort tracking"
    - name: "avg_training_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training hours per competency for training duration benchmarking"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`workforce_contractor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor workforce metrics including contractor headcount, engagement duration, and compliance status for contractor management and safety oversight."
  source: "`mining_ecm`.`workforce`.`contractor`"
  dimensions:
    - name: "engagement_start_date"
      expr: engagement_start_date
      comment: "Engagement start date for contractor onboarding tracking"
    - name: "engagement_end_date"
      expr: engagement_end_date
      comment: "Engagement end date for contractor offboarding tracking"
    - name: "engagement_month"
      expr: DATE_TRUNC('MONTH', engagement_start_date)
      comment: "Engagement start month for monthly contractor volume trending"
    - name: "contractor_status"
      expr: contractor_status
      comment: "Contractor status (active, inactive, suspended) for contractor status tracking"
    - name: "engagement_type"
      expr: engagement_type
      comment: "Engagement type for contractor classification"
    - name: "trade_classification"
      expr: trade_classification
      comment: "Trade classification for trade-based contractor analysis"
    - name: "induction_status"
      expr: induction_status
      comment: "Induction status for contractor onboarding compliance"
    - name: "medical_fitness_status"
      expr: medical_fitness_status
      comment: "Medical fitness status for contractor health compliance"
    - name: "site_access_clearance_status"
      expr: site_access_clearance_status
      comment: "Site access clearance status for contractor access management"
    - name: "insurance_status"
      expr: insurance_status
      comment: "Insurance status for contractor insurance compliance"
  measures:
    - name: "total_contractors"
      expr: COUNT(DISTINCT contractor_id)
      comment: "Total unique contractors for contractor workforce size tracking"
$$;