-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`workforce` COMMENT 'Human capital management including employee records, organizational structure, talent acquisition, performance management, compensation, benefits, and payroll. Manages workforce planning, shift scheduling for manufacturing operations, union labor agreements, skills inventory, and IATF-required competency records. Tracks headcount, turnover, training completion, and safety certifications. Integrates with SAP SuccessFactors for end-to-end HR processes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Employee Id',
    `manager_employee_id` BIGINT COMMENT 'Manager Employee Id',
    `position_id` BIGINT COMMENT 'Position Id',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `date_of_birth` DATE COMMENT 'Date Of Birth',
    `department_id` BIGINT COMMENT 'Department Id',
    `email` STRING COMMENT 'Email',
    `employee_number` STRING COMMENT 'Employee Number',
    `employment_status` STRING COMMENT 'Employment Status',
    `employment_type` STRING COMMENT 'Employment Type',
    `first_name` STRING COMMENT 'First Name',
    `gender` STRING COMMENT 'Gender',
    `hire_date` DATE COMMENT 'Hire Date',
    `job_title` STRING COMMENT 'Job Title',
    `last_name` STRING COMMENT 'Last Name',
    `national_id_number` STRING COMMENT 'National Id',
    `org_unit_id` BIGINT COMMENT 'Org Unit Id',
    `phone` STRING COMMENT 'Phone',
    `termination_date` DATE COMMENT 'Termination Date',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `work_location` STRING COMMENT 'Work Location',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for every individual employed by Automotive, sourced from SAP SuccessFactors. Captures employee identity, personal details, employment type (full-time, part-time, contract, CKD-site), hire date, termination date, employment status, home plant or office assignment, job classification, pay grade, union membership flag, IATF competency status, and EEO category. Serves as the SSOT for workforce identity across all HR sub-domains.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Position Id',
    `job_classification_id` BIGINT COMMENT 'Job Classification Id',
    `org_unit_id` BIGINT COMMENT 'Org Unit Id',
    `position_code` STRING COMMENT 'Position Code',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'Fte Equivalent',
    `headcount` STRING COMMENT 'Headcount',
    `position_status` STRING COMMENT 'Position Status',
    `title` STRING COMMENT 'Position Title',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized headcount position within the organizational structure, representing a budgeted role independent of the person filling it. Captures position title, job family, job level, plant or department assignment, shift eligibility, union classification code, FLSA status, target headcount, and whether the position is currently filled or vacant. Supports workforce planning and headcount reporting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Org Unit Id',
    `parent_org_unit_id` BIGINT COMMENT 'Parent Org Unit Id',
    `org_unit_code` STRING COMMENT 'Org Unit Code',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `org_unit_name` STRING COMMENT 'Org Unit Name',
    `org_level` STRING COMMENT 'Org Level',
    `org_unit_type` STRING COMMENT 'Org Unit Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy node representing departments, cost centers, plants, divisions, and business units within Automotive. Captures org unit name, type (plant, department, division), parent org unit, cost center code, plant code, region, and effective dates. Enables hierarchical rollup of headcount, labor cost, and performance data across the enterprise.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`job_classification` (
    `job_classification_id` BIGINT COMMENT 'Job Classification Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `eeo_category` STRING COMMENT 'Eeo Category',
    `flsa_status` STRING COMMENT 'Flsa Status',
    `job_code` STRING COMMENT 'Job Code',
    `job_family` STRING COMMENT 'Job Family',
    `job_level` STRING COMMENT 'Job Level',
    `job_title` STRING COMMENT 'Job Title',
    `max_salary` DECIMAL(18,2) COMMENT 'Max Salary',
    `min_salary` DECIMAL(18,2) COMMENT 'Min Salary',
    `pay_grade` STRING COMMENT 'Pay Grade',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_job_classification PRIMARY KEY(`job_classification_id`)
) COMMENT 'Reference master for standardized job classifications used across Automotives workforce. Captures job code, job title, job family, job level band, IATF competency requirements, union trade classification, FLSA exemption status, and applicable pay grade range. Used to standardize position definitions and link to compensation structures and competency requirements.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'Employment Contract Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `annual_salary` DECIMAL(18,2) COMMENT 'Annual Salary',
    `contract_number` STRING COMMENT 'Contract Number',
    `contract_status` STRING COMMENT 'Contract Status',
    `contract_type` STRING COMMENT 'Contract Type',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `end_date` DATE COMMENT 'End Date',
    `notice_period_days` STRING COMMENT 'Notice Period Days',
    `probation_end_date` DATE COMMENT 'Probation End Date',
    `start_date` DATE COMMENT 'Start Date',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `weekly_hours` DECIMAL(18,2) COMMENT 'Weekly Hours',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Formal employment contract record for each employee, capturing contract type (permanent, fixed-term, apprenticeship, CKD expatriate), contract start and end dates, probation period, notice period, governing collective bargaining agreement (CBA) reference, work location, contracted hours per week, and contract status. Tracks the legal employment relationship between Automotive and the employee.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Shift Schedule Id',
    `plant_id` BIGINT COMMENT 'Plant Id',
    `break_duration_minutes` STRING COMMENT 'Break Duration Minutes',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `end_time` TIMESTAMP COMMENT 'End Time',
    `shift_code` STRING COMMENT 'Shift Code',
    `shift_name` STRING COMMENT 'Shift Name',
    `shift_type` STRING COMMENT 'Shift Type',
    `start_time` TIMESTAMP COMMENT 'Start Time',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Planned shift schedule assignment for production and non-production employees at each plant. Captures employee assignment to a shift pattern (day, afternoon, night, rotating), effective date range, plant, production line, work center, scheduled hours, and overtime eligibility. Integrates with manufacturing.shift reference data and MES shop floor scheduling to ensure adequate staffing for SOP targets.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Time Entry Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `shift_schedule_id` BIGINT COMMENT 'Shift Schedule Id',
    `approval_status` STRING COMMENT 'Approval Status',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Clock In Timestamp',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Clock Out Timestamp',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `hours_worked` DECIMAL(18,2) COMMENT 'Hours Worked',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Overtime Hours',
    `time_entry_type` STRING COMMENT 'Time Entry Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `work_date` DATE COMMENT 'Work Date',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Transactional record of actual hours worked, absence, and overtime for each employee per pay period. Captures clock-in/clock-out timestamps, regular hours, overtime hours, shift differential hours, absence type, approval status, and cost center allocation. Source of truth for payroll calculation and labor cost reporting. Integrates with SAP SuccessFactors Time Tracking and SAP S/4HANA CO for labor cost posting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`absence_record` (
    `absence_record_id` BIGINT COMMENT 'Absence Record Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `absence_type` STRING COMMENT 'Absence Type',
    `approval_status` STRING COMMENT 'Approval Status',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `end_date` DATE COMMENT 'End Date',
    `reason` STRING COMMENT 'Reason',
    `start_date` DATE COMMENT 'Start Date',
    `total_days` DECIMAL(18,2) COMMENT 'Total Days',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_absence_record PRIMARY KEY(`absence_record_id`)
) COMMENT 'Transactional record capturing planned and unplanned employee absences including vacation, sick leave, FMLA, parental leave, union leave, and bereavement. Captures absence type, start date, end date, duration in hours/days, approval status, medical certification flag, and return-to-work date. Supports absenteeism tracking, IATF compliance, and production staffing gap analysis.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` (
    `payroll_result_id` BIGINT COMMENT 'Payroll Result Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `pay_period_id` BIGINT COMMENT 'Pay Period Id',
    `benefit_deductions` DECIMAL(18,2) COMMENT 'Benefit Deductions',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `gross_pay` DECIMAL(18,2) COMMENT 'Gross Pay',
    `net_pay` DECIMAL(18,2) COMMENT 'Net Pay',
    `overtime_pay` DECIMAL(18,2) COMMENT 'Overtime Pay',
    `payment_date` DATE COMMENT 'Payment Date',
    `payroll_status` STRING COMMENT 'Payroll Status',
    `tax_deductions` DECIMAL(18,2) COMMENT 'Tax Deductions',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_payroll_result PRIMARY KEY(`payroll_result_id`)
) COMMENT 'Payroll processing result record for each employee per pay period, capturing gross pay, net pay, base salary, overtime pay, shift differentials, bonuses, deductions (tax, benefits, union dues, garnishments), employer contributions, and pay period dates. Sourced from SAP SuccessFactors Payroll and SAP S/4HANA FI payroll posting. Serves as the authoritative payroll ledger for workforce cost reporting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Compensation Plan Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `base_salary` DECIMAL(18,2) COMMENT 'Base Salary',
    `bonus_target_percent` DECIMAL(18,2) COMMENT 'Bonus Target Percent',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `plan_status` STRING COMMENT 'Plan Status',
    `plan_type` STRING COMMENT 'Plan Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master record defining the compensation structure for a job classification or individual employee, including base salary range, merit increase eligibility, bonus plan type, shift differential rates, overtime multipliers, and effective date. Supports annual compensation review cycles, union CBA compliance, and pay equity analysis across Automotives global manufacturing workforce.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Benefit Enrollment Id',
    `benefit_plan_id` BIGINT COMMENT 'Benefit Plan Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `coverage_level` STRING COMMENT 'Coverage Level',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `employee_contribution` DECIMAL(18,2) COMMENT 'Employee Contribution',
    `employer_contribution` DECIMAL(18,2) COMMENT 'Employer Contribution',
    `enrollment_date` DATE COMMENT 'Enrollment Date',
    `enrollment_status` STRING COMMENT 'Enrollment Status',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefit enrollment record capturing active enrollments in health insurance, dental, vision, life insurance, disability, 401(k)/pension, employee stock purchase plan (ESPP), and wellness programs. Tracks plan type, coverage tier, enrollment date, effective date, employee contribution amount, employer contribution amount, and enrollment status. Sourced from SuccessFactors Benefits.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`talent_requisition` (
    `talent_requisition_id` BIGINT COMMENT 'Talent Requisition Id',
    `employee_id` BIGINT COMMENT 'Hiring Manager Employee Id',
    `position_id` BIGINT COMMENT 'Position Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `headcount_requested` STRING COMMENT 'Headcount Requested',
    `job_title` STRING COMMENT 'Job Title',
    `requisition_number` STRING COMMENT 'Requisition Number',
    `requisition_status` STRING COMMENT 'Requisition Status',
    `target_start_date` DATE COMMENT 'Target Start Date',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_talent_requisition PRIMARY KEY(`talent_requisition_id`)
) COMMENT 'Recruitment requisition record initiated when a position vacancy is approved for hiring. Captures requisition number, position, job classification, hiring manager, target start date, requisition status (open, in-progress, filled, cancelled), sourcing channel, headcount type (replacement, new headcount), and approval workflow status. Integrates with SuccessFactors Recruiting Management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`job_application` (
    `job_application_id` BIGINT COMMENT 'Job Application Id',
    `talent_requisition_id` BIGINT COMMENT 'Talent Requisition Id',
    `applicant_email` STRING COMMENT 'Applicant Email',
    `applicant_name` STRING COMMENT 'Applicant Name',
    `application_date` DATE COMMENT 'Application Date',
    `application_status` STRING COMMENT 'Application Status',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `source_channel` STRING COMMENT 'Source Channel',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_job_application PRIMARY KEY(`job_application_id`)
) COMMENT 'Candidate application record linked to a talent requisition. Captures applicant name, source channel (internal, external, referral, campus), application date, current stage in the hiring funnel (screening, interview, offer, hired, rejected), interview scores, background check status, offer details, and disposition reason. Supports time-to-fill and source effectiveness reporting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Performance Review Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `reviewer_employee_id` BIGINT COMMENT 'Reviewer Employee Id',
    `comments` STRING COMMENT 'Comments',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `overall_rating` STRING COMMENT 'Overall Rating',
    `review_date` DATE COMMENT 'Review Date',
    `review_period` STRING COMMENT 'Review Period',
    `review_status` STRING COMMENT 'Review Status',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Annual or mid-year performance review record for an employee, capturing review cycle, overall rating, goal achievement score, competency ratings, manager comments, calibration status, and final approved rating. Supports merit increase decisions, succession planning, and IATF-required competency evaluation documentation. Sourced from SuccessFactors Performance & Goals.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Training Record Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `training_course_id` BIGINT COMMENT 'Training Course Id',
    `certificate_number` STRING COMMENT 'Certificate Number',
    `completion_date` DATE COMMENT 'Completion Date',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `score` DECIMAL(18,2) COMMENT 'Score',
    `training_status` STRING COMMENT 'Training Status',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Transactional record of employee training completions and enrollments, capturing course name, course type (IATF competency, safety certification, EV/ADAS technical, leadership, compliance), delivery method (classroom, e-learning, OJT), completion date, pass/fail status, score, certification expiry date, and training provider. Critical for IATF 16949 competency compliance and OSHA safety certification tracking.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`competency` (
    `competency_id` BIGINT COMMENT 'Competency Id',
    `competency_category` STRING COMMENT 'Competency Category',
    `competency_code` STRING COMMENT 'Competency Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `competency_description` STRING COMMENT 'Description',
    `competency_name` STRING COMMENT 'Competency Name',
    `proficiency_levels` STRING COMMENT 'Proficiency Levels',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_competency PRIMARY KEY(`competency_id`)
) COMMENT 'Reference master defining the standardized competency framework used across Automotives workforce. Captures competency name, competency type (technical, behavioral, leadership, safety, IATF-required), proficiency levels, applicable job families, and regulatory requirement flag. Provides the taxonomy for IATF 16949 competency records, performance reviews, and skills gap analysis.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`skills_inventory` (
    `skills_inventory_id` BIGINT COMMENT 'Skills Inventory Id',
    `competency_id` BIGINT COMMENT 'Competency Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `assessed_date` DATE COMMENT 'Assessed Date',
    `certification_flag` BOOLEAN COMMENT 'Certification Flag',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `proficiency_level` STRING COMMENT 'Proficiency Level',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_skills_inventory PRIMARY KEY(`skills_inventory_id`)
) COMMENT 'Employee skills profile record capturing assessed proficiency levels for each competency or technical skill. Tracks skill name, skill category (welding, robotics, EV battery assembly, ADAS calibration, quality inspection, forklift operation), assessed proficiency level, assessment date, assessor, and certification status. Enables skills gap analysis, cross-training planning, and JIT workforce deployment on the shop floor.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`succession_plan` (
    `succession_plan_id` BIGINT COMMENT 'Succession Plan Id',
    `employee_id` BIGINT COMMENT 'Candidate Employee Id',
    `position_id` BIGINT COMMENT 'Position Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `plan_status` STRING COMMENT 'Plan Status',
    `readiness_level` STRING COMMENT 'Readiness Level',
    `target_date` DATE COMMENT 'Target Date',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_succession_plan PRIMARY KEY(`succession_plan_id`)
) COMMENT 'Succession planning record identifying key positions and their designated successors within Automotives leadership and critical technical roles. Captures target position, incumbent employee, successor employee, readiness level (ready now, 1-2 years, 3-5 years), development actions, and plan review date. Supports talent pipeline management and business continuity for plant leadership and engineering roles.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`labor_agreement` (
    `labor_agreement_id` BIGINT COMMENT 'Labor Agreement Id',
    `plant_id` BIGINT COMMENT 'Plant Id',
    `agreement_number` STRING COMMENT 'Agreement Number',
    `agreement_status` STRING COMMENT 'Agreement Status',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `union_name` STRING COMMENT 'Union Name',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    `wage_increase_percent` DECIMAL(18,2) COMMENT 'Wage Increase Percent',
    CONSTRAINT pk_labor_agreement PRIMARY KEY(`labor_agreement_id`)
) COMMENT 'Master record for collective bargaining agreements (CBAs) and union labor contracts governing Automotives unionized workforce. Captures union name, agreement effective date, expiration date, covered plant(s), wage scale provisions, overtime rules, grievance procedures, seniority rules, and ratification status. Serves as the authoritative reference for union labor compliance and payroll rule configuration.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`grievance` (
    `grievance_id` BIGINT COMMENT 'Grievance Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `labor_agreement_id` BIGINT COMMENT 'Labor Agreement Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `grievance_description` STRING COMMENT 'Description',
    `filed_date` DATE COMMENT 'Filed Date',
    `grievance_number` STRING COMMENT 'Grievance Number',
    `grievance_status` STRING COMMENT 'Grievance Status',
    `grievance_type` STRING COMMENT 'Grievance Type',
    `resolution_date` DATE COMMENT 'Resolution Date',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_grievance PRIMARY KEY(`grievance_id`)
) COMMENT 'Transactional record for formal employee or union grievances filed against Automotive under a collective bargaining agreement or company policy. Captures grievance number, filing date, grievant employee, union steward, grievance type, description, step in the grievance procedure, resolution status, resolution date, and outcome. Supports labor relations management and CBA compliance tracking.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Safety Incident Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `plant_id` BIGINT COMMENT 'Plant Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `safety_incident_description` STRING COMMENT 'Description',
    `incident_date` DATE COMMENT 'Incident Date',
    `incident_number` STRING COMMENT 'Incident Number',
    `incident_type` STRING COMMENT 'Incident Type',
    `is_recordable` BOOLEAN COMMENT 'Is Recordable',
    `lost_time_days` STRING COMMENT 'Lost Time Days',
    `root_cause` STRING COMMENT 'Root Cause',
    `severity` STRING COMMENT 'Severity',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'Transactional record capturing workplace safety incidents, near-misses, and OSHA recordable events at Automotives manufacturing plants. Captures incident date/time, plant, work center, employee involved, incident type (injury, near-miss, property damage, environmental), body part affected, root cause, corrective action, OSHA recordable flag, days away from work, and OSHA 300 log reference. Supports OSHA compliance and IATF 16949 safety reporting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Headcount Plan Id',
    `org_unit_id` BIGINT COMMENT 'Org Unit Id',
    `actual_headcount` STRING COMMENT 'Actual Headcount',
    `budget_amount` DECIMAL(18,2) COMMENT 'Budget Amount',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `plan_status` STRING COMMENT 'Plan Status',
    `planned_headcount` STRING COMMENT 'Planned Headcount',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Workforce planning record capturing planned headcount targets by org unit, job family, plant, and time period (monthly/quarterly/annual). Captures planned headcount, actual headcount, variance, attrition assumption, new hire plan, and approval status. Supports SOP (Start of Production) ramp-up planning, capacity planning for new model launches, and annual HR budgeting aligned with CapEx and production volume plans.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Disciplinary Action Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `action_date` DATE COMMENT 'Action Date',
    `action_status` STRING COMMENT 'Action Status',
    `action_type` STRING COMMENT 'Action Type',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `reason` STRING COMMENT 'Reason',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Transactional record of formal disciplinary actions taken against employees, including verbal warnings, written warnings, suspensions, and terminations. Captures action type, incident description, policy violated, action date, issuing manager, employee acknowledgment status, union representation flag, appeal status, and expiry date of the action. Supports progressive discipline management and labor relations compliance.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`employee_transfer` (
    `employee_transfer_id` BIGINT COMMENT 'Employee Transfer Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `org_unit_id` BIGINT COMMENT 'From Org Unit Id',
    `to_org_unit_id` BIGINT COMMENT 'To Org Unit Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `transfer_date` DATE COMMENT 'Transfer Date',
    `transfer_reason` STRING COMMENT 'Transfer Reason',
    `transfer_status` STRING COMMENT 'Transfer Status',
    `transfer_type` STRING COMMENT 'Transfer Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_employee_transfer PRIMARY KEY(`employee_transfer_id`)
) COMMENT 'Transactional record capturing internal employee movement events including plant transfers, department transfers, promotions, demotions, and lateral moves. Captures from/to org unit, from/to position, from/to job classification, effective date, transfer reason, relocation flag, and approval chain. Supports workforce mobility tracking, seniority management, and headcount reconciliation across plants.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`onboarding_task` (
    `onboarding_task_id` BIGINT COMMENT 'Onboarding Task Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `completion_date` DATE COMMENT 'Completion Date',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `due_date` DATE COMMENT 'Due Date',
    `task_category` STRING COMMENT 'Task Category',
    `task_name` STRING COMMENT 'Task Name',
    `task_status` STRING COMMENT 'Task Status',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_onboarding_task PRIMARY KEY(`onboarding_task_id`)
) COMMENT 'Transactional record tracking the completion of onboarding activities for newly hired or transferred employees. Captures task name, task category (IT setup, safety orientation, IATF training, badge issuance, plant access, benefits enrollment), assigned owner, due date, completion date, and status. Ensures new hires are production-ready and compliant with IATF 16949 competency requirements before shop floor assignment.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`workforce_certification` (
    `workforce_certification_id` BIGINT COMMENT 'Workforce Certification Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `certification_body` STRING COMMENT 'Certification Body',
    `certification_name` STRING COMMENT 'Certification Name',
    `certification_status` STRING COMMENT 'Certification Status',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `expiry_date` DATE COMMENT 'Expiry Date',
    `issue_date` DATE COMMENT 'Issue Date',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_workforce_certification PRIMARY KEY(`workforce_certification_id`)
) COMMENT 'Master record tracking mandatory and voluntary certifications held by employees, including safety certifications (forklift, crane, lockout/tagout), quality certifications (IATF internal auditor, SPC, APQP), technical certifications (EV high-voltage safety, ADAS calibration), and regulatory certifications (OSHA 10/30, EPA). Captures certification type, issuing body, issue date, expiry date, renewal status, and verification document reference.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`labor_cost_allocation` (
    `labor_cost_allocation_id` BIGINT COMMENT 'Labor Cost Allocation Id',
    `cost_center_id` BIGINT COMMENT 'Cost Center Id',
    `employee_id` BIGINT COMMENT 'Employee Id',
    `allocation_date` DATE COMMENT 'Allocation Date',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Allocation Percent',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost Amount',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `currency_code` STRING COMMENT 'Currency Code',
    `hours_allocated` DECIMAL(18,2) COMMENT 'Hours Allocated',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_labor_cost_allocation PRIMARY KEY(`labor_cost_allocation_id`)
) COMMENT 'Transactional record capturing the allocation of employee labor costs to cost centers, production orders, projects, and plant activities. Captures employee, pay period, hours allocated, cost center, WBS element or production order reference, labor rate, total allocated cost, and allocation method. Integrates with SAP S/4HANA CO-PA for product costing and manufacturing overhead absorption.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Department Id',
    `employee_id` BIGINT COMMENT 'Manager Employee Id',
    `org_unit_id` BIGINT COMMENT 'Org Unit Id',
    `department_code` STRING COMMENT 'Department Code',
    `cost_center_code` STRING COMMENT 'Cost Center Code',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `department_type` STRING COMMENT 'Department Type',
    `department_name` STRING COMMENT 'Department Name',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Benefit Plan Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `effective_from` DATE COMMENT 'Effective From',
    `effective_until` DATE COMMENT 'Effective Until',
    `plan_code` STRING COMMENT 'Plan Code',
    `plan_name` STRING COMMENT 'Plan Name',
    `plan_status` STRING COMMENT 'Plan Status',
    `plan_type` STRING COMMENT 'Plan Type',
    `provider_name` STRING COMMENT 'Provider Name',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by plan_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`pay_period` (
    `pay_period_id` BIGINT COMMENT 'Pay Period Id',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `fiscal_year` STRING COMMENT 'Fiscal Year',
    `is_closed` BOOLEAN COMMENT 'Is Closed',
    `payment_date` DATE COMMENT 'Payment Date',
    `period_code` STRING COMMENT 'Period Code',
    `period_end_date` DATE COMMENT 'Period End Date',
    `period_start_date` DATE COMMENT 'Period Start Date',
    `period_type` STRING COMMENT 'Period Type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_pay_period PRIMARY KEY(`pay_period_id`)
) COMMENT 'Master reference table for pay_period. Referenced by pay_period_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Training Course Id',
    `certification_validity_months` STRING COMMENT 'Certification Validity Months',
    `course_category` STRING COMMENT 'Course Category',
    `course_code` STRING COMMENT 'Course Code',
    `course_name` STRING COMMENT 'Course Name',
    `created_timestamp` TIMESTAMP COMMENT 'Created Timestamp',
    `delivery_method` STRING COMMENT 'Delivery Method',
    `duration_hours` DECIMAL(18,2) COMMENT 'Duration Hours',
    `is_mandatory` BOOLEAN COMMENT 'Is Mandatory',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated Timestamp',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master reference table for training_course. Referenced by course_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_classification_id` FOREIGN KEY (`job_classification_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`job_classification`(`job_classification_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employment_contract` ADD CONSTRAINT `fk_workforce_employment_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`absence_record` ADD CONSTRAINT `fk_workforce_absence_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` ADD CONSTRAINT `fk_workforce_payroll_result_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`pay_period`(`pay_period_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`talent_requisition` ADD CONSTRAINT `fk_workforce_talent_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_talent_requisition_id` FOREIGN KEY (`talent_requisition_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`talent_requisition`(`talent_requisition_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`skills_inventory` ADD CONSTRAINT `fk_workforce_skills_inventory_competency_id` FOREIGN KEY (`competency_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`competency`(`competency_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`skills_inventory` ADD CONSTRAINT `fk_workforce_skills_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_labor_agreement_id` FOREIGN KEY (`labor_agreement_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`labor_agreement`(`labor_agreement_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee_transfer` ADD CONSTRAINT `fk_workforce_employee_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee_transfer` ADD CONSTRAINT `fk_workforce_employee_transfer_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee_transfer` ADD CONSTRAINT `fk_workforce_employee_transfer_to_org_unit_id` FOREIGN KEY (`to_org_unit_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`onboarding_task` ADD CONSTRAINT `fk_workforce_onboarding_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_automotive_v1`.`workforce`.`department` ADD CONSTRAINT `fk_workforce_department_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_automotive_v1`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_automotive_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_classification` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_classification` ALTER COLUMN `max_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_classification` ALTER COLUMN `max_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_classification` ALTER COLUMN `min_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_classification` ALTER COLUMN `min_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employment_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employment_contract` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employment_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employment_contract` ALTER COLUMN `annual_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employment_contract` ALTER COLUMN `annual_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`absence_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`absence_record` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`absence_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` ALTER COLUMN `gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` ALTER COLUMN `gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` ALTER COLUMN `net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`payroll_result` ALTER COLUMN `net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`talent_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`talent_requisition` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`talent_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`talent_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_application` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_application` ALTER COLUMN `applicant_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`job_application` ALTER COLUMN `applicant_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`competency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`competency` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`skills_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`skills_inventory` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`skills_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`skills_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`succession_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`succession_plan` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`succession_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_agreement` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_increase_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_increase_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`grievance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`grievance` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee_transfer` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`employee_transfer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`onboarding_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`onboarding_task` SET TAGS ('dbx_subdomain' = 'safety_compliance');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`onboarding_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`onboarding_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`workforce_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`workforce_certification` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_cost_allocation` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`department` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`department` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`department` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`pay_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`pay_period` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'talent_development');
