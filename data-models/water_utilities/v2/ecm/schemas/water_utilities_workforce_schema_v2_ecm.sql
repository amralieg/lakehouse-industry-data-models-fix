-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 18:57:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`workforce` COMMENT 'Human capital management for utility operations including employee records, certifications and licensing (water/wastewater operator licenses), training compliance, shift scheduling, crew assignments, field service management, labor tracking, OSHA safety incident tracking, and workforce planning. Integrates with SAP HR and Microsoft Dynamics 365 Field Service.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record.',
    `supervisor_employee_id` BIGINT COMMENT 'FK to the employee record of this employees direct supervisor.',
    `cdl_class` STRING COMMENT 'Commercial driver license class held by the employee.',
    `cdl_expiration_date` DATE COMMENT 'Expiration date of the employees commercial driver license.',
    `cdl_license_number` STRING COMMENT 'Commercial driver license number.',
    `confined_space_certified_flag` BOOLEAN COMMENT 'Indicates whether the employee is certified for confined space entry.',
    `cost_center` DECIMAL(18,2) COMMENT 'Cost center code to which the employees labor is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was created.',
    `department_code` STRING COMMENT 'Code identifying the department the employee belongs to.',
    `department_name` STRING COMMENT 'Name of the department the employee belongs to.',
    `email_address` STRING COMMENT 'Employees work email address.',
    `emergency_contact_name` STRING COMMENT 'Name of the employees emergency contact.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the employees emergency contact.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee.',
    `employment_status` STRING COMMENT 'Current employment status (active, terminated, on leave, retired).',
    `employment_type` STRING COMMENT 'Type of employment (full-time, part-time, seasonal, contract).',
    `first_name` STRING COMMENT 'Employees first (given) name.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the employee holds hazardous materials certification.',
    `hire_date` DATE COMMENT 'Date the employee was hired.',
    `job_classification` STRING COMMENT 'Job classification code for the employees role.',
    `job_title` STRING COMMENT 'Official job title of the employee.',
    `last_name` STRING COMMENT 'Employees last (family) name.',
    `middle_name` STRING COMMENT 'Employees middle name.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was last modified.',
    `operator_license_class` STRING COMMENT 'Class of the operator license held (e.g., Class A, B, C, D).',
    `operator_license_expiration_date` DATE COMMENT 'Expiration date of the operator license.',
    `operator_license_issue_date` DATE COMMENT 'Date the operator license was issued.',
    `operator_license_number` STRING COMMENT 'State-issued operator license number.',
    `operator_license_type` STRING COMMENT 'Type of operator license (water treatment, water distribution, wastewater).',
    `osha_training_current_flag` BOOLEAN COMMENT 'Indicates whether the employees OSHA safety training is current.',
    `pay_grade` STRING COMMENT 'Pay grade level assigned to the employee.',
    `personnel_number` STRING COMMENT 'Unique personnel number assigned by HR system.',
    `phone_number` STRING COMMENT 'Employees work phone number.',
    `shift_assignment` STRING COMMENT 'Default shift assignment for the employee.',
    `termination_date` DATE COMMENT 'Date the employees employment was terminated.',
    `termination_reason` STRING COMMENT 'Reason for employment termination.',
    `union_local` STRING COMMENT 'Union local number if the employee is a union member.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a union member.',
    `work_location_code` STRING COMMENT 'Code identifying the employees primary work location.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Water utility employee master record containing personnel information, certifications, employment details, and operational qualifications for treatment plant operators, field technicians, and administrative staff.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` (
    `operator_license_id` BIGINT COMMENT 'Unique identifier for the operator license record.',
    `employee_id` BIGINT COMMENT 'FK to the employee holding this license.',
    `facility_id` BIGINT COMMENT 'FK to the treatment facility where this operator is primarily assigned.',
    `backup_operator_flag` BOOLEAN COMMENT 'Indicates if this operator serves as a backup/relief operator.',
    `continuing_education_hours_completed` DECIMAL(18,2) COMMENT 'Continuing education hours completed in the current renewal cycle.',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'Continuing education hours required for license renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `exam_date` DATE COMMENT 'Date the operator certification exam was taken.',
    `exam_score` DECIMAL(18,2) COMMENT 'Score achieved on the certification exam.',
    `expiration_date` DATE COMMENT 'Date the license expires.',
    `facility_classification_authorized` STRING COMMENT 'Maximum facility classification this license authorizes the operator to run.',
    `issue_date` DATE COMMENT 'Date the license was originally issued.',
    `issuing_agency_name` STRING COMMENT 'Name of the state agency that issued the license.',
    `issuing_state` STRING COMMENT 'State that issued the operator license.',
    `license_document_url` STRING COMMENT 'URL to the scanned license document.',
    `license_grade` STRING COMMENT 'Grade/level of the operator license (e.g., I, II, III, IV).',
    `license_number` STRING COMMENT 'State-assigned license number.',
    `license_status` STRING COMMENT 'Current status of the license (active, expired, suspended, revoked).',
    `license_type` STRING COMMENT 'Type of operator license (water treatment, water distribution, wastewater treatment, wastewater collection).',
    `license_verification_date` DATE COMMENT 'Date the license was last verified with the issuing agency.',
    `license_verification_method` STRING COMMENT 'Method used to verify the license (online, phone, letter).',
    `notes` STRING COMMENT 'Free-text notes about the license.',
    `operator_in_responsible_charge_flag` BOOLEAN COMMENT 'Indicates if this operator is designated as Operator in Responsible Charge.',
    `reciprocity_state` STRING COMMENT 'State from which reciprocity was granted, if applicable.',
    `renewal_application_submitted_date` DATE COMMENT 'Date the renewal application was submitted.',
    `renewal_date` DATE COMMENT 'Date the license was last renewed.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount paid for license renewal.',
    `renewal_fee_paid_date` DATE COMMENT 'Date the renewal fee was paid.',
    `renewal_notification_sent_date` DATE COMMENT 'Date a renewal reminder notification was sent.',
    `revocation_date` DATE COMMENT 'Date the license was revoked, if applicable.',
    `revocation_reason` STRING COMMENT 'Reason for license revocation.',
    `suspension_end_date` DATE COMMENT 'End date of a license suspension period.',
    `suspension_reason` STRING COMMENT 'Reason for license suspension.',
    `suspension_start_date` DATE COMMENT 'Start date of a license suspension period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    CONSTRAINT pk_operator_license PRIMARY KEY(`operator_license_id`)
) COMMENT 'State-issued operator licenses for water treatment, water distribution, and wastewater treatment operations, tracking license grades, renewal cycles, continuing education requirements, and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the certification record.',
    `employee_id` BIGINT COMMENT 'FK to the employee holding this certification.',
    `attachment_url` STRING COMMENT 'URL to the scanned certification document.',
    `certificate_number` STRING COMMENT 'Unique certificate number assigned by the certifying body.',
    `certification_status` STRING COMMENT 'Current status (active, expired, suspended, revoked).',
    `certification_type` STRING COMMENT 'Type/category of certification (safety, technical, management).',
    `certifying_body` STRING COMMENT 'Organization that issued the certification.',
    `ceu_earned` DECIMAL(18,2) COMMENT 'Continuing education units earned toward this certification.',
    `ceu_required` DECIMAL(18,2) COMMENT 'Continuing education units required for renewal.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost paid for obtaining or renewing the certification.',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'Currency code for the cost amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `expiration_date` DATE COMMENT 'Date the certification expires.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if this certification is mandatory for the employees position.',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates if this certification is required by regulation.',
    `issue_date` DATE COMMENT 'Date the certification was issued.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `certification_name` STRING COMMENT 'Name of the certification.',
    `notes` STRING COMMENT 'Free-text notes about the certification.',
    `reimbursement_status` STRING COMMENT 'Status of employer reimbursement for certification costs.',
    `renewal_date` DATE COMMENT 'Date the certification was last renewed.',
    `training_completion_date` DATE COMMENT 'Date the required training was completed.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total training hours completed for this certification.',
    `training_provider` STRING COMMENT 'Organization that provided the training.',
    `verification_date` DATE COMMENT 'Date the certification was last verified.',
    `verification_status` STRING COMMENT 'Status of certification verification (verified, pending, failed).',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Professional certifications held by utility employees including safety certifications, technical certifications, and industry credentials beyond state operator licenses.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course.',
    `employee_id` BIGINT COMMENT 'FK to the employee responsible for maintaining this course.',
    `vendor_id` BIGINT COMMENT 'FK to the approved vendor providing this course.',
    `training_vendor_id` BIGINT COMMENT 'FK to the vendor delivering the course.',
    `accessibility_accommodations` STRING COMMENT 'Available accessibility accommodations for the course.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates if a post-course assessment is required.',
    `certification_awarded` STRING COMMENT 'Certification awarded upon successful completion.',
    `ceu_credits` DECIMAL(18,2) COMMENT 'Continuing education units awarded for completion.',
    `cmms_system_flag` BOOLEAN COMMENT 'Indicates if this is CMMS system training.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Cost per participant for the course.',
    `course_category` STRING COMMENT 'Category of the course (safety, technical, regulatory, professional development).',
    `course_code` STRING COMMENT 'Unique code identifying the course.',
    `course_description` STRING COMMENT 'Detailed description of the course content and objectives.',
    `course_materials_url` STRING COMMENT 'URL to course materials and resources.',
    `course_status` STRING COMMENT 'Current status of the course (active, retired, under review).',
    `course_title` STRING COMMENT 'Title of the training course.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was created.',
    `delivery_method` STRING COMMENT 'Method of course delivery (classroom, online, hands-on, blended).',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the course in hours.',
    `effective_end_date` DATE COMMENT 'Date the course is no longer available.',
    `effective_start_date` DATE COMMENT 'Date the course becomes available.',
    `gis_system_flag` BOOLEAN COMMENT 'Indicates if this is GIS system training.',
    `language` STRING COMMENT 'Language in which the course is delivered.',
    `last_content_review_date` DATE COMMENT 'Date the course content was last reviewed.',
    `maximum_enrollment` STRING COMMENT 'Maximum number of participants per session.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was last modified.',
    `next_review_due_date` DATE COMMENT 'Date the next content review is due.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum passing score percentage for the assessment.',
    `prerequisite_courses` STRING COMMENT 'List of prerequisite course codes.',
    `regulatory_authority` STRING COMMENT 'Regulatory authority mandating this training.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates if this course is mandated by regulation.',
    `required_frequency_months` STRING COMMENT 'Frequency in months at which this training must be repeated.',
    `safety_training_flag` BOOLEAN COMMENT 'Indicates if this is a safety training course.',
    `scada_system_flag` BOOLEAN COMMENT 'Indicates if this is SCADA system training.',
    `target_audience` STRING COMMENT 'Intended audience for the course.',
    `vendor_contract_number` STRING COMMENT 'Contract number with the training vendor.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Catalog of training courses available to utility employees including regulatory-mandated safety training, operator certification preparation, SCADA/GIS system training, and professional development courses.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Unique identifier for the training record.',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center charged for this training.',
    `employee_id` BIGINT COMMENT 'FK to the employee who completed the training.',
    `training_course_id` BIGINT COMMENT 'FK to the training course completed.',
    `approval_date` DATE COMMENT 'Date the training was approved by supervisor.',
    `approved_by` STRING COMMENT 'Name of the person who approved the training.',
    `assessment_method` STRING COMMENT 'Method used to assess competency (written exam, practical, observation).',
    `attendance_percentage` DECIMAL(18,2) COMMENT 'Percentage of course sessions attended.',
    `certification_expiration_date` DATE COMMENT 'Expiration date of any certification earned.',
    `certification_issued` STRING COMMENT 'Certification issued upon completion.',
    `ceu_credits_earned` DECIMAL(18,2) COMMENT 'Continuing education units earned.',
    `comments` STRING COMMENT 'Additional comments about the training.',
    `completion_date` DATE COMMENT 'Date the training was completed.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Actual cost of the training for this employee.',
    `cost_currency_code` STRING COMMENT 'Currency code for the cost amount.',
    `course_code` STRING COMMENT 'Code of the course completed.',
    `course_name` STRING COMMENT 'Name of the course completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `delivery_method` STRING COMMENT 'How the training was delivered (classroom, online, OJT).',
    `enrollment_date` DATE COMMENT 'Date the employee enrolled in the training.',
    `funding_source` STRING COMMENT 'Source of funding for the training.',
    `instructor_name` STRING COMMENT 'Name of the instructor.',
    `is_compliance_required` BOOLEAN COMMENT 'Indicates if this training is required for compliance.',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates if this training is required by regulation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `score` DECIMAL(18,2) COMMENT 'Assessment score achieved.',
    `start_date` DATE COMMENT 'Date the training started.',
    `training_category` STRING COMMENT 'Category of training (safety, technical, regulatory).',
    `training_hours` DECIMAL(18,2) COMMENT 'Total hours spent in training.',
    `training_location` STRING COMMENT 'Location where the training took place.',
    `training_materials_provided` BOOLEAN COMMENT 'Indicates if training materials were provided.',
    `training_provider` STRING COMMENT 'Organization that provided the training.',
    `training_result` STRING COMMENT 'Result of the training (pass, fail, incomplete).',
    `training_status` STRING COMMENT 'Current status (enrolled, in progress, completed, cancelled).',
    `training_type` STRING COMMENT 'Type of training (initial, refresher, recertification).',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Individual employee training completion records tracking enrollment, attendance, assessment scores, CEU credits earned, and compliance status for regulatory-required and elective training.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` (
    `shift_assignment_id` BIGINT COMMENT 'Unique identifier for the shift assignment.',
    `crew_assignment_id` BIGINT COMMENT 'FK to the crew assignment record.',
    `facility_id` BIGINT COMMENT 'FK to the facility where the shift is worked.',
    `metering_dma_zone_id` BIGINT COMMENT 'FK to the metering DMA zone for field assignments.',
    `employee_id` BIGINT COMMENT 'FK to the primary employee on this shift.',
    `shift_approved_by_employee_id` BIGINT COMMENT 'FK to the employee who approved this shift assignment.',
    `shift_employee_id` BIGINT COMMENT 'FK to the employee assigned to this shift.',
    `shift_modified_by_user_employee_id` BIGINT COMMENT 'FK to the employee who last modified this record.',
    `shift_schedule_id` BIGINT COMMENT 'FK to the shift schedule this assignment belongs to.',
    `shift_supervisor_employee_id` BIGINT COMMENT 'FK to the supervising employee for this shift.',
    `swap_request_id` BIGINT COMMENT 'FK to the swap request if this assignment resulted from a swap.',
    `tertiary_shift_supervisor_employee_id` BIGINT COMMENT 'FK to the tertiary shift supervisor.',
    `warehouse_location_id` BIGINT COMMENT 'FK to the warehouse location for material pickup.',
    `work_order_id` BIGINT COMMENT 'FK to the work order associated with this shift.',
    `absence_notes` STRING COMMENT 'Notes regarding any absence during the shift.',
    `absence_reason` STRING COMMENT 'Reason for absence if the employee did not work the shift.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shift ended.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual hours worked during the shift.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shift started.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment was approved.',
    `assigned_date` DATE COMMENT 'Date the shift was assigned.',
    `assignment_notes` STRING COMMENT 'Notes about the shift assignment.',
    `assignment_number` STRING COMMENT 'Unique assignment number.',
    `assignment_status` STRING COMMENT 'Status of the assignment (scheduled, in progress, completed, cancelled).',
    `certification_required` STRING COMMENT 'Certifications required for this shift assignment.',
    `certification_verified_flag` BOOLEAN COMMENT 'Indicates if required certifications were verified.',
    `cost_center_code` STRING COMMENT 'Cost center code for labor charging.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `emergency_callout_flag` BOOLEAN COMMENT 'Indicates if this is an emergency callout shift.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this shift assignment.',
    `labor_cost_currency_code` STRING COMMENT 'Currency code for the labor cost.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `on_call_flag` BOOLEAN COMMENT 'Indicates if this is an on-call shift.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates if overtime was worked.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked.',
    `project_code` STRING COMMENT 'Project code for labor allocation.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Number of hours scheduled for this shift.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'Scheduled end timestamp for the shift.',
    `shift_role` STRING COMMENT 'Role the employee fills during this shift.',
    `shift_start_timestamp` TIMESTAMP COMMENT 'Scheduled start timestamp for the shift.',
    `shift_type` STRING COMMENT 'Type of shift (day, night, swing, weekend).',
    CONSTRAINT pk_shift_assignment PRIMARY KEY(`shift_assignment_id`)
) COMMENT 'Individual shift assignments linking employees to specific shifts, facilities, and crews, tracking actual hours worked, overtime, on-call status, and labor costs for water utility operations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Unique identifier for the crew.',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center for this crews labor.',
    `employee_id` BIGINT COMMENT 'FK to an employee assigned to this crew.',
    `crew_last_modified_by_user_employee_id` BIGINT COMMENT 'FK to the user who last modified the record.',
    `territory_id` BIGINT COMMENT 'FK to the service territory this crew covers.',
    `crew_territory_id` BIGINT COMMENT 'FK to the territory assigned to this crew.',
    `location_id` BIGINT COMMENT 'FK to the crews home base location.',
    `primary_crew_employee_id` BIGINT COMMENT 'FK to the crew lead employee.',
    `registry_id` BIGINT COMMENT 'FK to the asset registry for crew equipment.',
    `warehouse_location_id` BIGINT COMMENT 'FK to the warehouse where the crew picks up materials.',
    `average_response_time_minutes` DECIMAL(18,2) COMMENT 'Average response time in minutes for this crew.',
    `certification_level` STRING COMMENT 'Highest certification level held by crew members.',
    `crew_code` STRING COMMENT 'Unique code identifying the crew.',
    `confined_space_certified` BOOLEAN COMMENT 'Indicates if the crew is certified for confined space entry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew record was created.',
    `crew_status` STRING COMMENT 'Current status of the crew (active, inactive, on standby).',
    `crew_type` STRING COMMENT 'Type of crew (maintenance, construction, emergency, meter reading).',
    `effective_end_date` DATE COMMENT 'Date the crew was deactivated.',
    `effective_start_date` DATE COMMENT 'Date the crew became active.',
    `emergency_response_qualified` BOOLEAN COMMENT 'Indicates if the crew is qualified for emergency response.',
    `equipment_inventory_complete` BOOLEAN COMMENT 'Indicates if the crews equipment inventory is complete.',
    `excavation_certified` BOOLEAN COMMENT 'Indicates if the crew is certified for excavation work.',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Indicates if GPS tracking is enabled for this crew.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates if the crew is hazmat certified.',
    `hourly_labor_rate` DECIMAL(18,2) COMMENT 'Blended hourly labor rate for the crew.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `last_safety_training_date` DATE COMMENT 'Date of the crews last safety training.',
    `mobile_device_code` STRING COMMENT 'Code for the crews mobile device.',
    `crew_name` STRING COMMENT 'Name of the crew.',
    `notes` STRING COMMENT 'Free-text notes about the crew.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the crew is eligible for overtime.',
    `safety_incident_count_ytd` STRING COMMENT 'Number of safety incidents year-to-date.',
    `shift_schedule` STRING COMMENT 'Default shift schedule for the crew.',
    `size` STRING COMMENT 'Number of members in the crew.',
    `union_affiliation` STRING COMMENT 'Union affiliation of the crew members.',
    `vehicle_code` BIGINT COMMENT 'Code for the crews assigned vehicle.',
    `work_orders_completed_ytd` STRING COMMENT 'Number of work orders completed year-to-date.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Work crews composed of utility employees assigned to field operations, maintenance, construction, and emergency response activities across the water and wastewater systems.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` (
    `labor_timesheet_id` BIGINT COMMENT 'Unique identifier for the timesheet entry.',
    `cip_project_id` BIGINT COMMENT 'FK to the CIP project if labor is charged to capital.',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center for labor allocation.',
    `general_ledger_id` BIGINT COMMENT 'FK to the GL account for labor posting.',
    `employee_id` BIGINT COMMENT 'FK to the employee who worked the hours.',
    `primary_labor_employee_id` BIGINT COMMENT 'FK to the primary labor employee.',
    `work_order_id` BIGINT COMMENT 'FK to the work order the labor is charged against.',
    `activity_type` STRING COMMENT 'Type of activity performed (maintenance, operations, construction).',
    `approval_status` STRING COMMENT 'Status of timesheet approval (pending, approved, rejected).',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the timesheet was approved.',
    `billable_flag` BOOLEAN COMMENT 'Indicates if the labor is billable.',
    `call_out_hours` DECIMAL(18,2) COMMENT 'Hours worked on emergency call-outs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `crew_assignment` STRING COMMENT 'Crew the employee was assigned to.',
    `equipment_used` STRING COMMENT 'Equipment used during the work.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total hours worked.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Calculated labor cost for this entry.',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly labor rate applied.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `notes` STRING COMMENT 'Free-text notes about the work performed.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Overtime hours worked.',
    `pay_code` STRING COMMENT 'Pay code for payroll processing.',
    `payroll_period` STRING COMMENT 'Payroll period this entry belongs to.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Regular (non-overtime) hours worked.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates if a safety incident occurred during this work.',
    `shift_type` STRING COMMENT 'Type of shift worked.',
    `standby_hours` DECIMAL(18,2) COMMENT 'Hours on standby.',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the timesheet was submitted.',
    `task_description` STRING COMMENT 'Description of the task performed.',
    `timesheet_date` DATE COMMENT 'Date the work was performed.',
    `training_hours` DECIMAL(18,2) COMMENT 'Hours spent in training.',
    `work_location` STRING COMMENT 'Location where the work was performed.',
    CONSTRAINT pk_labor_timesheet PRIMARY KEY(`labor_timesheet_id`)
) COMMENT 'Daily labor timesheet entries recording hours worked by utility employees against work orders, projects, cost centers, and general ledger accounts for payroll processing and cost allocation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position.',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center funding this position.',
    `facility_id` BIGINT COMMENT 'FK to the facility where this position is located.',
    `org_unit_id` BIGINT COMMENT 'FK to the department org unit.',
    `position_org_unit_id` BIGINT COMMENT 'FK to the organizational unit this position belongs to.',
    `supervisor_position_id` BIGINT COMMENT 'FK to the supervisory position above this one.',
    `approval_date` DATE COMMENT 'Date the position was approved.',
    `approved_by` STRING COMMENT 'Name of the person who approved the position.',
    `bargaining_unit` STRING COMMENT 'Bargaining unit the position belongs to.',
    `position_code` STRING COMMENT 'Unique code for the position.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position was created.',
    `position_description` STRING COMMENT 'Detailed description of the position.',
    `effective_end_date` DATE COMMENT 'Date the position is no longer active.',
    `effective_start_date` DATE COMMENT 'Date the position becomes active.',
    `flsa_status` STRING COMMENT 'Fair Labor Standards Act status (exempt, non-exempt).',
    `fte_count` DECIMAL(18,2) COMMENT 'Full-time equivalent count for this position.',
    `job_code` STRING COMMENT 'Job classification code.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the position was last modified.',
    `organizational_level` STRING COMMENT 'Level in the organizational hierarchy.',
    `pay_grade` STRING COMMENT 'Pay grade assigned to this position.',
    `pay_range_maximum` DECIMAL(18,2) COMMENT 'Maximum salary for this position.',
    `pay_range_minimum` DECIMAL(18,2) COMMENT 'Minimum salary for this position.',
    `position_status` STRING COMMENT 'Current status (active, frozen, abolished).',
    `position_type` STRING COMMENT 'Type of position (permanent, temporary, seasonal).',
    `required_certifications` STRING COMMENT 'Certifications required for this position.',
    `required_operator_license_grade` STRING COMMENT 'Minimum operator license grade required.',
    `requires_cdl` BOOLEAN COMMENT 'Indicates if a CDL is required.',
    `requires_confined_space_entry` BOOLEAN COMMENT 'Indicates if confined space entry certification is required.',
    `requires_on_call` BOOLEAN COMMENT 'Indicates if on-call duty is required.',
    `safety_sensitive` BOOLEAN COMMENT 'Indicates if this is a safety-sensitive position.',
    `shift_rotation_required` BOOLEAN COMMENT 'Indicates if shift rotation is required.',
    `succession_criticality` STRING COMMENT 'Criticality rating for succession planning.',
    `title` STRING COMMENT 'Official title of the position.',
    `union_classification` STRING COMMENT 'Union classification for the position.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized positions within the utility organization defining job requirements, pay grades, required certifications, operator license grades, and organizational placement for workforce planning.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit.',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center for this org unit.',
    `location_id` BIGINT COMMENT 'FK to the physical location of this org unit.',
    `employee_id` BIGINT COMMENT 'FK to the employee managing this org unit.',
    `parent_org_unit_id` BIGINT COMMENT 'FK to the parent organizational unit.',
    `address_line_1` STRING COMMENT 'First line of the org units address.',
    `address_line_2` STRING COMMENT 'Second line of the org units address.',
    `budget_amount_annual` DECIMAL(18,2) COMMENT 'Annual budget amount for the org unit.',
    `budget_fiscal_year` STRING COMMENT 'Fiscal year for the budget amount.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates if certifications are required for staff in this unit.',
    `city` STRING COMMENT 'City where the org unit is located.',
    `country_code` STRING COMMENT 'Country code for the org unit location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `org_unit_description` STRING COMMENT 'Description of the organizational unit.',
    `effective_end_date` DATE COMMENT 'Date the org unit is deactivated.',
    `effective_start_date` DATE COMMENT 'Date the org unit became active.',
    `email_address` STRING COMMENT 'Contact email for the org unit.',
    `fax_number` STRING COMMENT 'Fax number for the org unit.',
    `functional_area` STRING COMMENT 'Functional area (operations, engineering, finance, customer service).',
    `headcount_actual` STRING COMMENT 'Current actual headcount.',
    `headcount_authorized` STRING COMMENT 'Authorized headcount for the org unit.',
    `hierarchy_level` STRING COMMENT 'Level in the organizational hierarchy.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `operates_24_7` BOOLEAN COMMENT 'Indicates if the org unit operates 24/7.',
    `phone_number` STRING COMMENT 'Contact phone number for the org unit.',
    `postal_code` STRING COMMENT 'Postal/ZIP code.',
    `regulatory_oversight_agency` STRING COMMENT 'Regulatory agency with oversight of this unit.',
    `safety_sensitive_flag` BOOLEAN COMMENT 'Indicates if the org unit performs safety-sensitive work.',
    `shift_schedule_type` STRING COMMENT 'Type of shift schedule used.',
    `state_province` STRING COMMENT 'State or province.',
    `union_representation` BOOLEAN COMMENT 'Indicates if the org unit has union representation.',
    `unit_code` STRING COMMENT 'Unique code for the org unit.',
    `unit_name` STRING COMMENT 'Name of the organizational unit.',
    `unit_short_name` STRING COMMENT 'Abbreviated name of the org unit.',
    `unit_status` STRING COMMENT 'Current status (active, inactive, reorganizing).',
    `unit_type` STRING COMMENT 'Type of organizational unit (division, department, section, team).',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational units representing departments, divisions, and sections within the water utility including treatment operations, distribution, customer service, engineering, and administration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Unique identifier for the safety incident.',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center where the incident occurred.',
    `facility_id` BIGINT COMMENT 'FK to the facility where the incident occurred.',
    `employee_id` BIGINT COMMENT 'FK to the primary safety officer.',
    `process_unit_id` BIGINT COMMENT 'FK to the process unit involved.',
    `registry_id` BIGINT COMMENT 'FK to the asset involved in the incident.',
    `safety_employee_id` BIGINT COMMENT 'FK to the employee involved in the incident.',
    `tertiary_safety_reported_by_employee_id` BIGINT COMMENT 'FK to the employee who reported the incident.',
    `work_order_id` BIGINT COMMENT 'FK to the work order being performed when the incident occurred.',
    `body_part_affected` STRING COMMENT 'Body part affected by the injury.',
    `corrective_action_completed_date` DATE COMMENT 'Date corrective action was completed.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken.',
    `corrective_action_due_date` DATE COMMENT 'Due date for corrective action.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates if corrective action is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `days_away_from_work` STRING COMMENT 'Number of days away from work due to the incident.',
    `days_of_restricted_duty` STRING COMMENT 'Number of days on restricted duty.',
    `department` STRING COMMENT 'Department where the incident occurred.',
    `environmental_release_flag` BOOLEAN COMMENT 'Indicates if an environmental release occurred.',
    `environmental_release_volume` DECIMAL(18,2) COMMENT 'Volume of environmental release in gallons.',
    `field_location_description` STRING COMMENT 'Description of the field location.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'GPS latitude of the incident location.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'GPS longitude of the incident location.',
    `incident_date` DATE COMMENT 'Date the incident occurred.',
    `incident_description` STRING COMMENT 'Detailed description of the incident.',
    `incident_number` STRING COMMENT 'Unique incident tracking number.',
    `incident_time` TIMESTAMP COMMENT 'Time the incident occurred.',
    `incident_type` STRING COMMENT 'Type of incident (injury, near-miss, property damage, vehicle).',
    `injury_nature` STRING COMMENT 'Nature of the injury (laceration, strain, fracture).',
    `injury_severity` STRING COMMENT 'Severity of the injury (minor, moderate, severe, fatal).',
    `investigation_completed_date` DATE COMMENT 'Date the investigation was completed.',
    `investigation_status` STRING COMMENT 'Status of the investigation.',
    `job_title` STRING COMMENT 'Job title of the affected employee.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `location_type` STRING COMMENT 'Type of location (plant, field, office, vehicle).',
    `osha_log_reference` STRING COMMENT 'Reference to the OSHA 300 log entry.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates if the incident is OSHA recordable.',
    `property_damage_amount` DECIMAL(18,2) COMMENT 'Estimated property damage amount.',
    `regulatory_notification_date` DATE COMMENT 'Date regulatory agencies were notified.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates if regulatory notification is required.',
    `reported_date` DATE COMMENT 'Date the incident was reported.',
    `root_cause_category` STRING COMMENT 'Category of root cause (human error, equipment failure, procedure).',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause.',
    `supervisor_name` STRING COMMENT 'Name of the supervisor at the time of incident.',
    `vehicle_code` BIGINT COMMENT 'Code of the vehicle involved, if applicable.',
    `witness_count` STRING COMMENT 'Number of witnesses to the incident.',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'Safety incidents occurring at utility facilities and field locations including injuries, near-misses, property damage, environmental releases, and vehicle accidents with OSHA reporting and root cause analysis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request.',
    `employee_id` BIGINT COMMENT 'FK to the employee requesting leave.',
    `primary_leave_employee_id` BIGINT COMMENT 'FK to the primary leave approver.',
    `tertiary_leave_backup_employee_id` BIGINT COMMENT 'FK to the backup employee covering during leave.',
    `location_id` BIGINT COMMENT 'FK to the work location affected by the leave.',
    `accrual_balance_after` DECIMAL(18,2) COMMENT 'Leave accrual balance after this request.',
    `accrual_balance_before` DECIMAL(18,2) COMMENT 'Leave accrual balance before this request.',
    `advance_notice_days` STRING COMMENT 'Number of days advance notice provided.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the request was approved or denied.',
    `approved_end_date` DATE COMMENT 'Approved end date of leave.',
    `approved_start_date` DATE COMMENT 'Approved start date of leave.',
    `attachment_url` STRING COMMENT 'URL to supporting documentation.',
    `certification_received` BOOLEAN COMMENT 'Indicates if medical certification was received.',
    `certification_received_date` DATE COMMENT 'Date medical certification was received.',
    `certification_required` BOOLEAN COMMENT 'Indicates if medical certification is required.',
    `cost_center_code` STRING COMMENT 'Cost center code for the leave.',
    `coverage_plan` STRING COMMENT 'Plan for shift coverage during the leave.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request was created.',
    `denial_reason` STRING COMMENT 'Reason for denial if the request was denied.',
    `fmla_case_number` STRING COMMENT 'FMLA case number if applicable.',
    `hours_approved` DECIMAL(18,2) COMMENT 'Number of leave hours approved.',
    `hours_requested` DECIMAL(18,2) COMMENT 'Number of leave hours requested.',
    `is_emergency_leave` BOOLEAN COMMENT 'Indicates if this is an emergency leave request.',
    `is_fmla_eligible` BOOLEAN COMMENT 'Indicates if the leave qualifies under FMLA.',
    `is_paid` BOOLEAN COMMENT 'Indicates if the leave is paid.',
    `leave_subtype` STRING COMMENT 'Subtype of leave (e.g., personal sick, family sick).',
    `leave_type` STRING COMMENT 'Type of leave (vacation, sick, FMLA, bereavement, jury duty).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `notes` STRING COMMENT 'Additional notes about the leave request.',
    `payroll_period` STRING COMMENT 'Payroll period affected by the leave.',
    `request_number` STRING COMMENT 'Unique request tracking number.',
    `request_status` STRING COMMENT 'Status of the request (pending, approved, denied, cancelled).',
    `request_submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the request was submitted.',
    `requested_end_date` DATE COMMENT 'Requested end date of leave.',
    `requested_start_date` DATE COMMENT 'Requested start date of leave.',
    `shift_coverage_impact` STRING COMMENT 'Assessment of impact on shift coverage.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave requests including vacation, sick leave, FMLA, bereavement, and other leave types with approval workflows, accrual balance tracking, and shift coverage impact assessment.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review.',
    `cost_center_id` BIGINT COMMENT 'FK to the cost center of the reviewed employee.',
    `employee_id` BIGINT COMMENT 'FK to the employee being reviewed.',
    `reviewer_employee_id` BIGINT COMMENT 'FK to the employee conducting the review.',
    `areas_for_improvement` STRING COMMENT 'Areas identified for improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the review was created.',
    `customer_service_rating` STRING COMMENT 'Rating for customer service performance.',
    `customer_service_score` DECIMAL(18,2) COMMENT 'Numeric score for customer service.',
    `development_plan_notes` STRING COMMENT 'Notes on the employees development plan.',
    `employee_acknowledgment_date` DATE COMMENT 'Date the employee acknowledged the review.',
    `employee_acknowledgment_status` STRING COMMENT 'Status of employee acknowledgment.',
    `employee_comments` STRING COMMENT 'Comments from the employee.',
    `goal_achievement_rating` STRING COMMENT 'Rating for goal achievement.',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Numeric score for goal achievement.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Recommended merit increase percentage.',
    `merit_increase_recommended_flag` BOOLEAN COMMENT 'Indicates if a merit increase is recommended.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the review was last modified.',
    `next_review_due_date` DATE COMMENT 'Date the next review is due.',
    `overall_rating` STRING COMMENT 'Overall performance rating.',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric overall performance score.',
    `promotion_recommended_flag` BOOLEAN COMMENT 'Indicates if a promotion is recommended.',
    `regulatory_knowledge_rating` STRING COMMENT 'Rating for regulatory knowledge.',
    `regulatory_knowledge_score` DECIMAL(18,2) COMMENT 'Numeric score for regulatory knowledge.',
    `review_date` DATE COMMENT 'Date the review was conducted.',
    `review_document_url` STRING COMMENT 'URL to the review document.',
    `review_period_end_date` DATE COMMENT 'End date of the review period.',
    `review_period_start_date` DATE COMMENT 'Start date of the review period.',
    `review_status` STRING COMMENT 'Status of the review (draft, submitted, acknowledged, finalized).',
    `review_type` STRING COMMENT 'Type of review (annual, probationary, mid-year, special).',
    `reviewer_comments` STRING COMMENT 'Comments from the reviewer.',
    `safety_compliance_rating` STRING COMMENT 'Rating for safety compliance.',
    `safety_compliance_score` DECIMAL(18,2) COMMENT 'Numeric score for safety compliance.',
    `strengths_summary` STRING COMMENT 'Summary of employee strengths.',
    `succession_planning_candidate_flag` BOOLEAN COMMENT 'Indicates if the employee is a succession planning candidate.',
    `teamwork_rating` STRING COMMENT 'Rating for teamwork.',
    `teamwork_score` DECIMAL(18,2) COMMENT 'Numeric score for teamwork.',
    `technical_skills_rating` STRING COMMENT 'Rating for technical skills.',
    `technical_skills_score` DECIMAL(18,2) COMMENT 'Numeric score for technical skills.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Annual and periodic performance reviews for utility employees evaluating technical skills, safety compliance, regulatory knowledge, customer service, teamwork, and goal achievement with merit increase recommendations.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` (
    `field_service_dispatch_id` BIGINT COMMENT 'Unique identifier for the dispatch record.',
    `crew_id` BIGINT COMMENT 'FK to the crew assigned to this dispatch.',
    `customer_account_id` BIGINT COMMENT 'FK to the customer account for this service call.',
    `registry_id` BIGINT COMMENT 'FK to the asset being serviced.',
    `employee_id` BIGINT COMMENT 'FK to the assigned technician.',
    `field_registry_id` BIGINT COMMENT 'FK to the asset registry.',
    `warehouse_location_id` BIGINT COMMENT 'FK to the warehouse for material pickup.',
    `primary_field_employee_id` BIGINT COMMENT 'FK to the primary field technician.',
    `work_order_id` BIGINT COMMENT 'FK to the associated work order.',
    `facility_id` BIGINT COMMENT 'FK to the treatment facility if applicable.',
    `actual_arrival_datetime` TIMESTAMP COMMENT 'Actual arrival timestamp at the service location.',
    `actual_departure_datetime` TIMESTAMP COMMENT 'Actual departure timestamp from the service location.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual duration of the service call in hours.',
    `cancellation_datetime` TIMESTAMP COMMENT 'Timestamp when the dispatch was cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation.',
    `completion_datetime` TIMESTAMP COMMENT 'Timestamp when the service was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispatch was created.',
    `customer_contact_name` STRING COMMENT 'Name of the customer contact.',
    `customer_contact_phone` STRING COMMENT 'Phone number of the customer contact.',
    `dispatch_datetime` TIMESTAMP COMMENT 'Timestamp when the dispatch was issued.',
    `dispatch_number` STRING COMMENT 'Unique dispatch tracking number.',
    `dispatch_status` STRING COMMENT 'Current status (pending, dispatched, en route, on site, completed).',
    `dispatch_type` STRING COMMENT 'Type of dispatch (service call, emergency, scheduled, meter).',
    `dispatcher_notes` STRING COMMENT 'Notes from the dispatcher.',
    `dma_zone_code` STRING COMMENT 'District metered area zone code.',
    `equipment_required` STRING COMMENT 'Equipment required for the service call.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours.',
    `estimated_travel_time_minutes` STRING COMMENT 'Estimated travel time in minutes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last modified.',
    `priority_level` STRING COMMENT 'Priority level (emergency, urgent, routine, low).',
    `safety_requirements` STRING COMMENT 'Safety requirements for the service call.',
    `scheduled_arrival_end_datetime` TIMESTAMP COMMENT 'End of the scheduled arrival window.',
    `scheduled_arrival_start_datetime` TIMESTAMP COMMENT 'Start of the scheduled arrival window.',
    `service_address_line1` STRING COMMENT 'First line of the service address.',
    `service_address_line2` STRING COMMENT 'Second line of the service address.',
    `service_city` STRING COMMENT 'City of the service location.',
    `service_latitude` DECIMAL(18,2) COMMENT 'GPS latitude of the service location.',
    `service_longitude` DECIMAL(18,2) COMMENT 'GPS longitude of the service location.',
    `service_postal_code` STRING COMMENT 'Postal code of the service location.',
    `service_state` STRING COMMENT 'State of the service location.',
    `service_territory_code` STRING COMMENT 'Service territory code.',
    `sla_actual_response_minutes` STRING COMMENT 'Actual response time in minutes.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates if the SLA was met.',
    `sla_target_response_minutes` STRING COMMENT 'Target response time per SLA in minutes.',
    `technician_notes` STRING COMMENT 'Notes from the field technician.',
    CONSTRAINT pk_field_service_dispatch PRIMARY KEY(`field_service_dispatch_id`)
) COMMENT 'Field service dispatch records assigning technicians and crews to customer service calls, meter work, main breaks, valve operations, and other field activities with scheduling, routing, and SLA tracking.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` (
    `labor_relations_case_id` BIGINT COMMENT 'Unique identifier for the labor relations case.',
    `employee_id` BIGINT COMMENT 'FK to the employee involved in the case.',
    `arbitration_date` DATE COMMENT 'Date of arbitration hearing if applicable.',
    `arbitration_outcome` STRING COMMENT 'Outcome of arbitration (sustained, denied, settled).',
    `arbitration_required` BOOLEAN COMMENT '',
    `arbitration_required_flag` BOOLEAN COMMENT '',
    `arbitrator_name` STRING COMMENT '',
    `case_category` STRING COMMENT 'Category of the case (grievance, disciplinary, arbitration, ULP).',
    `case_date` DATE COMMENT '',
    `case_description` STRING COMMENT 'Detailed description of the case.',
    `case_number` STRING COMMENT 'Unique case tracking number.',
    `case_priority` STRING COMMENT 'Priority level of the case.',
    `case_status` STRING COMMENT 'Current status (open, under review, hearing scheduled, closed).',
    `case_type` STRING COMMENT 'Type of labor relations case.',
    `closed_date` DATE COMMENT 'Date the case was closed.',
    `contract_article_reference` STRING COMMENT 'Reference to the collective bargaining agreement article.',
    `corrective_action_taken` STRING COMMENT 'Corrective action taken as a result of the case.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was created.',
    `department` STRING COMMENT 'Department involved in the case.',
    `filed_date` DATE COMMENT 'Date the case was filed.',
    `filing_date` DATE COMMENT '',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact or settlement amount.',
    `grievance_description` STRING COMMENT '',
    `grievance_level` STRING COMMENT '',
    `grievance_step` STRING COMMENT 'Current step in the grievance process.',
    `hearing_date` DATE COMMENT 'Date of the hearing.',
    `management_representative` STRING COMMENT 'Name of the management representative.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was last modified.',
    `notes` STRING COMMENT 'Additional case notes.',
    `resolution_date` DATE COMMENT 'Date the case was resolved.',
    `resolution_description` STRING COMMENT 'Description of the resolution.',
    `resolution_type` STRING COMMENT '',
    `response_due_date` DATE COMMENT '',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Settlement amount if applicable.',
    `union_local` STRING COMMENT 'Union local involved in the case.',
    `union_name` STRING COMMENT '',
    `union_representative` STRING COMMENT 'Name of the union representative.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_labor_relations_case PRIMARY KEY(`labor_relations_case_id`)
) COMMENT 'Labor relations cases including grievances, disciplinary actions, arbitrations, unfair labor practice charges, and contract disputes between the utility and employee unions or individual employees.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the shift schedule.',
    `previous_shift_schedule_id` BIGINT COMMENT 'FK to the previous version of this shift schedule.',
    `break_duration_minutes` STRING COMMENT 'Duration of breaks in minutes.',
    `shift_schedule_description` STRING COMMENT 'Description of the shift schedule.',
    `effective_from` DATE COMMENT 'Date the schedule becomes effective.',
    `effective_until` DATE COMMENT 'Date the schedule expires.',
    `is_paid_shift` BOOLEAN COMMENT 'Indicates if this is a paid shift.',
    `labor_category` STRING COMMENT 'Labor category for the shift.',
    `max_employees` STRING COMMENT 'Maximum number of employees on this shift.',
    `min_employees` STRING COMMENT 'Minimum number of employees required.',
    `notes` STRING COMMENT 'Additional notes about the schedule.',
    `osha_compliant` BOOLEAN COMMENT 'Indicates if the schedule is OSHA compliant.',
    `pay_rate_per_hour` DECIMAL(18,2) COMMENT 'Hourly pay rate for this shift.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit timestamp when the record was created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit timestamp when the record was last updated.',
    `schedule_code` STRING COMMENT 'Unique code for the shift schedule.',
    `schedule_name` STRING COMMENT 'Name of the shift schedule.',
    `schedule_type` STRING COMMENT 'Type of schedule (fixed, rotating, on-call, split).',
    `shift_duration_minutes` STRING COMMENT 'Duration of the shift in minutes.',
    `shift_end_time` TIMESTAMP COMMENT 'Scheduled end time of the shift.',
    `shift_group` STRING COMMENT 'Group designation for the shift.',
    `shift_location` STRING COMMENT 'Location where the shift is worked.',
    `shift_pattern_code` STRING COMMENT 'Code for the shift rotation pattern.',
    `shift_start_time` TIMESTAMP COMMENT 'Scheduled start time of the shift.',
    `shift_schedule_status` STRING COMMENT 'Current status of the schedule (active, inactive, draft).',
    `timezone` STRING COMMENT 'Timezone for the shift times.',
    `updated_by` STRING COMMENT 'User who last updated the schedule.',
    `work_day` STRING COMMENT 'Day of the week for this shift.',
    `created_by` STRING COMMENT 'User who created the schedule.',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Shift schedule definitions for water utility operations including treatment plant shifts, field crew schedules, on-call rotations, and emergency response coverage patterns.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` (
    `swap_request_id` BIGINT COMMENT 'Unique identifier for the swap request.',
    `employee_id` BIGINT COMMENT 'FK to the employee who approves the swap.',
    `location_id` BIGINT COMMENT 'FK to the work location for the swap.',
    `original_swap_request_id` BIGINT COMMENT 'FK to the original swap request if this is a counter-swap.',
    `swap_employee_id` BIGINT COMMENT 'FK to the employee requesting the swap.',
    `target_employee_id` BIGINT COMMENT 'FK to the employee being asked to swap.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the swap was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request was created.',
    `effective_date` DATE COMMENT 'Date the swap takes effect.',
    `hours_swapped` DECIMAL(18,2) COMMENT 'Number of hours being swapped.',
    `notes` STRING COMMENT 'Additional notes about the swap.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates if the swap results in overtime.',
    `reason_code` STRING COMMENT 'Code for the reason for the swap.',
    `reason_description` STRING COMMENT 'Description of the reason for the swap.',
    `request_number` STRING COMMENT 'Unique request tracking number.',
    `request_timestamp` TIMESTAMP COMMENT 'Timestamp when the request was made.',
    `shift_end_time` TIMESTAMP COMMENT 'End time of the shift being swapped.',
    `shift_start_time` TIMESTAMP COMMENT 'Start time of the shift being swapped.',
    `swap_request_status` STRING COMMENT 'Status of the swap request (pending, approved, denied, cancelled).',
    `swap_type` STRING COMMENT 'Type of swap (full shift, partial, on-call).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the request was last updated.',
    CONSTRAINT pk_swap_request PRIMARY KEY(`swap_request_id`)
) COMMENT 'Shift swap requests between employees allowing operators and field staff to exchange scheduled shifts with approval workflows and overtime impact assessment.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ADD CONSTRAINT `fk_workforce_operator_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_approved_by_employee_id` FOREIGN KEY (`shift_approved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_employee_id` FOREIGN KEY (`shift_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_modified_by_user_employee_id` FOREIGN KEY (`shift_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_supervisor_employee_id` FOREIGN KEY (`shift_supervisor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_swap_request_id` FOREIGN KEY (`swap_request_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`swap_request`(`swap_request_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_tertiary_shift_supervisor_employee_id` FOREIGN KEY (`tertiary_shift_supervisor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_crew_last_modified_by_user_employee_id` FOREIGN KEY (`crew_last_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_primary_crew_employee_id` FOREIGN KEY (`primary_crew_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_primary_labor_employee_id` FOREIGN KEY (`primary_labor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_position_org_unit_id` FOREIGN KEY (`position_org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_supervisor_position_id` FOREIGN KEY (`supervisor_position_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_safety_employee_id` FOREIGN KEY (`safety_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_tertiary_safety_reported_by_employee_id` FOREIGN KEY (`tertiary_safety_reported_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_tertiary_leave_backup_employee_id` FOREIGN KEY (`tertiary_leave_backup_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_primary_field_employee_id` FOREIGN KEY (`primary_field_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_previous_shift_schedule_id` FOREIGN KEY (`previous_shift_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_original_swap_request_id` FOREIGN KEY (`original_swap_request_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`swap_request`(`swap_request_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_swap_employee_id` FOREIGN KEY (`swap_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_target_employee_id` FOREIGN KEY (`target_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_class` SET TAGS ('dbx_business_glossary_term' = 'CDL Class');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'CDL Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_business_glossary_term' = 'CDL License Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `confined_space_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Certified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Certified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_class` SET TAGS ('dbx_business_glossary_term' = 'Operator License Class');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Operator License Expiration');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Operator License Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_number` SET TAGS ('dbx_business_glossary_term' = 'Operator License Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_type` SET TAGS ('dbx_business_glossary_term' = 'Operator License Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `osha_training_current_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Training Current');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `personnel_number` SET TAGS ('dbx_business_glossary_term' = 'Personnel Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `operator_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operator License ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Facility');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `backup_operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Operator');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `continuing_education_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'CE Hours Completed');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('dbx_business_glossary_term' = 'CE Hours Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `exam_date` SET TAGS ('dbx_business_glossary_term' = 'Exam Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `exam_score` SET TAGS ('dbx_business_glossary_term' = 'Exam Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `facility_classification_authorized` SET TAGS ('dbx_business_glossary_term' = 'Facility Classification Authorized');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issuing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_document_url` SET TAGS ('dbx_business_glossary_term' = 'License Document URL');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_grade` SET TAGS ('dbx_business_glossary_term' = 'License Grade');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `operator_in_responsible_charge_flag` SET TAGS ('dbx_business_glossary_term' = 'ORC Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `reciprocity_state` SET TAGS ('dbx_business_glossary_term' = 'Reciprocity State');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_application_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Paid Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `ceu_earned` SET TAGS ('dbx_business_glossary_term' = 'CEU Earned');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `ceu_required` SET TAGS ('dbx_business_glossary_term' = 'CEU Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Course Owner');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Provider');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `training_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `accessibility_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `ceu_credits` SET TAGS ('dbx_business_glossary_term' = 'CEU Credits');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `cmms_system_flag` SET TAGS ('dbx_business_glossary_term' = 'CMMS System Training');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_materials_url` SET TAGS ('dbx_business_glossary_term' = 'Course Materials URL');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `gis_system_flag` SET TAGS ('dbx_business_glossary_term' = 'GIS System Training');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `last_content_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `maximum_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `required_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Required Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `safety_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Training');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `scada_system_flag` SET TAGS ('dbx_business_glossary_term' = 'SCADA System Training');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `vendor_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'training_certification');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `attendance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `ceu_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'CEU Credits Earned');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `instructor_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `is_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_materials_provided` SET TAGS ('dbx_business_glossary_term' = 'Materials Provided');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_result` SET TAGS ('dbx_business_glossary_term' = 'Training Result');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` SET TAGS ('dbx_subdomain' = 'operations_scheduling');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `metering_dma_zone_id` SET TAGS ('dbx_business_glossary_term' = 'DMA Zone');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Shift Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Request');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Supervisor');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `absence_notes` SET TAGS ('dbx_business_glossary_term' = 'Absence Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `certification_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Verified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `emergency_callout_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Callout');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Currency');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On Call');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_role` SET TAGS ('dbx_business_glossary_term' = 'Shift Role');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` SET TAGS ('dbx_subdomain' = 'operations_scheduling');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Territory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `primary_crew_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Lead Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `primary_crew_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `primary_crew_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `average_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Avg Response Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `confined_space_certified` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Certified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `emergency_response_qualified` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Qualified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `equipment_inventory_complete` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inventory Complete');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `excavation_certified` SET TAGS ('dbx_business_glossary_term' = 'Excavation Certified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'GPS Tracking Enabled');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Certified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `hourly_labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Labor Rate');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `last_safety_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Training Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_business_glossary_term' = 'Crew Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `safety_incident_count_ytd` SET TAGS ('dbx_business_glossary_term' = 'Safety Incidents YTD');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `shift_schedule` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `work_orders_completed_ytd` SET TAGS ('dbx_business_glossary_term' = 'Work Orders Completed YTD');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `labor_timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Timesheet ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Labor Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `call_out_hours` SET TAGS ('dbx_business_glossary_term' = 'Call Out Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `crew_assignment` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `standby_hours` SET TAGS ('dbx_business_glossary_term' = 'Standby Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `timesheet_date` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Org Unit');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `supervisor_position_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Position');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `bargaining_unit` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'FLSA Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `fte_count` SET TAGS ('dbx_business_glossary_term' = 'FTE Count');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `organizational_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Level');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `required_operator_license_grade` SET TAGS ('dbx_business_glossary_term' = 'Required License Grade');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `requires_cdl` SET TAGS ('dbx_business_glossary_term' = 'Requires CDL');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `requires_confined_space_entry` SET TAGS ('dbx_business_glossary_term' = 'Requires Confined Space');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `requires_on_call` SET TAGS ('dbx_business_glossary_term' = 'Requires On Call');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `shift_rotation_required` SET TAGS ('dbx_business_glossary_term' = 'Shift Rotation Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `succession_criticality` SET TAGS ('dbx_business_glossary_term' = 'Succession Criticality');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `union_classification` SET TAGS ('dbx_business_glossary_term' = 'Union Classification');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Org Unit');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized Headcount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `operates_24_7` SET TAGS ('dbx_business_glossary_term' = 'Operates 24/7');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `regulatory_oversight_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Oversight Agency');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `safety_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `shift_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `union_representation` SET TAGS ('dbx_business_glossary_term' = 'Union Representation');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Short Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Safety Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `tertiary_safety_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `tertiary_safety_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `tertiary_safety_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `days_of_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days Restricted Duty');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `environmental_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Release');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `environmental_release_volume` SET TAGS ('dbx_business_glossary_term' = 'Release Volume');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `field_location_description` SET TAGS ('dbx_business_glossary_term' = 'Field Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `injury_nature` SET TAGS ('dbx_business_glossary_term' = 'Injury Nature');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `osha_log_reference` SET TAGS ('dbx_business_glossary_term' = 'OSHA Log Reference');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `property_damage_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Leave Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backup_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backup_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backup_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `accrual_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance After');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `accrual_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance Before');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `advance_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Days');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `certification_received` SET TAGS ('dbx_business_glossary_term' = 'Certification Received');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `certification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `coverage_plan` SET TAGS ('dbx_business_glossary_term' = 'Coverage Plan');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_business_glossary_term' = 'FMLA Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `hours_approved` SET TAGS ('dbx_business_glossary_term' = 'Hours Approved');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `hours_requested` SET TAGS ('dbx_business_glossary_term' = 'Hours Requested');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `is_emergency_leave` SET TAGS ('dbx_business_glossary_term' = 'Emergency Leave');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `is_fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'FMLA Eligible');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Paid Leave');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `request_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `shift_coverage_impact` SET TAGS ('dbx_business_glossary_term' = 'Shift Coverage Impact');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `areas_for_improvement` SET TAGS ('dbx_business_glossary_term' = 'Areas for Improvement');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `customer_service_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `customer_service_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `development_plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Development Plan');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase %');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Recommended');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `regulatory_knowledge_rating` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Knowledge Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `regulatory_knowledge_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Knowledge Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_document_url` SET TAGS ('dbx_business_glossary_term' = 'Review Document URL');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Compliance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Compliance Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `succession_planning_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Candidate');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_business_glossary_term' = 'Teamwork Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `teamwork_score` SET TAGS ('dbx_business_glossary_term' = 'Teamwork Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` SET TAGS ('dbx_subdomain' = 'operations_scheduling');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `field_service_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `field_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Warehouse');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `primary_field_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Field Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `primary_field_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `primary_field_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'WTP Facility');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `actual_arrival_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `actual_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Completion Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_datetime` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatcher_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dma_zone_code` SET TAGS ('dbx_business_glossary_term' = 'DMA Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `estimated_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Travel Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `scheduled_arrival_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival End');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `scheduled_arrival_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Start');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_latitude` SET TAGS ('dbx_business_glossary_term' = 'Service Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_longitude` SET TAGS ('dbx_business_glossary_term' = 'Service Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_state` SET TAGS ('dbx_business_glossary_term' = 'Service State');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `sla_actual_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Response');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `sla_target_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Response');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `technician_notes` SET TAGS ('dbx_business_glossary_term' = 'Technician Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `labor_relations_case_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Relations Case ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `arbitration_date` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `arbitration_outcome` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Outcome');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `contract_article_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Article');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `filed_date` SET TAGS ('dbx_business_glossary_term' = 'Filed Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `grievance_step` SET TAGS ('dbx_business_glossary_term' = 'Grievance Step');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `management_representative` SET TAGS ('dbx_business_glossary_term' = 'Management Representative');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `management_representative` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `union_representative` SET TAGS ('dbx_business_glossary_term' = 'Union Representative');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `union_representative` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'operations_scheduling');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `previous_shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Shift Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_paid_shift` SET TAGS ('dbx_business_glossary_term' = 'Paid Shift');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `max_employees` SET TAGS ('dbx_business_glossary_term' = 'Max Employees');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `min_employees` SET TAGS ('dbx_business_glossary_term' = 'Min Employees');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `osha_compliant` SET TAGS ('dbx_business_glossary_term' = 'OSHA Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `pay_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Per Hour');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Audit Created');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_group` SET TAGS ('dbx_business_glossary_term' = 'Shift Group');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_location` SET TAGS ('dbx_business_glossary_term' = 'Shift Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_pattern_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `work_day` SET TAGS ('dbx_business_glossary_term' = 'Work Day');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` SET TAGS ('dbx_subdomain' = 'operations_scheduling');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Request ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `original_swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Original Swap Request');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Target Employee');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `hours_swapped` SET TAGS ('dbx_business_glossary_term' = 'Hours Swapped');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_request_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_type` SET TAGS ('dbx_business_glossary_term' = 'Swap Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
