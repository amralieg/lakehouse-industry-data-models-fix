-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`workforce` COMMENT 'Manages the internal workforce — employee records, organizational hierarchy, job roles, compensation, benefits administration, payroll, performance management, workforce planning, and EAP programs. Owns HR master data, payroll cost allocations to cost centers, role-based access control (RBAC) for PHI/PII systems, and training/certification records required for HIPAA workforce training compliance. Distinct from provider credentialing which governs external clinical staff.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee.',
    `job_role_id` BIGINT COMMENT 'FK to job role.',
    `manager_employee_id` BIGINT COMMENT 'FK to manager employee record.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `access_level` STRING COMMENT 'System access level assigned.',
    `address_line1` STRING COMMENT 'Employee home address line 1.',
    `birth_date` DATE COMMENT 'Employee date of birth.',
    `bonus_eligible` BOOLEAN COMMENT 'Whether employee is eligible for bonus.',
    `city` STRING COMMENT 'City of residence.',
    `cost_center` DECIMAL(18,2) COMMENT 'Cost center code assignment.',
    `country` STRING COMMENT 'Country of residence.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `department` STRING COMMENT 'Department assignment.',
    `email` STRING COMMENT 'Employee email address.',
    `emergency_contact_name` STRING COMMENT 'Name of emergency contact.',
    `emergency_contact_phone` STRING COMMENT 'Phone of emergency contact.',
    `employee_status` STRING COMMENT 'Overall employee status.',
    `employment_status` STRING COMMENT 'Current employment status.',
    `employment_type` STRING COMMENT 'Full-time, part-time, contract.',
    `ethnicity` STRING COMMENT 'Employee ethnicity.',
    `first_name` STRING COMMENT 'Employee first name.',
    `gender` STRING COMMENT 'Employee gender.',
    `health_plan_eligible` BOOLEAN COMMENT 'Whether eligible for health plan.',
    `hipaa_training_completion_date` DATE COMMENT 'Date HIPAA training completed.',
    `hire_date` DATE COMMENT 'Date of hire.',
    `i9_verification_date` DATE COMMENT 'Date I-9 verified.',
    `last_name` STRING COMMENT 'Employee last name.',
    `middle_name` STRING COMMENT 'Employee middle name.',
    `notes` STRING COMMENT 'Free-text notes.',
    `organization_level` STRING COMMENT 'Level in org hierarchy.',
    `pay_frequency` STRING COMMENT 'Frequency of pay.',
    `phone_number` STRING COMMENT 'Employee phone number.',
    `postal_code` STRING COMMENT 'Postal code of residence.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp record was created.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp record was last updated.',
    `salary_amount` DECIMAL(18,2) COMMENT 'Current salary amount.',
    `salary_currency` DECIMAL(18,2) COMMENT 'Currency code for salary.',
    `security_training_completion_date` DATE COMMENT 'Date security training completed.',
    `ssn` STRING COMMENT 'Social security number.',
    `state` STRING COMMENT 'State of residence.',
    `termination_date` DATE COMMENT 'Date of termination if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Represents an individual employed by the health plan organization.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the position.',
    `job_role_id` BIGINT COMMENT 'FK to job role.',
    `bonus_eligible` BOOLEAN COMMENT 'Whether position is bonus eligible.',
    `competency_level` STRING COMMENT 'Required competency level.',
    `compliance_training_completed` BOOLEAN COMMENT 'Whether compliance training is completed.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `department_code` STRING COMMENT 'Department code.',
    `position_description` STRING COMMENT 'Description of the position.',
    `eeo1_category` STRING COMMENT 'EEO-1 job category.',
    `effective_end_date` DATE COMMENT 'Position effective end date.',
    `effective_start_date` DATE COMMENT 'Position effective start date.',
    `employment_type` STRING COMMENT 'Type of employment.',
    `flsa_classification` STRING COMMENT 'FLSA exempt/non-exempt.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation.',
    `hipaa_privacy_training_required` BOOLEAN COMMENT 'Whether HIPAA training is required.',
    `incentive_plan` STRING COMMENT 'Incentive plan name.',
    `is_managerial` BOOLEAN COMMENT 'Whether position is managerial.',
    `job_code` STRING COMMENT 'Job code identifier.',
    `language_requirements` STRING COMMENT 'Required languages.',
    `last_review_date` DATE COMMENT 'Date of last position review.',
    `next_review_due_date` DATE COMMENT 'Next review due date.',
    `notes` STRING COMMENT 'Free-text notes.',
    `overtime_eligible` BOOLEAN COMMENT 'Whether overtime eligible.',
    `pay_grade` STRING COMMENT 'Pay grade level.',
    `pay_grade_max` DECIMAL(18,2) COMMENT 'Maximum pay for grade.',
    `pay_grade_mid` DECIMAL(18,2) COMMENT 'Midpoint pay for grade.',
    `pay_grade_min` DECIMAL(18,2) COMMENT 'Minimum pay for grade.',
    `phi_access_tier` STRING COMMENT 'PHI access tier level.',
    `position_status` STRING COMMENT 'Current status of position.',
    `remote_allowed` BOOLEAN COMMENT 'Whether remote work is allowed.',
    `required_certifications` STRING COMMENT 'Certifications required.',
    `salary_band` DECIMAL(18,2) COMMENT 'Salary band designation.',
    `shift_type` STRING COMMENT 'Type of shift.',
    `supervisory_level` STRING COMMENT 'Level of supervisory responsibility.',
    `title` STRING COMMENT 'Position title.',
    `travel_required` BOOLEAN COMMENT 'Whether travel is required.',
    `union_member` BOOLEAN COMMENT 'Whether position is union.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'A defined position within the organization with associated job characteristics.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` (
    `job_role_id` BIGINT COMMENT 'Unique identifier for the job role.',
    `org_unit_id` BIGINT COMMENT 'FK to organizational unit.',
    `compensation_band` STRING COMMENT 'Compensation band.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `eeo_category` STRING COMMENT 'EEO category.',
    `effective_end_date` DATE COMMENT 'Role effective end date.',
    `effective_start_date` DATE COMMENT 'Role effective start date.',
    `external_system_source` STRING COMMENT 'Source system.',
    `flsa_exempt_status` STRING COMMENT 'FLSA exempt status.',
    `hipaa_training_required` BOOLEAN COMMENT 'Whether HIPAA training required.',
    `is_clinical` BOOLEAN COMMENT 'Whether role is clinical.',
    `is_managerial` BOOLEAN COMMENT 'Whether role is managerial.',
    `job_family` STRING COMMENT 'Job family grouping.',
    `job_function` STRING COMMENT 'Primary job function.',
    `job_role_status` STRING COMMENT 'Overall job role status.',
    `last_review_date` DATE COMMENT 'Last review date.',
    `legacy_role_code` STRING COMMENT 'Legacy system role code.',
    `notes` STRING COMMENT 'Free-text notes.',
    `organization_unit` STRING COMMENT 'Org unit name.',
    `pay_currency` STRING COMMENT 'Currency for pay.',
    `pay_grade_max` DECIMAL(18,2) COMMENT 'Maximum pay grade amount.',
    `pay_grade_min` DECIMAL(18,2) COMMENT 'Minimum pay grade amount.',
    `phi_access_tier` STRING COMMENT 'PHI access tier.',
    `required_certifications` STRING COMMENT 'Required certifications.',
    `role_access_level` STRING COMMENT 'Access level for role.',
    `role_code` STRING COMMENT 'Role code.',
    `role_description` STRING COMMENT 'Description of the role.',
    `role_level` STRING COMMENT 'Numeric role level.',
    `role_notes` STRING COMMENT 'Notes about the role.',
    `role_owner_department` STRING COMMENT 'Department owning the role.',
    `role_risk_level` STRING COMMENT 'Risk level of role.',
    `role_status` STRING COMMENT 'Status of the role.',
    `role_title` STRING COMMENT 'Title of the role.',
    `role_version` STRING COMMENT 'Version number.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_job_role PRIMARY KEY(`job_role_id`)
) COMMENT 'Defines a job role with associated responsibilities, requirements, and compensation bands.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier.',
    `parent_org_unit_id` BIGINT COMMENT 'FK to parent org unit.',
    `address_line1` STRING COMMENT 'Address line 1.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Annual budget amount.',
    `audit_status` STRING COMMENT 'Audit status.',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the org unit in the workforce domain.',
    `org_unit_code` STRING COMMENT 'Org unit code.',
    `compliance_training_required` BOOLEAN COMMENT 'Whether compliance training required.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `country` STRING COMMENT 'The country attribute capturing relevant data for the org unit in the workforce domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `data_classification` STRING COMMENT 'Data classification level.',
    `org_unit_description` STRING COMMENT 'Description.',
    `effective_end_date` DATE COMMENT 'Effective end date.',
    `effective_start_date` DATE COMMENT 'Effective start date.',
    `email` STRING COMMENT 'Org unit email.',
    `external_reference_code` STRING COMMENT 'External reference.',
    `gl_account_code` STRING COMMENT 'General ledger account code.',
    `headcount` STRING COMMENT 'Current headcount.',
    `is_cost_center` BOOLEAN COMMENT 'Whether unit is a cost center.',
    `is_profit_center` BOOLEAN COMMENT 'Whether unit is a profit center.',
    `last_audit_date` DATE COMMENT 'Last audit date.',
    `location` STRING COMMENT 'Location description.',
    `org_unit_name` STRING COMMENT 'Name of org unit.',
    `notes` STRING COMMENT 'Free-text notes.',
    `org_level` STRING COMMENT 'Level in hierarchy.',
    `org_unit_status` STRING COMMENT 'The current status indicator for the org unit within the workflow.',
    `org_unit_type` STRING COMMENT 'Type of org unit.',
    `payroll_allocation_method` STRING COMMENT 'Payroll allocation method.',
    `phone_number` STRING COMMENT 'Phone number.',
    `postal_code` STRING COMMENT 'Postal code.',
    `primary_function` STRING COMMENT 'Primary function.',
    `rbac_scope` STRING COMMENT 'RBAC scope.',
    `record_source_system` STRING COMMENT 'Source system.',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the org unit in the workforce domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `version_number` STRING COMMENT 'Version number.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Represents an organizational unit within the health plan entity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` (
    `employment_record_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `org_unit_id` BIGINT COMMENT 'FK to prior org unit.',
    `position_id` BIGINT COMMENT 'FK to prior position.',
    `tertiary_employment_hr_business_partner_employee_id` BIGINT COMMENT 'FK to HR BP.',
    `action_effective_date` DATE COMMENT 'Date action takes effect.',
    `action_number` STRING COMMENT 'Action reference number.',
    `action_subtype` STRING COMMENT 'Subtype of action.',
    `action_type` STRING COMMENT 'Type of employment action.',
    `appeal_status` STRING COMMENT 'Appeal status if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `employee_acknowledgment_status` STRING COMMENT 'Employee acknowledgment status.',
    `employment_record_status` STRING COMMENT 'Overall status.',
    `incident_description` STRING COMMENT 'Description of incident.',
    `lifecycle_status` STRING COMMENT 'Lifecycle status.',
    `new_pay_grade` STRING COMMENT 'New pay grade after action.',
    `notes` STRING COMMENT 'Free-text notes.',
    `policy_violated` STRING COMMENT 'Policy violated if applicable.',
    `prior_pay_grade` STRING COMMENT 'Prior pay grade.',
    `reason_code` STRING COMMENT 'Reason code for action.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `record_status` STRING COMMENT 'Record status.',
    `suspension_duration_days` STRING COMMENT 'Duration of suspension in days.',
    `termination_date` DATE COMMENT 'Termination date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_employment_record PRIMARY KEY(`employment_record_id`)
) COMMENT 'Tracks employment actions and lifecycle events for an employee.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` (
    `compensation_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to approver.',
    `compensation_plan_id` BIGINT COMMENT 'FK to compensation plan.',
    `primary_compensation_employee_id` BIGINT COMMENT 'FK to employee.',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `base_amount` DECIMAL(18,2) COMMENT 'Base compensation amount.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Bonus amount.',
    `bonus_frequency` STRING COMMENT 'Frequency of bonus.',
    `bonus_type` STRING COMMENT 'Type of bonus.',
    `change_reason` STRING COMMENT 'Reason for change.',
    `compensation_code` STRING COMMENT 'Compensation code.',
    `compensation_status` STRING COMMENT 'The current status indicator for the compensation within the workflow.',
    `compensation_type` STRING COMMENT 'Type of compensation.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `effective_date` DATE COMMENT 'Effective date.',
    `end_date` DATE COMMENT 'The date value representing end date for this compensation record.',
    `equity_amount` DECIMAL(18,2) COMMENT 'Equity amount.',
    `equity_type` STRING COMMENT 'Type of equity.',
    `equity_vesting_schedule` STRING COMMENT 'Vesting schedule.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly rate.',
    `incentive_target_pct` DECIMAL(18,2) COMMENT 'Incentive target percentage.',
    `is_exempt` BOOLEAN COMMENT 'Whether exempt.',
    `is_flexible` BOOLEAN COMMENT 'Whether flexible.',
    `location_code` STRING COMMENT 'Location code.',
    `compensation_name` STRING COMMENT 'Name of compensation.',
    `notes` STRING COMMENT 'Free-text notes.',
    `overtime_eligibility` BOOLEAN COMMENT 'Whether overtime eligible.',
    `pay_frequency` STRING COMMENT 'Pay frequency.',
    `pay_grade` STRING COMMENT 'Pay grade.',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Max salary range.',
    `salary_range_mid` DECIMAL(18,2) COMMENT 'Mid salary range.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Min salary range.',
    `shift_differential` DECIMAL(18,2) COMMENT 'Shift differential rate.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Tracks compensation details for employees including base, bonus, and equity.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `comments` STRING COMMENT 'The comments attribute capturing relevant data for the payroll run in the workforce domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `gl_posting_reference` STRING COMMENT 'GL posting reference.',
    `is_manual_run` BOOLEAN COMMENT 'Whether manual run.',
    `notes` STRING COMMENT 'Free-text notes.',
    `pay_date` DATE COMMENT 'The date value representing pay date for this payroll run record.',
    `payroll_batch_number` BIGINT COMMENT 'Batch number.',
    `payroll_cycle_code` STRING COMMENT 'Cycle code.',
    `payroll_run_status` STRING COMMENT 'The current status indicator for the payroll run within the workflow.',
    `payroll_type` STRING COMMENT 'Type of payroll.',
    `period_end_date` DATE COMMENT 'Period end date.',
    `period_start_date` DATE COMMENT 'Period start date.',
    `run_execution_timestamp` TIMESTAMP COMMENT 'Execution timestamp.',
    `run_number` STRING COMMENT 'Run number.',
    `total_employee_deductions` DECIMAL(18,2) COMMENT 'Total deductions.',
    `total_employer_tax` DECIMAL(18,2) COMMENT 'Total employer tax.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Total gross.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Total net.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `version_number` STRING COMMENT 'Version number.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Represents a payroll processing run for a pay period.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` (
    `payroll_disbursement_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `payroll_run_id` BIGINT COMMENT 'FK to payroll run.',
    `time_and_attendance_id` BIGINT COMMENT 'FK to time and attendance.',
    `bank_account_number` STRING COMMENT 'Bank account number.',
    `bank_routing_number` STRING COMMENT 'Bank routing number.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Clock in timestamp.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Clock out timestamp.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `federal_tax_withheld` DECIMAL(18,2) COMMENT 'Federal tax withheld.',
    `fica_tax_withheld` DECIMAL(18,2) COMMENT 'FICA tax withheld.',
    `gl_account_number` STRING COMMENT 'GL account number.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Gross pay amount.',
    `line_number` STRING COMMENT 'Line number.',
    `lob_code` STRING COMMENT 'Line of business code.',
    `manager_approval_date` DATE COMMENT 'Manager approval date.',
    `medicare_tax_withheld` DECIMAL(18,2) COMMENT 'Medicare tax withheld.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Net pay amount.',
    `notes` STRING COMMENT 'Free-text notes.',
    `other_deductions_total` DECIMAL(18,2) COMMENT 'Other deductions total.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Overtime hours.',
    `pay_date` DATE COMMENT 'The date value representing pay date for this payroll disbursement record.',
    `pay_period_end_date` DATE COMMENT 'Pay period end date.',
    `pay_period_start_date` DATE COMMENT 'Pay period start date.',
    `pay_stub_number` STRING COMMENT 'Pay stub number.',
    `payment_method` DECIMAL(18,2) COMMENT 'Payment method.',
    `payroll_disbursement_status` STRING COMMENT 'Overall status.',
    `payroll_disbursement_type` STRING COMMENT 'Type of disbursement.',
    `payroll_status` STRING COMMENT 'Payroll status.',
    `pto_hours` DECIMAL(18,2) COMMENT 'PTO hours.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Regular hours.',
    `shift_differential_hours` DECIMAL(18,2) COMMENT 'Shift differential hours.',
    `sick_hours` DECIMAL(18,2) COMMENT 'Sick hours.',
    `state_tax_withheld` DECIMAL(18,2) COMMENT 'State tax withheld.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Whether tax exempt.',
    `timesheet_approval_date` DATE COMMENT 'Timesheet approval date.',
    `timesheet_status` STRING COMMENT 'Timesheet status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_payroll_disbursement PRIMARY KEY(`payroll_disbursement_id`)
) COMMENT 'Individual payroll disbursement to an employee for a pay period.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` (
    `payroll_cost_allocation_id` BIGINT COMMENT 'Unique identifier.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `payroll_disbursement_id` BIGINT COMMENT 'FK to disbursement.',
    `payroll_run_id` BIGINT COMMENT 'FK to payroll run.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `tertiary_payroll_updated_by_user_employee_id` BIGINT COMMENT 'FK to updating user.',
    `allocated_benefit_cost` DECIMAL(18,2) COMMENT 'Allocated benefit cost.',
    `allocated_employer_tax_amount` DECIMAL(18,2) COMMENT 'Allocated employer tax.',
    `allocated_gross_pay_amount` DECIMAL(18,2) COMMENT 'Allocated gross pay.',
    `allocation_amount_total` DECIMAL(18,2) COMMENT 'Total allocation amount.',
    `allocation_date` DATE COMMENT 'Allocation date.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Allocation percentage.',
    `allocation_reason` STRING COMMENT 'Reason for allocation.',
    `allocation_sequence` STRING COMMENT 'Sequence number.',
    `allocation_status` STRING COMMENT 'Allocation status.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `effective_end_date` DATE COMMENT 'Effective end date.',
    `effective_start_date` DATE COMMENT 'Effective start date.',
    `gl_account_code` STRING COMMENT 'GL account code.',
    `is_manual_adjustment` BOOLEAN COMMENT 'Whether manual adjustment.',
    `lob_code` STRING COMMENT 'Line of business code.',
    `notes` STRING COMMENT 'Free-text notes.',
    `payroll_cost_allocation_status` DECIMAL(18,2) COMMENT 'Overall status.',
    `payroll_period` STRING COMMENT 'Payroll period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_payroll_cost_allocation PRIMARY KEY(`payroll_cost_allocation_id`)
) COMMENT 'Allocates payroll costs across cost centers and GL accounts.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` (
    `employee_benefit_enrollment_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan.',
    `benefit_year` STRING COMMENT 'Benefit year.',
    `cobra_end_date` DATE COMMENT 'COBRA end date.',
    `cobra_start_date` DATE COMMENT 'COBRA start date.',
    `contribution_frequency` STRING COMMENT 'Contribution frequency.',
    `coverage_tier` STRING COMMENT 'Coverage tier.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `effective_date` DATE COMMENT 'Effective date.',
    `employee_benefit_enrollment_status` STRING COMMENT 'Overall status.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Employee contribution amount.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount.',
    `enrollment_number` STRING COMMENT 'Enrollment number.',
    `enrollment_source` STRING COMMENT 'Enrollment source.',
    `enrollment_status` STRING COMMENT 'Enrollment status.',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Enrollment timestamp.',
    `is_aca_compliant` BOOLEAN COMMENT 'Whether ACA compliant.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Whether COBRA eligible.',
    `last_modified_by` STRING COMMENT 'Last modified by.',
    `notes` STRING COMMENT 'Free-text notes.',
    `payroll_deduction_code` STRING COMMENT 'Payroll deduction code.',
    `plan_type` STRING COMMENT 'Plan type.',
    `termination_date` DATE COMMENT 'Termination date.',
    `total_contribution_amount` DECIMAL(18,2) COMMENT 'Total contribution amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_employee_benefit_enrollment PRIMARY KEY(`employee_benefit_enrollment_id`)
) COMMENT 'Tracks employee enrollment in benefit plans.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `accommodation_details` STRING COMMENT 'Accommodation details.',
    `ada_accommodation_required` BOOLEAN COMMENT 'Whether ADA accommodation required.',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `approved_days` DECIMAL(18,2) COMMENT 'Number of approved days.',
    `approved_end_date` DATE COMMENT 'Approved end date.',
    `approved_start_date` DATE COMMENT 'Approved start date.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `denial_reason` STRING COMMENT 'Denial reason.',
    `end_date` DATE COMMENT 'Requested end date.',
    `fmla_eligible` BOOLEAN COMMENT 'Whether FMLA eligible.',
    `intermittent` BOOLEAN COMMENT 'Whether intermittent leave.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Leave balance after.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Leave balance before.',
    `leave_policy_code` STRING COMMENT 'Leave policy code.',
    `leave_request_status` STRING COMMENT 'Overall status.',
    `leave_status` STRING COMMENT 'Leave status.',
    `leave_type` STRING COMMENT 'Type of leave.',
    `notes` STRING COMMENT 'Free-text notes.',
    `payroll_amount` DECIMAL(18,2) COMMENT 'Payroll impact amount.',
    `payroll_impact` BOOLEAN COMMENT 'Whether impacts payroll.',
    `request_number` STRING COMMENT 'Request number.',
    `request_timestamp` TIMESTAMP COMMENT 'Request timestamp.',
    `requested_days` DECIMAL(18,2) COMMENT 'Number of requested days.',
    `return_to_work_date` DATE COMMENT 'Return to work date.',
    `start_date` DATE COMMENT 'Requested start date.',
    `updated_by` STRING COMMENT 'Updated by.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `created_by` STRING COMMENT 'Created by.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Tracks employee leave requests and approvals.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `average_goal_rating` DECIMAL(18,2) COMMENT 'Average goal rating.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Business event timestamp.',
    `calibration_status` STRING COMMENT 'Calibration status.',
    `compensation_grade` STRING COMMENT 'Compensation grade.',
    `competency_communication_rating` STRING COMMENT 'Communication competency rating.',
    `competency_leadership_rating` STRING COMMENT 'Leadership competency rating.',
    `competency_teamwork_rating` STRING COMMENT 'Teamwork competency rating.',
    `confidentiality_level` STRING COMMENT 'Confidentiality level.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `department` STRING COMMENT 'Department.',
    `employee_self_assessment_ref` STRING COMMENT 'Self assessment reference.',
    `goal_1_rating` STRING COMMENT 'Goal 1 rating.',
    `goal_2_rating` STRING COMMENT 'Goal 2 rating.',
    `goal_3_rating` STRING COMMENT 'Goal 3 rating.',
    `is_finalized` BOOLEAN COMMENT 'Whether finalized.',
    `job_role` STRING COMMENT 'The job role attribute capturing relevant data for the performance review in the workforce domain.',
    `location_code` STRING COMMENT 'Location code.',
    `manager_name` STRING COMMENT 'Manager name.',
    `manager_narrative` STRING COMMENT 'Manager narrative.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Merit increase percentage.',
    `merit_increase_recommendation_amount` DECIMAL(18,2) COMMENT 'Merit increase recommendation.',
    `notes` STRING COMMENT 'Free-text notes.',
    `overall_rating` STRING COMMENT 'Overall rating.',
    `performance_improvement_plan_due_date` DATE COMMENT 'PIP due date.',
    `performance_improvement_plan_flag` BOOLEAN COMMENT 'Whether on PIP.',
    `performance_review_status` STRING COMMENT 'Overall status.',
    `record_audit_created` TIMESTAMP COMMENT 'Audit creation timestamp.',
    `record_audit_updated` TIMESTAMP COMMENT 'Audit update timestamp.',
    `review_completion_date` DATE COMMENT 'Review completion date.',
    `review_cycle_number` STRING COMMENT 'Review cycle number.',
    `review_due_date` DATE COMMENT 'Review due date.',
    `review_number` STRING COMMENT 'Review number.',
    `review_period_end` DATE COMMENT 'Review period end.',
    `review_period_start` DATE COMMENT 'Review period start.',
    `review_status` STRING COMMENT 'Review status.',
    `review_type` STRING COMMENT 'Type of review.',
    `salary_adjustment_amount` DECIMAL(18,2) COMMENT 'Salary adjustment amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Tracks employee performance reviews and ratings.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `training_course_id` BIGINT COMMENT 'FK to training course.',
    `assessment_result_description` STRING COMMENT 'Assessment result description.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Assessment score.',
    `completion_timestamp` TIMESTAMP COMMENT 'Completion timestamp.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `delivery_method` STRING COMMENT 'Delivery method.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `is_expired` BOOLEAN COMMENT 'Whether expired.',
    `notes` STRING COMMENT 'Free-text notes.',
    `pass_fail_status` STRING COMMENT 'Pass or fail status.',
    `recertification_required` BOOLEAN COMMENT 'Whether recertification required.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `record_version` STRING COMMENT 'Record version.',
    `trainer_name` STRING COMMENT 'Trainer name.',
    `training_hours` DECIMAL(18,2) COMMENT 'Training hours.',
    `training_location` STRING COMMENT 'Training location.',
    `training_record_number` STRING COMMENT 'Training record number.',
    `training_record_status` STRING COMMENT 'Training record status.',
    `training_type` STRING COMMENT 'Type of training.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Records employee training completions and certifications.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` (
    `workforce_certification_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `certification_category` STRING COMMENT 'Certification category.',
    `certification_code` STRING COMMENT 'Certification code.',
    `certification_name` STRING COMMENT 'Certification name.',
    `certification_number` STRING COMMENT 'Certification number.',
    `certification_type` STRING COMMENT 'Certification type.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `document_reference` STRING COMMENT 'Document reference.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `is_mandatory` BOOLEAN COMMENT 'Whether mandatory.',
    `issue_date` DATE COMMENT 'Issue date.',
    `issuing_organization` STRING COMMENT 'Issuing organization.',
    `notes` STRING COMMENT 'Free-text notes.',
    `renewal_cycle_months` STRING COMMENT 'Renewal cycle in months.',
    `renewal_date` DATE COMMENT 'Renewal date.',
    `renewal_required` BOOLEAN COMMENT 'Whether renewal required.',
    `renewal_status` STRING COMMENT 'Renewal status.',
    `required_for_role` STRING COMMENT 'Role requiring cert.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `verification_date` DATE COMMENT 'Verification date.',
    `verification_status` STRING COMMENT 'Verification status.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `workforce_certification_status` STRING COMMENT 'Overall status.',
    CONSTRAINT pk_workforce_certification PRIMARY KEY(`workforce_certification_id`)
) COMMENT 'Tracks professional certifications held by employees.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` (
    `rbac_assignment_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to primary employee.',
    `rbac_employee_id` BIGINT COMMENT 'FK to employee.',
    `rbac_role_id` BIGINT COMMENT 'FK to RBAC role.',
    `rbac_updated_by_user_employee_id` BIGINT COMMENT 'FK to updating user.',
    `access_level` STRING COMMENT 'Access level.',
    `access_reason_code` STRING COMMENT 'Reason code.',
    `access_scope` STRING COMMENT 'Access scope.',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `business_justification` STRING COMMENT 'Business justification.',
    `comments` STRING COMMENT 'The comments attribute capturing relevant data for the rbac assignment in the workforce domain.',
    `compliance_framework` STRING COMMENT 'Compliance framework.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `is_temporary` BOOLEAN COMMENT 'Whether temporary.',
    `notes` STRING COMMENT 'Free-text notes.',
    `rbac_assignment_status` STRING COMMENT 'Assignment status.',
    `revocation_date` DATE COMMENT 'Revocation date.',
    `risk_level` STRING COMMENT 'Risk level.',
    `system_name` STRING COMMENT 'System name.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_rbac_assignment PRIMARY KEY(`rbac_assignment_id`)
) COMMENT 'Assigns RBAC roles to employees for system access control.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `headcount_updated_by_user_employee_id` BIGINT COMMENT 'FK to updating user.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `primary_headcount_employee_id` BIGINT COMMENT 'FK to primary employee.',
    `actual_headcount` STRING COMMENT 'Actual headcount.',
    `approved_fte` DECIMAL(18,2) COMMENT 'Approved FTE.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Budget variance amount.',
    `budget_variance_percent` DECIMAL(18,2) COMMENT 'Budget variance percent.',
    `budgeted_headcount` STRING COMMENT 'Budgeted headcount.',
    `compliance_review_status` STRING COMMENT 'Compliance review status.',
    `contract_headcount` STRING COMMENT 'Contract headcount.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `department_code` STRING COMMENT 'Department code.',
    `diversity_hiring_indicator` BOOLEAN COMMENT 'Diversity hiring indicator.',
    `effective_from` DATE COMMENT 'Effective from date.',
    `effective_until` DATE COMMENT 'Effective until date.',
    `filled_fte` DECIMAL(18,2) COMMENT 'Filled FTE.',
    `fiscal_year` STRING COMMENT 'Fiscal year.',
    `headcount_plan_status` STRING COMMENT 'Overall status.',
    `headcount_variance` STRING COMMENT 'Headcount variance.',
    `is_contractor` BOOLEAN COMMENT 'Whether contractor.',
    `notes` STRING COMMENT 'Free-text notes.',
    `plan_identifier` STRING COMMENT 'Plan identifier.',
    `plan_status` STRING COMMENT 'Plan status.',
    `planning_period` STRING COMMENT 'Planning period.',
    `position_title` STRING COMMENT 'Position title.',
    `requisition_number` STRING COMMENT 'Requisition number.',
    `requisition_status` STRING COMMENT 'Requisition status.',
    `time_to_fill_days` STRING COMMENT 'Time to fill in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vacant_fte` DECIMAL(18,2) COMMENT 'Vacant FTE.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Workforce headcount planning and requisition tracking.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` (
    `workforce_recruitment_id` BIGINT COMMENT 'Unique identifier.',
    `headcount_plan_id` BIGINT COMMENT 'FK to headcount plan.',
    `job_role_id` BIGINT COMMENT 'FK to job role.',
    `org_unit_id` BIGINT COMMENT 'FK to org unit.',
    `position_id` BIGINT COMMENT 'FK to position.',
    `employee_id` BIGINT COMMENT 'FK to hiring manager.',
    `tertiary_workforce_created_by_user_employee_id` BIGINT COMMENT 'FK to creating user.',
    `application_deadline` DATE COMMENT 'Application deadline.',
    `candidate_start_date` DATE COMMENT 'Candidate start date.',
    `compensation_type` STRING COMMENT 'Compensation type.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `department_code` STRING COMMENT 'Department code.',
    `interview_stage_completed` STRING COMMENT 'Interview stage completed.',
    `is_remote` BOOLEAN COMMENT 'Whether remote.',
    `job_level` STRING COMMENT 'Job level.',
    `job_posting_date` DATE COMMENT 'Job posting date.',
    `location_code` STRING COMMENT 'Location code.',
    `net_salary_amount` DECIMAL(18,2) COMMENT 'Net salary amount.',
    `notes` STRING COMMENT 'Free-text notes.',
    `number_of_applicants` STRING COMMENT 'Number of applicants.',
    `offer_accepted_date` DATE COMMENT 'Offer accepted date.',
    `offer_extended_date` DATE COMMENT 'Offer extended date.',
    `requisition_number` STRING COMMENT 'Requisition number.',
    `requisition_status` STRING COMMENT 'Requisition status.',
    `salary_adjustment_amount` DECIMAL(18,2) COMMENT 'Salary adjustment amount.',
    `salary_offer_amount` DECIMAL(18,2) COMMENT 'Salary offer amount.',
    `source_of_hire` STRING COMMENT 'Source of hire.',
    `time_to_fill_days` STRING COMMENT 'Time to fill in days.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `workforce_recruitment_status` STRING COMMENT 'Overall status.',
    CONSTRAINT pk_workforce_recruitment PRIMARY KEY(`workforce_recruitment_id`)
) COMMENT 'Tracks recruitment requisitions and hiring pipeline.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `tertiary_disciplinary_manager_employee_id` BIGINT COMMENT 'FK to manager.',
    `tertiary_quinary_disciplinary_updated_by_user_employee_id` BIGINT COMMENT 'FK to updating user.',
    `acknowledgment_status` STRING COMMENT 'Acknowledgment status.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Acknowledgment timestamp.',
    `action_date` DATE COMMENT 'Action date.',
    `action_number` STRING COMMENT 'Action number.',
    `action_type` STRING COMMENT 'Type of action.',
    `appeal_deadline` DATE COMMENT 'Appeal deadline.',
    `appeal_outcome` STRING COMMENT 'Appeal outcome.',
    `appeal_status` STRING COMMENT 'Appeal status.',
    `disciplinary_action_category` STRING COMMENT 'Action category.',
    `confidentiality_level` STRING COMMENT 'Confidentiality level.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `disciplinary_action_status` STRING COMMENT 'Action status.',
    `documentation_attached` BOOLEAN COMMENT 'Whether documentation attached.',
    `duration_days` STRING COMMENT 'Duration in days.',
    `effective_date` DATE COMMENT 'Effective date.',
    `incident_description` STRING COMMENT 'Incident description.',
    `is_repeat_offense` BOOLEAN COMMENT 'Whether repeat offense.',
    `notes` STRING COMMENT 'Free-text notes.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount.',
    `policy_violated` STRING COMMENT 'Policy violated.',
    `prior_action_count` STRING COMMENT 'Prior action count.',
    `record_status` STRING COMMENT 'Record status.',
    `suspension_end_date` DATE COMMENT 'Suspension end date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Tracks disciplinary actions taken against employees.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` (
    `compliance_event_id` BIGINT COMMENT 'Unique identifier.',
    `background_check_id` BIGINT COMMENT 'FK to background check.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `vendor_id` BIGINT COMMENT 'FK to vendor.',
    `completion_date` DATE COMMENT 'Completion date.',
    `compliance_event_status` STRING COMMENT 'Event status.',
    `compliance_outcome` STRING COMMENT 'Compliance outcome.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `due_date` DATE COMMENT 'The date value representing due date for this compliance event record.',
    `event_number` STRING COMMENT 'Event number.',
    `event_timestamp` TIMESTAMP COMMENT 'Event timestamp.',
    `event_type` STRING COMMENT 'Type of event.',
    `notes` STRING COMMENT 'Free-text notes.',
    `order_date` DATE COMMENT 'Order date.',
    `remediation_action` STRING COMMENT 'Remediation action.',
    `responsible_party` STRING COMMENT 'Responsible party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_compliance_event PRIMARY KEY(`compliance_event_id`)
) COMMENT 'Tracks workforce compliance events and outcomes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` (
    `background_check_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to creating user.',
    `background_employee_id` BIGINT COMMENT 'FK to employee.',
    `background_updated_by_user_employee_id` BIGINT COMMENT 'FK to updating user.',
    `vendor_id` BIGINT COMMENT 'FK to vendor.',
    `adjudication_decision` STRING COMMENT 'Adjudication decision.',
    `adverse_action_reason` STRING COMMENT 'Adverse action reason.',
    `background_check_status` STRING COMMENT 'Background check status.',
    `check_number` STRING COMMENT 'Check number.',
    `completion_timestamp` TIMESTAMP COMMENT 'Completion timestamp.',
    `compliance_status` STRING COMMENT 'Compliance status.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost amount.',
    `cost_currency_code` DECIMAL(18,2) COMMENT 'Cost currency code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `is_federal_program_access` BOOLEAN COMMENT 'Whether federal program access.',
    `is_oig_exclusion_flag` BOOLEAN COMMENT 'OIG exclusion flag.',
    `is_oig_exclusion_required` BOOLEAN COMMENT 'Whether OIG exclusion required.',
    `notes` STRING COMMENT 'Free-text notes.',
    `order_timestamp` TIMESTAMP COMMENT 'Order timestamp.',
    `result` STRING COMMENT 'The result attribute capturing relevant data for the background check in the workforce domain.',
    `screening_type` STRING COMMENT 'Screening type.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_background_check PRIMARY KEY(`background_check_id`)
) COMMENT 'Tracks employee background check screenings and results.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` (
    `time_and_attendance_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to employee.',
    `absence_code` STRING COMMENT 'Absence code.',
    `absence_reason` STRING COMMENT 'Absence reason.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Clock in timestamp.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Clock out timestamp.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `department_code` STRING COMMENT 'Department code.',
    `flsa_compliance` BOOLEAN COMMENT 'Whether FLSA compliant.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Gross pay amount.',
    `holiday_hours` DECIMAL(18,2) COMMENT 'Holiday hours.',
    `job_role_code` STRING COMMENT 'Job role code.',
    `location_code` STRING COMMENT 'Location code.',
    `manager_approval_status` STRING COMMENT 'Manager approval status.',
    `manager_approval_timestamp` TIMESTAMP COMMENT 'Manager approval timestamp.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Net pay amount.',
    `notes` STRING COMMENT 'Free-text notes.',
    `overtime_eligibility` BOOLEAN COMMENT 'Whether overtime eligible.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Overtime hours.',
    `pay_period_code` STRING COMMENT 'Pay period code.',
    `payroll_integration_status` STRING COMMENT 'Payroll integration status.',
    `payroll_processed_timestamp` TIMESTAMP COMMENT 'Payroll processed timestamp.',
    `period_end_date` DATE COMMENT 'Period end date.',
    `period_start_date` DATE COMMENT 'Period start date.',
    `pto_used_hours` DECIMAL(18,2) COMMENT 'PTO used hours.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Regular hours.',
    `shift_code` STRING COMMENT 'Shift code.',
    `shift_differential_hours` DECIMAL(18,2) COMMENT 'Shift differential hours.',
    `sick_hours_used` DECIMAL(18,2) COMMENT 'Sick hours used.',
    `submission_timestamp` TIMESTAMP COMMENT 'Submission timestamp.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount.',
    `time_and_attendance_status` STRING COMMENT 'Overall status.',
    `time_entry_device_code` STRING COMMENT 'Time entry device code.',
    `time_entry_error_code` STRING COMMENT 'Time entry error code.',
    `time_entry_method` STRING COMMENT 'Time entry method.',
    `time_entry_source` STRING COMMENT 'Time entry source.',
    `time_entry_type` STRING COMMENT 'Time entry type.',
    `timesheet_number` STRING COMMENT 'Timesheet number.',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Total hours worked.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_time_and_attendance PRIMARY KEY(`time_and_attendance_id`)
) COMMENT 'Tracks employee time entries and attendance records.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique identifier.',
    `parent_compensation_plan_id` BIGINT COMMENT 'FK to parent plan.',
    `base_amount` DECIMAL(18,2) COMMENT 'Base amount.',
    `benefit_plan_name` STRING COMMENT 'Benefit plan name.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Bonus amount.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate.',
    `compensation_plan_status` STRING COMMENT 'Overall status.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency` STRING COMMENT 'The currency attribute capturing relevant data for the compensation plan in the workforce domain.',
    `effective_from` DATE COMMENT 'Effective from date.',
    `effective_until` DATE COMMENT 'Effective until date.',
    `equity_type` STRING COMMENT 'Equity type.',
    `equity_units` STRING COMMENT 'Equity units.',
    `notes` STRING COMMENT 'Free-text notes.',
    `plan_category` STRING COMMENT 'Plan category.',
    `plan_code` STRING COMMENT 'Plan code.',
    `plan_description` STRING COMMENT 'Plan description.',
    `plan_name` STRING COMMENT 'Plan name.',
    `plan_notes` STRING COMMENT 'Plan notes.',
    `plan_status` STRING COMMENT 'Plan status.',
    `plan_type` STRING COMMENT 'Plan type.',
    `plan_version` STRING COMMENT 'Plan version.',
    `termination_date` DATE COMMENT 'Termination date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `variable_amount` DECIMAL(18,2) COMMENT 'Variable amount.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Defines compensation plan structures and parameters.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` (
    `rbac_role_id` BIGINT COMMENT 'Unique identifier.',
    `role_parent_rbac_role_id` BIGINT COMMENT 'FK to parent role.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_from` DATE COMMENT 'Effective from date.',
    `effective_until` DATE COMMENT 'Effective until date.',
    `notes` STRING COMMENT 'Free-text notes.',
    `rbac_role_status` STRING COMMENT 'Overall status.',
    `role_code` STRING COMMENT 'Role code.',
    `role_description` STRING COMMENT 'Role description.',
    `role_group` STRING COMMENT 'Role group.',
    `role_is_active` BOOLEAN COMMENT 'Whether active.',
    `role_is_system` BOOLEAN COMMENT 'Whether system role.',
    `role_is_temporary` BOOLEAN COMMENT 'Whether temporary.',
    `role_level` STRING COMMENT 'Role level.',
    `role_name` STRING COMMENT 'Role name.',
    `role_scope` STRING COMMENT 'Role scope.',
    `role_scope_type` STRING COMMENT 'Role scope type.',
    `role_status` STRING COMMENT 'Role status.',
    `role_type` STRING COMMENT 'Role type.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_rbac_role PRIMARY KEY(`rbac_role_id`)
) COMMENT 'Defines RBAC roles for system access control.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier.',
    `employee_id` BIGINT COMMENT 'FK to course owner employee.',
    `vendor_id` BIGINT COMMENT 'FK to vendor.',
    `training_course_code` STRING COMMENT 'Course code.',
    `compliance_due_date` DATE COMMENT 'Compliance due date.',
    `compliance_status` STRING COMMENT 'Compliance status.',
    `cost` DECIMAL(18,2) COMMENT 'Course cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `delivery_mode` STRING COMMENT 'Delivery mode.',
    `training_course_description` STRING COMMENT 'Course description.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Duration in hours.',
    `effective_from` DATE COMMENT 'Effective from date.',
    `effective_until` DATE COMMENT 'Effective until date.',
    `is_mandatory` BOOLEAN COMMENT 'Whether mandatory.',
    `language` STRING COMMENT 'Course language.',
    `training_course_name` STRING COMMENT 'Course name.',
    `notes` STRING COMMENT 'Free-text notes.',
    `training_course_status` STRING COMMENT 'Course status.',
    `training_course_type` STRING COMMENT 'Course type.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp.',
    `version` STRING COMMENT 'Course version.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Defines training courses available to employees.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ADD CONSTRAINT `fk_workforce_job_role_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_tertiary_employment_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_employment_hr_business_partner_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_primary_compensation_employee_id` FOREIGN KEY (`primary_compensation_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ADD CONSTRAINT `fk_workforce_payroll_disbursement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ADD CONSTRAINT `fk_workforce_payroll_disbursement_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ADD CONSTRAINT `fk_workforce_payroll_disbursement_time_and_attendance_id` FOREIGN KEY (`time_and_attendance_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`time_and_attendance`(`time_and_attendance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_payroll_disbursement_id` FOREIGN KEY (`payroll_disbursement_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement`(`payroll_disbursement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_tertiary_payroll_updated_by_user_employee_id` FOREIGN KEY (`tertiary_payroll_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ADD CONSTRAINT `fk_workforce_employee_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_rbac_employee_id` FOREIGN KEY (`rbac_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_rbac_role_id` FOREIGN KEY (`rbac_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`rbac_role`(`rbac_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_rbac_updated_by_user_employee_id` FOREIGN KEY (`rbac_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_headcount_updated_by_user_employee_id` FOREIGN KEY (`headcount_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_primary_headcount_employee_id` FOREIGN KEY (`primary_headcount_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_headcount_plan_id` FOREIGN KEY (`headcount_plan_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_tertiary_workforce_created_by_user_employee_id` FOREIGN KEY (`tertiary_workforce_created_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_disciplinary_manager_employee_id` FOREIGN KEY (`tertiary_disciplinary_manager_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_quinary_disciplinary_updated_by_user_employee_id` FOREIGN KEY (`tertiary_quinary_disciplinary_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ADD CONSTRAINT `fk_workforce_compliance_event_background_check_id` FOREIGN KEY (`background_check_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`background_check`(`background_check_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ADD CONSTRAINT `fk_workforce_compliance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_background_employee_id` FOREIGN KEY (`background_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_background_updated_by_user_employee_id` FOREIGN KEY (`background_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ADD CONSTRAINT `fk_workforce_time_and_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_parent_compensation_plan_id` FOREIGN KEY (`parent_compensation_plan_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ADD CONSTRAINT `fk_workforce_rbac_role_role_parent_rbac_role_id` FOREIGN KEY (`role_parent_rbac_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`rbac_role`(`rbac_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('dbx_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_type' = 'dob');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employee_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `health_plan_eligible` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `health_plan_eligible` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `health_plan_eligible` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `hipaa_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Training Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `i9_verification_date` SET TAGS ('dbx_business_glossary_term' = 'I-9 Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `organization_level` SET TAGS ('dbx_business_glossary_term' = 'Organization Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `security_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Security Training Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'SSN');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_type' = 'ssn');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('dbx_fhir_resource' = 'PractitionerRole');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `compliance_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `eeo1_category` SET TAGS ('dbx_business_glossary_term' = 'EEO-1 Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'FLSA Classification');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'FTE Allocation');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `hipaa_privacy_training_required` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Training Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `incentive_plan` SET TAGS ('dbx_business_glossary_term' = 'Incentive Plan');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `is_managerial` SET TAGS ('dbx_business_glossary_term' = 'Is Managerial');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_max` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Max');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_mid` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Mid');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_min` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Min');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `phi_access_tier` SET TAGS ('dbx_business_glossary_term' = 'PHI Access Tier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `remote_allowed` SET TAGS ('dbx_business_glossary_term' = 'Remote Allowed');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `salary_band` SET TAGS ('dbx_business_glossary_term' = 'Salary Band');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `salary_band` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `salary_band` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `supervisory_level` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `travel_required` SET TAGS ('dbx_business_glossary_term' = 'Travel Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Member');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('dbx_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('dbx_fhir_resource' = 'PractitionerRole');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `compensation_band` SET TAGS ('dbx_business_glossary_term' = 'Compensation Band');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `compensation_band` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `compensation_band` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `eeo_category` SET TAGS ('dbx_business_glossary_term' = 'EEO Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `external_system_source` SET TAGS ('dbx_business_glossary_term' = 'External System Source');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `flsa_exempt_status` SET TAGS ('dbx_business_glossary_term' = 'FLSA Exempt Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `hipaa_training_required` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Training Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `is_clinical` SET TAGS ('dbx_business_glossary_term' = 'Is Clinical');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `is_managerial` SET TAGS ('dbx_business_glossary_term' = 'Is Managerial');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `job_function` SET TAGS ('dbx_business_glossary_term' = 'Job Function');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `job_role_status` SET TAGS ('dbx_business_glossary_term' = 'Job Role Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `legacy_role_code` SET TAGS ('dbx_business_glossary_term' = 'Legacy Role Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `organization_unit` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `pay_currency` SET TAGS ('dbx_business_glossary_term' = 'Pay Currency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `pay_grade_max` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Max');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `pay_grade_min` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Min');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `phi_access_tier` SET TAGS ('dbx_business_glossary_term' = 'PHI Access Tier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_access_level` SET TAGS ('dbx_business_glossary_term' = 'Role Access Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Role Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_level` SET TAGS ('dbx_business_glossary_term' = 'Role Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_notes` SET TAGS ('dbx_business_glossary_term' = 'Role Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Role Owner Department');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Role Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_version` SET TAGS ('dbx_business_glossary_term' = 'Role Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('dbx_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Org Unit');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `compliance_training_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount` SET TAGS ('dbx_business_glossary_term' = 'Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `is_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Is Cost Center');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `is_profit_center` SET TAGS ('dbx_business_glossary_term' = 'Is Profit Center');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_level` SET TAGS ('dbx_business_glossary_term' = 'Org Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `payroll_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Payroll Allocation Method');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_function` SET TAGS ('dbx_business_glossary_term' = 'Primary Function');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `rbac_scope` SET TAGS ('dbx_business_glossary_term' = 'RBAC Scope');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('dbx_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_record_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Org Unit');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Position');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'HR Business Partner');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Action Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Action Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_subtype` SET TAGS ('dbx_business_glossary_term' = 'Action Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_record_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `new_pay_grade` SET TAGS ('dbx_business_glossary_term' = 'New Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `policy_violated` SET TAGS ('dbx_business_glossary_term' = 'Policy Violated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `prior_pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Prior Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `suspension_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Duration');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('dbx_subdomain' = 'payroll_compensation');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_frequency` SET TAGS ('dbx_business_glossary_term' = 'Bonus Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_type` SET TAGS ('dbx_business_glossary_term' = 'Bonus Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `equity_amount` SET TAGS ('dbx_business_glossary_term' = 'Equity Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `equity_type` SET TAGS ('dbx_business_glossary_term' = 'Equity Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `equity_vesting_schedule` SET TAGS ('dbx_business_glossary_term' = 'Vesting Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `incentive_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Incentive Target Pct');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Exempt');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `is_flexible` SET TAGS ('dbx_business_glossary_term' = 'Is Flexible');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `overtime_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Max');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_mid` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Mid');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_mid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_mid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Min');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `shift_differential` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'payroll_compensation');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Reference');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `is_manual_run` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Run');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Batch Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Cycle Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Execution Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employee_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Deductions');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Tax');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('dbx_subdomain' = 'payroll_compensation');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Disbursement ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `time_and_attendance_id` SET TAGS ('dbx_business_glossary_term' = 'Time and Attendance');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_type' = 'financial');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_type' = 'financial');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock In');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock Out');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `federal_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withheld');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fica_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'FICA Tax Withheld');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'GL Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'LOB Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `manager_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax Withheld');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `other_deductions_total` SET TAGS ('dbx_business_glossary_term' = 'Other Deductions Total');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_stub_number` SET TAGS ('dbx_business_glossary_term' = 'Pay Stub Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pto_hours` SET TAGS ('dbx_business_glossary_term' = 'PTO Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `shift_differential_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `sick_hours` SET TAGS ('dbx_business_glossary_term' = 'Sick Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `state_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'State Tax Withheld');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `state_tax_withheld` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `timesheet_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `timesheet_status` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('dbx_subdomain' = 'payroll_compensation');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Cost Allocation ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Disbursement');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `tertiary_payroll_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `tertiary_payroll_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `tertiary_payroll_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_benefit_cost` SET TAGS ('dbx_business_glossary_term' = 'Allocated Benefit Cost');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_employer_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Employer Tax');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Gross Pay');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_amount_total` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount Total');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Allocation Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `is_manual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'LOB Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_cost_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('dbx_subdomain' = 'benefits_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `benefit_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `cobra_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `cobra_start_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_benefit_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `is_aca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is ACA Compliant');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `is_cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is COBRA Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `payroll_deduction_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Deduction Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `total_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Contribution');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'benefits_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `accommodation_details` SET TAGS ('dbx_business_glossary_term' = 'Accommodation Details');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `ada_accommodation_required` SET TAGS ('dbx_business_glossary_term' = 'ADA Accommodation Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_days` SET TAGS ('dbx_business_glossary_term' = 'Approved Days');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'FMLA Eligible');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `intermittent` SET TAGS ('dbx_business_glossary_term' = 'Intermittent');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Leave Policy Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_amount` SET TAGS ('dbx_business_glossary_term' = 'Payroll Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_impact` SET TAGS ('dbx_business_glossary_term' = 'Payroll Impact');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_days` SET TAGS ('dbx_business_glossary_term' = 'Requested Days');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `average_goal_rating` SET TAGS ('dbx_business_glossary_term' = 'Average Goal Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_communication_rating` SET TAGS ('dbx_business_glossary_term' = 'Communication Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_teamwork_rating` SET TAGS ('dbx_business_glossary_term' = 'Teamwork Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment_ref` SET TAGS ('dbx_business_glossary_term' = 'Self Assessment Ref');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_1_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal 1 Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_2_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal 2 Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_3_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal 3 Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `is_finalized` SET TAGS ('dbx_business_glossary_term' = 'Is Finalized');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_narrative` SET TAGS ('dbx_business_glossary_term' = 'Manager Narrative');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Pct');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_recommendation_amount` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'PIP Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'PIP Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Audit Created');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end` SET TAGS ('dbx_business_glossary_term' = 'Review Period End');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Course');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `assessment_result_description` SET TAGS ('dbx_business_glossary_term' = 'Assessment Result');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `is_expired` SET TAGS ('dbx_business_glossary_term' = 'Is Expired');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `recertification_required` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_number` SET TAGS ('dbx_business_glossary_term' = 'Training Record Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `issuing_organization` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organization');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Months');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `required_for_role` SET TAGS ('dbx_business_glossary_term' = 'Required For Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ALTER COLUMN `workforce_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'RBAC Assignment ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary RBAC Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_role_id` SET TAGS ('dbx_business_glossary_term' = 'RBAC Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `access_level` SET TAGS ('dbx_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `access_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Access Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `access_scope` SET TAGS ('dbx_business_glossary_term' = 'Access Scope');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `is_temporary` SET TAGS ('dbx_business_glossary_term' = 'Is Temporary');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `system_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `primary_headcount_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `primary_headcount_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `primary_headcount_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte` SET TAGS ('dbx_business_glossary_term' = 'Approved FTE');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budget_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percent');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `contract_headcount` SET TAGS ('dbx_business_glossary_term' = 'Contract Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `diversity_hiring_indicator` SET TAGS ('dbx_business_glossary_term' = 'Diversity Hiring');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `filled_fte` SET TAGS ('dbx_business_glossary_term' = 'Filled FTE');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_variance` SET TAGS ('dbx_business_glossary_term' = 'Headcount Variance');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `is_contractor` SET TAGS ('dbx_business_glossary_term' = 'Is Contractor');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill Days');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `vacant_fte` SET TAGS ('dbx_business_glossary_term' = 'Vacant FTE');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `workforce_recruitment_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `headcount_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `job_role_id` SET TAGS ('dbx_business_glossary_term' = 'Job Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `tertiary_workforce_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `tertiary_workforce_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `tertiary_workforce_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `application_deadline` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `candidate_start_date` SET TAGS ('dbx_business_glossary_term' = 'Candidate Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `interview_stage_completed` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Is Remote');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `job_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `net_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Salary Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `net_salary_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `net_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `number_of_applicants` SET TAGS ('dbx_business_glossary_term' = 'Number of Applicants');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Salary Offer Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_offer_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_offer_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `source_of_hire` SET TAGS ('dbx_business_glossary_term' = 'Source of Hire');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill Days');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `workforce_recruitment_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'benefits_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_quinary_disciplinary_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_quinary_disciplinary_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_quinary_disciplinary_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Action Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `documentation_attached` SET TAGS ('dbx_business_glossary_term' = 'Documentation Attached');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration Days');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `is_repeat_offense` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Offense');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `policy_violated` SET TAGS ('dbx_business_glossary_term' = 'Policy Violated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `prior_action_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Action Count');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('dbx_subdomain' = 'benefits_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `background_check_id` SET TAGS ('dbx_business_glossary_term' = 'Background Check');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `compliance_event_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('dbx_subdomain' = 'benefits_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_check_id` SET TAGS ('dbx_business_glossary_term' = 'Background Check ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `adjudication_decision` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Decision');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `adverse_action_reason` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `is_federal_program_access` SET TAGS ('dbx_business_glossary_term' = 'Federal Program Access');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `is_oig_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'OIG Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `is_oig_exclusion_required` SET TAGS ('dbx_business_glossary_term' = 'OIG Exclusion Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Result');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `screening_type` SET TAGS ('dbx_business_glossary_term' = 'Screening Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_and_attendance_id` SET TAGS ('dbx_business_glossary_term' = 'Time and Attendance ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `absence_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock In');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock Out');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `flsa_compliance` SET TAGS ('dbx_business_glossary_term' = 'FLSA Compliance');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `holiday_hours` SET TAGS ('dbx_business_glossary_term' = 'Holiday Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `job_role_code` SET TAGS ('dbx_business_glossary_term' = 'Job Role Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `manager_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `manager_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `overtime_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `pay_period_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `payroll_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Integration Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `payroll_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `pto_used_hours` SET TAGS ('dbx_business_glossary_term' = 'PTO Used Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `shift_differential_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `sick_hours_used` SET TAGS ('dbx_business_glossary_term' = 'Sick Hours Used');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_and_attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_device_code` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Device Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_error_code` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_method` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Method');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_source` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Source');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `timesheet_number` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'payroll_compensation');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `parent_compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Plan');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `parent_compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `parent_compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `benefit_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `benefit_plan_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `equity_type` SET TAGS ('dbx_business_glossary_term' = 'Equity Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `equity_units` SET TAGS ('dbx_business_glossary_term' = 'Equity Units');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Plan Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `variable_amount` SET TAGS ('dbx_business_glossary_term' = 'Variable Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('dbx_subdomain' = 'access_security');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `rbac_role_id` SET TAGS ('dbx_business_glossary_term' = 'RBAC Role ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_parent_rbac_role_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `rbac_role_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Role Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_group` SET TAGS ('dbx_business_glossary_term' = 'Role Group');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_system` SET TAGS ('dbx_business_glossary_term' = 'Is System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_temporary` SET TAGS ('dbx_business_glossary_term' = 'Is Temporary');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_level` SET TAGS ('dbx_business_glossary_term' = 'Role Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_name` SET TAGS ('dbx_business_glossary_term' = 'Role Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_scope` SET TAGS ('dbx_business_glossary_term' = 'Role Scope');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_scope_type` SET TAGS ('dbx_business_glossary_term' = 'Role Scope Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Course Owner');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Course Cost');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
