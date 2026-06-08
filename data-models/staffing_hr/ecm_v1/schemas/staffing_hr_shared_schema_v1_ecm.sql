-- Schema for Domain: shared | Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm`.`shared` COMMENT 'Shared domain (auto-created for table holiday_calendar)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm`.`shared`.`holiday_calendar` (
    `holiday_calendar_id` BIGINT COMMENT 'Primary key for holiday_calendar',
    `parent_holiday_calendar_id` BIGINT COMMENT 'Self-referencing FK on holiday_calendar (parent_holiday_calendar_id)',
    `advance_notice_days` STRING COMMENT 'Number of days in advance that employees and clients should be notified about this holiday observance for planning purposes.',
    `business_unit_code` STRING COMMENT 'Code identifying the specific business unit, division, or operating entity to which this holiday calendar entry applies. Null indicates organization-wide applicability.',
    `client_specific_flag` BOOLEAN COMMENT 'Indicates whether this holiday is specific to a particular client engagement or contract, requiring special staffing considerations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the country where this holiday is observed (e.g., USA, CAN, GBR, AUS).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this holiday calendar entry was first created in the system. Audit trail for data lineage.',
    `day_of_week` STRING COMMENT 'The day of the week on which the holiday falls, used for scheduling and observance rule application.',
    `holiday_calendar_description` STRING COMMENT 'Detailed description of the holiday, including cultural or historical significance, observance traditions, and any special business considerations.',
    `effective_end_date` DATE COMMENT 'The date on which this holiday calendar entry ceases to be effective. Null indicates ongoing applicability.',
    `effective_start_date` DATE COMMENT 'The date from which this holiday calendar entry becomes effective for business operations and scheduling.',
    `holiday_date` DATE COMMENT 'The specific date on which the holiday occurs. Core business event date for this reference entity.',
    `holiday_name` STRING COMMENT 'The official name of the holiday or non-working day (e.g., New Years Day, Christmas, Independence Day, Company Shutdown).',
    `holiday_type` STRING COMMENT 'Classification of the holiday indicating its nature and scope (public, federal, state-specific, company-specific, religious observance, or floating holiday).',
    `is_mandatory_closure` BOOLEAN COMMENT 'Indicates whether the organization mandates office/facility closure on this holiday, affecting staffing availability and client service delivery.',
    `is_observed` BOOLEAN COMMENT 'Indicates whether this holiday is actively observed by the organization for payroll, scheduling, and operational purposes.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether employees receive paid time off for this holiday. Critical for payroll processing and compensation calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this holiday calendar entry was last updated. Critical for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this holiday observance, including exceptions or special handling requirements.',
    `observance_rule` STRING COMMENT 'Defines how the holiday date is determined: fixed (same date annually), floating (varies by year based on rules), calculated (algorithmic determination), or substitute (observed on alternate date when falls on weekend).',
    `observed_date` DATE COMMENT 'The actual date on which the holiday is observed for business purposes, which may differ from the holiday_date when substitution rules apply (e.g., Monday observance for Sunday holiday).',
    `premium_pay_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to standard pay rates for employees working on this holiday (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Used in payroll calculations.',
    `recurring_flag` BOOLEAN COMMENT 'Indicates whether this holiday recurs annually or is a one-time observance (e.g., special company anniversary, one-time government-declared holiday).',
    `source_system` STRING COMMENT 'The system or authority from which this holiday calendar entry was sourced (e.g., government calendar, HR policy system, client contract).',
    `staffing_impact_level` STRING COMMENT 'Assessment of the impact this holiday has on staffing availability and workforce planning, ranging from none to critical.',
    `state_province_code` STRING COMMENT 'State or province code for holidays that are region-specific within a country (e.g., CA for California, ON for Ontario). Null for national holidays.',
    `holiday_calendar_status` STRING COMMENT 'Current lifecycle status of this holiday calendar entry indicating whether it is actively used for scheduling and payroll operations.',
    `year` STRING COMMENT 'The calendar year in which this holiday occurs. Enables year-over-year holiday planning and historical analysis.',
    CONSTRAINT pk_holiday_calendar PRIMARY KEY(`holiday_calendar_id`)
) COMMENT 'Master reference table for holiday_calendar. Referenced by holiday_calendar_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm`.`shared`.`holiday_calendar` ADD CONSTRAINT `fk_shared_holiday_calendar_parent_holiday_calendar_id` FOREIGN KEY (`parent_holiday_calendar_id`) REFERENCES `staffing_hr_ecm`.`shared`.`holiday_calendar`(`holiday_calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm`.`shared` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `staffing_hr_ecm`.`shared` SET TAGS ('dbx_domain' = 'shared');
ALTER TABLE `staffing_hr_ecm`.`shared`.`holiday_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`shared`.`holiday_calendar` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Identifier');
ALTER TABLE `staffing_hr_ecm`.`shared`.`holiday_calendar` ALTER COLUMN `parent_holiday_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
