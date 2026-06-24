-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`workforce` COMMENT 'Healthcare workforce and human capital management. Owns employees, physicians, contract staff, FTE (Full-Time Equivalent) tracking, credentialing, privileging, competency assessments, CME (Continuing Medical Education), shift scheduling, time and attendance, payroll, benefits, talent management, and OSHA compliance. Integrates with Workday HCM and Symplr credentialing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record.',
    `care_site_id` BIGINT COMMENT 'FK to the facility care site where the employee primarily works.',
    `manager_employee_id` BIGINT COMMENT 'Self-referential FK to the employees direct manager.',
    `position_id` BIGINT COMMENT 'FK to the position the employee currently holds.',
    `background_check_status` STRING COMMENT 'Status of the employees background check (e.g., cleared, pending, failed).',
    `bill_rate` DECIMAL(18,2) COMMENT 'Billing rate for contract or agency employees.',
    `clinical_role_type` STRING COMMENT 'Type of clinical role (e.g., RN, MD, PA, NP) if applicable.',
    `cme_hours_completed` DECIMAL(18,2) COMMENT 'Continuing medical education hours completed in current cycle.',
    `cme_hours_required` DECIMAL(18,2) COMMENT 'CME hours required for the current compliance period.',
    `contract_end_date` DATE COMMENT 'End date of the employees contract if applicable.',
    `contract_start_date` DATE COMMENT 'Start date of the employees contract if applicable.',
    `cost_center_code` STRING COMMENT 'Cost center code for labor cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was created.',
    `credential_verification_status` STRING COMMENT 'Status of credential verification (e.g., verified, pending, expired).',
    `date_of_birth` DATE COMMENT 'Employee date of birth for identity and benefits administration.',
    `department_code` STRING COMMENT 'Department code where the employee is assigned.',
    `employment_status` STRING COMMENT 'Current employment status (active, terminated, on leave, etc.).',
    `employment_type` STRING COMMENT 'Type of employment (full-time, part-time, PRN, contract, agency).',
    `first_name` STRING COMMENT 'Employee first name.',
    `flsa_classification` STRING COMMENT 'FLSA classification (exempt or non-exempt) for overtime eligibility.',
    `fte_value` DECIMAL(18,2) COMMENT 'Full-time equivalent value for the employee.',
    `gender` STRING COMMENT 'Employee gender for HR demographics.',
    `hire_date` DATE COMMENT 'Most recent hire date for the employee.',
    `last_name` STRING COMMENT 'Employee last name.',
    `license_expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of the employees professional license.',
    `license_number` STRING COMMENT 'Professional license number.',
    `license_state` STRING COMMENT 'State where the professional license was issued.',
    `middle_name` STRING COMMENT 'Employee middle name.',
    `oig_exclusion_check_date` DATE COMMENT 'Date of last OIG exclusion list check.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'Whether OIG exclusion check has been performed.',
    `original_hire_date` DATE COMMENT 'Original hire date for rehired employees.',
    `osha_training_current` BOOLEAN COMMENT 'Whether OSHA safety training is current.',
    `pay_rate` DECIMAL(18,2) COMMENT 'Current pay rate for the employee.',
    `personal_email` STRING COMMENT 'Personal email address of the employee.',
    `preferred_name` STRING COMMENT 'Preferred name or nickname of the employee.',
    `primary_specialty` STRING COMMENT 'Primary clinical specialty if applicable.',
    `rehire_eligible` BOOLEAN COMMENT 'Whether the employee is eligible for rehire.',
    `staffing_agency_name` STRING COMMENT 'Name of staffing agency for contract/agency employees.',
    `termination_date` DATE COMMENT 'Date of employment termination if applicable.',
    `termination_reason` STRING COMMENT 'Reason for termination (voluntary, involuntary, retirement, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update to the employee record.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `work_email` STRING COMMENT 'Work email address.',
    `work_phone` STRING COMMENT 'Work phone number.',
    `workday_worker_code` STRING COMMENT 'Workday system worker identifier for integration.',
    `worker_category` STRING COMMENT 'Category of worker (e.g., regular, temporary, contingent).',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Core workforce entity representing all employees including clinical and non-clinical staff across the health system.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position.',
    `care_site_id` BIGINT COMMENT 'FK to the facility care site where the position is located.',
    `job_profile_id` BIGINT COMMENT 'FK to the job profile defining the position requirements.',
    `org_unit_id` BIGINT COMMENT 'FK to the department org unit.',
    `npi_registry_id` BIGINT COMMENT 'FK to NPI registry if position requires NPI.',
    `reports_to_position_id` BIGINT COMMENT 'Self-referential FK to the position this one reports to.',
    `tertiary_position_workforce_org_unit_id` BIGINT COMMENT 'FK to the primary org unit for the position.',
    `approved_by` STRING COMMENT 'Name or ID of person who approved the position.',
    `approved_date` DATE COMMENT 'Date the position was approved.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'Budgeted FTE for this position.',
    `cme_hours_required` DECIMAL(18,2) COMMENT 'CME hours required for this position.',
    `position_code` STRING COMMENT 'Unique position code identifier.',
    `cost_center_code` STRING COMMENT 'Cost center code for financial allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position was created.',
    `effective_date` DATE COMMENT 'Date the position becomes effective.',
    `employment_category` STRING COMMENT 'Employment category (regular, temporary, etc.).',
    `end_date` DATE COMMENT 'End date if the position is time-limited.',
    `flsa_classification` STRING COMMENT 'FLSA classification for the position.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'FTE allocation for the position.',
    `headcount_count` STRING COMMENT 'Number of headcount slots for this position.',
    `is_clinical` BOOLEAN COMMENT 'Whether this is a clinical position.',
    `is_critical_role` BOOLEAN COMMENT 'Whether this position is designated as critical.',
    `is_management` BOOLEAN COMMENT 'Whether this is a management position.',
    `is_provider` BOOLEAN COMMENT 'Whether this position is a provider role.',
    `is_union_eligible` BOOLEAN COMMENT 'Whether this position is union eligible.',
    `job_family` STRING COMMENT 'Job family grouping for the position.',
    `location_type` STRING COMMENT 'Location type (on-site, remote, hybrid).',
    `osha_job_hazard_category` STRING COMMENT 'OSHA job hazard category for safety compliance.',
    `pay_grade` STRING COMMENT 'Pay grade level for the position.',
    `pay_range_max` DECIMAL(18,2) COMMENT 'Maximum pay range for the position.',
    `pay_range_min` DECIMAL(18,2) COMMENT 'Minimum pay range for the position.',
    `position_status` STRING COMMENT 'Current status of the position (open, filled, frozen, closed).',
    `position_type` STRING COMMENT 'Type of position (permanent, temporary, contract).',
    `required_certification` STRING COMMENT 'Required certifications for the position.',
    `required_education_level` STRING COMMENT 'Minimum education level required.',
    `required_license_type` STRING COMMENT 'Type of license required for the position.',
    `shift_type` STRING COMMENT 'Shift type (day, night, rotating, etc.).',
    `source_system_code` STRING COMMENT 'Source system code for integration.',
    `source_system_position_code` STRING COMMENT 'Position code in the source system.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard hours per week for the position.',
    `title` STRING COMMENT 'Position title.',
    `union_code` STRING COMMENT 'Union code if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vacancy_reason` STRING COMMENT 'Reason for vacancy if position is open.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Defines authorized positions within the organization including clinical and non-clinical roles with associated requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique identifier for the job profile.',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code defining scope of practice.',
    `background_check_required` BOOLEAN COMMENT 'Whether background check is required.',
    `certification_required` BOOLEAN COMMENT 'Whether certification is required.',
    `clinical_role_indicator` BOOLEAN COMMENT 'Whether this is a clinical role.',
    `cme_compliance_period_months` STRING COMMENT 'CME compliance period in months.',
    `cme_hours_required` DECIMAL(18,2) COMMENT 'CME hours required per compliance period.',
    `competency_framework_code` STRING COMMENT 'Code for the competency framework applicable to this profile.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profile was created.',
    `dea_registration_required` DECIMAL(18,2) COMMENT 'Whether DEA registration is required.',
    `drug_screen_required` BOOLEAN COMMENT 'Whether drug screening is required.',
    `effective_date` DATE COMMENT 'Date the profile becomes effective.',
    `employment_type` STRING COMMENT 'Employment type for this profile.',
    `end_date` DATE COMMENT 'End date if the profile is retired.',
    `flsa_status` STRING COMMENT 'FLSA status (exempt/non-exempt).',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'FTE equivalent for the profile.',
    `hipaa_access_level` STRING COMMENT 'HIPAA access level required.',
    `job_category` STRING COMMENT 'Job category classification.',
    `job_code` STRING COMMENT 'Unique job code.',
    `job_description` STRING COMMENT 'Full job description text.',
    `job_family` STRING COMMENT 'Job family grouping.',
    `job_family_group` STRING COMMENT 'Higher-level job family group.',
    `job_level` STRING COMMENT 'Job level within the hierarchy.',
    `job_title` STRING COMMENT 'Standard job title.',
    `last_reviewed_date` DATE COMMENT 'Date the profile was last reviewed.',
    `licensure_required` BOOLEAN COMMENT 'Whether licensure is required.',
    `management_level` STRING COMMENT 'Management level designation.',
    `minimum_education_level` STRING COMMENT 'Minimum education level required.',
    `minimum_experience_years` DECIMAL(18,2) COMMENT 'Minimum years of experience required.',
    `npi_required` BOOLEAN COMMENT 'Whether NPI is required.',
    `on_call_required` BOOLEAN COMMENT 'Whether on-call duty is required.',
    `osha_exposure_category` STRING COMMENT 'OSHA exposure category for safety compliance.',
    `pay_grade` STRING COMMENT 'Pay grade for the profile.',
    `pay_range_max` DECIMAL(18,2) COMMENT 'Maximum pay range.',
    `pay_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint of pay range.',
    `pay_range_min` DECIMAL(18,2) COMMENT 'Minimum pay range.',
    `pay_rate_type` STRING COMMENT 'Type of pay rate (hourly, salary, per diem).',
    `privileging_required` BOOLEAN COMMENT 'Whether privileging is required.',
    `profile_status` STRING COMMENT 'Status of the job profile (active, inactive, draft).',
    `remote_eligible` BOOLEAN COMMENT 'Whether the role is eligible for remote work.',
    `required_certifications` STRING COMMENT 'List of required certifications.',
    `required_license_types` STRING COMMENT 'List of required license types.',
    `rvu_eligible` BOOLEAN COMMENT 'Whether the role is RVU-eligible for productivity tracking.',
    `shift_type` STRING COMMENT 'Shift type for the profile.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard hours per week.',
    `travel_required` BOOLEAN COMMENT 'Whether travel is required.',
    `union_code` STRING COMMENT 'Union code if applicable.',
    `union_eligible` BOOLEAN COMMENT 'Whether the role is union eligible.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `workday_job_profile_code` STRING COMMENT 'Workday job profile code for integration.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Defines job profiles with requirements, qualifications, and compensation parameters for healthcare workforce positions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` (
    `employment_competency_id` BIGINT COMMENT 'Unique identifier.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `clinician_id` BIGINT COMMENT 'FK to clinician.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code for privilege scope.',
    `hcpcs_code_id` BIGINT COMMENT 'FK to HCPCS code for privilege scope.',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code for privilege scope.',
    `application_complete_date` DATE COMMENT 'Date application was completed.',
    `application_decision` STRING COMMENT 'Decision on the application.',
    `application_decision_date` DATE COMMENT 'Date of application decision.',
    `application_submission_date` DATE COMMENT 'Date application was submitted.',
    `application_type` STRING COMMENT 'Type of application.',
    `appointment_effective_date` DATE COMMENT 'Effective date of appointment.',
    `appointment_expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of appointment.',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'CME credit hours earned.',
    `cme_requirement_hours` DECIMAL(18,2) COMMENT 'CME hours required.',
    `committee_review_date` DATE COMMENT 'Date of committee review.',
    `competency_assessment_date` DATE COMMENT 'Date of competency assessment.',
    `competency_assessment_score` DECIMAL(18,2) COMMENT 'Score from competency assessment.',
    `competency_type` STRING COMMENT 'Type of competency.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credential_category` STRING COMMENT 'Category of credential.',
    `credential_number` STRING COMMENT 'Credential number.',
    `credential_status` STRING COMMENT 'Status of the credential.',
    `denial_reason` STRING COMMENT 'Reason for denial if applicable.',
    `department_name` STRING COMMENT 'Department name.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of the competency/credential.',
    `issue_date` DATE COMMENT 'Date the credential was issued.',
    `issuing_authority` STRING COMMENT 'Authority that issued the credential.',
    `issuing_country` STRING COMMENT 'Country of issuance.',
    `issuing_state` STRING COMMENT 'State of issuance.',
    `malpractice_coverage_verified` BOOLEAN COMMENT 'Whether malpractice coverage is verified.',
    `medical_staff_category` STRING COMMENT 'Medical staff category.',
    `medical_staff_committee` STRING COMMENT 'Medical staff committee assignment.',
    `npdb_query_date` DATE COMMENT 'Date of NPDB query.',
    `npdb_query_result` STRING COMMENT 'Result of NPDB query.',
    `oig_exclusion_check_date` DATE COMMENT 'Date of OIG exclusion check.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'Whether OIG exclusion was checked.',
    `primary_source_verified` BOOLEAN COMMENT 'Whether primary source verification was done.',
    `privilege_category` STRING COMMENT 'Category of privilege.',
    `privilege_effective_date` DATE COMMENT 'Effective date of privilege.',
    `privilege_expiration_date` DECIMAL(18,2) COMMENT 'Expiration date of privilege.',
    `privilege_grant_date` DATE COMMENT 'Date privilege was granted.',
    `privilege_procedure_code` STRING COMMENT 'Procedure code for the privilege.',
    `privilege_procedure_name` STRING COMMENT 'Name of the privileged procedure.',
    `privilege_status` STRING COMMENT 'Status of the privilege.',
    `psv_date` DATE COMMENT 'Primary source verification date.',
    `psv_method` STRING COMMENT 'Method of primary source verification.',
    `renewal_date` DATE COMMENT 'Renewal date.',
    `sam_exclusion_checked` BOOLEAN COMMENT 'Whether SAM exclusion was checked.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_employment_competency PRIMARY KEY(`employment_competency_id`)
) COMMENT 'Tracks employee competencies, credentials, privileges, and compliance requirements for healthcare workforce management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` (
    `competency_assessment_id` BIGINT COMMENT 'Unique identifier.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `clinician_id` BIGINT COMMENT 'FK to clinician.',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED concept.',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code.',
    `education_program_id` BIGINT COMMENT 'FK to education program.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `employee_id` BIGINT COMMENT 'FK to employee being assessed.',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code.',
    `administration_route` DECIMAL(18,2) COMMENT 'Route of administration for vaccine/medication competency.',
    `administration_site` DECIMAL(18,2) COMMENT 'Site of administration.',
    `assessment_category` STRING COMMENT 'Category of assessment.',
    `assessment_date` DATE COMMENT 'Date of assessment.',
    `assessment_method` STRING COMMENT 'Method used for assessment.',
    `assessment_number` STRING COMMENT 'Assessment tracking number.',
    `assessment_status` STRING COMMENT 'Status of the assessment.',
    `assessment_type` STRING COMMENT 'Type of assessment.',
    `attempt_number` STRING COMMENT 'Attempt number for the assessment.',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'CME credit hours earned.',
    `competency_domain` STRING COMMENT 'Domain of competency.',
    `competency_name` STRING COMMENT 'Name of the competency.',
    `compliance_status` STRING COMMENT 'Compliance status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `declination_reason` STRING COMMENT 'Reason for declination if applicable.',
    `department_name` STRING COMMENT 'Department name.',
    `due_date` DATE COMMENT 'Due date for the assessment.',
    `fit_test_protocol` STRING COMMENT 'Fit test protocol used.',
    `job_role_applicability` STRING COMMENT 'Job roles this assessment applies to.',
    `medical_contraindication` BOOLEAN COMMENT 'Whether there is a medical contraindication.',
    `n95_respirator_model` STRING COMMENT 'N95 respirator model for fit testing.',
    `next_due_date` DATE COMMENT 'Next due date for reassessment.',
    `notes` STRING COMMENT 'Additional notes.',
    `outcome` STRING COMMENT 'Outcome of the assessment.',
    `passing_score` DECIMAL(18,2) COMMENT 'Passing score threshold.',
    `prior_immunity_documented` BOOLEAN COMMENT 'Whether prior immunity is documented.',
    `reassessment_date` DATE COMMENT 'Date of reassessment.',
    `regulatory_requirement` STRING COMMENT 'Regulatory requirement driving the assessment.',
    `remediation_due_date` DATE COMMENT 'Due date for remediation.',
    `remediation_plan` STRING COMMENT 'Remediation plan details.',
    `remediation_required` BOOLEAN COMMENT 'Whether remediation is required.',
    `result_interpretation` STRING COMMENT 'Interpretation of the result.',
    `result_value` DECIMAL(18,2) COMMENT 'Numeric result value.',
    `score` DECIMAL(18,2) COMMENT 'Assessment score.',
    `source_record_reference` STRING COMMENT 'Reference to source record.',
    `titer_result` STRING COMMENT 'Titer result for immunity testing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vaccine_dose_number` STRING COMMENT 'Vaccine dose number.',
    `vaccine_lot_number` STRING COMMENT 'Vaccine lot number.',
    `vaccine_manufacturer` STRING COMMENT 'Vaccine manufacturer.',
    `vaccine_ndc` STRING COMMENT 'Vaccine NDC code.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_competency_assessment PRIMARY KEY(`competency_assessment_id`)
) COMMENT 'Records individual competency assessments including clinical skills, immunizations, fit testing, and regulatory compliance evaluations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `clinician_id` BIGINT COMMENT 'FK to clinician.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `employee_id` BIGINT COMMENT 'FK to employee assigned to shift.',
    `swap_source_schedule_id` BIGINT COMMENT 'Self-referential FK for shift swaps.',
    `unit_id` BIGINT COMMENT 'FK to facility unit.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual end time of shift.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Actual hours worked.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual start time of shift.',
    `agency_name` STRING COMMENT 'Agency name for agency staff.',
    `approval_datetime` TIMESTAMP COMMENT 'Approval timestamp.',
    `assignment_status` STRING COMMENT 'Status of the shift assignment.',
    `break_minutes` STRING COMMENT 'Break time in minutes.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation.',
    `care_setting` STRING COMMENT 'Care setting type.',
    `created_datetime` TIMESTAMP COMMENT 'Record creation timestamp.',
    `fte_value` DECIMAL(18,2) COMMENT 'FTE value for the shift.',
    `is_agency_staff` BOOLEAN COMMENT 'Whether this is agency staff.',
    `is_charge_role` BOOLEAN COMMENT 'Whether this is a charge nurse role.',
    `is_float_assignment` BOOLEAN COMMENT 'Whether this is a float assignment.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Last update timestamp.',
    `nurse_to_patient_ratio` DECIMAL(18,2) COMMENT 'Nurse to patient ratio for the shift.',
    `on_call_response_minutes` STRING COMMENT 'On-call response time in minutes.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Overtime hours worked.',
    `patient_census` STRING COMMENT 'Patient census during shift.',
    `pay_code` STRING COMMENT 'Pay code for the shift.',
    `published_datetime` TIMESTAMP COMMENT 'When the schedule was published.',
    `required_fte_coverage` DECIMAL(18,2) COMMENT 'Required FTE coverage.',
    `schedule_notes` STRING COMMENT 'Schedule notes.',
    `schedule_number` STRING COMMENT 'Schedule tracking number.',
    `schedule_period_end_date` DATE COMMENT 'End of schedule period.',
    `schedule_period_start_date` DATE COMMENT 'Start of schedule period.',
    `schedule_status` STRING COMMENT 'Status of the schedule.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'Scheduled end time.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Scheduled hours.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Scheduled start time.',
    `shift_category` STRING COMMENT 'Category of shift.',
    `shift_date` DATE COMMENT 'Date of the shift.',
    `shift_type` STRING COMMENT 'Type of shift (day, night, etc.).',
    `source_system_code` STRING COMMENT 'Source system code.',
    `source_system_record_code` STRING COMMENT 'Source system record code.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Manages shift scheduling for healthcare workforce including staffing assignments, coverage tracking, and labor optimization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` (
    `time_attendance_id` BIGINT COMMENT 'Unique identifier.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `chart_of_accounts_id` BIGINT COMMENT 'FK to chart of accounts.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center.',
    `fiscal_period_id` BIGINT COMMENT 'FK to fiscal period.',
    `payroll_run_id` BIGINT COMMENT 'FK to payroll run.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `approval_status` STRING COMMENT 'Approval status of the time entry.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp of approval.',
    `base_pay_rate` DECIMAL(18,2) COMMENT 'Base pay rate.',
    `benefits_deduction` DECIMAL(18,2) COMMENT 'Benefits deduction amount.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Bonus amount.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Clock in timestamp.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Clock out timestamp.',
    `correction_reason` STRING COMMENT 'Reason for time correction.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `flsa_compliance_flag` BOOLEAN COMMENT 'FLSA compliance flag.',
    `flsa_exempt` BOOLEAN COMMENT 'Whether employee is FLSA exempt.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'FTE percentage.',
    `garnishment_deduction` DECIMAL(18,2) COMMENT 'Garnishment deduction amount.',
    `gl_account_code` STRING COMMENT 'GL account code for posting.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Gross pay amount.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `leave_type` STRING COMMENT 'Type of leave if applicable.',
    `meal_break_minutes` STRING COMMENT 'Meal break duration in minutes.',
    `missed_punch_count` STRING COMMENT 'Number of missed punches.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Net pay amount.',
    `on_call_hours` DECIMAL(18,2) COMMENT 'On-call hours.',
    `osha_incident_related` BOOLEAN COMMENT 'Whether related to an OSHA incident.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Overtime hours worked.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Overtime pay amount.',
    `pay_period_end_date` DATE COMMENT 'Pay period end date.',
    `pay_period_start_date` DATE COMMENT 'Pay period start date.',
    `pay_type` STRING COMMENT 'Type of pay.',
    `payment_method` STRING COMMENT 'Payment method.',
    `payroll_run_date` DATE COMMENT 'Payroll run date.',
    `payroll_run_status` STRING COMMENT 'Status of payroll run.',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Regular hours worked.',
    `shift_date` DATE COMMENT 'Date of the shift.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Shift differential pay amount.',
    `shift_type` STRING COMMENT 'Type of shift.',
    `time_entry_type` STRING COMMENT 'Type of time entry.',
    `timekeeper_corrected` BOOLEAN COMMENT 'Whether timekeeper made a correction.',
    `total_tax_deduction` DECIMAL(18,2) COMMENT 'Total tax deduction amount.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_time_attendance PRIMARY KEY(`time_attendance_id`)
) COMMENT 'Tracks time and attendance records including clock events, pay calculations, and payroll integration for workforce management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier.',
    `benefit_plan_id` BIGINT COMMENT 'FK to benefit plan.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `aca_affordability_flag` BOOLEAN COMMENT 'ACA affordability flag.',
    `aca_minimum_essential_coverage_flag` BOOLEAN COMMENT 'ACA minimum essential coverage flag.',
    `aca_minimum_value_flag` BOOLEAN COMMENT 'ACA minimum value flag.',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'Annual election amount for FSA/HSA.',
    `beneficiary_name` STRING COMMENT 'Name of beneficiary.',
    `beneficiary_relationship` STRING COMMENT 'Relationship of beneficiary.',
    `benefit_type` STRING COMMENT 'Type of benefit.',
    `carrier_confirmation_date` DATE COMMENT 'Date carrier confirmed enrollment.',
    `carrier_eligibility_sent_date` DATE COMMENT 'Date eligibility was sent to carrier.',
    `carrier_group_number` STRING COMMENT 'Carrier group number.',
    `carrier_member_number` STRING COMMENT 'Carrier member number.',
    `carrier_name` STRING COMMENT 'Insurance carrier name.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'COBRA eligibility flag.',
    `cobra_notification_date` DATE COMMENT 'COBRA notification date.',
    `coverage_tier` STRING COMMENT 'Coverage tier (employee only, family, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `deduction_frequency` STRING COMMENT 'Frequency of deductions.',
    `dependent_count` STRING COMMENT 'Number of dependents covered.',
    `disability_benefit_type` STRING COMMENT 'Type of disability benefit.',
    `effective_date` DATE COMMENT 'Effective date of enrollment.',
    `employee_premium_amount` DECIMAL(18,2) COMMENT 'Employee premium amount.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount.',
    `employer_match_rate` DECIMAL(18,2) COMMENT 'Employer match rate for retirement.',
    `employer_premium_amount` DECIMAL(18,2) COMMENT 'Employer premium amount.',
    `enrollment_confirmation_number` STRING COMMENT 'Enrollment confirmation number.',
    `enrollment_number` STRING COMMENT 'Enrollment tracking number.',
    `enrollment_source` STRING COMMENT 'Source of enrollment.',
    `enrollment_status` STRING COMMENT 'Status of enrollment.',
    `enrollment_submitted_date` DATE COMMENT 'Date enrollment was submitted.',
    `fsa_plan_type` STRING COMMENT 'FSA plan type.',
    `hsa_contribution_limit` DECIMAL(18,2) COMMENT 'HSA contribution limit.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `life_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Life insurance coverage amount.',
    `open_enrollment_period` STRING COMMENT 'Open enrollment period.',
    `other_coverage_carrier` STRING COMMENT 'Other coverage carrier name.',
    `plan_year` STRING COMMENT 'Plan year.',
    `pretax_flag` BOOLEAN COMMENT 'Whether deduction is pre-tax.',
    `qualifying_life_event_type` STRING COMMENT 'Qualifying life event type.',
    `retirement_contribution_rate` DECIMAL(18,2) COMMENT 'Retirement contribution rate.',
    `termination_date` DATE COMMENT 'Benefit termination date.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `waiver_reason` STRING COMMENT 'Reason for waiving coverage.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Tracks employee benefit enrollments including health insurance, retirement, FSA/HSA, life insurance, and COBRA eligibility.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `approved_by` STRING COMMENT 'Approver name or ID.',
    `approved_end_date` DATE COMMENT 'Approved end date.',
    `approved_start_date` DATE COMMENT 'Approved start date.',
    `benefits_continuation` BOOLEAN COMMENT 'Whether benefits continue during leave.',
    `cobra_notification_sent` BOOLEAN COMMENT 'Whether COBRA notification was sent.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `denial_reason` STRING COMMENT 'Reason for denial.',
    `fitness_for_duty_received_date` DATE COMMENT 'Date fitness for duty was received.',
    `fitness_for_duty_required` BOOLEAN COMMENT 'Whether fitness for duty is required.',
    `fmla_eligibility_determination_date` DATE COMMENT 'FMLA eligibility determination date.',
    `fmla_eligible` BOOLEAN COMMENT 'Whether employee is FMLA eligible.',
    `fmla_hours_remaining` DECIMAL(18,2) COMMENT 'FMLA hours remaining.',
    `fmla_hours_used` DECIMAL(18,2) COMMENT 'FMLA hours used.',
    `hr_notes` STRING COMMENT 'HR notes.',
    `intermittent_duration_hours` DECIMAL(18,2) COMMENT 'Duration of intermittent leave in hours.',
    `intermittent_frequency` STRING COMMENT 'Frequency of intermittent leave.',
    `is_intermittent` BOOLEAN COMMENT 'Whether leave is intermittent.',
    `leave_duration_days` DECIMAL(18,2) COMMENT 'Duration of leave in days.',
    `leave_reason` STRING COMMENT 'Reason for leave.',
    `leave_type` STRING COMMENT 'Type of leave.',
    `leave_year_start_date` DATE COMMENT 'Leave year start date.',
    `medical_certification_expiration_date` DECIMAL(18,2) COMMENT 'Medical certification expiration.',
    `medical_certification_received_date` DATE COMMENT 'Medical certification received date.',
    `medical_certification_required` BOOLEAN COMMENT 'Whether medical certification is required.',
    `military_order_number` STRING COMMENT 'Military order number for USERRA leave.',
    `military_service_branch` STRING COMMENT 'Military service branch.',
    `notice_provided_date` DATE COMMENT 'Date notice was provided.',
    `pay_status` STRING COMMENT 'Pay status during leave.',
    `pto_hours_applied` DECIMAL(18,2) COMMENT 'PTO hours applied.',
    `request_number` STRING COMMENT 'Request tracking number.',
    `request_status` STRING COMMENT 'Status of the request.',
    `requested_end_date` DATE COMMENT 'Requested end date.',
    `requested_start_date` DATE COMMENT 'Requested start date.',
    `return_to_work_date` DATE COMMENT 'Return to work date.',
    `return_to_work_status` STRING COMMENT 'Return to work status.',
    `submission_timestamp` TIMESTAMP COMMENT 'Submission timestamp.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `workday_absence_code` STRING COMMENT 'Workday absence code.',
    `workers_comp_claim_number` STRING COMMENT 'Workers comp claim number if applicable.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Manages employee leave requests including FMLA, military, medical, and PTO with compliance tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `employee_id` BIGINT COMMENT 'FK to employee being reviewed.',
    `review_template_id` BIGINT COMMENT 'FK to review template.',
    `reviewer_worker_employee_id` BIGINT COMMENT 'FK to reviewing employee.',
    `appeal_filed` BOOLEAN COMMENT 'Whether an appeal was filed.',
    `appeal_resolution_date` DATE COMMENT 'Date appeal was resolved.',
    `appeal_status` STRING COMMENT 'Status of appeal.',
    `calibration_date` DECIMAL(18,2) COMMENT 'Date of calibration session.',
    `calibration_status` STRING COMMENT 'Calibration status.',
    `career_interest_narrative` STRING COMMENT 'Career interest narrative.',
    `cme_hours_completed` DECIMAL(18,2) COMMENT 'CME hours completed during review period.',
    `competency_rating` STRING COMMENT 'Competency rating.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `development_goals_narrative` STRING COMMENT 'Development goals narrative.',
    `discipline_type` STRING COMMENT 'Type of discipline if applicable.',
    `due_date` DATE COMMENT 'Due date for review completion.',
    `employee_acknowledgment_date` DATE COMMENT 'Date employee acknowledged review.',
    `goal_achievement_rating` STRING COMMENT 'Goal achievement rating.',
    `is_high_potential` BOOLEAN COMMENT 'Whether employee is high potential.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `manager_feedback` STRING COMMENT 'Manager feedback narrative.',
    `manager_submission_date` DATE COMMENT 'Date manager submitted review.',
    `mentorship_participant` BOOLEAN COMMENT 'Whether employee participates in mentorship.',
    `merit_increase_eligible` BOOLEAN COMMENT 'Whether eligible for merit increase.',
    `merit_increase_percent` DECIMAL(18,2) COMMENT 'Merit increase percentage.',
    `mobility_preference` STRING COMMENT 'Mobility preference.',
    `overall_rating` STRING COMMENT 'Overall performance rating.',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric overall rating score.',
    `pip_end_date` DATE COMMENT 'PIP end date.',
    `pip_outcome` STRING COMMENT 'PIP outcome.',
    `pip_start_date` DATE COMMENT 'PIP start date.',
    `policy_violation_code` STRING COMMENT 'Policy violation code if applicable.',
    `promotion_eligible` BOOLEAN COMMENT 'Whether eligible for promotion.',
    `review_meeting_date` DATE COMMENT 'Date of review meeting.',
    `review_number` STRING COMMENT 'Review tracking number.',
    `review_period_end_date` DATE COMMENT 'Review period end date.',
    `review_period_start_date` DATE COMMENT 'Review period start date.',
    `review_status` STRING COMMENT 'Status of the review.',
    `review_type` STRING COMMENT 'Type of review.',
    `self_assessment_narrative` STRING COMMENT 'Self-assessment narrative.',
    `source_system_review_code` STRING COMMENT 'Source system review code.',
    `succession_plan_included` BOOLEAN COMMENT 'Whether included in succession plan.',
    `talent_segment` STRING COMMENT 'Talent segment classification.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Tracks employee performance reviews, ratings, development goals, and disciplinary actions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` (
    `recruitment_id` BIGINT COMMENT 'Unique identifier.',
    `applicant_id` BIGINT COMMENT 'FK to applicant.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `job_profile_id` BIGINT COMMENT 'FK to job profile.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `employee_id` BIGINT COMMENT 'FK to recruiter employee.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `actual_start_date` DATE COMMENT 'Actual start date.',
    `applicant_email` STRING COMMENT 'Applicant email address.',
    `applicant_phone` STRING COMMENT 'Applicant phone number.',
    `application_date` DATE COMMENT 'Application date.',
    `background_check_date` DATE COMMENT 'Background check date.',
    `background_check_status` STRING COMMENT 'Background check status.',
    `badge_issued` BOOLEAN COMMENT 'Whether badge was issued.',
    `cost_per_hire` DECIMAL(18,2) COMMENT 'Cost per hire.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `drug_screen_status` STRING COMMENT 'Drug screen status.',
    `employment_type` STRING COMMENT 'Employment type.',
    `fire_safety_training_completed` BOOLEAN COMMENT 'Fire safety training completed.',
    `fte_value` DECIMAL(18,2) COMMENT 'FTE value.',
    `hipaa_training_completed` BOOLEAN COMMENT 'HIPAA training completed.',
    `hire_date` DATE COMMENT 'Hire date.',
    `hire_decision` STRING COMMENT 'Hire decision.',
    `i9_completion_date` DATE COMMENT 'I-9 completion date.',
    `i9_verification_status` STRING COMMENT 'I-9 verification status.',
    `infection_control_training_completed` BOOLEAN COMMENT 'Infection control training completed.',
    `interview_date` DATE COMMENT 'Interview date.',
    `interview_stage` STRING COMMENT 'Current interview stage.',
    `is_clinical_position` BOOLEAN COMMENT 'Whether this is a clinical position.',
    `license_verified` BOOLEAN COMMENT 'Whether license was verified.',
    `offer_accepted_date` DATE COMMENT 'Date offer was accepted.',
    `offer_date` DATE COMMENT 'Date offer was made.',
    `offer_status` STRING COMMENT 'Status of the offer.',
    `offered_salary` DECIMAL(18,2) COMMENT 'Offered salary.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'OIG exclusion checked.',
    `onboarding_completion_date` DATE COMMENT 'Onboarding completion date.',
    `onboarding_status` STRING COMMENT 'Onboarding status.',
    `onboarding_target_completion_date` DATE COMMENT 'Target onboarding completion date.',
    `orientation_completion_date` DATE COMMENT 'Orientation completion date.',
    `orientation_status` STRING COMMENT 'Orientation status.',
    `pay_grade` STRING COMMENT 'Pay grade.',
    `pipeline_stage` STRING COMMENT 'Pipeline stage.',
    `policy_acknowledgment_completed` BOOLEAN COMMENT 'Policy acknowledgment completed.',
    `posting_date` DATE COMMENT 'Job posting date.',
    `required_license_type` STRING COMMENT 'Required license type.',
    `requisition_number` STRING COMMENT 'Requisition number.',
    `requisition_open_date` DATE COMMENT 'Requisition open date.',
    `requisition_status` STRING COMMENT 'Requisition status.',
    `source_of_hire` STRING COMMENT 'Source of hire.',
    `system_access_provisioned` BOOLEAN COMMENT 'System access provisioned.',
    `target_start_date` DATE COMMENT 'Target start date.',
    `time_to_fill_days` STRING COMMENT 'Time to fill in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `workday_candidate_code` STRING COMMENT 'Workday candidate code.',
    CONSTRAINT pk_recruitment PRIMARY KEY(`recruitment_id`)
) COMMENT 'Tracks the full recruitment lifecycle from requisition through onboarding for healthcare positions.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` (
    `osha_incident_id` BIGINT COMMENT 'Unique identifier.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `improvement_initiative_id` BIGINT COMMENT 'FK to quality improvement initiative.',
    `icd_code_id` BIGINT COMMENT 'FK to ICD code for injury.',
    `snomed_concept_id` BIGINT COMMENT 'FK to SNOMED concept for injury.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `payer_id` BIGINT COMMENT 'FK to workers comp payer.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `bloodborne_pathogen_exposure` BOOLEAN COMMENT 'Whether bloodborne pathogen exposure occurred.',
    `body_part_affected` STRING COMMENT 'Body part affected.',
    `body_side` STRING COMMENT 'Side of body affected.',
    `corrective_action_completed_date` DATE COMMENT 'Date corrective action was completed.',
    `corrective_action_description` STRING COMMENT 'Description of corrective action.',
    `corrective_action_due_date` DATE COMMENT 'Due date for corrective action.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `days_away_from_work` STRING COMMENT 'Days away from work.',
    `days_restricted_duty` STRING COMMENT 'Days on restricted duty.',
    `event_source` STRING COMMENT 'Source of the event.',
    `incident_datetime` TIMESTAMP COMMENT 'Date and time of incident.',
    `incident_description` STRING COMMENT 'Description of the incident.',
    `incident_location` STRING COMMENT 'Location of the incident.',
    `incident_number` STRING COMMENT 'Incident tracking number.',
    `incident_status` STRING COMMENT 'Status of the incident.',
    `incident_type` STRING COMMENT 'Type of incident.',
    `injury_illness_type` STRING COMMENT 'Type of injury or illness.',
    `investigation_completed_date` DATE COMMENT 'Date investigation was completed.',
    `is_fatality` BOOLEAN COMMENT 'Whether incident resulted in fatality.',
    `is_hospitalized` BOOLEAN COMMENT 'Whether employee was hospitalized.',
    `is_osha_recordable` BOOLEAN COMMENT 'Whether incident is OSHA recordable.',
    `is_privacy_case` BOOLEAN COMMENT 'Whether this is a privacy case.',
    `is_work_related` BOOLEAN COMMENT 'Whether incident is work-related.',
    `nature_of_injury` STRING COMMENT 'Nature of injury.',
    `osha_300_log_entry_date` DATE COMMENT 'OSHA 300 log entry date.',
    `osha_300a_included` BOOLEAN COMMENT 'Whether included in OSHA 300A.',
    `osha_301_completed` BOOLEAN COMMENT 'Whether OSHA 301 was completed.',
    `osha_establishment_number` STRING COMMENT 'OSHA establishment number.',
    `post_exposure_followup_completed` BOOLEAN COMMENT 'Whether post-exposure followup was completed.',
    `ppe_in_use` BOOLEAN COMMENT 'Whether PPE was in use.',
    `ppe_type` STRING COMMENT 'Type of PPE in use.',
    `reported_datetime` TIMESTAMP COMMENT 'Date and time incident was reported.',
    `return_to_work_date` DATE COMMENT 'Return to work date.',
    `root_cause_category` STRING COMMENT 'Root cause category.',
    `root_cause_description` STRING COMMENT 'Root cause description.',
    `severity_level` STRING COMMENT 'Severity level.',
    `shift_type` STRING COMMENT 'Shift type when incident occurred.',
    `supervisor_name` STRING COMMENT 'Supervisor name.',
    `treating_provider_name` STRING COMMENT 'Treating provider name.',
    `treatment_facility_name` STRING COMMENT 'Treatment facility name.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `witness_names` STRING COMMENT 'Names of witnesses.',
    `workers_comp_claim_number` STRING COMMENT 'Workers comp claim number.',
    CONSTRAINT pk_osha_incident PRIMARY KEY(`osha_incident_id`)
) COMMENT 'Records OSHA-reportable workplace incidents including injuries, exposures, and safety events with regulatory compliance tracking.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` (
    `fte_budget_id` BIGINT COMMENT 'Unique identifier.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `fiscal_period_id` BIGINT COMMENT 'FK to fiscal period.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `actual_fte` DECIMAL(18,2) COMMENT 'Actual FTE.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual hours worked.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual labor cost.',
    `agency_fte` DECIMAL(18,2) COMMENT 'Agency FTE.',
    `approval_date` DATE COMMENT 'Budget approval date.',
    `approved_by` STRING COMMENT 'Approved by.',
    `benefits_burden_pct` DECIMAL(18,2) COMMENT 'Benefits burden percentage.',
    `budget_code` STRING COMMENT 'Budget code.',
    `budget_status` STRING COMMENT 'Budget status.',
    `budget_version` STRING COMMENT 'Budget version.',
    `budgeted_avg_hourly_rate` DECIMAL(18,2) COMMENT 'Budgeted average hourly rate.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'Budgeted FTE.',
    `budgeted_hours` DECIMAL(18,2) COMMENT 'Budgeted hours.',
    `budgeted_labor_cost` DECIMAL(18,2) COMMENT 'Budgeted labor cost.',
    `budgeted_nonproductive_fte` DECIMAL(18,2) COMMENT 'Budgeted nonproductive FTE.',
    `budgeted_overtime_fte` DECIMAL(18,2) COMMENT 'Budgeted overtime FTE.',
    `budgeted_productive_fte` DECIMAL(18,2) COMMENT 'Budgeted productive FTE.',
    `cost_center_code` STRING COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Effective date.',
    `employment_type` STRING COMMENT 'Employment type.',
    `end_date` DATE COMMENT 'End date.',
    `fiscal_period` STRING COMMENT 'Fiscal period label.',
    `fiscal_year` STRING COMMENT 'Fiscal year.',
    `flsa_classification` STRING COMMENT 'FLSA classification.',
    `fte_variance` DECIMAL(18,2) COMMENT 'FTE variance (actual vs budget).',
    `is_union_position` BOOLEAN COMMENT 'Whether this is a union position.',
    `job_code` STRING COMMENT 'Job code.',
    `job_family` STRING COMMENT 'Job family.',
    `labor_cost_per_apd` DECIMAL(18,2) COMMENT 'Labor cost per adjusted patient day.',
    `labor_cost_variance` DECIMAL(18,2) COMMENT 'Labor cost variance.',
    `notes` STRING COMMENT 'Notes.',
    `pay_grade` STRING COMMENT 'Pay grade.',
    `pay_type` STRING COMMENT 'Pay type.',
    `productivity_target_pct` DECIMAL(18,2) COMMENT 'Productivity target percentage.',
    `staffing_ratio_target` DECIMAL(18,2) COMMENT 'Staffing ratio target.',
    `standard_hours_per_fte` DECIMAL(18,2) COMMENT 'Standard hours per FTE.',
    `union_code` STRING COMMENT 'Union code.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vacancy_fte` DECIMAL(18,2) COMMENT 'Vacancy FTE.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_fte_budget PRIMARY KEY(`fte_budget_id`)
) COMMENT 'Manages FTE budgeting and labor cost tracking by department, position, and fiscal period for workforce planning.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier.',
    `parent_org_unit_id` BIGINT COMMENT 'Self-referential FK to parent org unit.',
    `care_site_id` BIGINT COMMENT 'FK to primary care site.',
    `accreditation_program` STRING COMMENT 'Accreditation program.',
    `approved_by` STRING COMMENT 'Approved by.',
    `approved_date` DATE COMMENT 'Approval date.',
    `authorized_headcount` STRING COMMENT 'Authorized headcount.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'Budgeted FTE.',
    `org_unit_code` STRING COMMENT 'Org unit code.',
    `company_code` STRING COMMENT 'Company code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `division_name` STRING COMMENT 'Division name.',
    `effective_date` DATE COMMENT 'Effective date.',
    `email_address` STRING COMMENT 'Org unit email address.',
    `end_date` DATE COMMENT 'End date.',
    `fiscal_year_start_month` STRING COMMENT 'Fiscal year start month.',
    `gl_account_code` STRING COMMENT 'GL account code.',
    `hierarchy_level` STRING COMMENT 'Level in the hierarchy.',
    `hierarchy_path` STRING COMMENT 'Full hierarchy path.',
    `is_clinical` BOOLEAN COMMENT 'Whether this is a clinical unit.',
    `is_revenue_generating` BOOLEAN COMMENT 'Whether this unit generates revenue.',
    `is_supervisory_org` BOOLEAN COMMENT 'Whether this is a supervisory org.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `location_type` STRING COMMENT 'Location type.',
    `org_unit_name` STRING COMMENT 'Org unit name.',
    `org_unit_status` STRING COMMENT 'Status of the org unit.',
    `org_unit_type` STRING COMMENT 'Type of org unit.',
    `osha_establishment_number` STRING COMMENT 'OSHA establishment number.',
    `phone_number` STRING COMMENT 'Phone number.',
    `profit_center_code` STRING COMMENT 'Profit center code.',
    `service_line` STRING COMMENT 'Service line.',
    `short_name` STRING COMMENT 'Short name.',
    `specialty_code` STRING COMMENT 'Specialty code.',
    `subtype` STRING COMMENT 'Subtype.',
    `time_zone` STRING COMMENT 'Time zone.',
    `union_affiliation` STRING COMMENT 'Union affiliation.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `workday_integration_code` STRING COMMENT 'Workday integration code.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Represents organizational units in the workforce hierarchy including departments, divisions, and supervisory organizations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` (
    `workforce_provider_network_participation_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `payer_id` BIGINT COMMENT 'FK to payer.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Whether accepting new patients.',
    `contract_reference_number` STRING COMMENT 'Contract reference number.',
    `credentialing_expiration_date` DECIMAL(18,2) COMMENT 'Credentialing expiration date.',
    `credentialing_status` STRING COMMENT 'Credentialing status.',
    `effective_date` DATE COMMENT 'Effective date.',
    `enrollment_date` DATE COMMENT 'Enrollment date.',
    `network_participation_status` STRING COMMENT 'Network participation status.',
    `network_tier` STRING COMMENT 'Network tier.',
    `payer_provider_number` STRING COMMENT 'Payer provider number.',
    `reimbursement_rate_schedule` DECIMAL(18,2) COMMENT 'Reimbursement rate schedule.',
    `termination_date` DATE COMMENT 'Termination date.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_workforce_provider_network_participation PRIMARY KEY(`workforce_provider_network_participation_id`)
) COMMENT 'Tracks employee participation in payer provider networks including credentialing status and enrollment details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` (
    `clinical_privilege_id` BIGINT COMMENT 'Unique identifier.',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `competency_level` STRING COMMENT 'Competency level.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `granting_committee` STRING COMMENT 'Committee that granted the privilege.',
    `last_proctoring_date` DATE COMMENT 'Last proctoring date.',
    `privilege_expiration_date` DECIMAL(18,2) COMMENT 'Privilege expiration date.',
    `privilege_grant_date` DATE COMMENT 'Date privilege was granted.',
    `privilege_status` STRING COMMENT 'Status of the privilege.',
    `proctoring_cases_completed` STRING COMMENT 'Proctoring cases completed.',
    `proctoring_cases_required` STRING COMMENT 'Proctoring cases required.',
    `restriction_notes` STRING COMMENT 'Restriction notes.',
    `supervision_required` BOOLEAN COMMENT 'Whether supervision is required.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `volume_requirement` STRING COMMENT 'Volume requirement.',
    CONSTRAINT pk_clinical_privilege PRIMARY KEY(`clinical_privilege_id`)
) COMMENT 'Tracks clinical privileges granted to employees for specific procedures and clinical activities.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` (
    `channel_support_assignment_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `interface_channel_id` BIGINT COMMENT 'FK to interface channel.',
    `assignment_end_date` DATE COMMENT 'Assignment end date.',
    `assignment_start_date` DATE COMMENT 'Assignment start date.',
    `assignment_status` STRING COMMENT 'Assignment status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `escalation_tier` STRING COMMENT 'Escalation tier.',
    `notification_preference` STRING COMMENT 'Notification preference.',
    `on_call_rotation` STRING COMMENT 'On-call rotation schedule.',
    `support_role` STRING COMMENT 'Support role.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_channel_support_assignment PRIMARY KEY(`channel_support_assignment_id`)
) COMMENT 'Assigns workforce members to support interoperability interface channels for technical and business support.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` (
    `position_procedure_authorization_id` BIGINT COMMENT 'Unique identifier.',
    `cpt_code_id` BIGINT COMMENT 'FK to CPT code.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `authorization_level` STRING COMMENT 'Authorization level.',
    `authorization_status` STRING COMMENT 'Authorization status.',
    `competency_validation_frequency` STRING COMMENT 'Competency validation frequency.',
    `created_date` TIMESTAMP COMMENT 'Record creation date.',
    `credentialing_committee_approval_date` DATE COMMENT 'Credentialing committee approval date.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date.',
    `minimum_cases_required` STRING COMMENT 'Minimum cases required.',
    `notes` STRING COMMENT 'Notes.',
    `supervision_requirement` STRING COMMENT 'Supervision requirement.',
    `training_description` STRING COMMENT 'Training description.',
    `training_required` BOOLEAN COMMENT 'Whether training is required.',
    `updated_date` TIMESTAMP COMMENT 'Last update date.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `volume_expectation` STRING COMMENT 'Volume expectation.',
    `created_by` STRING COMMENT 'Created by.',
    CONSTRAINT pk_position_procedure_authorization PRIMARY KEY(`position_procedure_authorization_id`)
) COMMENT 'Defines which procedures are authorized for specific positions with competency and training requirements.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier.',
    `superseded_benefit_plan_id` BIGINT COMMENT 'FK to superseded benefit plan.',
    `carrier_name` STRING COMMENT 'Insurance carrier name.',
    `carrier_policy_number` STRING COMMENT 'Carrier policy number.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Coinsurance percentage.',
    `contribution_frequency` STRING COMMENT 'Contribution frequency.',
    `copay_emergency_room` DECIMAL(18,2) COMMENT 'ER copay amount.',
    `copay_primary_care` DECIMAL(18,2) COMMENT 'Primary care copay amount.',
    `copay_specialist` DECIMAL(18,2) COMMENT 'Specialist copay amount.',
    `coverage_level` STRING COMMENT 'Coverage level.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount.',
    `effective_end_date` DATE COMMENT 'Effective end date.',
    `effective_start_date` DATE COMMENT 'Effective start date.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Employee contribution amount.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount.',
    `employer_identification_number` STRING COMMENT 'Employer identification number.',
    `enrollment_eligibility_rule` STRING COMMENT 'Enrollment eligibility rule.',
    `erisa_plan_number` STRING COMMENT 'ERISA plan number.',
    `is_aca_compliant` BOOLEAN COMMENT 'Whether ACA compliant.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Whether COBRA eligible.',
    `is_fsa_eligible` BOOLEAN COMMENT 'Whether FSA eligible.',
    `is_hsa_eligible` BOOLEAN COMMENT 'Whether HSA eligible.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp.',
    `minimum_value_percentage` DECIMAL(18,2) COMMENT 'Minimum value percentage.',
    `network_type` STRING COMMENT 'Network type (HMO, PPO, etc.).',
    `notes` STRING COMMENT 'Notes.',
    `open_enrollment_end_date` DATE COMMENT 'Open enrollment end date.',
    `open_enrollment_start_date` DATE COMMENT 'Open enrollment start date.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Out of pocket maximum.',
    `plan_administrator_email` STRING COMMENT 'Plan administrator email.',
    `plan_administrator_name` STRING COMMENT 'Plan administrator name.',
    `plan_administrator_phone` STRING COMMENT 'Plan administrator phone.',
    `plan_category` STRING COMMENT 'Plan category.',
    `plan_code` STRING COMMENT 'Plan code.',
    `plan_description` STRING COMMENT 'Plan description.',
    `plan_document_url` STRING COMMENT 'Plan document URL.',
    `plan_name` STRING COMMENT 'Plan name.',
    `plan_type` STRING COMMENT 'Plan type.',
    `plan_year` STRING COMMENT 'Plan year.',
    `benefit_plan_status` STRING COMMENT 'Plan status.',
    `summary_plan_description_url` STRING COMMENT 'Summary plan description URL.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `waiting_period_days` STRING COMMENT 'Waiting period in days.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Defines employee benefit plans including health insurance, retirement, FSA/HSA, and other employer-sponsored benefits.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`education_program` (
    `education_program_id` BIGINT COMMENT 'Unique identifier.',
    `care_site_id` BIGINT COMMENT 'FK to care site.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `accreditation_body` STRING COMMENT 'Accreditation body.',
    `accreditation_effective_date` DATE COMMENT 'Accreditation effective date.',
    `accreditation_expiration_date` DECIMAL(18,2) COMMENT 'Accreditation expiration date.',
    `accreditation_number` STRING COMMENT 'Accreditation number.',
    `accreditation_status` STRING COMMENT 'Accreditation status.',
    `assessment_method` STRING COMMENT 'Assessment method.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Whether certificate is issued.',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'CME credit hours offered.',
    `competency_framework` STRING COMMENT 'Competency framework.',
    `completion_criteria` STRING COMMENT 'Completion criteria',
    `compliance_requirement_code` STRING COMMENT 'Compliance requirement code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `delivery_method` STRING COMMENT 'Delivery method.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Duration in hours.',
    `effective_date` DATE COMMENT 'Effective date.',
    `end_date` DATE COMMENT 'End date.',
    `enrollment_capacity` STRING COMMENT 'Enrollment capacity',
    `frequency_requirement` STRING COMMENT 'Frequency requirement.',
    `instructor_name` STRING COMMENT 'Instructor name',
    `is_mandatory` BOOLEAN COMMENT 'Whether program is mandatory.',
    `is_regulatory_required` BOOLEAN COMMENT 'Whether regulatory required.',
    `learning_objectives` STRING COMMENT 'Learning objectives',
    `passing_score` DECIMAL(18,2) COMMENT 'Passing score.',
    `program_category` STRING COMMENT 'Program category.',
    `program_code` STRING COMMENT 'Program code.',
    `program_description` STRING COMMENT 'Program description.',
    `program_name` STRING COMMENT 'Program name.',
    `program_status` STRING COMMENT 'Program status.',
    `program_type` STRING COMMENT 'Program type.',
    `recertification_period_months` STRING COMMENT 'Recertification period months',
    `regulatory_requirement` STRING COMMENT 'Regulatory requirement',
    `renewal_period_months` STRING COMMENT 'Renewal period in months.',
    `target_audience` STRING COMMENT 'Target audience.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vendor_name` STRING COMMENT 'Vendor name.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_education_program PRIMARY KEY(`education_program_id`)
) COMMENT 'Defines education and training programs for workforce development including CME, certifications, and compliance training.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`review_template` (
    `review_template_id` BIGINT COMMENT 'Unique identifier.',
    `competency_categories` STRING COMMENT 'Competency categories included.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Effective date.',
    `end_date` DATE COMMENT 'End date.',
    `includes_goal_section` BOOLEAN COMMENT 'Whether template includes goal section.',
    `includes_self_assessment` BOOLEAN COMMENT 'Whether template includes self-assessment.',
    `rating_scale_description` STRING COMMENT 'Rating scale description.',
    `rating_scale_max` DECIMAL(18,2) COMMENT 'Maximum rating scale value.',
    `rating_scale_min` DECIMAL(18,2) COMMENT 'Minimum rating scale value.',
    `review_cycle_frequency` STRING COMMENT 'Review cycle frequency',
    `review_frequency` STRING COMMENT 'Review frequency.',
    `template_code` STRING COMMENT 'Template code',
    `template_description` STRING COMMENT 'Template description',
    `template_name` STRING COMMENT 'Template name.',
    `template_status` STRING COMMENT 'Template status.',
    `template_type` STRING COMMENT 'Template type.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `version_number` STRING COMMENT 'Version number.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_review_template PRIMARY KEY(`review_template_id`)
) COMMENT 'Defines templates for performance reviews including rating scales, competency categories, and review criteria.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Unique identifier.',
    `applicant_status` STRING COMMENT 'Current applicant status.',
    `application_date` DATE COMMENT 'Application date',
    `application_source` STRING COMMENT 'Source of application.',
    `application_status` STRING COMMENT 'Application status',
    `city` STRING COMMENT 'City.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `current_employer` STRING COMMENT 'Current employer.',
    `current_job_title` STRING COMMENT 'Current job title.',
    `date_of_birth` DATE COMMENT 'Date of birth (PII)',
    `desired_salary` DECIMAL(18,2) COMMENT 'Desired salary.',
    `education_level` STRING COMMENT 'Education level.',
    `email` STRING COMMENT 'Email address.',
    `email_address` STRING COMMENT 'Email address (PII)',
    `first_name` STRING COMMENT 'First name.',
    `last_name` STRING COMMENT 'Last name.',
    `license_number` STRING COMMENT 'License number.',
    `license_state` STRING COMMENT 'License state.',
    `license_type` STRING COMMENT 'License type.',
    `middle_name` STRING COMMENT 'Middle name (PII)',
    `phone` STRING COMMENT 'Phone number.',
    `phone_number` STRING COMMENT 'Phone number (PII)',
    `preferred_shift` STRING COMMENT 'Preferred shift.',
    `referral_source` STRING COMMENT 'Referral source.',
    `resume_url` STRING COMMENT 'Resume URL',
    `state` STRING COMMENT 'State.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    `years_experience` DECIMAL(18,2) COMMENT 'Years of experience.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Tracks job applicants through the recruitment process with their qualifications and application details.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier.',
    `fiscal_period_id` BIGINT COMMENT 'FK to fiscal period.',
    `payroll_calendar_id` BIGINT COMMENT 'Payroll calendar',
    `approval_date` DATE COMMENT 'Approval date',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `approved_by` STRING COMMENT 'Approved by.',
    `check_date` DATE COMMENT 'Check date.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `employee_count` STRING COMMENT 'Number of employees in run.',
    `gross_pay_total` DECIMAL(18,2) COMMENT 'Total gross pay.',
    `net_pay_total` DECIMAL(18,2) COMMENT 'Total net pay.',
    `pay_period_end_date` DATE COMMENT 'Pay period end date.',
    `pay_period_start_date` DATE COMMENT 'Pay period start date.',
    `payroll_frequency` STRING COMMENT 'Payroll frequency.',
    `payroll_run_number` STRING COMMENT 'Payroll run number.',
    `payroll_run_status` STRING COMMENT 'Payroll run status',
    `payroll_run_type` STRING COMMENT 'Payroll run type',
    `payroll_type` STRING COMMENT 'Payroll type (regular, off-cycle, etc.).',
    `processing_status` STRING COMMENT 'Processing status.',
    `run_date` DATE COMMENT 'Run date.',
    `tax_deductions_total` DECIMAL(18,2) COMMENT 'Total tax deductions.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'Total gross pay',
    `total_net_pay` DECIMAL(18,2) COMMENT 'Total net pay',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Tracks payroll processing runs including pay period details, totals, and processing status.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` (
    `payroll_calendar_id` BIGINT COMMENT 'Unique identifier.',
    `fiscal_period_id` BIGINT COMMENT 'FK to fiscal period.',
    `calendar_name` STRING COMMENT 'Calendar name.',
    `calendar_year` STRING COMMENT 'Calendar year.',
    `check_date` DATE COMMENT 'Check date.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `is_off_cycle` BOOLEAN COMMENT 'Whether this is an off-cycle period.',
    `pay_frequency` STRING COMMENT 'Pay frequency.',
    `pay_period_end_date` DATE COMMENT 'Pay period end date.',
    `pay_period_number` STRING COMMENT 'Pay period number.',
    `pay_period_start_date` DATE COMMENT 'Pay period start date.',
    `processing_deadline` TIMESTAMP COMMENT 'Processing deadline.',
    `payroll_calendar_status` STRING COMMENT 'Period status.',
    `timesheet_due_date` DATE COMMENT 'Timesheet due date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vibe_added_flag` BOOLEAN COMMENT 'Added by VIBE mutator',
    CONSTRAINT pk_payroll_calendar PRIMARY KEY(`payroll_calendar_id`)
) COMMENT 'Defines payroll calendar periods including pay dates, processing deadlines, and fiscal period alignment.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_tertiary_position_workforce_org_unit_id` FOREIGN KEY (`tertiary_position_workforce_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_education_program_id` FOREIGN KEY (`education_program_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`education_program`(`education_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_swap_source_schedule_id` FOREIGN KEY (`swap_source_schedule_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_review_template_id` FOREIGN KEY (`review_template_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`review_template`(`review_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_worker_employee_id` FOREIGN KEY (`reviewer_worker_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ADD CONSTRAINT `fk_workforce_workforce_provider_network_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ADD CONSTRAINT `fk_workforce_clinical_privilege_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ADD CONSTRAINT `fk_workforce_channel_support_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ADD CONSTRAINT `fk_workforce_position_procedure_authorization_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ADD CONSTRAINT `fk_workforce_education_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_calendar_id` FOREIGN KEY (`payroll_calendar_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`payroll_calendar`(`payroll_calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`workforce` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`workforce` SET TAGS ('pii_domain' = 'workforce');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_expiration_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `staffing_agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `staffing_agency_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `npi_registry_id` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_license_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_license_type` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `dea_registration_required` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `npi_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `npi_required` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `required_license_types` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `required_license_types` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `appointment_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `department_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_category` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_committee` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_committee` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_procedure_code` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_procedure_code` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_procedure_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_procedure_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_procedure_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `administration_route` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `administration_site` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `competency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `competency_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `department_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `department_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `medical_contraindication` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `medical_contraindication` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_subdomain' = 'time_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `patient_census` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `patient_census` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_subdomain' = 'time_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_subdomain' = 'time_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_expiration_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_expiration_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_subdomain' = 'talent_performance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_worker_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_worker_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_subdomain' = 'talent_performance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `license_verified` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `license_verified` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offered_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offered_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `required_license_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `required_license_type` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `supervisor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `supervisor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treating_provider_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treating_provider_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treatment_facility_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treatment_facility_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treatment_facility_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treatment_facility_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `witness_names` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `witness_names` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `division_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `division_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_association_edges' = 'workforce.employee,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `reimbursement_rate_schedule` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_association_edges' = 'workforce.employee,reference.cpt_code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_subdomain' = 'time_scheduling');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_association_edges' = 'workforce.employee,interoperability.interface_channel');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_association_edges' = 'workforce.position,reference.cpt_code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_subdomain' = 'credentialing_compliance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `enrollment_capacity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `enrollment_capacity` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `instructor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `instructor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `vendor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_subdomain' = 'talent_performance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_subdomain' = 'talent_performance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_state` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_type` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_type` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `state` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `gross_pay_total` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `gross_pay_total` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `net_pay_total` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `net_pay_total` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_['model_tier' = 'ECM');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('pii_'ecm_member' = 'true]');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `processing_deadline` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `processing_deadline` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `vibe_added_flag` SET TAGS ('pii_vibe_added' = 'true');
