-- Schema for Domain: workforce | Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `restaurants_ecm`.`workforce` COMMENT 'Manages employee lifecycle including recruiting, onboarding, scheduling, time and attendance, labor forecasting, Labor% optimization, FTE tracking, certifications (ServSafe), performance management, and payroll integration via Workday HCM and Planday. Optimizes labor deployment across dayparts, BOH/FOH staffing ratios, and restaurant locations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique system-generated identifier for each employee.',
    `department_id` BIGINT COMMENT 'Foreign key linking to restaurant.department. Business justification: Employees are assigned to restaurant departments (FOH, BOH, management). The existing plain-text department column on employee is a denormalized representation of restaurant.department. Proper FK en',
    `unit_id` BIGINT COMMENT 'Primary restaurant location to which the employee is assigned.',
    `employee_unit_id` BIGINT COMMENT 'Primary restaurant location to which the employee is assigned.',
    `employee_work_location_unit_id` BIGINT COMMENT 'Specific work site (e.g., kitchen, dining area) within the restaurant.',
    `facility_id` BIGINT COMMENT 'Specific work site (e.g., kitchen, dining area) within the restaurant.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchise employees are employed by the franchisee entity, not the franchisor. Linking employee to franchisee enables franchisee labor compliance reporting — compliance audits, FDD labor disclosures',
    `manager_employee_id` BIGINT COMMENT 'Identifier of the employees direct manager.',
    `address_line1` STRING COMMENT 'Primary street address of the employees residence.',
    `address_line2` STRING COMMENT 'Secondary address information (apartment, suite, etc.).',
    `bank_account_number` STRING COMMENT 'Bank account number used for direct deposit of payroll.',
    `city` STRING COMMENT 'City of the employees residence.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the employees residence. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN — 8 candidates stripped; promote to reference product]',
    `date_of_birth` DATE COMMENT 'Birth date of the employee, used for age‑based compliance and benefits.',
    `email` STRING COMMENT 'Primary email address used for employee communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of emergency.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization.. Valid values are `active|inactive|terminated|on_leave|retired`',
    `employment_type` STRING COMMENT 'Classification of employment relationship (Full‑Time, Part‑Time, Contractor).. Valid values are `fte|pte|contractor`',
    `first_name` STRING COMMENT 'Legal first name of the employee.',
    `full_name` STRING COMMENT 'Concatenated first and last name for display purposes.',
    `hire_date` DATE COMMENT 'Date the employee started employment with the company.',
    `job_title` STRING COMMENT 'Official title or position held by the employee.',
    `labor_percentage_target` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the employees role.',
    `last_name` STRING COMMENT 'Legal last name of the employee.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the employee is eligible for overtime pay.',
    `pay_grade` STRING COMMENT 'Internal pay grade code used for compensation planning.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the employees residence.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record.',
    `role_classification` STRING COMMENT 'Primary functional area where the employee works: Back‑of‑House, Front‑of‑House, Administrative, Support.. Valid values are `boh|foh|admin|support`',
    `salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount before bonuses or overtime.',
    `salary_currency` STRING COMMENT 'Three‑letter ISO currency code for the salary amount.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `servsafe_certified` BOOLEAN COMMENT 'Indicates whether the employee holds a valid ServSafe food safety certification.',
    `servsafe_expiration_date` DATE COMMENT 'Expiration date of the employees ServSafe certification.',
    `shift_pattern` STRING COMMENT 'Standard shift pattern assigned to the employee.. Valid values are `morning|evening|night|flex|rotating`',
    `state` STRING COMMENT 'State or province of the employees residence.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identification number (e.g., SSN, SIN).',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    `union_member` BOOLEAN COMMENT 'True if the employee is a member of a labor union.',
    `work_schedule_type` STRING COMMENT 'Scheduling model applied to the employee.. Valid values are `fixed|flex|rotating`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for every restaurant employee across company-owned and franchised locations. Captures full employee lifecycle data including personal details, employment type (FTE/PTE), BOH/FOH role classification, hire date, termination date, employment status, pay grade, home restaurant assignment, Workday HCM employee ID, declared availability windows (preferred dayparts, max weekly hours, blackout dates, cross-location availability), and current benefit enrollment summary. Single source of truth for workforce identity and worker profile across the enterprise.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`shift` (
    `shift_id` BIGINT COMMENT 'Unique identifier for the shift record.',
    `facility_id` BIGINT COMMENT 'Restaurant location where the shift occurs.',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.schedule. Business justification: A shift is a specific scheduled work block that belongs to a weekly/period-level schedule. The schedule is the parent container (published labor plan for a restaurant location and period); individual ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned to the shift.',
    `shift_scheduled_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who scheduled the shift.',
    `unit_id` BIGINT COMMENT 'Restaurant location where the shift occurs.',
    `actual_end` TIMESTAMP COMMENT 'Actual clock‑out timestamp recorded for the shift.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual worked hours for the shift (excluding breaks).',
    `actual_start` TIMESTAMP COMMENT 'Actual clock‑in timestamp recorded for the shift.',
    `break_duration_minutes` STRING COMMENT 'Total break time in minutes allocated for the shift.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift record was created.',
    `daypart` STRING COMMENT 'Part of the day the shift is scheduled for.. Valid values are `breakfast|lunch|dinner|late_night`',
    `is_deleted` BOOLEAN COMMENT 'Flag indicating soft deletion of the shift record.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for the shift (rate multiplied by actual hours).',
    `labor_percentage` DECIMAL(18,2) COMMENT 'Labor cost expressed as a percentage of projected sales for the shift.',
    `labor_rate_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the labor rate.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Pay rate per hour for the employee on this shift.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the shift.',
    `on_call_flag` BOOLEAN COMMENT 'Indicates if the shift is an on‑call assignment.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates if the shift includes overtime hours.',
    `scheduled_end` TIMESTAMP COMMENT 'Planned end timestamp of the shift.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Planned shift duration in hours (excluding breaks).',
    `scheduled_start` TIMESTAMP COMMENT 'Planned start timestamp of the shift.',
    `shift_code` STRING COMMENT 'Human‑readable code for the shift (e.g., SHIFT20230915-001).',
    `shift_date` DATE COMMENT 'Calendar date of the shift (derived from scheduled_start).',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift.. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `shift_type` STRING COMMENT 'Classification of the shift (e.g., regular, overtime, on‑call, training).. Valid values are `regular|overtime|on_call|training`',
    `source_system` STRING COMMENT 'System that originated the shift schedule.. Valid values are `planday|workday|manual`',
    `station` STRING COMMENT 'Work station or area assigned to the employee (Back‑of‑House, Front‑of‑House, etc.).. Valid values are `BOH|FOH|drive_thru|delivery`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shift record.',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Represents a scheduled work shift for an employee at a specific restaurant location, daypart (breakfast, lunch, dinner, late-night), and station assignment (grill, fry, drive-thru, expo, host, bar, dish). Captures planned start/end times, actual clock-in/clock-out times, assigned BOH/FOH station, shift type (regular, overtime, on-call, training), break duration, scheduling source (Planday), and swap/coverage details (original assignee, covering employee, swap request reason, swap approval status, approval timestamp) when shift reassignment occurs. Core operational record for labor deployment, station coverage planning, Speed of Service (SOS) staffing optimization, and Planday shift coverage workflows.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique system-generated identifier for each labor schedule.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pre-period labor cost control by cost center: restaurant managers and finance teams review scheduled labor cost against cost center budgets before the week begins. schedule has no cost_center_id; this',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Schedule-to-period labor cost alignment: schedules span period_start_date/period_end_date and must align to financial periods for labor cost period-close accruals and budget vs. actual reporting. Plai',
    `labor_budget_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_budget. Business justification: A published schedule is the operational execution plan for a restaurant location and period, and it must be planned against an approved labor budget. Adding labor_budget_id to schedule links the opera',
    `labor_forecast_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_forecast. Business justification: Labor schedules in foodservice are built directly from labor forecasts — the projected FTE demand by daypart drives how many employees are scheduled per shift. Adding labor_forecast_id to schedule doc',
    `nro_pipeline_id` BIGINT COMMENT 'Foreign key linking to franchise.nro_pipeline. Business justification: New restaurant openings require pre-opening staffing schedules created before the unit is operational. Linking schedule to nro_pipeline enables NRO pre-opening staffing planning — franchise developm',
    `employee_id` BIGINT COMMENT 'Unique identifier of the manager or supervisor who approved the schedule.',
    `schedule_manager_employee_id` BIGINT COMMENT 'Unique identifier of the manager or supervisor who approved the schedule.',
    `unit_id` BIGINT COMMENT 'Unique identifier of the restaurant unit for which the schedule is created.',
    `schedule_unit_id` BIGINT COMMENT 'Unique identifier of the restaurant unit for which the schedule is created.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule was formally approved by the manager.',
    `approved_by` STRING COMMENT 'Display name of the manager who approved the schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the schedule record was first created in the system.',
    `daypart_schedule_notes` STRING COMMENT 'Optional comments or special instructions for each daypart (e.g., event staffing, overtime alerts).',
    `fte_evening` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent staff for the evening shift (e.g., 16:00‑22:00).',
    `fte_midday` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent staff for the midday shift (e.g., 12:00‑16:00).',
    `fte_morning` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent staff for the morning shift (e.g., 06:00‑12:00).',
    `fte_night` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent staff for the night shift (e.g., 22:00‑02:00).',
    `fte_total` DECIMAL(18,2) COMMENT 'Sum of planned FTEs across all dayparts for the schedule period.',
    `labor_pct_evening` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the evening shift.',
    `labor_pct_midday` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the midday shift.',
    `labor_pct_morning` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the morning shift.',
    `labor_pct_night` DECIMAL(18,2) COMMENT 'Target labor cost as a percentage of sales for the night shift.',
    `labor_percentage` DECIMAL(18,2) COMMENT 'Target labor cost expressed as a percentage of projected sales for the period.',
    `period_end_date` DATE COMMENT 'Last calendar date covered by the schedule.',
    `period_start_date` DATE COMMENT 'First calendar date covered by the schedule.',
    `schedule_number` STRING COMMENT 'Human‑readable schedule code assigned by the scheduling system (e.g., SCHED‑2024‑W15).',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the schedule: draft (editable), published (visible to staff), or locked (finalized).. Valid values are `draft|published|locked`',
    `total_scheduled_hours` DECIMAL(18,2) COMMENT 'Aggregate number of labor hours planned across all dayparts and positions for the schedule period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the schedule.',
    `version` STRING COMMENT 'Incremental version of the schedule used for audit and rollback purposes.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Weekly or period-level labor schedule published for a restaurant location, representing the planned staffing plan across all dayparts. Captures schedule period (start/end dates), restaurant unit, total scheduled hours, scheduled Labor%, FTE count by daypart, publication status (draft/published/locked), and the manager who approved the schedule. Links to individual shifts for granular staffing detail.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique surrogate key for the time entry record.',
    `department_id` BIGINT COMMENT 'Foreign key linking to restaurant.department. Business justification: Real-time labor cost allocation by department (FOH vs BOH) is a core restaurant finance and operations process. time_entry records actual hours worked; without a department FK, department-level labor ',
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant location where the work was performed.',
    `payroll_record_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_record. Business justification: Time entries (actual clock-in/clock-out events) are the source data aggregated into period-level payroll records. Adding payroll_record_id to time_entry links each time entry to the payroll record it ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the time entry.',
    `shift_id` BIGINT COMMENT 'Identifier of the scheduled shift associated with this time entry.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the work was performed.',
    `approved_by_manager` BOOLEAN COMMENT 'True when a manager has approved the time entry.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the entry was approved by a manager.',
    `break_flag` BOOLEAN COMMENT 'True if a break was taken during the shift.',
    `break_minutes` STRING COMMENT 'Total minutes taken for breaks during the shift.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the employee clocked in.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the employee clocked out.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the time entry record was first created.',
    `entry_number` STRING COMMENT 'Human‑readable unique code for the time entry.',
    `job_role` STRING COMMENT 'Functional role of the employee during the shift.. Valid values are `front_of_house|back_of_house|management|support|other`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Monetary cost of the labor for this entry (total_hours * labor_rate).',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly wage rate applicable to the employee for this entry (in local currency).',
    `missed_punch_flag` BOOLEAN COMMENT 'True if the employee missed a clock‑in or clock‑out punch.',
    `notes` STRING COMMENT 'Optional free‑form comments or remarks about the time entry.',
    `overtime_flag` BOOLEAN COMMENT 'True if any overtime hours were recorded.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked.',
    `pay_code` STRING COMMENT 'Payroll code indicating the type of pay (regular, overtime, sick leave, etc.).. Valid values are `REG|OT|SL|VAC|OTHER`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of non‑overtime hours worked.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date‑time of the shift according to the schedule.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date‑time of the shift according to the schedule.',
    `source_system` STRING COMMENT 'System that originated the time entry record.. Valid values are `workday|pos|planday`',
    `time_entry_status` STRING COMMENT 'Current lifecycle status of the time entry.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `time_entry_type` STRING COMMENT 'Method by which the time entry was recorded.. Valid values are `clock_in_out|manual|adjustment`',
    `total_hours` DECIMAL(18,2) COMMENT 'Total number of hours (including overtime and breaks) recorded for the entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the time entry.',
    `work_date` DATE COMMENT 'Calendar date on which the shift occurred.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Captures actual clock-in and clock-out events for each employee per shift, sourced from Workday HCM time tracking or POS-integrated time clocks. Records regular hours, overtime hours, break time, missed punch flags, and manager approval status. Foundation for payroll processing, Labor% calculation, and compliance with FLSA/OSHA labor regulations.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`labor_forecast` (
    `labor_forecast_id` BIGINT COMMENT 'Unique identifier for the labor forecast record. _canonical_skip_reason: Entity does not fit standard role categories; treated as OTHER.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: In QSR/casual dining, workforce planners build labor forecasts directly from marketing campaign calendars — projecting FTE and labor cost for campaign periods. labor_forecast already has promotion_fla',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Labor cost forecasting by cost center: labor forecasts drive cost center spending projections used in rolling forecasts and flash P&L reporting. Restaurant finance teams use cost center as the primary',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Rolling forecast period alignment: labor forecasts must align to financial periods for weekly/period flash reporting and forecast vs. actual variance analysis. forecast_date and week_number are plain ',
    `menu_lto_id` BIGINT COMMENT 'Foreign key linking to menu.menu_lto. Business justification: LTO launches require dedicated labor forecasting — new menu items increase prep complexity and throughput demands. Linking labor_forecast to the specific LTO enables pre-launch staffing planning and p',
    `nro_pipeline_id` BIGINT COMMENT 'Foreign key linking to franchise.nro_pipeline. Business justification: NRO pipeline records carry expected_labor_percent and expected_traffic_volume that seed initial labor forecasts for new units. Linking labor_forecast to nro_pipeline enables NRO labor planning — fra',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location for which the labor forecast is generated.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center labor P&L forecasting: labor forecasts are used in profit center P&L projections for restaurant-level financial planning. labor_forecast links to restaurant.unit but not to finance.profi',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to marketing.promotion. Business justification: LTO and promotional events directly drive traffic spikes requiring specific staffing plans. labor_forecast has lto_flag and promotion_flag columns confirming this dependency. Ops teams receive promoti',
    `confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence level (0‑100) of the forecast output.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the day for which labor is forecasted.. Valid values are `breakfast|lunch|dinner|late_night`',
    `expected_adt` STRING COMMENT 'Projected average daily transaction count for the forecast period.',
    `expected_atc` STRING COMMENT 'Projected average number of items per transaction for the forecast period.',
    `forecast_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast record was initially created.',
    `forecast_date` DATE COMMENT 'The calendar date for which the labor forecast applies.',
    `forecast_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the forecast record.',
    `labor_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total labor cost (in currency) for the forecast period.',
    `labor_forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record.. Valid values are `pending|active|completed|cancelled`',
    `model_version` STRING COMMENT 'Version identifier of the forecasting model used to generate the forecast.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the forecast.',
    `projected_cover_count` STRING COMMENT 'Estimated number of guests (covers) expected for the forecast period.',
    `projected_fte_boh` DECIMAL(18,2) COMMENT 'Forecasted full‑time equivalent staff needed for back‑of‑house operations.',
    `projected_fte_foh` DECIMAL(18,2) COMMENT 'Forecasted full‑time equivalent staff needed for front‑of‑house operations.',
    `projected_labor_percent` DECIMAL(18,2) COMMENT 'Projected labor cost as a percentage of total sales for the forecast period.',
    `projected_throughput` STRING COMMENT 'Estimated number of transactions/orders expected during the forecast period.',
    `promotion_flag` BOOLEAN COMMENT 'Indicates whether a planned promotion or marketing campaign is active during the forecast period.',
    `scenario` STRING COMMENT 'Scenario used for the forecast (e.g., baseline, optimistic, pessimistic).. Valid values are `baseline|optimistic|pessimistic`',
    `week_number` STRING COMMENT 'ISO week number of the forecast date.',
    `year` STRING COMMENT 'Four‑digit year of the forecast date.',
    CONSTRAINT pk_labor_forecast PRIMARY KEY(`labor_forecast_id`)
) COMMENT 'Projected labor demand by restaurant, daypart, and week based on historical transaction volume (ADT/ATC), seasonal patterns, and planned promotions or LTOs. Captures forecasted cover count, expected throughput, recommended FTE count by BOH/FOH, projected Labor%, and the forecasting model version used. Drives Planday schedule generation and labor budget alignment.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'System-generated unique identifier for the payroll record.',
    `cost_center_id` BIGINT COMMENT 'Financial cost‑center to which payroll costs are charged.',
    `department_id` BIGINT COMMENT 'Identifier of the internal department (e.g., FOH, BOH) for cost allocation.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the payroll pertains.',
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant/location where the employee works.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Payroll period-close reconciliation: payroll records must align to financial periods for period-end labor accruals, audit, and budget vs. actual variance reporting. Plain pay_period_start/end dates ca',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payroll journal posting: every payroll record maps to a primary GL expense account (wages, overtime, benefits) for period-close journal entries and financial reporting. A restaurant controller expects',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Multi-entity payroll statutory reporting: in franchise/multi-entity restaurant groups, payroll is processed per legal entity for tax filing (W-2, employer tax returns) and statutory compliance. payrol',
    `payment_id` BIGINT COMMENT 'Foreign key linking to order.payment. Business justification: IRS Form 8027 and FLSA tip reporting require reconciling declared employee tips against actual payment transactions. Linking tip_compliance directly to the payment record enables per-transaction tip a',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Unit-level P&L labor allocation: payroll costs must be attributed to a profit center for restaurant-level P&L reporting. payroll_record already has cost_center_id but not profit_center_id; restaurant ',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant/location where the employee works.',
    `benefit_deduction` DECIMAL(18,2) COMMENT 'Sum of employee benefit contributions deducted.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Monetary value of any bonus paid.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Monetary value of commission earned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `employee_address` STRING COMMENT 'Mailing address of the employee.',
    `employee_type` STRING COMMENT 'Classification of employment relationship.. Valid values are `full_time|part_time|seasonal|contractor`',
    `fiscal_period` STRING COMMENT 'Period number within the fiscal year (e.g., Q1, Q2).',
    `gross_pay` DECIMAL(18,2) COMMENT 'Total earnings before any deductions.',
    `is_bonus` BOOLEAN COMMENT 'Indicates whether the payroll includes a bonus component.',
    `job_title` STRING COMMENT 'Official job title or position held by the employee.',
    `labor_percent` DECIMAL(18,2) COMMENT 'Labor cost as a percentage of sales for the period.',
    `net_pay` DECIMAL(18,2) COMMENT 'Take‑home earnings after all deductions.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the payroll record.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Hourly rate applied to overtime hours.',
    `pay_date` DATE COMMENT 'Date on which the net amount is disbursed to the employee.',
    `pay_group` STRING COMMENT 'Grouping used for payroll processing (e.g., weekly, bi‑weekly).',
    `pay_period_end` DATE COMMENT 'Last calendar day of the payroll period.',
    `pay_period_start` DATE COMMENT 'First calendar day of the payroll period.',
    `pay_rate` DECIMAL(18,2) COMMENT 'Standard hourly or salary rate for the employee.',
    `payroll_date` TIMESTAMP COMMENT 'Exact time the payroll was run in the source system.',
    `payroll_number` STRING COMMENT 'Human‑readable payroll reference number assigned by the payroll system.',
    `payroll_record_status` STRING COMMENT 'Current processing state of the payroll record.. Valid values are `processed|pending|error|cancelled`',
    `payroll_type` STRING COMMENT 'Nature of compensation for the period.. Valid values are `salary|hourly|commission|bonus`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total non‑overtime hours worked.',
    `source_system` STRING COMMENT 'Originating system for the payroll data (e.g., Workday HCM).',
    `tax_withheld` DECIMAL(18,2) COMMENT 'Total tax amount deducted from gross pay.',
    `tax_year` STRING COMMENT 'Fiscal year applicable for tax reporting.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Tips declared by the employee for the period.',
    `union_member_flag` BOOLEAN COMMENT 'True if the employee is a union member.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payroll record.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Period-level payroll summary for each employee, capturing gross pay, net pay, regular hours paid, overtime hours paid, tips declared, deductions (benefits, taxes, garnishments), pay period dates, and payroll run status. Sourced from Workday HCM payroll module. Serves as the authoritative payroll transaction record for finance integration and Labor% reporting.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'System-generated unique identifier for the certification record.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Brand standard compliance audits require evidence that employees hold certifications mandated by specific brand standards (e.g., ServSafe required by food-safety brand standard). brand_standard has ce',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who holds this certification.',
    `certification_code` STRING COMMENT 'Business identifier or code assigned to the certification by the issuing body.',
    `certification_name` STRING COMMENT 'Human‑readable name of the certification (e.g., ServSafe Food Handler).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|revoked|pending`',
    `certification_type` STRING COMMENT 'Category of certification required for foodservice operations.. Valid values are `food_handler|manager|allergen|haccp|alcohol|osha`',
    `compliance_status` STRING COMMENT 'Regulatory compliance assessment of the certification.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the scanned certification document stored in the document repository.',
    `expiration_date` DATE COMMENT 'Date the certification expires and must be renewed.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the certification is required for the employees role.',
    `issue_date` DATE COMMENT 'Date the certification was originally issued.',
    `issuing_body` STRING COMMENT 'Organization that issued the certification.. Valid values are `NRA_ServSafe|Local_Health_Department|OSHA|Other`',
    `last_verified_date` DATE COMMENT 'Date when the certification was last validated by internal audit.',
    `notes` STRING COMMENT 'Free‑form notes regarding the certification (e.g., special conditions, comments).',
    `renewal_notice_date` DATE COMMENT 'Date a renewal reminder is sent to the employee.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification must be renewed before expiration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Single source of truth for all employee learning credentials, training completions, and regulatory certifications required for foodservice operations. Covers external certifications (ServSafe Food Handler, ServSafe Manager, allergen awareness, HACCP, alcohol service permits, OSHA safety) and internal training completions (new hire orientation, food safety modules, POS/KDS operation, BOH/FOH SOPs, LTO product training, management development). Captures credential type, issuing body (NRA ServSafe, local health department, internal L&D), delivery method (in-person, e-learning, OJT), issue/completion date, expiration date, assessment score, trainer/facilitator, and compliance status. Critical for food safety regulatory compliance, health department inspections, scheduling eligibility validation, and employee development tracking.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'System-generated unique identifier for each training completion record.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Brand standard audits require proof that mandated training modules are completed. brand_standard carries training_module_reference and training_required_flag. Linking training_completion to the drivin',
    `certification_id` BIGINT COMMENT 'Foreign key linking to workforce.certification. Business justification: A training completion event fulfills or renews a specific certification credential. The certification table is the single source of truth for employee credentials (ServSafe, food safety, etc.). Adding',
    `facility_id` BIGINT COMMENT 'Identifier of the restaurant location where the training was completed.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: HACCP regulatory compliance requires employees to complete plan-specific training. Linking training_completion to the specific haccp_plan it satisfies enables compliance reporting (e.g., all staff tr',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: New menu item launches require crew training on preparation procedures, allergen handling, and HACCP protocols. Linking training_completion to menu_item enables tracking which employees are certified ',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who completed the training.',
    `shift_id` BIGINT COMMENT 'Identifier of the work shift associated with the training session.',
    `training_enrollment_id` BIGINT COMMENT 'Foreign key linking to franchise.training_enrollment. Business justification: Franchise training enrollment drives workforce training completion records. Linking completion back to enrollment enables franchise training compliance tracking — operators and franchisors must veri',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the training was completed.',
    `assessment_max_score` DECIMAL(18,2) COMMENT 'Maximum possible score for the assessment.',
    `assessment_passed` BOOLEAN COMMENT 'Indicates whether the employee passed the assessment (true) or not (false).',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved by the employee on the training assessment.',
    `completion_number` STRING COMMENT 'Business-assigned code for the training completion event.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the employee finished the training.',
    `compliance_status` STRING COMMENT 'Indicates whether the training satisfies regulatory or internal compliance requirements.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training completion record was first created in the system.',
    `daypart` STRING COMMENT 'Daypart during which the training took place.. Valid values are `breakfast|lunch|dinner|late_night`',
    `delivery_method` STRING COMMENT 'Method used to deliver the training to the employee.. Valid values are `in_person|e_learning|on_the_job`',
    `notes` STRING COMMENT 'Free-text field for any supplemental information or comments.',
    `required_for_role` STRING COMMENT 'Job role(s) for which this training is mandatory (e.g., cook, manager).',
    `source_system` STRING COMMENT 'System of record that originated the training completion data.. Valid values are `Workday|Planday|Zenput|Other`',
    `trainer_name` STRING COMMENT 'Full name of the trainer or facilitator.',
    `training_category` STRING COMMENT 'More specific category or module within the training type.',
    `training_completion_status` STRING COMMENT 'Current lifecycle status of the training completion record.. Valid values are `completed|in_progress|failed|cancelled`',
    `training_duration_minutes` STRING COMMENT 'Total length of the training session in minutes.',
    `training_type` STRING COMMENT 'Broad classification of the training content.. Valid values are `safety|operations|customer_service|leadership`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training completion record.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Records completion of training programs by employees, including new hire orientation, food safety modules, POS operation, KDS usage, BOH/FOH SOPs, LTO product training, and management development programs. Captures training program name, delivery method (in-person, e-learning, OJT), completion date, assessment score, and trainer/facilitator. Supports compliance tracking and performance development.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`workforce`.`labor_budget` (
    `labor_budget_id` BIGINT COMMENT 'System-generated unique identifier for each labor budget record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Franchise agreements specify labor percentage targets that unit labor budgets must comply with. Linking labor_budget to agreement enables franchise agreement labor compliance reporting — franchisors',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Labor budget ownership by cost center: labor budgets are planned and owned at the cost center level in restaurant finance. Without this FK, labor_budget cannot be reconciled against finance.cost_cente',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Labor budget as component of consolidated financial budget: workforce labor_budget feeds into the finance.budget for total restaurant cost planning. Role-prefix finance_ used to distinguish from wor',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Budget period-close alignment: labor budgets must align to financial periods for period-end budget vs. actual variance analysis and financial close. fiscal_year/fiscal_period are plain strings on labo',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Labor expense GL mapping for financial planning: labor budgets are mapped to GL accounts (wages expense, benefits, overtime) for chart-of-accounts-aligned financial planning. Without this FK, labor bu',
    `nro_pipeline_id` BIGINT COMMENT 'Foreign key linking to franchise.nro_pipeline. Business justification: Initial labor budgets for new franchise units are created during NRO planning, referencing the pipeline projects expected_labor_percent and capital budget. Linking labor_budget to nro_pipeline enable',
    `unit_id` BIGINT COMMENT 'Unique identifier of the restaurant location to which the labor budget applies.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center labor P&L planning: labor budgets feed directly into profit center P&L projections. Restaurant finance teams plan labor cost at the profit center level; labor_budget links to restaurant.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget was approved by finance.',
    `budget_category` STRING COMMENT 'Classification of the budget purpose (e.g., operational labor, training, benefits).. Valid values are `operational|capital|training|benefits`',
    `budget_code` STRING COMMENT 'External business code used to reference the budget in financial systems.',
    `budget_name` STRING COMMENT 'Human‑readable name for the labor budget (e.g., "2024 Q1 Labor Budget").',
    `budget_source` STRING COMMENT 'Origin of the budget figures (historical data, forecasting model, or manager input).. Valid values are `historical|model|manager_input`',
    `budget_status` STRING COMMENT 'Current lifecycle state of the budget record.. Valid values are `draft|submitted|approved|active|closed|rejected`',
    `budget_type` STRING COMMENT 'Granularity of the budget (annual, quarterly, monthly, weekly, or daypart specific).. Valid values are `annual|quarterly|monthly|weekly|daypart`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the budget record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Specific daypart the budget applies to; use "all_day" for full‑day budgets.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `fiscal_period` STRING COMMENT 'Period within the fiscal year (e.g., "Q1", "M03").',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year for which the budget is defined.',
    `fte_budget_boh` DECIMAL(18,2) COMMENT 'Planned BOH full‑time equivalent headcount.',
    `fte_budget_foh` DECIMAL(18,2) COMMENT 'Planned FOH full‑time equivalent headcount.',
    `fte_budget_total` DECIMAL(18,2) COMMENT 'Planned full‑time equivalent headcount for the period (combined BOH and FOH).',
    `hours_budget_boh` DECIMAL(18,2) COMMENT 'Planned BOH labor hours.',
    `hours_budget_foh` DECIMAL(18,2) COMMENT 'Planned FOH labor hours.',
    `hours_budget_total` DECIMAL(18,2) COMMENT 'Planned total labor hours for the period.',
    `labor_cost_estimate` DECIMAL(18,2) COMMENT 'Projected labor cost derived from forecasting models, may differ from the budgeted amount.',
    `labor_cost_estimate_boh` DECIMAL(18,2) COMMENT 'Projected BOH labor spend derived from forecasting.',
    `labor_cost_estimate_foh` DECIMAL(18,2) COMMENT 'Projected FOH labor spend derived from forecasting.',
    `labor_dollar_budget` DECIMAL(18,2) COMMENT 'Planned total labor spend in local currency for the period.',
    `labor_percent_target` DECIMAL(18,2) COMMENT 'Planned labor cost as a percentage of total sales for the period.',
    `labor_percent_target_boh` DECIMAL(18,2) COMMENT 'Target labor cost percentage for BOH operations.',
    `labor_percent_target_foh` DECIMAL(18,2) COMMENT 'Target labor cost percentage for FOH operations.',
    `notes` STRING COMMENT 'Free‑form comments or rationale for the budget.',
    `period_end_date` DATE COMMENT 'Last calendar date of the budgeting period.',
    `period_start_date` DATE COMMENT 'First calendar date of the budgeting period.',
    `scenario` STRING COMMENT 'Forecasting scenario used to generate the budget.. Valid values are `base|optimistic|pessimistic|promotion|lto`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the budget record.',
    `version` STRING COMMENT 'Version number of the budget record for change tracking.',
    CONSTRAINT pk_labor_budget PRIMARY KEY(`labor_budget_id`)
) COMMENT 'Period-level labor budget targets by restaurant location, capturing budgeted Labor%, budgeted total labor dollars, budgeted FTE count by BOH/FOH, budgeted hours by daypart, budgeted SPLH (Sales Per Labor Hour), and the fiscal period. Serves as the financial target against which actual labor spend (from payroll_record and time_entry) and forecasted demand (from labor_forecast) are measured. Supports P&L management, AUV optimization, and manager accountability for labor cost control.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `restaurants_ecm`.`workforce`.`schedule`(`schedule_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_shift_scheduled_by_user_employee_id` FOREIGN KEY (`shift_scheduled_by_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_labor_budget_id` FOREIGN KEY (`labor_budget_id`) REFERENCES `restaurants_ecm`.`workforce`.`labor_budget`(`labor_budget_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_labor_forecast_id` FOREIGN KEY (`labor_forecast_id`) REFERENCES `restaurants_ecm`.`workforce`.`labor_forecast`(`labor_forecast_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_schedule_manager_employee_id` FOREIGN KEY (`schedule_manager_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_record_id` FOREIGN KEY (`payroll_record_id`) REFERENCES `restaurants_ecm`.`workforce`.`payroll_record`(`payroll_record_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `restaurants_ecm`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);

