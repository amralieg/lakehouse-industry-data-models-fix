-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-24 00:22:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`workforce` COMMENT 'Owns human capital and workforce management data. Manages employee master records, organizational structure, payroll, benefits, talent acquisition, performance management, compensation, workforce planning, OSHA safety incident records, training records, and labor compliance across manufacturing and commercial operations. Integrates with Workday HCM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Primary key',
    `job_profile_id` BIGINT COMMENT '',
    `manager_employee_id` BIGINT COMMENT '',
    `position_id` BIGINT COMMENT '',
    `work_location_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `date_of_birth` DATE COMMENT '',
    `email` STRING COMMENT '',
    `employee_number` STRING COMMENT '',
    `employment_status` STRING COMMENT '',
    `employment_type` STRING COMMENT '',
    `first_name` STRING COMMENT '',
    `gender` STRING COMMENT '',
    `hire_date` DATE COMMENT '',
    `last_name` STRING COMMENT '',
    `phone_number` STRING COMMENT '',
    `termination_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core employee master record';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Primary key',
    `parent_org_unit_id` BIGINT COMMENT '',
    `org_unit_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `org_unit_level` STRING COMMENT '',
    `org_unit_name` STRING COMMENT '',
    `org_unit_type` STRING COMMENT '',
    `org_unit_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Primary key',
    `job_profile_id` BIGINT COMMENT '',
    `org_unit_id` BIGINT COMMENT '',
    `position_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `fte` DECIMAL(18,2) COMMENT '',
    `position_status` STRING COMMENT '',
    `title` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Position master data';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Primary key',
    `job_profile_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `job_profile_description` STRING COMMENT '',
    `flsa_status` STRING COMMENT '',
    `job_family` STRING COMMENT '',
    `job_level` STRING COMMENT '',
    `job_profile_name` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Job profile definitions';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `payroll_period_id` BIGINT COMMENT '',
    `payroll_run_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `gross_pay` DECIMAL(18,2) COMMENT '',
    `net_pay` DECIMAL(18,2) COMMENT '',
    `payment_date` DATE COMMENT '',
    `total_deductions` DECIMAL(18,2) COMMENT '',
    `total_taxes` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Individual payroll transaction records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `benefit_plan_code` STRING COMMENT '',
    `benefit_type` STRING COMMENT '',
    `coverage_level` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_date` DATE COMMENT '',
    `employee_contribution` DECIMAL(18,2) COMMENT '',
    `employer_contribution` DECIMAL(18,2) COMMENT '',
    `enrollment_date` DATE COMMENT '',
    `benefit_enrollment_status` STRING COMMENT '',
    `termination_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefit enrollment records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` DECIMAL(18,2) COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `time_employee_id` BIGINT COMMENT '',
    `approval_status` STRING COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `hours_worked` DECIMAL(18,2) COMMENT '',
    `overtime_hours` DECIMAL(18,2) COMMENT '',
    `time_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `work_date` DATE COMMENT '',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Employee time and attendance records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` (
    `recruiting_requisition_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `job_profile_id` BIGINT COMMENT '',
    `position_id` BIGINT COMMENT '',
    `close_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `number_of_openings` STRING COMMENT '',
    `open_date` DATE COMMENT '',
    `requisition_number` STRING COMMENT '',
    `requisition_status` STRING COMMENT '',
    `target_hire_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_recruiting_requisition PRIMARY KEY(`recruiting_requisition_id`)
) COMMENT 'Job requisition records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` (
    `job_application_id` BIGINT COMMENT 'Primary key',
    `applicant_id` BIGINT COMMENT '',
    `recruiting_requisition_id` BIGINT COMMENT '',
    `application_date` DATE COMMENT '',
    `application_source` STRING COMMENT '',
    `application_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `current_stage` STRING COMMENT '',
    `offer_accepted_date` DATE COMMENT '',
    `offer_extended_date` DATE COMMENT '',
    `rejection_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_job_application PRIMARY KEY(`job_application_id`)
) COMMENT 'Candidate job applications';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `reviewer_employee_id` BIGINT COMMENT '',
    `comments` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `overall_rating` STRING COMMENT '',
    `review_date` DATE COMMENT '',
    `review_period_end` DATE COMMENT '',
    `review_period_start` DATE COMMENT '',
    `review_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Employee performance review records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `training_course_id` BIGINT COMMENT '',
    `completion_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `expiration_date` DATE COMMENT '',
    `instructor_name` STRING COMMENT '',
    `score` DECIMAL(18,2) COMMENT '',
    `training_record_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Employee training completion records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Primary key',
    `org_unit_id` BIGINT COMMENT '',
    `course_code` STRING COMMENT '',
    `course_name` STRING COMMENT '',
    `course_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `training_course_description` STRING COMMENT '',
    `duration_hours` DECIMAL(18,2) COMMENT '',
    `is_mandatory` BOOLEAN COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `validity_period_months` STRING COMMENT '',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Training course catalog';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `manufacturing_facility_id` BIGINT COMMENT '',
    `corrective_action` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `safety_incident_description` STRING COMMENT '',
    `incident_date` DATE COMMENT '',
    `incident_time` TIMESTAMP COMMENT '',
    `incident_type` STRING COMMENT '',
    `lost_time_days` STRING COMMENT '',
    `osha_recordable` BOOLEAN COMMENT '',
    `root_cause` STRING COMMENT '',
    `severity` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'Workplace safety incident records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `work_location_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `shift_date` DATE COMMENT '',
    `shift_end_time` TIMESTAMP COMMENT '',
    `shift_start_time` TIMESTAMP COMMENT '',
    `shift_type` STRING COMMENT '',
    `shift_schedule_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Employee shift scheduling';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` (
    `labor_relation_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `dues_amount` DECIMAL(18,2) COMMENT '',
    `membership_end_date` DATE COMMENT '',
    `membership_start_date` DATE COMMENT '',
    `membership_status` STRING COMMENT '',
    `union_code` STRING COMMENT '',
    `union_name` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_labor_relation PRIMARY KEY(`labor_relation_id`)
) COMMENT 'Labor relations and union records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` (
    `enrollment_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT '',
    `enrollment_supervisor_employee_id` BIGINT COMMENT 'Supervisor who approved enrollment',
    `enrollment_training_course_id` BIGINT COMMENT '',
    `training_course_id` BIGINT COMMENT 'Prerequisite course required',
    `attendance_pct` DECIMAL(18,2) COMMENT 'Percentage of attendance',
    `cancellation_date` DATE COMMENT 'Date enrollment was cancelled',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation',
    `certificate_issue_date` DATE COMMENT 'Date certificate was issued',
    `certificate_issued_flag` BOOLEAN COMMENT 'Whether certificate was issued',
    `certificate_number` STRING COMMENT 'Certificate number issued',
    `certifying_body` STRING COMMENT '',
    `channel` STRING COMMENT 'Channel through which enrollment occurred',
    `completion_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `credits_earned` DECIMAL(18,2) COMMENT 'Credits earned from enrollment',
    `delivery_method` STRING COMMENT 'Training delivery method (online, classroom, etc.)',
    `effective_date` DATE COMMENT '',
    `enrollment_date` DATE COMMENT '',
    `enrollment_status` STRING COMMENT '',
    `enrollment_type` STRING COMMENT '',
    `expiration_date` DATE COMMENT 'Date when certification expires',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee for enrollment',
    `feedback_rating` DECIMAL(18,2) COMMENT 'Employee feedback rating for the training (1-5 scale)',
    `final_grade` STRING COMMENT 'Final grade received',
    `instructor_name` STRING COMMENT 'Name of the instructor',
    `is_mandatory` BOOLEAN COMMENT 'Whether this enrollment is for a mandatory training requirement',
    `location` STRING COMMENT 'Training location',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates if training is mandatory',
    `pass_fail_flag` BOOLEAN COMMENT 'Whether the employee passed or failed',
    `pass_fail_indicator` STRING COMMENT 'Whether the employee passed or failed the course',
    `pass_fail_status` STRING COMMENT 'Pass or fail status',
    `passing_score_required` DECIMAL(18,2) COMMENT 'Minimum passing score required',
    `payment_date` DATE COMMENT 'Date payment was made',
    `payment_status` STRING COMMENT 'Payment status (paid, pending, etc.)',
    `prerequisite_met_flag` BOOLEAN COMMENT 'Whether prerequisites were met',
    `program_code` STRING COMMENT '',
    `program_name` STRING COMMENT '',
    `reason` STRING COMMENT 'Reason for enrollment',
    `recertification_due_date` DATE COMMENT '',
    `refund_eligible_flag` BOOLEAN COMMENT 'Whether refund is eligible',
    `score` DECIMAL(18,2) COMMENT '',
    `supervisor_approval_date` DATE COMMENT 'Date supervisor approved',
    `supervisor_approval_required_flag` BOOLEAN COMMENT 'Whether supervisor approval is required',
    `termination_date` DATE COMMENT '',
    `training_hours` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `waitlist_flag` BOOLEAN COMMENT 'Whether on waitlist',
    `waitlist_position` STRING COMMENT 'Position on waitlist',
    CONSTRAINT pk_enrollment PRIMARY KEY(`enrollment_id`)
) COMMENT 'General enrollment records for programs and initiatives';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Primary key',
    `job_profile_id` BIGINT COMMENT '',
    `application_source` STRING COMMENT '',
    `availability_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `email` STRING COMMENT '',
    `expected_salary` DECIMAL(18,2) COMMENT '',
    `first_name` STRING COMMENT '',
    `last_name` STRING COMMENT '',
    `phone_number` STRING COMMENT '',
    `resume_url` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Job applicant master records';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key',
    `payroll_group_id` BIGINT COMMENT '',
    `payroll_period_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `employee_count` STRING COMMENT '',
    `payment_date` DATE COMMENT '',
    `run_date` DATE COMMENT '',
    `run_status` STRING COMMENT '',
    `total_gross_pay` DECIMAL(18,2) COMMENT '',
    `total_net_pay` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Payroll processing run header';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` (
    `work_location_id` BIGINT COMMENT 'Primary key',
    `address_line_1` STRING COMMENT '',
    `address_line_2` STRING COMMENT '',
    `city` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `emergency_contact_name` STRING COMMENT '',
    `emergency_contact_phone` STRING COMMENT '',
    `location_code` STRING COMMENT '',
    `location_name` STRING COMMENT '',
    `location_type` STRING COMMENT '',
    `postal_code` STRING COMMENT '',
    `state_province` STRING COMMENT '',
    `time_zone` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_work_location PRIMARY KEY(`work_location_id`)
) COMMENT 'Physical work location master data';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key',
    `payroll_group_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `payment_date` DATE COMMENT '',
    `period_end_date` DATE COMMENT '',
    `period_number` STRING COMMENT '',
    `period_start_date` DATE COMMENT '',
    `period_year` STRING COMMENT '',
    `payroll_period_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Payroll period calendar';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` (
    `payroll_group_id` BIGINT COMMENT 'Primary key',
    `payroll_group_code` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `payroll_group_name` STRING COMMENT '',
    `pay_frequency` STRING COMMENT '',
    `payroll_group_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_payroll_group PRIMARY KEY(`payroll_group_id`)
) COMMENT 'Payroll group configuration';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_time_employee_id` FOREIGN KEY (`time_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ADD CONSTRAINT `fk_workforce_recruiting_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` ADD CONSTRAINT `fk_workforce_job_application_recruiting_requisition_id` FOREIGN KEY (`recruiting_requisition_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition`(`recruiting_requisition_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_work_location_id` FOREIGN KEY (`work_location_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`work_location`(`work_location_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ADD CONSTRAINT `fk_workforce_labor_relation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_enrollment_supervisor_employee_id` FOREIGN KEY (`enrollment_supervisor_employee_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_enrollment_training_course_id` FOREIGN KEY (`enrollment_training_course_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ADD CONSTRAINT `fk_workforce_enrollment_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_group`(`payroll_group_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_payroll_group_id` FOREIGN KEY (`payroll_group_id`) REFERENCES `vibe_consumer_goods_v1`.`workforce`.`payroll_group`(`payroll_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_consumer_goods_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'compensation_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_record` ALTER COLUMN `total_taxes` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`time_entry` ALTER COLUMN `time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`recruiting_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`job_application` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`labor_relation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` SET TAGS ('dbx_association_edges' = 'workforce.employee,workforce.training_course');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `enrollment_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `attendance_pct` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Credits Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `final_grade` SET TAGS ('dbx_business_glossary_term' = 'Final Grade');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `instructor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `prerequisite_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Met');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `supervisor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `supervisor_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Approval Required');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `waitlist_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`enrollment` ALTER COLUMN `waitlist_position` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Position');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` SET TAGS ('dbx_subdomain' = 'talent_operations');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_sensitivity' = 'financial_personal');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_pii_type' = 'financial_personal');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `expected_salary` SET TAGS ('dbx_pii_kind' = 'financial_personal');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'compensation_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_sensitivity' = 'person_name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_kind' = 'person_name');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`work_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_subdomain' = 'compensation_processing');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`workforce`.`payroll_group` SET TAGS ('dbx_subdomain' = 'compensation_processing');
