-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 17:53:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`workforce` COMMENT 'Human capital management for hospitality operations including employee profiles, scheduling, labor management, payroll, benefits, talent acquisition, performance management, and learning and development. Integrates with Oracle HCM Cloud and SAP S/4HANA HCM. Tracks labor cost as percentage of revenue, CPOR labor components, and compliance with OSHA and ADA workforce regulations. Supports USALI labor cost reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` (
    `learning_course_id` BIGINT COMMENT 'Unique identifier for the learning course. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Training courses implement compliance policies (harassment prevention, data privacy, safety). Compliance officers must track which courses satisfy which policy requirements for audit evidence and regu',
    `prerequisite_course_learning_course_id` BIGINT COMMENT 'Reference to another learning course that must be completed before this course can be taken. Null if no prerequisite exists.',
    `property_id` BIGINT COMMENT '',
    `accreditation_body` STRING COMMENT 'Name of the professional or regulatory body that accredits or certifies this course. Examples include OSHA, state health departments, American Hotel and Lodging Educational Institute (AHLEI), Court of Master Sommeliers. Null if course is not externally accredited.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether learners must complete a graded assessment or examination to pass the course. True for courses with tests, false for attendance-only or participation-based courses.',
    `certificate_template_code` STRING COMMENT 'Identifier for the certificate template used to generate completion certificates for this course. Links to document generation system. Null if course does not issue certificates.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this course results in a professional certification or license being issued. True for courses like food handler certification, TIPS alcohol service, CPR, OSHA 10/30, sommelier certification, spa therapy licenses.',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this course fulfills a regulatory or legal compliance requirement such as OSHA mandatory training, food safety certification, ADA training, or other jurisdiction-specific requirements.',
    `content_version` STRING COMMENT 'Version number of the course content. Incremented when course materials are updated to reflect regulatory changes, brand standard updates, or content improvements.. Valid values are `^[0-9]+.[0-9]+$`',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education units or credits awarded upon course completion. Used for professional development tracking and license renewal requirements. Null if course does not award CEUs.',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'Cost to deliver the course per individual learner. Includes instructor fees, materials, platform fees, and external vendor costs. Used for training budget planning and CPOR (Cost Per Occupied Room) labor component analysis.',
    `course_category` STRING COMMENT 'Primary classification of the course type. Compliance courses are mandatory regulatory training, skills courses develop job-specific competencies, leadership courses develop management capabilities, brand standards ensure consistent guest experience, food safety covers ISO 22000 requirements, OSHA covers workplace safety, ADA covers accessibility compliance. [ENUM-REF-CANDIDATE: compliance|skills|leadership|brand_standards|food_safety|osha|ada — 7 candidates stripped; promote to reference product]',
    `course_code` STRING COMMENT 'Unique business identifier for the course used in catalogs and learning management systems. Typically alphanumeric code assigned by training department.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed description of the course content, learning objectives, and outcomes. Provides employees with understanding of what they will learn.',
    `course_status` STRING COMMENT 'Current lifecycle status of the course. Active courses are available for enrollment, inactive courses are temporarily unavailable, under development courses are being created, retired courses are no longer offered, suspended courses are on hold pending review.. Valid values are `active|inactive|under_development|retired|suspended`',
    `course_title` STRING COMMENT 'Full name of the learning course as displayed to employees and managers.',
    `course_type` STRING COMMENT 'Indicates whether the course is mandatory for specific roles, optional for employee development, recommended by management, or required for professional certification.. Valid values are `mandatory|optional|recommended|certification`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was first created in the learning management system.',
    `delivery_method` STRING COMMENT 'Method by which the course content is delivered to learners. Instructor-led is in-person classroom, online is self-paced eLearning, blended combines multiple methods, on-the-job is practical training during work, virtual classroom is live remote instruction.. Valid values are `instructor_led|online|blended|on_the_job|virtual_classroom`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the course in hours. Used for scheduling, labor planning, and compliance tracking. Supports OSHA 10-hour and 30-hour certification requirements.',
    `effective_end_date` DATE COMMENT 'Date when the course is no longer available for new enrollments. Null for courses with no planned end date. Used when courses are being phased out or replaced.',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment and delivery. Used for scheduling new course launches and regulatory compliance effective dates.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of learners that can be enrolled in a single offering of the course. Relevant for instructor-led and virtual classroom courses. Null for unlimited capacity online courses.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language in which the course is delivered. Examples: ENG (English), SPA (Spanish), FRA (French).. Valid values are `^[A-Z]{3}$`',
    `last_content_update_date` DATE COMMENT 'Date when the course content was last revised or updated. Critical for ensuring compliance training reflects current regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was last updated. Tracks any changes to course metadata, content version, status, or configuration.',
    `max_attempts` STRING COMMENT 'Maximum number of attempts allowed for course completion or assessment. Null if unlimited attempts are permitted.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score percentage required to successfully complete the course. Null if course does not have a scored assessment.',
    `regulatory_body` STRING COMMENT 'Name of the government or regulatory agency that mandates this training. Examples: OSHA, FDA, state health department, fire marshal. Null if course is not mandated by a regulatory body.',
    `target_audience` STRING COMMENT 'Description of the intended audience for the course, such as specific job roles, departments, or employee levels. Examples: front desk agents, housekeeping supervisors, F&B managers, all property staff.',
    `validity_period_days` STRING COMMENT 'Number of days the course completion remains valid before recertification is required. Critical for compliance courses like food handler certification, OSHA training, and CPR certification. Null if course completion does not expire.',
    `vendor_name` STRING COMMENT 'Name of external training provider or vendor delivering the course. Null for internally developed courses.',
    CONSTRAINT pk_learning_course PRIMARY KEY(`learning_course_id`)
) COMMENT 'Learning and development management including course catalog, employee training enrollments, completion tracking, and professional certification records for hotel staff. Covers course definitions (compliance, skills, leadership, brand standards, food safety, OSHA, ADA), delivery methods, and passing requirements. Includes enrollment/completion records with scores, certificates, and expiry dates. Tracks professional certifications and licenses (food handler, TIPS, CPR, OSHA 10/30, sommelier, spa license) with issuing authority, certification number, validity period, and renewal status. Supports OSHA mandatory training compliance, food safety certification (ISO 22000), brand standards training, ADA/regulatory credential verification, and license expiry alerting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee` (
    `workforce_employee_id` BIGINT COMMENT '',
    `property_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `email` STRING COMMENT '',
    `employment_status` STRING COMMENT '',
    `first_name` STRING COMMENT '',
    `hire_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `job_title` STRING COMMENT '',
    `last_name` STRING COMMENT '',
    CONSTRAINT pk_workforce_employee PRIMARY KEY(`workforce_employee_id`)
) COMMENT 'Employee records for the workforce domain';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_position` (
    `workforce_position_id` BIGINT COMMENT '',
    `workforce_org_unit_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `fte_count` DECIMAL(18,2) COMMENT '',
    `is_vacant` BOOLEAN COMMENT '',
    `position_code` STRING COMMENT '',
    `position_title` STRING COMMENT '',
    CONSTRAINT pk_workforce_position PRIMARY KEY(`workforce_position_id`)
) COMMENT 'Workforce position records';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_org_unit` (
    `workforce_org_unit_id` BIGINT COMMENT '',
    `parent_org_unit_id` BIGINT COMMENT '',
    `property_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `org_unit_code` STRING COMMENT '',
    `org_unit_name` STRING COMMENT '',
    `org_unit_type` STRING COMMENT '',
    CONSTRAINT pk_workforce_org_unit PRIMARY KEY(`workforce_org_unit_id`)
) COMMENT 'Organizational unit within the workforce hierarchy';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` (
    `schedule_id` BIGINT COMMENT '',
    `workforce_employee_id` BIGINT COMMENT '',
    `property_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `end_timestamp` TIMESTAMP COMMENT '',
    `schedule_status` STRING COMMENT '',
    `scheduled_hours` DECIMAL(18,2) COMMENT '',
    `shift_date` DATE COMMENT '',
    `start_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Schedule records for workforce management';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` (
    `workforce_benefit_plan_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT '',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `plan_name` STRING COMMENT '',
    `plan_type` STRING COMMENT '',
    CONSTRAINT pk_workforce_benefit_plan PRIMARY KEY(`workforce_benefit_plan_id`)
) COMMENT 'Workforce benefit plan information';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan` (
    `workforce_compensation_plan_id` BIGINT COMMENT '',
    `workforce_employee_id` BIGINT COMMENT '',
    `base_salary_amount` DECIMAL(18,2) COMMENT '',
    `bonus_target_pct` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `plan_name` STRING COMMENT '',
    CONSTRAINT pk_workforce_compensation_plan PRIMARY KEY(`workforce_compensation_plan_id`)
) COMMENT 'Compensation plan details for workforce employees';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_disciplinary_action` (
    `workforce_disciplinary_action_id` BIGINT COMMENT '',
    `workforce_employee_id` BIGINT COMMENT '',
    `action_date` DATE COMMENT '',
    `action_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `is_resolved` BOOLEAN COMMENT '',
    `severity_level` BIGINT COMMENT '',
    CONSTRAINT pk_workforce_disciplinary_action PRIMARY KEY(`workforce_disciplinary_action_id`)
) COMMENT 'Records of disciplinary actions taken against workforce members';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_job_requisition` (
    `workforce_job_requisition_id` BIGINT COMMENT '',
    `workforce_org_unit_id` BIGINT COMMENT '',
    `workforce_position_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `is_approved` BOOLEAN COMMENT '',
    `openings_count` STRING COMMENT '',
    `requisition_status` STRING COMMENT '',
    `target_start_date` DATE COMMENT '',
    CONSTRAINT pk_workforce_job_requisition PRIMARY KEY(`workforce_job_requisition_id`)
) COMMENT 'Stores job requisition records for workforce management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_benefit_plan` (
    `procurement_benefit_plan_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `property_id` BIGINT COMMENT '',
    `aca_compliant_flag` BOOLEAN COMMENT '',
    `carrier_name` STRING COMMENT '',
    `carrier_policy_number` BIGINT COMMENT '',
    `cobra_eligible_flag` BOOLEAN COMMENT '',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT '',
    `contribution_frequency` STRING COMMENT '',
    `copay_amount` DECIMAL(18,2) COMMENT '',
    `coverage_amount` DECIMAL(18,2) COMMENT '',
    `coverage_level` BIGINT COMMENT '',
    `coverage_tier` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `deductible_amount` DECIMAL(18,2) COMMENT '',
    `dependent_coverage_allowed_flag` BOOLEAN COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `eligibility_criteria` STRING COMMENT '',
    `eligibility_waiting_period_days` STRING COMMENT '',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT '',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT '',
    `enrollment_period_end_date` DATE COMMENT '',
    `enrollment_period_start_date` DATE COMMENT '',
    `enrollment_window_days` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `life_event_enrollment_allowed_flag` BOOLEAN COMMENT '',
    `maximum_dependent_age` STRING COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT '',
    `plan_code` STRING COMMENT '',
    `plan_description` STRING COMMENT '',
    `plan_document_url` STRING COMMENT '',
    `plan_name` STRING COMMENT '',
    `plan_status` STRING COMMENT '',
    `plan_type` STRING COMMENT '',
    `plan_year` STRING COMMENT '',
    `waiting_period_days` STRING COMMENT '',
    CONSTRAINT pk_procurement_benefit_plan PRIMARY KEY(`procurement_benefit_plan_id`)
) COMMENT 'Benefit plan information for procurement domain';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` (
    `procurement_compensation_plan_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `procurement_position_id` BIGINT COMMENT '',
    `procurement_employee_id` BIGINT COMMENT '',
    `property_id` BIGINT COMMENT '',
    `approval_status` STRING COMMENT '',
    `approved_timestamp` TIMESTAMP COMMENT '',
    `base_salary_max` DECIMAL(18,2) COMMENT '',
    `base_salary_min` DECIMAL(18,2) COMMENT '',
    `benefits_package_code` STRING COMMENT '',
    `bonus_eligible` BOOLEAN COMMENT '',
    `bonus_target_percentage` DECIMAL(18,2) COMMENT '',
    `brand_segment` STRING COMMENT '',
    `commission_eligible` BOOLEAN COMMENT '',
    `commission_rate` DECIMAL(18,2) COMMENT '',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT '',
    `compa_ratio_target` DECIMAL(18,2) COMMENT '',
    `compensation_plan_description` STRING COMMENT '',
    `compensation_plan_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `flsa_status` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `is_unionized` BOOLEAN COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT '',
    `market_pricing_date` DATE COMMENT '',
    `market_pricing_source` STRING COMMENT '',
    `maximum_rate` DECIMAL(18,2) COMMENT '',
    `merit_increase_cycle` STRING COMMENT '',
    `merit_increase_eligible` BOOLEAN COMMENT '',
    `midpoint_rate` DECIMAL(18,2) COMMENT '',
    `minimum_rate` DECIMAL(18,2) COMMENT '',
    `modified_timestamp` TIMESTAMP COMMENT '',
    `overtime_eligible` BOOLEAN COMMENT '',
    `overtime_multiplier` DECIMAL(18,2) COMMENT '',
    `pay_frequency` STRING COMMENT '',
    `plan_code` STRING COMMENT '',
    `plan_name` STRING COMMENT '',
    `plan_status` STRING COMMENT '',
    `plan_type` STRING COMMENT '',
    `rate_unit` DECIMAL(18,2) COMMENT '',
    `service_charge_eligible` BOOLEAN COMMENT '',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT '',
    `tip_credit_eligible` BOOLEAN COMMENT '',
    `union_affiliation` STRING COMMENT '',
    `usali_department` STRING COMMENT '',
    CONSTRAINT pk_procurement_compensation_plan PRIMARY KEY(`procurement_compensation_plan_id`)
) COMMENT 'Compensation plan details for procurement domain employees';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ADD CONSTRAINT `fk_workforce_learning_course_prerequisite_course_learning_course_id` FOREIGN KEY (`prerequisite_course_learning_course_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`learning_course`(`learning_course_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_position` ADD CONSTRAINT `fk_workforce_workforce_position_workforce_org_unit_id` FOREIGN KEY (`workforce_org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_org_unit`(`workforce_org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_org_unit` ADD CONSTRAINT `fk_workforce_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_org_unit`(`workforce_org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_workforce_employee_id` FOREIGN KEY (`workforce_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee`(`workforce_employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan` ADD CONSTRAINT `fk_workforce_workforce_compensation_plan_workforce_employee_id` FOREIGN KEY (`workforce_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee`(`workforce_employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_disciplinary_action` ADD CONSTRAINT `fk_workforce_workforce_disciplinary_action_workforce_employee_id` FOREIGN KEY (`workforce_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee`(`workforce_employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_job_requisition` ADD CONSTRAINT `fk_workforce_workforce_job_requisition_workforce_org_unit_id` FOREIGN KEY (`workforce_org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_org_unit`(`workforce_org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_job_requisition` ADD CONSTRAINT `fk_workforce_workforce_job_requisition_workforce_position_id` FOREIGN KEY (`workforce_position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_position`(`workforce_position_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Course ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `prerequisite_course_learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `certificate_template_code` SET TAGS ('dbx_business_glossary_term' = 'Certificate Template ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `content_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credits (CEU)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Learner');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_development|retired|suspended');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'mandatory|optional|recommended|certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'instructor_led|online|blended|on_the_job|virtual_classroom');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Course Duration Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `last_content_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Update Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `max_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Training Vendor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `vendor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `vendor_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee` ALTER COLUMN `email` SET TAGS ('dbx_pii' = 'email');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii' = 'person_name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii' = 'person_name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_position` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_org_unit` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` SET TAGS ('dbx_subdomain' = 'learning_development');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan` ALTER COLUMN `workforce_compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan` ALTER COLUMN `workforce_compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_compensation_plan` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_disciplinary_action` SET TAGS ('dbx_subdomain' = 'compensation_benefits');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_disciplinary_action` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_disciplinary_action` ALTER COLUMN `workforce_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_disciplinary_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_typed' = 'numeric_correction');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_job_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_job_requisition` SET TAGS ('dbx_subdomain' = 'people_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_benefit_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_benefit_plan` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_typed' = 'numeric_correction');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_benefit_plan` ALTER COLUMN `coverage_level` SET TAGS ('dbx_typed' = 'numeric_correction');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `procurement_compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `procurement_compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `procurement_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `procurement_employee_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `base_salary_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `base_salary_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `base_salary_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `base_salary_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`procurement_compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii' = 'true');