-- ========= TAGS =========
ALTER SCHEMA `restaurants_ecm`.`workforce` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `restaurants_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Restaurant Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employee_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Home Restaurant Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employee_work_location_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Manager Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Employee Address Line 1');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Employee Address Line 2');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Bank Account Number');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Employee City');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Employee Country Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Employment Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|on_leave|retired');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Employment Type');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'fte|pte|contractor');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Full Name');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Hire Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Employee Job Title');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `labor_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Target Labor Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligibility Flag');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Employee Pay Grade');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Employee Postal Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `role_classification` SET TAGS ('dbx_business_glossary_term' = 'Employee Role Classification');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `role_classification` SET TAGS ('dbx_value_regex' = 'boh|foh|admin|support');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Base Salary Amount');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Employee Salary Currency');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `servsafe_certified` SET TAGS ('dbx_business_glossary_term' = 'ServSafe Certification Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `servsafe_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'ServSafe Certification Expiration Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Employee Shift Pattern');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'morning|evening|night|flex|rotating');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Employee State/Province');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Employee Tax Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Termination Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Type');
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ALTER COLUMN `work_schedule_type` SET TAGS ('dbx_value_regex' = 'fixed|flex|rotating');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` SET TAGS ('dbx_subdomain' = 'scheduling_operations');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_scheduled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled By User ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_scheduled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_scheduled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual Clock‑Out Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Worked Hours');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Clock‑In Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Soft Delete Flag');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `labor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `labor_rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Currency Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `labor_rate_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Per Hour');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Notes');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On‑Call Flag');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `scheduled_end` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Hours');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `scheduled_start` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|on_call|training');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'planday|workday|manual');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `station` SET TAGS ('dbx_business_glossary_term' = 'Work Station');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `station` SET TAGS ('dbx_value_regex' = 'BOH|FOH|drive_thru|delivery');
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` SET TAGS ('dbx_subdomain' = 'scheduling_operations');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Forecast Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `nro_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Nro Pipeline Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approver Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approver Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approval Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approved By');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `daypart_schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Daypart Schedule Notes');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `fte_evening` SET TAGS ('dbx_business_glossary_term' = 'Evening FTE');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `fte_midday` SET TAGS ('dbx_business_glossary_term' = 'Midday FTE');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `fte_morning` SET TAGS ('dbx_business_glossary_term' = 'Morning FTE');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `fte_night` SET TAGS ('dbx_business_glossary_term' = 'Night FTE');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `fte_total` SET TAGS ('dbx_business_glossary_term' = 'Total Full‑Time Equivalent (FTE)');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_pct_evening` SET TAGS ('dbx_business_glossary_term' = 'Evening Labor Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_pct_midday` SET TAGS ('dbx_business_glossary_term' = 'Midday Labor Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_pct_morning` SET TAGS ('dbx_business_glossary_term' = 'Morning Labor Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_pct_night` SET TAGS ('dbx_business_glossary_term' = 'Night Labor Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `labor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Percentage (Labor% of Sales)');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period End Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period Start Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|locked');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `total_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Labor Hours');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'scheduling_operations');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID (TEID)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (EMP_ID)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (SHIFT_ID)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOC_ID)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `approved_by_manager` SET TAGS ('dbx_business_glossary_term' = 'Manager Approval Indicator (MGR_APPROVED)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `break_flag` SET TAGS ('dbx_business_glossary_term' = 'Break Indicator (BRK_FLAG)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Minutes (BRK_MIN)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock‑In Timestamp (CI_TS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock‑Out Timestamp (CO_TS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Number (TE_NUM)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Job Role (JOB_ROLE)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `job_role` SET TAGS ('dbx_value_regex' = 'front_of_house|back_of_house|management|support|other');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost (LABOR_COST)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate (LABOR_RATE)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `missed_punch_flag` SET TAGS ('dbx_business_glossary_term' = 'Missed Punch Indicator (MISSED_PUNCH)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTE_TEXT)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Indicator (OT_FLAG)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours (OT_HRS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code (PAY_CODE)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_value_regex' = 'REG|OT|SL|VAC|OTHER');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours (REG_HRS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift End (SCH_END_TS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Start (SCH_START_TS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday|pos|planday');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status (TE_STATUS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type (TE_TYPE)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_value_regex' = 'clock_in_out|manual|adjustment');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked (TOT_HRS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date (WORK_DT)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `labor_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Forecast ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `menu_lto_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Lto Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `nro_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Nro Pipeline Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Score');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `expected_adt` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Daily Transactions');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `expected_atc` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Transaction Count');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `forecast_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Created Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `forecast_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `labor_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Estimate');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `labor_forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `labor_forecast_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Version');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `projected_cover_count` SET TAGS ('dbx_business_glossary_term' = 'Projected Cover Count');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `projected_fte_boh` SET TAGS ('dbx_business_glossary_term' = 'Projected FTE Back‑of‑House');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `projected_fte_foh` SET TAGS ('dbx_business_glossary_term' = 'Projected FTE Front‑of‑House');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `projected_labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Labor Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `projected_throughput` SET TAGS ('dbx_business_glossary_term' = 'Projected Throughput');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `promotion_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Flag');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `scenario` SET TAGS ('dbx_value_regex' = 'baseline|optimistic|pessimistic');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `week_number` SET TAGS ('dbx_business_glossary_term' = 'Week Number');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Year');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `benefit_deduction` SET TAGS ('dbx_business_glossary_term' = 'Benefit Deduction Amount');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Address');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Type');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contractor');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `is_bonus` SET TAGS ('dbx_business_glossary_term' = 'Bonus Indicator');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Labor Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Notes');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Rate');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_group` SET TAGS ('dbx_business_glossary_term' = 'Pay Group');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Execution Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Number');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_status` SET TAGS ('dbx_value_regex' = 'processed|pending|error|cancelled');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Type');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_type` SET TAGS ('dbx_value_regex' = 'salary|hourly|commission|bonus');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Indicator');
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'food_handler|manager|allergen|haccp|alcohol|osha');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Certification Flag');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_value_regex' = 'NRA_ServSafe|Local_Health_Department|OSHA|Other');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `assessment_max_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Assessment Score (Points)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `assessment_passed` SET TAGS ('dbx_business_glossary_term' = 'Assessment Passed Indicator');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score (Points)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `completion_number` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Number');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status of Training');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart of Training (Breakfast, Lunch, etc.)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method (In-Person, E-Learning, On-The-Job)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'in_person|e_learning|on_the_job');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes on Training Completion');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `required_for_role` SET TAGS ('dbx_business_glossary_term' = 'Required Role for Training');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Training Record');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Workday|Planday|Zenput|Other');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Full Name');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `trainer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `trainer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|cancelled');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `training_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Minutes)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type (Safety, Operations, etc.)');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'safety|operations|customer_service|leadership');
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` SET TAGS ('dbx_subdomain' = 'labor_planning');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `nro_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Nro Pipeline Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Category');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'operational|capital|training|benefits');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Name');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_source` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Source');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_source` SET TAGS ('dbx_value_regex' = 'historical|model|manager_input');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Status');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|rejected');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Type');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|weekly|daypart');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fte_budget_boh` SET TAGS ('dbx_business_glossary_term' = 'Back‑of‑House FTE Budget');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fte_budget_foh` SET TAGS ('dbx_business_glossary_term' = 'Front‑of‑House FTE Budget');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `fte_budget_total` SET TAGS ('dbx_business_glossary_term' = 'Total FTE Budget');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `hours_budget_boh` SET TAGS ('dbx_business_glossary_term' = 'Back‑of‑House Hours Budget');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `hours_budget_foh` SET TAGS ('dbx_business_glossary_term' = 'Front‑of‑House Hours Budget');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `hours_budget_total` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Hours Budget');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Estimate');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_cost_estimate_boh` SET TAGS ('dbx_business_glossary_term' = 'Back‑of‑House Labor Cost Estimate');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_cost_estimate_foh` SET TAGS ('dbx_business_glossary_term' = 'Front‑of‑House Labor Cost Estimate');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_dollar_budget` SET TAGS ('dbx_business_glossary_term' = 'Labor Dollar Budget');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_percent_target` SET TAGS ('dbx_business_glossary_term' = 'Target Labor Percentage');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_percent_target_boh` SET TAGS ('dbx_business_glossary_term' = 'Back‑of‑House Labor Percentage Target');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `labor_percent_target_foh` SET TAGS ('dbx_business_glossary_term' = 'Front‑of‑House Labor Percentage Target');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `scenario` SET TAGS ('dbx_business_glossary_term' = 'Budget Scenario');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `scenario` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic|promotion|lto');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
